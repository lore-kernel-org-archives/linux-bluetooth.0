Return-Path: <SRS0=YOMr=7K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4430C433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 May 2020 08:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD35520B80
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 May 2020 08:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgE1INx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 May 2020 04:13:53 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:50759 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbgE1INx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 May 2020 04:13:53 -0400
Received: from marcel-macpro.fritz.box (p4fefc5a7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id AA550CECB0;
        Thu, 28 May 2020 10:23:38 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [BlueZ PATCH v5] doc:adding definitions for load default params
 mgmt op
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200528012421.136864-1-alainm@chromium.org>
Date:   Thu, 28 May 2020 10:13:51 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <6239D349-F91F-4C95-9001-A4410AA3BF3C@holtmann.org>
References: <20200528012421.136864-1-alainm@chromium.org>
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
> future values that may be necessary.
> 
> This will allow bluetoothd to load parameters from a conf file that may
> be customized for the specific requirements of each platforms.
> 
> Signed-off-by: Alain Michaud <alainm@chromium.org>
> ---
> 
> doc/mgmt-api.txt | 59 ++++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 59 insertions(+)
> 
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index 6ee01fed8..14e3179b5 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -3223,6 +3223,65 @@ Set Experimental Feature Command
> 				Invalid Index
> 
> 
> +Load Default Controller Parameter Command
> +=============================
> +
> +	Command Code:		0x004b
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
> +	This command is used to feed the kernel a list of default controller
> +	parameters.
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
> +	This command can be used when the controller is not powered and
> +	all settings will be programmed once powered.  Note that these only
> +	control the default parameters.  Higher level Apis may influence the
> +	effective value used.
> +
> +	This command generates a Command Complete event on success or
> +	a Command Status event on failure.
> +
> +	Possible errors:	Invalid Parameters
> +				Invalid Index
> +
> +

you asked me about naming and I was thinking this:

+Read Default System Configuration Command
+=========================================
+
+
+Set Default System Configuration Command
+========================================
+
+
+Read Default Runtime Parameters Command
+=======================================
+
+
+Load Default Runtime Parameters Command
+=======================================

The Default System is the actual configuration that you load before you power on the controller. These are really the default values for a lot of things. And I used “Read” to get the current settings and also with that the list of supported values. So you know what changes would actually be possible.

I called the other one “Set” since it can set/overwrite a few of these values or actually all. I don’t wanted to use “Load” since it is not replacing all of the values like what we have with the other load commands.

The Default Runtime would be then all values that can be tweaked while the controller is up and running.

Regards

Marcel

