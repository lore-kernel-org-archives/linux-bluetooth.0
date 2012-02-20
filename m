Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH] Heart Rate Profile API
Date: Mon, 20 Feb 2012 10:54:33 +0100
Message-Id: <1329731673-5878-2-git-send-email-sancane@gmail.com>
In-Reply-To: <1329731673-5878-1-git-send-email-sancane@gmail.com>
References: <1329731673-5878-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/heartrate-api.txt |   70 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 70 insertions(+), 0 deletions(-)
 create mode 100644 doc/heartrate-api.txt

diff --git a/doc/heartrate-api.txt b/doc/heartrate-api.txt
new file mode 100644
index 0000000..f90e90b
--- /dev/null
+++ b/doc/heartrate-api.txt
@@ -0,0 +1,70 @@
+BlueZ D-Bus Heart Rate API description
+****************************************
+
+	Santiago Carot-Nemesio <sancane@gmail.com>
+
+Heart Rate Profile hierarchy
+============================
+
+Service		org.bluez
+Interface	org.bluez.HeartRate
+Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
+
+Methods		dict GetProperties()
+
+			Returns all properties for the interface. See the
+			Properties section for the available properties.
+
+		RegisterWatcher(object agent)
+
+			Registers a watcher to monitor heart rate measurements.
+
+			Possible Errors: org.bluez.Error.InvalidArguments
+
+		UnregisterWatcher(object agent)
+
+			Unregisters a watcher.
+
+			Possible Errors: org.bluez.Error.InvalidArguments
+					org.bluez.Error.NotFound
+
+		Reset()
+			Restart the accumulation of energy expended from zero.
+
+			Possible Errors: org.bluez.Error.NotSupported
+
+Properties	boolean Reset [readonly]
+
+			True if energy expended is supportted.
+
+Heart Rate Watcher hierarchy
+============================
+Service		unique name
+Interface	org.bluez.HeartRateWatcher
+Object path	freely definable
+
+Methods		void MeasurementReceived(dict measure)
+
+			This callback is called whenever a heart rate measurement
+			is received from the heart rate device. The unit for the
+			Value is expressed in beats per minute (bpm). The energy
+			field is optional and represents the accumulated energy
+			expended in kilo Joules since last time it was resetted.
+			Furthermore, the device will be automatically resetted
+			when it is needed.
+			The Contact field, if present, indicates that the device
+			supports contact sensor, besides it will be true if skin
+			contact is detected. The optional interval field is an
+			array containing RR-Interval values which represent the
+			time between two R-Wave detections, where the RR-Interval
+			Value 0 is older than the Value 1 and so on.
+
+			Dict is defined as below:
+			{
+				"Value" : uint16,
+				"Energy" : uint16,
+				"Contact" : boolean,
+				"Location" : ("Other", "Chest", "Wrist","Finger",
+					"Hand", "Ear Lobe", "Foot"),
+				"Interval" : array{uint16}
+			}
\ No newline at end of file
-- 
1.7.9.1

