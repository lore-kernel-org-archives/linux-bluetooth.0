Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/5] core/device: Call profile disconnect if ATT disconnects
Date: Thu,  8 Sep 2016 15:38:57 +0300
Message-Id: <1473338340-7587-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1473338340-7587-1-git-send-email-luiz.dentz@gmail.com>
References: <1473338340-7587-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If the profile accepts connections it should also be notified when ATT
disconnects so it can cleanup properly.
---
 src/device.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/src/device.c b/src/device.c
index 9586022..eda873f 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4563,6 +4563,18 @@ static void attio_disconnected(gpointer data, gpointer user_data)
 		attio->dcfunc(attio->user_data);
 }
 
+static void disconnect_gatt_service(gpointer data, gpointer user_data)
+{
+	struct btd_service *service = data;
+	struct btd_profile *profile = btd_service_get_profile(service);
+
+	/* Ignore if profile cannot accept connections */
+	if (!profile->accept)
+		return;
+
+	btd_service_disconnect(service);
+}
+
 static void att_disconnected_cb(int err, void *user_data)
 {
 	struct btd_device *device = user_data;
@@ -4575,6 +4587,7 @@ static void att_disconnected_cb(int err, void *user_data)
 	DBG("%s (%d)", strerror(err), err);
 
 	g_slist_foreach(device->attios, attio_disconnected, NULL);
+	g_slist_foreach(device->services, disconnect_gatt_service, NULL);
 
 	btd_gatt_client_disconnected(device->client_dbus);
 
-- 
2.7.4

