Return-Path: <SRS0=YdAw=6E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D50C54FCC
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Apr 2020 22:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B879D205C9
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Apr 2020 22:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHKsaudD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbgDTWi4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Apr 2020 18:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgDTWi4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Apr 2020 18:38:56 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0006C061A0C
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2020 15:38:55 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id b13so9636825oti.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2020 15:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=04q0PmHXOuzQxjLLYpnWrSrywgKTNWy6DTSnBtlY6SQ=;
        b=GHKsaudD8rhUwxEpzXc0c0HUcypwKLMmUwnK0FVxIBz0k2UvFUVFw03amtnyPU2OBX
         2H+oMXIMHa5Q5dui0T+6n2QLTFnonC/93XkIaFWN7KRRQXq6yTZafActb2QzFZqtQJZM
         4NzqYp2gzDgCLWvMt0al0zRLPAyKp+wzI86lYtRopJNS7LZc5lTkKeLRu4rmHWCt6xJs
         J06XgQct4eqfZP7LL7cQLu0DJeARaR2PQH759R7Pn0AQE35+WawgLtV8qJUsGgb1BjMX
         rPuXbU4i4iIJU+fP/mLCAN/uBTMVDPhtdI7DKAvp5p2Jt3d/2l+ajU/3wDjVDHwqhj1A
         YZhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=04q0PmHXOuzQxjLLYpnWrSrywgKTNWy6DTSnBtlY6SQ=;
        b=A72CImX6taViysLSV8CH+8ZXJxIq/6INjSix7kiHbTbklor+gQnQWwZkOThcCa9nja
         D3AzC4r96vVJuuEQRJAsJ3Rzz0xBmUjQtFGi6jabiad9UJN1JYPdiHDAp1ZNA0pzqNx4
         WLZ3tKypQUfBcQHgPAKy8V7CGtpIl093Nu6lXp17PqyuYpfJJ/Ov//DIJtBsZevvrcNJ
         PMclYsl/u7oBeisWcgdejq64csnR2YiX1oWQFdIrlSOOeXNYw3pbaPuW9Q+FyReIyvRO
         C0Yc1AVShCcTorJuY7MjOF+Lpascb0vjQ+PE8td+VTuwNHbsdLh4MD4cnD9S6xZh779c
         dbJg==
X-Gm-Message-State: AGi0PuZHgP0xqlkftEqmEzTmWbKjnnFX/d91KvfpgLUsjtv9K8xv74+S
        QYcdZgAq14Zs06WBjmR8rsH/s331lI3yLENE/uZyqFSn
X-Google-Smtp-Source: APiQypLfMoL/BdO0QO5SO8vvuk/29uv3OKq61rIb6VXwxghKNUxoCzOpJDjSIzASPlcsCQN0A6Ey0n42SlkP+HbDkAs=
X-Received: by 2002:a9d:644:: with SMTP id 62mr10091278otn.177.1587422335105;
 Mon, 20 Apr 2020 15:38:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200419211058.31987-1-pali@kernel.org>
In-Reply-To: <20200419211058.31987-1-pali@kernel.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 20 Apr 2020 15:38:43 -0700
Message-ID: <CABBYNZLO+o1XiY7bo0epOt-hOQ+SSFKBiCjcKv4e+xkTfBYWGw@mail.gmail.com>
Subject: Re: [PATCH] profile: Fix reporting error message when connection failed
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On Sun, Apr 19, 2020 at 2:14 PM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> Some bluetooth headsets do not support connecting more then one bluetooth
> profile (e.g. in parallel A2DP and HSP, or HSP and HFP) and issuing
> connect() syscall for second profile returns just ECONNREFUSED.
>
> Prior this patch bluetooth daemon for such situation reported following
> message to log:
>
>   Unable to get connect data for Headset Voice gateway: getpeername: Tran=
sport endpoint is not connected (107)
>
> Message is incorrect as connect() syscall failed, not getpeername(). This
> patch fixes this problem and logs correct error message:
>
>   Headset Voice gateway failed connect to XX:XX:XX:XX:XX:XX: Connection r=
efused (111)
>
> Main problem was in ext_connect() function which called bt_io_get() for
> retrieving remote address (BT_IO_OPT_DEST) and if it failed then original
> error from connect() syscall was masked. Because it is not possible to
> retrieve BT_IO_OPT_DEST for unconnected socket, original destination
> address for error message is propagated via connect_add() function in bti=
o.
>
> --
>
> Having correct error message in logs is important. Due to this mangled
> error message I was not able to easily debug why particular bluetooth
> headset sometimes connection with nonsense error that Transport endpoint
> was not connected.

Looks good, but lets have the btio changes as a separate patch.

> ---
>  btio/btio.c   | 19 ++++++++++++++-----
>  src/profile.c |  5 +++--
>  2 files changed, 17 insertions(+), 7 deletions(-)
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
> diff --git a/src/profile.c b/src/profile.c
> index c2992e795..6961a107b 100644
> --- a/src/profile.c
> +++ b/src/profile.c
> @@ -1085,12 +1085,13 @@ static void ext_connect(GIOChannel *io, GError *e=
rr, gpointer user_data)
>         if (!bt_io_get(io, &io_err,
>                                 BT_IO_OPT_DEST, addr,
>                                 BT_IO_OPT_INVALID)) {
> -               error("Unable to get connect data for %s: %s", ext->name,
> -                                                       io_err->message);
>                 if (err) {
> +                       error("%s failed %s", ext->name, err->message);
>                         g_error_free(io_err);
>                         io_err =3D NULL;
>                 } else {
> +                       error("Unable to get connect data for %s: %s",
> +                               ext->name, io_err->message);
>                         err =3D io_err;
>                 }
>                 goto drop;
> --
> 2.20.1
>


--=20
Luiz Augusto von Dentz
