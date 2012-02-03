Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ] proximity: Fix Proximity API to match documentation
Date: Fri,  3 Feb 2012 09:42:56 -0400
Message-Id: <1328276576-2996-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Recently, the documented D-Bus interface for Proximity was changed to
prepare for the upcoming Proximity Reporter API.
---
 proximity/monitor.c |    2 +-
 test/test-proximity |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/proximity/monitor.c b/proximity/monitor.c
index 76020ee..7bf95a1 100644
--- a/proximity/monitor.c
+++ b/proximity/monitor.c
@@ -49,7 +49,7 @@
 #include "monitor.h"
 #include "textfile.h"
 
-#define PROXIMITY_INTERFACE "org.bluez.Proximity"
+#define PROXIMITY_INTERFACE "org.bluez.ProximityMonitor"
 
 #define ALERT_LEVEL_CHR_UUID 0x2A06
 #define POWER_LEVEL_CHR_UUID 0x2A07
diff --git a/test/test-proximity b/test/test-proximity
index 289908e..130590c 100755
--- a/test/test-proximity
+++ b/test/test-proximity
@@ -53,11 +53,11 @@ if __name__ == "__main__":
 	device_path = adapter.FindDevice(options.address)
 
 	bus.add_signal_receiver(property_changed, bus_name="org.bluez",
-				dbus_interface="org.bluez.Proximity",
+				dbus_interface="org.bluez.ProximityMonitor",
 				signal_name="PropertyChanged")
 
 	proximity = dbus.Interface(bus.get_object("org.bluez",
-					device_path), "org.bluez.Proximity")
+					device_path), "org.bluez.ProximityMonitor")
 
 	print "Proximity SetProperty('%s', '%s')" % (args[0], args[1])
 	proximity.SetProperty(args[0], args[1])
-- 
1.7.5.4

