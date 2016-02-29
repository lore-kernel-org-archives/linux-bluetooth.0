Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] core/gatt-client: Fix printing errors if experimental is disabled
Date: Mon, 29 Feb 2016 17:28:59 +0200
Message-Id: <1456759739-22626-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If experimental flag is not set don't attempt to create any objects since
it will cause error that are hard to guess such as bellow:

bluetoothd[6539]: Unable to register GATT service with handle 0x000c for device
---
 src/gatt-client.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index b4ca3b6..dd76a36 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -1688,6 +1688,12 @@ static void export_service(struct gatt_db_attribute *attr, void *user_data)
 
 static void create_services(struct btd_gatt_client *client)
 {
+	/* Don't attempt to create any objects if experimental is disabled */
+	if (!(g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL)) {
+		info("GATT service objects disabled");
+		return;
+	}
+
 	DBG("Exporting objects for GATT services: %s", client->devaddr);
 
 	gatt_db_foreach_service(client->db, NULL, export_service, client);
-- 
2.5.0

