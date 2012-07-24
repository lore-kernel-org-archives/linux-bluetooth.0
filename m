Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v2] serial: Remove serial test script
Date: Tue, 24 Jul 2012 10:08:41 -0300
Message-Id: <1343135321-26066-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <20120724093458.GA8836@x220.ice.intel.com>
References: <20120724093458.GA8836@x220.ice.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.tools   |   10 ++++----
 test/test-serial |   58 ------------------------------------------------------
 2 files changed, 5 insertions(+), 63 deletions(-)
 delete mode 100755 test/test-serial

diff --git a/Makefile.tools b/Makefile.tools
index fccac2d..4c70db1 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -218,11 +218,11 @@ endif
 EXTRA_DIST += test/sap_client.py test/hsplay test/hsmicro \
 		test/dbusdef.py test/monitor-bluetooth test/list-devices \
 		test/test-discovery test/test-manager test/test-adapter \
-		test/test-device test/test-service test/test-serial \
-		test/test-telephony test/test-network test/simple-agent \
-		test/simple-service test/simple-endpoint test/test-audio \
-		test/test-input test/test-sap-server test/test-oob \
-		test/test-attrib test/test-proximity test/test-thermometer \
+		test/test-device test/test-service test/test-telephony \
+		test/test-network test/simple-agent test/simple-service \
+		test/simple-endpoint test/test-audio test/test-input \
+		test/test-sap-server test/test-oob test/test-attrib \
+		test/test-proximity test/test-thermometer \
 		test/test-serial-proxy test/test-health test/test-health-sink \
 		test/service-record.dtd test/service-did.xml \
 		test/service-spp.xml test/service-opp.xml test/service-ftp.xml \
diff --git a/test/test-serial b/test/test-serial
deleted file mode 100755
index 8858dbd..0000000
--- a/test/test-serial
+++ /dev/null
@@ -1,58 +0,0 @@
-#!/usr/bin/python
-
-from __future__ import absolute_import, print_function, unicode_literals
-
-import sys
-import time
-import dbus
-from optparse import OptionParser, make_option
-
-bus = dbus.SystemBus()
-
-manager = dbus.Interface(bus.get_object("org.bluez", "/"),
-						"org.bluez.Manager")
-option_list = [
-		make_option("-i", "--device", action="store",
-				type="string", dest="dev_id"),
-		]
-parser = OptionParser(option_list=option_list)
-
-(options, args) = parser.parse_args()
-
-if options.dev_id:
-	adapter_path = manager.FindAdapter(options.dev_id)
-else:
-	adapter_path = manager.DefaultAdapter()
-
-adapter = dbus.Interface(bus.get_object("org.bluez", adapter_path),
-							"org.bluez.Adapter")
-
-if (len(args) < 1):
-	print("Usage: %s <address> [service]" % (sys.argv[0]))
-	sys.exit(1)
-
-address = args[0]
-
-if (len(args) < 2):
-	service = "spp"
-else:
-	service = args[1]
-
-path = adapter.FindDevice(address)
-
-serial = dbus.Interface(bus.get_object("org.bluez", path),
-						"org.bluez.Serial")
-
-node = serial.Connect(service)
-
-print("Connected %s to %s" % (node, address))
-
-print("Press CTRL-C to disconnect")
-
-try:
-	time.sleep(1000)
-	print("Terminating connection")
-except:
-	pass
-
-serial.Disconnect(node)
-- 
1.7.8.6

