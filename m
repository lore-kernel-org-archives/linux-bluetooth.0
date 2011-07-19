Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ] Proximity API simplification
Date: Tue, 19 Jul 2011 19:36:30 -0300
Message-Id: <1311114990-21762-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <CAKT1EBepAMrUzRvOMMiEyr5Zmist-rzD55pfnkSe+hRMdtM26A@mail.gmail.com>
References: <CAKT1EBepAMrUzRvOMMiEyr5Zmist-rzD55pfnkSe+hRMdtM26A@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Delegates the Immediate Alert Level control to the caller(client).
Immediate Alert Service is shared between Path Loss and Find Me.

Three signal level states are defined: "good", "regular" and "weak".
Meaning that at least two thresholds are necessary to implement a
proper state transition. "unknown" will be returned if the link is not
active. For Path Loss, the logic to trigger the writting operation of
the Immediate Alert Level characteristic needs to be implemented in
the client. SignalLevel can be only one of the inputs to define when
and which value to write in the characteristic.
---
 doc/proximity-api.txt |   36 ++++++------------------------------
 1 files changed, 6 insertions(+), 30 deletions(-)

diff --git a/doc/proximity-api.txt b/doc/proximity-api.txt
index ed78fb5..cf64bbf 100644
--- a/doc/proximity-api.txt
+++ b/doc/proximity-api.txt
@@ -30,29 +30,11 @@ Signals		PropertyChanged(string name, variant value)
 			property.
 
 Properties
-		uint8 PathLoss[readonly]
 
-			If Tx Power Service is available, this property value
-			will be reported on regular intervals when the peer is
-			connected. Range: 0 - 100. The number is a relative
-			value to represent inaccurately the signal strength,
-			where 0 represents out of range and 100 close to the
-			reporter.
+		string SignalLevel[readonly]
 
-		string Threshold [readwrite]
-
-			Persistent property. Trigger for immediate alert.
-			Values: "low", "medium", "high". Enabled only if Tx
-			Power and Immediate Alert services are available in
-			the reporter. Controls when the immediate alert is
-			triggered in the reporter.
-
-		boolean ThresholdAlert[readonly]
-
-			Alert indicating that threshold has been reached or the
-			path loss returned to a value below the threshold. It is
-			up to the implementation catch this property value and
-			emit a sound in the proximity monitor.
+			Alert indicating that a threshold has been reached.
+			Possible values: "unknown", "good", "regular", "weak"
 
 		string LinkLossAlertLevel [readwrite]
 
@@ -60,16 +42,10 @@ Properties
 			proximity reporter for link loss scenario. Values:
 			"none", "mild", "high".
 
-		string PathLossAlertLevel [readwrite]
-
-			Persistent property. Alert level for path loss scenario.
-			It's a LOCAL property value written in the Alert Level of
-			the Immediate Alert service when the threshold alert is
-			triggered. Values: "none", "mild", "high".
-
-		string FindMeAlertLevel [readwrite]
+		string ImmediateAlertLevel [readwrite]
 
-			Alert level to be written in the Find Me Target.
+			Alert level to be written in the Immediate Alert Level.
+			Property shared between Path Loss and Find Me.
 			Values: "none", "mild", "high". Default value is
 			"none". Applications can disable the alert setting
 			the value to "none". If the "Target" is not found,
-- 
1.7.6

