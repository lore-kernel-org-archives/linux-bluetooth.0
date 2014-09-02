Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 0/8] Android tester GATT test cases
Date: Tue,  2 Sep 2014 14:04:23 +0200
Message-Id: <1409659471-25171-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

v1:
This patch set improve handling of ssp requests in few test cases
and adds GATT test cases for searching primary services and
characteristics.

This set contains rebased version of pending commits.

v2:
* rebased
* fixed not comparing status of get_characteristic_cb

Marcin Kraglak (8):
  android/tester: Simplify ACTION_FAIL and ACTION_SUCCESS defines
  android/tester: Add function to set default ssp handler
  android/tester: Add support for search services callbacks
  android/tester: Add GATT Client Search Service test case
  android/tester: Add GATT Search Service 2 test case
  android/tester: Add negative GATT Search Service test
  android/tester: Add support for get_characteristic_cb()
  android/tester: Add GATT get_characteristic test

 android/tester-a2dp.c |   3 +
 android/tester-gatt.c | 269 +++++++++++++++++++++++++++++++++++++++++++++++++-
 android/tester-main.c | 123 ++++++++++++++++++++++-
 android/tester-main.h |  44 ++++++---
 android/tester-pan.c  |   3 +
 5 files changed, 426 insertions(+), 16 deletions(-)

-- 
1.9.0

