Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v1 12/16] test: Use ObjectManager instead of Adapters property
Date: Thu, 15 Nov 2012 16:09:15 +0100
Message-Id: <1352992159-11559-13-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1352992159-11559-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1352992159-11559-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Use the objects and interfaces reported by the ObjectManager in order
to list the available adapters.
---
 test/test-health      | 11 ++++++++---
 test/test-health-sink | 12 +++++++++---
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/test/test-health b/test/test-health
index 21d1776..9d2f62f 100755
--- a/test/test-health
+++ b/test/test-health
@@ -131,10 +131,15 @@ if not con:
 	enter_mainloop()
 	sys.exit()
 
-manager = dbus.Interface(bus.get_object("org.bluez", "/org/bluez"),
-						"org.bluez.Manager")
+manager = dbus.Interface(bus.get_object("org.bluez", "/"),
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
index 7bf1af4..a886d85 100755
--- a/test/test-health-sink
+++ b/test/test-health-sink
@@ -21,10 +21,16 @@ app_path = hdp_manager.CreateApplication({"DataType": dbus.types.UInt16(4103),
 
 print(app_path)
 
-manager = dbus.Interface(bus.get_object("org.bluez", "/org/bluez"),
-						"org.bluez.Manager")
+manager = dbus.Interface(bus.get_object("org.bluez", "/"),
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

