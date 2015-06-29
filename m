Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [RFC v3] doc: Add initial Network Management API definition
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1434962366-10791-1-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 29 Jun 2015 16:24:17 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <AAEF3A5A-CAFE-4C19-AFA6-A3BC9A8527B3@holtmann.org>
References: <1434962366-10791-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This was formerly known as "doc: Add initial 6LoWPAN API definition".
> It now has a more generic name so that other Networking profiles could
> potentially be included behind the same channel in the future. I've
> skipped event code 0x03 ("HW Error") since we couldn't reach concensus
> there. So 0x03 is effectively a "reserved" value for now.
> 
> Makefile.am              |   2 +-
> doc/network-mgmt-api.txt | 326 +++++++++++++++++++++++++++++++++++++++++++++++
> 2 files changed, 327 insertions(+), 1 deletion(-)
> create mode 100644 doc/network-mgmt-api.txt
> 
> diff --git a/Makefile.am b/Makefile.am
> index 76d17239783f..d322117dabec 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -243,7 +243,7 @@ EXTRA_DIST += doc/assigned-numbers.txt doc/supported-features.txt \
> 				doc/test-runner.txt \
> 				doc/settings-storage.txt
> 
> -EXTRA_DIST += doc/mgmt-api.txt \
> +EXTRA_DIST += doc/mgmt-api.txt doc/network-mgmt-api.txt \
> 		doc/adapter-api.txt doc/device-api.txt \
> 		doc/agent-api.txt doc/profile-api.txt \
> 		doc/network-api.txt doc/media-api.txt \
> diff --git a/doc/network-mgmt-api.txt b/doc/network-mgmt-api.txt
> new file mode 100644
> index 000000000000..29e506c8283b
> --- /dev/null
> +++ b/doc/network-mgmt-api.txt
> @@ -0,0 +1,326 @@
> +Network Management API
> +**********************
> +
> +Copyright (C) 2015  Intel Corporation
> +
> +
> +Overview
> +========
> +
> +The Network Management API follows largely the same principles as the main
> +Bluetooth Management API described in mgmt-api.txt. The main difference is
> +a separate namespace for command and event codes, distinguished by using
> +HCI_CHANNEL_NETWORK rather than HCI_CHANNEL_CONTROL when creating the mgmt
> +socket.
> +
> +
> +Read Version Information Command
> +================================
> +
> +	Command Code:		0x0001
> +	Controller Index:	<non-controller>
> +	Command Parameters:
> +	Return Parameters:	Version (1 Octets)
> +				Revision (2 Octets)
> +
> +	This command returns the Network Management version and
> +	revision. In addition to being informational the information can
> +	be used to determine whether certain behavior has changed or
> +	bugs fixed when interacting with the kernel.
> +
> +	This command generates a Command Complete event on success or
> +	a Command Status event on failure.
> +
> +
> +Read Supported Commands Command
> +===============================
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
> +	This command returns the list of supported Network commands
> +	and events.
> +
> +	The commands Read Version Information and Read Supported
> +	Commands are not included in this list. Both commands are always
> +	supported and mandatory.
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
> +
> +	This command returns the list of currently known controllers
> +	that can be used for Network connections. Controllers added or
> +	removed after calling this command can be monitored using the
> +	Index Added and Index Removed events.
> +
> +	This command generates a Command Complete event on success or
> +	a Command Status event on failure.
> +
> +
> +Read Controller Information Command
> +===================================
> +
> +	Command Code:		0x0004
> +	Controller Index:	<controller id>
> +	Command Parameters:
> +	Return Parameters:	Address (6 Octets)
> +				Address_Type (6 Octets)
> +				Supported_Settings (4 Octets)
> +				Current_Settings (4 Octets)
> +				6LoWPAN_Interface_Index (4 Octets)
> +
> +	This command is used to retreive the current state and basic
> +	information of a controller. It is typically used right after
> +	getting the response to the Read Controller Index List command
> +	or an Index Added event.
> +
> +	Current_Settings and Supported_Settings is a bitmask with
> +	currently the following available bits:
> +
> +		0	6LoWPAN
> +		1	6LoWPAN Server (Node)
> +
> +	The 6LoWPAN_Interface_Index parameter value is only valid if the
> +	6LoWPAN settings bit is set in the Current_Settings, otherwise
> +	it should be ignored.

I have no idea what this is going to do. I wonder if should really have this in this command. Especially since the index might be even there if it is not enabled yet. This sound more like a parameter that should be returned by an individual command or when enabling the 6LoWPAN support.

On a site note, we might need to stay away from calling this 6LoWPAN since the IETF is not even sure how they want to name stuff. Some comments say that 6LoWPAN is for 802.15.4 and 6LoBTLE or similar will be for LE. So it might be better to start using generic terms like 6lo, IPv6 and IPSP.

> +	This command generates a Command Complete event on success or
> +	a Command Status event on failure.
> +
> +	Possible errors:	Invalid Parameters
> +				Invalid Index
> +
> +
> +Connect 6LoWPAN Command
> +=======================
> +
> +	Command Code:		0x0005
> +	Controller Index:	<controller id>
> +	Command Parameters:	Address (6 Octets)
> +				Address_Type (1 Octet)
> +	Return Parameters:	Address (6 Octets)
> +				Address_Type (1 Octet)
> +
> +	This command is used to connect to a remote 6LoWPAN Node.

