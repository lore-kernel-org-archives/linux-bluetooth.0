Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
Subject: [PATCH v5 0/6] Create bneptest tool
Date: Thu, 12 Mar 2015 18:07:27 +0100
Message-Id: <1426180053-26646-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
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
v5:
- Fix converting uuids (16 to 128),
- Extend bneptest with frames retransmission parameters,
- Update PTS results and test instructions.

Grzegorz Kolodziejczyk (6):
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
 profiles/network/bnep.c       |  53 +--
 profiles/network/bnep.h       |   9 +-
 profiles/network/connection.c |  23 +-
 profiles/network/server.c     |  36 +-
 tools/bneptest.c              | 777 ++++++++++++++++++++++++++++++++++++++++++
 13 files changed, 985 insertions(+), 75 deletions(-)
 create mode 100644 android/pics-bnep.txt
 create mode 100644 android/pixit-bnep.txt
 create mode 100644 android/pts-bnep.txt
 create mode 100644 tools/bneptest.c

-- 
2.1.0

