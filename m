Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v2] serial: Remove serial proxy test script
Date: Tue, 24 Jul 2012 10:11:00 -0300
Message-Id: <1343135460-26176-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1342715766-22943-2-git-send-email-claudio.takahasi@openbossa.org>
References: <1342715766-22943-2-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.tools         |    9 +++---
 test/test-serial-proxy |   66 ------------------------------------------------
 2 files changed, 4 insertions(+), 71 deletions(-)
 delete mode 100755 test/test-serial-proxy

diff --git a/Makefile.tools b/Makefile.tools
index 4c70db1..5579b86 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -222,8 +222,7 @@ EXTRA_DIST += test/sap_client.py test/hsplay test/hsmicro \
 		test/test-network test/simple-agent test/simple-service \
 		test/simple-endpoint test/test-audio test/test-input \
 		test/test-sap-server test/test-oob test/test-attrib \
-		test/test-proximity test/test-thermometer \
-		test/test-serial-proxy test/test-health test/test-health-sink \
-		test/service-record.dtd test/service-did.xml \
-		test/service-spp.xml test/service-opp.xml test/service-ftp.xml \
-		test/simple-player test/test-nap
+		test/test-proximity test/test-thermometer test/test-health \
+		test/test-health-sink test/service-record.dtd \
+		test/service-did.xml test/service-spp.xml test/service-opp.xml \
+		test/service-ftp.xml test/simple-player test/test-nap
diff --git a/test/test-serial-proxy b/test/test-serial-proxy
deleted file mode 100755
index 7963f23..0000000
--- a/test/test-serial-proxy
+++ /dev/null
@@ -1,66 +0,0 @@
-#!/usr/bin/python
-
-from __future__ import absolute_import, print_function, unicode_literals
-
-import sys
-import time
-import dbus
-import socket
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
-	print("Usage: %s <socket_name> [service]" % (sys.argv[0]))
-	sys.exit(1)
-
-socket_name = args[0]
-
-if (len(args) < 2):
-	service = "spp"
-else:
-	service = args[1]
-
-sk = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
-sk.bind(socket_name)
-sk.listen(1)
-
-proxy_manager = dbus.Interface(bus.get_object("org.bluez", adapter_path),
-						"org.bluez.SerialProxyManager")
-proxy_path = proxy_manager.CreateProxy(service, socket_name)
-
-proxy = dbus.Interface(bus.get_object("org.bluez", proxy_path),
-							"org.bluez.SerialProxy")
-proxy.Enable()
-
-conn, addr = sk.accept()
-
-print("Waiting for message")
-
-while 1:
-	data = conn.recv(1024)
-	if data:
-		print(data)
-		break
-
-proxy.Disable()
-proxy_manager.RemoveProxy(proxy_path)
-conn.close()
-- 
1.7.8.6

