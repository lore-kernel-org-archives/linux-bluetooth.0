Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] core/device: Enable bt_gatt_client debug
Date: Tue, 17 Mar 2015 17:19:34 +0200
Message-Id: <1426605574-13691-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1426605574-13691-1-git-send-email-luiz.dentz@gmail.com>
References: <1426605574-13691-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables bt_gatt_client debug and use BDG to print out.
---
 src/device.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/device.c b/src/device.c
index aaa9f43..6a23adc 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3989,6 +3989,11 @@ static void gatt_client_service_changed(uint16_t start_handle,
 	DBG("start 0x%04x, end: 0x%04x", start_handle, end_handle);
 }
 
+static void gatt_debug(const char *str, void *user_data)
+{
+	DBG("%s", str);
+}
+
 static void gatt_client_init(struct btd_device *device)
 {
 	gatt_client_cleanup(device);
@@ -4000,6 +4005,8 @@ static void gatt_client_init(struct btd_device *device)
 		return;
 	}
 
+	bt_gatt_client_set_debug(device->client, gatt_debug, NULL, NULL);
+
 	/* Notify attio so it can react to notifications */
 	g_slist_foreach(device->attios, attio_connected, device->attrib);
 
-- 
2.1.0

