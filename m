Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ 0/4] android fixes and gattrib shim
Date: Wed, 12 Nov 2014 12:22:55 -0800
Message-Id: <1415823779-346-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patchset fixes some issues with Android GATT testing, a minor
issue with Android GATT exposed by the shim, and provides a
GAttrib shim using bt_att.

Passes all android/android-tester, unit/test-gattrib

Michael Janssen (4):
  android/tester-gatt: DRY/bugfix search single PDUs
  android/tester-gatt: deduplicate read-by-type PDUs
  android/gatt: dummy callback for indications
  GATT shim to src/shared bt_att

 android/gatt.c        |  15 +-
 android/tester-gatt.c | 167 +++---------
 attrib/gattrib.c      | 733 +++++++++++---------------------------------------
 3 files changed, 208 insertions(+), 707 deletions(-)

-- 
2.1.0.rc2.206.gedb03e5

