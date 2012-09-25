Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH v8 01/13] Heart Rate Profile (HRP) client API
Date: Tue, 25 Sep 2012 16:27:34 +0200
Message-ID: <1348583267-16816-2-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1348583267-16816-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1348583267-16816-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Santiago Carot-Nemesio <sancane@gmail.com>

---
 doc/heartrate-api.txt | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 doc/heartrate-api.txt

diff --git a/doc/heartrate-api.txt b/doc/heartrate-api.txt
new file mode 100644
index 0000000..1fa9d0b
--- /dev/null
+++ b/doc/heartrate-api.txt
@@ -0,0 +1,84 @@
+Heart Rate API description
+****************************************
+
+Copyright (C) 2012	Santiago Carot-Nemesio <sancane@gmail.com>
+Copyright (C) 2012	Tieto Poland
+
+Heart Rate Manager hierarchy
+============================
+
+Service		org.bluez
+Interface	org.bluez.HeartRateManager
+Object path	[variable prefix]/{hci0,hci1,...}
+
+Methods		RegisterWatcher(object agent)
+
+			Registers a watcher to monitor heart rate measurements.
+
+			Possible Errors: org.bluez.Error.InvalidArguments
+
+		UnregisterWatcher(object agent)
+
+			Unregisters a watcher.
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
+		Reset()
+
+			Restart the accumulation of energy expended from zero.
+
+			Possible Errors: org.bluez.Error.NotSupported
+
+Properties	String Location (optional) [readonly]
+
+			Possible values: "Other", "Chest", "Wrist","Finger",
+					"Hand", "Earlobe", "Foot"
+
+		boolean ResetSupported [readonly]
+
+			True if energy expended is supported.
+
+Heart Rate Watcher hierarchy
+
+============================
+Service		unique name
+Interface	org.bluez.HeartRateWatcher
+Object path	freely definable
+
+Methods		void MeasurementReceived(object device, dict measurement)
+
+			This callback is called whenever a heart rate
+			measurement is received from the heart rate device.
+
+			Measurement:
+
+				uint16 Value:
+
+					Measurement value expressed in beats per
+					minute (bpm)
+
+				uint16 Energy (optional):
+
+					Accumulated energy expended in kilo Joules
+
+				boolean Contact (optional):
+
+					true if skin contact is detected by sensor,
+					false otherwise
+
+				array{uint16} Interval (optional):
+
+					RR-Interval values which represent the time
+					between two consecutive R waves in an ECG.
+					Values are ordered starting from oldest to
+					most recent.
-- 
1.7.11.3

