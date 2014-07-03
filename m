Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/2] test: Fix getting devices in health test scripts
Date: Thu,  3 Jul 2014 16:32:55 +0200
Message-Id: <1404397976-7940-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/test-health      | 12 +++++++++++-
 test/test-health-sink | 12 +++++++++++-
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/test/test-health b/test/test-health
index 343f29c..24afa79 100755
--- a/test/test-health
+++ b/test/test-health
@@ -170,7 +170,17 @@ while select == None:
 
 adapter = dbus.Interface(bus.get_object(BUS_NAME, select), ADAPTER_INTERFACE)
 
-devices = adapter.GetProperties()["Devices"]
+devices = []
+for path, interfaces in objects.iteritems():
+	if "org.bluez.Device1" not in interfaces:
+		continue
+	properties = interfaces["org.bluez.Device1"]
+	if properties["Adapter"] != select:
+		continue;
+
+	if HEALTH_DEVICE_INTERFACE not in interfaces:
+		continue
+	devices.append(path)
 
 if len(devices) == 0:
 	print("No devices available")
diff --git a/test/test-health-sink b/test/test-health-sink
index 52be535..2343a23 100755
--- a/test/test-health-sink
+++ b/test/test-health-sink
@@ -61,7 +61,17 @@ while select == None:
 adapter =  dbus.Interface(bus.get_object(BUS_NAME, select),
 						ADAPTER_INTERFACE)
 
-devices = adapter.GetProperties()["Devices"]
+devices = []
+for path, interfaces in objects.iteritems():
+	if "org.bluez.Device1" not in interfaces:
+		continue
+	properties = interfaces["org.bluez.Device1"]
+	if properties["Adapter"] != select:
+		continue;
+
+	if HEALTH_DEVICE_INTERFACE not in interfaces:
+		continue
+	devices.append(path)
 
 if len(devices) == 0:
 	print("No devices available")
-- 
1.9.1

