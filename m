Return-Path: <cyrus@holtmann.org>
From: Paulo Alcantara <paulo.alcantara@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Paulo Alcantara <paulo.alcantara@openbossa.org>
Subject: [PATCH BlueZ 00/12] Store address type in BR/EDR and shared files
Date: Thu, 14 Jun 2012 20:03:52 -0300
Message-Id: <1339715044-13737-1-git-send-email-paulo.alcantara@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patchset proposes new storage format (used currently in LE-only
files) in BR/EDR and shared files.

As the LE-only file changes _only_ occurred in the BlueZ 4.100 release,
the BlueZ 5.x release should contain the new storage format in BR/EDR and
shared files as well.

Do we also need to change BR/EDR-only files like profiles, sdp, linkkeys
and eir ?


Claudio Takahasi (1):
  storage: Store address type in blocked file

Paulo Alcantara (11):
  storage: Store address type in "names" file
  storage: Store address type in aliases file
  core: Fix reading from "aliases" and "names" file
  storage: Store address type in "lastseen" file
  storage: Store address type in "lastused" file
  storage: Store address type in "profiles" file
  storage: Store address type in "did" file
  storage: Store address type in "linkkeys" file
  storage: Store address type in "trusts" file
  storage: Store address type in "eir" file
  storage: Store address type in "sdp" file

 input/device.c |   11 +-
 src/adapter.c  |   44 ++++++--
 src/device.c   |   54 +++++-----
 src/event.c    |   27 +++--
 src/storage.c  |  308 ++++++++++++++++++++++++++++++++++++++++----------------
 src/storage.h  |   61 +++++++----
 6 files changed, 352 insertions(+), 153 deletions(-)

-- 
1.7.10.2

