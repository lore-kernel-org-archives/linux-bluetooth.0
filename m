Return-Path: <SRS0=vsJv=6G=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72BEC54FCB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Apr 2020 17:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDBC620706
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Apr 2020 17:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgDVRdw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Apr 2020 13:33:52 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:33749 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgDVRdw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Apr 2020 13:33:52 -0400
Received: from [192.168.1.91] (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 8628CCECFD;
        Wed, 22 Apr 2020 19:43:28 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [BlueZ PATCH v2] doc: Describe the new Advertisement Monitor
 support
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200421180155.BlueZ.v2.1.If9f6be992cbaeaa35423de29da6db28675b35fcc@changeid>
Date:   Wed, 22 Apr 2020 19:33:20 +0200
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Yoni Shavit <yshavit@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Michael Sun <michaelfsun@google.com>,
        Alain Michaud <alainm@chromium.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <C6C04FC6-4D51-45CB-BB85-94660F6B93E5@holtmann.org>
References: <20200421180155.BlueZ.v2.1.If9f6be992cbaeaa35423de29da6db28675b35fcc@changeid>
To:     Miao-chen Chou <mcchou@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Miao-chen,

> This describes the following commands.
> - Add Advertisement Patterns Monitor
> - Remove Advertisement Monitors
> Note that the content of a monitor can differ based on its type. For now we
> introduce only pattern-based monitor, so you may find that unlike the
> command of removing monitor(s), the Add command is tied to a specific type.
> ---
> 
> Changes in v2:
> - Combine commands to remove one monitor and remove all monitors. The
> refined command takes multiple handles and an extra field to indicate
> whether to remove all monitors.
> 
> doc/mgmt-api.txt | 83 ++++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 83 insertions(+)
> 
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index 39f23c456..d5d402361 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -3138,6 +3138,89 @@ Read Security Information Command
> 				Invalid Index
> 
> 
> +Add Advertisement Patterns Monitor Command
> +=========================================

I wonder if we do Add Advertisement Monitor Pattern or Add Advertisement Monitor With Pattern.

> +
> +	Command Code:		0x0049
> +	Controller Index:	<controller id>
> +	Command Parameters:	Pattern_count (1 Octets)
> +				Pattern1 {
> +					AD_Data_Type (1 Octet)
> +					Offset (1 Octet)
> +					Length (1 Octet)
> +					Value (variable length)
> +				}
> +				Pattern2 { }
> +				...
> +	Return Parameters:	Monitor_Handle (8 Octets)

Why 8 Octets? How many do you expect? I would do 16-bit.

> +
> +	This command is used to add an advertisement monitor whose filtering
> +	conditions are patterns. The kernel would track the number of registered
> +	monitors to determine whether to perform LE scanning while there is
> +	ongoing LE scanning for other intentions, such as auto-reconnection and
> +	discovery session. If the controller supports Microsoft HCI extension,
> +	the kernel would offload the content filtering to the controller in
> +	order to reduce power consumption; otherwise the kernel ignore the
> +	content of the monitor. Note that if the there are more than one
> +	patterns, OR logic would applied among patterns during filtering. In
> +	other words, any advertisement matching at least one pattern in a given
> +	monitor would be considered as a match.
> +
> +	A pattern contain the following fields.
> +		AD_Data_Type	Advertising Data Type. The possible values are
> +				defined in Core Specification Supplement.
> +		Offset		The start index where pattern matching shall be
> +				performed with in the AD data.
> +		Length		The length of the pattern value in bytes.
> +		Value		The value of the pattern in bytes.
> +
> +	Here is an example of a pattern.
> +		{
> +			0x16, // Service Data - 16-bit UUID
> +			0x02, // Skip the UUID part.
> +			0x04,
> +			{0x11, 0x22, 0x33, 0x44},
> +		}
> +
> +	Possible errors:	Failed
> +				Busy
> +				Invalid Parameters
> +
> +
> +Remove Advertisement Monitors Command
> +=====================================

I would have a generic Remove Adveristement Monitor

> +
> +	Command Code:		0x004A
> +	Controller Index:	<controller id>
> +	Command Parameters:	Remove_All (1 Octet)

Skip the Remove_All. If you give Monitor_Count == 0, then it will remove all of them. This is how we have done the others.

> +				Monitor_Count (2 Octets)
> +				Monitor_Handle[i] (8 Octets)
> +	Return Parameters:	Removed_Monitor_Count (2 Octets)
> +				Removed_Monitor_Handle[i] (8 Octets)

Return values are not needed here.

> +
> +	This command is used to remove advertisement monitor(s). The kernel
> +	would remove the monitor(s) with Monitor_Index and update the LE
> +	scanning. If the controller supports Microsoft HCI extension and the
> +	monitor(s) has been offloaded, the kernel would cancel the offloading;
> +	otherwise the kernel takes no further actions other than removing the
> +	monitor(s) from the list.
> +
> +	Remove_All can be the following values.
> +		Value		Operation
> +		-------------------------
> +		0x00		Removes only the monitors with handles specified
> +				in Monitor_Handle[i], so there must be at least
> +				one handle.
> +		0x01		Removes all existing monitor(s), so
> +				Monitor_Count must be 0, and Monitor_Handle
> +				must be empty.
> +
> +	Possible errors:	Failed
> +				Busy
> +				Invalid Index
> +				Invalid Parameters
> +
> +
> Command Complete Event
> ======================

You are missing signals for Monitor Added and Monitor Removed.

And we are also missing a command for reading the basic supported features. Like we do for Advertising as well.

Regards

Marcel

