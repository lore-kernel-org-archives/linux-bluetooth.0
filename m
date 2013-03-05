Return-Path: <cyrus@holtmann.org>
Message-ID: <5135D965.8020604@tieto.com>
Date: Tue, 5 Mar 2013 12:39:17 +0100
From: Rymarkiewicz Waldemar <waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC] bloodpressure: Add Blood Pressure API
References: <1360668097-28906-1-git-send-email-waldemar.rymarkiewicz@tieto.com> <C4340FC6-1121-468E-B15D-68E2770AA07E@holtmann.org>
In-Reply-To: <C4340FC6-1121-468E-B15D-68E2770AA07E@holtmann.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Marcel,

>> +Blood Pressure Manager hierarchy
>> +================================
>> +
>> +Serviceorg.bluez
>> +Interface	org.bluez.BloodPressureManager1
>> +Object path	[variable prefix]/{hci0,hci1,...}
>> +
>> +Methods		RegisterWatcher(object agent)
>
> I do not really this manager business anymore. Splitting the interface over adapter and device object seems pointless. What I like to see is that we make one interface on the device object. We should have no proper lifetime rules for these.
>
> Basically a client using a specialised interface should have to deal with one entry point and not with multiple. Low Energy clients need to pick a device they want to operate with. So this should focus on device objects and nothing else.
>

Is this what you mean?


diff --git a/doc/bloodpressure-api.txt b/doc/bloodpressure-api.txt
new file mode 100644
index 0000000..be18208
--- /dev/null
+++ b/doc/bloodpressure-api.txt
@@ -0,0 +1,127 @@
+Blood Pressure API description
+******************************
+
+Blood Pressure Profile hierarchy
+================================
+
+Service		org.bluez
+Interface	org.bluez.BloodPressure1
+Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
+
+Methods		RegisterWatcher(object watcher)
+
+			Registers a watcher to monitor blood pressure
+			measurements. This watcher will be notified about
+			final pressure measurements.
+
+			Possible Errors: org.bluez.Error.InvalidArguments
+
+		UnregisterWatcher(object watcher)
+
+			Unregisters a watcher.
+
+		EnableIntermediateMeasurement(object watcher)
+
+			Enables intermediate measurement notifications
+			for this watcher. Intermediate measurements will
+			be enabled only for devices which support it.
+
+			Possible Errors: org.bluez.Error.InvalidArguments
+					org.bluez.Error.NotSupported
+
+		DisableIntermediateMeasurement(object watcher)
+
+			Disables intermediate measurement notifications
+			for this watcher. It will disable notifications in
+			devices when the last watcher is removed for
+			intermediate measurements.
+
+			Possible Errors: org.bluez.Error.InvalidArguments
+					org.bluez.Error.NotFound
+
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
