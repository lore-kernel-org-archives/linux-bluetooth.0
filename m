Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/2] Add test/test-oob for testing Out Of Band pairing
Date: Thu, 7 Apr 2011 14:01:22 +0200
Message-ID: <1302177682-7873-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1302177682-7873-1-git-send-email-szymon.janc@tieto.com>
References: <1302177682-7873-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This test utilizes D-Bus Out Of Band API so bluetoothd must be
compiled with dbusoob plugin.
---
 Makefile.tools |    5 ++-
 test/test-oob  |   95 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+), 2 deletions(-)
 create mode 100755 test/test-oob

diff --git a/Makefile.tools b/Makefile.tools
index de45371..3a894ac 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -205,8 +205,9 @@ EXTRA_DIST += test/apitest test/sap-client test/hsplay test/hsmicro \
 		test/test-telephony test/test-network test/simple-agent \
 		test/simple-service test/simple-endpoint test/test-audio \
 		test/test-input test/test-attrib test/test-sap-server \
-		test/agent.py test/service-record.dtd test/service-did.xml \
-		test/service-spp.xml test/service-opp.xml test/service-ftp.xml
+		test/agent.py test/test-oob test/service-record.dtd \
+		test/service-did.xml test/service-spp.xml \
+		test/service-opp.xml test/service-ftp.xml
 
 
 if HIDD
diff --git a/test/test-oob b/test/test-oob
new file mode 100755
index 0000000..ab507a8
--- /dev/null
+++ b/test/test-oob
@@ -0,0 +1,95 @@
+#!/usr/bin/python
+
+import gobject
+
+import dbus.mainloop.glib
+
+import agent
+
+agent1_path = "/test/agent1"
+agent2_path = "/test/agent2"
+
+adapter1 = None
+
+def create_device_reply(device):
+	print "Pairing succeed!"
+	adapter1.UnregisterAgent(agent1_path)
+	mainloop.quit()
+
+def create_device_error(error):
+	print "Pairing failed."
+	adapter1.UnregisterAgent(agent1_path)
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
+	adapter1_path = manager.FindAdapter("hci0")
+	adapter2_path = manager.FindAdapter("hci1")
+
+	adapter1 = dbus.Interface(bus.get_object("org.bluez", adapter1_path),
+							"org.bluez.Adapter")
+	adapter2 = dbus.Interface(bus.get_object("org.bluez", adapter2_path),
+							"org.bluez.Adapter")
+
+	adapter1_address = adapter1.GetProperties()["Address"]
+	adapter2_address = adapter2.GetProperties()["Address"]
+	print "Adapters:"
+	print "    hci0: " + adapter1_address
+	print "    hci1: " + adapter2_address
+	print
+
+	print "Removing any existing bond..."
+
+	try:
+		device = adapter1.FindDevice(adapter2_address)
+		adapter1.RemoveDevice(device)
+	except:
+		pass
+
+	try:
+		device = adapter2.FindDevice(adapter1_address)
+		adapter2.RemoveDevice(device)
+	except:
+		pass
+
+	print "Done."
+	print
+	print "Reading local Out of Band data."
+
+	oob_adapter1 = dbus.Interface(bus.get_object("org.bluez",
+					adapter1_path), "org.bluez.OutOfBand")
+	oob_adapter2 = dbus.Interface(bus.get_object("org.bluez",
+					adapter2_path), "org.bluez.OutOfBand")
+
+	oob1 = oob_adapter1.ReadLocalData()
+	oob2 = oob_adapter2.ReadLocalData()
+
+	print "Done."
+	print
+	print "Exchanging Out of Band data..."
+
+	oob_adapter1.AddRemoteData(adapter2_address, oob2[0], oob2[1])
+	oob_adapter2.AddRemoteData(adapter1_address, oob1[0], oob1[1])
+
+	print "Done."
+	print
+	print "Registering agent for hci0..."
+
+	adapter1.RegisterAgent(agent1_path, "DisplayYesNo")
+
+	print "Done."
+	print
+	print "Starting to pair."
+	adapter2.CreatePairedDevice(adapter1_address, agent2_path,
+					"DisplayYesNo",
+					reply_handler=create_device_reply,
+					error_handler=create_device_error)
+
+	mainloop.run()
-- 
1.7.0.4

