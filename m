Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ v2 0/4] android fixes and bt_att shim
Date: Thu, 13 Nov 2014 09:39:13 -0800
Message-Id: <1415900357-27027-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patchset fixes some issues with Android GATT testing, a minor
issue with Android GATT exposed by the shim, and provides a
GAttrib shim using bt_att.

Passes all android/android-tester, unit/test-gattrib

v1 -> v2:
  * Address comments by Szymon Janc, Arman Uguray

Michael Janssen (4):
  android/tester-gatt: Fix search single PDUs
  android/tester-gatt: deduplicate read-by-type PDUs
  android/gatt: dummy callback for indications
  GATT shim to src/shared bt_att

 android/gatt.c        |   17 
 android/tester-gatt.c |  169 ++-----
 attrib/gattrib.c      | 1096 +++++++++++++++-----------------------------------
 3 files changed, 395 insertions(+), 887 deletions(-)

-- 
2.1.0.rc2.206.gedb03e5

