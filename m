Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ] Add support for listing all adapters using test-adapter
Date: Tue, 16 Aug 2011 18:58:52 -0300
Message-Id: <1313531932-10944-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/test-adapter |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/test/test-adapter b/test/test-adapter
index 00ef6f5..33bdd47 100755
--- a/test/test-adapter
+++ b/test/test-adapter
@@ -29,6 +29,7 @@ if (len(args) < 1):
 	print "Usage: %s <command>" % (sys.argv[0])
 	print ""
 	print "  address"
+	print "  list"
 	print "  name [name]"
 	print "  powered [on/off]"
 	print "  pairable [on/off]"
@@ -51,6 +52,22 @@ if (args[0] == "name"):
 		adapter.SetProperty("Name", args[1])
 	sys.exit(0)
 
+if (args[0] == "list"):
+	if (len(args) < 2):
+		properties = manager.GetProperties()
+		for adapter_path in properties["Adapters"]:
+			adapter = dbus.Interface(bus.get_object("org.bluez", adapter_path),
+													"org.bluez.Adapter")
+			prop = adapter.GetProperties()
+			print " [ %s ]" % (adapter_path)
+			for (key, value) in prop.iteritems():
+				if (key == "Class"):
+					print "    %s = 0x%06x" % (key, value)
+				else:
+					print "    %s = %s" % (key, value)
+			print
+	sys.exit(0)
+
 if (args[0] == "powered"):
 	if (len(args) < 2):
 		properties = adapter.GetProperties()
-- 
1.7.6

