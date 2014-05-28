Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 2/2] android/gatt: Exchange mtu on connect if acting as client
Date: Wed, 28 May 2014 09:48:50 +0200
Message-Id: <1401263330-30680-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1401263330-30680-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1401263330-30680-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When no client apps are registered we basically act as server only and
mtu exchange request handling is enough. When acting as client we send
request. Flag indicating mtu exchange status is stored in device to send
exchange mtu requests when first client app registers.
---
 android/gatt.c | 47 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 41 insertions(+), 6 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 1f83eaa..0c9837d 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -168,6 +168,7 @@ struct gatt_device {
 
 	int ref;
 	int conn_cnt;
+	bool mtu_exchanged;
 
 	struct queue *pending_requests;
 };
@@ -320,11 +321,24 @@ static bool match_app_by_id(const void *data, const void *user_data)
 	return client->id == exp_id;
 }
 
+static bool match_app_by_type(const void *data, const void *user_data)
+{
+	gatt_app_type_t app_type = PTR_TO_INT(user_data);
+	const struct gatt_app *app = data;
+
+	return app->type == app_type;
+}
+
 static struct gatt_app *find_app_by_id(int32_t id)
 {
 	return queue_find(gatt_apps, match_app_by_id, INT_TO_PTR(id));
 }
 
+static struct gatt_app *find_app_by_type(gatt_app_type_t type)
+{
+	return queue_find(gatt_apps, match_app_by_type, INT_TO_PTR(type));
+}
+
 static bool match_by_value(const void *data, const void *user_data)
 {
 	return data == user_data;
@@ -599,6 +613,7 @@ static void connection_cleanup(struct gatt_device *device)
 		queue_remove_all(device->services, NULL, NULL, destroy_service);
 
 	device_set_state(device, DEVICE_DISCONNECTED);
+	device->mtu_exchanged = false;
 }
 
 static void destroy_gatt_app(void *data)
@@ -672,21 +687,38 @@ static int register_app(const uint8_t *uuid, gatt_app_type_t app_type)
 	return app->id;
 }
 
+static void send_exchange_mtu_request(struct gatt_device *device);
+
+static void device_exchange_mtu(void *data, void *user_data)
+{
+	struct gatt_device *dev = data;
+
+	if (!dev->mtu_exchanged)
+		send_exchange_mtu_request(dev);
+}
+
 static void handle_client_register(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_client_register *cmd = buf;
 	struct hal_ev_gatt_client_register_client ev;
+	void *client;
 
 	DBG("");
 
+	client = find_app_by_type(APP_CLIENT);
+
 	memset(&ev, 0, sizeof(ev));
 
 	ev.client_if = register_app(cmd->uuid, APP_CLIENT);
 
-	if (ev.client_if)
+	if (ev.client_if) {
 		ev.status = GATT_SUCCESS;
-	else
+
+		if (!client)
+			queue_foreach(gatt_devices, device_exchange_mtu, NULL);
+	} else {
 		ev.status = GATT_FAILURE;
+	}
 
 	/* We should send notification with given in cmd UUID */
 	memcpy(ev.app_uuid, cmd->uuid, sizeof(ev.app_uuid));
@@ -1043,6 +1075,8 @@ static void exchange_mtu_cb(guint8 status, const guint8 *pdu, guint16 plen,
 		goto failed;
 	}
 
+	device->mtu_exchanged = true;
+
 	DBG("MTU exchange succeeded: rmtu:%d, old mtu:%d, new mtu:%d", rmtu,
 								imtu, mtu);
 
@@ -1116,9 +1150,9 @@ static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 
 	device_set_state(dev, DEVICE_CONNECTED);
 
-	/* Send exchange mtu request as we assume being client and server */
-	/* TODO: Dont exchange mtu if no client apps */
-	send_exchange_mtu_request(dev);
+	/* Send exchange mtu request if any client app was registered */
+	if (find_app_by_type(APP_CLIENT))
+		send_exchange_mtu_request(dev);
 
 	status = GATT_SUCCESS;
 
@@ -4760,7 +4794,8 @@ static uint8_t mtu_att_handle(const uint8_t *cmd, uint16_t cmd_len,
 
 	/* Limit OMTU to received value */
 	mtu = MIN(mtu, omtu);
-	g_attrib_set_mtu(dev->attrib, mtu);
+	if (g_attrib_set_mtu(dev->attrib, mtu))
+		dev->mtu_exchanged = true;
 
 	return 0;
 }
-- 
1.9.3

