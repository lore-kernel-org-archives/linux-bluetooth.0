Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v2 06/15] test: Use ObjectManager instead of Adapters property
Date: Thu, 29 Nov 2012 13:47:27 +0100
Message-Id: <1354193256-30610-7-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1354193256-30610-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1354193256-30610-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Use the objects and interfaces reported by the ObjectManager in order
to list the available adapters.
---
 test/test-health      |  9 +++++++--
 test/test-health-sink | 10 ++++++++--
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/test/test-health b/test/test-health
index a7df679..9d2f62f 100755
--- a/test/test-health
+++ b/test/test-health
@@ -132,9 +132,14 @@ if not con:
 	sys.exit()
 
 manager = dbus.Interface(bus.get_object("org.bluez", "/"),
-						"org.bluez.Manager")
+					"org.freedesktop.DBus.ObjectManager")
 
-adapters = manager.GetProperties()["Adapters"]
+objects = manager.GetManagedObjects()
+adapters = []
+
+for path, ifaces in objects.iteritems():
+	if ifaces.has_key("org.bluez.Adapter"):
+		adapters.append(path)
 
 i = 1
 for ad in adapters:
diff --git a/test/test-health-sink b/test/test-health-sink
index 333b2fb..a886d85 100755
--- a/test/test-health-sink
+++ b/test/test-health-sink
@@ -22,9 +22,15 @@ app_path = hdp_manager.CreateApplication({"DataType": dbus.types.UInt16(4103),
 print(app_path)
 
 manager = dbus.Interface(bus.get_object("org.bluez", "/"),
-						"org.bluez.Manager")
+					"org.freedesktop.DBus.ObjectManager")
+
+objects = manager.GetManagedObjects()
+adapters = []
+
+for path, ifaces in objects.iteritems():
+	if ifaces.has_key("org.bluez.Adapter"):
+		adapters.append(path)
 
-adapters = manager.GetProperties()["Adapters"]
 i = 1
 for ad in adapters:
 	print("%d. %s" % (i, ad))
-- 
1.7.11.7

