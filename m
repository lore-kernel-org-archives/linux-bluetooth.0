Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH] android/gatt: Send Exchange MTU request on connect
Date: Fri, 16 May 2014 15:33:15 +0200
Message-Id: <1400247195-23530-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

According to spec: "This request shall only be sent once during a
connection by the client." This is needed to pass TC_GAC_CL_BV_01_C.
---
 android/gatt.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index 283bb6d..15fdb98 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -978,6 +978,18 @@ static void send_app_connect_notifications(void *data, void *user_data)
 
 static void att_handler(const uint8_t *ipdu, uint16_t len, gpointer user_data);
 
+static void send_exchange_mtu_request(struct gatt_device *device,
+							uint16_t mtu_size)
+{
+	uint8_t req[ATT_DEFAULT_LE_MTU];
+	uint16_t len = 0;
+
+	len = enc_mtu_req(mtu_size, req, ATT_DEFAULT_LE_MTU);
+	if (len) {
+		g_attrib_send(device->attrib, 0, req, len, NULL, NULL, NULL);
+	}
+}
+
 static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 {
 	struct gatt_device *dev = user_data;
@@ -1023,6 +1035,8 @@ static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 
 	status = GATT_SUCCESS;
 
+	send_exchange_mtu_request(dev, ATT_DEFAULT_LE_MTU);
+
 reply:
 	data.dev = dev;
 	data.status = status;
-- 
1.9.3

