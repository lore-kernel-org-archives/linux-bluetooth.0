Return-Path: <SRS0=vsJv=6G=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C062C54FCB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Apr 2020 18:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 722012098B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Apr 2020 18:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HK8gcp4r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbgDVSbK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Apr 2020 14:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgDVSbJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Apr 2020 14:31:09 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8D9C03C1A9
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2020 11:31:09 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id g14so732941ooa.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2020 11:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=t32cHKHwAdtaArS3PyntRI2apJ7jkXgW3pqiTZ4LEOY=;
        b=HK8gcp4rZ10WHW3NtYEQdzK7ZZCz5MSe6Qt5VWEP0T1U3d7kxqYalv3l0YozCkoDRh
         RwUsD42FuBlx3IRK3XxiPB6EFQvkDam7QVcIaLJ9PbRYAvB7DNtfVz17yNMs4MULvIrJ
         vbE4SxLCK6BIye8+tFFhyy1ItLS4oPCTZjlX/PK7Wz171J6gom+PvGlL1r2Gocf51niC
         vl5GPqmkIPIvhiTUX2KllrB+06kyzGJYKzw8Dnomez4gy3CMhMUYVjkdYUSUn/Te+nn9
         e4g9jT6hunHQi/vKn+TTv3XbesuB6NoAKwyZya4/4iPJPHreZpjCBlBNOsrr6RHY2HWF
         ljAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=t32cHKHwAdtaArS3PyntRI2apJ7jkXgW3pqiTZ4LEOY=;
        b=s0GgATuRU6QlorO1Vhe/RnS/cgo+NQMzPGyvVjU1feVMrUBk2c9jCCDsLaROCTw3Mc
         CaCzsC21j0d6ew7dnQhdHZpElCyMFF3MJjqLi9RcKdk14hlZmU/P2ng+CR3J7P691zv7
         SLqOuDW3cl/LEahnD1oFIHY3Ugj7BQ1Hig2nSot95PH0y2iWF1VapXdHfPXKEYKegCW0
         JbDbhxGXEgx28dZvXYZ9jXjPuLLhMoq9vTyyEoSbNLuckYMLzYgKzpD3inQdoM2KQnyT
         hKK2/216eqI8Z25lT9TaZ1Pz8QwDNdcKle1aaAuN+2J5BhpyyyvxILEP7KRWu55mqX+1
         wJCA==
X-Gm-Message-State: AGi0PuaF96D+uI6MdJd2ZeRItJAd+OwdbeOPgtT0w+Pbfyfn0r+49ZqR
        RmqVP6+5xXh6gzzgQu789dQ2YQgyWuyUh9gtF2Q=
X-Google-Smtp-Source: APiQypJZPU57UPSB0nZMdQtGQ2KWtBJzx1LbWGKF62DgKGKbZRGcbPpV7FUM4o+mOxSZ47oyxa4/J7n11259X76wCGI=
X-Received: by 2002:a4a:e0d4:: with SMTP id e20mr98932oot.35.1587580268698;
 Wed, 22 Apr 2020 11:31:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200422170105.29685-1-pali@kernel.org> <CABBYNZJg4SzHygkb0WtutA9pK0BSszOO1NCxW1in9wrSr6ugRg@mail.gmail.com>
In-Reply-To: <CABBYNZJg4SzHygkb0WtutA9pK0BSszOO1NCxW1in9wrSr6ugRg@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 22 Apr 2020 11:30:57 -0700
Message-ID: <CABBYNZKCy6q77RiH150_5X2Qr=Pi2cxNrQe5tRBm66vaWSucpg@mail.gmail.com>
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

On Wed, Apr 22, 2020 at 10:57 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Pali,
>
> On Wed, Apr 22, 2020 at 10:06 AM Pali Roh=C3=A1r <pali@kernel.org> wrote:
> >
> > When connect() fails it is not possible to retrieve destination address=
 as
