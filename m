Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] doc: Add commands and events for managing advertising data
Date: Thu, 12 Mar 2015 19:35:48 -0700
Message-Id: <1426214148-9259-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/mgmt-api.txt | 237 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 237 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index fdca60fc6c1a..6313d2f180a6 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -1590,6 +1590,9 @@ Set Advertising Command
 	The value 0x02 should be the preferred mode of operation when
 	implementing peripheral mode.
 
+	Using this command will temporarily deactive any configuration
+	made by the Add Advertising command. This command takes precedence.
+
 	A pre-requisite is that LE is already enabled, otherwise this
 	command will return a "rejected" response.
 
@@ -2411,6 +2414,212 @@ Read Extended Controller Index List Command
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
+	by the controller and stack.
+
+	With the Supported_Flags field the possible values for the Flags
+	field in Add Advertising command provided:
+
+		0	Switch into Connectable mode
+		1	Add Flags field to Adv_Data
+		2	Add TX Power field to Adv_Data
+		3	Add Appearance field to Scan_Rsp
+		4	Add Local Name in Scan_Rsp
+
+	The Flags bit 0 indicates support for connectable advertising
+	and for switching to connectable advertising independent of the
+	connectable global setting. When this flag is not supported, then
+	the global connectable setting determines if undirected connectable,
+	undirected scannable or undirected non-connectable advertising is
+	used. It also determines the use of non-resolvable random address
+	versus identity address or resolvable private address.
+
+	The Flags bit 1 indicates support for automatically keeping the
+	Flags field of the advertising data updated. Users of this flag
+	will decrease the Max_Adv_Data_Len by 3 octets and need to keep
+	that in mind. The Flags field will be added in front of the
+	advertising data provided by the user.
+
+	The Flags bit 2 indicates support for automatically adding the
+	TX Power value to the advertising data. Users of this flag will
+	decrease the Max_Adv_Data_Len by 3 octets. The TX Power field will
+	be added at the end of the user provided advertising data. If the
+	controller does not support TX Power information, then this bit will
+	not be set.
+
+	The Flags bit 3 indicates support for automatically adding the
+	Apperance value to the scan response data. Users of this flag
+	will decrease the Max_Scan_Rsp_len by 4 octets. The Appearance
+	field will be added in front of the scan response data provided
+	by the user. If the appearance value is not supported, then this
+	bit will not be set.
+
+	The Flags bit 4 indicates support for automatically adding the
+	Local Name value to the scan response data. This flag indicates
+	an opportunistic approach for the Local Name. If enough space
+	in the scan response data is available, it will be added. If the
+	space is limited a short version or no name information. The
+	Local Name will be added at the end of the scan response data.
+
+	The valid range for Instance identifiers is 1-254. The value 0
+	is reserved for internal use and the value 255 is reserved for
+	future extensions. However the Max_Instances value for indicating
+	the number of supported Instances can be also 0 if the controller
+	does not support any advertising.
+
+	The Max_Adv_Data_Len and Max_Scan_Rsp_Len provides extra
+	information about the maximum length of the data fields. For
+	now this will always return the value 31. Different flags
+	however might decrease the actual available length in these
+	data fields.
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
+	when using the Set Advertising command to enable advertising. The
+	usage of Set Advertising command take precedence over this command.
+
+	The Instance identifier is a value between 1 and the number of
+	supported instances. The value 0 is reserved.
+
+	With the Flags value the type of advertising is controlled and
+	the following flags are defined:
+
+		0	Switch into Connectable mode
+		1	Add Flags field to Adv_Data
+		2	Add TX Power field to Adv_Data
+		3	Add Appearance field to Scan_Rsp
+		4	Add Local Name to Scan_Rsp
+
+	When the connectable flag is set, then the controller will use
+	undirected connectable advertising. The value of the connectable
+	setting can be overwritten this way. This is useful to switch a
+	controller into connectable mode only for LE operation. This is
+	similar to the mode 0x02 from the Set Advertising command.
+
+	When the connectable flag is not set, then the controller will
+	use advertising based on the connectable setting. When using
+	non-connectable or scannable advertising, the controller will
+	be programmed with a non-resolvable random address. When the
+	system is connectable, then the identity address or resolvable
+	private address will be used.
+
+	Using the connectable flag is useful for peripheral mode support
+	where BR/EDR (and/or LE) is controlled by Add Device. This allows
+	making the peripheral connectable without having to interfere
+	with the global connectable setting.
+
+	If Scan_Rsp_Len is zero and connectable flag is not set and
+	the global connectable setting is off, then non-connectable
+	advertising is used. If Scan_Rsp_Len is larger than zero and
+	connectable flag is not set and the global advertising is off,
+	then scannable advertising is used. This small difference is
+	supported to provide less air traffic for devices implementing
+	broadcaster role.
+
+	The Duration parameter configures the length of an Instance. The
+	value is in seconds and a value of 0 indicates an automatic choice
+	for the Duration. If only one advertising Instance has been added,
+	then the Duration value will be ignored. It only applies for the
+	case where multiple Instances are configured. In that case every
+	Instance will be available for the Duration time and after that
+	it switches to the next one. This is a simple round-robin based
+	approach.
+
+	The Timeout parameter configures the life-time of an Instance. In
+	case the value 0 is used it indicates no expiration time. If a
+	timeout value is provided, then the advertising Instace will be
+	automatically removed when the timeout passes. The value for the
+	timeout is in seconds. Powering down a controller will invalidate
+	all advertising Instances and it is not possible to add a new
+	Instance with a timeout when the controller is powered down.
+
+	When a Timeout is provided, then the Duration substracts from
+	the actual Timeout value of that Instance. For example an Instance
+	with Timeout of 6 and Duration of 2 will be scheduled exactly 3
+	times. Other Instances have no influence on the Timeout.
+
+	A pre-requisite is that LE is already enabled, otherwise this
+	command will return a "rejected" response.
+
+	This command can be used when the controller is not powered and
+	all settings will be programmed once powered.
+
+	This command generates a Command Complete event on success or a
+	Command Status event on failure.
+
+	Possible errors:	Failed
+				Rejected
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
 
@@ -3185,3 +3394,31 @@ Extended Index Removed Event
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

