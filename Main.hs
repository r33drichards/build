module Main where

import Control.Monad.State

import Build.Task
import Build.Store
import Build

-- import Build.System


busy :: Eq k => Build Applicative () k v
busy tasks key store = execState (fetch key) store
    where
        fetch k = case tasks k of
            Nothing   -> gets (getValue k)
            Just task -> do v <- run task fetch
                            modify (putValue k v)
                            return v
                            
sprsh1 :: Tasks Applicative String Integer
sprsh1 "B1" = Just $ Task $ \fetch -> ((+)  <$> fetch "A1" <*> fetch "A2")
sprsh1 "B2" = Just $ Task $ \fetch -> ((*2) <$> fetch "B1")
sprsh1 _    = Nothing

-- intialize store with a1 set to 10 and everything else set to 20
store = initialise () (\key -> if key == "A1" then 10 else 20)
-- get the result of b2
result = busy sprsh1 "B2" store



main :: IO ()
main = putStrLn $ show (getValue "B1" result)