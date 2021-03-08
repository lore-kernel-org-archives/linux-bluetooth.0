Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDF1C4332E
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Mar 2021 18:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EEC165202
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Mar 2021 18:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhCHSg2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Mar 2021 13:36:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbhCHSgN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Mar 2021 13:36:13 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CBFC06174A
        for <linux-bluetooth@vger.kernel.org>; Mon,  8 Mar 2021 10:36:13 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id j22so4353408otp.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Mar 2021 10:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IokpKDXy0gIiZadJsX6stztbVXLb8FYGSIlq5mkLaBg=;
        b=dCyKxvkKzFnGbQ2FpHemgDl1i112MPz+RIdwPvbiZAlf8BXAhh16ae3rTCYMRgdVtT
         GNKPbw0HuqSX4GkYHAnDXGw2ZswWhn73xC5ysstVnzx3rfbE8o/VXIyH0Qsv5G2URml6
         Tu4f0vcGfCPf7sl5wpCkydiPAWDQq6xZ9bLv3+u+si80b+1GPlYe13N9vWI7Cvfq586b
         mOcOhdEUU5hUSJbQU8oqD+Q6DO+mZ22aBbyl//6zpuJWMLxouWxcEWxdlTMuIpETdHcE
         dVvOv+JYtWKPawfHyyCkj8dNIxxJb7ZTV0RbT99QT+UN4MoImNtZnNoO4IE+aQmcp3lb
         uQwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IokpKDXy0gIiZadJsX6stztbVXLb8FYGSIlq5mkLaBg=;
        b=G/adcx8xlakCu4usUvksdXNwsQANqogaOT/jqzU3dGR1XpJIO7p5CbuvCZoVaT0rmg
         jyiepT3jYTAcNTuHZ+sYUyBrOPnQBT4pV0GNQaJhksaw+IpH23Lhnjgc4HimqWZBkbGC
         MpdQX8Y0WfUg12UQfmrszVJh2NmcRU7LYfRIlQ6CDgEY4HogCaR6DS0k+FetAWm5TLCK
         A2f35BLpfAmG+ETV4NvhDeL7ICvlD/u/MTE6joBYBz5JLqPiFXhaLXiz7EM9YkoNxx6x
         P1C2EqLrNhqCmzo6MXa7okpz/1wTg6ZQ1BHhbP1Mxl1ATcWuMnGRMfk49U4O8rKET5UL
         AhOw==
X-Gm-Message-State: AOAM530wgD/FXkbRVQLaqNnEk2QIV/30+8eecMt6gntkfV4LFfbT+2Xr
        sy+TfkftNgTJ2F5SDBeQU8MNZpVSkZRpUFWS888=
X-Google-Smtp-Source: ABdhPJy5HbFmNK4L/jUxoKY4FwK1RC6YuakpPTe8wLdDiOhKpsH612Jbx2YBQc7kRsORUpZsBDTyAm8ofYabEogK/NU=
X-Received: by 2002:a9d:7b44:: with SMTP id f4mr21852803oto.240.1615228573079;
 Mon, 08 Mar 2021 10:36:13 -0800 (PST)
MIME-Version: 1.0
References: <20210305235217.2382976-1-danielwinkler@google.com> <20210305155113.Bluez.v3.3.Ieb6522963e3f54b0d63dd88ed3ce24a8942ed73e@changeid>
In-Reply-To: <20210305155113.Bluez.v3.3.Ieb6522963e3f54b0d63dd88ed3ce24a8942ed73e@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 8 Mar 2021 10:36:02 -0800
Message-ID: <CABBYNZKeiHhiro2tryrku=3vjWMXuBsWfGvgnJB6Ka-7orf-Pw@mail.gmail.com>
Subject: Re: [Bluez PATCH v3 3/3] doc/advertising-api: Add adv
 SupportedFeatures to doc
To:     Daniel Winkler <danielwinkler@google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Daniel,

On Fri, Mar 5, 2021 at 3:59 PM Daniel Winkler <danielwinkler@google.com> wrote:
>
> Add supported features to advertising dbus api.
>
> Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> ---
>
> Changes in v3:
> - Rebased onto master
>
> Changes in v2:
> - Doc: Expect empty SupportedFeatures if no support available
>
>  doc/advertising-api.txt | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt
> index 541c57004..ba9eacaae 100644
> --- a/doc/advertising-api.txt
> +++ b/doc/advertising-api.txt
> @@ -235,6 +235,7 @@ Properties  byte ActiveInstances
>                                          "2M"
>                                          "Coded"
>
> +

Extra empty line.

>                 dict SupportedCapabilities [Experimental]
>
>                         Enumerates Advertising-related controller capabilities
> @@ -257,3 +258,22 @@ Properties byte ActiveInstances
>                                 int16 MaxTxPower
>
>                                         Max advertising tx power (dBm)
> +
> +
> +               array{string} SupportedFeatures [readonly, optional]

This shall probably be marked as experimental for now.

> +
> +                       List of supported platform features. If no features
> +                       are available on the platform, the SupportedFeatures
> +                       array will be empty.
> +
> +                       Possible values: "CanSetTxPower"
> +
> +                                               Indicates whether platform can
> +                                               specify tx power on each
> +                                               advertising instance.
> +
> +                                        "HardwareOffload"
> +
> +                                               Indicates whether multiple
> +                                               advertising will be offloaded
> +                                               to the controller.
> --
> 2.30.1.766.gb4fecdf3b7-goog
>


-- 
Luiz Augusto von Dentz