> > socket is not bound. So put destination address into error message.
> > ---
> >  btio/btio.c | 19 ++++++++++++++-----
> >  1 file changed, 14 insertions(+), 5 deletions(-)
> >
> > diff --git a/btio/btio.c b/btio/btio.c
> > index e7b4db16b..3ea73faea 100644
> > --- a/btio/btio.c
> > +++ b/btio/btio.c
> > @@ -85,6 +85,7 @@ struct connect {
> >         BtIOConnect connect;
> >         gpointer user_data;
> >         GDestroyNotify destroy;
> > +       bdaddr_t dst;
> >  };
> >
> >  struct accept {
> > @@ -214,6 +215,7 @@ static gboolean connect_cb(GIOChannel *io, GIOCondi=
tion cond,
> >         GError *gerr =3D NULL;
> >         int err, sk_err, sock;
> >         socklen_t len =3D sizeof(sk_err);
> > +       char addr[18];
> >
> >         /* If the user aborted this connect attempt */
> >         if ((cond & G_IO_NVAL) || check_nval(io))
> > @@ -226,8 +228,11 @@ static gboolean connect_cb(GIOChannel *io, GIOCond=
ition cond,
> >         else
> >                 err =3D -sk_err;
> >
> > -       if (err < 0)
> > -               ERROR_FAILED(&gerr, "connect error", -err);
> > +       if (err < 0) {
> > +               ba2str(&conn->dst, addr);
> > +               g_set_error(&gerr, BT_IO_ERROR, err,
> > +                       "connect to %s: %s (%d)", addr, strerror(-err),=
 -err);
> > +       }
> >
> >         conn->connect(io, gerr, conn->user_data);
> >
> > @@ -286,7 +291,7 @@ static void server_add(GIOChannel *io, BtIOConnect =
connect,
> >                                         (GDestroyNotify) server_remove)=
;
> >  }
> >
> > -static void connect_add(GIOChannel *io, BtIOConnect connect,
> > +static void connect_add(GIOChannel *io, BtIOConnect connect, bdaddr_t =
dst,
> >                                 gpointer user_data, GDestroyNotify dest=
roy)
> >  {
> >         struct connect *conn;
> > @@ -296,6 +301,7 @@ static void connect_add(GIOChannel *io, BtIOConnect=
 connect,
> >         conn->connect =3D connect;
> >         conn->user_data =3D user_data;
> >         conn->destroy =3D destroy;
> > +       conn->dst =3D dst;
> >
> >         cond =3D G_IO_OUT | G_IO_ERR | G_IO_HUP | G_IO_NVAL;
> >         g_io_add_watch_full(io, G_PRIORITY_DEFAULT, cond, connect_cb, c=
onn,
> > @@ -1671,6 +1677,7 @@ GIOChannel *bt_io_connect(BtIOConnect connect, gp=
ointer user_data,
> >         struct set_opts opts;
> >         int err, sock;
> >         gboolean ret;
> > +       char addr[18];
> >
> >         va_start(args, opt1);
> >         ret =3D parse_set_opts(&opts, gerr, opt1, args);
> > @@ -1710,12 +1717,14 @@ GIOChannel *bt_io_connect(BtIOConnect connect, =
gpointer user_data,
> >         }
> >
> >         if (err < 0) {
> > -               ERROR_FAILED(gerr, "connect", -err);
> > +               ba2str(&opts.dst, addr);
> > +               g_set_error(gerr, BT_IO_ERROR, err,
> > +                               "connect to %s: %s (%d)", addr, strerro=
r(-err), -err);
> >                 g_io_channel_unref(io);
> >                 return NULL;
> >         }
> >
> > -       connect_add(io, connect, user_data, destroy);
> > +       connect_add(io, connect, opts.dst, user_data, destroy);
> >
> >         return io;
> >  }
> > --
> > 2.20.1
>
> WARNING:LONG_LINE: line over 80 characters
> #67: FILE: btio/btio.c:1722:
> + "connect to %s: %s (%d)", addr, strerror(-err), -err);

I went ahead and applied.

--=20
Luiz Augusto von Dentz
