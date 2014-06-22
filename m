Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] doc: Add management support for handling connection parameters
Date: Sun, 22 Jun 2014 22:02:34 +0200
Message-Id: <1403467354-41573-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/mgmt-api.txt | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 5a7d2ef0e5d3..3b8d63af63b1 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -1748,6 +1748,50 @@ Get Connection Information Command
 				Invalid Index
 
 
+Load Connection Parameters Command
+==================================
+
+	Command Code:		0x0032
+	Controller Index:	<controller id>
+	Command Parameters:	Param_Count (2 Octets)
+				Param1 {
+					Address (6 Octets)
+					Address_Type (1 Octet)
+					Min_Connection_Interval (2 Octets)
+					Max_Connection_Interval (2 Octes)
+					Connection_Latency (2 Octets)
+					Supervision_Timeout (2 Octets)
+				}
+				Param2 {  }
+				...
+	Return Parameters:
+
+	This command is used to load connection parameters from several
+	devices into kernel. Currently this is only supported on controllers
+	with Low Energy support.
+
+	Possible values for the Address_Type parameter:
+		0	Reserved (not in use)
+		1	LE Public
+		2	LE Random
+
+	The provided Address and Address_Type are the identity of
+	a device. So either its public address or static random address.
+
+	The Min_Connection_Interval, Max_Connection_Interval,
+	Connection_Latency and Supervision_Timeout parameters should
+	be configured as described in Core 4.1 spec, Vol 2, 7.8.12.
+
+	This command can be used when the controller is not powered.
+
+	This command generates a Command Complete event on success or
+	a Command Status event on failure.
+
+	Possible errors:	Invalid Parameters
+				Invalid Index
+				Not Supported
+
+
 Command Complete Event
 ======================
 
@@ -2337,3 +2381,34 @@ New Signature Resolving Key Event
 
 	The provided Address and Address_Type are the identity of
 	a device. So either its public address or static random address.
+
+
+New Connection Parameter Event
+==============================
+
+	Event Code:		0x001a
+	Controller Index:	<controller id>
+	Event Parameters:	Store_Hint (1 Octet)
+				Param {
+					Address (6 Octets)
+					Address_Type (1 Octet)
+					Min_Connection_Interval (2 Octets)
+					Max_Connection_Interval (2 Octes)
+					Connection_Latency (2 Octets)
+					Supervision_Timeout (2 Octets)
+				}
+
+	This event indicates a new set of connection parameter from
+	a peripheral device.
+
+	The Store_Hint parameter indicates whether the host is expected
+	to store these information persistently or not.
+
+	Possible values for the Address_Type parameter:
+		0	Reserved (not in use)
+		1	LE Public
+		2	LE Random
+
+	The Min_Connection_Interval, Max_Connection_Interval,
+	Connection_Latency and Supervision_Timeout parameters are
+	encoded as described in Core 4.1 spec, Vol 2, 7.7.65.3.
-- 
1.9.3

