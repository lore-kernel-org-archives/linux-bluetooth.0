Return-Path: <SRS0=+RU5=DC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BDFC4363D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Sep 2020 17:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 724C42344C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Sep 2020 17:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbgIYR6O convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 25 Sep 2020 13:58:14 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:37484 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgIYR6O (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 25 Sep 2020 13:58:14 -0400
Received: from [172.20.10.2] (dynamic-046-114-136-219.46.114.pool.telefonica.de [46.114.136.219])
        by mail.holtmann.org (Postfix) with ESMTPSA id EE4E7CECE0;
        Fri, 25 Sep 2020 20:05:09 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [Bluez PATCH v3 2/9] doc/mgmt-api: Add new MGMT interfaces to
 mgmt-api
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200924180838.Bluez.v3.2.If15d3d09724ded2bcc7240d29f6888f2ad12e723@changeid>
Date:   Fri, 25 Sep 2020 19:58:08 +0200
Cc:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <311BC779-4869-4092-B715-5D041F163192@holtmann.org>
References: <20200925011347.2478464-1-danielwinkler@google.com>
 <20200924180838.Bluez.v3.2.If15d3d09724ded2bcc7240d29f6888f2ad12e723@changeid>
To:     Daniel Winkler <danielwinkler@google.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Daniel,

> This patch adds the following to mgmt-api:
> - Add Extended Advertising Parameters Command
> - Add Extended Advertising Data Command
> - Changes Read Security Info to Read Controller Capabilities CMD
> 
> Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
> Reviewed-by: Alain Michaud <alainm@chromium.org>
> ---
> 
> Changes in v3:
> - Removed Tx Power Selected MGMT event
> - Changed Read Security Info cmd to  Read Controller Capabilities
> 
> Changes in v2:
> - Removed extra space in Add Extended Advertising Parameters API
> 
> doc/mgmt-api.txt | 229 +++++++++++++++++++++++++++++++++++++++++++++--
> 1 file changed, 223 insertions(+), 6 deletions(-)
> 
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index ca0d38469..85aa8b797 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -3110,19 +3110,19 @@ Set Wideband Speech Command
> 				Invalid Index
> 
> 
> -Read Security Information Command
> +Read Controller Capabilities Command
> =================================

I am fine with the name. Just extend the === to match the text above.

> 
> 	Command Code:		0x0048
> 	Controller Index:	<controller id>
> 	Command Parameters:
> -	Return Parameters:	Security_Data_Length (2 Octets)
> -				Security_Data (0-65535 Octets)
> +	Return Parameters:	Capabilities_Data_Length (2 Octets)
> +				Capabilities_Data (0-65535 Octets)
> 
> -	This command is used to retrieve the supported security features
> +	This command is used to retrieve the supported capabilities
> 	by the controller or the host stack.
> 
> -	The Security_Data_Length and Security_Data parameters provide
> +	The Capabilities_Data_Length and Capabilities_Data parameters provide
> 	a list of security settings, features and information. It uses
> 	the same format as EIR_Data, but with the namespace defined here.
> 
> @@ -3131,6 +3131,8 @@ Read Security Information Command
> 		0x01		Flags
> 		0x02		Max Encryption Key Size (BR/EDR)
> 		0x03		Max Encryption Key Size (LE)
> +		0x04		Min Supported LE Tx Power (dBm)
> +		0x05		Max Supported LE Tx Power (dBm)

I would actually prefer if we put them into a 2 octet size value. So two times s8 fields. And then just call it "Supported Tx Power (LE)”.

> 
> 	Flags (data type 0x01)
> 
> @@ -3146,6 +3148,15 @@ Read Security Information Command
> 		present, then it is unknown what the max encryption key
> 		size of the controller or host is in use.
> 
> +	Min/Max Supported LE Tx Power (data types 0x04 and 0x05)
> +
> +		These fields indicate the supported range of LE Tx Power in
> +		dBm across all supported PHYs. These values are populated
> +		by the return of the LE Read Transmit Power HCI command. If
> +		this HCI command is not available, the values default to
> +		0x7F, indicating HCI_TX_POWER_INVALID, as a valid range
> +		is not available.
> +

Actually no. If the command is not available or failed, then this field will not be present. Clearly indicate the absence. The should be a clear difference if the command is not available and the controller returning -127.

Can we split this change into a separate patch please.

> 	This command generates a Command Complete event on success or
> 	a Command Status event on failure.
> 
> @@ -3574,6 +3585,212 @@ Remove Advertisement Monitor Command
> 				Busy
> 
> 
> +Add Extended Advertising Parameters Command
> +===========================================
> +
> +	Command Code:		0x0054
> +	Controller Index:	<controller id>
> +	Command Parameters:	Instance (1 Octet)
> +				Flags (4 Octets)
> +				Params (2 Octets)
> +				Duration (2 Octets)
> +				Timeout (2 Octets)
> +				MinInterval (4 Octets)
> +				MaxInterval (4 Octets)
> +				TxPower (1 Octet)
> +	Return Parameters:	Instance (1 Octet)
> +				TxPower (1 Octet)

If we leave the Flags that tell what adv data and scan rsp data to add, then we should also return the leftover sizes of each fields so that the caller knows how much they can occupy. So that you don’t have to use Get Advertising Size Information command to get that information. We already know it at this point in time.

> +
> +	This command is used to configure the parameters for Bluetooth Low
> +	Energy advertising instance. This command is expected to be followed
> +	by an Add Extended Advertising Data command to complete and enable
> +	the advertising instance.
> +
> +	Added advertising information with this command will not be visible
> +	immediately if advertising is enabled via the Set Advertising
> +	command. The usage of the Set Advertising command takes precedence
> +	over this command. Instance information is stored and will be
> +	advertised once advertising via Set Advertising has been disabled.
> +
> +	The Instance identifier is a value between 1 and the number of
> +	supported instances. The value 0 is reserved.
> +
> +	With the Flags value the type of advertising is controlled and
> +	the following flags are defined:
> +
> +		0	Switch into Connectable mode
> +		1	Advertise as Discoverable
> +		2	Advertise as Limited Discoverable
> +		3	Add Flags field to Adv_Data
> +		4	Add TX Power field to Adv_Data
> +		5	Add Appearance field to Scan_Rsp
> +		6	Add Local Name in Scan_Rsp
> +		7	Secondary Channel with LE 1M
> +		8	Secondary Channel with LE 2M
> +		9	Secondary Channel with LE Coded
> +
> +	When the connectable flag is set, then the controller will use
> +	undirected connectable advertising. The value of the connectable
> +	setting can be overwritten this way. This is useful to switch a
> +	controller into connectable mode only for LE operation. This is
> +	similar to the mode 0x02 from the Set Advertising command.
> +
> +	When the connectable flag is not set, then the controller will
> +	use advertising based on the connectable setting. When using
> +	non-connectable or scannable advertising, the controller will
> +	be programmed with a non-resolvable random address. When the
> +	system is connectable, then the identity address or resolvable
> +	private address will be used.
> +
> +	Using the connectable flag is useful for peripheral mode support
> +	where BR/EDR (and/or LE) is controlled by Add Device. This allows
> +	making the peripheral connectable without having to interfere
> +	with the global connectable setting.
> +
> +	Secondary channel flags can be used to advertise in secondary
> +	channel with the corresponding PHYs. These flag bits are mutually
> +	exclusive and setting multiple will result in Invalid Parameter
> +	error. Choosing either LE 1M or LE 2M will result in using
> +	extended advertising on the primary channel with LE 1M and the
> +	respectively LE 1M or LE 2M on the secondary channel. Choosing
> +	LE Coded will result in using extended advertising on the primary
> +	and secondary channels with LE Coded. Choosing none of these flags
> +	will result in legacy advertising.
> +
> +	To allow future parameters to be optionally extended in this structure,
> +	the Params member is used to specify which of the structure fields were
> +	purposefully set by the caller. Unspecified parameters will be given
> +	sensible defaults by the kernel before the advertisement is registered.
> +	The Params bit field uses the following bit to parameter relationship:
> +
> +		0	The Duration parameter should be used
> +		1	The Timeout parameter should be used
> +		2	The Interval parameters should be used
> +		3	The Tx Power parameter should be used
> +
> +	The Duration parameter configures the length of an Instance. The
> +	value is in seconds. The default is 2 seconds.

Wouldn’t we just add this to Flags instead of yet another parameter?

> +
> +	If only one advertising Instance has been added, then the Duration
> +	value will be ignored. It only applies for the case where multiple
> +	Instances are configured. In that case every Instance will be
> +	available for the Duration time and after that it switches to
> +	the next one. This is a simple round-robin based approach.
> +
> +	The Timeout parameter configures the life-time of an Instance. In
> +	case the value 0 is used it indicates no expiration time. If a
> +	timeout value is provided, then the advertising Instance will be
> +	automatically removed when the timeout passes. The value for the
> +	timeout is in seconds. Powering down a controller will invalidate
> +	all advertising Instances and it is not possible to add a new
> +	Instance with a timeout when the controller is powered down.
> +
> +	When a Timeout is provided, then the Duration subtracts from
> +	the actual Timeout value of that Instance. For example an Instance
> +	with Timeout of 5 and Duration of 2 will be scheduled exactly 3
> +	times, twice with 2 seconds and once with one second. Other
> +	Instances have no influence on the Timeout.
> +
> +	MinInterval and MaxInterval define the minimum and maximum advertising
> +	intervals, with units as number of .625ms advertising slots. The Max
> +	interval is expected to be greater than or equal to the Min interval,
> +	and both must have values in the range [0x000020, 0xFFFFFF]. If either
> +	condition is not met, the registration will fail.
> +
> +	The provided Tx Power parameter will only be used if the controller
> +	supports it, which can be determined by the presence of the
> +	CanSetTxPower member of the Read Advertising Features command.
> +
> +	The acceptable range for requested Tx Power is defined in the spec
> +	(Version 5.2 | Vol 4, Part E, page 2585) to be [-127, +20] dBm, and the
> +	controller will select a power value up to the requested one. The
> +	transmission power selected by the controller is not guaranteed
> +	to match the requested one, so the reply will contain the power
> +	chosen by the controller. If the requested Tx Power is outside
> +	the valid range, the registration will fail.
> +
> +	Re-adding an already existing instance (i.e. issuing the Add Extended
> +	Advertising Parameters command with an Instance identifier of an
> +	existing instance) will update that instance's configuration.

This can get tricky with Instance Added and Instance Removed events. We would have to describe on how that is handled.

> +
> +	An instance being added or changed while another instance is
> +	being advertised will not be visible immediately but only when
> +	the new/changed instance is being scheduled by the round robin
> +	advertising algorithm.
> +
> +	Changes to an instance that is currently being advertised will
> +	cancel that instance and switch to the next instance. The changes
> +	will be visible the next time the instance is scheduled for
> +	advertising. In case a single instance is active, this means
> +	that changes will be visible right away.
> +
> +	LE must already be enabled, and the controller must be powered,
> +	otherwise a "rejected" status will be returned.
> +
> +	This command generates a Command Complete event on success or a
> +	Command Status event on failure.
> +
> +	Possible errors:	Failed
> +				Rejected
> +				Not Supported
> +				Invalid Parameters
> +				Busy
> +
> +
> +Add Extended Advertising Data Command
> +=====================================
> +
> +	Command Code:		0x0055
> +	Controller Index:	<controller id>
> +	Command Parameters:	Instance (1 Octet)
> +				Advertising Data Length (1 Octet)
> +				Scan Response Length (1 Octet)
> +				Advertising Data (0-255 Octets)
> +				Scan Response (0-255 Octets)
> +	Return Parameters:	Instance (1 Octet)
> +
> +	The Add Extended Advertising Data command is used to update the
> +	advertising data of an existing advertising instance known to the
> +	kernel. It is expected to be called after an Add Extended Advertising
> +	Parameters command, as part of the advertisement registration
> +	process.
> +
> +	If extended advertising is available, this call will initiate HCI
> +	commands to set the instance's advertising data, set scan response
> +	data, and then enable the instance. If extended advertising is
> +	unavailable, the advertising instance structure maintained in kernel
> +	will have its advertising data and scan response updated, and the
> +	instance will either be scheduled immediately or left in the queue
> +	for later advertisement as part of round-robin advertisement rotation
> +	in software.
> +
> +	If Scan_Rsp_Len is zero and the flags defined in Add Extended
> +	Advertising Parameters command do not have connectable flag set and
> +	the global connectable setting is off, then non-connectable
> +	advertising is used. If Scan_Rsp_Len is larger than zero and
> +	connectable flag is not set and the global advertising is off,
> +	then scannable advertising is used. This small difference is
> +	supported to provide less air traffic for devices implementing
> +	broadcaster role.
> +
> +	If the Instance provided does not match a known instance, or if the
> +	provided advertising data or scan response are in an unrecognized
> +	format, an "Invalid Parameters" status will be returned.
> +
> +	If a "Set LE" or Advertising command is still in progress, a "Busy"
> +	status will be returned.
> +
> +	If the controller is not powered, a "rejected" status will be returned.
> +
> +	This command generates a Command Complete event on success or a
> +	Command Status event on failure.
> +
> +	Possible errors:	Failed
> +				Rejected
> +				Invalid Parameters
> +				Busy
> +
> +
> Command Complete Event
> ======================
> 
> @@ -4576,4 +4793,4 @@ Advertisement Monitor Removed Event
> 	using the Remove Advertisement Monitor command.
> 
> 	The event will only be sent to management sockets other than the
> -	one through which the command was sent.
> +	one through which the command was sent.

Please don’t add unrelated changes.

Regards

Marcel

