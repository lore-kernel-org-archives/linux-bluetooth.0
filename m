Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF288C19F29
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jul 2022 19:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbiG0Tvr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Jul 2022 15:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiG0Tvp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Jul 2022 15:51:45 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC1D56BB8;
        Wed, 27 Jul 2022 12:51:44 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id ss3so33237445ejc.11;
        Wed, 27 Jul 2022 12:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hfdYfW+eLA7FgQQsAh15YN9rCKIS6IXGot7C5LjHDn4=;
        b=BCz9kQjvyZHZawq3s69SRwOJmd1O1vpBZ9ktgivhTgBA8RPSKJOOpqXo2WVkuy58CN
         l6GunFUUUTkt3Yp6XK8pg5IJjSdymnCKlVk5pTaaffC1yn5GwBHqk1zK42bMDl5w3YFi
         26AU4n9nT16W0q2fucH5qmE7+KG/aMChB5OHhgPyXpibjBTZ+12rrNWtI4CAEIidCphh
         Z2gqMBqguN1F202dQ/QZHk6qaYVlgHtRs3VYu1gachSG8hqoYWUKnBo3YC0qClfB5SFL
         wgpDCrhYKKxYi8zbJ8X69DeRnHrz3pfE8uwR+TlD3YdzUoISzAKasbV5cbt/nOJluaWe
         fsuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hfdYfW+eLA7FgQQsAh15YN9rCKIS6IXGot7C5LjHDn4=;
        b=ff1vHWdXz2cig0TIbOfjGr3jiCH+vRO23S/TFdvZIrRtyomYU85ZhPjAzbCU2xQh+I
         tR1WtG0mA6oBZtImaMJCgkmKXQJpBx2d1WOWZGqmKQ/gohUOo+umE+YluYiqUsS1699z
         s8P0P/ox7KobhKrk/O14NrHb+fuuv3zA4rtRpL0rf6jO3rjgAvjgF+j5+PzdJ5SGL9lM
         dxpUq7poaD28qvKx3FoF5lt7kqiZu/8MD8wdpw6N5fBuHGg8kQh1xDDFpnMLCGezPTzV
         dV5qfQhfBbRQqVrPSf57FdqZveFos6i5a1AZ9TLR7/ndudWcZ7tA0PC1UwsWbO3SVriX
         UaKQ==
X-Gm-Message-State: AJIora8xwAK9SzCNo51DdIUAi6+q7n/KKCvvUn7+BTvbI+23qavtljNC
        XZzXVWt6EqufzbvCGH/USwEm/qjOG+WK5Ae3NdKAADbL+dUw0Q==
X-Google-Smtp-Source: AGRyM1sJzG4h98xoiCI9QQECHrkP65HPdlCL1385J1vvnBs9s0XVDa4Iosdl0OTUSZzLrzDbB39TPurjUM6eZ4mmQMo=
X-Received: by 2002:a17:907:a40d:b0:72b:7f56:650 with SMTP id
 sg13-20020a170907a40d00b0072b7f560650mr18592955ejc.132.1658951502443; Wed, 27
 Jul 2022 12:51:42 -0700 (PDT)
MIME-Version: 1.0
References: <YuEq2Aey0VOrxPB+@kili> <YuErMEjse5lgAMO3@kili>
In-Reply-To: <YuErMEjse5lgAMO3@kili>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 27 Jul 2022 12:51:30 -0700
Message-ID: <CABBYNZ+bdU4sVjbQfOHtz5P7X+BkZj2DG6f3hNJzdjx+DSVtGw@mail.gmail.com>
Subject: Re: [PATCH 2/2] Bluetooth: ISO: fix info leak in iso_sock_getsockopt()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Dan,

On Wed, Jul 27, 2022 at 5:10 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> The "qos" struct has holes after the in and out struct members.  Zero
> out those holes to prevent leaking stack information.
>
> The C standard rules for when struct holes are zeroed out are slightly
> weird.  The existing assignments might initialize everything, but GCC
> is allowed to (and does sometimes) leave the struct holes uninitialized.
> However, when you have a struct initializer that doesn't initialize
> every member then the holes must be zeroed.
>
> Fixes: ccf74f2390d6 ("Bluetooth: Add BTPROTO_ISO socket type")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  net/bluetooth/iso.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index 19d003727b50..c982087d3b52 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -1235,7 +1235,7 @@ static int iso_sock_getsockopt(struct socket *sock, int level, int optname,
>  {
>         struct sock *sk = sock->sk;
>         int len, err = 0;
> -       struct bt_iso_qos qos;
> +       struct bt_iso_qos qos = {}; /* zero out struct holes */
>         u8 base_len;
>         u8 *base;
>
> --
> 2.35.1

Interesting, did you get a report from static analyzer or something?
The variable gets assigned in the code below which has the exact same
size thus I don't see how it would leave anything uninitialized:

        if (sk->sk_state == BT_CONNECTED || sk->sk_state == BT_CONNECT2)
            qos = iso_pi(sk)->conn->hcon->iso_qos;
        else
            qos = iso_pi(sk)->qos;

Well perhaps it would have been better to use a pointer though so we
don't have to copy anything:

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index ff09c353e64e..0e4ec46ef273 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1233,7 +1233,7 @@ static int iso_sock_getsockopt(struct socket
*sock, int level, int optname,
 {
        struct sock *sk = sock->sk;
        int len, err = 0;
-       struct bt_iso_qos qos;
+       struct bt_iso_qos *qos;
        u8 base_len;
        u8 *base;

@@ -1259,12 +1259,12 @@ static int iso_sock_getsockopt(struct socket
*sock, int level, int optname,

        case BT_ISO_QOS:
                if (sk->sk_state == BT_CONNECTED || sk->sk_state == BT_CONNECT2)
-                       qos = iso_pi(sk)->conn->hcon->iso_qos;
+                       qos = &iso_pi(sk)->conn->hcon->iso_qos;
                else
-                       qos = iso_pi(sk)->qos;
+                       qos = &iso_pi(sk)->qos;

                len = min_t(unsigned int, len, sizeof(qos));
-               if (copy_to_user(optval, (char *)&qos, len))
+               if (copy_to_user(optval, (char *)qos, len))
                        err = -EFAULT;

                break;

-- 
Luiz Augusto von Dentz
