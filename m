Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 18/18] Add a "services" command to test-device
Date: Tue, 21 Dec 2010 19:26:40 -0200
Message-Id: <1292966800-6264-19-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1292966800-6264-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1292966800-6264-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This command adds a way to retrieve the Services property that each
device has.
---
 test/test-device |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/test/test-device b/test/test-device
index 06d7c46..154af19 100755
--- a/test/test-device
+++ b/test/test-device
@@ -34,6 +34,7 @@ if (len(args) < 1):
 	print "Usage: %s <command>" % (sys.argv[0])
 	print ""
 	print "  list"
+	print "  services <address>"
 	print "  create <address>"
 	print "  remove <address|path>"
 	print "  disconnect <address>"
@@ -190,5 +191,17 @@ if (args[0] == "blocked"):
 			device.SetProperty("Blocked", value)
 	sys.exit(0)
 
+if (args[0] == "services"):
+	if (len(args) < 2):
+		print "Need address parameter"
+	else:
+		path = adapter.FindDevice(args[1])
+		device = dbus.Interface(bus.get_object("org.bluez", path),
+							"org.bluez.Device")
+		properties = device.GetProperties()
+		for path in properties["Services"]:
+			print path
+	sys.exit(0)
+
 print "Unknown command"
 sys.exit(1)
-- 
1.7.3.4

