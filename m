Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 4/5] android/gatt: Handle indications in a separate function
Date: Tue,  9 Dec 2014 09:51:49 +0100
Message-Id: <1418115110-25335-4-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1418115110-25335-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1418115110-25335-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Indications needs their own handler as they do not fall under the
ALL_REQUESTS op type.
---
 android/gatt.c | 40 ++++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 536a7fe..e7ca147 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -162,6 +162,7 @@ struct gatt_device {
 
 	guint watch_id;
 	guint server_id;
+	guint ind_id;
 
 	int ref;
 	int conn_cnt;
@@ -633,6 +634,10 @@ static void connection_cleanup(struct gatt_device *device)
 		if (device->server_id > 0)
 			g_attrib_unregister(device->attrib, device->server_id);
 
+		if (device->ind_id > 0)
+			g_attrib_unregister(device->attrib,
+							device->ind_id);
+
 		device->attrib = NULL;
 		g_attrib_cancel_all(attrib);
 		g_attrib_unref(attrib);
@@ -1431,6 +1436,27 @@ static void create_app_connection(void *data, void *user_data)
 		create_connection(dev, app);
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
+	/*
+	 * We have to send confirmation here. If some client is
+	 * registered for this indication, event will be send in
+	 * handle_notification
+	 */
+
+	resp_length = enc_confirmation(opdu, length);
+	if (resp_length)
+		g_attrib_send(dev->attrib, 0, opdu, resp_length, NULL, NULL,
+									NULL);
+}
+
 static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 {
 	struct gatt_device *dev = user_data;
@@ -1478,7 +1504,10 @@ static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 	dev->server_id = g_attrib_register(attrib, GATTRIB_ALL_REQS,
 						GATTRIB_ALL_HANDLES,
 						att_handler, dev, NULL);
-	if (dev->server_id == 0)
+	dev->ind_id = g_attrib_register(attrib, ATT_OP_HANDLE_IND,
+						GATTRIB_ALL_HANDLES,
+						ind_handler, dev, NULL);
+	if ((dev->server_id && dev->ind_id) == 0)
 		error("gatt: Could not attach to server");
 
 	device_set_state(dev, DEVICE_CONNECTED);
@@ -6535,15 +6564,6 @@ static void att_handler(const uint8_t *ipdu, uint16_t len, gpointer user_data)
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

