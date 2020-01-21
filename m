Return-Path: <SRS0=PvgB=3K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CE8C2D0CE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jan 2020 16:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EE8C22525
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jan 2020 16:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbgAUQUz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Jan 2020 11:20:55 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:55837 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgAUQUz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Jan 2020 11:20:55 -0500
Received: from marcel-macpro.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 98508CECE3;
        Tue, 21 Jan 2020 17:30:13 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [Bluez PATCH] doc: Add definition for Set Kernel Debug Level
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200120202708.111383-1-alainm@chromium.org>
Date:   Tue, 21 Jan 2020 17:20:54 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <6E55772A-01D5-4616-B3DB-CC22B935C855@holtmann.org>
References: <20200120202708.111383-1-alainm@chromium.org>
To:     Alain Michaud <alainm@chromium.org>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

> This command is used to by higher level applications to dynamically
> control the debug logging level of the kernel module.  This is
> particularly useful to collect debug information from customers filing
> feedback reports for issues that are difficult to reproduce outside of a
> customer's particular environement.
> 
> ---
> 
> doc/mgmt-api.txt | 25 +++++++++++++++++++++++++
> 1 file changed, 25 insertions(+)
> 
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index 1e59acc54..f2dba64d1 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -3047,6 +3047,31 @@ Load Blocked Keys Command
> 	Possible errors:	Invalid Parameters
> 				Invalid Index
> 
> +Set Kernel Debug Logging Level Command
> +=======================
> +
> +	Command Code:		0x0047
> +	Controller Index: <controller id>
> +	Command Parameters : Debug_Logging_Level (1 octet)
> +
> +	This command is used to set the kernel debug logging level. This
> +	can be by higher level applications to facilitate dynamically
> +	controlling	the logging level produced by the Bluez kernel module.
> +
> +	Supported Debug_Logging_Level values:
> +		0 : No Logging
> +		1 : All debug information.
> +		All other values are reserved for future use.
> +
> +	When the kernel receives a value higher than the maximum supported
> +	value, the kernel module shall set it's logging level to the highest
> +	value it supports.
> +
> +	This command generates a Command Complete event on success or
> +	a Command Status event on failure.
> +
> +	Possible errors:	Invalid Parameters
> +				Invalid Index

I need a bit more explanation on how this is suppose to work and why the current dynamic_debug feature is not enough.

Regards

Marcel

