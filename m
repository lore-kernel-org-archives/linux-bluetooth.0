Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH -v2 23/28] test: add test-audiosource
Date: Wed,  4 Jul 2012 10:17:42 +0200
Message-Id: <1341389867-30749-24-git-send-email-gustavo@padovan.org>
In-Reply-To: <1341389867-30749-1-git-send-email-gustavo@padovan.org>
References: <1341389867-30749-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

---
 Makefile.tools        |    2 +-
 test/test-audiosource |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 1 deletion(-)
 create mode 100644 test/test-audiosource

diff --git a/Makefile.tools b/Makefile.tools
index e4cf238..3cfc6f3 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -222,4 +222,4 @@ EXTRA_DIST += test/sap-client test/hsplay test/hsmicro \
 		test/test-serial-proxy test/test-health test/test-health-sink \
 		test/service-record.dtd test/service-did.xml \
 		test/service-spp.xml test/service-opp.xml test/service-ftp.xml \
-		test/simple-player test/test-nap
+		test/simple-player test/test-nap test/test-audiosource
diff --git a/test/test-audiosource b/test/test-audiosource
new file mode 100644
index 0000000..c89ff7c
--- /dev/null
+++ b/test/test-audiosource
@@ -0,0 +1,46 @@
+#!/usr/bin/python
+
+import sys
+import dbus
+from optparse import OptionParser, make_option
+
+bus = dbus.SystemBus()
+
+manager = dbus.Interface(bus.get_object("org.bluez", "/"), "org.bluez.Manager")
+
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
+if len(args) < 2:
+	print """Usage: %s <command>
+
+	connect <bdaddr>
+	disconnect <bdaddr>
+	""" % sys.argv[0]
+	sys.exit(1)
+
+device = adapter.FindDevice(args[1])
+audio = dbus.Interface(bus.get_object("org.bluez", device),
+				"org.bluez.AudioSource")
+
+if args[0] == "connect":
+	audio.Connect()
+elif args[0] == "disconnect":
+	audio.Disconnect()
+else:
+	print "Unknown command"
+	sys.exit(1)
+
-- 
1.7.10.2

