Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v4] doc: Connection Parameters command and event
Date: Mon,  7 Apr 2014 19:27:05 -0300
Message-Id: <1396909625-4669-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/mgmt-api.txt | 83 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 82 insertions(+), 1 deletion(-)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index cd5cd24..7c77f75 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -1006,7 +1006,8 @@ Unpair Device Command
 	Return Parameters:	Address (6 Octets)
 				Address_Type (1 Octet)
 
-	Removes all keys associated with the remote device.
+	Removes all keys and connection parameters associated with the remote
+	device.
 
 	Possible values for the Address_Type parameter:
 		0	BR/EDR
@@ -1679,6 +1680,52 @@ Load Identity Resolving Keys Command
 				Invalid Index
 
 
+Load Connection Parameters Command
+====================================
+
+	Command Code:		0x0031
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
+	This command is used to load connection parameters from several LE
+	devices into kernel. It is only supported on controllers with LE
+	support.
+
+	The provided Address and Address_Type are the identity of a device. So
+	either its public address or static random address. Unresolvable random
+	addresses and resolvable random addresses are not valid and will be
+	rejected.
+
+	Possible values for the Address_Type parameter:
+		0	Reserved (not in use)
+		1	LE Public
+		2	LE Random
+
+	The Min_Connection_Interval, Max_Connection_Interval, Connection_Latency
+	and Supervision_Timeout parameters should be configured as described in
+	Core 4.1 spec, Vol 2, 7.8.12.
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
 
@@ -2268,3 +2315,37 @@ New Signature Resolving Key Event
 
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
+	This event indicates the new LE connection parameters set by GAP
+	Connection Parameter Update Procedure.
+
+	The Store_Hint parameter indicates whether the host is expected
+	to store the connection parameters persistently or not.
+
+	This event is sent only if the new parameters are different from the
+	parameters the user has configured (See Load Connection Parameters
+	Command) or if there is no parameters configured for that device.
+
+	Possible values for the Address_Type parameter:
+		0	Reserved (not in use)
+		1	LE Public
+		2	LE Random
+
+	The Connection_Interval, Connection_Latency and Supervision_Timeout
+	parameters are encoded as described in Core 4.1	spec, Vol 2, 7.7.65.3.
-- 
1.9.1

