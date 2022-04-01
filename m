Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9502AC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Apr 2022 17:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349827AbiDARXK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Apr 2022 13:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349774AbiDARXF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Apr 2022 13:23:05 -0400
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A45AEC6802
        for <linux-bluetooth@vger.kernel.org>; Fri,  1 Apr 2022 10:21:13 -0700 (PDT)
Received: from smtpclient.apple (p4ff9fa3c.dip0.t-ipconnect.de [79.249.250.60])
        by mail.holtmann.org (Postfix) with ESMTPSA id C013BCED02;
        Fri,  1 Apr 2022 19:21:11 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH BlueZ 1/2] docs: Add support for Mesh Scanning and Sending
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220331182653.465828-1-brian.gix@intel.com>
Date:   Fri, 1 Apr 2022 19:21:11 +0200
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <248EF762-97D2-4484-A333-B19BFDC912A0@holtmann.org>
References: <20220331182653.465828-1-brian.gix@intel.com>
To:     Brian Gix <brian.gix@intel.com>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
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
> ---
> doc/mgmt-api.txt | 170 +++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 170 insertions(+)
> 
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index ebe56afa4..2da89e2f3 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -332,6 +332,7 @@ Read Controller Information Command
> 		15	Static Address
> 		16	PHY Configuration
> 		17	Wideband Speech

we need to leave 18 to Quality Reporting.

> +		18	Mesh Mode
> 
> 	This command generates a Command Complete event on success or
> 	a Command Status event on failure.
> @@ -3858,6 +3859,128 @@ Add Advertisement Patterns Monitor With RSSI Threshold Command
> 				Invalid Parameters
> 

Lets leave 0x0057 to Set Quality Report command.

> 
> +Set Mesh Receiver Command
> +=========================
> +
> +	Command Code:		0x0057
> +	Controller Index:	<controller id>
> +	Command Parameters:	Enable (1 Octets)
> +				Window (2 Octets)
> +				Period (2 Octets)
> +				Num AD Types (1 Octets)
> +				AD Types (variable)
> +
> +	This command Enables or Disables Mesh Receiving. When enabled passive
> +	scanning remains enabled for this controller.
> +
> +	The Window/Period values are used to set the Scan Parameters when no
> +	other scanning is being done.
> +
> +	Num AD Types and AD Types parameter, filter Advertising and Scan
> +	responses by AD type. Reponses that do not contain at least one of the
> +	requested AD types will be ignored. Otherwise they will be delivered
> +	with the Mesh Device Found event.
> +
> +	Possible errors:	Failed
> +				No Resources
> +				Invalid Parameters
> +
> +Read Mesh Features Command
> +==========================
> +
> +	Command Code:		0x0058
> +	Controller Index:	<controller id>
> +	Command Parameters:
> +	Return Parameters:	Index (2 Octets)
> +				Max Handles (1 Octets)
> +				Used Handles (1 Octets)
> +				Handle (variable)
> +
> +	This command is used to both verify that Outbound Mesh packet
> +	support is enabled, and to indicate the number of packets that
> +	can and are simultaneously queued.
> +
> +	Index identifies the HCI Controller that this information is valid for.

Scrap the Index. It is already present the basic mgmt frame structure.

> +
> +	Max Handles indicates the maximum number of packets that may be queued.
> +
> +	Used Handles indicates the number of packets awaiting transmission.
> +
> +	Handle is an array of the currently outstanding packets.
> +
> +	Possible errors:	Failed
> +				No Resources
> +				Invalid Parameters

I rather have 0x0058 Read Mesh Features, 0x0059 Set Mesh Receiver, 0x005a Transmit Mesh Packet and 0x005b Cancel Transmit Mesh Packet.

> +
> +Transmit Mesh Packet Command
> +============================
> +
> +	Command Code:		0x0059
> +	Controller Index:	<controller id>
> +	Command Parameters:	Addr (6 octets)
> +				Addr Type (1 Octets)
> +				Instant (8 Octets)
> +				Delay (2 Octets)
> +				Count (1 Octets)
> +				Data (variable)
> +	Return Parameters:	Handle
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
> +	at the earliest opportunity. If non-Zero, and the controller supports
> +	delayed delivery, the Instant and Delay parameters will be used
> +	to delay the outbound packet. While the Instant is not defined, the
> +	Delay is specified in milliseconds.
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
> +===================================
> +
> +	Command Code:		0x005A
> +	Controller Index:	<controller id>
> +	Command Parameters:	Handle (1 octets)
> +
> +	This command may be used to cancel an outbound transmission request.
> +
> +	The Handle parameter is the returned handle from a successful Transmit
> +	Mesh Packet request. If Zero is specified as the handle, all outstanding
> +	send requests are canceled.
> +
> +	For each mesh packet canceled, the Mesh Packet Transmission Complete
> +	event will be generated, regardless of whether the packet was sent
> +	successfully.
> +
> +	Possible errors:	Failed
> +				Invalid Parameters
> +
> +
> Command Complete Event
> ======================
> 
> @@ -4978,3 +5101,50 @@ Advertisement Monitor Device Lost Event
> 		2	LE Random
> 
> 	This event will be sent to all management sockets.
> +
> +
> +Mesh Device Found Event
> +=======================
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
> +
> +	This event will be sent to all management sockets.

Describe the Flags field please.

> +
> +Mesh Packet Transmit Complete Event
> +===================================
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

