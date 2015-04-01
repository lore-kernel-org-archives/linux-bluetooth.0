Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCH 00/28] android/hog Introduce bt_gatt_client
Date: Wed,  1 Apr 2015 18:40:16 +0200
Message-Id: <1427906444-11769-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These patches replace gattrib with bt_gatt_client.
It is part of HoG deduplication. HoG, ScPP, DIS, BAS have been
cleaned from glib, btio, attrib dependencies.

Note, that unit/test-hog tests are no longer valid and won't work since
were written to be used with attrib. Fixes for unit tests will be
sent in the next set of patches.

Mariusz Skamra (28):
  android/hidhost: Create bt_gatt_client
  android/hog: Introduce bt_gatt_client
  shared/gatt-client: Expose gatt_db
  android/hog: Remove tracking gatt operations
  android/hog: Use bt_gatt_client to read characteristic value
  android/hog: Use bt_gatt_client to register for notifications
  android/hog: Use bt_gatt_client to write without response
  android/hog: Replace gatt_write_char with bt_gatt_client_write_value
  android/hog: Use gatt_db to search for services and characteristics in
    db
  android/hog: Add helper to create uhid device
  lib/uuid: Add define for HoG UUID
  android/hog: Replace list of reports with a queue of reports
  android/hog: Replace definitions of characteristic uuids with bt_uuids
  android/hog: Replace GSList of hog instances with queue of instances
  android/dis: Remove tracking pending gatt operations
  android/dis: Introduce bt_gatt_client
  android/scpp: Remove tracking pending gatt operations
  android/scpp: Introduce bt_gatt_client
  android/scpp: Merge refresh_discovered_cb with iwin_discovered_cb
  android/bas: Remove tracking pending gatt operations
  android/bas: Start using bt_gatt_client
  android/hog: Strip btio dependencies
  android/hog: Enable Input Report notifications only if uhid is created
  android/bas: Enable Battery Level notifications after reconnection
  android/hog: Add MIN definition
  android/hog: Remove attrib/
  android/hog: Remove glib dependencies
  android/hog: Remove redundant code

 android/Android.mk       |    2 +
 android/bas.c            |  312 +++----------
 android/bas.h            |    4 +-
 android/dis.c            |  203 ++-------
 android/dis.h            |    4 +-
 android/hidhost.c        |   80 +++-
 android/hog.c            | 1132 ++++++++++++++++------------------------------
 android/hog.h            |   12 +-
 android/scpp.c           |  262 +++--------
 android/scpp.h           |    4 +-
 lib/uuid.h               |    1 +
 src/shared/gatt-client.c |    8 +
 src/shared/gatt-client.h |    1 +
 unit/test-hog.c          |    9 +-
 14 files changed, 646 insertions(+), 1388 deletions(-)

-- 
1.9.1

