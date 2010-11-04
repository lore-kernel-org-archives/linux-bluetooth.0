Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 4/4] Add simple-oobprovider for testing.
Date: Thu, 4 Nov 2010 11:11:01 +0100
Message-ID: <1288865461-3760-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1288865461-3760-1-git-send-email-szymon.janc@tieto.com>
References: <1288865461-3760-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/simple-oobprovider |   54 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 54 insertions(+), 0 deletions(-)
 create mode 100755 test/simple-oobprovider

diff --git a/test/simple-oobprovider b/test/simple-oobprovider
new file mode 100755
index 0000000..135f0f7
--- /dev/null
+++ b/test/simple-oobprovider
@@ -0,0 +1,54 @@
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
+class Provider(dbus.service.Object):
+
+	remotedata = None
+
+	@dbus.service.method("org.bluez.OOB",
+					in_signature="s", out_signature="ayay")
+
+	def RequestRemoteOobData(self, address):
+		print "RequestRemoteOobData for %s" % (address)
+		return self.remotedata
+
+if __name__ == '__main__':
+	dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
+
+	bus = dbus.SystemBus()
+
+	manager = dbus.Interface(bus.get_object("org.bluez", "/"),
+			"org.bluez.Manager")
+	adapter = dbus.Interface(bus.get_object("org.bluez",
+			manager.DefaultAdapter()), "org.bluez.Adapter")
+	adr = adapter.GetProperties()['Address']
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
+	print "Local data for %s:" % (adr)
+	print oob.UpdateLocalOobData(adr)
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

