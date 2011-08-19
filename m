Return-Path: <cyrus@holtmann.org>
From: Bruno Dilly <bdilly@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Bruno Dilly <bdilly@profusion.mobi>
Subject: [PATCH 3/3] Add test for serial proxy and serial proxy manager
Date: Fri, 19 Aug 2011 19:10:42 -0300
Message-Id: <1313791842-32558-3-git-send-email-bdilly@profusion.mobi>
In-Reply-To: <1313791842-32558-1-git-send-email-bdilly@profusion.mobi>
References: <1313791842-32558-1-git-send-email-bdilly@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/test-serial-proxy |   64 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 64 insertions(+), 0 deletions(-)
 create mode 100755 test/test-serial-proxy

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

