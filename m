Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA7627603C
	for <linux-bluetooth@vger.kernel.org>; Sun, 12 Apr 2026 12:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775997557; cv=pass; b=bqLg6stH8g5h663kJ26Ko+xTcjFdZrIxfpv6yDoXaaWY3VfjXpJTVIyAM0aDWJRmJeMuYL8606ae6P9FgLeszXSavru4Pj0aDTP4dhgTOhy0HRTHsS/hsq1GBetIb7G0i2Xx/Uzz3Cn5vK3d7ZCmWcfEJr30YDMbgWInIf2GSPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775997557; c=relaxed/simple;
	bh=d7MWkVoSPO3hoO50dPPW9tknvfxebmdx+5G0jHTzdgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bJJiL69PlyZa4r9Enqp2/G5hFfT7EnWmPYLkJDza9Mr6xmMVJwPdA9E3Jry9GNaNuC6FyciBpjhbzE3qsxB0suRFaC6hr3oqCjjbvjSsTPC1/+HqvzSeykf/QykNV3vqaklx5R7WM8FaJTF8vBDTbJjr0XLz1vc2Tr1A7tDcVIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m8X14BUp; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8X14BUp"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a2beae348eso3785153e87.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Apr 2026 05:39:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775997553; cv=none;
        d=google.com; s=arc-20240605;
        b=MFkV+zggKnBOOv++zniA+/qo+eFfdTQhmJ4Zti5Opzh9qYn4PQhrDA0h/BGAcQHy2O
         /OENnXv8UggH7Mts1YXR5dkGHGUeAV5bzVRnIaC73NNK+QfOJqP6KeD9U0l4rWvZ/O+z
         Wou8TKcjB5yFxap2GF5hQhnixIOElXqAr5BgZN7z6TMzlAu2eEiwXUH6p5rh9HKeQang
         1cTshqhvw8yez7voUhL5pPT+bRurK+xKy8i32yh0hljXACOvijgRw90FP5SHRVcpjwOV
         6GlERkuRyNSoxd04zBpMLYlsia+dIeM3hpzdT+Oy/lwiSNyGhGMSBFQqpNeN/os8A6W5
         ilmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Um9n0JoiHoLXYLzl3bBl8igrJjY4hhdUC98iqCXcYFM=;
        fh=++AgVgrUGx9HNhv8gB6bVP0z8LhO+VWYpIZrulwlk6s=;
        b=BoP+dAuGBa81CRZXFG+SmfqAZr9c12lS1xuXW8PTthIrcOgLNFBKRMv2eP7kf5l9Xg
         ZLu3VphufMlH99gEZoxyoPlmkl08akfvA8AlJNc5qek3CKF3oGRi+6qj2GwDJhM99hvE
         7JkNyY/jZvizTv9Co/n31FTQu+t0ZO3mVUG7lcSkZT4HW0EKTVoSI2h/11W5rQbpKEs7
         sN9+dvQ+VEX4+/V8cdDGq81gmdqQZQwALrvXDSKwbLibtWXSC1yFJcqTqhEIJA+X7yH9
         +l9l20LePViamKjWE2nX25STY5LHMeJ/jXHU99iYwiVaB21QghuYXTGKCxhLT7GRCy6Y
         czNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775997553; x=1776602353; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Um9n0JoiHoLXYLzl3bBl8igrJjY4hhdUC98iqCXcYFM=;
        b=m8X14BUpmb65kzItVrpCk9dFvao50oAieeqAtcwTKrZMEpKPIIGYz0RxQ+dQJe8ZQO
         T/O7dEmFBVsLr1/IHk/f3WNVCzd0Z4RibTN19jguO8micijJ3S4Z8cQF8tiDaSojx0Yo
         ZD50ihh/QXsT9A7Gv/n1yVUuOG6HnfT4KfnSTnQLnhV72/l6rDvb3FMbrCk2gNt+4Y5+
         T/nuc6DAUGGnYNkL9SwBaj3qEg/E5WAYDA3wA2fCuPczKKFBih/cEkjGH/4/tBoe3YXB
         FbxD6pnA473r46+XLvTe7xDw67jyUc3v1HPBak7htaE7uaGsz2TraF/4Pmv+ZUOeW+WC
         z9nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775997553; x=1776602353;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Um9n0JoiHoLXYLzl3bBl8igrJjY4hhdUC98iqCXcYFM=;
        b=j5sNBZ9KnbJUlmyArodVZy6sOOhkrvli1HEs9NiIlv3LEbZwIz5PRUvRqVKBqMiCzV
         uM6Chl1WRso55PMBRBvSNVN/tRtYTH+0/9dbgbSdgSgJI+RZ2clIwnpt1rQK5Pw/qo3c
         uLHuFuHYIim+cUpNoKh6BWs52PQOalHZ+XMSWG/E2iILcmuONpsOmSwrcIdxplPwDVzl
         W/piaWZahIwpme9DVPb9y+kbA4bsOuq8G3PBKERLIyltl/dYgSSv/htKWzmHViLCw0OF
         5vI6NgmxsmDnVtpGvEiNecFujjzVby9B9gBtyhBKNK2LA11yUTbQwrUvVEPhUrP3+6A/
         iwog==
X-Gm-Message-State: AOJu0YznIGHSpEcGbyiLPMMuXKWepuNhDhH5GNLVJKw3SStH9DQL/ppn
	r4JF9+k5br3+cumyftwsxs8dNRsTJyH0JkvYRGgM9P8hH9H9b970bZ3AwFCKI8g9kt7uAAbez/k
	f1FeH94aleepepQmBfNaEOuoh1gZ90zk=
X-Gm-Gg: AeBDievC8XXB5J2adFmuSYx0VGe+clnCEdoaAMHNJsgARP56OgHmrNiiZIa+pEg7DbG
	ysBLeKwudj/qKBpcofhm17nqkZ7gws5itGvxhxJW0/gqMYKVoNREIMDIprMXKd3c2UJcn9WTpFt
	UQGSioXFUc+pH417BVONv9QTIvRmRgz9tG4NzgnzYY6VaWTe3CP2om3imhuXaUymvUslcIFARo0
	odmd7FgkeSOWlnwEMk3vJkgEmVcxWRZr+3RXxhwkt11GX5f2gkwlph1J6MujQrCrfIJTXmJd5Av
	onDuFLvDjlBLmSsyH/KFp7zzVEyppWo/Sgsi1dM=
X-Received: by 2002:a05:6512:138e:b0:5a2:b3dd:7a63 with SMTP id
 2adb3069b0e04-5a3efb4160dmr3057848e87.10.1775997553061; Sun, 12 Apr 2026
 05:39:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260412045457.53100-1-suunj1331@gmail.com> <e009a1a1-17df-4845-b72a-ca6442754472@molgen.mpg.de>
In-Reply-To: <e009a1a1-17df-4845-b72a-ca6442754472@molgen.mpg.de>
From: SeungJu Cheon <suunj1331@gmail.com>
Date: Sun, 12 Apr 2026 21:39:01 +0900
X-Gm-Features: AQROBzAGCmYz4QFO_-JZe-X_3NJb8c90wnosd7L3oviXsdg0jZzhKr1pQZjUMho
Message-ID: <CAGwK=3pXYk1eA48G819D+SiyN90+CiP7487uWxjDoMFhnHEM8Q@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: RFCOMM: validate skb length in MCC handlers
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, luiz.dentz@gmail.com, 
	kees@kernel.org, kuba@kernel.org, me@brighamcampbell.com, 
	linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org
Content-Type: multipart/mixed; boundary="00000000000045d5da064f42a7de"

--00000000000045d5da064f42a7de
Content-Type: multipart/alternative; boundary="00000000000045d5d8064f42a7dc"

--00000000000045d5d8064f42a7dc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paul,

Thanks for the review.

> Nice catch. Do you have a reproducer to create such a short MCC frame?

Yes, a PoC is attached. It uses VHCI to inject malformed (short) MCC frames=
.

> Before these handlers are reached, rfcomm_recv_mcc() unconditionally cast=
s
> skb->data to struct rfcomm_mcc * and reads mcc->type and mcc->len.

Good point. I'll add a sizeof(struct rfcomm_mcc) check in rfcomm_recv_mcc()
before accessing these fields in v2.

> if rfcomm_recv_frame() unconditionally trims the FCS with skb->len--;
> could a 0-byte payload cause skb->len to underflow to UINT_MAX?

I'll review rfcomm_recv_frame() and add a minimum length check if needed.

> Does this unconditionally drop legitimate 1-byte RPN requests?

You're right. In v2, I'll update rfcomm_recv_rpn() to first check 1 byte
for DLCI, then validate full struct size only when len > 1.

Thanks,
SeungJu

On Sun, Apr 12, 2026 at 4:38=E2=80=AFPM Paul Menzel <pmenzel@molgen.mpg.de>=
 wrote:

