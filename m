Return-Path: <SRS0=gY20=5B=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD681C0044D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Mar 2020 20:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89B0F2073C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Mar 2020 20:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2QK7spW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732588AbgCPUwd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Mar 2020 16:52:33 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46777 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732567AbgCPUwd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Mar 2020 16:52:33 -0400
Received: by mail-oi1-f196.google.com with SMTP id x5so1605648oic.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Mar 2020 13:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=RhsyPaVK1yQTl06RsduJKOP4k1mkojm/ZQ9bgji1Amw=;
        b=a2QK7spWzI+7RmwzfQFQGNh0fQxDDzFxHY1qSpTtLY1slz+hYFz1xaHOvF0u6tq3Hu
         nzq4+iAZivqCGTjQJaacOIXQ4Q5hbb3aHy+XHpZv620865bcfiUZ/xkvAn0VCOE9iNTj
         mRP24y3NLtf6zbAecunEFEvYmFlgscJFO8psjoQuvkpoizUY3Gw1N90UjP5rw5aHTUid
         ShZcFcsgo5qZw3w2wgE+QKlcWSAbtB1FGZwY7B0RS3wtetQOgeWZFDgAmm+i6aIE5X8o
         /xdx6TvTrgcROTRV4UvoVulzaDQsOZ+2DXo0kIw6zEC9CdVjmURuho8eavtc4jcvvSRN
         rFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=RhsyPaVK1yQTl06RsduJKOP4k1mkojm/ZQ9bgji1Amw=;
        b=HPfmuhyhieRZ14PLUOHLxX0wPaH36oNIbu98kb6+IdZGv8b+zl98lcFi1OGByLL+qq
         q7C8VynstohUp5wgWq84dW52swu96OJFzl7jFH1zSKK6nGdlGkDJ6Ex5TA8KBt4Giga7
         cz8Gf24cQl4yI9WzBXe7GlyLacWvAjd+3vDKHbkFIkI7wVmhbqIEPCfgoexpSSUn91uU
         EVqVLsbbr9TWv+9IEQNXVbKRneT2f8ts+pMMk4YK0cH5yEv2lIzfSqrWjK+jrVUqdmgp
         AstyvtJz9Z1VTt6dg+8howbOdM+jfpv0xb5zD2jE3MgtHQCPM/XHtTfm7sFxE89D00mI
         QXEQ==
X-Gm-Message-State: ANhLgQ1Ok3Oy+nrveyiy8/LOaQRunHP1pLBWI2wPSmMlGNOGYGGreeZF
        LlK4bcZRSc/hJuM9yD6YGujQsJiG0eHZH9hoJ2dxkA==
X-Google-Smtp-Source: ADFU+vvx/PQfzkJ+FDUhk6A1mzg8vzqB9quPlR695jfrp3rQtk8ZsC55O20YjVXHvzeH81lvmBxN5g7pAq1PoGKP16Y=
X-Received: by 2002:aca:5345:: with SMTP id h66mr1093691oib.110.1584391951690;
 Mon, 16 Mar 2020 13:52:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200312223839.6236-1-luiz.dentz@gmail.com>
In-Reply-To: <20200312223839.6236-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 16 Mar 2020 13:52:20 -0700
Message-ID: <CABBYNZL7ZxrmpKPXEvAGLXiSoJ=PjUWLWarKMdO6=o4C1TORHw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] input: hog: Attempt to set security level if not bonded
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Thu, Mar 12, 2020 at 3:38 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This attempts to set the security if the device is not bonded, the
> kernel will block any communication on the ATT socket while bumping
> the security and if that fails the device will be disconnected which
> is better than having the device dangling around without being able to
> communicate with it until it is properly bonded.
> ---
>  profiles/input/hog.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/profiles/input/hog.c b/profiles/input/hog.c
> index dfac68921..f0226ebbd 100644
> --- a/profiles/input/hog.c
> +++ b/profiles/input/hog.c
> @@ -49,6 +49,8 @@
>  #include "src/shared/util.h"
>  #include "src/shared/uhid.h"
>  #include "src/shared/queue.h"
> +#include "src/shared/att.h"
> +#include "src/shared/gatt-client.h"
>  #include "src/plugin.h"
>
>  #include "suspend.h"
> @@ -187,8 +189,15 @@ static int hog_accept(struct btd_service *service)
>         }
>
>         /* HOGP 1.0 Section 6.1 requires bonding */
> -       if (!device_is_bonded(device, btd_device_get_bdaddr_type(device)))
> -               return -ECONNREFUSED;
> +       if (!device_is_bonded(device, btd_device_get_bdaddr_type(device))) {
> +               struct bt_gatt_client *client;
> +
> +               client = btd_device_get_gatt_client(device);
> +               if (!bt_gatt_client_set_security(client,
> +                                               BT_ATT_SECURITY_MEDIUM)) {
> +                       return -ECONNREFUSED;
> +               }
> +       }
>
>         /* TODO: Replace GAttrib with bt_gatt_client */
>         bt_hog_attach(dev->hog, attrib);
> --
> 2.21.1

Applied.

-- 
Luiz Augusto von Dentz
