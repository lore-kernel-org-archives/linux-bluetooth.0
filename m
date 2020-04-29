Return-Path: <SRS0=4cRj=6N=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03510C83003
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Apr 2020 08:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF2AD2087E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Apr 2020 08:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgD2IHR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Apr 2020 04:07:17 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:35026 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgD2IHR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Apr 2020 04:07:17 -0400
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 7B9C6CECFA;
        Wed, 29 Apr 2020 10:16:54 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [BlueZ PATCH v4] doc: Describe the new Advertisement Monitor
 support
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200428154221.BlueZ.v4.1.If9f6be992cbaeaa35423de29da6db28675b35fcc@changeid>
Date:   Wed, 29 Apr 2020 10:07:13 +0200
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Alain Michaud <alainm@chromium.org>,
        Michael Sun <michaelfsun@google.com>,
        Yoni Shavit <yshavit@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <771FD3FA-5BB5-4D52-9649-3E548D0E8D83@holtmann.org>
References: <20200428154221.BlueZ.v4.1.If9f6be992cbaeaa35423de29da6db28675b35fcc@changeid>
To:     Miao-chen Chou <mcchou@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Miao-chen,

> This describes the following commands and event.
> - Read Advertisement Monitor Features command
> - Add Advertisement Patterns Monitor command
> - Remove Advertisement Monitor command
> - Advertisement Monitor Added event
> - Advertisement Monitor Removed event
> Note that the content of a monitor can differ based on its type. For now we
> introduce only pattern-based monitor, so you may find that unlike the
> command of removing monitor(s), the Add command is tied to a specific type.
> ---
> 
> Changes in v4:
> - In Read Advertisement Monitor Features command, rename
> Adopted_Features to Enabled_Features.
> 
> Changes in v3:
> - Remove Advertisement Monitor can perform the removal of one monitor
> or all monitors.
> - Add Read Advertisement Monitor Features command.
> - Add Advertisement Monitor Added event and dvertisement Monitor Removed
> event.
> 
> Changes in v2:
> - Combine commands to remove one monitor and remove all monitors. The
> refined command takes multiple handles and an extra field to indicate
> whether to remove all monitors.
> 
> doc/mgmt-api.txt | 118 +++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 118 insertions(+)
> 
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index 39f23c456..e3a115c02 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -3138,6 +3138,102 @@ Read Security Information Command
> 				Invalid Index
> 
> 
> +Read Advertisement Monitor Features Command
> +===========================================
> +
> +	Command Code:		0x0049
> +	Controller Index:	<controller id>
> +	Command Parameters:
> +	Return Parameters:	Supported_Features (4 octets)
> +				Enabled_Features (4 octets)
> +
> +	This command is used to read the advertisement monitor features supported
> +	by the controller and stack. Supported_Features lists all related
> +	features supported by the controller while Enabled_Features lists the
> +	ones currently used by the stack.

hmmm. The enabled portion you need to explain a bit more. I don’t see the need for it right now.

Similar to the Read Advertising Features, I would at least add the Num_Handles and a Handle list so that you know what handles you have.

I do wonder if you should do a Max_Handles or Max_Pattern information here as well.

> +
> +	Supported_Features and Enabled_Features are bitmasks with currently the
> +	following available bits:
> +
> +		1	Advertisement content monitoring based on Microsoft HCI
> +			extension.

Lets say “based on pattern matching”. I would try to avoid Microsoft HCI extension as explicit mentioning in the API description if possible.

> +
> +
> +Add Advertisement Patterns Monitor Command
> +=========================================
> +
> +	Command Code:		0x004A
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
> +	Return Parameters:	Monitor_Handle (4 Octets)

Unless our Advertising or Connection Handle in the Bluetooth Core spec are 32-bit, I would like to stay with a 16-bit value here.

> +
> +	This command is used to add an advertisement monitor whose filtering
> +	conditions are patterns. The kernel would track the number of registered
> +	monitors to determine whether to perform LE scanning while there is
> +	ongoing LE scanning for other intentions, such as auto-reconnection and

This sentence doesn’t really parse.

Lets keep this simple, if there is at least one monitor enabled, then the kernel will trigger scanning.

> +	discovery session. If the controller supports advertisement filtering,
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
> +Remove Advertisement Monitor Command
> +====================================
> +
> +	Command Code:		0x004B
> +	Controller Index:	<controller id>
> +	Command Parameters:	Monitor_Handle (4 Octets)
> +	Return Parameters:
> +
> +	This command is used to remove advertisement monitor(s). The kernel
> +	would remove the monitor(s) with Monitor_Index and update the LE
> +	scanning. If the controller supports advertisement filtering and the
> +	monitor(s) has been offloaded, the kernel would cancel the offloading;
> +	otherwise the kernel takes no further actions other than removing the
> +	monitor(s) from the list.

When the Monitor_Handle is set to zero, then all previously handles are removed. Make this similar to Remove Advertisement.

We also should not that in case of pattern monitor, all patterns associated with a monitor handle will be removed.

> +
> +	Monitor_Handle can be the following values.
> +		Value		Operation
> +		-------------------------
> +		0x00000000		Removes all existing monitor(s)
> +		0x00000001 or greater	Removes the monitor with that handle
> +
> +	Possible errors:	Failed
> +				Busy
> +				Invalid Index
> +
> +
> Command Complete Event
> ======================
> 
> @@ -4020,3 +4116,25 @@ PHY Configuration Changed Event
> 	one through which the change was triggered.
> 
> 	Refer Get PHY Configuration command for PHYs parameter.
> +
> +
> +Advertisement Monitor Added Event
> +=================================
> +
> +	Event Code:		0x0027
> +	Controller Index:	<controller id>
> +	Event Parameters:	Monitor_Handle (4 Octets)
> +
> +	This event indicates that an advertisement monitor has been added using
> +	the Add Advertisement Monitor command.
> +
> +
> +Advertisement Monitor Removed Event
> +===================================
> +
> +	Event Code:		0x0028
> +	Controller Index:	<controller id>
> +	Event Parameters:	Monitor_Handle (4 Octets)
> +
> +	This event indicates that an advertisement monitor has been removed
> +	using the Remove Advertisement Monitor command.
> -- 
> 2.24.1

Besides these minor details, I think this look good.

Regards

Marcel

