Return-Path: <SRS0=8+Sx=7X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CAE4C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 08:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5806A2072E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 08:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgFJIuI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Jun 2020 04:50:08 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:58677 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgFJIuH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Jun 2020 04:50:07 -0400
Received: from marcel-macbook.fritz.box (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id 4CF7BCECE0;
        Wed, 10 Jun 2020 10:59:56 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [BlueZ PATCH v6] doc:adding definitions for load default params
 mgmt op
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200528135459.18496-1-alainm@chromium.org>
Date:   Wed, 10 Jun 2020 10:50:06 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <F39E72FF-0271-4B87-9C49-0BDFE39F74B5@holtmann.org>
References: <20200528135459.18496-1-alainm@chromium.org>
To:     Alain Michaud <alainm@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

> This change adds the definition for the read/set default parameter
> commands.
> 
> In particular, these commands are used to read and set the system
> default parameters.  The use of a TLV format also ensures that
> parameters are expandable in the future.
> 
> This will allow bluetoothd to load parameters from a conf file that may
> be customized for the specific requirements of each platforms.
> 
> ---
> 
> doc/mgmt-api.txt | 113 +++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 113 insertions(+)

patch has been applied.

> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index 6ee01fed8..cbe6422a5 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -3223,6 +3223,119 @@ Set Experimental Feature Command
> 				Invalid Index
> 
> 
> +Read Default System Configuration Command
> +=============================
> +
> +	Command Code:		0x004b
> +	Controller Index:	<controller id>
> +	Command Parameters:
> +	Return Parameters:	Parameter1 {
> +					Parameter_Type (2 Octet)
> +					Value_Length (1 Octet)
> +					Value (0-255 Octets)
> +				}
> +				Parameter2 { }
> +				...
> +
> +	This command is used to read a list of default controller parameters.
> +
> +	Currently defined Parameter_Type values are:
> +
> +		0x0000	BR/EDR Page Scan Type
> +		0x0001	BR/EDR Page Scan Interval
> +		0x0002	BR/EDR Page Scan Window
> +		0x0003	BR/EDR Inquiry Scan Type
> +		0x0004	BR/EDR Inquiry Scan Interval
> +		0x0005	BR/EDR Inquiry Scan Window
> +		0x0006	BR/EDR Link Supervision Timeout
> +		0x0007	BR/EDR Page Timeout
> +		0x0008	BR/EDR Min Sniff Interval
> +		0x0009	BR/EDR Max Sniff Interval
> +		0x000a	LE Advertisement Min Interval
> +		0x000b	LE Advertisement Max Interval
> +		0x000c	LE Multi Advertisement Rotation Interval
> +		0x000d	LE Scanning Interval for auto connect
> +		0x000e	LE Scanning Window for auto connect
> +		0x000f	LE Scanning Interval for wake scenarios
> +		0x0010	LE Scanning Window for wake scenarios
> +		0x0011	LE Scanning Interval for discovery
> +		0x0012	LE Scanning Window for discovery
> +		0x0013	LE Scanning Interval for adv monitoring
> +		0x0014	LE Scanning Window for adv monitoring
> +		0x0015	LE Scanning Interval for connect
> +		0x0016	LE Scanning Window for connect
> +		0x0017	LE Min Connection Interval
> +		0x0018	LE Max Connection Interval
> +		0x0019	LE Connection Latency
> +		0x001a	LE Connection Supervision Timeout
> +
> +	This command can be used at any time and will return a list of supported
> +	parameters as well as their current default value.
> +
> +	This command generates a Command Complete event on success or
> +	a Command Status event on failure.
> +
> +	Possible errors:	Invalid Parameters
> +				Invalid Index
> +
> +Set Default System Configuration Command
> +=============================
> +
> +	Command Code:		0x004c
> +	Controller Index:	<controller id>
> +	Command Parameters:	Parameter1 {
> +					Parameter_Type (2 Octet)
> +					Value_Length (1 Octet)
> +					Value (0-255 Octets)
> +				}
> +				Parameter2 { }
> +				...
> +	Return Parameters:
> +
> +	This command is used to set a list of default controller parameters.
> +
> +	Currently defined Parameter_Type values are:
> +
> +		0x0000	BR/EDR Page Scan Type
> +		0x0001	BR/EDR Page Scan Interval
> +		0x0002	BR/EDR Page Scan Window
> +		0x0003	BR/EDR Inquiry Scan Type
> +		0x0004	BR/EDR Inquiry Scan Interval
> +		0x0005	BR/EDR Inquiry Scan Window
> +		0x0006	BR/EDR Link Supervision Timeout
> +		0x0007	BR/EDR Page Timeout
> +		0x0008	BR/EDR Min Sniff Interval
> +		0x0009	BR/EDR Max Sniff Interval
> +		0x000a	LE Advertisement Min Interval
> +		0x000b	LE Advertisement Max Interval
> +		0x000c	LE Multi Advertisement Rotation Interval
> +		0x000d	LE Scanning Interval for auto connect
> +		0x000e	LE Scanning Window for auto connect
> +		0x000f	LE Scanning Interval for wake scenarios
> +		0x0010	LE Scanning Window for wake scenarios
> +		0x0011	LE Scanning Interval for discovery
> +		0x0012	LE Scanning Window for discovery
> +		0x0013	LE Scanning Interval for adv monitoring
> +		0x0014	LE Scanning Window for adv monitoring
> +		0x0015	LE Scanning Interval for connect
> +		0x0016	LE Scanning Window for connect
> +		0x0017	LE Min Connection Interval
> +		0x0018	LE Max Connection Interval
> +		0x0019	LE Connection Latency
> +		0x001a	LE Connection Supervision Timeout

However I collapsed this into see the Read command.

> +	This command can be used when the controller is not powered and
> +	all supported parameters will be programmed once powered. Non supported
> +	parameters will be ignored.  Note that these only control the default
> +	parameters.  Higher level Apis may influence the effective value used.

And I think it is prudent that the kernel does a validity check and fails gracefully. Let bluetoothd do all the work for creating the correct set of parameters to supply. We have the read command to know which ones are supported and which are not.

Regards

Marcel

