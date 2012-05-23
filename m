Return-Path: <cyrus@holtmann.org>
From: Paulo Alcantara <paulo.alcantara@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Paulo Alcantara <paulo.alcantara@openbossa.org>
Subject: [PATCH BlueZ 00/15] Store address type on storage - remaining files
Date: Wed, 23 May 2012 15:48:18 -0300
Message-Id: <1337798914-20974-1-git-send-email-paulo.alcantara@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patchset contains the remaining changes for the new storage format
used (bdaddr#type) on storage files (LE-only or shared files).

The files that have been changed so far are:
    primaries, characteristics, appearance, ccc, names, aliases,
    longtermkeys, attributes, blocked.

Unchanged files:
    lastseen, lastused, eir, classes, manufacturers, features, linkkeys,
    pincodes, trusts, profiles.

Maybe we should initially use the new storage format in lastseen,
lastused and trusts files as well. However, I'm not quite sure about
that. So, what do you guys think about using the new storage format in
these files ?


Claudio Takahasi (4):
  storage: Store address type in "aliases" file
  storage: Store address type in blocked file
  storage: Rename characteristic to characteristics
  storage: Rename primary file to primaries

Paulo Alcantara (11):
  storage: Store address type in "characteristics"
  storage: Store address type in "appearance" file
  storage: Store address type in "ccc" file
  storage: Store address type in "names" file
  core: Fix reading stored data from "aliases" and "names" file
  storage: Do not store address type twice
  storage: Store address type in "longtermkeys" file
  core: Fix creating device from "longtermkeys" file
  storage: Store address type in "attributes" file
  core: Fix creating device from "blocked" file
  core: Fix deleting entries

 attrib/client.c     |   31 +++++++----
 input/device.c      |    6 ++-
 src/adapter.c       |   64 ++++++++++++++--------
 src/attrib-server.c |   19 +++++--
 src/device.c        |   49 +++++++++++------
 src/device.h        |    1 +
 src/event.c         |   13 +++--
 src/storage.c       |  147 +++++++++++++++++++++++++++++---------------------
 src/storage.h       |   44 +++++++++------
 9 files changed, 232 insertions(+), 142 deletions(-)

-- 
1.7.7.6

