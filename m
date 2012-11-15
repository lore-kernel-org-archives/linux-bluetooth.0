Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v1 06/16] test: Update to new Manager path
Date: Thu, 15 Nov 2012 16:09:09 +0100
Message-Id: <1352992159-11559-7-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1352992159-11559-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1352992159-11559-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Make use of the new object path being used for org.bluez.Manager.
---
 profiles/cups/main.c  | 4 ++--
 test/agent.c          | 2 +-
 test/dbusdef.py       | 3 ++-
 test/gaptest.c        | 2 +-
 test/mpris-player.c   | 2 +-
 test/simple-agent     | 2 +-
 test/simple-endpoint  | 2 +-
 test/simple-player    | 2 +-
 test/simple-service   | 2 +-
 test/test-adapter     | 3 ++-
 test/test-attrib      | 3 ++-
 test/test-audio       | 3 ++-
 test/test-device      | 3 ++-
 test/test-discovery   | 2 +-
 test/test-health      | 2 +-
 test/test-health-sink | 2 +-
 test/test-heartrate   | 2 +-
 test/test-input       | 3 ++-
 test/test-manager     | 2 +-
 test/test-nap         | 2 +-
 test/test-network     | 2 +-
 test/test-oob         | 2 +-
 test/test-proximity   | 2 +-
 test/test-service     | 3 ++-
 test/test-thermometer | 2 +-
 25 files changed, 33 insertions(+), 26 deletions(-)

diff --git a/profiles/cups/main.c b/profiles/cups/main.c
index b8bcbd3..ab1d2b9 100644
--- a/profiles/cups/main.c
+++ b/profiles/cups/main.c
@@ -543,7 +543,7 @@ static gboolean list_printers(void)
 		return TRUE;
 
 	/* Get the default adapter */
