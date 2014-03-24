Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] doc: Connection Parameters Command
Date: Mon, 24 Mar 2014 20:17:27 -0300
Message-Id: <1395703047-5743-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch introduces commands to add and remove connection parameters.
---
 doc/mgmt-api.txt | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 83 insertions(+), 1 deletion(-)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 78f0bd2..20e3e6c 100644
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
@@ -1668,6 +1669,87 @@ Load Identity Resolving Keys Command
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
+	The Min_Connection_Interval and Max_Connection_Interval parameters
+	should be configured as described in Core 4.1 spec, Vol 2, 7.8.12.
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
+Add Connection Parameters Command
+====================================
+
+	Command Code:		0x0032
+	Controller Index:	<controller id>
+	Command Parameters:	Address (6 Octets)
+				Address_Type (1 Octet)
+				Auto_Connect_Option (1 Octet)
+				Min_Connection_Interval (2 Octets)
+				Max_Connection_Interval (2 Octes)
+	Return Parameters:
+
+	This command is used add or update connection parameters from a given
+	LE device. It is only supported on controllers with LE support.
+
+	Parameters from this command are described in "Load Connection
+	Parameters Command".
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
 
-- 
1.9.0

