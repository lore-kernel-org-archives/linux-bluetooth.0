Return-Path: <SRS0=YM4v=Q4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC43C4360F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Feb 2019 12:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C6C620855
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Feb 2019 12:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URQYsnYH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfBUMKO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Feb 2019 07:10:14 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41092 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfBUMKN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Feb 2019 07:10:13 -0500
Received: by mail-ot1-f67.google.com with SMTP id t7so28274868otk.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Feb 2019 04:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=hTnamW/zUQ/NnHJGMDM6ZcCNfRSd4bwQFrG8aGBycCs=;
        b=URQYsnYHmHQi2Ci/iKojax8ovGlKEYyUlZZFyOU62H5jz5INgHLl7qa45GwS75m5xc
         7G3xmrMCzq56Vv8X/y+7wb+f7BPhpQwFUJjHqtNTZdRQaWOLNNrAW7X5bT0/SxNW++Bb
         b/xXxodLOxDNBGaRvnfKO1i+MM1hZAUlGbcmTH5ZYcYVTFNJ/aANvDghIioXJubfRPk4
         UaTTLm/NutTAybAPYQecVZsdrQwya6sCI7Gd3A2Nut7iSKN0nsNJ4286zlg2112PBT9G
         +zWY1nJDnHtUywM69doRGI8HA1b8hwz84KY9EOs1fc8O0+s4mez5+rVbdi9MWtg+lAhM
         jopg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=hTnamW/zUQ/NnHJGMDM6ZcCNfRSd4bwQFrG8aGBycCs=;
        b=CJcEF2ioKPQqI0O2eTFQAo9Uf4EbYHJF48ERd9zlmws5oxh40jsBSbxLr5o19MLfXc
         nBoQ6l/Vg3TmwchGk/xgDJVLoJHBaDXJ24J9iHtofjy1hvOU+pnIiiUO5e1AMhMjEVNL
         u7GKD4qPmav0M5cgImcbvZGMc7p7GqAa94OdVnpp6BIptPLpzSJILLdjArVuXXbYbXTv
         InpqplFYmapdIFdldI32WVsL/pPSZXmzeeQBukHevxaMdCICk7TmaWTw3RG+IbE07F1/
         +6vDj48J9ZnvQOJlgopGWj9nvkJy2RvAQZP3zWPkGVXtVzf3JMaCR++ih9525+Ec4hf5
         c0dw==
X-Gm-Message-State: AHQUAua2KgL60aMKLs9gzLwQYsCYDLJXmD1cTH8pd03t3C972p7HFe+p
        zEfVp5YJssTGEJQajkBt5VPkClKeewrSDryKVOfWyQ==
X-Google-Smtp-Source: AHgI3IYaY9Bykhp29/Bp+gXA6RkPBg8pOYfjwmUMrzstwBFsyspyU4ikMVO84beVTBCvFj8f5DtYie6nH0t2AISAvG8=
X-Received: by 2002:a9d:72c3:: with SMTP id d3mr14085424otk.71.1550751011571;
 Thu, 21 Feb 2019 04:10:11 -0800 (PST)
MIME-Version: 1.0
References: <20190215142301.30909-1-luiz.dentz@gmail.com>
In-Reply-To: <20190215142301.30909-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 21 Feb 2019 14:09:59 +0200
Message-ID: <CABBYNZLrE8TEeRrOzE7YTz9oRTT63nSyxMu9ACAg1SAmU1Moug@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/4] doc/advertising-api: Add support for setting
 Secondary Channel
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,
On Fri, Feb 15, 2019 at 4:23 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This enables reading and setting the Secondary Channel/PHY supported
> by the controller.
> ---
>  doc/advertising-api.txt | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt
> index cfce0f9a3..b0565eab2 100644
> --- a/doc/advertising-api.txt
> +++ b/doc/advertising-api.txt
> @@ -129,6 +129,15 @@ Properties string Type
>                         Timeout of the advertisement in seconds. This defines
>                         the lifetime of the advertisement.
>
> +               string SecondaryChannel [Experimental]
> +
> +                       Secondary channel to be used. Primary channel is
> +                       always set to "1M" except when "Coded" is set.
> +
> +                       Possible value: "1M" (default)
> +                                       "2M"
> +                                       "Coded"
> +
>  LE Advertising Manager hierarchy
>  ================================
>
> @@ -190,3 +199,13 @@ Properties byte ActiveInstances
>                         Possible values: "tx-power"
>                                          "appearance"
>                                          "local-name"
> +
> +               array{string} SupportedSecondaryChannels [Experimental]
> +
> +                       List of supported Secondary channels. Secondary
> +                       channels can be used to advertise with the
> +                       corresponding PHY.
> +
> +                       Possible values: "1M"
> +                                        "2M"
> +                                        "Coded"
> --
> 2.17.2

Applied.


-- 
Luiz Augusto von Dentz
