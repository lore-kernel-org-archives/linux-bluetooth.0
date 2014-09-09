Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 0/7] shared/gatt-client: Handle notifications.
Date: Mon,  8 Sep 2014 18:03:04 -0700
Message-Id: <1410224591-5402-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set adds handle value notification/indication handling to
shared/gatt-client. Introduced are bt_gatt_client_register_notify and
bt_gatt_client_unregister_notify functions which register a user provided
callback for a specific characteristic value handle to be invoked when a
notification or indication is received from that characteristic.

The functions automatically write to the Client Characteristic Configuration
descriptor to enable or disable notifications/indications based on the
characteristic's properties bit field. An internal per-characteristic count is
kept, in which the CCC descriptor is only written to when the count transitions
from 0 -> 1 or 1 -> 0.

Also added the "register-notify" and "unregister-notify" commands to
tools/btgatt-client to test the above feature.

Arman Uguray (7):
  shared/gatt-client: Introduce struct bt_gatt_characteristic_iter.
  shared/gatt-client: Implement bt_gatt_client_register_notify.
  shared/gatt-client: Implement bt_gatt_client_unregister_notify.
  shared/gatt-client: Handle incoming not/ind PDUs.
  tools/btgatt-client: Add the "register-notify" command.
  tools/btgatt-client: Add "unregister-notify" command.
  TODO: Reference counted notify functions implemented

 TODO                      |  10 -
 src/shared/gatt-client.c  | 521 ++++++++++++++++++++++++++++++++++++++++++----
 src/shared/gatt-client.h  |  57 +++--
 src/shared/gatt-helpers.c |  67 ------
 src/shared/gatt-helpers.h |   9 -
 tools/btgatt-client.c     | 139 +++++++++++--
 6 files changed, 657 insertions(+), 146 deletions(-)

-- 
2.1.0.rc2.206.gedb03e5

