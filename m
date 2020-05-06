Return-Path: <SRS0=zRH5=6U=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F46EC38A24
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 May 2020 11:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E652D2068E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 May 2020 11:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgEFLFQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 May 2020 07:05:16 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:60293 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727959AbgEFLFP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 May 2020 07:05:15 -0400
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 67218CED03;
        Wed,  6 May 2020 13:14:53 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [BlueZ PATCH v5] doc: Describe the new Advertisement Monitor
 support
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200429203031.BlueZ.v5.1.If9f6be992cbaeaa35423de29da6db28675b35fcc@changeid>
Date:   Wed, 6 May 2020 13:05:11 +0200
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Alain Michaud <alainm@chromium.org>,
        Michael Sun <michaelfsun@google.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Yoni Shavit <yshavit@chromium.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <6FD8666C-39AD-4D41-9BBF-7E1371FDFFA6@holtmann.org>
References: <20200429203031.BlueZ.v5.1.If9f6be992cbaeaa35423de29da6db28675b35fcc@changeid>
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
> Changes in v5:
> - Add more fields in the return value of Read Advertisement Monitor
> Features command.
> - Refine the description of commands and events.
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
> doc/mgmt-api.txt | 147 +++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 147 insertions(+)
> 
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index 39f23c456..4aa755c45 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -3138,6 +3138,125 @@ Read Security Information Command
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
> +				Max_Num_Handles (2 octets)
> +				Max_Num_Patterns (1 octet)
> +				Num_Handles (2 octets)
> +				Handle1 (2 octets)
> +				Handle2 (2 octets)
> +				...

				Handle[i] (2 Octets)

And we have been using Octet(s) and not octet(s). The document should be pretty much consistent with its style. If you see mistakes, please send patches to correct it.

> +
> +	This command is used to read the advertisement monitor features
> +	supported by the controller and stack. Supported_Features lists all
> +	related features supported by the controller while Enabled_Features
> +	lists the ones currently used by the kernel.
> +
> +	Supported_Features and Enabled_Features are bitmasks with currently
> +	the following available bits:
> +
> +		1	Advertisement content monitoring based on Microsoft
> +			HCI extension.

Advertising content monitoring based on pattern. Lets leave Microsoft out of it.

> +
> +	Max_Num_Handles indicates the maximum number of supported
> +	advertisement monitors. Note that the actual number of supported
> +	ones might be less depending on the limitation of the controller.
> +
> +	Max_Num_Pattern indicates the maximum number of supported patterns
> +	in an advertisement patterns monitor. Note that the actual number
> +	of supported ones might be less depending on the limitation of the
> +	controller.
> +
> +	Num_Handles indicates the number of added advertisement monitors,
> +	and it is followed by a list of handles.
> +
> +	This command can be used when the controller is not powered.
> +
> +
> +Add Advertisement Patterns Monitor Command
> +=========================================
> +
> +	Command Code:		0x004A
> +	Controller Index:	<controller id>
> +	Command Parameters:	Pattern_count (1 Octets)

Pattern_Count please.

> +				Pattern1 {
> +					AD_Data_Type (1 Octet)

Just call it Type and explain in the description that it is the AD Type.

> +					Offset (1 Octet)
> +					Length (1 Octet)
> +					Value (variable length)

We normally give a range and not “variable length”. I wonder if we should just use a fixed size field here.

> +				}
> +				Pattern2 { }
> +				...
> +	Return Parameters:	Monitor_Handle (2 Octets)
> +
> +	This command is used to add an advertisement monitor whose
> +	filtering conditions are patterns. The kernel will trigger scanning
> +	if there is at least one monitor added. If the controller supports
> +	advertisement filtering, the kernel would offload the content
> +	filtering to the controller in order to reduce power consumption;
> +	otherwise the kernel ignores the content of the monitor. Note that
> +	if the there are more than one patterns, OR logic would applied
> +	among patterns during filtering. In other words, any advertisement
> +	matching at least one pattern in a given monitor would be
> +	considered as a match.
> +
> +	A pattern contains the following fields.
> +		AD_Data_Type	Advertising Data Type. The possible values
> +				are defined in Core Specification
> +				Supplement.
> +		Offset		The start index where pattern matching
> +				shall be performed with in the AD data.
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
> +	This command can be used when the controller is not powered and
> +	all settings will be programmed once powered.
> +
> +	Possible errors:	Failed
> +				Busy
> +				No Resources
> +				Invalid Parameters
> +
> +
> +Remove Advertisement Monitor Command
> +====================================
> +
> +	Command Code:		0x004B
> +	Controller Index:	<controller id>
> +	Command Parameters:	Monitor_Handle (2 Octets)
> +	Return Parameters:

Include Monitor_Handle in the return value. The events are not send to the caller and so the caller somehow needs to be able to map that response if they have to.

> +
> +	This command is used to remove advertisement monitor(s). The kernel
> +	would remove the monitor(s) with Monitor_Handle and update the LE
> +	scanning.
> +
> +	When the Monitor_Handle is set to zero, then all previously added
> +	handles will be removed.
> +
> +	Removing a monitor while it is being added will be ignored.
> +
> +	This command can be used when the controller is not powered and
> +	all settings will be programmed once powered.
> +
> +	Possible errors:	Failed
> +				Busy
> +				Invalid Index
> +
> +
> Command Complete Event
> ======================
> 
> @@ -4020,3 +4139,31 @@ PHY Configuration Changed Event
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
> +	Event Parameters:	Monitor_Handle (2 Octets)
> +
> +	This event indicates that an advertisement monitor has been added
> +	using the Add Advertisement Monitor command.
> +
> +	The event will only be sent to management sockets other than the
> +	one through which the command was sent.
> +
> +
> +Advertisement Monitor Removed Event
> +===================================
> +
> +	Event Code:		0x0028
> +	Controller Index:	<controller id>
> +	Event Parameters:	Monitor_Handle (2 Octets)
> +
> +	This event indicates that an advertisement monitor has been removed
> +	using the Remove Advertisement Monitor command.
> +
> +	The event will only be sent to management sockets other than the
> +	one through which the command was sent.

Regards

Marcel

