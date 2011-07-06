Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ] Add Proximity API
Date: Wed,  6 Jul 2011 17:02:26 -0300
Message-Id: <1309982546-24830-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <CAKT1EBcZTnGUT2Fp_JPQSYWFcvb884OtVW16SioDfKMNhRCpnw@mail.gmail.com>
References: <CAKT1EBcZTnGUT2Fp_JPQSYWFcvb884OtVW16SioDfKMNhRCpnw@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Covers the Proximity Monitor for Link Loss, Tx Power and Immediate
Alert services. This first proposal considers that the connections
will be managed by the bluetoothd core based on the registered
connection callbacks.

Only one instance of Immediate Alert service is allowed, "Alert Level"
characteristic of this service is used by Find Me and Path Loss. Note
that "Alert Level" for Path Loss is a LOCAL property written in the
Immediate Alert service when the threshold is reached. For Find Me
the user/application needs to actively enable the alert in the Immediate
Alert service. Link Loss has it's own instance of Alert Level
characteristic.
---
 doc/proximity-api.txt |   78 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 78 insertions(+), 0 deletions(-)
 create mode 100644 doc/proximity-api.txt

diff --git a/doc/proximity-api.txt b/doc/proximity-api.txt
new file mode 100644
index 0000000..ed78fb5
--- /dev/null
+++ b/doc/proximity-api.txt
@@ -0,0 +1,78 @@
+BlueZ D-Bus Proximity API description
+***********************************
+
+Copyright (C) 2011  Claudio Takahasi <claudio.takahasi@openbossa.org>
+
+
+Proximity hierarchy
+=================
+
+Service		org.bluez
+Interface	org.bluez.ProximityMonitor
+Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
+
+Methods		dict GetProperties()
+
+			Returns all properties for the interface. See the
+			properties section for available properties.
+
+		void SetProperty(string name, variant value)
+
+			Changes the value of the specified property. Only
+			properties that are listed a read-write are changeable.
+			On success this will emit a PropertyChanged signal.
+
+			Possible Errors: org.bluez.Error.InvalidArguments
+
+Signals		PropertyChanged(string name, variant value)
+
+			This signal indicates a changed value of a given
+			property.
+
+Properties
+		uint8 PathLoss[readonly]
+
+			If Tx Power Service is available, this property value
+			will be reported on regular intervals when the peer is
+			connected. Range: 0 - 100. The number is a relative
+			value to represent inaccurately the signal strength,
+			where 0 represents out of range and 100 close to the
+			reporter.
+
+		string Threshold [readwrite]
+
+			Persistent property. Trigger for immediate alert.
+			Values: "low", "medium", "high". Enabled only if Tx
+			Power and Immediate Alert services are available in
+			the reporter. Controls when the immediate alert is
+			triggered in the reporter.
+
+		boolean ThresholdAlert[readonly]
+
+			Alert indicating that threshold has been reached or the
+			path loss returned to a value below the threshold. It is
+			up to the implementation catch this property value and
+			emit a sound in the proximity monitor.
+
+		string LinkLossAlertLevel [readwrite]
+
+			Persistent property. Sets the alert level in the
+			proximity reporter for link loss scenario. Values:
+			"none", "mild", "high".
+
+		string PathLossAlertLevel [readwrite]
+
+			Persistent property. Alert level for path loss scenario.
+			It's a LOCAL property value written in the Alert Level of
+			the Immediate Alert service when the threshold alert is
+			triggered. Values: "none", "mild", "high".
+
+		string FindMeAlertLevel [readwrite]
+
+			Alert level to be written in the Find Me Target.
+			Values: "none", "mild", "high". Default value is
+			"none". Applications can disable the alert setting
+			the value to "none". If the "Target" is not found,
+			"none" will be emitted after the configured timeout.
+			When changing the level, signal is the confirmation
+			that the value was written in the remote.
-- 
1.7.6

