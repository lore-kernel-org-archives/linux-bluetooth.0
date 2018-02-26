Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH BlueZ 1/1 v2] Add initial doc describing Bluetooth Mesh
 API
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180218064819.23459-2-inga.stotland@intel.com>
Date: Mon, 26 Feb 2018 14:49:42 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <7EA4BC6E-29F5-440E-9D61-0EECE796AB6E@holtmann.org>
References: <20180218064819.23459-1-inga.stotland@intel.com>
 <20180218064819.23459-2-inga.stotland@intel.com>
To: Inga Stotland <inga.stotland@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Inga,

> ---
> doc/mesh-api.txt | 269 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 269 insertions(+)
> create mode 100644 doc/mesh-api.txt
> 
> diff --git a/doc/mesh-api.txt b/doc/mesh-api.txt
> new file mode 100644
> index 000000000..87311faba
> --- /dev/null
> +++ b/doc/mesh-api.txt
> @@ -0,0 +1,269 @@
> +Bluetooth Mesh Socket API
> +*************************
> +
> +Copyright (C) 2018 Intel Corporation. All rights reserved.
> +
> +This document decribes the data format that is used for communication with
> +the kernel via Bluetooth Mesh socket. The data that are passed over this
> +type of a socket is specific to Bluetooth Mesh Profile.
> +
> +The Bluetooth Mesh socket is implemented as part of PF_BLUETOOTH family
> +and can be created by opening a raw HCI socket with hci_channel set to
> +HCI_CHANNEL_BTMESH. The mesh socket requires the creating process to have

call this HCI_CHANNEL_MESH. There is no point in adding BT* here.

> +CAP_NET_ADMIN capability.
> +
> +===================================================
> +Packet Structure: user space to/from kernel (Tx/Rx)
> +===================================================
> +
> +Each packet to or from the Over-the-Air interface is sent between the user
> +space and the kernel must be of nonzero length, and start with the AD_Type,
> +followed by a variable amount of additional payload.
> +
> +	0               8
> +	+---------------+------------------------------------
> +	|  AD_Type      | Mesh Packet
> +	+---------------+——————————————————
> +

Actually I would have really preferred that we followed the Proxy PDU format.

	2 Bits reserved
	6 Bits packet type
	Variable data payload

I think that we really need the 0x02 type for configuration between the kernel and userspace.

> +AD_Type (1 octet -- Defined by the Bluetooth SIG)
> +=================
> +
> +Provisioning:	0x29 -	The payload contains a Mesh Provisioning message
> +Network:		0x2A -	The payload contains a Mesh Data Packet
> +Beacon:		0x2B -	The payload contains a Mesh Beacon
> +
> +The AD_Type values correspond to AD types introduced in Mesh Profile
> +specification. The API is designed to support additional types.
> +
> +
> +A packet with empty (Zero-Length) payload may be sent over the socket in case
> +when only Control ancillary data is needed (e.g., Flush or Scan, defined below).
> +
> +===============
> +Socket Options
> +===============
> +
> +HCI Mesh Scan Filter
> +====================
> +	Code:	0x05
> +
> +	Filter_Id		(1 octet)
> +	Duplicates		(1 octet)
> +	Filter			(variable length)
> +
> +Read/write socket option used to setup scan filters for mesh specific packets.
> +First octet of filter must include at least the AD_Type but may be longer to
> +include NIDs or other known data.

These ones look more like type 0x02 PDU packets. And this in particular I would have done as Add Network ID and Remove Network ID and let the kernel deal with deciding if it chooses a more global filter (since not enough filters are available) or if it can be more precise with the filtering.

> +
> +HCI Mesh Default Tx Power
> +=========================
> +	Code:	0x06
> +
> +	Tx_Power		(1 octet)
> +
> +Read/write socket option for setting default Tx power.

Leave this out for now. I assume initially we will always use 127 for do not care. If we think it is valuable for testing, then via debugfs.

> +
> +HCI Mesh Default Cahnnel Map
> +============================
> +	Code:	0x07
> +
> +	Chan_map		(1 octet)
> +
> +Read/write socket option for setting default channel map.

