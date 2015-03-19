Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH v2] doc: Add initial 6LoWPAN API definition
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1426761568-7649-1-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 19 Mar 2015 14:39:24 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <779A63F7-7FD6-4643-8D17-19541AA44489@holtmann.org>
References: <1426761568-7649-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> ---
> Makefile.am         |   2 +-
> doc/6lowpan-api.txt | 291 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> 2 files changed, 292 insertions(+), 1 deletion(-)
> create mode 100644 doc/6lowpan-api.txt
> 
> diff --git a/Makefile.am b/Makefile.am
> index 90bb86baefdc..d6726dde40a0 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -239,7 +239,7 @@ EXTRA_DIST += $(test_scripts)
> EXTRA_DIST += doc/assigned-numbers.txt doc/supported-features.txt \
> 				doc/test-coverage.txt doc/settings-storage.txt
> 
> -EXTRA_DIST += doc/mgmt-api.txt \
> +EXTRA_DIST += doc/mgmt-api.txt doc/6lowpan-api.txt \
> 		doc/adapter-api.txt doc/device-api.txt \
> 		doc/agent-api.txt doc/profile-api.txt \
> 		doc/network-api.txt doc/media-api.txt \
> diff --git a/doc/6lowpan-api.txt b/doc/6lowpan-api.txt
> new file mode 100644
> index 000000000000..03dffbff8968
> --- /dev/null
> +++ b/doc/6lowpan-api.txt
> @@ -0,0 +1,291 @@
> +6LoWPAN Management API
> +**********************
> +
> +Copyright (C) 2015  Intel Corporation
> +
> +
> +Overview
> +========
> +
> +The 6LoWPAN Management API follows largely the same principles as the
> +main Bluetooth Management API described in mgmt-api.txt. The main
> +difference is a separate namespace for command and event codes,
> +distinguished by using HCI_CHANNEL_6LOWPAN rather than
> +HCI_CHANNEL_CONTROL when creating the mgmt socket.
> +
> +
> +Read 6LoWPAN Version Information Command
> +========================================
> +
> +	Command Code:		0x0001
> +	Controller Index:	<non-controller>
> +	Command Parameters:
> +	Return Parameters:	Version (1 Octets)
> +				Revision (2 Octets)
> +
> +	This command returns the 6LoWPAN version and revision.
> +	Besides, being informational the information can be used to
> +	determine whether certain behavior has changed or bugs fixed
> +	when interacting with the kernel.
> +
> +	This command generates a Command Complete event on success or
> +	a Command Status event on failure.
> +
> +
> +Read 6LoWPAN Supported Commands Command
> +========================================
> +
> +	Command Code:		0x0002
> +	Controller Index:	<non-controller>
> +	Command Parameters:
> +	Return Parameters:	Num_Of_Commands (2 Octets)
> +				Num_Of_Events (2 Octets)
> +				Command1 (2 Octets)
> +				Command2 (2 Octets)
> +				...
> +				Event1 (2 Octets)
> +				Event2 (2 Octets)
> +				...
> +
> +	This command returns the list of supported 6LoWPAN commands
> +	and events.
> +
> +	The commands Read 6LoWPAN Version Information and Read
> +	6LoWPAN Supported Commands are not included in this list.
> +	Both commands are always supported and mandatory.
> +
> +	The events Command Status and Command Complete are not included
> +	in this list. Both are implicit and mandatory.
> +
> +	This command generates a Command Complete event on success or
> +	a Command Status event on failure.
> +
> +
> +Read Controller Index List Command
> +==================================
> +
> +	Command Code:		0x0003
> +	Controller Index:	<non-controller>
> +	Command Parameters:
> +	Return Parameters:	Num_Controllers (2 Octets)
> +				Controller_Index[i] (2 Octets)
> +				Supported_Features[i] (4 Octets)
> +
> +	This command returns the list of currently known controllers
> +	that can be used for 6LoWPAN connections. Controllers added or
> +	removed after calling this command can be monitored using the
> +	Index Added and Index Removed events.
> +
> +	The Supported_Features is a bitmask with the following available
> +	bits:
> +
> +		0	Node Role Supported
> +		1	Router Role Supported
> +
> +	This command generates a Command Complete event on success or
> +	a Command Status event on failure.

