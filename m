Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
Subject: [PATCH v4 0/7] Create bneptest tool
Date: Thu, 12 Mar 2015 17:06:35 +0100
Message-Id: <1426176402-21179-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

v4:
- Fix error returning in bnep server add
- Reorganize bnep service comparing (by uuid, by string),
- Fixed pointed by Szymon commit message typo,
- Add support for sending general bnep frames by bneptest,
- bneptest now require bridge and iface name (it was optional-def. names were
 set)
- Update PTS results and test instructions.

Grzegorz Kolodziejczyk (7):
  profiles/network: Fix sending error in bnep server add
  profiles/network: Remove unneded bnep_uuid function from bnep code
  profiles/network: Remove not needed get name by bnep id function
  profiles/network: Move disconn cb setting to bnep connect method
  tools/bneptest: Add initial support for bneptest tool
  tools/bneptest: Add generic connect/listen functionality
  android/pts: Add BNEP PTS 6.0 results for android 5.0

 .gitignore                    |   1 +
 Makefile.tools                |  12 +-
 android/Android.mk            |  35 ++
 android/Makefile.am           |   5 +-
 android/pan.c                 |   5 +-
 android/pics-bnep.txt         |  26 ++
 android/pixit-bnep.txt        |  30 ++
 android/pts-bnep.txt          |  48 +++
 profiles/network/bnep.c       |  59 +---
 profiles/network/bnep.h       |   9 +-
 profiles/network/connection.c |  23 +-
 profiles/network/server.c     |  35 +-
 tools/bneptest.c              | 762 ++++++++++++++++++++++++++++++++++++++++++
 13 files changed, 973 insertions(+), 77 deletions(-)
 create mode 100644 android/pics-bnep.txt
 create mode 100644 android/pixit-bnep.txt
 create mode 100644 android/pts-bnep.txt
 create mode 100644 tools/bneptest.c

-- 
2.1.0

