Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ] serial: Remove serial proxy test script
Date: Thu, 19 Jul 2012 13:36:06 -0300
Message-Id: <1342715766-22943-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1342715766-22943-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1342715766-22943-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/test-serial-proxy |   66 ------------------------------------------------
 1 files changed, 0 insertions(+), 66 deletions(-)
 delete mode 100755 test/test-serial-proxy

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

