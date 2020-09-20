Return-Path: <SRS0=JmZN=C5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F3BC43468
	for <linux-bluetooth@archiver.kernel.org>; Sun, 20 Sep 2020 06:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C77312085B
	for <linux-bluetooth@archiver.kernel.org>; Sun, 20 Sep 2020 06:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgITGRR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 20 Sep 2020 02:17:17 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:58571 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbgITGRP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 20 Sep 2020 02:17:15 -0400
Received: from marcel-macbook.fritz.box (p4fefc7f4.dip0.t-ipconnect.de [79.239.199.244])
        by mail.holtmann.org (Postfix) with ESMTPSA id CDD6CCEC92;
        Sun, 20 Sep 2020 08:14:17 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [Bluez PATCH v2 02/10] doc/mgmt-api: Add new MGMT interfaces to
 mgmt-api
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200918151041.Bluez.v2.2.If15d3d09724ded2bcc7240d29f6888f2ad12e723@changeid>
Date:   Sun, 20 Sep 2020 08:07:19 +0200
Cc:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <0E891E36-FA71-414C-9E60-596D253A82A5@holtmann.org>
References: <20200918221357.3436905-1-danielwinkler@google.com>
 <20200918151041.Bluez.v2.2.If15d3d09724ded2bcc7240d29f6888f2ad12e723@changeid>
To:     Daniel Winkler <danielwinkler@google.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Daniel,

> This patch adds the following to mgmt-api:
> - Add Extended Advertising Parameters Command
> - Add Extended Advertising Data Command
> - Read Controller Capabilities Command
> - Advertisement Tx Power Selected Event
> 
> Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
> Reviewed-by: Alain Michaud <alainm@chromium.org>
> ---
> 
> Changes in v2:
> - Removed extra space in Add Extended Advertising Parameters API
> 
> doc/mgmt-api.txt | 242 +++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 242 insertions(+)
> 
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index ca0d38469..62f976a11 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -3574,6 +3574,234 @@ Remove Advertisement Monitor Command
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

didn’t you also want to return the selected TxPower? We then also have to agree to allow this command only when the controller is powered.

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
> +	to match the requested one, but the caller can determine the power
> +	chosen by the controller by listening for the Tx Power Selected MGMT
> +	event that follows this command. If the requested Tx Power is outside
> +	the valid range, the registration will fail.
> +
> +	Re-adding an already existing instance (i.e. issuing the Add Extended
> +	Advertising Parameters command with an Instance identifier of an
> +	existing instance) will update that instance's configuration.
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
> +Read Controller Capabilities Command
> +====================================
> +
> +	Command Code:		0x0056
> +	Controller Index:	<controller id>
> +	Command Parameters:
> +	Return Parameters:	Parameter1 {
> +					Capability_Tag (2 Octet)
> +					Value_Length (1 Octet)
> +					Value (0-255 Octets)
> +				}
> +				Parameter2 { }
> +				...
> +
> +	This command is used to read a list of controller capabilities.
> +
> +	Currently defined Capability_Tag values are:
> +
> +		0x0000	Minimum Supported LE Tx Power (dBm)
> +		0x0001	Maximum Supported LE Tx Power (dBm)
> +
> +

I was thinking we rename Read Security Information Command and also return these values there. I think it is a bit of waste to introduce yet another command to return controller capabilities.

> Command Complete Event
> ======================
> 
> @@ -4577,3 +4805,17 @@ Advertisement Monitor Removed Event
> 
> 	The event will only be sent to management sockets other than the
> 	one through which the command was sent.
> +
> +
> +Advertisement Tx Power Selected Event
> +===================================
> +
> +	Event Code:		0x002d
> +	Controller Index:	<controller id>
> +	Event Parameters:	Instance (1 Octet)
> +				TxPower (1 Octet)
> +
> +	This event indicates that the controller selected a transmission
> +	power for an advertising instance. The event is emitted on platforms
> +	that support extended advertising after an Add Extended Advertising
> +	Parameters command is submitted.

I would rather return the value right away and only allow it when powered on.

Regards

Marcel

