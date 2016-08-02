Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/3] doc/gatt-api: Mention available examples
Date: Tue,  2 Aug 2016 14:33:55 +0300
Message-Id: <1470137637-6189-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 doc/gatt-api.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
index f2f3d89..fd4bdd5 100644
--- a/doc/gatt-api.txt
+++ b/doc/gatt-api.txt
@@ -307,6 +307,15 @@ unregister the service. Similarly, if the application disconnects from the bus,
 all of its registered services will be automatically unregistered.
 InterfacesAdded signals will be ignored.
 
+Examples:
+	- Client
+		test/example-gatt-client
+		client/bluetoothctl
+	- Server
+		test/example-gatt-server
+		tools/gatt-service
+
+
 Service		org.bluez
 Interface	org.bluez.GattManager1
 Object path	[variable prefix]/{hci0,hci1,...}
-- 
2.7.4

