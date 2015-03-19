Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] doc: Add initial 6LoWPAN API definition
Date: Thu, 19 Mar 2015 11:10:30 +0200
Message-Id: <1426756230-422-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

---
 Makefile.am         |   2 +-
 doc/6lowpan-api.txt | 291 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 292 insertions(+), 1 deletion(-)
 create mode 100644 doc/6lowpan-api.txt

diff --git a/Makefile.am b/Makefile.am
index 90bb86baefdc..d6726dde40a0 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -239,7 +239,7 @@ EXTRA_DIST += $(test_scripts)
 EXTRA_DIST += doc/assigned-numbers.txt doc/supported-features.txt \
 				doc/test-coverage.txt doc/settings-storage.txt
 
-EXTRA_DIST += doc/mgmt-api.txt \
+EXTRA_DIST += doc/mgmt-api.txt doc/6lowpan-api.txt \
 		doc/adapter-api.txt doc/device-api.txt \
 		doc/agent-api.txt doc/profile-api.txt \
 		doc/network-api.txt doc/media-api.txt \
diff --git a/doc/6lowpan-api.txt b/doc/6lowpan-api.txt
new file mode 100644
index 000000000000..6c4e2fb7201a
--- /dev/null
+++ b/doc/6lowpan-api.txt
@@ -0,0 +1,291 @@
+6LoWPAN Management API
+**********************
+
+Copyright (C) 2015  Intel Corporation
+
+
+Overview
+========
+
+The 6LoWPAN Management API follows largely the same principles as the
+main Bluetooth Management API described in mgmt-api.txt. The main
+difference is a separate namespace for command and event codes,
+distinguished by using HCI_CHANNEL_6LOWPAN rather than
+HCI_CHANNEL_CONTROL when creating the mgmt socket.
+
+
+Read 6LoWPAN Version Information Command
+========================================
+
+	Command Code:		0x0001
+	Controller Index:	<non-controller>
+	Command Parameters:
+	Return Parameters:	Version (1 Octets)
+				Revision (2 Octets)
+
+	This command returns the 6LoWPAN version and revision.
+	Besides, being informational the information can be used to
+	determine whether certain behavior has changed or bugs fixed
+	when interacting with the kernel.
+
+	This command generates a Command Complete event on success or
+	a Command Status event on failure.
+
+
+Read 6LoWPAN Supported Commands Command
+========================================
+
+	Command Code:		0x0002
+	Controller Index:	<non-controller>
+	Command Parameters:
+	Return Parameters:	Num_Of_Commands (2 Octets)
+				Num_Of_Events (2 Octets)
+				Command1 (2 Octets)
+				Command2 (2 Octets)
+				...
+				Event1 (2 Octets)
+				Event2 (2 Octets)
+				...
+
+	This command returns the list of supported 6LoWPAN commands
+	and events.
+
+	The commands Read 6LoWPAN Version Information and Read
+	6LoWPAN Supported Commands are not included in this list.
+	Both commands are always supported and mandatory.
+
+	The events Command Status and Command Complete are not included
+	in this list. Both are implicit and mandatory.
+
+	This command generates a Command Complete event on success or
+	a Command Status event on failure.
+
+
+Read Controller Index List Command
+==================================
+
+	Command Code:		0x0003
+	Controller Index:	<non-controller>
+	Command Parameters:
+	Return Parameters:	Num_Controllers (2 Octets)
+				Controller_Index[i] (2 Octets)
+				Supported_Features[i] (4 Octets)
+
+	This command returns the list of currently known controllers
+	that can be used for 6LoWPAN connections. Controllers added or
+	removed after calling this command can be monitored using the
+	Index Added and Index Removed events.
+
+	The Supported_Features is a bitmask with the following available
+	bits:
+
+		0	Node Role Supported
+		1	Router Role Supported
+
+	This command generates a Command Complete event on success or
+	a Command Status event on failure.
+
+
+Connect Command
+===============
+
+	Command Code:		0x0004
+	Controller Index:	<controller id>
+	Command Parameters:	Address (6 Octets)
+				Address_Type (1 Octet)
+	Return Parameters:	Address (6 Octets)
+				Address_Type (1 Octet)
+				Network_Interface (16 Octets)
+
+	This command is used to connect to a remote 6LoWPAN server.
+
+	The returned Network_Interface parameter is a nul-terminated
+	string containing the created network interface name.
+
+	This command generates a Command Complete event on success or
+	a Command Status event on failure.
+
+	Possible errors:	Busy
+				Invalid Parameters
+				Not Powered
+				Invalid Index
+
+
+Disconnect Command
+==================
+
+	Command Code:		0x0005
+	Controller Index:	<controller id>
+	Command Parameters:	Address (6 Octets)
+				Address_Type (1 Octet)
+	Return Parameters:	Address (6 Octets)
+				Address_Type (1 Octet)
+
+	This command is used to disconnect from a remote 6LoWPAN server.
+
+	This command generates a Command Complete event on success or
+	a Command Status event on failure.
+
+	Possible errors:	Busy
+				Not Connected
+				Invalid Parameters
+				Not Powered
+				Invalid Index
+
+
+Start Server Command
+====================
+
+	Command Code:		0x0005
+	Controller Index:	<controller id>
+	Command Parameters:
+	Return Parameters:
+
+	This command is used to start a 6LoWPAN server for a specified
+	controller.
+
+	This command generates a Command Complete event on success or
+	a Command Status event on failure.
+
+	Possible errors:	Busy
+				Invalid Index
+
+
+Stop Server Command
+===================
+
+	Command Code:		0x0006
+	Controller Index:	<controller id>
+	Command Parameters:
+	Return Parameters:
+
+	This command is used to stop a 6LoWPAN server for a specified
+	controller.
+
+	This command generates a Command Complete event on success or
+	a Command Status event on failure.
+
+	Possible errors:	Rejected
+				Invalid Index
+
+
+Command Complete Event
+======================
+
+	Event Code:		0x0001
+	Controller Index:	<controller id> or <non-controller>
+	Event Parameters:	Command_Opcode (2 Octets)
+				Status (1 Octet)
+				Return_Parameters
+
+	This event is an indication that a command has completed. The
+	fixed set of parameters includes the opcode to identify the
+	command that completed as well as a status value to indicate
+	success or failure. The rest of the parameters are command
+	specific and documented in the section for each command
+	separately.
+
+
+Command Status Event
+====================
+
+	Event Code:		0x0002
+	Controller Index:	<controller id> or <non-controller>
+	Event Parameters:	Command_Opcode (2 Octets)
+				Status (1 Octet)
+
+	The command status event is used to indicate an early status for
+	a pending command. In the case that the status indicates failure
+	(anything else except success status) this also means that the
+	command has finished executing.
+
+
+Index Added Event
+=================
+
+	Event Code:		0x0003
+	Controller Index:	<controller id>
+	Event Parameters:	Supported_Features (4 octets)
+
+	This event indicates that a new controller has been added to the
+	system that can be used for 6LoWPAN.
+
+	The Supported_Features is a bitmask with the following available
+	bits:
+
+		0	Node Role Supported
+		1	Router Role Supported
+
+
+Index Removed Event
+===================
+
+	Event Code:		0x0004
+	Controller Index:	<controller id>
+	Event Parameters:
+
+	This event indicates that a 6LoWPAN-capable controller has been
+	removed from the system.
+
+
+6LoWPAN Connected Event
+=======================
+
+	Event Code:		0x0005
+	Controller Index:	<controller id>
+	Event Parameters:	Address (6 Octets)
+				Address_Type (1 Octet)
+				Role (1 Octet)
+				Interface_Name (16 Octets)
+
+	This event indicates that a successful 6LoWPAN connection has
+	been created to the remote device.
+
+	Possible values for the Address_Type parameter:
+		1	LE Public
+		2	LE Random
+
+	For devices using resolvable random addresses with a known
+	identity resolving key, the Address and Address_Type will
+	contain the identity information.
+
+	The Role parameter indicates which role the local system has for
+	the connection. The parameter has the following possible values:
+		0x00	Node
+		0x01	Router
+
+	The Network_Interface parameter is a nul-terminated
+	string containing the created network interface name.
+
+
+6LoWPAN Disconnected Event
+==========================
+
+	Event Code:		0x0006
+	Controller Index:	<controller id>
+	Event Parameters:	Address (6 Octets)
+				Address_Type (1 Octet)
+				Role (1 Octet)
+				Reason (1 Octet)
+
+	This event indicates that the 6LoWPAN connection was lost to a
+	remote device.
+
+	Possible values for the Address_Type parameter:
+		1	LE Public
+		2	LE Random
+
+	For devices using resolvable random addresses with a known
+	identity resolving key, the Address and Address_Type will
+	contain the identity information.
+
+	The Role parameter indicates which role the local system has for
+	the connection. The parameter has the following possible values:
+		0x00	Node
+		0x01	Router
+
+	Possible values for the Reason parameter:
+		0	Unspecified
+		1	Connection timeout
+		2	Connection terminated by local host
+		3	Connection terminated by remote host
-- 
2.1.0

