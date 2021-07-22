Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F128C63797
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 17:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6194461279
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 17:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbhGVQkE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Jul 2021 12:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhGVQkD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Jul 2021 12:40:03 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AF6C061575
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 10:20:38 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id y38so6521451ybi.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 10:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tH8lPjuXyAGZkVGYUOOpNa1tNdQn40RhraGHQ4fQNwc=;
        b=RPz2/SauepElXXQ0yJOVClQWbLh2eD3UTPVFWBrTYHxrPPQ8ioT276lVE4c2IURJAo
         c4G0I+Z/9HoS409+SyN8YO4IdCLh3Ahy9zjrHDKkvE8iPmUNxJaVQLVq0/dagPtjbAN+
         Tp3W3XyhvDkr8sR35M+DJpgaKsSuS2tKIOIo5QAuiER6d4ti02N7rgCM8sVmRnslysRN
         AkOjX1X4GlA4JEuNKf6xTFGk2G5IGZaOS7s1gutdp3fksk8VDMv6M6e+zZdd4Ck/aavv
         tIF2FCxG3q9xjPvR13wPbxr+fXKFcWVBaL2GVLVMCwww8735rdXAKPKizdkJxcUDJtJa
         K5SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tH8lPjuXyAGZkVGYUOOpNa1tNdQn40RhraGHQ4fQNwc=;
        b=Vy5xBw29J9bDv0XP2yynxF7O5dVc+XoILPDq4D7zBPGlKOuBoPdOQM50qK2pxBRtur
         tN+HV3WH0QuP1upzLeY2qWQuqzYLWrZkMCdgv3sL6/Gw617Lvwp6tR4vpm3PDWHrI4bL
         KquvFE2884tpTjrWpQj3D1n0TITDn9Rcvqr/dvEqppTl3wnYvp6xm1L5aVjovROCf63X
         lEQ0V13NBkrNxXmiKxojEFitvQ7yeiBpBMDso2y+WkvlyLy7ESPKtXyWsSUE6DP4VfvI
         0OY46XPfBEx9tnT714nki4W+NbKeE75HWfRq518IpqDcWxUmciAoLlZi5OoeOtuUSuh6
         AyAg==
X-Gm-Message-State: AOAM533tYqLjrK2AAyB99B1Vr0OffOAm4welpAzo3m8qVcEiPKA+Y4DR
        +0ij/5GQklrS5ECRbX4fnba/HeTlFODIY2tgGLw=
X-Google-Smtp-Source: ABdhPJzR92AS2O74LYwuLIekzuTuzsfkLpPPL1m+ToSTyhVJREIfjFKhXv46ylqugcLIUGQ2ms+d5WBU/535I8Yy2iE=
X-Received: by 2002:a25:b741:: with SMTP id e1mr703151ybm.347.1626974437498;
 Thu, 22 Jul 2021 10:20:37 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20210722052739epcas5p4412d38b394f51ab195c77c887f0a0aaf@epcas5p4.samsung.com>
 <20210722052640.5863-1-ayush.garg@samsung.com> <20210722052640.5863-3-ayush.garg@samsung.com>
In-Reply-To: <20210722052640.5863-3-ayush.garg@samsung.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 22 Jul 2021 10:20:26 -0700
Message-ID: <CABBYNZJ5k-G55ACT412-7=Be=3nVqRUL0ep_Tx2UFi5onnAH+Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/7] doc/adapter-api: Add PhyConfiguration property
To:     Ayush Garg <ayush.garg@samsung.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Anupam Roy <anupam.r@samsung.com>, nitin.j@samsung.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Ayush,

On Wed, Jul 21, 2021 at 11:02 PM Ayush Garg <ayush.garg@samsung.com> wrote:
>
> This change add a new property which will allow the user
> to get the controller's current selected PHYs and to
> change it at any point of time.
>
> Reviewed-by: Anupam Roy <anupam.r@samsung.com>
> ---
>  doc/adapter-api.txt | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
> index 25e370d75..97af8e70b 100644
> --- a/doc/adapter-api.txt
> +++ b/doc/adapter-api.txt
> @@ -356,3 +356,17 @@ Properties string Address [readonly]
>                                 "LE2MRX"
>                                 "LECODEDTX"
>                                 "LECODEDRX"
> +
> +               array{string} PhyConfiguration [readwrite]
> +
> +                       Set/Get the default PHYs to the controller.
> +
> +                       These PHYs will be used for all the
> +                       subsequent scanning and connection initiation.
> +
> +                       The value of this property is persistent. After
> +                       restart or unplugging of the adapter it will continue
> +                       with the last set PHYs.
> +
> +                       Refer SupportedPhyConfiguration property
> +                       for the possible values.
> --
> 2.17.1

You should probably have create a github issue to discuss the API
first, anyway for the adapter I don't think we should be doing the PHY
configuration at runtime so it would probably have been better to have
such configuration as part of main.conf, and Ive done this with a
exclude logic so one can disable PHYs that it doesn't want the system
to use.


-- 
Luiz Augusto von Dentz
