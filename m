Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCH 2/2] android/gatt: Fix service changed indication
Date: Thu, 11 Dec 2014 13:07:00 +0100
Message-Id: <1418299620-7524-2-git-send-email-mariusz.skamra@tieto.com>
In-Reply-To: <1418299620-7524-1-git-send-email-mariusz.skamra@tieto.com>
References: <1418299620-7524-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes the service changed indication issue.
Without confirmation callback indications were not sent.
Dummy ignore_confirmation_cb is used for this purpose.
---
 android/gatt.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 6d3bcd7..8a81852 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1017,6 +1017,12 @@ static void send_exchange_mtu_request(struct gatt_device *device)
 		device_unref(device);
 }
 
+static void ignore_confirmation_cb(guint8 status, const guint8 *pdu,
+						guint16 len, gpointer user_data)
+{
+	/* Ignored. */
+}
+
 static void notify_att_range_change(struct gatt_device *dev,
 							struct att_range *range)
 {
@@ -1025,6 +1031,7 @@ static void notify_att_range_change(struct gatt_device *dev,
 	uint16_t ccc;
 	uint8_t *pdu;
 	size_t mtu;
+	GAttribResultFunc confirmation_cb = NULL;
 
 	handle = gatt_db_attribute_get_handle(service_changed_attrib);
 	if (!handle)
@@ -1044,6 +1051,7 @@ static void notify_att_range_change(struct gatt_device *dev,
 	case 0x0002:
 		length = enc_indication(handle, (uint8_t *) range,
 						sizeof(*range), pdu, mtu);
+		confirmation_cb = ignore_confirmation_cb;
 		break;
 	default:
 		/* 0xfff4 reserved for future use */
@@ -1051,7 +1059,7 @@ static void notify_att_range_change(struct gatt_device *dev,
 	}
 
 	if (length)
-		g_attrib_send(dev->attrib, 0, pdu, length, NULL, NULL, NULL);
+		g_attrib_send(dev->attrib, 0, pdu, length, confirmation_cb, NULL, NULL);
 }
 
 static struct app_connection *create_connection(struct gatt_device *device,
@@ -5432,12 +5440,6 @@ failed:
 				HAL_OP_GATT_SERVER_DELETE_SERVICE, status);
 }
 
-static void ignore_confirmation_cb(guint8 status, const guint8 *pdu,
-						guint16 len, gpointer user_data)
-{
-	/* Ignored. */
-}
-
 static void handle_server_send_indication(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_server_send_indication *cmd = buf;
-- 
1.9.1

