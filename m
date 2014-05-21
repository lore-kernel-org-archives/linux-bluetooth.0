Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv4 1/4] android/gatt: Send Exchange MTU request on connect
Date: Wed, 21 May 2014 16:17:32 +0200
Message-Id: <1400681855-7438-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1400681855-7438-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1400681855-7438-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds sending exchange MTU request on connection.

This is needed to pass TC_GAC_CL_BV_01_C.
---
 android/gatt.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 59 insertions(+), 2 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 89da60d..e9db9e6 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -144,6 +144,7 @@ struct gatt_device {
 
 	gatt_device_state_t state;
 
+	size_t mtu;
 	GAttrib *attrib;
 	GIOChannel *att_io;
 	struct queue *services;
@@ -368,6 +369,15 @@ static struct app_connection *find_connection_by_id(int32_t conn_id)
 							INT_TO_PTR(conn_id));
 }
 
+static bool match_client_connection_by_device(const void *data,
+							const void *user_data)
+{
+	const struct app_connection *conn = data;
+	const struct gatt_device *dev = user_data;
+
+	return conn->device == dev ? conn->app->type == APP_CLIENT : false;
+}
+
 static bool match_connection_by_device(const void *data, const void *user_data)
 {
 	const struct app_connection *conn = data;
@@ -979,6 +989,48 @@ static void send_app_connect_notifications(void *data, void *user_data)
 
 static void att_handler(const uint8_t *ipdu, uint16_t len, gpointer user_data);
 
+static void exchange_mtu_cb(guint8 status, const guint8 *pdu, guint16 plen,
+							gpointer user_data)
+{
+	struct gatt_device *device = user_data;
+	uint16_t rmtu, mtu;
+
+	if (status) {
+		error("gatt: MTU exchange: %s", att_ecode2str(status));
+		goto failed;
+	}
+
+	if (!dec_mtu_resp(pdu, plen, &rmtu)) {
+		error("gatt: MTU exchange: protocol error");
+		goto failed;
+	}
+
+	if (rmtu < ATT_DEFAULT_LE_MTU) {
+		error("gatt: MTU exchange: mtu error");
+		goto failed;
+	}
+
+	mtu = MIN(rmtu, device->mtu);
+	if (mtu != device->mtu && !g_attrib_set_mtu(device->attrib, mtu)) {
+		error("gatt: MTU exchange failed");
+		goto failed;
+	}
+
+	DBG("MTU exchange succeeded: rmtu:%d, old mtu:%zd, new mtu:%d", rmtu,
+							device->mtu, mtu);
+	device->mtu = mtu;
+
+failed:
+	device_unref(device);
+}
+
+static void send_exchange_mtu_request(struct gatt_device *device)
+{
+	if (!gatt_exchange_mtu(device->attrib, device->mtu,
+					exchange_mtu_cb, device_ref(device)))
+		device_unref(device);
+}
+
 static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 {
 	struct gatt_device *dev = user_data;
@@ -1022,10 +1074,15 @@ static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 	if (dev->server_id == 0)
 		error("gatt: Could not attach to server");
 
+	/* store current mtu */
+	g_attrib_get_buffer(attrib, &dev->mtu);
 	device_set_state(dev, DEVICE_CONNECTED);
 
 	status = GATT_SUCCESS;
 
+	if (queue_find(app_connections, match_client_connection_by_device, dev))
+		send_exchange_mtu_request(dev);
+
 reply:
 	data.dev = dev;
 	data.status = status;
@@ -4513,8 +4570,8 @@ static uint8_t mtu_att_handle(const uint8_t *cmd, uint16_t cmd_len,
 	}
 
 	/* Limit OMTU to received value */
-	mtu = MIN(mtu, omtu);
-	g_attrib_set_mtu(dev->attrib, mtu);
+	dev->mtu = MIN(mtu, omtu);
+	g_attrib_set_mtu(dev->attrib, dev->mtu);
 
 	/* Respond with our IMTU */
 	len = enc_mtu_resp(imtu, rsp, rsp_size);
-- 
1.9.3

