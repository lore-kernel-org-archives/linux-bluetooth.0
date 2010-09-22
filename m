Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 22 Sep 2010 15:25:53 -0400
Message-ID: <AANLkTikcG2XRNDKSiq5b==JXo+YtPVJy9y4QWkBR9zdR@mail.gmail.com>
Subject: Pull request: git://gitorious.org/~lizardo/bluez/lizardo-bluez.git for-upstream
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The following changes since commit ec901c2428324ea2fe7d1bc2a2f3171ac5ed1950:
  Johan Hedberg (1):
        Fix reading local name from command complete event

are available in the git repository at:

  git://gitorious.org/~lizardo/bluez/lizardo-bluez.git for-upstream

Claudio Takahasi (9):
      Update characteristic value when a notification is received
      Return an error if the path doesn't exist when registering a watcher
      Add watcher's characteristic path verification before notify changes
      Watchers don't need to reply for characteristic value updates
      Change notification/indication output formating on gatttool
      Report attribute changes for the Battery Service
      Add missing response for handle value indication on attribute client
      Remove forward declaration on gattrib source
      Fix uninitialised value warning

Vinicius Costa Gomes (6):
      Add encoders/decoders for Indication/Confirmation
      Add support to the server to sending Indications
      Add support for Indications to gatttool
      Add support for Indications to the client
      Add support for actively updating the watcher
      Add a way to unregister GAttrib events

 attrib/att.c        |   50 +++++++++++++++++
 attrib/att.h        |    3 +
 attrib/client.c     |  113 +++++++++++++++++++++++++++++++++++++--
 attrib/example.c    |   19 +++----
 attrib/gattrib.c    |  150 ++++++++++++++++++++++++++++++++-------------------
 attrib/gatttool.c   |   40 +++++++++-----
 src/attrib-server.c |   28 ++++++++++
 7 files changed, 320 insertions(+), 83 deletions(-)

-- 
Anderson Lizardo
OpenBossa Labs - INdT
Manaus - Brazil
