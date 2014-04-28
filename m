Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	andrzej.kaczmarek@tieto.com,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [RFC] mgmt-api: Add support to get connection parameters
Date: Mon, 28 Apr 2014 11:26:01 +0200
Message-Id: <1398677161-14795-1-git-send-email-lukasz.rymanowski@tieto.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Set Connection Parameters Change command and
Connection Parameters Changed Event has been introduced.
---
 doc/mgmt-api.txt | 87 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index cd5cd24..2408ba0 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -1679,6 +1679,50 @@ Load Identity Resolving Keys Command
 				Invalid Index
 
 
+Set Connection Parameters Change Command
+========================================
+
+	Command Code:		0x0031
+	Controller Index:       <controller id>
+	Command Parameters:	Address (6 Octets)
+				Address_Type (1 Octet)
+				Parameters_count (2 Octet)
+				Parameter1 {
+					Type (1 Octet)
+					Delta (1 Octet)
+				}
+				Parameter2 {  }
+				...
+
+	Return Parameters:	Address (6 Octets)
+				Address_Type (1 Octet)
+
+	This command is used to register for Connection Parameters Change
+	Event.
+
+	Possible Parameter Type:
+		0	TX Power
+		1	RSSI
+
+	This command will trigger Connection Parameters Change event.
+	Only changes greater or equal to Delta trigger subsequent Connection
+	Parameters Change events.
+
+	Delta shall be greater and equal to 0.
+	Delta equal to 0 disable parameter tracking.
+
+	Parameters set will be remembered during power down/up toggles and
+	connection state toggles.
+
+	On new connection, Connection Parameters Change Event is sent.
+
+	This command generates a Command Complete event on success
+	and on failure.
+
+	Possible errors:	Invalid Parameters
+				Invalid Index
+
+
 Command Complete Event
 ======================
 
@@ -2268,3 +2312,46 @@ New Signature Resolving Key Event
 
 	The provided Address and Address_Type are the identity of
 	a device. So either its public address or static random address.
+
+
+Connection Parameters Changed Event
+===================================
+
+	Event Code:		0x0020
+	Controller Index:	<controller id>
+	Event Parameters:	Address (6 Octets)
+				Address_Type (1 Octet)
+				Parameters_count (2 Octet)
+				Parameter1 {
+					Type (1 Octet)
+					Value (1 Octet)
+				}
+				Parameter2 {  }
+				...
+
+	This event indicates that a remote Connection Parameters has exceed
+	delta given on Set Connection Parameters Change event.
+
+	This event is sent only during connection time.
+
+	Possible values for the Address_Type parameter:
+		0	BR/EDR
+		1	LE Public
+		2	LE Random
+
+	Possible Parameter Type:
+		0	TX Power
+		1	RSSI
+
+	Possible TX Power:
+		BR/ERD/LE:
+			Range: -30 to 20
+			Units: dBm
+
+	Possible RSSI Value:
+		BR/EDR:
+			Range: -128 <= N <= 127 (signed integer)
+			Units: dBm
+		LE:
+			Range: -127 to 20, 127 (signed integer)
+			Units: dBm
-- 
1.8.4
