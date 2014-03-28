Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [RFC v2] mgmt-api: Add support for Read Remote RSSI
Date: Fri, 28 Mar 2014 09:10:00 +0100
Message-ID: <1395994200-23071-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Two commands has been introduced:
Start Read Remote RSSI Command
Stop Read Remote RSSI Command

And one Event:
Remote RSSI Changed Event

Idea is that it is possible to start/stop read remote RSSI session
and register for RSSI Change event with given theshold.
This API gives a possibility to do one time RSSI read in case userspace
really needs that.
---
 doc/mgmt-api.txt | 82 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 78f0bd2..58b1ebe 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -1668,6 +1668,58 @@ Load Identity Resolving Keys Command
 				Invalid Index
 
 
+Start Read Remote RSSI Command
+==============================
+
+	Command Code:		0x0031
+	Controller Index:       <controller id>
+	Command Parameters:	Address (6 Octets)
+				Address_Type (1 Octet)
+				Threshold (1 Octet)
+	Return Parameters:	Address (6 Octets)
+				Address_Type (1 Octet)
+				Current_RSSI (1 Octet)
+
+	This command is used to start read remote rssi with given
+	threshold. On this command current remote RSSI is read and
+	is used as starting point for messurements. If threshold is
+	exceeded then Remote RSSI Changed event is sent.
+
+	If threshold is 0 then no Remote RSSI Changed event is generated but
+	only Command Complete with current RSSI.
+
+	This command can be used only when controller is powered on.
+
+	This command generates a Command Complete event on success
+	and on failure.
+
+	Possible errors:	Not Connected
+				Invalid Parameters
+				Not Powered
+				Invalid Index
+
+
+Stop Read Remote RSSI Command
+=============================
+
+	Command Code:		0x0032
+	Controller Index:	<controller id>
+	Command Parameters:	Address (6 Octets)
+				Adress_Type (1 Octet)
+
+	Return Parametes:
+
+	This command is used to stop read remote RSSI started with
+	Start Read Remote RSSI command.
+
+	This command generates Command Complete event on success
+	and on failure.
+
+	Possible errors:	Rejected
+				Invalid Parameters
+				Invalid Index
+
+
 Command Complete Event
 ======================
 
@@ -2257,3 +2309,33 @@ New Signature Resolving Key Event
 
 	The provided Address and Address_Type are the identity of
 	a device. So either its public address or static random address.
+
+
+Remote RSSI Changed Event
+=========================
+
+	Event Code:		0x0020
+	Controller Index:	<controller id>
+	Event Parameters:	Address (6 Octets)
+				Address_Type (1 Octet)
+				Active (1 Octet)
+				RSSI (1 Octet)
+
+	This event indicates that a remote RSSI has exceed threshold
+	given on Start Read Remote RSSI command.
+
+	Possible values for the Address_Type parameter:
+		0	BR/EDR
+		1	LE Public
+		2	LE Random
+
+	The valid values for the Active parameter are 0x01
+	(RSSI read active) and 0x00 (RSSI read stopped).
+
+	Possible RSSI values:
+		BR/EDR
+			Range: -128 <= N <= 127 (signed integer)
+			Units: dB
+		LE:
+			Range: -127 to 20, 127 (signed integer)
+			Units: dBm
-- 
1.8.4

