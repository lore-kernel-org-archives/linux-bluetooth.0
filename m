Return-Path: <SRS0=QCqs=4V=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D174C3F2CE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Mar 2020 18:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B1BF20866
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Mar 2020 18:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730190AbgCDSg7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Mar 2020 13:36:59 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:45966 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730167AbgCDSg7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Mar 2020 13:36:59 -0500
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 97063CECE1;
        Wed,  4 Mar 2020 19:46:25 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [BlueZ PATCH v1] Adding definitions for Wide Band Speech
 configuration
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200304173249.66324-1-alainm@chromium.org>
Date:   Wed, 4 Mar 2020 19:36:57 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <1990C7E4-CB11-48A5-B07D-A06A94FB73EC@holtmann.org>
References: <20200304173249.66324-1-alainm@chromium.org>
To:     Alain Michaud <alainm@chromium.org>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

> This change adds the corresponding user space definition for wide band
> speech.
> 
> ---
> 
> doc/mgmt-api.txt | 30 ++++++++++++++++++++++++++++++
> lib/mgmt.h       |  5 ++++-
> 2 files changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index 5c23268a1..ecdfd9b95 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -3052,6 +3052,36 @@ Load Blocked Keys Command
> 	Possible errors:	Invalid Parameters
> 				Invalid Index
> 
> +Set Wide Band Speech Command
> +======================
> +
> +	Command Code:		0x0047
> +	Controller Index:	<controller id>
> +	Command Parameters:	wide_band_speech_enabled (1 Octet)
> +	Return Parameters:	Current_Settings (4 Octets)
> +
> +	This command is used to enable/disable Wide Band Speech support for a
> +	controller. The allowed values of the wide_band_speech_enabled command
> +	parameter are 0x00 and 0x01. All other values will return
> +	Invalid Parameters.
> +
> +	This command is only available for Wide Band Speech capable controllers and
> +	will yield in a Not Supported error otherwise.
> +
> +	This command can be used when the controller is not powered and
> +	all settings will be programmed once powered.
> +
> +	In case the kernel subsystem does not support Wide Band Speech or the
> +	controller does not either, the command will fail regardless.
> +
> +	This command generates a Command Complete event on success or
> +	a Command Status event on failure.
> +
> +	Possible errors:	Busy
> +				Not Supported
> +				Invalid Parameters
> +				Invalid Index
> +

I already committed the mgmt-api.txt change since I was fixing a few things in the document.

Regards

Marcel

