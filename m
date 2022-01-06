Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522A3C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Jan 2022 20:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243763AbiAFUlg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Jan 2022 15:41:36 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:39916 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232673AbiAFUlg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Jan 2022 15:41:36 -0500
Received: from smtpclient.apple (p4fefca45.dip0.t-ipconnect.de [79.239.202.69])
        by mail.holtmann.org (Postfix) with ESMTPSA id 4EAEECECDD;
        Thu,  6 Jan 2022 21:41:35 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [RFC BlueZ v2] Bluetooth: Add support for Mesh Scanning and
 Sending
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211231003208.2530079-1-brian.gix@intel.com>
Date:   Thu, 6 Jan 2022 21:41:34 +0100
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <692337DA-DCE5-4354-AB5A-161D9F824A0E@holtmann.org>
References: <20211231003208.2530079-1-brian.gix@intel.com>
To:     Brian Gix <brian.gix@intel.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

> Adds four new MGMT Commands:
> 	- MESH_RECEIVER - Enable Mesh Receiver with Passive scanning
> 	  with a list of AD Types (Mesh and/or Extended Mesh).
> 
> 	- MESH_FEATURES - Requests information on how many simultaneous
> 	  outbound  mesh packets can be pending at one time.
> 
> 	- MESH_TX_PACKET - Send a requested Mesh Packet, perhaps with a
> 	  specific fine-timed delay.
> 
> 	- MESH_TX_CANCEL - Cancel a prior Mesh TX request that has not
> 	  yet completed.
> 
> Adds two new MGMT Events:
> 	- MESH_DEVICE_FOUND - Returned when Mesh is enabled, and one of
> 	  the requested AD Types is detected in an incoming
> 	  Advertisement.
> 
> 	- MESH_TX_COMPLETE - Reports that a prior requested transmission
> 	  has completed and no longer consumes one of the available
> 	  outbound slots.
> 
> Signed-off-by: Brian Gix <brian.gix@intel.com>
> ---
> doc/mgmt-api.txt | 161 +++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 161 insertions(+)
> 
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index ebe56afa4..1833f178b 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -332,6 +332,7 @@ Read Controller Information Command
> 		15	Static Address
> 		16	PHY Configuration
> 		17	Wideband Speech
> +		18	Mesh Mode
> 
> 	This command generates a Command Complete event on success or
> 	a Command Status event on failure.
> @@ -3858,6 +3859,120 @@ Add Advertisement Patterns Monitor With RSSI Threshold Command
> 				Invalid Parameters
> 
> 
> +Set Mesh Receiver Command
> +==============================================================\

The === should be length of the command name. Lets be consistent.

> +
> +	Command Code:		0x0057
> +	Controller Index:	<controller id>
> +	Command Parameters:	Enable (1 Octet)
> +				Window (2 Octets)
> +				Period (2 Octets)
> +				AD Types { variable }

We do Num_AD_Types followed by the variable data length.

> +	Return Parameters:	Status

Status is not needed. We always have a a status. It we are consistent with some of the other commands we return Current_Settings and with thus indicate that Mesh Mode is active. We can discuss this a bit since we might not want to actually use Mesh Mode in Controller Information.

> +
> +	This command Enables or Disables Mesh Mode. Mesh mode, when enabled
> +	keeps the controller passivly scanning for LE Advertising packets.
> +	To enable Mesh, LE must first be enabled.
> +
> +	The Window/Period values are used to set the Scan Parameters when no
> +	other scanning is being done.
> +
> +	The AD Types parameter, if present, will filter Advertising and Scan
> +	responses by AD type. reponses that do not contain at least one of the
> +	requested AD types will be discarded. Response results will be delivered
> +	with the Mesh Device Found event.
> +
> +	This command may be used redundantly to set new filtering AD Types.

You need to be a bit more detailed and describes the Enable types and ranged for Window and Period etc.

> +
> +	Possible errors:	Failed
> +				No Resources
> +				Invalid Parameters
> +
> +Read Mesh Features Command
> +==============================================================
> +
> +	Command Code:		0x0058
> +	Controller Index:	<controller id>
> +	Command Parameters:
> +	Return Parameters:	Status, Used slots, Total slots
> +
> +	This command is used to request the count of outbound packet slots
> +	which may be simultaneously requested.
> +
> +	Used slots (1 octet) contains the count of packets currently awaiting
> +	transmission.
> +

I think this better done this way:

	Max_Handles
	Num_Handles
	Handles[i]

The Status here is pointless since we have that anyway. However we might need to indicate support for advertising extension and other bearer. So we need to make the future proof.

