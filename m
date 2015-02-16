Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv6 0/8] AVDTP deduplication
Date: Mon, 16 Feb 2015 15:02:22 +0200
Message-Id: <1424091750-29487-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Changes:
	* v6: Fix uid_get/clear adding id checks
	* v5: Use POSIX ffs() for bitmap get uid, limiting maximum number of local SEPs to 32.
	* v4: Fix Android build and clear typos.
        * v3: Convert gslist to queue for lseps, refactor lseps handlings, remove extra DBGs.
        * v2: Fix fixup patch
        * v1: Add SEID fixes with unit tests
        * RFC: initial version

Andrei Emeltchenko (8):
  unit/avdtp: Add SEP register/unregister tests
  unit/avdtp: Add duplicate SEID test
  shared/utils: Add helpers for bitfield id generation
  android/avdtp: Fix SEID generation
  unit/avdtp: Add check for too many SEP creation
  android/avdtp: Fix registering SEP with wrong SEID
  android/avdtp: Refactor local SEP list handling
  unit/avdtp: Refactor context destroy

 android/Android.mk  |   2 +
 android/Makefile.am |   2 +
 android/a2dp.c      |  15 +++--
 android/avdtp.c     | 101 +++++++++++++++++++------------
 android/avdtp.h     |  10 ++-
 android/avdtptest.c |  10 ++-
 src/shared/util.c   |  29 +++++++++
 src/shared/util.h   |   3 +
 unit/test-avdtp.c   | 171 ++++++++++++++++++++++++++++++++++++++++++++--------
 9 files changed, 273 insertions(+), 70 deletions(-)

-- 
2.1.0