Also irrelevant and only for fine tuning and testing. Can be exposed via debugfs.

> +
> +HCI Mesh Accuracy
> +=================
> +	Code:	0x08
> +
> +	Accuracy		(1 octet)
> +
> +Read-only socket option to obtain the value of the smallest number of
> +milliseconds that a Mesh Friendship Offer Window can be, for guaranteed
> +Poll Response transmission within that window.

I still would have done this via type 0x02 and a PDU exchange protocol. Mainly because then it also becomes traceable via btmon. So yes, I want the mesh channel also be included in btmon.

> +
> +==================
> +Tx Ancillary Data
> +==================
> +
> +The information about which timing settings to use when sending a mesh
> +packet is contained in mandatory ancillary data accompanying the
> +payload. Exactly one of the following (mutually exclusive) ancillary
> +data types must be present with nonzero length Tx payload:
> +
> +Mesh Transmit Info
> +===================
> +
> +cmsg_level     cmsg_type             cmsg_data[]
> +--------------------------------------------------
> +SOL_BLUETOOTH  BTMESH_TX_INFO        Parameters

General format we started using is BT_* and so this should be BT_MESH_*

> +
> +	Code:	0x01
> +	Parameters:
> +		Count			(1 octet)
> +		Interval:		(2 octets)
> +		Min_Random_Delay:	(1 octet)
> +		Max_Random_Delay:	(1 octet)
> +
> +The retransmission parameters for a regular outgoing mesh message.
> +
> +Count is the total number of times to Tx. A Zero means Tx Until Canceled.
> +
> +Interval is the number of milliseconds between each Tx.
> +
> +Random Delay is milliseconds added before first Tx.
> +
> +Mesh Poll Transmit Info
> +=======================
> +
> +cmsg_level     cmsg_type              cmsg_data[]
> +---------------------------------------------------
> +SOL_BLUETOOTH  BTMESH_POLL_TX_INFO    Parameters
> +
> +	Code:	0x02
> +	Parameters:
> +		Scan_Delay		(1 octet)
> +		Scan_Duration		(1 octet)
> +		Filter_Ids[2]		(2 octets)
> +		Min_Random_Delay:	(1 octet)
> +		Max_Random_Delay:	(1 octet)
> +
> +Scan_Delay describes the wait period to begin scanning after the Poll message
> +is sent.
> +
> +Filter_Ids contain IDs of two filters that account for two possible values of
> +IV Update bit in expected Poll response.
> +
> +Random Delay is milliseconds added before Tx.
> +
> +Mesh Poll Response Transmit Info
> +================================
> +
> +cmsg_level     cmsg_type                cmsg_data[]
> +-----------------------------------------------------
> +SOL_BLUETOOTH  BTMESH_POLL_RSP_TX_INFO  Parameters
> +
> +	Code:	0x03
> +	Parameters:
> +		Instant		(4 octets)
> +		Delay		(1 octet)
> +
> +The timing parameters for sending a friend poll response.
> +
> +Instant is a 4-octet opaque value that corresponds to the instant an
> +associated incoming mesh message was recieved, for timing purposes.
> +
> +Delay defines number of milliseconds after the corresponding Instant
> +to wait before sending this Tx.
> +
> +____________________________________________________________________
> +
> +The following ancillary types are optional with nonzero length Tx payload:
> +
> +Transmit Power
> +==============
> +
> +cmsg_level     cmsg_type             cmsg_data[]
> +---------------------------------------------------------------
> +SOL_BLUETOOTH  BTMESH_TX_POWER_INFO  Parameters
> +
> +	Code:	0x04
> +	Parameters:
> +		Tx_Power	(1 octet)
> +
> +Transmit power setting can be used for finer control on the outbound messages.
> +If not present, use default value (builtin or configured as socket options).
> +
> +Transmit Channel
> +================
> +cmsg_level     cmsg_type               cmsg_data[]
> +---------------------------------------------------------------
> +SOL_BLUETOOTH  BTMESH_TX_CHANNEL_INFO  Parameters
> +
> +	Code:	0x05
> +	Parameters:
> +		Tx_Channel	(1 octet)
> +
> +The presence of this option specifies transmit channel and allows
> +for better control, e.g., to respond on the same
> +channel as the one on which incoming message has been received.
> +If not present, the default value will be used (builtin or configured as
> +socket options).

