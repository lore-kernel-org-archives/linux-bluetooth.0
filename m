Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] doc: Add mangement API for service information feature
Date: Thu, 12 Mar 2015 12:42:31 -0700
Message-Id: <1426189351-4277-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/mgmt-api.txt | 137 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 137 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index d4df8d94208d..af85b3c10ce1 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -2390,6 +2390,114 @@ Read Extended Controller Index List Command
 	a Command Status event on failure.
 
 
+Add Service Information Command
+===============================
+
+	Command Code:		0x003d
+	Controller Index:	<controller id>
+	Command Parameters:	UUID (16 Octets)
+				Type (1 Octet)
+				Timeout (2 Octets)
+				Data_Len (1 Octet)
+				Data (0-255 Octets)
+	Return Parameters:	UUID (16 Octets)
+
+	This command is used to add service information for Bluetooth
+	Low Energy controllers. These information are used when the
+	controller has to advertise its services.
+
+	The Type parameter defines the actions associcated with the
+	provided UUID. The following values are defined:
+
+		0	Service UUID (opportunistic)
+		1	Service UUID (required)
+		2	Service data information
+		3	Service solicitation using general discoverable mode
+		4	Service solicitation using limited discoverable mode
+
+	Every UUID can only be provided once and can only be associated
+	with one of these types. It is possible to change the current
+	type, but it means that it will no longer advertised using the
+	previous configured type.
+
+	The Service UUID (type 0 and 1) are advertised using the standard
+	Service UUID advertising data type. The difference is that type 1
+	UUID are mandatory to include and the command will fail in case
+	there is no space in the advertising data. The type 0 will add
+	the UUID and add the UUID if there is space. It is preferred to
+	use type 0 over type 1 to provide the Bluetooth core with maximum
+	flexibility to choose which UUIDs to include.
+
+	The Service data information will include the data information
+	instead of the Service UUID. Since both types include the UUID,
+	it makes no sense to be duplicated. However Service data information
+	is treated the same as type 1 and mandatory. If it does not fit,
+	then the command will return an error.
+
+	For type 0, 1 and 2 the Set Advertising command has to be used
+	to enable advertising in the first place. Adding the Service UUID
+	or Service data will not enable advertising.
+
+	The Service solicitation however will actually enable advertising
+	in general or limited discoverable mode. This means that adding
+	a UUID with type 3 or 4 will cause the Bluetooth core to advertise.
+
+	In case the controller is not configured as connectable, then
+	using type 3 or 4 will return an error. In that sense it behaves
+	similar to Set Discoverable mode. For the Service solicitation,
+	the Timeout parameter can be used to limit the transaction. The
+	Bluetooth core will disable advertising and discoverable mode
+	automatically then.
+
+	The Timeout parameter can also be used for type 0, 1 and 2 in
+	case advertising of a certain UUID should be limited to a certain
+	amount of time. The Timeout paramter value is specified in seconds
+	and a value of 0 disables the timeout handling.
+
+	UUID values configured will stay around when the controller gets
+	powered down and will be automatically programmed back into the
+	controller once it gets powered on. However for UUID values with
+	a timeout, the powering down of the controller result in the
+	timeout triggering and the UUID being removed. The same applies
+	for type 3 and 4 when connectable setting is turned off.
+
+	This command can be used when the controller is not powered and
+	all settings will be programmed once powered.
+
+	This command generates a Command Complete event on success
+	or failure.
+
+	Possible errors:	Failed
+				Not Supported
+				Invalid Parameters
+				Invalid Index
+
+
+Remove Service Information Command
+==================================
+
+	Command Code:		0x003e
+	Controller Index:	<controller id>
+	Command Parameters:	UUID (16 Octets)
+	Return Parameters:	UUID (16 Octets)
+
+	This command is used to remove service information from a Bluetooth
+	Low Energy controller previously added by using the Add Service
+	Information command.
+
+	When the UUID parameter is an empty UUID (16 x 0x00), then all
+	previously loaded UUIDs will be removed.
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
 
@@ -3164,3 +3272,32 @@ Extended Index Removed Event
 	This event will only be used after Read Extended Controller Index
 	List has been used at least once. If it has not been used, then
 	Index Removed and Unconfigured Index Removed are send instead.
+
+
+Service Information Added Event
+===============================
+
+	Event Code:		0x0022
+	Controller Index:	<controller id>
+	Event Parameters:	UUID (16 Octets)
+				Type (1 Octet)
+
+	This event indicates that service information have been added
+	using the Add Service Information command.
+
+	The event will only be sent to management sockets other than the
+	one through which the command was sent.
+
+
+Service Information Removed Event
+=================================
+
+	Event Code:		0x0023
+	Controller Index:	<controller id>
+	Event Parameters:	UUID (16 Octets)
+
+	This event indicates that service information have been removed
+	using the Remove Service Information command.
+
+	The event will only be sent to management sockets other than the
+	one through which the command was sent.
-- 
2.1.0

