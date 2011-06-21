Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [RFC] Health Thermometer Profile API
Date: Tue, 21 Jun 2011 15:03:28 +0200
Message-Id: <1308661408-8364-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/thermometer.txt |  111 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 111 insertions(+), 0 deletions(-)
 create mode 100644 doc/thermometer.txt

diff --git a/doc/thermometer.txt b/doc/thermometer.txt
new file mode 100644
index 0000000..4635fdf
--- /dev/null
+++ b/doc/thermometer.txt
@@ -0,0 +1,111 @@
+BlueZ D-Bus Thermomether API description
+****************************************
+
+	Santiago Carot-Nemesio <sancane@gmail.com>
+
+Health Thermomether Profile hierarchy
+=====================================
+
+Service		org.bluez
+Interface	org.bluez.Thermometer
+Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
+
+
+Methods		void SetProperty(string name, variant value)
+
+			Changes the value of the specified property. Only
+			read-write properties can be changed. On success
+			this will emit a PropertyChanged signal.
+
+			Possible Errors: org.bluez.Error.InvalidArguments
+
+		dict GetProperties()
+
+			Returns all properties for the interface. See the
+			Properties section for the available properties.
+
+		RegisterThermometerWatcher(object agent)
+
+			Register a watcher to monitor scanned measures.
+
+			The agent registered for the health thermometer
+			service will be notified about measures scanned.
+
+			Possible Errors: org.bluez.Error.InvalidArguments
+
+		UnregisterThermometerWatcher(object agent)
+
+			Unregister a watcher.
+
+			Final and intermediate temperatures won't be notified to
+			the agent any more.
+
+			Possible Errors: org.bluez.Error.InvalidArguments
+					org.bluez.Error.NotFound
+
+		EnableIntermediateMeasures(object agent)
+
+			Enable notifications about intermediate measures. Agent
+			should have registered a watcher for health thermometer
+			service before to enable this feature.
+
+			Possible Errors: org.bluez.Error.InvalidArguments
+					org.bluez.Error.NotAllowed
+
+		DisableIntermediateMeasures(object agent)
+
+			Disable intermediate temperatures. It will disable
+			intermediate measure notifications in the device when
+			the last agent disables this feature.
+
+			Possible Errors: org.bluez.Error.InvalidArguments
+					org.bluez.Error.NotFound
+
+Signals		PropertyChanged(string name, variant value)
+
+			This signal indicates a changed value of the given
+			property.
+
+Properties	uint16 Interval (optional) [readwrite]
+
+			The Measurement Interval defines the time (in seconds)
+			between measurements. This interval is not related to
+			the intermediates measures and must be defined into
+			a valid range. Setting it to zero meaning that no
+			periodic measurements will be taken.
+
+		uint16 Minimum (optional) [readonly]
+
+			Defines the maximum value allowed for the interval
+			between periodic measurements.
+
+		uint16 Maximum (optional) [readonly]
+
+			Defines the minimuum value allowed for the interval
+			between periodic measurements.
+
+
+Health Thermometer Watcher hierarchy
+====================================
+Service		unique name
+Interface	org.bluez.ThermometerWatcher
+Object path	freely definable
+
+Methods		void MeasureReceived(dict measure)
+
+			This callback gets called when a measure has been
+			scanned	in the thermometer. The Value entry corresponds
+			to IEEE-11073 32-bit FLOAT.The Time entry in the dict
+			will be only present if the device supports storing of
+			data. The time value is expressed in seconds since epoch.
+
+			Dict is defined as below:
+			{
+				"Value" : uint32,
+				"Unit" : ("Celsius" or "Fahrenheit"),
+				"Time" : uint64,
+				"Type" : ("Armpit", "Body", "Ear", "Finger",
+					"Intestines", "Mouth", "Rectum", "Toe",
+					"Tympanum"),
+				"Measurement" : ("Final" or "Intermediate"),
+			}
-- 
1.7.5.2

