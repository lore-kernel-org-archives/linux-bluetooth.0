Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v2] Cycling Speed and Cadence profile (CSCP) API
Date: Tue, 25 Sep 2012 17:07:27 +0200
Message-ID: <1348585647-25458-2-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1348585647-25458-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1348585647-25458-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/cycling-api.txt | 117 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)
 create mode 100644 doc/cycling-api.txt

diff --git a/doc/cycling-api.txt b/doc/cycling-api.txt
new file mode 100644
index 0000000..6186fe1
--- /dev/null
+++ b/doc/cycling-api.txt
@@ -0,0 +1,117 @@
+Cycling Speed and Cadence API description
+****************************************
+
+Copyright (C) 2012	Tieto Poland
+
+Cycling Speed and Cadence Manager hierarchy
+============================
+
+Service		org.bluez
+Interface	org.bluez.CyclingSpeedManager
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
+Interface	org.bluez.CyclingSpeed
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
+Properties	string Location (optional) [readwrite]
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
+Interface	org.bluez.CyclingSpeedWatcher
+Object path	freely definable
+
+Methods		void MeasurementReceived(object device, dict measurement)
+
+			This callback is called whenever wheel and/or crank
+			revolutions measurement is received from sensor.
+
+			Measurement:
+
+				uint32 WheelRevolutions (optional):
+
+					Cumulative number of wheel revolutions.
+
+				uint16 LastWheelEventTime (optional):
+
+					Time of last event from wheel sensor.
+					Value is expressed in 1/1024 second
+					units and can roll over during a ride.
+
+				uint16 CrankRevolutions (optional):
+
+					Cumulative number of crank revolutions.
+					This value can occasionally roll over.
+
+				uint16 LastCrankEventTime (optional):
+
+					Time of last event from crank sensor.
+					Value is expressed in 1/1024 second
+					units and can roll over during a ride.
-- 
1.7.11.3

