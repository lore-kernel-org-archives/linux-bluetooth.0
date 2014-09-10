Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v2 0/7] shared/gatt-client: Handle notifications.
Date: Wed, 10 Sep 2014 09:36:20 -0700
Message-Id: <1410366987-8128-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

*v2:
   - Renames:
     - not_id -> notify_id
     - not_ref_count -> notify_count
     - ind_id -> indic_id -> indication_id -> ind_id

   - Fixed typo in tools/btgatt-client.

*v1: Handled style comments:
   - Renamed some variables to make them more meaningful.
   - Moved functions around to avoid forward declarations as much as possible.
   - Added an internal bt_gatt_descriptor_t pointer to struct chrc_data while
     keeping the external const pointer in bt_gatt_descriptor_t, both of which
     point to the same array of descriptors.

Arman Uguray (7):
  shared/gatt-client: Introduce struct bt_gatt_characteristic_iter.
  shared/gatt-client: Implement bt_gatt_client_register_notify.
  shared/gatt-client: Implement bt_gatt_client_unregister_notify.
  shared/gatt-client: Handle incoming not/ind PDUs.
  tools/btgatt-client: Add the "register-notify" command.
  tools/btgatt-client: Add "unregister-notify" command.
  TODO: Reference counted notify functions implemented

 TODO                      |  10 -
 src/shared/gatt-client.c  | 564 +++++++++++++++++++++++++++++++++++++++++-----
 src/shared/gatt-client.h  |  57 ++++-
 src/shared/gatt-helpers.c |  67 ------
 src/shared/gatt-helpers.h |   9 -
 tools/btgatt-client.c     | 139 ++++++++++--
 6 files changed, 684 insertions(+), 162 deletions(-)

-- 
2.1.0.rc2.206.gedb03e5

