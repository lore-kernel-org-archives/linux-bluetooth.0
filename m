Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [RFC v3] mgmt-api: Add support for Read Remote RSSI
Date: Fri, 28 Mar 2014 10:37:47 +0100
Message-ID: <1395999467-29192-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1395999467-29192-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1395999467-29192-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Two commands has been introduced:
Register Read Remote RSSI Change Command
Unregister Read Remote RSSI Change Command

And one Event:
Remote RSSI Changed Event
---
 doc/mgmt-api.txt | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 78f0bd2..ffe24fe 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -1668,6 +1668,53 @@ Load Identity Resolving Keys Command
 				Invalid Index
 
 
+Register Remote RSSI Change Command
+===================================
+
+	Command Code:		0x0031
+	Controller Index:       <controller id>
+	Command Parameters:	Address (6 Octets)
+				Address_Type (1 Octet)
+				Threshold (1 Octet)
+	Return Parameters:	Address (6 Octets)
+				Address_Type (1 Octet)
+
+	This command is used to register on Remote RSSI Change with given
+	threshold. If threshold is exceeded then Remote RSSI Changed event
+	is sent.
+
+	Threshold shall be greater than 0.
+
+	Threshold will be remembered during power down/up toggles.
+
+	This command generates a Command Complete event on success
+	and on failure.
+
+	Possible errors:	Invalid Parameters
+				Invalid Index
+
+
+Unregister Remote RSSI Change Command
+=====================================
+
+	Command Code:		0x0032
+	Controller Index:	<controller id>
+	Command Parameters:	Address (6 Octets)
+				Address_Type (1 Octet)
+	Return Parametes:	Address (6 Octets)
+				Address_Type (1 Octet)
+
+	This command is used to unregister from Remote RSSI Change event
+	started with Register Remote RSSI Change command.
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
 
@@ -2257,3 +2304,29 @@ New Signature Resolving Key Event
 
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
+	Possible RSSI values:
+		BR/EDR
+			Range: -128 <= N <= 127 (signed integer)
+			Units: dB
+		LE:
+			Range: -127 to 20, 127 (signed integer)
+			Units: dBm
-- 
1.8.4