Same as above, we might better just call this IPSP or Connect Internet Protocol.

One additional thing could be that we just return the interface index this new connection is using. I think that could be beneficial. Especially if we would actually create the 6lo interface for each controller on demand. Which might makes sense in case we only ever have client connections.

> +
> +	Possible values for the Address_Type parameter:
> +		1	LE Public
> +		2	LE Random
> +
> +	This command generates a Command Complete event on success
> +	or failure.
> +
> +	Possible errors:	Busy
> +				Refused
> +				Invalid Parameters
> +				Not Powered
> +				Invalid Index

Don't we miss an already connected error here?

> +
> +
> +Disconnect 6LoWPAN Command
> +==========================
> +
> +	Command Code:		0x0006
> +	Controller Index:	<controller id>
> +	Command Parameters:	Address (6 Octets)
> +				Address_Type (1 Octet)
> +	Return Parameters:	Address (6 Octets)
> +				Address_Type (1 Octet)
> +
> +	This command is used to disconnect from a remote 6LoWPAN device.
> +
> +	Possible values for the Address_Type parameter:
> +		1	LE Public
> +		2	LE Random
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
> +Get 6LoWPAN Connections Command
> +===============================
> +
> +	Command Code:		0x0007
> +	Controller Index:	<controller id>
> +	Command Parameters:
> +	Return Parameters:	Connection_Count (2 Octets)
> +				Address1 {
> +					Address (6 Octets)
> +					Address_Type (1 Octet)
> +				}
> +				Address2 { }
> +				...

We could include the interface index here. Since you really want to know the interface index and what connections belong to it.

> +
> +	This command is used to retrieve a list of currently connected
> +	6LoWPAN devices.
> +
> +	Possible values for the Address_Type parameter:
> +		1	LE Public
> +		2	LE Random
> +
> +	For devices using resolvable random addresses with a known
> +	identity resolving key, the Address and Address_Type will
> +	contain the identity information.
> +
> +	This command can only be used when the controller is powered.
> +
> +	This command generates a Command Complete event on success or
> +	a Command Status event on failure.
> +
> +	Possible errors:	Invalid Parameters
> +				Not Powered
> +				Invalid Index
> +
> +
> +Enable 6LoWPAN Server Command
> +=============================
> +
> +	Command Code:		0x0008
> +	Controller Index:	<controller id>
> +	Command Parameters:	Enable (1 Octet)
> +	Return Parameters:	Current_Settings (4 Octets)

As mentioned above, I might have included the interface index here.

> +
> +	This command is used start a 6LoWPAN Server (Node rols) on a
> +	specified controller.
> +
> +	This command generates a Command Complete event on success or
> +	a Command Status event on failure.
> +
> +	Possible errors:	Busy
> +				Invalid Index

Since this does enable and disable, I think this should be rather called Set Internet Protocol Gateway or something similar. I am even fine with using the terms client and server.

I think we also want this command to start advertising. So it should grab an instance in the multi-advertising feature and add the IPSP service. Might be also an option to the command to selective choose if it advertises. Maybe as 0x02 option.

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
> +
> +
> +Index Added Event
> +=================
> +
> +	Event Code:		0x0004
> +	Controller Index:	<controller id>
> +	Event Parameters:
> +
> +	This event indicates that a new Networking capable controller
> +	has been added to the system. It is usually followed by a Read
> +	Controller Information command.
> +
> +
> +Index Removed Event
> +===================
> +
> +	Event Code:		0x0005
> +	Controller Index:	<controller id>
> +	Event Parameters:
> +
> +	This event indicates that a Network-capable controller has been
> +	removed from the system.
> +
> +
> +New Settings Event
> +==================
> +
> +	Event Code:		0x0006
> +	Controller Index:	<controller id>
> +	Event Parameters:	Current_Settings (4 Octets)
> +
> +	This event indicates that one or more of the settings for a
> +	controller has changed.
> +
> +
> +6LoWPAN Connected Event
> +=======================
> +
> +	Event Code:		0x0007
> +	Controller Index:	<controller id>
> +	Event Parameters:	Address (6 Octets)
> +				Address_Type (1 Octet)
> +
> +	This event indicates that a successful 6LoWPAN connection has
> +	been created to the remote device.
> +
> +	For devices using resolvable random addresses with a known
> +	identity resolving key, the Address and Address_Type will
> +	contain the identity information.

This would also be a good candidate for including the interface index.

> +
> +
> +6LoWPAN Disconnected Event
> +==========================
> +
> +	Event Code:		0x0008
> +	Controller Index:	<controller id>
> +	Event Parameters:	Address (6 Octets)
> +				Address_Type (1 Octet)
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
> +	Possible values for the Reason parameter:
> +		0	Unspecified
> +		1	Connection timeout
> +		2	Connection terminated by local host
> +		3	Connection terminated by remote host

I wonder what we are doing with this reason. The core API had some good uses for this. I am not sure this one is a good one.

The way I am seeing this is that we should have an automatic mode to connect to all IPSP service we find. Which of course means we keep scanning in the background. And another one where the kernel scans and connects to known device. So something similar to Add Device where userspace that includes known devices and then the kernel will connect them when found. We could include a limited to only connect to n device. So by default only 1 IPSP device and when disconnected, it tries to find another one.

Regards

Marcel

