Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2] Add test/test-oob for testing Out Of Band pairing
Date: Fri, 8 Apr 2011 11:37:54 +0200
Message-ID: <1302255474-15128-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This test utilizes D-Bus Out Of Band API so bluetoothd must be
compiled with dbusoob plugin.
---
 Makefile.tools |    4 +-
 test/test-oob  |   80 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+), 2 deletions(-)
 create mode 100755 test/test-oob

diff --git a/Makefile.tools b/Makefile.tools
index f6d7b13..364db37 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -205,8 +205,8 @@ EXTRA_DIST += test/apitest test/sap-client test/hsplay test/hsmicro \
 		test/test-telephony test/test-network test/simple-agent \
 		test/simple-service test/simple-endpoint test/test-audio \
 		test/test-input test/test-attrib test/test-sap-server \
-		test/service-record.dtd test/service-did.xml test/service-spp.xml \
-		test/service-opp.xml test/service-ftp.xml
+		test/test-oob test/service-record.dtd test/service-did.xml \
+		test/service-spp.xml test/service-opp.xml test/service-ftp.xml
 
 
 if HIDD
diff --git a/test/test-oob b/test/test-oob
new file mode 100755
index 0000000..3340c00
--- /dev/null
+++ b/test/test-oob
@@ -0,0 +1,80 @@
+#!/usr/bin/python
+
+import gobject
+
+import dbus.mainloop.glib
+
+def create_device_reply(device):
+	print "Pairing succeed!"
+	mainloop.quit()
+
+def create_device_error(error):
+	print "Pairing failed."
+	mainloop.quit()
+
+if __name__ == '__main__':
+	dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
+
+	mainloop = gobject.MainLoop()
+
+	bus = dbus.SystemBus()
+	manager = dbus.Interface(bus.get_object("org.bluez", "/"),
+							"org.bluez.Manager")
+
+	adapter0_path = manager.FindAdapter("hci0")
+	adapter1_path = manager.FindAdapter("hci1")
+
+	adapter0 = dbus.Interface(bus.get_object("org.bluez", adapter0_path),
+							"org.bluez.Adapter")
+	adapter1 = dbus.Interface(bus.get_object("org.bluez", adapter1_path),
+							"org.bluez.Adapter")
+
+	adapter0_address = adapter0.GetProperties()["Address"]
+	adapter1_address = adapter1.GetProperties()["Address"]
+	print "Adapters:"
+	print "    hci0: " + adapter0_address
+	print "    hci1: " + adapter1_address
+	print
+
+	print "Removing any existing bond..."
+
+	try:
+		device = adapter0.FindDevice(adapter1_address)
+		adapter0.RemoveDevice(device)
+	except:
+		pass
+
+	try:
+		device = adapter1.FindDevice(adapter0_address)
+		adapter1.RemoveDevice(device)
+	except:
+		pass
+
+	print "Done."
+	print
+	print "Reading local Out of Band data..."
+
+	oob_adapter0 = dbus.Interface(bus.get_object("org.bluez",
+					adapter0_path), "org.bluez.OutOfBand")
+	oob_adapter1 = dbus.Interface(bus.get_object("org.bluez",
+					adapter1_path), "org.bluez.OutOfBand")
+
+	oob0 = oob_adapter0.ReadLocalData()
+	oob1 = oob_adapter1.ReadLocalData()
+
+	print "Done."
+	print
+	print "Exchanging Out of Band data..."
+
+	oob_adapter0.AddRemoteData(adapter1_address, oob1[0], oob1[1])
+	oob_adapter1.AddRemoteData(adapter0_address, oob0[0], oob0[1])
+
+	print "Done."
+	print
+	print "Starting to pair."
+	adapter1.CreatePairedDevice(adapter0_address, "/test/agent_oob",
+					"DisplayYesNo",
+					reply_handler=create_device_reply,
+					error_handler=create_device_error)
+
+	mainloop.run()
-- 
1.7.0.4

on behalf of ST-Ericsson
