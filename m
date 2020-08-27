Return-Path: <SRS0=2B3h=CF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7069FC433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Aug 2020 17:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B7C02087E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Aug 2020 17:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQ8oPgF/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbgH0RzW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Aug 2020 13:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbgH0RzW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Aug 2020 13:55:22 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89620C061264
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2020 10:55:21 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id j18so5364129oig.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2020 10:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j6hmv2VFrPeKS/IkOSA+hkC5KX7drhT9XYW0bLgpA3U=;
        b=BQ8oPgF/o6AAMz7GIPagL6Lwu5cj0QWvvkwsXuyR8GaqfulfFjL+ZPxw7VBPlk7lm+
         sh7wnwUEh9N89rKlW/GkmClqryvDoGBRjQaPkb4Yzp4FXnydH5V2UWndYPlX9qhbUDOf
         G0M6QS2bIbO7IhrrMgtpduU8wB//sdPhfXvkSWnHQK7CQXi0mfYqeuk9XHn9YfX+YKov
         sqkFPMXem0vnnYXqgx0ZnrI177ms/IH2WfMn9YhWw8deQPO0WAwBo0YPipgXmQNQ6m+j
         mhBTyA+4jgcGaOHVCGmoMKPUkA/y/t9F4hOfA2B2YpvKZ3Ne2cCRej0FMVTxP1yiGiCR
         UWwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j6hmv2VFrPeKS/IkOSA+hkC5KX7drhT9XYW0bLgpA3U=;
        b=oKIEZJa2ABccdquoZoBca9YL5oHgtvh5cDPM9JTBkXgQ8N97RNEN8aL7rXRycDVz55
         bb+CQeSMJ0pbxFEsj0Hb29nm5yLfWx7Jsqk8AY6Ga4RrpaMJWjzV0TG/TsK7RxzUuIwA
         iMMqlfUsOuGbkO8zROr0xWSe+/qz1vhMqfdmtdLiA4ygqMrFD9o7fZDpoCThCUQJ4SLU
         k+EGHyxeGM+0CBHhroO9+jdJ0ON9mxVY/KgDpPVJ5PnS65ZoAReHnCrABxZBNnUSOSyH
         RzIW8K6nAShYmG7/buF9ZsW0hHycLxSX9Qa0HFUtE3fwSoIfADiYcvpc42plc8oo2h3r
         7RHw==
X-Gm-Message-State: AOAM530bwqGU/IZNY2kAQ+a/C8pfyeBQdP7BAFtDyo2RtrgcJsc/jVFZ
        SnBwCH1rB9FvgJQOfybbRNwK2vRhvCgF6hjB6HMvKt5A
X-Google-Smtp-Source: ABdhPJzgU9bnHtYx7CfPUQRm3iU7mLLt59US/YRzVw2ThY1+EiyeYDXRAPpZxX72eduvIjASz/wGFIT8Nz1QZQWXIyQ=
X-Received: by 2002:a54:478f:: with SMTP id o15mr17474oic.137.1598550920962;
 Thu, 27 Aug 2020 10:55:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200827112759.6914-1-edef@edef.eu>
In-Reply-To: <20200827112759.6914-1-edef@edef.eu>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 27 Aug 2020 10:55:10 -0700
Message-ID: <CABBYNZJ8QzWF88BoxK3CbxhNiyWONfzZx5ChyD_ZB8BRXp1m-g@mail.gmail.com>
Subject: Re: [PATCH BlueZ] profiles/network: Log connection event after
 setting device name
To:     edef <edef@edef.eu>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Edef,

On Thu, Aug 27, 2020 at 8:21 AM edef <edef@edef.eu> wrote:
>
> Without reordering these two statements, the logs look like this:
>
>     bnep%d connected
>     bnep0 disconnected
> ---
>  profiles/network/connection.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/profiles/network/connection.c b/profiles/network/connection.c
> index 97b87d02e..170841de6 100644
> --- a/profiles/network/connection.c
> +++ b/profiles/network/connection.c
> @@ -216,9 +216,9 @@ static void bnep_conn_cb(char *iface, int err, void *data)
>                 goto failed;
>         }
>
> +       memcpy(nc->dev, iface, sizeof(nc->dev));
>         info("%s connected", nc->dev);
>
> -       memcpy(nc->dev, iface, sizeof(nc->dev));
>         btd_service_connecting_complete(nc->service, 0);
>
>         if (nc->connect)
> --
> 2.27.0

Applied, thanks.

-- 
Luiz Augusto von Dentz
