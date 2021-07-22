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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA8DC6377D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 17:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E8AE611C1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 17:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhGVQxX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Jul 2021 12:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhGVQxX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Jul 2021 12:53:23 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB072C061575
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 10:33:57 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id t186so6666773ybf.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 10:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FX7uGT/LtaCtaLWZQ+MWzHZ6Mgny7SPOIF7zoGEpiig=;
        b=Y/czBGsWo/9blbUd/dGg8zZLHaOcLHkh5DJPyHePxdn33Bi0HAGroTGNi0mQyTAu5h
         X3zA6GhfaOfi2TXJXDG5ejPsceDIHnu92TcHsoHXrotLRT9/2Q0aXZZTE5lTBrABnhaM
         o6HvW9yNs01zEwXOkXcUCxdO/G8ISwbQ2VzLsGDF4ZG8fuvpJ6KwhjFxk6hTbBUowLfy
         htjTv+rq+UMzDXvfgX68G88v6PN75OnbVhwTmATXc8Is4hVmwMejLzYTt8iyE3qaYZ78
         QpAQCfLV06TGRmq+uYp9XJaOOg6L/QtoN3mq6Mt76/nPZjKf8cCnN2z2gNIvhLmv+w2o
         Ghnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FX7uGT/LtaCtaLWZQ+MWzHZ6Mgny7SPOIF7zoGEpiig=;
        b=YXp3N+nFUoLUIEF8FOdJplCL+xP7+moOpAoJ3JyZfvATA1VC8UjzW9ZR6U37016cpS
         /Ij3wRPnkEuN+9O691dsBuDU3a/Q07fwW21mrRhG9owvrtd+WfA/F9XU1QPJF52zUDSc
         tVpHXbLUg3YPXGZDdrPemqhkwiOwQBbSv2zbzxW1NOJfGN/tJjvdNcp0iF7V0heugPKB
         Q0vtz0ozCHLbuP5cxeE/v99ipGqauDbeSQ3/+xVPaJRfdxZU1iZ9tbiDfIPd15DJv9RL
         18K6rdMhWV+oiK0DJYYfRuawqvbO5AZd+vT5FzsnO4lOc5H5wA19nsk5zkQTIZq0jxnJ
         ECpA==
X-Gm-Message-State: AOAM531OKyGN40OeJC9FP08Zmd0cmSxFs2wocprbqYwHDVm3tWB6+e8R
        b+hDIImGY1N0fctvIcWXkV4gb/dEfb81C2nMimo=
X-Google-Smtp-Source: ABdhPJxcc/RhVG+TbkP6dbJpbt1G4nMeRNY7OfKUZzE4XX/yWV4MtA9VYi44NWrFDCoLfFs+Hz9galjOvPmpgXB5th4=
X-Received: by 2002:a25:fc1c:: with SMTP id v28mr882354ybd.408.1626975237083;
 Thu, 22 Jul 2021 10:33:57 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20210722055009epcas5p25e4997aa7e53cb2a6e3780fdb7301785@epcas5p2.samsung.com>
 <20210722054951.8291-1-ayush.garg@samsung.com> <20210722054951.8291-2-ayush.garg@samsung.com>
In-Reply-To: <20210722054951.8291-2-ayush.garg@samsung.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 22 Jul 2021 10:33:46 -0700
Message-ID: <CABBYNZLZUB1CsJpYqC=ioZrBzM+BV9n6VMPCobFDKsm00FBo4w@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/8] doc/device-api: Add Phy property
To:     Ayush Garg <ayush.garg@samsung.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Anupam Roy <anupam.r@samsung.com>, nitin.j@samsung.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Ayush,

On Wed, Jul 21, 2021 at 11:03 PM Ayush Garg <ayush.garg@samsung.com> wrote:
>
> This will allow to set the LE PHY preferences for
> a connected device.
>
> Reviewed-by: Anupam Roy <anupam.r@samsung.com>
> ---
>  doc/device-api.txt | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/doc/device-api.txt b/doc/device-api.txt
> index 4e824d2de..d0e108f74 100644
> --- a/doc/device-api.txt
> +++ b/doc/device-api.txt
> @@ -272,3 +272,25 @@ Properties string Address [readonly]
>                         Example:
>                                 <Transport Discovery> <Organization Flags...>
>                                 0x26                   0x01         0x01...
> +
> +               array{string} Phy [readwrite, optional]
> +
> +                       PHY Preferences for a connected device.
> +
> +                       Note: The controller might not be able to make the
> +                       change because of reasons like peer not supporting
> +                       the requested PHY or it couldnot schedule due to
> +                       other activites.
> +
> +                       This is only available for LE capable controllers.
> +                       It will return Not Supported Otherwise.

The property shall be omitted if LE is not enabled, I guess that was
the intent of optional but saying it would return NotSupport means
otherwise.

> +
> +                       Possible values:
> +                               "LE1MTX"
> +                               "LE1MRX"
> +                               "LE2MTX"
> +                               "LE2MRX"
> +                               "LECODEDTX"
> +                               "LECODEDRX"
> +                               "LECODEDS2"
> +                               "LECODEDS8"
> --
> 2.17.1

I guess the intend here would be to have a prefered PHY for LE, but I
wonder if this would really help since different profiles/service may
have different preferences, also by being an array I assume one would
need to the enter in the preferred order which should probably be
stated and again depending on the use case this could be a config
setting in main.conf instead so it is applied globally to all devices
by drivers can overwrite it with their own preferences.

-- 
Luiz Augusto von Dentz
