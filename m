Return-Path: <cyrus@holtmann.org>
From: Paulo Alcantara <paulo.alcantara@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Paulo Alcantara <paulo.alcantara@openbossa.org>
Subject: [PATCH BlueZ 0/9] Store address type on storage (LE-only files)
Date: Sat, 26 May 2012 21:40:45 -0300
Message-Id: <1338079254-14054-1-git-send-email-paulo.alcantara@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patchset contains the remaining changes for the new storage format
used (bdaddr#type) on storage for LE-only files.

Note also that the BlueZ 4.x will only contain this new storage format
for LE-only files, whereas BlueZ 5.x will contain this new storage format
for all files (BR/EDR and LE).


Claudio Takahasi (2):
  storage: Rename characteristic to characteristics
  storage: Rename primary file to primaries

Paulo Alcantara (7):
  storage: Store address type in "characteristics"
  storage: Store address type in "appearance" file
  storage: Store address type in "ccc" file
  storage: Store address type in "longtermkeys" file
  core: Fix creating device from "longtermkeys" file
  storage: Store address type in "attributes" file
  storage: Rename appearance file to appearances

 attrib/client.c     |   31 +++++++++++------
 src/adapter.c       |   36 +++++++++++--------
 src/attrib-server.c |   19 +++++++---
 src/device.c        |   36 ++++++++++++++-----
 src/device.h        |    1 +
 src/event.c         |    6 ++--
 src/storage.c       |   94 +++++++++++++++++++++++++++------------------------
 src/storage.h       |   27 +++++++++------
 8 files changed, 151 insertions(+), 99 deletions(-)

-- 
1.7.7.6

