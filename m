Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v2] doc: Connection Parameters command and event
Date: Thu,  3 Apr 2014 08:18:05 -0300
Message-Id: <1396523885-3705-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/mgmt-api.txt | 89 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 88 insertions(+), 1 deletion(-)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 78f0bd2..a2c65db 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -995,7 +995,8 @@ Unpair Device Command
 	Return Parameters:	Address (6 Octets)
 				Address_Type (1 Octet)
 
-	Removes all keys associated with the remote device.
+	Removes all keys and connection parameters associated with the remote
+	device.
 
 	Possible values for the Address_Type parameter:
 		0	BR/EDR
@@ -1668,6 +1669,62 @@ Load Identity Resolving Keys Command
 				Invalid Index
 
 
+Load Connection Parameters Command
+====================================
+
+	Command Code:		0x0031
+	Controller Index:	<controller id>
+	Command Parameters:	Params_Count (2 Octets)
+				Params1 {
+					Address (6 Octets)
+					Address_Type (1 Octet)
+					Auto_Connect_Option (1 Octet)
+					Min_Connection_Interval (2 Octets)
+					Max_Connection_Interval (2 Octes)
+					Connection_Latency (2 Octets)
+					Supervision_Timeout (2 Octets)
+				}
+				Params2 {  }
+				...
+	Return Parameters:
+
+	This command is used load connection parameters from several LE devices
+	into kernel. It is only supported on controllers with LE support.
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
+	Possible values for the Auto_Connect_Option parameter:
+		0	Disabled
+		1	Always
+		2	Link Loss
+
+	The 'Always' option configures the kernel to always re-establish the
+	connection, no matter the reason the connection was terminated. The
+	'Link Loss' option configures the kernel to re-establish the connection
+	only in case the connection was terminated due to a link loss.
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
 
@@ -2257,3 +2314,33 @@ New Signature Resolving Key Event
 
 	The provided Address and Address_Type are the identity of
 	a device. So either its public address or static random address.
+
+
+New Connection Parameters Event
+===============================
+
+	Event Code:		0x001a
+	Controller Index:	<controller id>
+	Event Parameters:	Address (6 Octets)
+				Address_Type (1 Octet)
+				Connection_Interval (2 Octets)
+				Connection_Latency (2 Octets)
+				Supervision_Timeout (2 Octets)
+
+	This event indicates the new LE connection parameters set by GAP
+	Connection Parameter Update Procedure.
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
+	The provided Address and Address_Type are the identity of
+	a device. So either its public address or static random address.
+
+	The Connection_Interval, Connection_Latency and Supervision_Timeout
+	parameters are encoded as described in Core 4.1	spec, Vol 2, 7.7.65.3.
-- 
1.9.1