so my preference is to keep command codes 0x0001 - 0x0003 exactly the same as with what we have in the current GAP part of the API. That means this should just return the list of controller indexes.

This also means that event codes 0x0001 - 0x0005 kept exactly the same. And that should be kept the same for any future channel we are adding support for. The basic commands and events have served us really well.

With this in mind the first specific command would be the Read Controller Info type command with 0x0004 that then. It will return the list of Supported_Features and Current_Features and maybe some extra information about the 6LoWPAN side of things. Doing it that way has also served us well to communicate states across the clients easily.

> +
> +
> +Connect Command
> +===============
> +
> +	Command Code:		0x0004
> +	Controller Index:	<controller id>
> +	Command Parameters:	Address (6 Octets)
> +				Address_Type (1 Octet)
> +	Return Parameters:	Address (6 Octets)
> +				Address_Type (1 Octet)
> +				Network_Interface (16 Octets)

Kernel interfaces should return the 4 octet ifindex. Not the network interface name. Also this is most likely pretty much wrong in the connect context. Per controller you only have a single 6LoWPAN network interface anyway. That sounds more like something that should be generic in the read info details.

I spent a lot of time to explain the Address_Type parameters in the other document, we might better actually copy that over here. And clearly say which ones are supported and which ones reserved.

> +
> +	This command is used to connect to a remote 6LoWPAN Node.
> +
> +	The returned Network_Interface parameter is a nul-terminated
> +	string containing the created network interface name.
> +
> +	This command generates a Command Complete event on success
> +	or failure.
> +
> +	Possible errors:	Busy
> +				Invalid Parameters
> +				Not Powered
> +				Invalid Index
> +
> +
> +Disconnect Command
> +==================
> +
> +	Command Code:		0x0005
> +	Controller Index:	<controller id>
> +	Command Parameters:	Address (6 Octets)
> +				Address_Type (1 Octet)
> +	Return Parameters:	Address (6 Octets)
> +				Address_Type (1 Octet)
> +
> +	This command is used to disconnect from a remote 6LoWPAN Node.
> +
> +	This command generates a Command Complete event on success
> +	or failure.
> +
> +	Possible errors:	Busy
> +				Not Connected
> +				Invalid Parameters
> +				Not Powered
> +				Invalid Index
> +
> +
> +Start Node Command
> +==================
> +
> +	Command Code:		0x0005
> +	Controller Index:	<controller id>
> +	Command Parameters:
> +	Return Parameters:
> +
> +	This command is used create a 6LoWPAN Node for a specified
> +	controller.
> +
> +	This command generates a Command Complete event on success or
> +	a Command Status event on failure.
> +
> +	Possible errors:	Busy
> +				Invalid Index
> +
> +
> +Stop Node Command
> +=================
> +
> +	Command Code:		0x0006
> +	Controller Index:	<controller id>
> +	Command Parameters:
> +	Return Parameters:
> +
> +	This command is used to stop a 6LoWPAN Node for a specified
> +	controller.
> +
> +	This command generates a Command Complete event on success or
> +	a Command Status event on failure.
> +
> +	Possible errors:	Rejected
> +				Invalid Index

Generally I think Set Node and Set Router seems to be the more obvious commands here. And they could have then also returned the information about the changed Current_Features / Current_Settings.

