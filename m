Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/7] advertising: Use client proxy to release
Date: Thu,  2 Nov 2017 16:15:16 +0200
Message-Id: <20171102141519.28446-4-luiz.dentz@gmail.com>
In-Reply-To: <20171102141519.28446-1-luiz.dentz@gmail.com>
References: <20171102141519.28446-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This uses g_dbus_proxy_method_call instead of build the message
manually.
---
 src/advertising.c  | 13 ++-----------
 src/bluetooth.conf |  1 +
 2 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/src/advertising.c b/src/advertising.c
index 31a5fff5c..94a8c4050 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -137,20 +137,11 @@ static gboolean client_free_idle_cb(void *data)
 static void client_release(void *data)
 {
 	struct btd_adv_client *client = data;
-	DBusMessage *message;
 
 	DBG("Releasing advertisement %s, %s", client->owner, client->path);
 
-	message = dbus_message_new_method_call(client->owner, client->path,
-							LE_ADVERTISEMENT_IFACE,
-							"Release");
-
-	if (!message) {
-		error("Couldn't allocate D-Bus message");
-		return;
-	}
-
-	g_dbus_send_message(btd_get_dbus_connection(), message);
+	g_dbus_proxy_method_call(client->proxy, "Release", NULL, NULL, NULL,
+									NULL);
 }
 
 static void client_destroy(void *data)
diff --git a/src/bluetooth.conf b/src/bluetooth.conf
index 10d2d3688..60e75955c 100644
--- a/src/bluetooth.conf
+++ b/src/bluetooth.conf
@@ -20,6 +20,7 @@
     <allow send_interface="org.bluez.CyclingSpeedWatcher1"/>
     <allow send_interface="org.bluez.GattCharacteristic1"/>
     <allow send_interface="org.bluez.GattDescriptor1"/>
+    <allow send_interface="org.bluez.LEAdvertisement1"/>   
     <allow send_interface="org.freedesktop.DBus.ObjectManager"/>
     <allow send_interface="org.freedesktop.DBus.Properties"/>
   </policy>
-- 
2.13.6

