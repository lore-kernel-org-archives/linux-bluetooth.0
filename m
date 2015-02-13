Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 0/9] Deduplication of avdtp
Date: Fri, 13 Feb 2015 11:05:59 +0200
Message-Id: <1423818368-15899-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Second iteration of AV deduplication.

Changes:
	* v1: Add SEID fixes with unit tests
	* RFC: initial version

Andrei Emeltchenko (9):
  unit/avdtp: Add SEP register/unregister tests
  unit/avdtp: Add duplicate SEID test
  shared/utils: Add helpers for bitfield fast uid generation
  android/avdtp: Fix SEID generation
  f duplicate test
  unit/avdtp: Add check for too many SEP creation
  android/avdtp: Fix registering SEP with wrong SEID
  android/avdtp: Refactor local SEP list handling
  unit/avdtp: Refactor context destroy

 android/Makefile.am |   1 +
 android/a2dp.c      |  19 +++++--
 android/avdtp.c     |  65 ++++++++++++++++--------
 android/avdtp.h     |   2 +
 android/avdtptest.c |   6 +++
 src/shared/util.c   |  24 +++++++++
 src/shared/util.h   |   3 ++
 unit/test-avdtp.c   | 139 ++++++++++++++++++++++++++++++++++++++++++++++++----
 8 files changed, 227 insertions(+), 32 deletions(-)

-- 
2.1.0

