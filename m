Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [BlueZ PATCH] Health Thermometer Profile API
Date: Mon,  4 Jul 2011 11:07:38 +0200
Message-Id: <1309770458-4112-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/interactive.c |    2 +
 doc/thermometer.txt  |  126 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 128 insertions(+), 0 deletions(-)
 create mode 100644 doc/thermometer.txt

diff --git a/attrib/interactive.c b/attrib/interactive.c
index a772362..0e4bb1e 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -811,6 +811,8 @@ int interactive(const gchar *src, const gchar *dst, int psm)
 	opt_dst = g_strdup(dst);
 	opt_psm = psm;
 
+	printf("src: %s, dst: %s, psm %d\n", src, dst, psm);
+
 	prompt = g_string_new(NULL);
 
 	event_loop = g_main_loop_new(NULL, FALSE);
diff --git a/doc/thermometer.txt b/doc/thermometer.txt
new file mode 100644
index 0000000..6392d39
--- /dev/null
+++ b/doc/thermometer.txt
@@ -0,0 +1,126 @@
+BlueZ D-Bus Thermometer API description
+****************************************
+
+	Santiago Carot-Nemesio <sancane@gmail.com>
+
+Health Thermometer Profile hierarchy
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
+		RegisterWatcher(object agent)
+
+			Registers a watcher to monitor scanned measurements.
+			This agent will be notified about final temperature
+			measurements.
+
+			Possible Errors: org.bluez.Error.InvalidArguments
+
+		UnregisterWatcher(object agent)
+
+			Unregisters a watcher.
+
+			Final and intermediate temperatures won't be notified to
+			this agent any more.
+
+			Possible Errors: org.bluez.Error.InvalidArguments
+					org.bluez.Error.NotFound
+
+		EnableIntermediateMeasurement(object agent)
+
+			Enables intermediate measurement notifications for this
+			agent if the thermometer supports it.
+
+			Possible Errors: org.bluez.Error.InvalidArguments
+					org.bluez.Error.NotSupported
+
+		DisableIntermediateMeasurement(object agent)
+
+			Disables intermediate measurement notifications for this
+			agent. It will disable notifications in the thermometer
+			when the last agent removes the watcher for intermediate
+			measurements.
+
+			Possible Errors: org.bluez.Error.InvalidArguments
+					org.bluez.Error.NotFound
+
+Signals		PropertyChanged(string name, variant value)
+
+			This signal indicates a changed value of the given
+			property.
+
+Properties	boolean Intermediate [readonly]
+
+			True if the thermometer supports intermediate measurement
+			notifications.
+
+		uint16 Interval (optional) [readwrite]
+
+			The Measurement Interval defines the time (in seconds)
+			between measurements. This interval is not related to
+			the intermediate measurements and must be defined into
+			a valid range. Setting it to zero means that no periodic
+			measurements will be taken.
+
+		uint16 Maximum (optional) [readonly]
+
+			Defines the maximum value allowed for the interval
+			between periodic measurements.
+
+		uint16 Minimum (optional) [readonly]
+
+			Defines the minimum value allowed for the interval
+			between periodic measurements.
+
+
+Health Thermometer Watcher hierarchy
+====================================
+Service		unique name
+Interface	org.bluez.ThermometerWatcher
+Object path	freely definable
+
+Methods		void MeasurementReceived(dict measure)
+
+			This callback gets called when a measure has been
+			scanned	in the thermometer. The Time entry in the dict
+			will be only present if the device supports storing of
+			data. The time value is expressed in seconds since epoch.
+			The value represented is (mantissa) x (10**exponent)
+			See foot note for special values when treating with
+			health devices.
+
+			Dict is defined as below:
+			{
+				"Exponent" : int8,
+				"Mantissa" : int32,
+				"Unit" : ("Celsius" or "Fahrenheit"),
+				"Time" : uint64,
+				"Type" : ("Armpit", "Body", "Ear", "Finger",
+					"Intestines", "Mouth", "Rectum", "Toe",
+					"Tympanum"),
+				"Measurement" : ("Final" or "Intermediate"),
+			}
+
+			For special cases, the exponent shall always be zero and
+			the mantissa should be one of following values:
+
+			NRes = -(2**23)
+			NaN = +(2**23-1)
+			INFINITY = (2**23-2)
+			-INFINITY = -(2**23-2)
-- 
1.7.6

