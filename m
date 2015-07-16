Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/gatt-client: Fix discovery
Date: Thu, 16 Jul 2015 13:48:01 +0300
Message-Id: <1437043681-32403-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The discovery shall not be interrupted in case Exchange MTU is not
supported, instead we shall continue using the default MTU as stated by
the spec:

BLUETOOTH SPECIFICATION Version 4.2 [Vol 3, Part G] page 546:
  "If the Error Response is sent by the server with the Error Code set
   to Request Not Supported , the Attribute Opcode is not supported and
   the default MTU shall be used."
---
 src/shared/gatt-client.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 0bd306c..24aef18 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1066,6 +1066,15 @@ static void exchange_mtu_cb(bool success, uint8_t att_ecode, void *user_data)
 				"MTU Exchange failed. ATT ECODE: 0x%02x",
 				att_ecode);
 
+		/*
+		 * BLUETOOTH SPECIFICATION Version 4.2 [Vol 3, Part G] page 546
+		 * If the Error Response is sent by the server with the Error
+		 * Code set to RequestNot Supported , the Attribute Opcode is
+		 * not supported and the default MTU shall be used.
+		 */
+		if (att_ecode == BT_ATT_ERROR_REQUEST_NOT_SUPPORTED)
+			goto discover;
+
 		client->in_init = false;
 		notify_client_ready(client, success, att_ecode);
 
@@ -1076,6 +1085,7 @@ static void exchange_mtu_cb(bool success, uint8_t att_ecode, void *user_data)
 					"MTU exchange complete, with MTU: %u",
 					bt_att_get_mtu(client->att));
 
+discover:
 	client->discovery_req = bt_gatt_discover_all_primary_services(
 							client->att, NULL,
 							discover_primary_cb,
-- 
2.1.0

