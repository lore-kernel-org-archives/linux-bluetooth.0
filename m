Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH] Heart Rate Profile API
Date: Fri, 17 Feb 2012 11:37:30 +0100
Message-Id: <1329475050-2710-2-git-send-email-sancane@gmail.com>
In-Reply-To: <1329475050-2710-1-git-send-email-sancane@gmail.com>
References: <1329475050-2710-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/heartrate-api.txt |   58 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 58 insertions(+), 0 deletions(-)
 create mode 100644 doc/heartrate-api.txt

diff --git a/doc/heartrate-api.txt b/doc/heartrate-api.txt
new file mode 100644
index 0000000..692e8b8
--- /dev/null
+++ b/doc/heartrate-api.txt
@@ -0,0 +1,58 @@
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
+Methods		RegisterWatcher(object agent)
+
+			Registers a heart reat watcher to monitor scanned
+			measurements.
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
+Heart Rate Watcher hierarchy
+============================
+Service		unique name
+Interface	org.bluez.HeartRateWatcher
+Object path	freely definable
+
+Methods		void MeasurementReceived(dict measure)
+
+			This callback gets called whenever a measure is scanned
+			from the heart rate device. The units for the Value is
+			expressed in beats per minute (bpm). The energy field is
+			optional and it represents the accumulated energy
+			expended in kilo Joules since last time it was reset.
+			Furthermore, the device will be automatically reset when
+			it is needed.
+			The Contact field, when it's present, indicates that the
+			device support contact sensor, besides it will be true
+			if skin contact is detected. The interval field is also
+			optional, it's an array containing RR-Interval values
+			wich represents the time between two R-Wave detections,
+			where the RR-Interval Value 0 is older than the Value 1
+			and so on.
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

