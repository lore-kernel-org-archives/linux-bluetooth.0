Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 06/14] thermometer: Update test script
Date: Tue, 25 Sep 2012 16:52:35 +0200
Message-ID: <1348584763-22824-7-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1348584763-22824-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1348584763-22824-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/test-thermometer | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/test/test-thermometer b/test/test-thermometer
index 9216264..2ca260f 100755
--- a/test/test-thermometer
+++ b/test/test-thermometer
@@ -16,9 +16,9 @@ from optparse import OptionParser, make_option
 
 class Watcher(dbus.service.Object):
 	@dbus.service.method("org.bluez.ThermometerWatcher",
-					in_signature="a{sv}", out_signature="")
-	def MeasurementReceived(self, measure):
-		print(measure["Measurement"], " measurement received")
+					in_signature="oa{sv}", out_signature="")
+	def MeasurementReceived(self, device, measure):
+		print("%s measurement received from %s" % (measure["Measurement"], device))
 		print("Exponent: ", measure["Exponent"])
 		print("Mantissa: ", measure["Mantissa"])
 		print("Unit: ", measure["Unit"])
@@ -66,23 +66,23 @@ if __name__ == "__main__":
 	adapter = dbus.Interface(bus.get_object("org.bluez", adapter_path),
 							"org.bluez.Adapter")
 
+	thermometer_manager = dbus.Interface(bus.get_object("org.bluez",
+				adapter_path), "org.bluez.ThermometerManager")
+
 	device_path = adapter.FindDevice(options.address)
 
 	bus.add_signal_receiver(property_changed, bus_name="org.bluez",
 				dbus_interface="org.bluez.Thermometer",
 				signal_name="PropertyChanged")
 
-	thermometer = dbus.Interface(bus.get_object("org.bluez",
-					device_path), "org.bluez.Thermometer")
-
 	path = "/test/watcher"
 	watcher = Watcher(bus, path)
 
-	thermometer.RegisterWatcher(path)
+	thermometer_manager.RegisterWatcher(path)
 
 	if len(args) > 0:
 		if args[0] == "EnableIntermediateMeasurement":
-			thermometer.EnableIntermediateMeasurement(path)
+			thermometer_manager.EnableIntermediateMeasurement(path)
 		else:
 			print("unknown command")
 			sys.exit(1)
-- 
1.7.11.3

