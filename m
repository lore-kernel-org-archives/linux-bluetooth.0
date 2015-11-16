Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?=C5=81ukasz=20Rymanowski?=
	<lukasz.rymanowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?=C5=81ukasz=20Rymanowski?=
	<lukasz.rymanowski@codecoup.pl>
Subject: [PATCH 2/2] test/test-discovery: Remove dead code
Date: Mon, 16 Nov 2015 21:58:13 +0100
Message-Id: <1447707493-9342-2-git-send-email-lukasz.rymanowski@codecoup.pl>
In-Reply-To: <1447707493-9342-1-git-send-email-lukasz.rymanowski@codecoup.pl>
References: <1447707493-9342-1-git-send-email-lukasz.rymanowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

PropertyChanged is left over from BlueZ 4.x now it is PropertiesChanged.
However in this test it does not make sense to register for this signal
as StopDiscovery is never called from this test.
---
 test/test-discovery | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/test/test-discovery b/test/test-discovery
index 73b8161..9a2c6b9 100755
--- a/test/test-discovery
+++ b/test/test-discovery
@@ -107,10 +107,6 @@ def properties_changed(interface, changed, invalidated, path):
 	else:
 		print_normal(address, devices[path])
 
-def property_changed(name, value):
-	if (name == "Discovering" and not value):
-		mainloop.quit()
-
 if __name__ == '__main__':
 	dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
 
@@ -141,10 +137,6 @@ if __name__ == '__main__':
 			arg0 = "org.bluez.Device1",
 			path_keyword = "path")
 
-	bus.add_signal_receiver(property_changed,
-					dbus_interface = "org.bluez.Adapter1",
-					signal_name = "PropertyChanged")
-
 	om = dbus.Interface(bus.get_object("org.bluez", "/"),
 				"org.freedesktop.DBus.ObjectManager")
 	objects = om.GetManagedObjects()
-- 
2.5.0