-	message = dbus_message_new_method_call("org.bluez", "/",
+	message = dbus_message_new_method_call("org.bluez", "/org/bluez",
 						"org.bluez.Manager",
 						"FindAdapter");
 	if (message == NULL) {
@@ -634,7 +634,7 @@ static gboolean print_ieee1284(const char *bdaddr)
 	if (conn == NULL)
 		return FALSE;
 
-	message = dbus_message_new_method_call("org.bluez", "/",
+	message = dbus_message_new_method_call("org.bluez", "/org/bluez",
 			"org.bluez.Manager",
 			"FindAdapter");
 
diff --git a/test/agent.c b/test/agent.c
index 6ad3bc7..5edd9ce 100644
--- a/test/agent.c
+++ b/test/agent.c
@@ -474,7 +474,7 @@ static char *get_adapter_path(DBusConnection *conn, const char *adapter)
 	if (!adapter)
 		adapter = "default";
 
-	msg = dbus_message_new_method_call("org.bluez", "/",
+	msg = dbus_message_new_method_call("org.bluez", "/org/bluez",
 					"org.bluez.Manager", "FindAdapter");
 
 	if (!msg) {
diff --git a/test/dbusdef.py b/test/dbusdef.py
index 1d55f97..f9b955f 100644
--- a/test/dbusdef.py
+++ b/test/dbusdef.py
@@ -8,7 +8,8 @@ dummy = dbus.Interface(bus.get_object('org.bluez', '/'), 'org.freedesktop.DBus.I
 #print dummy.Introspect()
 
 
-manager = dbus.Interface(bus.get_object('org.bluez', '/'), 'org.bluez.Manager')
+manager = dbus.Interface(bus.get_object('org.bluez', '/org/bluez'),
+							'org.bluez.Manager')
 
 try:
 	adapter = dbus.Interface(bus.get_object('org.bluez', manager.FindAdapter("default")), 'org.bluez.Adapter')
diff --git a/test/gaptest.c b/test/gaptest.c
index bcc3959..6ff6c78 100644
--- a/test/gaptest.c
+++ b/test/gaptest.c
@@ -35,7 +35,7 @@
 
 #define BLUEZ_SERVICE	"org.bluez"
 
-#define MANAGER_PATH	"/"
+#define MANAGER_PATH	"/org/bluez"
 #define MANAGER_INTF	BLUEZ_SERVICE ".Manager"
 #define ADAPTER_INTF	BLUEZ_SERVICE ".Adapter"
 
diff --git a/test/mpris-player.c b/test/mpris-player.c
index 641db6e..b354187 100644
--- a/test/mpris-player.c
+++ b/test/mpris-player.c
@@ -672,7 +672,7 @@ static char *get_adapter(DBusConnection *conn, const char *adapter)
 	if (!adapter)
 		adapter = NULL;
 
-	msg = dbus_message_new_method_call("org.bluez", "/",
+	msg = dbus_message_new_method_call("org.bluez", "/org/bluez",
 					"org.bluez.Manager", "FindAdapter");
 
 	if (!msg) {
diff --git a/test/simple-agent b/test/simple-agent
index cad7dc7..09742f4 100755
--- a/test/simple-agent
+++ b/test/simple-agent
@@ -109,7 +109,7 @@ if __name__ == '__main__':
 	dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
 
 	bus = dbus.SystemBus()
-	manager = dbus.Interface(bus.get_object("org.bluez", "/"),
+	manager = dbus.Interface(bus.get_object("org.bluez", "/org/bluez"),
 							"org.bluez.Manager")
 
 	capability = "KeyboardDisplay"
diff --git a/test/simple-endpoint b/test/simple-endpoint
index 013ed8c..20ad0b3 100755
--- a/test/simple-endpoint
+++ b/test/simple-endpoint
@@ -79,7 +79,7 @@ if __name__ == '__main__':
 	dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
 
 	bus = dbus.SystemBus()
-	manager = dbus.Interface(bus.get_object("org.bluez", "/"),
+	manager = dbus.Interface(bus.get_object("org.bluez", "/org/bluez"),
 						"org.bluez.Manager")
 
 	if len(sys.argv) > 1:
diff --git a/test/simple-player b/test/simple-player
index 5e10e95..b4750f3 100755
--- a/test/simple-player
+++ b/test/simple-player
@@ -137,7 +137,7 @@ if __name__ == '__main__':
 	dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
 
 	bus = dbus.SystemBus()
-	manager = dbus.Interface(bus.get_object("org.bluez", "/"),
+	manager = dbus.Interface(bus.get_object("org.bluez", "/org/bluez"),
 						"org.bluez.Manager")
 
 	if len(sys.argv) > 1:
diff --git a/test/simple-service b/test/simple-service
index 9b65e80..4e62283 100755
--- a/test/simple-service
+++ b/test/simple-service
@@ -103,7 +103,7 @@ xml = ' \
 '
 
 bus = dbus.SystemBus()
-manager = dbus.Interface(bus.get_object("org.bluez", "/"),
+manager = dbus.Interface(bus.get_object("org.bluez", "/org/bluez"),
 						"org.bluez.Manager")
 
 if len(sys.argv) > 1:
diff --git a/test/test-adapter b/test/test-adapter
index 8d44dd8..4449277 100755
--- a/test/test-adapter
+++ b/test/test-adapter
@@ -9,7 +9,8 @@ from optparse import OptionParser, make_option
 
 bus = dbus.SystemBus()
 
-manager = dbus.Interface(bus.get_object("org.bluez", "/"), "org.bluez.Manager")
+manager = dbus.Interface(bus.get_object("org.bluez", "/org/bluez"),
+							"org.bluez.Manager")
 
 option_list = [
 		make_option("-i", "--device", action="store",
diff --git a/test/test-attrib b/test/test-attrib
index 5263c84..f2ebd0b 100755
--- a/test/test-attrib
+++ b/test/test-attrib
@@ -18,7 +18,8 @@ dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
 bus = dbus.SystemBus()
 mainloop = gobject.MainLoop()
 
-manager = dbus.Interface(bus.get_object("org.bluez", "/"), "org.bluez.Manager")
+manager = dbus.Interface(bus.get_object("org.bluez", "/org/bluez"),
+							"org.bluez.Manager")
 
 option_list = [
 		make_option("-i", "--device", action="store",
diff --git a/test/test-audio b/test/test-audio
index 77cc22e..b4e024b 100755
--- a/test/test-audio
+++ b/test/test-audio
@@ -8,7 +8,8 @@ from optparse import OptionParser, make_option
 
 bus = dbus.SystemBus()
 
-manager = dbus.Interface(bus.get_object("org.bluez", "/"), "org.bluez.Manager")
+manager = dbus.Interface(bus.get_object("org.bluez", "/org/bluez"),
+							"org.bluez.Manager")
 
 option_list = [
 		make_option("-i", "--device", action="store",
diff --git a/test/test-device b/test/test-device
index 8db1fac..50bad05 100755
--- a/test/test-device
+++ b/test/test-device
@@ -14,7 +14,8 @@ dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
 bus = dbus.SystemBus()
 mainloop = GObject.MainLoop()
 
-manager = dbus.Interface(bus.get_object("org.bluez", "/"), "org.bluez.Manager")
+manager = dbus.Interface(bus.get_object("org.bluez", "/org/bluez"),
+							"org.bluez.Manager")
 
 option_list = [
 		make_option("-i", "--device", action="store",
diff --git a/test/test-discovery b/test/test-discovery
index f262021..a7c9fcc 100755
--- a/test/test-discovery
+++ b/test/test-discovery
@@ -88,7 +88,7 @@ if __name__ == '__main__':
 	dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
 
 	bus = dbus.SystemBus()
-	manager = dbus.Interface(bus.get_object("org.bluez", "/"),
+	manager = dbus.Interface(bus.get_object("org.bluez", "/org/bluez"),
 							"org.bluez.Manager")
 
 	option_list = [
diff --git a/test/test-health b/test/test-health
index a7df679..21d1776 100755
--- a/test/test-health
+++ b/test/test-health
@@ -131,7 +131,7 @@ if not con:
 	enter_mainloop()
 	sys.exit()
 
-manager = dbus.Interface(bus.get_object("org.bluez", "/"),
+manager = dbus.Interface(bus.get_object("org.bluez", "/org/bluez"),
 						"org.bluez.Manager")
 
 adapters = manager.GetProperties()["Adapters"]
diff --git a/test/test-health-sink b/test/test-health-sink
index 333b2fb..7bf1af4 100755
--- a/test/test-health-sink
+++ b/test/test-health-sink
@@ -21,7 +21,7 @@ app_path = hdp_manager.CreateApplication({"DataType": dbus.types.UInt16(4103),
 
 print(app_path)
 
-manager = dbus.Interface(bus.get_object("org.bluez", "/"),
+manager = dbus.Interface(bus.get_object("org.bluez", "/org/bluez"),
 						"org.bluez.Manager")
 
 adapters = manager.GetProperties()["Adapters"]
diff --git a/test/test-heartrate b/test/test-heartrate
index aee6a46..c9b0218 100755
--- a/test/test-heartrate
+++ b/test/test-heartrate
@@ -36,7 +36,7 @@ if __name__ == "__main__":
 
 	bus = dbus.SystemBus()
 
-	manager = dbus.Interface(bus.get_object("org.bluez", "/"),
+	manager = dbus.Interface(bus.get_object("org.bluez", "/org/bluez"),
 					"org.bluez.Manager")
 
 	option_list = [
diff --git a/test/test-input b/test/test-input
index 783a19f..45a07a8 100755
--- a/test/test-input
+++ b/test/test-input
@@ -8,7 +8,8 @@ from optparse import OptionParser, make_option
 
 bus = dbus.SystemBus()
 
-manager = dbus.Interface(bus.get_object("org.bluez", "/"), "org.bluez.Manager")
+manager = dbus.Interface(bus.get_object("org.bluez", "/org/bluez"),
+							"org.bluez.Manager")
 
 option_list = [
 		make_option("-i", "--device", action="store",
diff --git a/test/test-manager b/test/test-manager
index 30ca155..2a9c1e9 100755
--- a/test/test-manager
+++ b/test/test-manager
@@ -21,7 +21,7 @@ if __name__ == "__main__":
 
 	bus = dbus.SystemBus()
 
-	manager = dbus.Interface(bus.get_object('org.bluez', '/'),
+	manager = dbus.Interface(bus.get_object('org.bluez', '/org/bluez'),
 							'org.bluez.Manager')
 
 	manager.connect_to_signal("AdapterAdded", adapter_added)
diff --git a/test/test-nap b/test/test-nap
index b97b165..0b1857c 100755
--- a/test/test-nap
+++ b/test/test-nap
@@ -9,7 +9,7 @@ from optparse import OptionParser, make_option
 
 bus = dbus.SystemBus()
 
-manager = dbus.Interface(bus.get_object("org.bluez", "/"),
+manager = dbus.Interface(bus.get_object("org.bluez", "/org/bluez"),
 						"org.bluez.Manager")
 
 option_list = [
diff --git a/test/test-network b/test/test-network
index b920901..dd3e11b 100755
--- a/test/test-network
+++ b/test/test-network
@@ -9,7 +9,7 @@ from optparse import OptionParser, make_option
 
 bus = dbus.SystemBus()
 
-manager = dbus.Interface(bus.get_object("org.bluez", "/"),
+manager = dbus.Interface(bus.get_object("org.bluez", "/org/bluez"),
 						"org.bluez.Manager")
 
 option_list = [
diff --git a/test/test-oob b/test/test-oob
index d44215f..40f45a8 100755
--- a/test/test-oob
+++ b/test/test-oob
@@ -20,7 +20,7 @@ if __name__ == '__main__':
 	mainloop = gobject.MainLoop()
 
 	bus = dbus.SystemBus()
-	manager = dbus.Interface(bus.get_object("org.bluez", "/"),
+	manager = dbus.Interface(bus.get_object("org.bluez", "/org/bluez"),
 							"org.bluez.Manager")
 
 	adapter0_path = manager.FindAdapter("hci0")
diff --git a/test/test-proximity b/test/test-proximity
index 9afb1d9..8c0d88a 100755
--- a/test/test-proximity
+++ b/test/test-proximity
@@ -23,7 +23,7 @@ if __name__ == "__main__":
 
 	bus = dbus.SystemBus()
 
-	manager = dbus.Interface(bus.get_object("org.bluez", "/"),
+	manager = dbus.Interface(bus.get_object("org.bluez", "/org/bluez"),
 					"org.bluez.Manager")
 
 	option_list = [
diff --git a/test/test-service b/test/test-service
index 17e8593..98f00a4 100755
--- a/test/test-service
+++ b/test/test-service
@@ -9,7 +9,8 @@ from optparse import OptionParser, make_option
 
 bus = dbus.SystemBus()
 
-manager = dbus.Interface(bus.get_object("org.bluez", "/"), "org.bluez.Manager")
+manager = dbus.Interface(bus.get_object("org.bluez", "/org/bluez"),
+							"org.bluez.Manager")
 
 option_list = [
 		make_option("-i", "--device", action="store",
diff --git a/test/test-thermometer b/test/test-thermometer
index 16ab0ac..8b86f76 100755
--- a/test/test-thermometer
+++ b/test/test-thermometer
@@ -38,7 +38,7 @@ if __name__ == "__main__":
 
 	bus = dbus.SystemBus()
 
-	manager = dbus.Interface(bus.get_object("org.bluez", "/"),
+	manager = dbus.Interface(bus.get_object("org.bluez", "/org/bluez"),
 					"org.bluez.Manager")
 
 	option_list = [
-- 
1.7.11.7

