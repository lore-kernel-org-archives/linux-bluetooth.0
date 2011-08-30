Return-Path: <cyrus@holtmann.org>
From: Bruno Dilly <bdilly@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Bruno Dilly <bdilly@profusion.mobi>
Subject: [PATCH -v2 3/3] Add test for serial proxy and serial proxy manager
Date: Tue, 30 Aug 2011 10:04:23 -0300
Message-Id: <1314709463-4712-1-git-send-email-bdilly@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.tools         |    2 +-
 test/test-serial-proxy |   64 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 1 deletions(-)
 create mode 100755 test/test-serial-proxy

diff --git a/Makefile.tools b/Makefile.tools
index 91599c6..6be1df8 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -209,7 +209,7 @@ EXTRA_DIST += test/apitest test/sap-client test/hsplay test/hsmicro \
 		test/test-input test/test-attrib test/test-proximity \
 		test/test-sap-server test/test-oob test/service-record.dtd \
 		test/service-did.xml test/service-spp.xml \
-		test/service-opp.xml test/service-ftp.xml
+		test/service-opp.xml test/service-ftp.xml test/test-serial-proxy
 
 
 if HIDD
diff --git a/test/test-serial-proxy b/test/test-serial-proxy
new file mode 100755
index 0000000..f6dbd6c
--- /dev/null
+++ b/test/test-serial-proxy
@@ -0,0 +1,64 @@
+#!/usr/bin/python
+
+import sys
+import time
+import dbus
+import socket
+from optparse import OptionParser, make_option
+
+bus = dbus.SystemBus()
+
+manager = dbus.Interface(bus.get_object("org.bluez", "/"),
+						"org.bluez.Manager")
+option_list = [
+		make_option("-i", "--device", action="store",
+				type="string", dest="dev_id"),
+		]
+parser = OptionParser(option_list=option_list)
+
+(options, args) = parser.parse_args()
+
+if options.dev_id:
+	adapter_path = manager.FindAdapter(options.dev_id)
+else:
+	adapter_path = manager.DefaultAdapter()
+
+adapter = dbus.Interface(bus.get_object("org.bluez", adapter_path),
+							"org.bluez.Adapter")
+
+if (len(args) < 1):
+	print "Usage: %s <socket_name> [service]" % (sys.argv[0])
+	sys.exit(1)
+
+socket_name = args[0]
+
+if (len(args) < 2):
+	service = "spp"
+else:
+	service = args[1]
+
+sk = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
+sk.bind(socket_name)
+sk.listen(1)
+
+proxy_manager = dbus.Interface(bus.get_object("org.bluez", adapter_path),
+						"org.bluez.SerialProxyManager")
+proxy_path = proxy_manager.CreateProxy(service, socket_name)
+
+proxy = dbus.Interface(bus.get_object("org.bluez", proxy_path),
+							"org.bluez.SerialProxy")
+proxy.Enable()
+
+conn, addr = sk.accept()
+
+print "Waiting for message"
+
+while 1:
+	data = conn.recv(1024)
+	if data:
+		print(data)
+		break
+
+proxy.Disable()
+proxy_manager.RemoveProxy(proxy_path)
+conn.close()
-- 
1.7.4.1

