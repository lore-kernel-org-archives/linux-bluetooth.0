Return-Path: <SRS0=zRH5=6U=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050E6C28CBC
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 May 2020 11:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAAA420663
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 May 2020 11:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgEFLWU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 May 2020 07:22:20 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:39284 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbgEFLWU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 May 2020 07:22:20 -0400
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 25C29CED03;
        Wed,  6 May 2020 13:32:00 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [BlueZ PATCH v1] doc:adding definitions for load default params
 mgmt op
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200504142625.213143-1-alainm@chromium.org>
Date:   Wed, 6 May 2020 13:22:18 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <7610937E-424D-4968-B8D9-378E44773088@holtmann.org>
References: <20200504142625.213143-1-alainm@chromium.org>
To:     Alain Michaud <alainm@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

> This change adds the definition for the load default parameter command.
> In particular, this command is used to load default parameters for
> various operations in the kernel. This mechanism is also expandable to
> future knobs that may be necessary.
> 
> This will allow bluetoothd to load parameters from a conf file that may
> be customized for the specific requirements of each platforms.
> 
> ---
> 
> doc/mgmt-api.txt | 59 ++++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 59 insertions(+)
> 
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index 39f23c456..71d528706 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -3137,6 +3137,65 @@ Read Security Information Command
> 	Possible errors:	Invalid Parameters
> 				Invalid Index
> 
> +Load Default Parameter Command
> +=============================

I think that Load Controller Default Parameters is a better name.

> +
> +	Command Code:		0x0049
> +	Controller Index:	<controller id>
> +	Command Parameters:	Parameter_Count (2 Octets)
> +				Parameter1 {
> +					Parameter_Type (2 Octet)
> +					Value_Length (1 Octet)
> +					Value (0-255 Octets)
> +				}
> +				Parameter2 { }
> +				...
> +	Return Parameters:
> +
> +	This command is used to feed the kernel a list of default parameters.
> +
> +	Currently defined Parameter_Type values are:
> +
> +			0x0000	BR/EDR Page Scan Type
> +			0x0001	BR/EDR Page Scan Interval
> +			0x0002	BR/EDR Page Scan Window
> +			0x0003	BR/EDR Inquiry Scan Type
> +			0x0004	BR/EDR Inquiry Scan Interval
> +			0x0005	BR/EDR Inquiry Scan Window
> +			0x0006	BR/EDR Link Supervision Timeout
> +			0x0007	BR/EDR Page Timeout
> +			0x0008	BR/EDR Min Sniff Interval
> +			0x0009	BR/EDR Max Sniff Interval
> +			0x0080	LE Advertisement Min Interval
> +			0x0081	LE Advertisement Max Interval
> +			0x0082	LE Multi Advertisement Rotation Interval
> +			0x0083	LE Scanning Interval for auto connect
> +			0x0084	LE Scanning Window for auto connect
> +			0x0085	LE Scanning Interval for HID only
> +			0x0086	LE Scanning Window for HID only
> +			0x0087	LE Scanning Interval for wake scenarios
> +			0x0088	LE Scanning Window for wake scenarios
> +			0x0089	LE Scanning Interval for discovery
> +			0x008a	LE Scanning Window for discovery
> +			0x008b	LE Scanning Interval for adv monitoring
> +			0x008c	LE Scanning Window for adv monitoring
> +			0x008d	LE Scanning Interval for connect
> +			0x008e	LE Scanning Window for connect
> +			0x008f	LE Min Connection Interval
> +			0x0090	LE Max Connection Interval
> +			0x0091	LE Connection Connection Latency
> +			0x0092	LE Connection Supervision Timeout

I would just enumerate these and not try to split between 0x000 and 0x008 for BR/EDR and LE. Also I would just start with a few values that we currently want to change.

> +
> +	This command can be used any time, but will not take effect until the
> +	next activity requiring the parameters.  In the case the parameters are
> +	used during initialization of the adapter, it is expected that the
> +	parameters be set before the adapter is powered.

Hmmm. This one, I might want to limit this controllers powered down. Otherwise you get into the conflict case that we would expect parameters taking affect and I think that is just too complicated.

> +
> +	This command generates a Command Complete event on success or
> +	a Command Status event on failure.
> +
> +	Possible errors:	Invalid Parameters
> +				Invalid Index
> 

Regards

Marcel

