Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22C6C3F6B0
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Aug 2022 08:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiHAIN0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Aug 2022 04:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbiHAINZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Aug 2022 04:13:25 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55362B602
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Aug 2022 01:13:22 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id k3so10429238vsr.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Aug 2022 01:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P3Zv79Cs51isXrSdJsVm0i4Wa9LD12edge7RWxx7y3o=;
        b=dmqEzlOZ1X3YsuP2nwYbn+cD+s24NBSeT7TsDEkS1uorO87puy7L9Cvgoucf7L8WDs
         bUX1UYXP2+fi/dldoeY95oUgSmqErFNBTb6vEhO5V0ei9Q/0qH+hqJVVF+YPqYv8cOaV
         hcay9seG+ZC5DCr1aULZGcovFoskHIrBbmRgcyyfi1+V3xyVAvRmiKactcnylrDNGpYS
         nf1b3JLqGTWcLwQMQVsUJw6DC2Zg2PMKYXFhjcLzIA9RBq4sV5UsGn3z3KyVC2GOAzfX
         dINFBcBK65WaQkJ+5CoHy+H2eJkCrPpS8jGhhoJM4CRMdtgp4wQPxpUs1JPqnFo2ZqxU
         CjGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P3Zv79Cs51isXrSdJsVm0i4Wa9LD12edge7RWxx7y3o=;
        b=qDyrU/yucfz3HLf6H7RJzVt2z4xWokxrwMyfDUjpx7xv0yTtbQGrtsoQjkRfkakhEA
         6P3Qk8ok15Zze68KyyBQi1v2lwwSvqan8Xy1wYCslFeuhhlD4AqlHae/wyIsWs1oAVzR
         Ir0mlEoDH+LB6GyDzNR/ZZO79pu8PK5BKqtxBpVs22rUmKyUpJWUvuavAPoV+Q7V4bpZ
         R6MJPM6qN5+Qjj3+QX6tktyZViMwrQblJMSyOuyKRKClkRSEYgpOBqWBQ9cYJDWTg9rZ
         J4TTKFULFImvYCU+8S1EbzdPr+pF7dO7rHEJzOiuLo+ut2rQ8RFEDavHM7n8SZQFj3Si
         jhZw==
X-Gm-Message-State: ACgBeo0p+NqnwdWjgDevrrdQ31VfCNnyXxAUCyztY8IA95Gci/V7fzYg
        DvSl5O3tfVs1O4JkgmHvAspx1bcMpjQU1Gwz1vjKnQ==
X-Google-Smtp-Source: AA6agR52sPn0O7rKsqSW4B1dL7cPYFngDmDT5Bc/jLGziLt9uaz9T4vam1lKXUObeAjdqtnFcMZwzzuzl4e9YsN68zI=
X-Received: by 2002:a67:c19c:0:b0:386:3a4b:dd5 with SMTP id
 h28-20020a67c19c000000b003863a4b0dd5mr632376vsj.53.1659341601797; Mon, 01 Aug
 2022 01:13:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220801042918.292541-1-shraash@google.com>
In-Reply-To: <20220801042918.292541-1-shraash@google.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Mon, 1 Aug 2022 01:13:09 -0700
Message-ID: <CABXOdTfCxZ=r+iH0bwN3Rb6x-RgXHvCMeieeyQv_bwEAFF=tbQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Replace IS_ERR_OR_NULL with IS_ERR
To:     Aashish Sharma <shraash@google.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Guenter Roeck <groeck@chromium.org>,
        Martin Faltesek <mfaltesek@google.com>,
        Linux Bluetooth <linux-bluetooth@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Sun, Jul 31, 2022 at 9:29 PM Aashish Sharma <shraash@google.com> wrote:
>
> Since bt_skb_sendmsg never returns NULL, replace IS_ERR_OR_NULL
> with IS_ERR.
>
> Signed-off-by: Aashish Sharma <shraash@google.com>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>  include/net/bluetooth/bluetooth.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> index 6b48d9e2aab9..a8b52175af05 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -494,7 +494,7 @@ static inline struct sk_buff *bt_skb_sendmmsg(struct sock *sk,
>         struct sk_buff *skb, **frag;
>
>         skb = bt_skb_sendmsg(sk, msg, len, mtu, headroom, tailroom);
> -       if (IS_ERR_OR_NULL(skb))
> +       if (IS_ERR(skb))
>                 return skb;
>
>         len -= skb->len;
> --
> 2.37.1.455.g008518b4e5-goog
>
