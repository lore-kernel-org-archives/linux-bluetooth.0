Return-Path: <SRS0=vsJv=6G=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 327BDC54FCB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Apr 2020 17:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11CAF2082E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Apr 2020 17:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y20dGsFn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgDVR5h (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Apr 2020 13:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726082AbgDVR5h (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Apr 2020 13:57:37 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CF2C03C1A9
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2020 10:57:37 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id i27so2967960ota.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2020 10:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1P3n5yzGLrN3RyW11F6K5L4EtpM5nuprDnpIk2a/LhU=;
        b=Y20dGsFnM0sOeIFb4B1recOjndDqObZu/vsAS6Xm8lVhw1m8+lfD3xX+GSdzFwlsp1
         llBGbw+yXALWluXrzus5b21Bjybg2F15pKUv20l3pre2U1sZE+pYpIKr4gIOeEWkuWjg
         khcNsUx4dRKq72nxOtbtnKQTXyFyMKdxc1FuVoo1UDPMicG5KPYipkb1kWRv8V1KAqp9
         gdK1jQf5D5oEcnyzmpnfzx9p52Z9ZARAmqU/urByCLSTa+GUulOLgPb0bb3kEzWsnqrw
         SkLKYYiIMRQ9tdx2Z41jQWE3WDxpX8lgldeCzBfc1Yj5RvkvofCYcujceVTC7U6r1ECp
         cblQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1P3n5yzGLrN3RyW11F6K5L4EtpM5nuprDnpIk2a/LhU=;
        b=S6tSnfQGqcuNH27wPdvJSRZc3f0pVtlVHuMQ5BAQdSQco2o/ItSdy/dt0sK01NfLh+
         RoIsAexvRK6lC16JpcvJ9S1sC/ujefLtD8DE2By1Ab4baFOzSuDwHxX7dYzP10/kOmEQ
         daAU2tIOS1T1NAnzi0W5vT6bIJcHoNIr+UpeJwp4URVtJNItgMk3ToY7geI1vr/gPgaI
         sm2n6uvBkZ4Nd6LC2v0Z0Rp2e5+N2ttRBesxSGWNQqG4wjR0Yu6iS/70IOur4o+9hPul
         9DHUzvKMYYbMJBpuF3VcQmZMn+YR5UvyXxJ7r9K5eYlEr4K1k2mVE76MhN+F4mRAoo4N
         ZN8g==
X-Gm-Message-State: AGi0Pub2pQtY25Agzdqf5EOhGmqpQ3tfpENRvaF4zLd+R3+sJM9Zswx2
        npPiM2X2nYnob9W5gCTTrjhatYzyWjfnURTlJU0=
X-Google-Smtp-Source: APiQypKAXnnrmP3ixMp4JwtiOjINqFJx5hTJEq+VSFJOMZQmWBMLiwqmxRspuXx3otopd9cNdo4r1PnfQA+tJ6ZZ/cI=
X-Received: by 2002:a9d:7a98:: with SMTP id l24mr211173otn.79.1587578256574;
 Wed, 22 Apr 2020 10:57:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200422170105.29685-1-pali@kernel.org>
In-Reply-To: <20200422170105.29685-1-pali@kernel.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 22 Apr 2020 10:57:24 -0700
Message-ID: <CABBYNZJg4SzHygkb0WtutA9pK0BSszOO1NCxW1in9wrSr6ugRg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] btio: Show destination address in connect error message
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On Wed, Apr 22, 2020 at 10:06 AM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> When connect() fails it is not possible to retrieve destination address a=
s
> socket is not bound. So put destination address into error message.
> ---
>  btio/btio.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/btio/btio.c b/btio/btio.c
> index e7b4db16b..3ea73faea 100644
> --- a/btio/btio.c
> +++ b/btio/btio.c
> @@ -85,6 +85,7 @@ struct connect {
>         BtIOConnect connect;
>         gpointer user_data;
>         GDestroyNotify destroy;
> +       bdaddr_t dst;
>  };
>
>  struct accept {
> @@ -214,6 +215,7 @@ static gboolean connect_cb(GIOChannel *io, GIOConditi=
on cond,
>         GError *gerr =3D NULL;
>         int err, sk_err, sock;
>         socklen_t len =3D sizeof(sk_err);
> +       char addr[18];
>
>         /* If the user aborted this connect attempt */
>         if ((cond & G_IO_NVAL) || check_nval(io))
> @@ -226,8 +228,11 @@ static gboolean connect_cb(GIOChannel *io, GIOCondit=
ion cond,
>         else
>                 err =3D -sk_err;
>
> -       if (err < 0)
> -               ERROR_FAILED(&gerr, "connect error", -err);
> +       if (err < 0) {
> +               ba2str(&conn->dst, addr);
> +               g_set_error(&gerr, BT_IO_ERROR, err,
> +                       "connect to %s: %s (%d)", addr, strerror(-err), -=
err);
> +       }
>
>         conn->connect(io, gerr, conn->user_data);
>
> @@ -286,7 +291,7 @@ static void server_add(GIOChannel *io, BtIOConnect co=
nnect,
>                                         (GDestroyNotify) server_remove);
>  }
>
> -static void connect_add(GIOChannel *io, BtIOConnect connect,
> +static void connect_add(GIOChannel *io, BtIOConnect connect, bdaddr_t ds=
t,
>                                 gpointer user_data, GDestroyNotify destro=
y)
>  {
>         struct connect *conn;
> @@ -296,6 +301,7 @@ static void connect_add(GIOChannel *io, BtIOConnect c=
onnect,
>         conn->connect =3D connect;
>         conn->user_data =3D user_data;
>         conn->destroy =3D destroy;
> +       conn->dst =3D dst;
>
>         cond =3D G_IO_OUT | G_IO_ERR | G_IO_HUP | G_IO_NVAL;
>         g_io_add_watch_full(io, G_PRIORITY_DEFAULT, cond, connect_cb, con=
n,
> @@ -1671,6 +1677,7 @@ GIOChannel *bt_io_connect(BtIOConnect connect, gpoi=
nter user_data,
>         struct set_opts opts;
>         int err, sock;
>         gboolean ret;
> +       char addr[18];
>
>         va_start(args, opt1);
>         ret =3D parse_set_opts(&opts, gerr, opt1, args);
> @@ -1710,12 +1717,14 @@ GIOChannel *bt_io_connect(BtIOConnect connect, gp=
ointer user_data,
>         }
>
>         if (err < 0) {
> -               ERROR_FAILED(gerr, "connect", -err);
> +               ba2str(&opts.dst, addr);
> +               g_set_error(gerr, BT_IO_ERROR, err,
> +                               "connect to %s: %s (%d)", addr, strerror(=
-err), -err);
>                 g_io_channel_unref(io);
>                 return NULL;
>         }
>
> -       connect_add(io, connect, user_data, destroy);
> +       connect_add(io, connect, opts.dst, user_data, destroy);
>
>         return io;
>  }
> --
> 2.20.1

WARNING:LONG_LINE: line over 80 characters
#67: FILE: btio/btio.c:1722:
+ "connect to %s: %s (%d)", addr, strerror(-err), -err);


--=20
Luiz Augusto von Dentz