> Dear SeungJu,
>
>
> Thank you for the patch.
>
> Am 12.04.26 um 06:54 schrieb SeungJu Cheon:
> > rfcomm_recv_pn(), rfcomm_recv_rpn(), rfcomm_recv_rls(), and
> > rfcomm_recv_msc() cast skb->data to their respective structs
> > without first checking skb->len. A remote device can send a
> > short MCC frame, causing out-of-bounds reads from the skb buffer.
>
> Nice catch. Do you have a reproducer to create such a short MCC frame?
>
> > For rfcomm_recv_pn(), the uninitialized pn->mtu value is stored
> > in d->mtu via rfcomm_apply_pn(), then echoed back to the remote
> > device in the PN response, leaking kernel heap data.
> >
> > This results in use of uninitialized memory, as reported by KMSAN.
> >
> > Add explicit skb->len checks against the expected structure size
> > at the start of each handler before accessing the payload.
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > BUG: KMSAN: uninit-value in rfcomm_run+0x7eae/0xee90
> >   rfcomm_run+0x7eae/0xee90
> >   kthread+0x53f/0x600
> >   ret_from_fork+0x20f/0x910
> >   ret_from_fork_asm+0x1a/0x30
> >
> > Uninit was created at:
> >   kmem_cache_alloc_node_noprof+0x3cd/0x12d0
> >   __alloc_skb+0x855/0x1190
> >   vhci_write+0x125/0x960
> >   vfs_write+0xbe1/0x15c0
> >   ksys_write+0x1d9/0x470
> >   __x64_sys_write+0x97/0xf0
> >   x64_sys_call+0x2ff0/0x3ea0
> >   do_syscall_64+0x134/0xf80
> >   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > CPU: 0 UID: 0 PID: 3374 Comm: krfcommd Tainted: G        W
>  7.0.0-rc7
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
> > Kernel panic - not syncing: kmsan.panic set ...
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>
> > ---
> >   net/bluetooth/rfcomm/core.c | 40 +++++++++++++++++++++++++++++-------=
-
> >   1 file changed, 32 insertions(+), 8 deletions(-)
> >
> > diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
> > index 611a9a94151e..daeba71a1514 100644
> > --- a/net/bluetooth/rfcomm/core.c
> > +++ b/net/bluetooth/rfcomm/core.c
> > @@ -1431,9 +1431,15 @@ static int rfcomm_apply_pn(struct rfcomm_dlc *d,
> int cr, struct rfcomm_pn *pn)
> >
> >   static int rfcomm_recv_pn(struct rfcomm_session *s, int cr, struct
> sk_buff *skb)
> >   {
> > -     struct rfcomm_pn *pn =3D (void *) skb->data;
> > +     struct rfcomm_pn *pn;
> >       struct rfcomm_dlc *d;
> > -     u8 dlci =3D pn->dlci;
> > +     u8 dlci;
> > +
> > +     if (skb->len < sizeof(*pn))
> > +             return -EINVAL;
> > +
> > +     pn =3D (void *) skb->data;
> > +     dlci =3D pn->dlci;
>
> gemini/gemini-3.1-pro-preview comments [1]. No idea if it=E2=80=99s a val=
id
> comment:
>
> > Before these handlers are reached, rfcomm_recv_mcc() unconditionally
> casts
> > skb->data to struct rfcomm_mcc * and reads mcc->type and mcc->len. Does
> > this leave an out-of-bounds read unpatched if a remote device sends an
> MCC
> > frame with 0 or 1 bytes of payload?
> > Additionally, if rfcomm_recv_frame() unconditionally trims the FCS with
> > skb->len--; skb->tail--;, could a 0-byte payload cause skb->len to
> > underflow to UINT_MAX?
> > Since skb->len is unsigned, this new check (UINT_MAX < 8) would evaluat=
e
> to
> > false, potentially bypassing this protection entirely.
> >
> >       BT_DBG("session %p state %ld dlci %d", s, s->state, dlci);
> >
> > @@ -1483,8 +1489,8 @@ static int rfcomm_recv_pn(struct rfcomm_session
> *s, int cr, struct sk_buff *skb)
> >
> >   static int rfcomm_recv_rpn(struct rfcomm_session *s, int cr, int len,
> struct sk_buff *skb)
> >   {
> > -     struct rfcomm_rpn *rpn =3D (void *) skb->data;
> > -     u8 dlci =3D __get_dlci(rpn->dlci);
> > +     struct rfcomm_rpn *rpn;
> > +     u8 dlci;
> >
> >       u8 bit_rate  =3D 0;
> >       u8 data_bits =3D 0;
> > @@ -1495,6 +1501,12 @@ static int rfcomm_recv_rpn(struct rfcomm_session
> *s, int cr, int len, struct sk_
> >       u8 xoff_char =3D 0;
> >       u16 rpn_mask =3D RFCOMM_RPN_PM_ALL;
> >
> > +     if (skb->len < sizeof(*rpn))
> > +             return -EINVAL;
>
> gemini/gemini-3.1-pro-preview comments [1]:
>
> > Does this unconditionally drop legitimate 1-byte Remote Port Negotiatio=
n
> > (RPN) requests?
> > Looking at the existing code further down in rfcomm_recv_rpn():
> >     if (len =3D=3D 1) {
> >         /* This is a request, return default (according to ETSI TS
> 07.10) settings */
> >         ...
> > Since sizeof(struct rfcomm_rpn) is 8 bytes, enforcing this minimum leng=
th
> > would reject valid 1-byte queries allowed by the ETSI TS 07.10 standard=
.
>
>
> > +
> > +     rpn =3D (void *) skb->data;
> > +     dlci =3D __get_dlci(rpn->dlci);
> > +
> >       BT_DBG("dlci %d cr %d len 0x%x bitr 0x%x line 0x%x flow 0x%x xonc
> 0x%x xoffc 0x%x pm 0x%x",
> >               dlci, cr, len, rpn->bit_rate, rpn->line_settings,
> rpn->flow_ctrl,
> >               rpn->xon_char, rpn->xoff_char, rpn->param_mask);
> > @@ -1589,8 +1601,14 @@ static int rfcomm_recv_rpn(struct rfcomm_session
> *s, int cr, int len, struct sk_
> >
> >   static int rfcomm_recv_rls(struct rfcomm_session *s, int cr, struct
> sk_buff *skb)
> >   {
> > -     struct rfcomm_rls *rls =3D (void *) skb->data;
> > -     u8 dlci =3D __get_dlci(rls->dlci);
> > +     struct rfcomm_rls *rls;
> > +     u8 dlci;
> > +
> > +     if (skb->len < sizeof(*rls))
> > +             return -EINVAL;
> > +
> > +     rls =3D (void *) skb->data;
> > +     dlci =3D __get_dlci(rls->dlci);
> >
> >       BT_DBG("dlci %d cr %d status 0x%x", dlci, cr, rls->status);
> >
> > @@ -1608,9 +1626,15 @@ static int rfcomm_recv_rls(struct rfcomm_session
> *s, int cr, struct sk_buff *skb
> >
> >   static int rfcomm_recv_msc(struct rfcomm_session *s, int cr, struct
> sk_buff *skb)
> >   {
> > -     struct rfcomm_msc *msc =3D (void *) skb->data;
> > +     struct rfcomm_msc *msc;
> >       struct rfcomm_dlc *d;
> > -     u8 dlci =3D __get_dlci(msc->dlci);
> > +     u8 dlci;
> > +
> > +     if (skb->len < sizeof(*msc))
> > +             return -EINVAL;
> > +
> > +     msc =3D (void *) skb->data;
> > +     dlci =3D __get_dlci(msc->dlci);
> >
> >       BT_DBG("dlci %d cr %d v24 0x%x", dlci, cr, msc->v24_sig);
> >
>
>
> Kind regards,
>
> Paul
>
>
> [1]:
> https://sashiko.dev/#/patchset/20260412045457.53100-1-suunj1331%40gmail.c=
om
>

--00000000000045d5d8064f42a7dc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Paul,<br><br>Thanks for the review.<br><br>&gt; Nice ca=
tch. Do you have a reproducer to create such a short MCC frame?<br><br>Yes,=
 a PoC is attached. It uses VHCI to inject malformed (short) MCC frames.<br=
><br>&gt; Before these handlers are reached, rfcomm_recv_mcc() unconditiona=
lly casts<br>&gt; skb-&gt;data to struct rfcomm_mcc * and reads mcc-&gt;typ=
e and mcc-&gt;len.<br><br>Good point. I&#39;ll add a sizeof(struct rfcomm_m=
cc) check in rfcomm_recv_mcc()<br>before accessing these fields in v2.<br><=
br>&gt; if rfcomm_recv_frame() unconditionally trims the FCS with skb-&gt;l=
en--;<br>&gt; could a 0-byte payload cause skb-&gt;len to underflow to UINT=
_MAX?<br><br>I&#39;ll review rfcomm_recv_frame() and add a minimum length c=
heck if needed.<br><br>&gt; Does this unconditionally drop legitimate 1-byt=
e RPN requests?<br><br>You&#39;re right. In v2, I&#39;ll update rfcomm_recv=
_rpn() to first check 1 byte<br>for DLCI, then validate full struct size on=
ly when len &gt; 1.<br><br>Thanks,<br>SeungJu</div><br><div class=3D"gmail_=
quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, =
Apr 12, 2026 at 4:38=E2=80=AFPM Paul Menzel &lt;<a href=3D"mailto:pmenzel@m=
olgen.mpg.de">pmenzel@molgen.mpg.de</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">Dear SeungJu,<br>
<br>
<br>
Thank you for the patch.<br>
<br>
Am 12.04.26 um 06:54 schrieb SeungJu Cheon:<br>
&gt; rfcomm_recv_pn(), rfcomm_recv_rpn(), rfcomm_recv_rls(), and<br>
&gt; rfcomm_recv_msc() cast skb-&gt;data to their respective structs<br>
&gt; without first checking skb-&gt;len. A remote device can send a<br>
&gt; short MCC frame, causing out-of-bounds reads from the skb buffer.<br>
<br>
Nice catch. Do you have a reproducer to create such a short MCC frame?<br>
<br>
&gt; For rfcomm_recv_pn(), the uninitialized pn-&gt;mtu value is stored<br>
&gt; in d-&gt;mtu via rfcomm_apply_pn(), then echoed back to the remote<br>
&gt; device in the PN response, leaking kernel heap data.<br>
&gt; <br>
&gt; This results in use of uninitialized memory, as reported by KMSAN.<br>
&gt; <br>
&gt; Add explicit skb-&gt;len checks against the expected structure size<br=
>
&gt; at the start of each handler before accessing the payload.<br>
&gt; <br>
&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D<br>
&gt; BUG: KMSAN: uninit-value in rfcomm_run+0x7eae/0xee90<br>
&gt;=C2=A0 =C2=A0rfcomm_run+0x7eae/0xee90<br>
&gt;=C2=A0 =C2=A0kthread+0x53f/0x600<br>
&gt;=C2=A0 =C2=A0ret_from_fork+0x20f/0x910<br>
&gt;=C2=A0 =C2=A0ret_from_fork_asm+0x1a/0x30<br>
&gt; <br>
&gt; Uninit was created at:<br>
&gt;=C2=A0 =C2=A0kmem_cache_alloc_node_noprof+0x3cd/0x12d0<br>
&gt;=C2=A0 =C2=A0__alloc_skb+0x855/0x1190<br>
&gt;=C2=A0 =C2=A0vhci_write+0x125/0x960<br>
&gt;=C2=A0 =C2=A0vfs_write+0xbe1/0x15c0<br>
&gt;=C2=A0 =C2=A0ksys_write+0x1d9/0x470<br>
&gt;=C2=A0 =C2=A0__x64_sys_write+0x97/0xf0<br>
&gt;=C2=A0 =C2=A0x64_sys_call+0x2ff0/0x3ea0<br>
&gt;=C2=A0 =C2=A0do_syscall_64+0x134/0xf80<br>
&gt;=C2=A0 =C2=A0entry_SYSCALL_64_after_hwframe+0x77/0x7f<br>
&gt; <br>
&gt; CPU: 0 UID: 0 PID: 3374 Comm: krfcommd Tainted: G=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 W=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A07.0.0-rc7<br>
&gt; Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)<br>
&gt; Kernel panic - not syncing: kmsan.panic set ...<br>
&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D<br>
&gt; <br>
&gt; Fixes: 1da177e4c3f4 (&quot;Linux-2.6.12-rc2&quot;)<br>
&gt; Signed-off-by: SeungJu Cheon &lt;<a href=3D"mailto:suunj1331@gmail.com=
" target=3D"_blank">suunj1331@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0net/bluetooth/rfcomm/core.c | 40 +++++++++++++++++++++++++=
++++--------<br>
&gt;=C2=A0 =C2=A01 file changed, 32 insertions(+), 8 deletions(-)<br>
&gt; <br>
&gt; diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c=
<br>
&gt; index 611a9a94151e..daeba71a1514 100644<br>
&gt; --- a/net/bluetooth/rfcomm/core.c<br>
&gt; +++ b/net/bluetooth/rfcomm/core.c<br>
&gt; @@ -1431,9 +1431,15 @@ static int rfcomm_apply_pn(struct rfcomm_dlc *d=
, int cr, struct rfcomm_pn *pn)<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static int rfcomm_recv_pn(struct rfcomm_session *s, int cr=
, struct sk_buff *skb)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; -=C2=A0 =C2=A0 =C2=A0struct rfcomm_pn *pn =3D (void *) skb-&gt;data;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0struct rfcomm_pn *pn;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct rfcomm_dlc *d;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0u8 dlci =3D pn-&gt;dlci;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u8 dlci;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (skb-&gt;len &lt; sizeof(*pn))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pn =3D (void *) skb-&gt;data;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0dlci =3D pn-&gt;dlci;<br>
<br>
gemini/gemini-3.1-pro-preview comments [1]. No idea if it=E2=80=99s a valid=
 comment:<br>
<br>
&gt; Before these handlers are reached, rfcomm_recv_mcc() unconditionally c=
asts<br>
&gt; skb-&gt;data to struct rfcomm_mcc * and reads mcc-&gt;type and mcc-&gt=
;len. Does<br>
&gt; this leave an out-of-bounds read unpatched if a remote device sends an=
 MCC<br>
&gt; frame with 0 or 1 bytes of payload?<br>
&gt; Additionally, if rfcomm_recv_frame() unconditionally trims the FCS wit=
h<br>
&gt; skb-&gt;len--; skb-&gt;tail--;, could a 0-byte payload cause skb-&gt;l=
en to<br>
&gt; underflow to UINT_MAX?<br>
&gt; Since skb-&gt;len is unsigned, this new check (UINT_MAX &lt; 8) would =
evaluate to<br>
&gt; false, potentially bypassing this protection entirely.<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0BT_DBG(&quot;session %p state %ld dlci %d&qu=
ot;, s, s-&gt;state, dlci);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -1483,8 +1489,8 @@ static int rfcomm_recv_pn(struct rfcomm_session =
*s, int cr, struct sk_buff *skb)<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static int rfcomm_recv_rpn(struct rfcomm_session *s, int c=
r, int len, struct sk_buff *skb)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; -=C2=A0 =C2=A0 =C2=A0struct rfcomm_rpn *rpn =3D (void *) skb-&gt;data;=
<br>
&gt; -=C2=A0 =C2=A0 =C2=A0u8 dlci =3D __get_dlci(rpn-&gt;dlci);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct rfcomm_rpn *rpn;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u8 dlci;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0u8 bit_rate=C2=A0 =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0u8 data_bits =3D 0;<br>
&gt; @@ -1495,6 +1501,12 @@ static int rfcomm_recv_rpn(struct rfcomm_sessio=
n *s, int cr, int len, struct sk_<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0u8 xoff_char =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0u16 rpn_mask =3D RFCOMM_RPN_PM_ALL;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (skb-&gt;len &lt; sizeof(*rpn))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
<br>
gemini/gemini-3.1-pro-preview comments [1]:<br>
<br>
&gt; Does this unconditionally drop legitimate 1-byte Remote Port Negotiati=
on<br>
&gt; (RPN) requests?<br>
&gt; Looking at the existing code further down in rfcomm_recv_rpn():<br>
&gt;=C2=A0 =C2=A0 =C2=A0if (len =3D=3D 1) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* This is a request, return default =
(according to ETSI TS 07.10) settings */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0...<br>
&gt; Since sizeof(struct rfcomm_rpn) is 8 bytes, enforcing this minimum len=
gth<br>
&gt; would reject valid 1-byte queries allowed by the ETSI TS 07.10 standar=
d.<br>
<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0rpn =3D (void *) skb-&gt;data;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0dlci =3D __get_dlci(rpn-&gt;dlci);<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0BT_DBG(&quot;dlci %d cr %d len 0x%x bitr 0x%=
x line 0x%x flow 0x%x xonc 0x%x xoffc 0x%x pm 0x%x&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dlci, cr, len, r=
pn-&gt;bit_rate, rpn-&gt;line_settings, rpn-&gt;flow_ctrl,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rpn-&gt;xon_char=
, rpn-&gt;xoff_char, rpn-&gt;param_mask);<br>
&gt; @@ -1589,8 +1601,14 @@ static int rfcomm_recv_rpn(struct rfcomm_sessio=
n *s, int cr, int len, struct sk_<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static int rfcomm_recv_rls(struct rfcomm_session *s, int c=
r, struct sk_buff *skb)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; -=C2=A0 =C2=A0 =C2=A0struct rfcomm_rls *rls =3D (void *) skb-&gt;data;=
<br>
&gt; -=C2=A0 =C2=A0 =C2=A0u8 dlci =3D __get_dlci(rls-&gt;dlci);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct rfcomm_rls *rls;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u8 dlci;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (skb-&gt;len &lt; sizeof(*rls))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0rls =3D (void *) skb-&gt;data;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0dlci =3D __get_dlci(rls-&gt;dlci);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0BT_DBG(&quot;dlci %d cr %d status 0x%x&quot;=
, dlci, cr, rls-&gt;status);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -1608,9 +1626,15 @@ static int rfcomm_recv_rls(struct rfcomm_sessio=
n *s, int cr, struct sk_buff *skb<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static int rfcomm_recv_msc(struct rfcomm_session *s, int c=
r, struct sk_buff *skb)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; -=C2=A0 =C2=A0 =C2=A0struct rfcomm_msc *msc =3D (void *) skb-&gt;data;=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct rfcomm_msc *msc;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct rfcomm_dlc *d;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0u8 dlci =3D __get_dlci(msc-&gt;dlci);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u8 dlci;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (skb-&gt;len &lt; sizeof(*msc))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0msc =3D (void *) skb-&gt;data;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0dlci =3D __get_dlci(msc-&gt;dlci);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0BT_DBG(&quot;dlci %d cr %d v24 0x%x&quot;, d=
lci, cr, msc-&gt;v24_sig);<br>
&gt;=C2=A0 =C2=A0<br>
<br>
<br>
Kind regards,<br>
<br>
Paul<br>
<br>
<br>
[1]: <br>
<a href=3D"https://sashiko.dev/#/patchset/20260412045457.53100-1-suunj1331%=
40gmail.com" rel=3D"noreferrer" target=3D"_blank">https://sashiko.dev/#/pat=
chset/20260412045457.53100-1-suunj1331%40gmail.com</a><br>
</blockquote></div>

--00000000000045d5d8064f42a7dc--
--00000000000045d5da064f42a7de
Content-Type: text/plain; charset="US-ASCII"; name="dmesg.txt"
Content-Disposition: attachment; filename="dmesg.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mnvr0yy81>
X-Attachment-Id: f_mnvr0yy81

WyAgNDQxLjM3NDc2OF1bIFQzMzc1XSA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PQpbICA0NDEuMzc1MTQwXVsgVDMzNzVdIEJVRzogS01TQU46IHVu
aW5pdC12YWx1ZSBpbiByZmNvbW1fcnVuKzB4N2VhZS8weGVlOTAKWyAgNDQxLjM3NTQyMl1bIFQz
Mzc1XSAgcmZjb21tX3J1bisweDdlYWUvMHhlZTkwClsgIDQ0MS4zNzU2MjBdWyBUMzM3NV0gIGt0
aHJlYWQrMHg1M2YvMHg2MDAKWyAgNDQxLjM3NTgwMV1bIFQzMzc1XSAgcmV0X2Zyb21fZm9yaysw
eDIwZi8weDkxMApbICA0NDEuMzc1OTk4XVsgVDMzNzVdICByZXRfZnJvbV9mb3JrX2FzbSsweDFh
LzB4MzAKWyAgNDQxLjM3NjIxM11bIFQzMzc1XSAKWyAgNDQxLjM3NjMxNF1bIFQzMzc1XSBVbmlu
aXQgd2FzIGNyZWF0ZWQgYXQ6ClsgIDQ0MS4zNzY1MjBdWyBUMzM3NV0gIGttZW1fY2FjaGVfYWxs
b2Nfbm9kZV9ub3Byb2YrMHgzY2QvMHgxMmQwClsgIDQ0MS4zNzY3NzFdWyBUMzM3NV0gIF9fYWxs
b2Nfc2tiKzB4ODU1LzB4MTE5MApbICA0NDEuMzc2OTY4XVsgVDMzNzVdICB2aGNpX3dyaXRlKzB4
MTI1LzB4OTYwClsgIDQ0MS4zNzcxNjVdWyBUMzM3NV0gIHZmc193cml0ZSsweGJlMS8weDE1YzAK
WyAgNDQxLjM3NzM1M11bIFQzMzc1XSAga3N5c193cml0ZSsweDFkOS8weDQ3MApbICA0NDEuMzc3
NTQxXVsgVDMzNzVdICBfX3g2NF9zeXNfd3JpdGUrMHg5Ny8weGYwClsgIDQ0MS4zNzc3NDJdWyBU
MzM3NV0gIHg2NF9zeXNfY2FsbCsweDJmZjAvMHgzZWEwClsgIDQ0MS4zNzc5NDVdWyBUMzM3NV0g
IGRvX3N5c2NhbGxfNjQrMHgxMzQvMHhmODAKWyAgNDQxLjM3ODE1Ml1bIFQzMzc1XSAgZW50cnlf
U1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lKzB4NzcvMHg3ZgpbICA0NDEuMzc4Mzk2XVsgVDMzNzVd
IApbICA0NDEuMzc4NTAzXVsgVDMzNzVdIENQVTogMSBVSUQ6IDAgUElEOiAzMzc1IENvbW06IGty
ZmNvbW1kIFRhaW50ZWQ6IEcgICAgICAgIFcgICAgICAgICAgIDcuMC4wLXJjNy0wMDIyNy1nOWE5
YzhjZTMwMGNkICM1IFBSRUVNUFQoZnVsbCkgClsgIDQ0MS4zNzg5ODRdWyBUMzM3NV0gVGFpbnRl
ZDogW1ddPVdBUk4KWyAgNDQxLjM3OTE0M11bIFQzMzc1XSBIYXJkd2FyZSBuYW1lOiBRRU1VIFN0
YW5kYXJkIFBDIChpNDQwRlggKyBQSUlYLCAxOTk2KSwgQklPUyAxLjE3LjAtOS5mYzQzIDA2LzEw
LzIwMjUKWyAgNDQxLjM3OTUxM11bIFQzMzc1XSA9PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PQpbICA0NDEuMzc5NzgyXVsgVDMzNzVdIERpc2FibGlu
ZyBsb2NrIGRlYnVnZ2luZyBkdWUgdG8ga2VybmVsIHRhaW50ClsgIDQ0MS4zODAwMjJdWyBUMzM3
NV0gS2VybmVsIHBhbmljIC0gbm90IHN5bmNpbmc6IGttc2FuLnBhbmljIHNldCAuLi4KWyAgNDQx
LjM4MDI4Ml1bIFQzMzc1XSBDUFU6IDEgVUlEOiAwIFBJRDogMzM3NSBDb21tOiBrcmZjb21tZCBU
YWludGVkOiBHICAgIEIgICBXICAgICAgICAgICA3LjAuMC1yYzctMDAyMjctZzlhOWM4Y2UzMDBj
ZCAjNSBQUkVFTVBUKGZ1bGwpIApbICA0NDEuMzgwNzYzXVsgVDMzNzVdIFRhaW50ZWQ6IFtCXT1C
QURfUEFHRSwgW1ddPVdBUk4KWyAgNDQxLjM4MDk2OV1bIFQzMzc1XSBIYXJkd2FyZSBuYW1lOiBR
RU1VIFN0YW5kYXJkIFBDIChpNDQwRlggKyBQSUlYLCAxOTk2KSwgQklPUyAxLjE3LjAtOS5mYzQz
IDA2LzEwLzIwMjUKWyAgNDQxLjM4MTMzOV1bIFQzMzc1XSBDYWxsIFRyYWNlOgpbICA0NDEuMzgx
NDc3XVsgVDMzNzVdICA8VEFTSz4KWyAgNDQxLjM4MTYwMl1bIFQzMzc1XSAgX19kdW1wX3N0YWNr
KzB4MjYvMHgzMApbICA0NDEuMzgxNzk2XVsgVDMzNzVdICBkdW1wX3N0YWNrX2x2bCsweDUwLzB4
MWMwClsgIDQ0MS4zODIwMDBdWyBUMzM3NV0gID8gZHVtcF9zdGFjaysweDEyLzB4MjUKWyAgNDQx
LjM4MjE5NV1bIFQzMzc1XSAgZHVtcF9zdGFjaysweDFlLzB4MjUKWyAgNDQxLjM4MjM4Ml1bIFQz
Mzc1XSAgdnBhbmljKzB4N2I0LzB4MTQzMApbICA0NDEuMzgyNTczXVsgVDMzNzVdICBwYW5pYysw
eDE1ZC8weDE2MApbICA0NDEuMzgyNzY1XVsgVDMzNzVdICA/IF9fbXNhbl9tZXRhZGF0YV9wdHJf
Zm9yX3N0b3JlXzErMHgyNy8weDQwClsgIDQ0MS4zODMwNDJdWyBUMzM3NV0gIGttc2FuX3JlcG9y
dCsweDMxYS8weDMyMApbICA0NDEuMzgzMjY2XVsgVDMzNzVdICA/IF9fbXNhbl93YXJuaW5nKzB4
MWIvMHgzMApbICA0NDEuMzgzNDgxXVsgVDMzNzVdICA/IHJmY29tbV9ydW4rMHg3ZWFlLzB4ZWU5
MApbICA0NDEuMzgzNjk0XVsgVDMzNzVdICA/IGt0aHJlYWQrMHg1M2YvMHg2MDAKWyAgNDQxLjM4
Mzg4OV1bIFQzMzc1XSAgPyByZXRfZnJvbV9mb3JrKzB4MjBmLzB4OTEwClsgIDQ0MS4zODQxMDRd
WyBUMzM3NV0gID8gcmV0X2Zyb21fZm9ya19hc20rMHgxYS8weDMwClsgIDQ0MS4zODQzMjVdWyBU
MzM3NV0gID8gX19tc2FuX3dhcm5pbmcrMHgxYi8weDMwClsgIDQ0MS4zODQ1MzZdWyBUMzM3NV0g
ID8gZmlsdGVyX2lycV9zdGFja3MrMHgxM2YvMHgxOTAKWyAgNDQxLjM4NDc2NF1bIFQzMzc1XSAg
PyBrbXNhbl9nZXRfbWV0YWRhdGErMHhmMS8weDE2MApbICA0NDEuMzg0OTg0XVsgVDMzNzVdICA/
IGttc2FuX2ludGVybmFsX3NldF9zaGFkb3dfb3JpZ2luKzB4N2EvMHgxMTAKWyAgNDQxLjM4NTI2
Ml1bIFQzMzc1XSAgPyBrbXNhbl9nZXRfbWV0YWRhdGErMHhmMS8weDE2MApbICA0NDEuMzg1NDgy
XVsgVDMzNzVdICA/IGttc2FuX2dldF9tZXRhZGF0YSsweGYxLzB4MTYwClsgIDQ0MS4zODU2OTld
WyBUMzM3NV0gID8ga21zYW5faW50ZXJuYWxfc2V0X3NoYWRvd19vcmlnaW4rMHg3YS8weDExMApb
ICA0NDEuMzg1OTc1XVsgVDMzNzVdICA/IGttc2FuX2dldF9tZXRhZGF0YSsweGYxLzB4MTYwClsg
IDQ0MS4zODYyMDBdWyBUMzM3NV0gID8ga21zYW5fZ2V0X21ldGFkYXRhKzB4ZjEvMHgxNjAKWyAg
NDQxLjM4NjQyMV1bIFQzMzc1XSAgPyBrbXNhbl9nZXRfc2hhZG93X29yaWdpbl9wdHIrMHg0YS8w
eGIwClsgIDQ0MS4zODY2NjldWyBUMzM3NV0gID8gX19tc2FuX21ldGFkYXRhX3B0cl9mb3Jfc3Rv
cmVfOCsweDI3LzB4NDAKWyAgNDQxLjM4NjkzNl1bIFQzMzc1XSAgPyBrbXNhbl9nZXRfbWV0YWRh
dGErMHhmMS8weDE2MApbICA0NDEuMzg3MTYyXVsgVDMzNzVdICBfX21zYW5fd2FybmluZysweDFi
LzB4MzAKWyAgNDQxLjM4NzM2Nl1bIFQzMzc1XSAgcmZjb21tX3J1bisweDdlYWUvMHhlZTkwClsg
IDQ0MS4zODc1ODJdWyBUMzM3NV0gID8ga21zYW5fZ2V0X21ldGFkYXRhKzB4ZjEvMHgxNjAKWyAg
NDQxLjM4NzgwN11bIFQzMzc1XSAgPyBfX3BmeF93b2tlbl93YWtlX2Z1bmN0aW9uKzB4MTAvMHgx
MApbICA0NDEuMzg4MDU0XVsgVDMzNzVdICBrdGhyZWFkKzB4NTNmLzB4NjAwClsgIDQ0MS4zODgy
NDRdWyBUMzM3NV0gID8gX19wZnhfcmZjb21tX3J1bisweDEwLzB4MTAKWyAgNDQxLjM4ODQ2NF1b
IFQzMzc1XSAgPyBfX3BmeF9rdGhyZWFkKzB4MTAvMHgxMApbICA0NDEuMzg4NjcwXVsgVDMzNzVd
ICByZXRfZnJvbV9mb3JrKzB4MjBmLzB4OTEwClsgIDQ0MS4zODg4NzRdWyBUMzM3NV0gID8gX19z
d2l0Y2hfdG8rMHg1MWMvMHg3NTAKWyAgNDQxLjM4OTA4N11bIFQzMzc1XSAgPyBfX3BmeF9rdGhy
ZWFkKzB4MTAvMHgxMApbICA0NDEuMzg5Mjk1XVsgVDMzNzVdICByZXRfZnJvbV9mb3JrX2FzbSsw
eDFhLzB4MzAKWyAgNDQxLjM4OTUxNF1bIFQzMzc1XSAgPC9UQVNLPgpbICA0NDEuMzg5OTU4XVsg
VDMzNzVdIEtlcm5lbCBPZmZzZXQ6IGRpc2FibGVkClsgIDQ0MS4zOTAxMzhdWyBUMzM3NV0gUmVi
b290aW5nIGluIDg2NDAwIHNlY29uZHMuLgoK
--00000000000045d5da064f42a7de
Content-Type: text/x-csrc; charset="US-ASCII"; name="poc.c"
Content-Disposition: attachment; filename="poc.c"
Content-Transfer-Encoding: base64
Content-ID: <f_mnvr0f630>
X-Attachment-Id: f_mnvr0f630

I2RlZmluZSBfR05VX1NPVVJDRQoKI2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdHJpbmcu
aD4KI2luY2x1ZGUgPGZjbnRsLmg+CiNpbmNsdWRlIDx1bmlzdGQuaD4KI2luY2x1ZGUgPHN0ZGlu
dC5oPgojaW5jbHVkZSA8c3lzL3NvY2tldC5oPgojaW5jbHVkZSA8c3lzL3dhaXQuaD4KI2luY2x1
ZGUgPHNpZ25hbC5oPgojaW5jbHVkZSA8cG9sbC5oPgoKI2RlZmluZSBBRl9CTFVFVE9PVEggICAg
MzEKI2RlZmluZSBCVFBST1RPX1JGQ09NTSAgMwojZGVmaW5lIEFDTF9IQU5ETEUgICAgICAweDAw
NDAKI2RlZmluZSBMMkNBUF9DSURfU0lHICAgMHgwMDAxCgojZGVmaW5lIFJGQ09NTV9TQUJNICAg
ICAweDJmCiNkZWZpbmUgUkZDT01NX1VBICAgICAgIDB4NjMKI2RlZmluZSBSRkNPTU1fVUlIICAg
ICAgMHhlZgojZGVmaW5lIFJGQ09NTV9NQ0NfUE4gICAweDIwCiNkZWZpbmUgUkZDT01NX01DQ19S
UE4gIDB4MjQKCiNkZWZpbmUgUkZDT01NX0FERFIoY3IsIGRsY2kpICAoKChkbGNpKSA8PCAyKSB8
ICgoY3IpIDw8IDEpIHwgMSkKI2RlZmluZSBSRkNPTU1fQ1RSTCh0eXBlLCBwZikgICgoKHR5cGUp
ICYgfjB4MTApIHwgKChwZikgPDwgNCkpCgpzdGF0aWMgaW50IHZoY2lfZmQ7CnN0YXRpYyB1aW50
MTZfdCBsb2NhbF9jaWQgPSAweDAwNDE7CnN0YXRpYyB1aW50MTZfdCByZW1vdGVfY2lkID0gMHgw
MDQwOwoKc3RhdGljIGNvbnN0IHVpbnQ4X3QgY3JjX3RhYmxlWzI1Nl0gPSB7CiAgICAweDAwLCAw
eDkxLCAweGUzLCAweDcyLCAweDA3LCAweDk2LCAweGU0LCAweDc1LAogICAgMHgwZSwgMHg5Ziwg
MHhlZCwgMHg3YywgMHgwOSwgMHg5OCwgMHhlYSwgMHg3YiwKICAgIDB4MWMsIDB4OGQsIDB4ZmYs
IDB4NmUsIDB4MWIsIDB4OGEsIDB4ZjgsIDB4NjksCiAgICAweDEyLCAweDgzLCAweGYxLCAweDYw
LCAweDE1LCAweDg0LCAweGY2LCAweDY3LAogICAgMHgzOCwgMHhhOSwgMHhkYiwgMHg0YSwgMHgz
ZiwgMHhhZSwgMHhkYywgMHg0ZCwKICAgIDB4MzYsIDB4YTcsIDB4ZDUsIDB4NDQsIDB4MzEsIDB4
YTAsIDB4ZDIsIDB4NDMsCiAgICAweDI0LCAweGI1LCAweGM3LCAweDU2LCAweDIzLCAweGIyLCAw
eGMwLCAweDUxLAogICAgMHgyYSwgMHhiYiwgMHhjOSwgMHg1OCwgMHgyZCwgMHhiYywgMHhjZSwg
MHg1ZiwKICAgIDB4NzAsIDB4ZTEsIDB4OTMsIDB4MDIsIDB4NzcsIDB4ZTYsIDB4OTQsIDB4MDUs
CiAgICAweDdlLCAweGVmLCAweDlkLCAweDBjLCAweDc5LCAweGU4LCAweDlhLCAweDBiLAogICAg
MHg2YywgMHhmZCwgMHg4ZiwgMHgxZSwgMHg2YiwgMHhmYSwgMHg4OCwgMHgxOSwKICAgIDB4NjIs
IDB4ZjMsIDB4ODEsIDB4MTAsIDB4NjUsIDB4ZjQsIDB4ODYsIDB4MTcsCiAgICAweDQ4LCAweGQ5
LCAweGFiLCAweDNhLCAweDRmLCAweGRlLCAweGFjLCAweDNkLAogICAgMHg0NiwgMHhkNywgMHhh
NSwgMHgzNCwgMHg0MSwgMHhkMCwgMHhhMiwgMHgzMywKICAgIDB4NTQsIDB4YzUsIDB4YjcsIDB4
MjYsIDB4NTMsIDB4YzIsIDB4YjAsIDB4MjEsCiAgICAweDVhLCAweGNiLCAweGI5LCAweDI4LCAw
eDVkLCAweGNjLCAweGJlLCAweDJmLAogICAgMHhlMCwgMHg3MSwgMHgwMywgMHg5MiwgMHhlNywg
MHg3NiwgMHgwNCwgMHg5NSwKICAgIDB4ZWUsIDB4N2YsIDB4MGQsIDB4OWMsIDB4ZTksIDB4Nzgs
IDB4MGEsIDB4OWIsCiAgICAweGZjLCAweDZkLCAweDFmLCAweDhlLCAweGZiLCAweDZhLCAweDE4
LCAweDg5LAogICAgMHhmMiwgMHg2MywgMHgxMSwgMHg4MCwgMHhmNSwgMHg2NCwgMHgxNiwgMHg4
NywKICAgIDB4ZDgsIDB4NDksIDB4M2IsIDB4YWEsIDB4ZGYsIDB4NGUsIDB4M2MsIDB4YWQsCiAg
ICAweGQ2LCAweDQ3LCAweDM1LCAweGE0LCAweGQxLCAweDQwLCAweDMyLCAweGEzLAogICAgMHhj
NCwgMHg1NSwgMHgyNywgMHhiNiwgMHhjMywgMHg1MiwgMHgyMCwgMHhiMSwKICAgIDB4Y2EsIDB4
NWIsIDB4MjksIDB4YjgsIDB4Y2QsIDB4NWMsIDB4MmUsIDB4YmYsCiAgICAweDkwLCAweDAxLCAw
eDczLCAweGUyLCAweDk3LCAweDA2LCAweDc0LCAweGU1LAogICAgMHg5ZSwgMHgwZiwgMHg3ZCwg
MHhlYywgMHg5OSwgMHgwOCwgMHg3YSwgMHhlYiwKICAgIDB4OGMsIDB4MWQsIDB4NmYsIDB4ZmUs
IDB4OGIsIDB4MWEsIDB4NjgsIDB4ZjksCiAgICAweDgyLCAweDEzLCAweDYxLCAweGYwLCAweDg1
LCAweDE0LCAweDY2LCAweGY3LAogICAgMHhhOCwgMHgzOSwgMHg0YiwgMHhkYSwgMHhhZiwgMHgz
ZSwgMHg0YywgMHhkZCwKICAgIDB4YTYsIDB4MzcsIDB4NDUsIDB4ZDQsIDB4YTEsIDB4MzAsIDB4
NDIsIDB4ZDMsCiAgICAweGI0LCAweDI1LCAweDU3LCAweGM2LCAweGIzLCAweDIyLCAweDUwLCAw
eGMxLAogICAgMHhiYSwgMHgyYiwgMHg1OSwgMHhjOCwgMHhiZCwgMHgyYywgMHg1ZSwgMHhjZgp9
OwoKc3RhdGljIHVpbnQ4X3QgZmNzMih1aW50OF90IGEsIHVpbnQ4X3QgYykKewogICAgcmV0dXJu
IDB4ZmYgLSBjcmNfdGFibGVbY3JjX3RhYmxlWzB4ZmYgXiBhXSBeIGNdOwp9CgpzdGF0aWMgdWlu
dDhfdCBmY3MzKHVpbnQ4X3QgYSwgdWludDhfdCBjLCB1aW50OF90IGwpCnsKICAgIHJldHVybiAw
eGZmIC0gY3JjX3RhYmxlW2NyY190YWJsZVtjcmNfdGFibGVbMHhmZiBeIGFdIF4gY10gXiBsXTsK
fQoKc3RhdGljIHZvaWQgc2VuZF9jYyh1aW50MTZfdCBvcCwgdWludDhfdCAqcCwgaW50IGxlbikK
ewogICAgdWludDhfdCBwa3RbNTEyXSA9IHsweDA0LCAweDBlLCAzICsgbGVuLCAxLCBvcCAmIDB4
ZmYsIG9wID4+IDh9OwogICAgbWVtY3B5KHBrdCArIDYsIHAsIGxlbik7CiAgICB3cml0ZSh2aGNp
X2ZkLCBwa3QsIDYgKyBsZW4pOwp9CgpzdGF0aWMgdm9pZCBzZW5kX2FjbCh1aW50MTZfdCBjaWQs
IHVpbnQ4X3QgKmRhdGEsIGludCBsZW4pCnsKICAgIHVpbnQ4X3QgcGt0WzUxMl0gPSB7CiAgICAg
ICAgMHgwMiwKICAgICAgICBBQ0xfSEFORExFICYgMHhmZiwKICAgICAgICAoKEFDTF9IQU5ETEUg
Pj4gOCkgJiAweDBmKSB8IDB4MjAsCiAgICAgICAgKDQgKyBsZW4pICYgMHhmZiwgKDQgKyBsZW4p
ID4+IDgsCiAgICAgICAgbGVuICYgMHhmZiwgbGVuID4+IDgsCiAgICAgICAgY2lkICYgMHhmZiwg
Y2lkID4+IDgKICAgIH07CiAgICBtZW1jcHkocGt0ICsgOSwgZGF0YSwgbGVuKTsKICAgIHdyaXRl
KHZoY2lfZmQsIHBrdCwgOSArIGxlbik7Cn0KCnN0YXRpYyB2b2lkIHNlbmRfc2hvcnRfcG4odWlu
dDhfdCBkbGNpKQp7CiAgICB1aW50OF90IGEgPSBSRkNPTU1fQUREUigxLCAwKTsKICAgIHVpbnQ4
X3QgYyA9IFJGQ09NTV9DVFJMKFJGQ09NTV9VSUgsIDApOwogICAgdWludDhfdCBmW10gPSB7YSwg
YywgKDU8PDEpfDEsIChSRkNPTU1fTUNDX1BOPDwyKXwzLCAoMzw8MSl8MSwKICAgICAgICAgICAg
ICAgICAgIGRsY2ksIDB4ZTAsIDB4MDAsIGZjczIoYSwgYyl9OwogICAgc2VuZF9hY2wocmVtb3Rl
X2NpZCwgZiwgc2l6ZW9mKGYpKTsKfQoKc3RhdGljIHZvaWQgc2VuZF9zaG9ydF9ycG4odWludDhf
dCBkbGNpKQp7CiAgICB1aW50OF90IGEgPSBSRkNPTU1fQUREUigxLCAwKTsKICAgIHVpbnQ4X3Qg
YyA9IFJGQ09NTV9DVFJMKFJGQ09NTV9VSUgsIDApOwogICAgdWludDhfdCBmW10gPSB7YSwgYywg
KDQ8PDEpfDEsIChSRkNPTU1fTUNDX1JQTjw8Mil8MywgKDI8PDEpfDEsCiAgICAgICAgICAgICAg
ICAgICAoZGxjaTw8Mil8MywgMHgwMCwgZmNzMihhLCBjKX07CiAgICBzZW5kX2FjbChyZW1vdGVf
Y2lkLCBmLCBzaXplb2YoZikpOwp9CgpzdGF0aWMgdm9pZCByZmNvbW1fY2xpZW50KHZvaWQpCnsK
ICAgIHN0cnVjdCB7IHVpbnQxNl90IGZhbWlseTsgdWludDhfdCBhZGRyWzZdOyB1aW50OF90IGNo
YW5uZWw7IH0gc2EgPSB7MH07CgogICAgd2hpbGUgKGFjY2VzcygiL3RtcC92aGNpX3JlYWR5Iiwg
Rl9PSykpIHVzbGVlcCgxMDAwMDApOwogICAgc2xlZXAoMSk7CgogICAgaW50IGZkID0gc29ja2V0
KEFGX0JMVUVUT09USCwgU09DS19TVFJFQU0sIEJUUFJPVE9fUkZDT01NKTsKICAgIHNhLmZhbWls
eSA9IEFGX0JMVUVUT09USDsKICAgIHNhLmFkZHJbMF0gPSAweGZmOyBzYS5hZGRyWzFdID0gMHhl
ZTsgc2EuYWRkclsyXSA9IDB4ZGQ7CiAgICBzYS5hZGRyWzNdID0gMHhjYzsgc2EuYWRkcls0XSA9
IDB4YmI7IHNhLmFkZHJbNV0gPSAweGFhOwogICAgc2EuY2hhbm5lbCA9IDE7CiAgICBjb25uZWN0
KGZkLCAodm9pZCAqKSZzYSwgc2l6ZW9mKHNhKSk7CiAgICB3aGlsZSAoMSkgc2xlZXAoMSk7Cn0K
CnN0YXRpYyB2b2lkIGhjaV9jbWQodWludDhfdCAqYnVmKQp7CiAgICB1aW50MTZfdCBvcCA9IGJ1
ZlsxXSB8IChidWZbMl0gPDwgOCk7CgogICAgc3dpdGNoIChvcCkgewogICAgY2FzZSAweDBjMDM6
IGNhc2UgMHgwYzAxOiBjYXNlIDB4MGM0NTogY2FzZSAweDBjNTI6IGNhc2UgMHgwODBmOiBjYXNl
IDB4MjA3NDoKICAgIGNhc2UgMHgwYzE2OiBjYXNlIDB4MGMxODogY2FzZSAweDBjMTk6IGNhc2Ug
MHgwYzFhOiBjYXNlIDB4MGM2ZDogY2FzZSAweDBjNDY6CiAgICBjYXNlIDB4MGMyNDogY2FzZSAw
eDBjMTM6IGNhc2UgMHgyMDAxOgogICAgICAgIHsgdWludDhfdCBwW10gPSB7MH07IHNlbmRfY2Mo
b3AsIHAsIDEpOyB9IGJyZWFrOwoKICAgIGNhc2UgMHgwYzU4OiBjYXNlIDB4MGMzODogY2FzZSAw
eDBjMzk6IGNhc2UgMHgwYzQ0OiBjYXNlIDB4MjAxNjogY2FzZSAweDIwM2I6CiAgICAgICAgeyB1
aW50OF90IHBbXSA9IHswLCAwfTsgc2VuZF9jYyhvcCwgcCwgMik7IH0gYnJlYWs7CgogICAgY2Fz
ZSAweDBjMjU6IGNhc2UgMHgxMDBiOgogICAgICAgIHsgdWludDhfdCBwW10gPSB7MCwgMCwgMH07
IHNlbmRfY2Mob3AsIHAsIDMpOyB9IGJyZWFrOwoKICAgIGNhc2UgMHgwYzIzOiB7IHVpbnQ4X3Qg
cFtdID0gezAsIDAsIDEsIDB9OyBzZW5kX2NjKG9wLCBwLCA0KTsgfSBicmVhazsKICAgIGNhc2Ug
MHgyMDAyOiB7IHVpbnQ4X3QgcFtdID0gezAsIDB4ZmIsIDAsIDh9OyBzZW5kX2NjKG9wLCBwLCA0
KTsgfSBicmVhazsKICAgIGNhc2UgMHgwYzFjOiBjYXNlIDB4MjAyMzogeyB1aW50OF90IHBbXSA9
IHswLDAsMCwwLDB9OyBzZW5kX2NjKG9wLCBwLCA1KTsgfSBicmVhazsKICAgIGNhc2UgMHgwYzBk
OiB7IHVpbnQ4X3QgcFtdID0gezAsIEFDTF9IQU5ETEUmMHhmZiwgQUNMX0hBTkRMRT4+OCwgMCwg
MH07IHNlbmRfY2Mob3AsIHAsIDUpOyB9IGJyZWFrOwogICAgY2FzZSAweDEwMGE6IHsgdWludDhf
dCBwW10gPSB7MCwgMCwgNCwgMCwgOCwgMH07IHNlbmRfY2Mob3AsIHAsIDYpOyB9IGJyZWFrOwog
ICAgY2FzZSAweDEwMDk6IHsgdWludDhfdCBwW10gPSB7MCwgMHgxMSwgMHgyMiwgMHgzMywgMHg0
NCwgMHg1NSwgMHg2Nn07IHNlbmRfY2Mob3AsIHAsIDcpOyB9IGJyZWFrOwogICAgY2FzZSAweDIw
NjA6IGNhc2UgMHgyMDYxOiBjYXNlIDB4MjA2MjogeyB1aW50OF90IHBbN10gPSB7MH07IHNlbmRf
Y2Mob3AsIHAsIDcpOyB9IGJyZWFrOwogICAgY2FzZSAweDEwMDU6IHsgdWludDhfdCBwW10gPSB7
MCwgMCwgNCwgMHg0MCwgOCwgMCwgOCwgMH07IHNlbmRfY2Mob3AsIHAsIDgpOyB9IGJyZWFrOwog
ICAgY2FzZSAweDEwMDE6IGNhc2UgMHgxMDAzOiBjYXNlIDB4MjAwMzoKICAgICAgICB7IHVpbnQ4
X3QgcFtdID0gezAsIDB4ZmYsIDB4ZmYsIDB4OGYsIDB4ZmUsIDB4ZGIsIDB4ZmYsIDB4NWIsIDB4
ODd9OyBzZW5kX2NjKG9wLCBwLCA5KTsgfSBicmVhazsKICAgIGNhc2UgMHgyMDFjOiBjYXNlIDB4
MjAyZjoKICAgICAgICB7IHVpbnQ4X3QgcFtdID0gezAsIDB4ZmIsIDAsIDB4NDgsIDgsIDB4ZmIs
IDAsIDB4NDgsIDh9OyBzZW5kX2NjKG9wLCBwLCA5KTsgfSBicmVhazsKICAgIGNhc2UgMHgxMDA0
OiB7IHVpbnQ4X3QgcFsxMV0gPSB7MH07IHBbM10gPSA3OyBzZW5kX2NjKG9wLCBwLCAxMSk7IH0g
YnJlYWs7CiAgICBjYXNlIDB4MTAwMjogeyB1aW50OF90IHBbNjVdID0gezB9OyBwWzVdPTB4ZmY7
IHBbNl09MHhmZjsgcFs3XT0weGZmOyBwWzE0XT04OyBzZW5kX2NjKG9wLCBwLCA2NSk7IH0gYnJl
YWs7CiAgICBjYXNlIDB4MGMxNDogeyB1aW50OF90IHBbMjQ5XSA9IHswfTsgc2VuZF9jYyhvcCwg
cCwgMjQ5KTsgfSBicmVhazsKCiAgICBjYXNlIDB4MGMxMjogewogICAgICAgIHVpbnQ4X3QgcFtd
ID0gezAsIDAsIDB9OyBzZW5kX2NjKG9wLCBwLCAzKTsKICAgICAgICBzdGF0aWMgaW50IHJlYWR5
ID0gMDsKICAgICAgICBpZiAoIXJlYWR5KSB7IHJlYWR5ID0gMTsgY2xvc2Uob3BlbigiL3RtcC92
aGNpX3JlYWR5IiwgT19DUkVBVHxPX1dST05MWSwgMDY0NCkpOyB9CiAgICB9IGJyZWFrOwoKICAg
IGNhc2UgMHgwNDA1OiB7CiAgICAgICAgdWludDhfdCBjc1tdID0gezB4MDQsIDB4MGYsIDQsIDAs
IDEsIDUsIDR9OwogICAgICAgIHdyaXRlKHZoY2lfZmQsIGNzLCA3KTsKICAgICAgICB1c2xlZXAo
MTAwMDAwKTsKICAgICAgICB1aW50OF90IGNuW10gPSB7MHgwNCwgMHgwMywgMTEsIDAsIEFDTF9I
QU5ETEUmMHhmZiwgQUNMX0hBTkRMRT4+OCwKICAgICAgICAgICAgICAgICAgICAgICAgMHhmZiwg
MHhlZSwgMHhkZCwgMHhjYywgMHhiYiwgMHhhYSwgMSwgMH07CiAgICAgICAgd3JpdGUodmhjaV9m
ZCwgY24sIDE0KTsKICAgIH0gYnJlYWs7CgogICAgY2FzZSAweDA0MWI6IHsKICAgICAgICB1aW50
OF90IGNzW10gPSB7MHgwNCwgMHgwZiwgNCwgMCwgMSwgMHgxYiwgNH07CiAgICAgICAgd3JpdGUo
dmhjaV9mZCwgY3MsIDcpOwogICAgICAgIHVzbGVlcCg1MDAwMCk7CiAgICAgICAgdWludDhfdCBl
dltdID0gezB4MDQsIDB4MGIsIDExLCAwLCBBQ0xfSEFORExFJjB4ZmYsIEFDTF9IQU5ETEU+Pjgs
CiAgICAgICAgICAgICAgICAgICAgICAgIDB4ZmYsIDB4ZmYsIDB4OGYsIDB4ZmUsIDB4ZGIsIDB4
ZmYsIDB4NWIsIDB4ODd9OwogICAgICAgIHdyaXRlKHZoY2lfZmQsIGV2LCAxNCk7CiAgICB9IGJy
ZWFrOwoKICAgIGNhc2UgMHgwNDFjOiB7CiAgICAgICAgdWludDhfdCBjc1tdID0gezB4MDQsIDB4
MGYsIDQsIDAsIDEsIDB4MWMsIDR9OwogICAgICAgIHdyaXRlKHZoY2lfZmQsIGNzLCA3KTsKICAg
ICAgICB1c2xlZXAoNTAwMDApOwogICAgICAgIHVpbnQ4X3QgZXZbXSA9IHsweDA0LCAweDIzLCAx
MywgMCwgQUNMX0hBTkRMRSYweGZmLCBBQ0xfSEFORExFPj44LAogICAgICAgICAgICAgICAgICAg
ICAgICAxLCAyLCA3LCAwLCAwLCAwLCAwLCAwLCAwLCAwfTsKICAgICAgICB3cml0ZSh2aGNpX2Zk
LCBldiwgMTYpOwogICAgfSBicmVhazsKCiAgICBjYXNlIDB4MDQxOTogewogICAgICAgIHVpbnQ4
X3QgY3NbXSA9IHsweDA0LCAweDBmLCA0LCAwLCAxLCAweDE5LCA0fTsKICAgICAgICB3cml0ZSh2
aGNpX2ZkLCBjcywgNyk7CiAgICAgICAgdXNsZWVwKDUwMDAwKTsKICAgICAgICB1aW50OF90IGV2
WzI1OF0gPSB7MHgwNCwgMHgwNywgMjU1LCAwLCAweGZmLCAweGVlLCAweGRkLCAweGNjLCAweGJi
LCAweGFhfTsKICAgICAgICB3cml0ZSh2aGNpX2ZkLCBldiwgMjU4KTsKICAgIH0gYnJlYWs7Cgog
ICAgZGVmYXVsdDoKICAgICAgICB7IHVpbnQ4X3QgcFtdID0gezB9OyBzZW5kX2NjKG9wLCBwLCAx
KTsgfSBicmVhazsKICAgIH0KfQoKc3RhdGljIHZvaWQgZXhlY3V0ZSh2b2lkKQp7CiAgICB1aW50
OF90IGJ1Zls1MTJdOwogICAgaW50IGRsY19jb25uZWN0ZWQgPSAwOwogICAgdWludDhfdCBkbGNp
ID0gMDsKCiAgICB2aGNpX2ZkID0gb3BlbigiL2Rldi92aGNpIiwgT19SRFdSKTsKICAgIHdyaXRl
KHZoY2lfZmQsICJceGZmXHgwMCIsIDIpOwoKICAgIHdoaWxlICghZGxjX2Nvbm5lY3RlZCkgewog
ICAgICAgIHN0cnVjdCBwb2xsZmQgcGZkID0ge3ZoY2lfZmQsIFBPTExJTiwgMH07CiAgICAgICAg
aWYgKHBvbGwoJnBmZCwgMSwgMTAwKSA8PSAwKSBjb250aW51ZTsKCiAgICAgICAgaW50IGxlbiA9
IHJlYWQodmhjaV9mZCwgYnVmLCA1MTIpOwogICAgICAgIGlmIChsZW4gPD0gMCkgY29udGludWU7
CgogICAgICAgIGlmIChidWZbMF0gPT0gMHgwMSkgewogICAgICAgICAgICBoY2lfY21kKGJ1Zik7
CiAgICAgICAgfQogICAgICAgIGVsc2UgaWYgKGJ1ZlswXSA9PSAweDAyICYmIGxlbiA+PSA5KSB7
CiAgICAgICAgICAgIHVpbnQxNl90IGNpZCA9IGJ1Zls3XSB8IChidWZbOF0gPDwgOCk7CgogICAg
ICAgICAgICBpZiAoY2lkID09IEwyQ0FQX0NJRF9TSUcpIHsKICAgICAgICAgICAgICAgIHVpbnQ4
X3QgY29kZSA9IGJ1Zls5XSwgaWQgPSBidWZbMTBdOwoKICAgICAgICAgICAgICAgIGlmIChjb2Rl
ID09IDB4MDIpIHsKICAgICAgICAgICAgICAgICAgICBsb2NhbF9jaWQgPSBidWZbMTVdIHwgKGJ1
ZlsxNl0gPDwgOCk7CiAgICAgICAgICAgICAgICAgICAgdWludDhfdCByW10gPSB7MywgaWQsIDgs
IDAsIHJlbW90ZV9jaWQmMHhmZiwgcmVtb3RlX2NpZD4+OCwKICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBsb2NhbF9jaWQmMHhmZiwgbG9jYWxfY2lkPj44LCAwLCAwLCAwLCAwfTsK
ICAgICAgICAgICAgICAgICAgICBzZW5kX2FjbChMMkNBUF9DSURfU0lHLCByLCAxMik7CiAgICAg
ICAgICAgICAgICB9CiAgICAgICAgICAgICAgICBlbHNlIGlmIChjb2RlID09IDB4MDQpIHsKICAg
ICAgICAgICAgICAgICAgICB1aW50OF90IHJbXSA9IHs1LCBpZCwgNiwgMCwgbG9jYWxfY2lkJjB4
ZmYsIGxvY2FsX2NpZD4+OCwgMCwgMCwgMCwgMH07CiAgICAgICAgICAgICAgICAgICAgc2VuZF9h
Y2woTDJDQVBfQ0lEX1NJRywgciwgMTApOwogICAgICAgICAgICAgICAgICAgIHVzbGVlcCg1MDAw
MCk7CiAgICAgICAgICAgICAgICAgICAgdWludDhfdCBjW10gPSB7NCwgMHgxMCwgNCwgMCwgbG9j
YWxfY2lkJjB4ZmYsIGxvY2FsX2NpZD4+OCwgMCwgMH07CiAgICAgICAgICAgICAgICAgICAgc2Vu
ZF9hY2woTDJDQVBfQ0lEX1NJRywgYywgOCk7CiAgICAgICAgICAgICAgICB9CiAgICAgICAgICAg
ICAgICBlbHNlIGlmIChjb2RlID09IDB4MGEpIHsKICAgICAgICAgICAgICAgICAgICB1aW50MTZf
dCB0ID0gYnVmWzEzXSB8IChidWZbMTRdIDw8IDgpOwogICAgICAgICAgICAgICAgICAgIGlmICh0
ID09IDIpIHsKICAgICAgICAgICAgICAgICAgICAgICAgdWludDhfdCByW10gPSB7MHgwYiwgaWQs
IDgsIDAsIDIsIDAsIDAsIDAsIDB4ODAsIDIsIDAsIDB9OwogICAgICAgICAgICAgICAgICAgICAg
ICBzZW5kX2FjbChMMkNBUF9DSURfU0lHLCByLCAxMik7CiAgICAgICAgICAgICAgICAgICAgfSBl
bHNlIGlmICh0ID09IDMpIHsKICAgICAgICAgICAgICAgICAgICAgICAgdWludDhfdCByW10gPSB7
MHgwYiwgaWQsIDB4MGMsIDAsIDMsIDAsIDAsIDAsIDYsIDAsIDAsIDAsIDAsIDAsIDAsIDB9Owog
ICAgICAgICAgICAgICAgICAgICAgICBzZW5kX2FjbChMMkNBUF9DSURfU0lHLCByLCAxNik7CiAg
ICAgICAgICAgICAgICAgICAgfQogICAgICAgICAgICAgICAgfQogICAgICAgICAgICB9CiAgICAg
ICAgICAgIGVsc2UgaWYgKGNpZCA9PSByZW1vdGVfY2lkICYmIGxlbiA+PSAxMikgewogICAgICAg
ICAgICAgICAgdWludDhfdCBhZGRyID0gYnVmWzldLCBjdHJsID0gYnVmWzEwXTsKICAgICAgICAg
ICAgICAgIHVpbnQ4X3QgZCA9IChhZGRyID4+IDIpICYgMHgzZjsKCiAgICAgICAgICAgICAgICBp
ZiAoKGN0cmwgJiAweGVmKSA9PSBSRkNPTU1fU0FCTSkgewogICAgICAgICAgICAgICAgICAgIHVp
bnQ4X3QgY3IgPSAoYWRkciA+PiAxKSAmIDE7CiAgICAgICAgICAgICAgICAgICAgdWludDhfdCB1
YV9hID0gUkZDT01NX0FERFIoY3IgPyAwIDogMSwgZCk7CiAgICAgICAgICAgICAgICAgICAgdWlu
dDhfdCB1YV9jID0gUkZDT01NX0NUUkwoUkZDT01NX1VBLCAxKTsKICAgICAgICAgICAgICAgICAg
ICB1aW50OF90IHVhW10gPSB7dWFfYSwgdWFfYywgMSwgZmNzMyh1YV9hLCB1YV9jLCAxKX07CiAg
ICAgICAgICAgICAgICAgICAgc2VuZF9hY2wocmVtb3RlX2NpZCwgdWEsIDQpOwogICAgICAgICAg
ICAgICAgICAgIGlmIChkKSB7IGRsY2kgPSBkOyBkbGNfY29ubmVjdGVkID0gMTsgfQogICAgICAg
ICAgICAgICAgfQogICAgICAgICAgICAgICAgZWxzZSBpZiAoKGN0cmwgJiAweGVmKSA9PSBSRkNP
TU1fVUlIICYmIGQgPT0gMCAmJiBsZW4gPj0gMTQpIHsKICAgICAgICAgICAgICAgICAgICBpZiAo
KGJ1ZlsxMl0gPj4gMikgPT0gUkZDT01NX01DQ19QTiAmJiAoYnVmWzEyXSAmIDIpKSB7CiAgICAg
ICAgICAgICAgICAgICAgICAgIHVpbnQ4X3QgcGQgPSBidWZbMTRdOwogICAgICAgICAgICAgICAg
ICAgICAgICB1aW50OF90IGEgPSBSRkNPTU1fQUREUigxLCAwKTsKICAgICAgICAgICAgICAgICAg
ICAgICAgdWludDhfdCBjID0gUkZDT01NX0NUUkwoUkZDT01NX1VJSCwgMCk7CiAgICAgICAgICAg
ICAgICAgICAgICAgIHVpbnQ4X3QgZltdID0ge2EsIGMsICgxMDw8MSl8MSwgKFJGQ09NTV9NQ0Nf
UE48PDIpfDEsICg4PDwxKXwxLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBwZCwgMHhlMCwgMCwgMCwgMHg5YiwgMiwgMCwgNywgZmNzMihhLCBjKX07CiAgICAgICAgICAg
ICAgICAgICAgICAgIHNlbmRfYWNsKHJlbW90ZV9jaWQsIGYsIDE0KTsKICAgICAgICAgICAgICAg
ICAgICB9CiAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgIH0KICAgICAgICB9CiAgICB9Cgog
ICAgdXNsZWVwKDEwMDAwMCk7CiAgICBzZW5kX3Nob3J0X3BuKGRsY2kpOwogICAgdXNsZWVwKDEw
MDAwMCk7CiAgICBzZW5kX3Nob3J0X3JwbihkbGNpKTsKICAgIHNsZWVwKDIpOwp9CgppbnQgbWFp
bih2b2lkKQp7CiAgICB1bmxpbmsoIi90bXAvdmhjaV9yZWFkeSIpOwoKICAgIHBpZF90IHBpZCA9
IGZvcmsoKTsKICAgIGlmIChwaWQgPT0gMCkgewogICAgICAgIHJmY29tbV9jbGllbnQoKTsKICAg
ICAgICByZXR1cm4gMDsKICAgIH0KCiAgICBleGVjdXRlKCk7CiAgICBraWxsKHBpZCwgU0lHS0lM
TCk7CiAgICB3YWl0cGlkKHBpZCwgTlVMTCwgMCk7CiAgICByZXR1cm4gMDsKfQo=
--00000000000045d5da064f42a7de--
