Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] doc: Add support for generic advertising management API
Date: Thu, 12 Mar 2015 15:49:43 -0700
Message-Id: <1426200583-8385-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/mgmt-api.txt | 187 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 187 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index d4df8d94208d..528d7f96934e 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -2390,6 +2390,165 @@ Read Extended Controller Index List Command
 	a Command Status event on failure.
 
 
+Read Advertising Features Command
+=================================
+
+	Command Code:		0x003d
+	Controller Index:	<controller id>
+	Command Parameters:
+	Return Parameters:	Supported_Flags (4 Octets)
+				Max_Adv_Data_Len (1 Octet)
+				Max_Scan_Rsp_Len (1 Octet)
+				Max_Instances (1 Octet)
+				Num_Instances (1 Octet)
+				Instance[i] (1 Octet)
+
+	This command is used to read the advertising features supported
+	by the controller and the Bluetooth core.
+
+	The valid range for Instance identifiers is 1-254. The value 0
+	is reserved for internal use and the value 255 is reserved for
+	future extensions. However the Max_Instances value for indicating
+	the number of supported Instances can be also 0 if the controller
+	does not support any advertising.
+
+	The Max_Adv_Data_Len and Max_Scan_Rsp_Len provides extra
+	information about the maximum length of the data fields. For
+	now this will always return the value 31.
+
+	With Num_Instances and Instance array the current occupied
+	Instance identifiers can be retrieved.
+
+	This command generates a Command Complete event on success or
+	a Command Status event on failure.
+
+	Possible errors:	Invalid Parameters
+				Invalid Index
+
+
+Add Advertising Command
+=======================
+
+	Command Code:		0x003e
+	Controller Index:	<controller id>
+	Command Parameters:	Instance (1 Octet)
+				Flags (4 Octets)
+				Duration (2 Octets)
+				Timeout (2 Octets)
+				Adv_Data_Len (1 Octet)
+				Scan_Rsp_len (1 Octet)
+				Adv_Data (0-255 Octets)
+				Scan_Rsp (0-255 Octets)
+	Return Parameters:	Instance (1 Octet)
+
+	This command is used to configure an advertising instance that
+	can be used to switch a Bluetooth Low Energy controller into
+	advertising mode.
+
+	Added advertising information with this command will be ignored
+	when using the Set Advertising command to enable advertising.
+
+	Switching on advertising via that command will give the kernel
+	full control over the advertising and scan response data. This
+	command is still valid, but the Instace information added will
+	only be used after switching the global advertising off.
+
+	The Instance identifier is a value between 1 and the number of
+	supported instances. The value 0 is reserved.
+
+	With the Flags value the type of advertising is controlled and
+	the following flags are defined:
+
+		0	Connectable
+		1	Add Flags field to Adv_Data (required)
+		2	Add TX Power field to Adv_Data (required)
+		2	Add Name in Scan_Rsp (opportunistic)
+
+	When Connectable flags field is set, then the controller will
+	be instructed to advertise with undirected connectable advertising
+	using the identity address or random resolvable address based on
+	the privacy setting. If the Connectable flags field is not set,
+	then either non-connectable or scannable advertising using a
+	non-resolvable random addresses is used. The flag might not be
+	supported if the controller supports multiple instances, but does
+	not allow connectable advertising.
+
+	Advertising with the Connectable flag set is only valid when the
+	controller is in connectable mode or device entries are configured
+	using Add Device command. Otherwise this command will fail.
+
+	If Scan_Rsp_Len is zero and Connectable flags field is not set,
+	the non-connectable advertising is used. If the Scan_Rsp_Len is
+	is large than zero, then scannable advertising is used.
+
+	The flags field to include Flags field into the Adv_Data will
+	reduce the Max_Adv_Data_Len by up to 3 octets. The information
+	needed to configure this flags field can be retrieved manually
+	as well. This flag is just for convience and might not be always
+	supported.
+
+	The flags field to include the TX Power field into the Adv_Data
+	will reduce the Max_Adv_Data_Len by 3 octets. This flag is just
+	for convience and might not be always supported.
+
+	The flags field to include local Name field into the Scan_Rsp
+	if space permits. If there is enough space left, either the
+	full name or a short version of the name will be included. This
+	flag is also just for convience and might not be always supported.
+
+	In case the Scan_Rsp_Len is zero and the flag to include the local
+	Name set, then scannable advertising is used.
+
+	The Duration parameter configures the length of an Instance. The
+	value is in seconds and a value of 0 indicates an automatic choice
+	for the Duration. If only a single advertising Instance is defined,
+	then it will not be interrupted.
+
+	The Timeout parameter configures the life-time of an Instance. In
+	case the value 0 is used it indicates no expiration time. If a
+	timeout value is provided, then the advertising Instace will be
+	automatically removed when the timeout passes. The value for the
+	timeout is in seconds. Powering down a controller will invalidate
+	all advertising Instances and it is not possible to add a new
+	Instance with a timeout when the controller is powered down.
+
+	This command can be used when the controller is not powered and
+	all settings will be programmed once powered.
+
+	This command generates a Command Complete event on success or
+	a Command Status event on failure.
+
+	Possible errors:	Failed
+				Not Supported
+				Invalid Parameters
+				Invalid Index
+
+
+Remove Advertising Command
+==========================
+
+	Command Code:		0x003f
+	Controller Index:	<controller id>
+	Command Parameters:	Instance (1 Octet)
+	Return Parameters:	Instance (1 Octet)
+
+	This command is used to remove an advertising instance that
+	can be used to switch a Bluetooth Low Energy controller into
+	advertising mode.
+
+	When the Instance parameter is zero, then all previously added
+	advertising Instances will be removed.
+
+	This command can be used when the controller is not powered and
+	all settings will be programmed once powered.
+
+	This command generates a Command Complete event on success or
+	a Command Status event on failure.
+
+	Possible errors:	Invalid Parameters
+				Invalid Index
+
+
 Command Complete Event
 ======================
 
@@ -3164,3 +3323,31 @@ Extended Index Removed Event
 	This event will only be used after Read Extended Controller Index
 	List has been used at least once. If it has not been used, then
 	Index Removed and Unconfigured Index Removed are send instead.
+
+
+Advertising Added Event
+=======================
+
+	Event Code:		0x0022
+	Controller Index:	<controller id>
+	Event Parameters:	Instance (1 Octet)
+
+	This event indicates that an advertising instance has been added
+	using the Add Advertising command.
+
+	The event will only be sent to management sockets other than the
+	one through which the command was sent.
+
+
+Advertising Removed Event
+=========================
+
+	Event Code:		0x0023
+	Controller Index:	<controller id>
+	Event Parameters:	Instance (1 Octet)
+
+	This event indicates that an advertising instance has been removed
+	using the Remove Advertising command.
+
+	The event will only be sent to management sockets other than the
+	one through which the command was sent.
-- 
2.1.0

