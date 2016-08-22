module XMonad.Util.EZConfig.QQ (keys) where

import Data.Char
import Data.Maybe
import Language.Haskell.TH
import Language.Haskell.TH.Quote
import Language.Haskell.Meta.Parse
import Text.ParserCombinators.ReadP

keys :: QuasiQuoter
keys = QuasiQuoter
  { quoteExp = fmap (ListE . catMaybes) . mapM go . lines }

go :: String -> Q (Maybe Exp)
go s =
  case readP_to_S parser s of
    [((k,v),_)] ->
      case parseExp v of
        Left err -> fail err
        Right e  -> Just <$> tupE [stringE k, pure e]
    _ -> pure Nothing

parser :: ReadP (String, String)
parser = do
  whitespace
  key <- munch1 (not . isSpace)
  whitespace
  _ <- char '='
  whitespace
  val <- look
  pure (key, val)
 where
  whitespace :: ReadP ()
  whitespace = munch isSpace >> pure ()
