Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 4/5] android/gatt: Extract indication support from att_req_handler
Date: Mon,  8 Dec 2014 09:22:39 +0100
Message-Id: <1418026960-21104-4-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1418026960-21104-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1418026960-21104-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fixes indication being not confirmed as this handler is called
only for requests.
---
 android/gatt.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 766aae9..8f0864f 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -164,6 +164,7 @@ struct gatt_device {
 	guint req_handler_id;
 	guint write_cmd_handler_id;
 	guint sign_write_cmd_handler_id;
+	guint ind_handler_id;
 
 	int ref;
 	int conn_cnt;
@@ -641,6 +642,9 @@ static void connection_cleanup(struct gatt_device *device)
 		if (device->sign_write_cmd_handler_id > 0)
 			g_attrib_unregister(device->attrib,
 					device->sign_write_cmd_handler_id);
+		if (device->ind_handler_id > 0)
+			g_attrib_unregister(device->attrib,
+							device->ind_handler_id);
 
 		device->attrib = NULL;
 		g_attrib_cancel_all(attrib);
@@ -1657,6 +1661,22 @@ static void att_sign_write_cmd_handler(const uint8_t *cmd, uint16_t cmd_len,
 	}
 }
 
+static void ind_handler(const uint8_t *cmd, uint16_t cmd_len,
+							gpointer user_data)
+{
+	struct gatt_device *dev = user_data;
+	uint16_t resp_length = 0;
+	size_t length;
+
+	uint8_t *opdu = g_attrib_get_buffer(dev->attrib, &length);
+
+	resp_length = enc_confirmation(opdu, length);
+
+	if (resp_length)
+		g_attrib_send(dev->attrib, 0, opdu, resp_length, NULL, NULL,
+									NULL);
+}
+
 static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 {
 	struct gatt_device *dev = user_data;
@@ -1713,8 +1733,11 @@ static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 						GATTRIB_ALL_HANDLES,
 						att_sign_write_cmd_handler,
 						dev, NULL);
+	dev->ind_handler_id = g_attrib_register(attrib, ATT_OP_HANDLE_IND,
+						GATTRIB_ALL_HANDLES,
+						ind_handler, dev, NULL);
 	if ((dev->req_handler_id && dev->write_cmd_handler_id &&
-					dev->sign_write_cmd_handler_id) == 0)
+			dev->ind_handler_id && dev->ind_handler_id) == 0)
 		error("gatt: Could not attach to server");
 
 	device_set_state(dev, DEVICE_CONNECTED);
@@ -6549,15 +6572,6 @@ static void att_req_handler(const uint8_t *ipdu, uint16_t len,
 	case ATT_OP_FIND_BY_TYPE_REQ:
 		status = find_by_type_request(ipdu, len, dev);
 		break;
-	case ATT_OP_HANDLE_IND:
-		/*
-		 * We have to send confirmation here. If some client is
-		 * registered for this indication, event will be send in
-		 * handle_notification
-		 */
-		resp_length = enc_confirmation(opdu, length);
-		status = 0;
-		break;
 	case ATT_OP_HANDLE_NOTIFY:
 		/* Client will handle this */
 		return;
-- 
1.9.1

