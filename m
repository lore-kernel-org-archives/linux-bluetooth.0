Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ v2 12/14] test: Fix exiting the bus when a discovery session ends
Date: Wed, 15 Aug 2012 11:50:51 -0300
Message-Id: <1345042253-15053-13-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1345042253-15053-1-git-send-email-jprvita@openbossa.org>
References: <1345042253-15053-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>

Sometimes we may want that a discovery session to continue existing
for more than a discovery window. For example, testing starting a
pairing while a discovery session is running.
---
 test/test-discovery | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/test/test-discovery b/test/test-discovery
index 269c51c..08dfd0b 100755
--- a/test/test-discovery
+++ b/test/test-discovery
@@ -22,10 +22,6 @@ def device_found(address, properties):
 
 	print()
 
-def property_changed(name, value):
-	if (name == "Discovering" and not value):
-		mainloop.quit()
-
 if __name__ == '__main__':
 	dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
 
@@ -53,10 +49,6 @@ if __name__ == '__main__':
 			dbus_interface = "org.bluez.Adapter",
 					signal_name = "DeviceFound")
 
-	bus.add_signal_receiver(property_changed,
-			dbus_interface = "org.bluez.Adapter",
-					signal_name = "PropertyChanged")
-
 	adapter.StartDiscovery()
 
 	mainloop = GObject.MainLoop()
-- 
1.7.11.2

