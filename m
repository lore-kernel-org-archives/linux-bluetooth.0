Return-Path: <cyrus@holtmann.org>
From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Subject: [RFC] bloodpressure: Add Blood Pressure API
Date: Tue, 12 Feb 2013 12:21:37 +0100
Message-ID: <1360668097-28906-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Change-Id: I7165ecee0186dfdb51cd01838f28768d94ff12b9
---
 doc/bloodpressure-api.txt | 138 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 138 insertions(+)
 create mode 100644 doc/bloodpressure-api.txt

diff --git a/doc/bloodpressure-api.txt b/doc/bloodpressure-api.txt
new file mode 100644
index 0000000..2acc660
--- /dev/null
+++ b/doc/bloodpressure-api.txt
@@ -0,0 +1,138 @@
+Blood Pressure API description
+******************************
+
+
+Blood Pressure Manager hierarchy
+================================
+
+Serviceorg.bluez
+Interface	org.bluez.BloodPressureManager1
+Object path	[variable prefix]/{hci0,hci1,...}
+
+Methods		RegisterWatcher(object agent)
+
+			Registers a watcher to monitor blood pressure
+			measurements. This agent will be notified about
+			final pressure measurements.
+
+			Possible Errors: org.bluez.Error.InvalidArguments
+
+		UnregisterWatcher(object agent)
+
+			Unregisters a watcher.
+
+		EnableIntermediateMeasurement(object agent)
+
+			Enables intermediate measurement notifications
+			for this agent. Intermediate measurements will
+			be enabled only for devices which support it.
+
+			Possible Errors: org.bluez.Error.InvalidArguments
+
+		DisableIntermediateMeasurement(object agent)
+
+			Disables intermediate measurement notifications
+			for this agent. It will disable notifications in
+			devices when the last agent removes the
+			watcher for intermediate measurements.
+
+			Possible Errors: org.bluez.Error.InvalidArguments
+					org.bluez.Error.NotFound
+
+Blood Pressure Profile hierarchy
+================================
+
+Service		org.bluez
+Interface	org.bluez.BloodPressure1
+Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
+
+Properties	boolean Intermediate [readonly]
+
+			True if the device supports intermediate
+			measurement notifications.
+
+Blood Pressure Watcher hierarchy
+================================
+
+Service		unique name
+Interface	org.bluez.BloodPressureWatcher1
+Object path	freely definable
+
+Methods		void MeasurementReceived(object device, dict measurement)
+
+			This callback is called whenever a blood pressure
+			measurement is received from the blood pressure device.
+
+			Measurement:
+
+				string Measurement:
+
+					Posible values: "final" or
+							"intermediate"
+
+				uint16 CurrentCuffPressure:
+
+					Current cuff pressure value is only
+					present in intermediate measurement.
+
+				uint16 Systolic:
+
+					Systolic Blood Pressure value is only
+					present in final measurement.
+
+				uint16 Diastolic:
+
+					Diastolic Blood Pressure value is only
+					present in final final measurement.
+
+				uint16 Mean:
+
+					Mean Arterial Pressure value is only
+					present in final measurement.
+
+				string Unit:
+
+					The unit of blood pressure measurement.
+
+					Possible values: "mmHg" or "kPa".
+
+				uint64 Time (optional):
+
+					Time of measurement expresed in seconds
+					from epoch.
+
+				uint16 PulseRate (optional):
+
+					Pulse rate value.
+
+				uint8 UserID (optional):
+
+					User ID if the device supports
+					multiusers measurements.
+
+				boolean BodyMovement (optional)
+
+					True if body movement during
+					measurement has been detected.
+
+				boolean CuffTooLoose (optional)
+
+					True if too loose cuff during
+					measurement has been detected.
+
+				boolean IrregularPulse (optional)
+
+					True if irrgular pulse during
+					measurement has been detected.
+
+				uint8 PulseRateNotInRange (optional)
+
+					Possible values:
+
+					0 - pulse rate exceeds upper limit
+					1 - pulse rate is less then lower limit
+
+				boolean MeasurementPosition (optional)
+
+					True if improper measurement position
+					has been detected.
-- 
1.8.0.209.gf3828dc

