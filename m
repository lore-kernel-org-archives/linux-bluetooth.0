Return-Path: <SRS0=vsJv=6G=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E20C54FCB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Apr 2020 17:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38D582073A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Apr 2020 17:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgDVRfW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Apr 2020 13:35:22 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:46864 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgDVRfW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Apr 2020 13:35:22 -0400
Received: from [192.168.1.91] (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 28CADCECFD;
        Wed, 22 Apr 2020 19:44:59 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [BlueZ PATCH v2] doc:Adding LESupportedRoles property
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200421204722.195637-1-alainm@chromium.org>
Date:   Wed, 22 Apr 2020 19:34:50 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <37A7A874-31C4-4DD7-AB71-1C3C0837DDAE@holtmann.org>
References: <20200421204722.195637-1-alainm@chromium.org>
To:     Alain Michaud <alainm@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

> This change adds a new property to indicate the support for concurrent
> LE roles which means that the controller has reported the appropriate
> LE_Supported_States (hdev->le_states) and that the controller's driver
> has reported correctly handling the various reported states.
> ---
> 
> doc/adapter-api.txt | 8 ++++++++
> 1 file changed, 8 insertions(+)
> 
> diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
> index acae032d9..f76e1e910 100644
> --- a/doc/adapter-api.txt
> +++ b/doc/adapter-api.txt
> @@ -326,3 +326,11 @@ Properties	string Address [readonly]
> 
> 			Local Device ID information in modalias format
> 			used by the kernel and udev.
> +
> +		array{string} LERoles [readonly]

I would just call it Roles. Then we can extend it without having to be LE specific.

> +
> +			List of supported LE roles.  Possible values:
> +				"central" - Supports the central role.
> +				"peripheral" - Supports the peripheral role.
> +				"central-peripheral" - Supports both roles
> +						       concurrently.

Otherwise I am good with this.

Regards

Marcel

