{-# LANGUAGE TemplateHaskell #-}

module Types
  ( -- * QA session
    Title(..),
    Id(..),
    Highlight(..),
    Message(..),
    msgAuthorL,
    msgContentL,
    msgHighlightL,
    Conversation(..),
    conversationMessagesL,
    QaSession(..),
    qassIdL,
    qassTitleL,
    qassDateL,
    qassConversationL,
    Role(..),
    Name(..),
    Alias(..),
    Pic(..),
    Link(..),
    Nickname(..),
    Person(..),
    People,

    -- * Misc
    SiteUrl(..)
  ) where

import BasePrelude
import Control.Lens
import Data.Text
import Data.Time
import Data.List.NonEmpty
import Data.Map
import Text.MMark

import LensUtil

newtype Highlight = Highlight Bool
  deriving (Eq, Ord, Show)

data Message person =
  Message
    { msgAuthor :: !person,
      msgContent :: !MMark,
      msgHighlight :: !Highlight
    }
  deriving (Show)

newtype Conversation person =
  Conversation { conversationMessages :: NonEmpty (Message person) }
  deriving (Show)

newtype Title =
  Title { titleText :: Text }
  deriving (Show)

newtype Id =
  Id { idText :: Text }
  deriving (Eq, Ord, Show)

data QaSession id person =
  QaSession
    { qassId :: !id,
      qassTitle :: !Title,
      qassDate :: !Day,
      qassConversation :: !(Conversation person)
    }
  deriving (Show)

data Role = Client | Consultant
  deriving (Show)

newtype Nickname = Nickname Text
  deriving (Eq, Ord, Show)

newtype Name = Name Text
  deriving (Eq, Ord, Show)

newtype Alias = Alias Text
  deriving (Eq, Ord, Show)

newtype Pic = PicFile Text
  deriving (Eq, Ord, Show)

newtype Link = Link Text
  deriving (Eq, Ord, Show)

data Person =
  Person
    { pNicks :: ![Nickname],
      pName :: !Name,
      pAlias :: !Alias,
      pPic :: !(Maybe Pic),
      pLink :: !(Maybe Link),
      pRole :: !Role
    }
  deriving (Show)

type People = Map Nickname Person

makeLensesWith postfixLFields ''Message
makeLensesWith postfixLFields ''Conversation
makeLensesWith postfixLFields ''QaSession

newtype SiteUrl = SiteUrl Text
  deriving Show