> +	Total slots contains (1 octet) contains the total number of packets
> +	that can be pending at one time.
> +
> +	Possible errors:	Failed
> +				No Resources
> +				Invalid Parameters
> +
> +Transmit Mesh Packet Command
> +==============================================================
> +
> +	Command Code:		0x0059
> +	Controller Index:	<controller id>
> +	Command Parameters:	Addr (6 octets)
> +				Addr Type (1 Octets)
> +				Instant (4 Octets)
> +				Delay (2 Octets)
> +				Count (1 Octets)
> +				Data { }
> +	Return Parameters:	Status, Handle

Status is not required.

> +
> +	This command sends a Mesh Packet as a NONCONN LE Advertisement.
> +
> +	The Addr + Addr Type parameters specifify the address to use in the
> +	outbound advertising packet. If BD_ADDR_ANY and LE_RANDOM is set, the
> +	kernel will create a single use non-resolvable address.
> +
> +	The Instant parameter is used in combination with the Delay
> +	parameter, to finely time the sending of the Advertising packet. It
> +	should be set to the Instant value tag of a received incoming
> +	Mesh Device Found Event. It is only useful in POLL-RESPONSE situations
> +	where a response must be sent within a negotiated time window. The value
> +	of the Instant parameter should not be interpreted by the host, and
> +	only has meaning to the controller.
> +
> +	The Delay parameter, if 0x0000, will cause the packet to be sent
> +	immediately, or at the earliest opportunity. If non-Zero, it will
> +	attempt to send the packet the requested number of milliseconds after
> +	the instant in time represented by the Instant parameter.
> +
> +	The Count parameter must be sent to a non-Zero value indicating the
> +	number of times this packet will be sent before transmission completes.
> +	If the Delay parameter is non-Zero, then Count must be 1 only.
> +
> +	The Data parameter is an octet array of the AD Type and Mesh Packet.
> +
> +	This command will return immediately, and if it succeeds, will generate
> +	a Mesh Packet Transmission Complete event when after the packet has been
> +	sent.
> +
> +	Possible errors:	Failed
> +				Busy
> +				No Resources
> +				Invalid Parameters
> +
> +Cancel Transmit Mesh Packet Command
> +==============================================================
> +
> +	Command Code:		0x005A
> +	Controller Index:	<controller id>
> +	Command Parameters:	Handle (2 octets)
> +	Return Parameters:	Status

Same here. And I think Handle should be just 1 Octet.

> +
> +	This command may be used to cancel an outbound transmission request.
> +
> +	The Handle parameter is the returned handle from a successful Transmit
> +	Mesh Packet request.
> +
> +	Possible errors:	Failed
> +				Invalid Parameters
> +
> +
> Command Complete Event
> ======================
> 
> @@ -4978,3 +5093,49 @@ Advertisement Monitor Device Lost Event
> 		2	LE Random
> 
> 	This event will be sent to all management sockets.
> +
> +Mesh Device Found Event
> +========================================
> +
> +	Event code:		0x0031
> +	Controller Index:	<controller_id>
> +	Event Parameters:	Address (6 Octets)
> +				Address_Type (1 Octet)
> +				RSSI (1 Octet)
> +				Flags (4 Octets)
> +				Instant (4 Octets)
> +				AD_Data_Length (2 Octets)
> +				AD_Data (0-65535 Octets)
> +
> +	This event indicates that the controller has received an Advertisement
> +	or Scan Result containing an AD Type matching the Mesh scan set.
> +
> +	The address of the sending device is returned, and must be a valid LE
> +	Address_Type.
> +
> +	Possible values for the Address_Type parameter:
> +		0	Reserved (not in use)
> +		1	LE Public
> +		2	LE Random
> +
> +	The RSSI field is a signed octet, and is the RSSI reported by the
> +	receiving controller.
> +
> +	The Instant field is 32 bit value that represents the instant in time
> +	the packet was received. It's value is not intended to be interpretted
> +	by the host, and is only useful if the host wants to make a timed
> +	response to the received packet. (i.e. a Poll/Response)

Didn’t you want to make the Instant 64-bit?

> +
> +	This event will be sent to all management sockets.
> +
> +Mesh Packet Transmit Complete Event
> +========================================
> +
> +	Event code:		0x0032
> +	Controller Index:	<controller_id>
> +	Event Parameters:	Handle (2 Octets)
> +
> +	This event indicates that a requested outbound Mesh packet has
> +	completed and no longer occupies a transmit slot.
> +
> +	This event will be sent to all management sockets.

Regards

Marcel

