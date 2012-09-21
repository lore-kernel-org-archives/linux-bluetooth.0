Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH] Cycling Speed and Cadence profile (CSCP) API
Date: Fri, 21 Sep 2012 11:09:21 +0200
Message-ID: <1348218561-24509-2-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1348218561-24509-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1348218561-24509-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/cycling-api.txt | 112 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)
 create mode 100644 doc/cycling-api.txt

diff --git a/doc/cycling-api.txt b/doc/cycling-api.txt
new file mode 100644
index 0000000..5988cac
--- /dev/null
+++ b/doc/cycling-api.txt
@@ -0,0 +1,112 @@
+Cycling Speed and Cadence API description
+****************************************
+
+Copyright (C) 2012	Tieto Poland
+
+Cycling Manager hierarchy
+============================
+
+Service		org.bluez
+Interface	org.bluez.CyclingManager
+Object path	[variable prefix]/{hci0,hci1,...}
+
+Methods		RegisterWatcher(object agent)
+
+			Registers a watcher to monitor cycling speed and cadence
+			measurements.
+
+			Possible Errors: org.bluez.Error.InvalidArguments
+
+		UnregisterWatcher(object agent)
+
+			Unregisters a watcher.
+
+Cycling Speed and Cadence Profile hierarchy
+============================
+
+Service		org.bluez
+Interface	org.bluez.Cycling
+Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
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
+		SetCumulativeWheelRevolutions(uint32 value)
+
+			Sets cumulative wheel revolutions value if
+			Cumulative Wheel Revolutions feature is supported.
+
+			Possible Errors: org.bluez.Error.NotSupported
+
+Signals		PropertyChanged(string name, variant value)
+
+			This signal indicates a changed value of the given
+			property.
+
+Properties	String Location (optional) [readwrite]
+
+			Current sensor location, if supported.
+			If Multiple Sensor Locations feature is supported,
+			this property can be set to one of values read from
+			SupportedLocations property.
+
+			Possible values: "Other", "Top of shoe", "In shoe",
+					"Hip", "Front Wheel", "Left Crank",
+					"Right Crank", "Left Pedal",
+					"Right Pedal", "Front Hub",
+					"Rear Dropout", "Chainstay",
+					"Rear Wheel", "Rear Hub"
+
+		array{string} SupportedLocations (optional) [readonly]
+
+			List of locations supported by sensor, only present
+			if Multiple Sensor Locations feature is supported.
+
+		boolean WheelRevolutionDataSupported [readonly]
+
+			true if sensor can read and set Cumulative Wheel
+			Revolutions value, false otherwise.
+
+		boolean MultipleSensorLocationsSupported [readonly]
+
+			true if sensor supports Multiple Sensor Locations
+			feature and can set Location, false otherwise.
+
+Cycling Speed and Cadence Watcher hierarchy
+============================
+Service		unique name
+Interface	org.bluez.CyclingWatcher
+Object path	freely definable
+
+Methods		void MeasurementReceived(object device, dict measurement)
+
+			This callback is called whenever a cycling speed and
+			cadence measurement is received from sensor.
+
+			Measurement:
+
+				uint32 WheelRevolutions (optional):
+
+					Cumulative number of wheel revolutions
+
+				uint16 LastWheelEventTime (optional):
+
+					Value of Last Wheel Event time
+
+				uint16 CrankRevolutions (optional):
+
+					Cumulative number of crank revolutions
+
+				uint16 LastCrankEventTime (optional):
+
+					Value of Last Crank Event time
-- 
1.7.11.3

