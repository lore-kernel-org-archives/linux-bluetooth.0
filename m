Return-Path: <cyrus@holtmann.org>
From: Paulo Alcantara <paulo.alcantara@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Paulo Alcantara <paulo.alcantara@openbossa.org>
Subject: [PATCH BlueZ v3 00/18] Store address type on storage - remaining files
Date: Fri, 25 May 2012 12:46:52 -0300
Message-Id: <1337960830-3506-1-git-send-email-paulo.alcantara@openbossa.org>
In-Reply-To: <1337798914-20974-1-git-send-email-paulo.alcantara@openbossa.org>
References: <1337798914-20974-1-git-send-email-paulo.alcantara@openbossa.org>
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


Note: The v3 of this series adds two other patchs (17/18 and 18/18) which
      keep backward compatibility with the old storage format in both
      names and aliases files since they're shared by both BR/EDR and LE
      devices.


Claudio Takahasi (4):
  storage: Store address type in "aliases" file
  storage: Store address type in blocked file
  storage: Rename characteristic to characteristics
  storage: Rename primary file to primaries

Paulo Alcantara (14):
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
  storage: Keep backward compatibility in "blocked" file
  storage: Keep backward compatibility in "names" file
  storage: Keep backward compatibility in "aliases" file

 attrib/client.c     |   31 ++++++---
 input/device.c      |    6 +-
 src/adapter.c       |   64 ++++++++++++-------
 src/attrib-server.c |   19 ++++--
 src/device.c        |   51 ++++++++++-----
 src/device.h        |    1 +
 src/event.c         |   13 +++-
 src/storage.c       |  177 ++++++++++++++++++++++++++++++++-------------------
 src/storage.h       |   44 ++++++++-----
 9 files changed, 261 insertions(+), 145 deletions(-)

-- 
1.7.7.6

