Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77516EB64D8
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Jun 2023 16:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235277AbjFNQyL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Jun 2023 12:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236187AbjFNQyK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Jun 2023 12:54:10 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88232120
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jun 2023 09:54:08 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b1b30445cfso13727921fa.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jun 2023 09:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686761647; x=1689353647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=89SNXLVjRRh/evD99q3dU0l5uK6Zmh2A8ng5JFQSecQ=;
        b=gjIO8CbJpdtXqNAXQ4pt3LkyuEan3/zaZHHTwTUKK5jNGmX0RoFcb1unkFb+oidDFC
         DYDEmXhAaWZa/D2s84iB76FmRK2cvOBeJH322kl5QoRirwFlsCYR6TZGkBuyQuPyQ1No
         XBLwy9PtAjEzLwvS2VbYK2Uonb5gcHYRTLgKUVMaQjMYqQQekQvG4VVinks7/YYeVYvi
         EqDcUSvE43D/6iNbhwJRygVvjCpzxCLKLlE9s4phJjscyw42PS/tQPwWuFvVDpkxotlT
         5WuO+57D++f7q4pgd4N0/xBgfMJwZ9wSUOGxAlhPMgyAD/VIqnVhBlMRCD7O1cGNz1VT
         NWPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686761647; x=1689353647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=89SNXLVjRRh/evD99q3dU0l5uK6Zmh2A8ng5JFQSecQ=;
        b=H+8ynSUPEMpjFM4DOaVB5ZZkK+KUVrMHLJ3dlDu8UMeCTvBWvHUD4qK8cUZorwqkC3
         dhSvkYk8DI2Wp6Gonq0E/a40u3ojg9Xul1ei/bbjPCeU4jIIJ0zu4FGJPhh0+WuAPpMR
         EKgyUl3rhV8F8rTMlpdOuOIwz4UDAveit5PWyNpJaKQG7KRu210pCr0SsBJIgMZLclIZ
         Stannkk7ygTmOMUILudrOhQSetk+8Ijpvez1PGOcEAKVKlxObgB9zpUVUIdVMcFmZaog
         +gvcWVvWQZ4pv8k9hP2CjXUizeGe0uOrUcRP43/4hWXEYuOnm6My3e/xv6aRo5K9lmju
         h6qg==
X-Gm-Message-State: AC+VfDw0Bm56sm21j8x5ygTnCN7s7pO1mpRUqmjiC2Y7zznANrAV5Im1
        +p3RSeHh8X0074p/34hb4qXCYMtJe5HKOFPZPLnPyeADqWJNW2iO
X-Google-Smtp-Source: ACHHUZ7B4SeghtaiVLorNJUPvvFi1IaDANEfeyX7HG+4qoN6ROaZQCEpSdetvb4Hwgzazutf7ooArZ5hphjY6fLsgiY=
X-Received: by 2002:a2e:3c10:0:b0:2b1:fda8:e653 with SMTP id
 j16-20020a2e3c10000000b002b1fda8e653mr6477279lja.27.1686761646851; Wed, 14
 Jun 2023 09:54:06 -0700 (PDT)
MIME-Version: 1.0
References: <6704ebbea9d1bb64e54b45b1b3d6cd321b28971b.camel@infinera.com>
 <CABBYNZ+5ToeenijZkpRSrQ+wyLPjFSD5S7LWwCWXVoT=m-9Y3g@mail.gmail.com> <da4df669a540a395eec5a596a9594bea73be404d.camel@infinera.com>
In-Reply-To: <da4df669a540a395eec5a596a9594bea73be404d.camel@infinera.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 14 Jun 2023 09:53:54 -0700
Message-ID: <CABBYNZKhf0Ve5P+N9zhAuUwU5O-e5JcifcxE-0=o+X_hRdPtyA@mail.gmail.com>
Subject: Re: bluez SEGV in current master
To:     Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Joakim,

