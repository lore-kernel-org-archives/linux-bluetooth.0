Return-Path: <SRS0=8+Sx=7X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85682C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 08:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63C2C20734
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 08:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgFJI11 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Jun 2020 04:27:27 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:52330 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgFJI10 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Jun 2020 04:27:26 -0400
Received: from marcel-macbook.fritz.box (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id 5DDE8CECE0;
        Wed, 10 Jun 2020 10:37:15 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] Install avinfo utility
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200506193435.3746-1-pali@kernel.org>
Date:   Wed, 10 Jun 2020 10:27:25 +0200
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <CECA6D9A-0F26-40E8-BFDF-A24CD972307D@holtmann.org>
References: <20200506193435.3746-1-pali@kernel.org>
To:     =?utf-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

> This utility is very useful for determining which A2DP codecs are supported
> by remote side. So install it to system as part of bluez package.
> ---
> Makefile.tools | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Makefile.tools b/Makefile.tools
> index 9b9236609..d52721612 100644
> --- a/Makefile.tools
> +++ b/Makefile.tools
> @@ -176,9 +176,9 @@ endif
> if TOOLS
> bin_PROGRAMS += tools/rctest tools/l2test tools/l2ping tools/bccmd \
> 			tools/bluemoon tools/hex2hcd tools/mpris-proxy \
> -			tools/btattach
> +			tools/btattach tools/avinfo
> 
> -noinst_PROGRAMS += tools/bdaddr tools/avinfo tools/avtest \
> +noinst_PROGRAMS += tools/bdaddr tools/avtest \
> 			tools/scotest tools/amptest tools/hwdb \
> 			tools/hcieventmask tools/hcisecfilter \
> 			tools/btinfo tools/btconfig \

I had no intention to install that tool since it is too limited and makes too many assumption. In addition it has a bad name with no Bluetooth prefix.

If we think it is useful to have such a test utility, then we need to clean this up first and put this into a larger btinfo work to gather appropriate information from a remote device for debug purposes.

Regards

Marcel

