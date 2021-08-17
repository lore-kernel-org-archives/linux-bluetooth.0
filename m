Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD6FC4338F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Aug 2021 23:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2391C61019
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Aug 2021 23:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235393AbhHQXrW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Aug 2021 19:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235369AbhHQXrV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Aug 2021 19:47:21 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC78C061764
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Aug 2021 16:46:47 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id r4so1675139ybp.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Aug 2021 16:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5LX92XYLaFP2DfQppcVu0HjhoyUx25+0qDkFYUILhrU=;
        b=p4lpDtMGRPzk1px5LPOMnyvoZUdTt+MmjsxMA7e/d2FvSQXDbK0gT6LdK2M4/MuImq
         /bElwgrqGW4mr855KVZIULg0x5/X/8BKD6lkz0jRezYoEXHmf1ySCVggYiWfAa3xziLD
         sHPgjOtI5eCB3GlHAS5Wllb08cqk572Zn0CqORoWGrRBUrocQSTj0i4x39fL1QnLxajg
         q2c+WUEXH50uh9bXj9MXwg5dO40sNfpN3v2aPxcghe1bToxqK7QFxba8J9EUS+K427AX
         9HU3gN1BvnuR3EiW1ZOtxAQzHXccfVyv0tS05Llcjuo577P2T0f08njGiOKNezdbP2ft
         CBRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5LX92XYLaFP2DfQppcVu0HjhoyUx25+0qDkFYUILhrU=;
        b=VssaUBR4+f3jpgZeHoaXZYSFzJhho4W+4JdXqKJjw6CtoZTDpoOutVZwvQLNt8EZq7
         DFFXkC+DlhaQ9iVAMBPSGwCJD3N0eGUG4NjjAYMzHedS2ZcC+9MvRJ+iM0VrkupPMsa4
         r0uOAxW4h6MhVIO23Xzw9yPu/6Y0a+QZV25jVW8qdgb4Qdz/k//5UrIUTSvSJD0Vacs9
         CCzS6soz3ui93UHEYdCPik6GloEw1iLeFnBcttGYtyADzXQ1OiKVRgrpjuqcv96xr7xn
         m1kLN9Micf2CDoMA0alrIlMc/Mdensh4TPfTomYyvh0URCtlANOsgFuP/jPce5fikJcA
         BhIA==
X-Gm-Message-State: AOAM530pxoty2WZt95dn144GGrahWL1dAE4FYZS9t91etDBFLE2mrdqb
        mjd4/YsUyuZVikeKXselcEWuCszV+im9lM2dQ2yCids9
X-Google-Smtp-Source: ABdhPJww8GeBQwHZOpzwNUD76BVq0CeoCYLFfAtaqwLqhPgFTob3N4p2L0y6Q0o7I88YjPFJKtV2kcJXeMhKqdkzqg8=
X-Received: by 2002:a25:ce01:: with SMTP id x1mr7874866ybe.432.1629244006804;
 Tue, 17 Aug 2021 16:46:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210817010237.1792589-1-luiz.dentz@gmail.com>
In-Reply-To: <20210817010237.1792589-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 17 Aug 2021 16:46:36 -0700
Message-ID: <CABBYNZKanqKStHnTO+iFEfJ0wLCEpgHoE3m3nsqcpFm=d4XsTA@mail.gmail.com>
Subject: Re: [RFC 1/3] adapter-api: Add Experimental property
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Mon, Aug 16, 2021 at 6:02 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This adds Experimental property which indicates what experimental
> features are currently enabled.
> ---
>  doc/adapter-api.txt | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
> index 464434a81..13e904425 100644
> --- a/doc/adapter-api.txt
> +++ b/doc/adapter-api.txt
> @@ -335,3 +335,8 @@ Properties  string Address [readonly]
>                                 "peripheral": Supports the peripheral role.
>                                 "central-peripheral": Supports both roles
>                                                       concurrently.
> +
> +               array{string} Experimental [readonly, optional]
> +
> +                       List of 128-bit UUIDs that represents the experimental
> +                       features currently enabled.
> --
> 2.31.1
>

Any feedback on this, by design this would only appear when
experimental is enabled (either via main.conf or using -E), the
intention is to have a common way to expose to application a certain
experimental feature is enabled.

-- 
Luiz Augusto von Dentz
