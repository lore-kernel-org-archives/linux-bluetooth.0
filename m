Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCHv2 4/7] Add simple-oobprovider for testing.
Date: Wed, 10 Nov 2010 14:31:14 +0100
Message-ID: <1289395877-12384-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1289395877-12384-1-git-send-email-szymon.janc@tieto.com>
References: <1289395877-12384-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/simple-oobprovider |   61 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 61 insertions(+), 0 deletions(-)
 create mode 100755 test/simple-oobprovider

diff --git a/test/simple-oobprovider b/test/simple-oobprovider
new file mode 100755
index 0000000..8e89fdb
--- /dev/null
+++ b/test/simple-oobprovider
@@ -0,0 +1,61 @@
+#!/usr/bin/python
+# Copyright (C) 2010  ST-Ericsson SA
+# Author: Szymon Janc <szymon.janc@tieto.com> for ST-Ericsson
+
+import gobject
+
+import sys
+import dbus
+import dbus.service
+import dbus.mainloop.glib
+
+class NoOobData(dbus.DBusException):
+        _dbus_error_name = "org.bluez.Error.NoData"
+
+
+class Provider(dbus.service.Object):
+
+	remotedata = None
+
+	@dbus.service.method("org.bluez.OOB",
+					in_signature="s", out_signature="ayay")
+
+	def RequestRemoteOobData(self, device):
+		print "RequestRemoteOobData for %s" % (device)
+		if (self.remotedata != None):
+			return self.remotedata
+		raise NoOobData("No OOB data present")
+
+if __name__ == '__main__':
+	dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
+
+	bus = dbus.SystemBus()
+
+	manager = dbus.Interface(bus.get_object("org.bluez", "/"),
+			"org.bluez.Manager")
+
+	adapter_path = manager.DefaultAdapter()
+	adapter = dbus.Interface(bus.get_object("org.bluez",
+			adapter_path), "org.bluez.Adapter")
+
+	oob = dbus.Interface(bus.get_object("org.bluez", "/org/bluez"),
+			"org.bluez.OOB")
+
+	path = "/test/oobprovider"
+	provider = Provider(bus, path)
+
+	mainloop = gobject.MainLoop()
+
+	oob.RegisterProvider(path)
+
+	print "Local data for %s:" % (adapter_path)
+	print oob.UpdateLocalOobData(adapter_path)
+
+	provider.remotedata = input("Provide remote data (in python syntax):\n")
+
+	print "You may try pairing now"
+
+	mainloop.run()
+
+	#adapter.UnregisterProvider(path)
+	#print "Provider unregistered"
-- 
1.7.1

