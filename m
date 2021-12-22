Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F41C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Dec 2021 08:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243340AbhLVIYR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Dec 2021 03:24:17 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:45756 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239634AbhLVIYQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Dec 2021 03:24:16 -0500
Received: from smtpclient.apple (p5b3d2e91.dip0.t-ipconnect.de [91.61.46.145])
        by mail.holtmann.org (Postfix) with ESMTPSA id 7BBC9CED09;
        Wed, 22 Dec 2021 09:24:15 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [RFC BlueZ] Bluetooth: Add support for Mesh Scanning and Sending
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211217212542.372210-1-brian.gix@intel.com>
Date:   Wed, 22 Dec 2021 09:24:14 +0100
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <5B8DC5BF-E90C-4619-9650-2D0374796D79@holtmann.org>
References: <20211217212542.372210-1-brian.gix@intel.com>
To:     Brian Gix <brian.gix@intel.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

> Adds two new MGMT Commands:
> 	- MESH_MODE - Enable Mesh Mode with either Active or Passive
> 	scanning for a list of AD Types (Mesh and/or Extended Mesh).
> 
> 	- MESH_SEND - Send a requested Mesh Packet on a non-resolvable
> 	random address, perhaps with a specific fine-timed delay.
> 
> Adds one new MGMT Event:
> 	- MESH_DEVICE_FOUND - Returned when Mesh is enabled, and one of
> 	  the requested AD Types is detected in an incoming
> 	  Advertisement.
> 
> Signed-off-by: Brian Gix <brian.gix@intel.com>
> ---
> doc/mgmt-api.txt | 119 +++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 119 insertions(+)
> 
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index ebe56afa4..3c34d6fb9 100644
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
> @@ -3858,6 +3859,90 @@ Add Advertisement Patterns Monitor With RSSI Threshold Command
> 				Invalid Parameters
> 

also introduce a Read Mesh Features command. And things like Available Slots should go there.

> 
> +Set controller to Mesh mode Command
> +==============================================================
> +
> +	Command Code:		0x0057
> +	Controller Index:	<controller id>
> +	Command Parameters:	Enable (1 Octet)
> +				Active (1 Octet)
> +				AD Types { }
> +	Return Parameters:	Available Slots (1 Octet)
> +
> +	This command Enables or Disables Mesh Mode. Mesh mode, when enabled
> +	keeps the controller passivly or actively scanning for LE Advertising
> +	messgaes. To enable Mesh, LE must be enabled.
> +
> +	The Active parameter when set to 0x01, will cause the controller to
> +	perform active scanning, as opposed to passive scanning, when the
> +	parameter is set to 0x00.
> +
> +	The AD Types parameter, if present, will filter Advertising and Scan
> +	responses by AD type. reponses that do not contain at least one of the
> +	requested AD types will be discarded. response results will be delivered
> +	with the Mesh Device Found event.
> +
> +	This command may be called redundantly to switch between Active and
> +	Passive scanning, without disabling Mesh mode. If Mesh mode is disabled,
> +	all active outbound Mesh Packet Send requests will return fail codes.
> +
> +	The returned parameter Available Slots returns the number of
> +	simultaneous outbound packets that may to queued for delivery.
> +
> +	Possible errors:	Failed
> +				Busy
> +				No Resources
> +				Invalid Parameters

I would call this Set Mesh Receiver. I think we are going to reconfigure this at runtime for different AD types depending on our mode.

However I do not get the Active part. I don’t want any Mesh Receiver that set the device to active scan. That is crazy. If you for some reason want active scanning, then enable the mesh receiver and start a discovery procedure. If the mesh receiver is marked as active it should report out any mesh packet, no matter how it got it. However for basic mesh operation we will do passive scanning.

We also need to introduce scanning parameters via the settings so that we can overwrite the defaults.

I think trying to bundle receiving with sending is a bit pointless and too much of a policy. Let userspace handle that.

> +
> +
> +Mesh Packet Send Command
> +==============================================================
> +
> +	Command Code:		0x0058
> +	Controller Index:	<controller id>
> +	Command Parameters:	Reference (1 Octets)
> +				Instant (4 Octets)
> +				Delay (2 Octets)
> +				Count (1 Octets)
> +				Data { }
> +	Return Parameters:	Status, Reference Value
> +
> +	This command sends a Mesh Packet as a NONCONN LE Advertisement. Mesh
> +	mode must be enabled.
> +
> +	The Reference value is Host defined, and will be returned with the
> +	status, so that the Host may have multiple requests outstanding at
> +	the same time. The Reference value will not be interpretted by the
> +	kernel.
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
> +	This command will return only after the outbound packet has been sent,
> +	or it fails.
> +
> +	Possible errors:	Failed
> +				Busy
> +				No Resources
> +				Invalid Parameters
> +
> +

I would call this Transmit Mesh Packet.

For the Reference, I am not convinced it is a good idea to have this come from userspace. We have to take extra care then of checking for duplicates or other weird things. Let the kernel just return a reference that can be used. I also tend to call this Handle.

You are also missing then the Mesh Packet Transmission Complete event.

I think we should also include the Address and Address_Type and let userspace generate these. Or at least allow it specify one and only let the kernel generate one in case of BDADDR_ANY. I want to give this API a chance to survive in case newer specs want to play with using RPAs.

> Command Complete Event
> ======================
> 
> @@ -4978,3 +5063,37 @@ Advertisement Monitor Device Lost Event
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
> +
> +	This event will be sent to all management sockets.

We need to think about if the Instant might be better as 64-bit value or if we want to handle the 32-bit overrun internally.

Regards

Marcel