On Wed, Jun 14, 2023 at 9:32=E2=80=AFAM Joakim Tjernlund
<Joakim.Tjernlund@infinera.com> wrote:
>
> On Wed, 2023-06-14 at 09:25 -0700, Luiz Augusto von Dentz wrote:
> > Hi Joakim,
> >
> > On Wed, Jun 14, 2023 at 5:36=E2=80=AFAM Joakim Tjernlund
> > <Joakim.Tjernlund@infinera.com> wrote:
> > >
> > > commit bap: Add broadcast source support, 3030883, in bluez.git
> > >
> > > A co-worker see this SEGV when connecting a headset:
> > >
> > > Jun 13 13:38:15 systemd-coredump[3941]: Process 1897 (bluetoothd) of =
user 0 dumped core.
> > >                                         Module bluetoothd without bui=
ld-id.
> > >                                         #0  0x0000556bea93277a a2dp_r=
esume_complete (bluetoothd + 0x3e77a)
> > >                                         #1  0x0000556bea9210a2 finali=
ze_resume (bluetoothd + 0x2d0a2)
> > >                                         #2  0x0000556bea92afaf avdtp_=
start_resp (bluetoothd + 0x36faf)
> > >                                         #6  0x0000556bea9dcc85 mainlo=
op_run (bluetoothd + 0xe8c85)
> > >                                         #7  0x0000556bea9dd0dc mainlo=
op_run_with_signal (bluetoothd + 0xe90dc)
> > >                                         #8  0x0000556bea91a4ef main (=
bluetoothd + 0x264ef)
> > >                                         #11 0x0000556bea91ace1 _start=
 (bluetoothd + 0x26ce1)
> > > Jun 13 13:38:15 systemd[1]: bluetooth.service: Main process exited, c=
ode=3Ddumped, status=3D11/SEGV
> > >
> > >
> > > Crash seems to be at:
> > >
> > > 342     static void a2dp_resume_complete(struct avdtp *session, int e=
rr,
> > > 343                                                             void =
*user_data)
> > > 344     {
> > > 345             struct media_owner *owner =3D user_data;
> > > 346             struct media_request *req =3D owner->pending;
> > > 347             struct media_transport *transport =3D owner->transpor=
t;
> > > 348             struct a2dp_sep *sep =3D media_endpoint_get_sep(trans=
port->endpoint);
> > >
> > > A good start(but does NOT fix the problem) might be:
> > >
> > > --- bluez-9999/profiles/audio/transport.c.org   2023-06-13 18:38:14.5=
42137531 +0200
> > > +++ bluez-9999/profiles/audio/transport.c       2023-06-13 18:48:32.5=
42527882 +0200
> > > @@ -345,7 +345,7 @@
> > >         struct media_owner *owner =3D user_data;
> > >         struct media_request *req =3D owner->pending;
> > >         struct media_transport *transport =3D owner->transport;
> > > -       struct a2dp_sep *sep =3D media_endpoint_get_sep(transport->en=
dpoint);
> > > +       struct a2dp_sep *sep;
> > >         struct avdtp_stream *stream;
> > >         int fd;
> > >         uint16_t imtu, omtu;
> > > @@ -355,7 +355,10 @@
> > >
> > >         if (err)
> > >                 goto fail;
> > > +       if (!transport)
> > > +               goto fail;
> > >
> > > +       sep =3D media_endpoint_get_sep(transport->endpoint);
> > >         stream =3D a2dp_sep_get_stream(sep);
> > >         if (stream =3D=3D NULL)
> > >                 goto fail;
> > >
> > > bluez-5.66 Works fine though.
> > >
> > > Headset: WH-1000XM3
> > >
> > >   Jocke
> >
> > Weird, I don't think much has changed for A2DP, but perhaps there is
> > some BAP related changes affecting A2DP for some reason, any chance to
> > bisect the patch that introduces this problem? Or it is not always
> > reproducible?
>
> It is reproducible but on an remote laptop used for daily work so would d=
isturb quite a lot.
> Can I turn off BAP somehow to see if it is interfering ?
>
> Any chance it is related to https://github.com/bluez/bluez/issues/533 ?

Right, yeah that is possible since it appears to be some unbalanced
reference count issue, that said that was a very old version, not sure
if we haven't fixed that.

>  Jocke



--=20
Luiz Augusto von Dentz