> +
> +
> +Command Complete Event
> +======================
> +
> +	Event Code:		0x0001
> +	Controller Index:	<controller id> or <non-controller>
> +	Event Parameters:	Command_Opcode (2 Octets)
> +				Status (1 Octet)
> +				Return_Parameters
> +
> +	This event is an indication that a command has completed. The
> +	fixed set of parameters includes the opcode to identify the
> +	command that completed as well as a status value to indicate
> +	success or failure. The rest of the parameters are command
> +	specific and documented in the section for each command
> +	separately.
> +
> +
> +Command Status Event
> +====================
> +
> +	Event Code:		0x0002
> +	Controller Index:	<controller id> or <non-controller>
> +	Event Parameters:	Command_Opcode (2 Octets)
> +				Status (1 Octet)
> +
> +	The command status event is used to indicate an early status for
> +	a pending command. In the case that the status indicates failure
> +	(anything else except success status) this also means that the
> +	command has finished executing.

I would include the Controller Error event to allow us to indicate controller errors.

> +
> +
> +Index Added Event
> +=================
> +
> +	Event Code:		0x0003
> +	Controller Index:	<controller id>
> +	Event Parameters:	Supported_Features (4 octets)
> +
> +	This event indicates that a new controller has been added to the
> +	system that can be used for 6LoWPAN.
> +
> +	The Supported_Features is a bitmask with the following available
> +	bits:
> +
> +		0	Node Role Supported
> +		1	Router Role Supported
> +
> +
> +Index Removed Event
> +===================
> +
> +	Event Code:		0x0004
> +	Controller Index:	<controller id>
> +	Event Parameters:
> +
> +	This event indicates that a 6LoWPAN-capable controller has been
> +	removed from the system.

As said above, these two I would have kept exactly as is with the current interface. Just tell about the new index. That  has been working out nicely.

We might actually want to move the whole common set of parameters into a common document that provides the basics and these common commands and events. Then each individual document can focus on its part.

> +
> +
> +6LoWPAN Connected Event
> +=======================
> +
> +	Event Code:		0x0005
> +	Controller Index:	<controller id>
> +	Event Parameters:	Address (6 Octets)
> +				Address_Type (1 Octet)
> +				Role (1 Octet)
> +				Interface_Name (16 Octets)

The interface makes really no sense here. That is fixed and always the same for the controller id. These information need to be provided differently in the common info set.

> +
> +	This event indicates that a successful 6LoWPAN connection has
> +	been created to the remote device.
> +
> +	Possible values for the Address_Type parameter:
> +		1	LE Public
> +		2	LE Random
> +
> +	For devices using resolvable random addresses with a known
> +	identity resolving key, the Address and Address_Type will
> +	contain the identity information.
> +
> +	The Role parameter indicates which role the local system has for
> +	the connection. The parameter has the following possible values:
> +		0x00	Node
> +		0x01	Router

Why local system? Don't we actually know that information. I am really not getting this event.

> +
> +	The Network_Interface parameter is a nul-terminated
> +	string containing the created network interface name.
> +
> +
> +6LoWPAN Disconnected Event
> +==========================
> +
> +	Event Code:		0x0006
> +	Controller Index:	<controller id>
> +	Event Parameters:	Address (6 Octets)
> +				Address_Type (1 Octet)
> +				Role (1 Octet)
> +				Reason (1 Octet)
> +
> +	This event indicates that the 6LoWPAN connection was lost to a
> +	remote device.
> +
> +	Possible values for the Address_Type parameter:
> +		1	LE Public
> +		2	LE Random
> +
> +	For devices using resolvable random addresses with a known
> +	identity resolving key, the Address and Address_Type will
> +	contain the identity information.
> +
> +	The Role parameter indicates which role the local system has for
> +	the connection. The parameter has the following possible values:
> +		0x00	Node
> +		0x01	Router
> +
> +	Possible values for the Reason parameter:
> +		0	Unspecified
> +		1	Connection timeout
> +		2	Connection terminated by local host
> +		3	Connection terminated by remote host

The obvious missing event is when Current_Features change or the service as node or router has been activated. We really want to communicate this kind of information.

Regards

Marcel

