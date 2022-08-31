Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA09FECAAD4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 Aug 2022 20:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbiHaUoE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 31 Aug 2022 16:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiHaUoB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 31 Aug 2022 16:44:01 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA81BE9930
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Aug 2022 13:44:00 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id z23so12981797ljk.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Aug 2022 13:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ybvS/jiElGCm8zoq/NJTfLpOIeFa+N2d11BfGqBk67c=;
        b=IR/DRVdkum90/U6jMw8YUQyw9EiAqLC5+Z5gcwyMpR4zUhmiT4T17W581yxKh6VLVM
         1LIhtY3h2/Ret3aSQrJ/KRIeOMd3rocl+UGtVLstnujYwrl5g4Z6UXxz0+TYLE7iMJ8f
         4rO/l818fXNBLH8KjNMiByo+czUMdjgAGj4P2YwivWtbHSwQU+TEeDLEch45IQtKn16g
         pztB5XQnYSc2hCpcQAMnbHOgk4jQnlH74VeetICGgnB+gz5vg9ZSFMBH/FxxQgVnpyCv
         v8TeUPeJ9Nu6iqhKP9P0U1x36MG+yopL2EIQdVveh9ve6b3JBhFbtxu/Zxmr3I1GgIbX
         os5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ybvS/jiElGCm8zoq/NJTfLpOIeFa+N2d11BfGqBk67c=;
        b=PokPe5AL9mOEaO5awEWLTLTI3h+i0MJb54JXDuccIqig1NiUMXgc4QHJPBGpm0ZLGP
         03iRhJCUHx6Nsulriv85N43F+8wgNa1XVK8fj3o+QJps+yXJfNWBV/zJoqU6MeKLswBo
         1vFrty42bilqMcgzufKae3tEE3syHzpIjqCOq/FBX8Qaz96F5rgs8wmQiuOH+mPKbtQg
         muIuLWDM/NSCGuH9kuz210jfGM81eH0KfTiAhiTEM9KXSTIfGTWCiTgqBNEjv20lqo/j
         MXcicX0KxgGVdzN3f+8YMlDlNSXDVNLLosDLyquAgQ/hiqJjJHYu/4XqQxbAyu71vZSs
         5euA==
X-Gm-Message-State: ACgBeo2McmFH6zz7OnBO25DaLFmSrZV2m6P0puWHvPJBF1My/4jBjvO/
        hZg0RHl16qddY6MaZJw8dStBHRGj3fBfrWHRHqmxkh0I
X-Google-Smtp-Source: AA6agR7qeNYFIWkMNhYFrEwZD50P+njhpHri1Qr5WMp2dxA1pksZ1Lk/liD1xwriI+eEZD1yfTNORLWOKCI4jag1Q2g=
X-Received: by 2002:a2e:9c84:0:b0:268:8e0f:78cd with SMTP id
 x4-20020a2e9c84000000b002688e0f78cdmr1359130lji.432.1661978639062; Wed, 31
 Aug 2022 13:43:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220831113647.85110-1-hadess@hadess.net> <20220831113647.85110-4-hadess@hadess.net>
In-Reply-To: <20220831113647.85110-4-hadess@hadess.net>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 31 Aug 2022 13:43:47 -0700
Message-ID: <CABBYNZL3iTX8sLnQy6Bo_kchqiHXr5VUTz0g29ay3xoXLs76Fw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v5 4/6] adapter-api: Add PowerState property documentation
To:     Bastien Nocera <hadess@hadess.net>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Bastien,

On Wed, Aug 31, 2022 at 4:40 AM Bastien Nocera <hadess@hadess.net> wrote:
>
> ---
>  doc/adapter-api.txt | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
> index 48466ab75..28e53a105 100644
> --- a/doc/adapter-api.txt
> +++ b/doc/adapter-api.txt
> @@ -269,6 +269,21 @@ Properties string Address [readonly]
>                         restart or unplugging of the adapter it will reset
>                         back to false.
>
> +               string PowerState [readonly]

We should have it documented as experimental as well.

> +
> +                       The power state of an adapter.
> +
> +                       The power state will show whether the adapter is
> +                       turning off, or turning on, as well as being on
> +                       or off.
> +
> +                       Possible values:
> +                               "on" - powered on
> +                               "off" - powered off
> +                               "off-enabling" - transitioning from "off" to "on"
> +                               "on-disabling" - transitioning from "on" to "off"
> +                               "off-blocked" - blocked by rfkill
> +
>                 boolean Discoverable [readwrite]
>
>                         Switch an adapter to discoverable or non-discoverable
> --
> 2.37.2
>


-- 
Luiz Augusto von Dentz
