Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v1 0/6] Remove access rights from MediaTransport
Date: Wed,  5 Dec 2012 17:15:28 +0100
Message-Id: <1354724134-7354-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

v1 proposes TryAcquire() instead of Acquire(TRUE), as suggested by Johan.

>From original cover-letter:

The accessrights used in the Acquire() method are not very useful and can thus be removed. This simplifies both the D-Bus API and the internal implementation significantly.

Mikel Astiz (6):
  media: Remove transport access type from D-Bus API
  media: Remove internal transport locks
  media: Remove transport owner list
  media: Add MediaTransport.TryAcquire()
  media: Trivial style fix
  media: Add version suffix to all media interfaces

 doc/audio-telephony-design.txt |   4 +-
 doc/media-api.txt              |  46 +++----
 profiles/audio/media.c         |   8 +-
 profiles/audio/player.c        |   2 +-
 profiles/audio/transport.c     | 264 ++++++++++++-----------------------------
 test/mpris-player.c            |  14 +--
 6 files changed, 108 insertions(+), 230 deletions(-)

-- 
1.7.11.7

