Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [RFC 18/18] doc: Rename cycling API to cyclingspeed
Date: Thu, 25 Oct 2012 16:43:48 +0200
Message-ID: <1351176228-5789-19-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1351176228-5789-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1351176228-5789-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/cycling-api.txt      | 100 -----------------------------------------------
 doc/cyclingspeed-api.txt | 100 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+), 100 deletions(-)
 delete mode 100644 doc/cycling-api.txt
 create mode 100644 doc/cyclingspeed-api.txt

diff --git a/doc/cycling-api.txt b/doc/cycling-api.txt
deleted file mode 100644
index 08e11c8..0000000
--- a/doc/cycling-api.txt
+++ /dev/null
@@ -1,100 +0,0 @@
-Cycling Speed and Cadence API description
-*****************************************
-
-Copyright (C) 2012	Tieto Poland
-
-Cycling Speed and Cadence Manager hierarchy
-===========================================
-
-Service		org.bluez
-Interface	org.bluez.CyclingSpeedManager
-Object path	[variable prefix]/{hci0,hci1,...}
-
-Methods		RegisterWatcher(object agent)
-
-			Registers a watcher to monitor cycling speed and
-			cadence measurements.
-
-			Possible Errors: org.bluez.Error.InvalidArguments
-
-		UnregisterWatcher(object agent)
-
-			Unregisters a watcher.
-
-Cycling Speed and Cadence Profile hierarchy
-===========================================
-
-Service		org.bluez
-Interface	org.bluez.CyclingSpeed
-Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
-
-Methods		SetCumulativeWheelRevolutions(uint32 value)
-
-			Sets cumulative wheel revolutions value if
-			Cumulative Wheel Revolutions feature is supported.
-
-			Possible Errors: org.bluez.Error.NotSupported
-
-Properties	string Location (optional) [readwrite]
-
-			Current sensor location, if supported.
-			If Multiple Sensor Locations feature is supported,
-			this property can be set to one of values read from
-			SupportedLocations property.
-
-			Possible values: "other", "top-of-shoe", "in-shoe",
-					"hip", "front-wheel", "left-crank",
-					"right-crank", "left-pedal",
-					"right-pedal", "front-hub",
-					"rear-dropout", "chainstay",
-					"rear-wheel", "rear-hub"
-
-		array{string} SupportedLocations (optional) [readonly]
-
-			List of locations supported by sensor, only present
-			if Multiple Sensor Locations feature is supported.
-
-		boolean WheelRevolutionDataSupported [readonly]
-
-			true if sensor can read and set Cumulative Wheel
-			Revolutions value, false otherwise.
-
-		boolean MultipleSensorLocationsSupported [readonly]
-
-			true if sensor supports Multiple Sensor Locations
-			feature and can set Location, false otherwise.
-
-Cycling Speed and Cadence Watcher hierarchy
-===========================================
-
-Service		unique name
-Interface	org.bluez.CyclingSpeedWatcher
-Object path	freely definable
-
-Methods		void MeasurementReceived(object device, dict measurement)
-
-			This callback is called whenever wheel and/or crank
-			revolutions measurement is received from sensor.
-
-			Measurement:
-
-				uint32 WheelRevolutions (optional):
-
-					Cumulative number of wheel revolutions.
-
-				uint16 LastWheelEventTime (optional):
-
-					Time of last event from wheel sensor.
-					Value is expressed in 1/1024 second
-					units and can roll over during a ride.
-
-				uint16 CrankRevolutions (optional):
-
-					Cumulative number of crank revolutions.
-					This value can occasionally roll over.
-
-				uint16 LastCrankEventTime (optional):
-
-					Time of last event from crank sensor.
-					Value is expressed in 1/1024 second
-					units and can roll over during a ride.
diff --git a/doc/cyclingspeed-api.txt b/doc/cyclingspeed-api.txt
new file mode 100644
index 0000000..08e11c8
--- /dev/null
+++ b/doc/cyclingspeed-api.txt
@@ -0,0 +1,100 @@
+Cycling Speed and Cadence API description
+*****************************************
+
+Copyright (C) 2012	Tieto Poland
+
+Cycling Speed and Cadence Manager hierarchy
+===========================================
+
+Service		org.bluez
+Interface	org.bluez.CyclingSpeedManager
+Object path	[variable prefix]/{hci0,hci1,...}
+
+Methods		RegisterWatcher(object agent)
+
+			Registers a watcher to monitor cycling speed and
+			cadence measurements.
+
+			Possible Errors: org.bluez.Error.InvalidArguments
+
+		UnregisterWatcher(object agent)
+
+			Unregisters a watcher.
+
+Cycling Speed and Cadence Profile hierarchy
+===========================================
+
+Service		org.bluez
+Interface	org.bluez.CyclingSpeed
+Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
+
+Methods		SetCumulativeWheelRevolutions(uint32 value)
+
+			Sets cumulative wheel revolutions value if
+			Cumulative Wheel Revolutions feature is supported.
+
+			Possible Errors: org.bluez.Error.NotSupported
+
+Properties	string Location (optional) [readwrite]
+
+			Current sensor location, if supported.
+			If Multiple Sensor Locations feature is supported,
+			this property can be set to one of values read from
+			SupportedLocations property.
+
+			Possible values: "other", "top-of-shoe", "in-shoe",
+					"hip", "front-wheel", "left-crank",
+					"right-crank", "left-pedal",
+					"right-pedal", "front-hub",
+					"rear-dropout", "chainstay",
+					"rear-wheel", "rear-hub"
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
+===========================================
+
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
1.8.0

