Return-Path: <SRS0=dAEe=7O=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30AD4C433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Jun 2020 12:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 000E120679
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Jun 2020 12:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591016334;
	bh=HfmEynBrmGVKRRxfBGAZb9y2U+saq1h9cry3QHH9Yfk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=h74RsBffQdC1PNRKlhOUoVcb2bdcEjhwoEK4PpKCbycbYlj/oWHSX/0hjz78VXH5Q
	 S6k34eIMLtxAUaKtXB/KuMQk7qMrX2UR/lDVvLqYBIG7lFV4Ioe1XHidXk/UPGakIK
	 b4KY5F2qJ9xRh0BjXpNJ2qkzzOc0PpXRuDsA1isI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbgFAM6x (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Jun 2020 08:58:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:60932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbgFAM6x (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Jun 2020 08:58:53 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8EE420679;
        Mon,  1 Jun 2020 12:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591016333;
        bh=HfmEynBrmGVKRRxfBGAZb9y2U+saq1h9cry3QHH9Yfk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bv7ObUH358a8Ccef4DsRGXYy1RTgVYkhIdpV7WclCB3OF7DECeuNyPbqMTXPg7a16
         MQIrnef93wm4a/v1XLldxt/XvwSqCIZtzwcMC3fxX59tr+MZN9pbyYFqrD32B+DGnk
         ZRRuezMbcsuiFm9xHxAu5cbFemnp4jEgagba/aRI=
Received: by pali.im (Postfix)
        id 9C3F3CB0; Mon,  1 Jun 2020 14:58:50 +0200 (CEST)
Date:   Mon, 1 Jun 2020 14:58:50 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: [PATCH] Install avinfo utility
Message-ID: <20200601125850.q2l3yaow3kruugvd@pali>
References: <20200506193435.3746-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200506193435.3746-1-pali@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wednesday 06 May 2020 21:34:35 Pali Rohár wrote:
> This utility is very useful for determining which A2DP codecs are supported
> by remote side. So install it to system as part of bluez package.
> ---
>  Makefile.tools | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Ping?

> diff --git a/Makefile.tools b/Makefile.tools
> index 9b9236609..d52721612 100644
> --- a/Makefile.tools
> +++ b/Makefile.tools
> @@ -176,9 +176,9 @@ endif
>  if TOOLS
>  bin_PROGRAMS += tools/rctest tools/l2test tools/l2ping tools/bccmd \
>  			tools/bluemoon tools/hex2hcd tools/mpris-proxy \
> -			tools/btattach
> +			tools/btattach tools/avinfo
>  
> -noinst_PROGRAMS += tools/bdaddr tools/avinfo tools/avtest \
> +noinst_PROGRAMS += tools/bdaddr tools/avtest \
>  			tools/scotest tools/amptest tools/hwdb \
>  			tools/hcieventmask tools/hcisecfilter \
>  			tools/btinfo tools/btconfig \
> -- 
> 2.20.1
> 
