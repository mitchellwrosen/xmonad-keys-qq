## xmonad-keys-qq}
[![Build Status](https://travis-ci.org/mitchellwrosen/xmonad-keys-qq.svg?branch=master)](https://travis-ci.org/mitchellwrosen/xmonad-keys-qq)

Simple quasi-quoter for `EZConfig`-style key bindings.

Example:

```haskell
mkKeys :: X.XConfig Layout -> Map (ButtonMask, KeySym) (X ())
mkKeys config = mkKeymap config
  [ ("M-<Return>", spawn (X.terminal config))
  , ("M-i",        spawn browser)
  , ("M-p",        spawn "dmenu_run")
  , ("M-c",        kill)
  , ("M-<Space>",  sendMessage NextLayout)
  , ("M-j",        windows W.focusDown)
  , ("M-k",        windows W.focusUp)
  , ("M-S-j",      windows W.swapDown)
  , ("M-S-k",      windows W.swapUp)
  , ("M-h",        prevWS)
  , ("M-l",        nextWS)
  , ("M-S-h",      shiftToPrev >> prevWS)
  , ("M-S-l",      shiftToNext >> nextWS)
  , ("M-M1-h",     sendMessage Shrink)
  , ("M-M1-l",     sendMessage Expand)
  , ("M-m",        withFocused (sendMessage . maximizeRestore))
  , ("M-t",        withFocused (windows . W.sink))
  , ("M-,",        sendMessage (IncMasterN 1))
  , ("M-.",        sendMessage (IncMasterN (-1)))
  ]
```

becomes:

```haskell
mkKeys :: X.XConfig Layout -> Map (ButtonMask, KeySym) (X ())
mkKeys config = mkKeymap config
  [keys|
    M-<Return> = spawn (X.terminal config)
    M-i        = spawn browser
    M-p        = spawn "dmenu_run"
    M-c        = kill
    M-<Space>  = sendMessage NextLayout
    M-j        = windows W.focusDown
    M-k        = windows W.focusUp
    M-S-j      = windows W.swapDown
    M-S-k      = windows W.swapUp
    M-h        = prevWS
    M-l        = nextWS
    M-S-h      = shiftToPrev >> prevWS
    M-S-l      = shiftToNext >> nextWS
    M-M1-h     = sendMessage Shrink
    M-M1-l     = sendMessage Expand
    M-m        = withFocused (sendMessage . maximizeRestore)
    M-t        = withFocused (windows . W.sink)
    M-,        = sendMessage (IncMasterN 1)
    M-.        = sendMessage (IncMasterN (-1))
  |]
```

All lines that do not pass the `key = value` parser are simply ignored. So,
don't write a comment that looks like

```haskell
-- = blah
```

but any other comment should fail gracefully.