Don’t bother with these two at the moment. I think they have no use for us except for allowing some testing via debugfs. They needed to be in the HCI spec for completeness and because you can also use the HCI spec to build a mesh sniffer.

> +
> +
> +Additional the ancillary data portion may contain Control type information.
> +
> +The following are Control ancillary data types, that me be sent with or
> +without payloads:
> +
> +Scan
> +=======
> +cmsg_level     cmsg_type             cmsg_data[]
> +---------------------------------------------------------------
> +SOL_BLUETOOTH  BTMESH_SCAN           Parameters
> +
> +	Code:	0x06
> +	Parameters:
> +		Filter_Ids[]	(variable)
> +
> +To enable/disable scanning of Mesh packets.
> +
> +If Filter_Ids array is nonzero length, start scanning with the specified
> +filters (filters are initialized via socket options mechanism). This array
> +replaces any prior filters.
> +
> +If no filter IDs are present (i.e., zero array length), stop scanning.

I dislike this. We should have a type 0x02 command that tells us what kind of role we are operating in. And based on that scanning is enabled by binding the socket and closing it. Or changing the role. The whole filter id exposure seems a bit odd to me. I realize that this might look simple, but a few things should be done by the kernel. And managing the scanning filters is one of them. So we need to feed the kernel enough details that it can do that efficiently. Swapping filters around from userspace is painful.

Otherwise we could just expose HCI_CHANNEL_MESH as HCI mesh commands. They are all multiplexed via a single opcode anyway and have a single event with and event prefix. So if you want this detailed control of the HCI commands, then don’t try to put too much kernel in between. Just do path through of them.

We could do just that and then leave the kernel portion for this alone. Maybe it is worth while to debate pros and cons for this. It is actually not the worst idea to give exclusive access to the mesh commands. It would be similar to HCI_CHANNEL_USER, but only for the mesh commands and we would strip the HCI command header and HCI event header + event prefix off it so that you just have to deal with mesh opcode and mesh subevent code.

Hmmm .. it gets a bit tricky for the command complete portion of it. So it might have to be the full HCI anyway, but restricted to one opcode and only matching events being forwarded.

Actually if I spin my train of thoughts further now, we might want to put HCI_CHANNEL_MESH on ice and leave that for some future version. I think providing some sort of abstraction and automatic handling of scanning filters etc. is a good abstraction for the kernel, but it might be something that will take a while to be defined and working correctly. Doing the HCI mesh commands directly on a socket has the command complete problem as stated above and having yet another variation of HCI_CHANNEL_RAW with mesh HCI filters seems wrong as well. Especially since eventually I want to have an option to disable HCI_CHANNEL_RAW. In addition it would have been exclusive access to make sure nothing goes wrong.

So maybe we just expose HCI mesh commands as MGMT command and MGMT event.

Mesh Command
============

	Command Code:		0x0043
	Controller Index:	<controller index>
	Command Parameters:	Opcode (1 Octet)
				Command parameters (Variable)
	Return Parameters:	Status (1 Octet)
				Opcode (1 Octet)
				Return parameters (Variable)

Mesh Event
==========

	Event Code:		0x0026
	Controller Index:	<controller index>
	Event Parameters:	Subevent (1 Octet)
				Even parameters (variable)

This would map 1:1 to the HCI mesh commands and events with the tiny modification that the event prefix is stripped from the Mesh Event and not provided and with the Mesh Get Options command issued it would be mapped to event prefix length of zero.

And then only a settings 16 Mesh would be needed. Or we make the command and event only available when HCI mesh commands are actually supported. That is something that would needs to be discussing. In general, we have not had limited commands based on hardware functionality, but these two would be special since they are vendor specific commands in the first place.

For the kernel side we only have the the driver provide the mesh HCI opcode and run Mesh Get Options once to retrieve the firmwares event prefix so that it can be zeroed out by the MGMT commands and events.

With that comments? Thoughts?

Regards

Marcel

