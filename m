Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE93F449B25
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 19:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784576855; cv=pass; b=K676cYdXRwtz7rfcRJ7uaxGV9HDQmuH25K/t/ATg3oTCLUhHVRRb8AVq0GawTMqxnnbbv3b62AfXTkdnnlafoOeu3s3fN4I95HRFtRSSuzpJAAeoa3o/shUDN+H1rYv2rbDb/JJNUn/kW/3NUsGVIearWrUIYnCQ0DFbQBS4tl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784576855; c=relaxed/simple;
	bh=cEX7D8MIuV2QMBaIbdonBrCOKrzx8El8+lMVNx++688=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pgmTk7Toi6K8RA9pOVPyNGv7e1EZq6dsJRFZcuYFNnATq2ZrNDsrwESEk98HcN1UyZweoGu+pxN4Lcy0hKFdb2F3ZdO8Xr3W+hEdygAt5ujNJPuiazDlWLn5zklsSP1KSCThtRVe4A3Tz0sZYGiGiMqhTloEaRc2D2CAcRnaElE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aw5gjtnX; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aw5gjtnX"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-81e83f1f15aso41210027b3.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 12:47:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784576853; cv=none;
        d=google.com; s=arc-20260327;
        b=meksg5RU83GzubiekStNmCbXyM2PtokCtyn+gRducDWxm+9IOFYVT3jmqSt/w4+1UV
         PH+kwhvEbtkvP2JPo72l1tSzCLh9nzz3M4vB+pXz/wVvWKDYopZSoBd3M5V++zECKxFo
         R0EdzhvI040fyTv+Rb86ceMdz7yRnrbTb2uxjknvmjT1mrun+zyioBIlI7YHXG2bUgo/
         nvXxgmk87hWucLSZfhzInkeujkzX0l8PyvqYVBxnSRth/jR7XfxOvyPCejh/rViCJ9b+
         +jl8HAi66fQqnaJX8Q7y5m9PztEKFmxEmt0T+u3pDNIAiRhAoZwgPqKwNfCiO9LRz8d5
         2vIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ykBr0/VOhtxcVeD7Inh46ggjaB6Z9PNwcFWo5KP6MTg=;
        fh=7RZSI8pn1rNbdbC5NBo1R/0gLsMmT9Kp8NhOt3JHQfI=;
        b=UvHEjSvNvgKCobx6d8/3/SxGxPFjS+acusGN4tkqmWk0sCx5CuOSySvQyzX0GcDUF5
         Zu3gIhHvieB79hS3KRFrcDqEcngQnI8M1quOEtLY3OgD0swUmmSKf1l8cmTCv6/ahUlN
         nbZXL+NpfFvE1ehqvGs83403TVgkp7I78bqtfzSxgppsNH89Hvln5/dJl0VqrRnJ+0PA
         bI+ELgMhCKY+GC+dUXJfcNlo85mG2CBmpEQLpaqotnTanae3y9bTj2jSZ8RF3j8qacqo
         tzPxzx5qFjxki6H2IqreXWa3fwgobKXGmQbSZH3eKZ5kPnp8dVDiWG13jvdxZk0cGvLL
         IufQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784576853; x=1785181653; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ykBr0/VOhtxcVeD7Inh46ggjaB6Z9PNwcFWo5KP6MTg=;
        b=Aw5gjtnXsj42RYRXL5mRndZh0l8+MoE7fXWRRCB4v3O/BQ+z3kIdZv+HhC6QL36GkI
         a9yIbwqTjzWXNoEKdD2DN2i7p/BYt3tPhHB3xdk+gIQFIgnBVeRddJAnjRMj8wCjYc6C
         G0BvYAdTL7CIytQgg22LxGLxXypjtYxi+hnw4guO0A3OrsT2zEc3Wv2dm5cLm7wnoZxb
         EATWoC1hG2hHC4dp8X03NgiLNSBagOHZ+ORBgqBmq8NPkmuQUtoZIC7d5GKf4MfdnK0s
         ZF4sm23uBFu8DWIAAugEbgj63OMbE8+QLHo3iYg9QAwMyG/Uzn2v5LbblIzsnQiDN5gD
         Z4/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784576853; x=1785181653;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ykBr0/VOhtxcVeD7Inh46ggjaB6Z9PNwcFWo5KP6MTg=;
        b=Moh85rNQ+LdW2QZd7PGJdn6aUl/88kdN9iq8YqsxhfXoULB88QVUVt5tzGstfGonou
         aPpflBD3hK1aT/g0rFefvsjoiYF6QICJ0GiYDLUX5VRGbMr3UASdpRECDzslsIINZoCK
         NzBVFmGIPz0GWZ43hMax7yjp0gxmDeJEyBIwpZx+vCytI6xUB23/SwCNcvG+W+YLe8u4
         jky4+Gmh8qWJ3mJSvXoiuOK208YvnAm7sc54VpAOc4ShW4BhY3HgvEbFw2PLbRLgq+Ln
         zAK7I+89R7yenyYNdswu9NZhlHJQD2Ayy3wBbn384zhe70ypE+O0xdJpn0ZuCzkggKJt
         4LBg==
X-Forwarded-Encrypted: i=1; AHgh+RpunHMOytb6qKKRP8GlrX9ZafYmrNKCGHfQAgAW2hDGG36c3tTWgOOK0uYETvLfgRRKVrc0JREBAGiHNME0P98=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW6r2XMDMxSCMDDguYTaqarrGDAQFR1upFlJSP2WQ6YgMhfv5S
	5R5pIuOl9Nt5fGAK5easCxuAhlkRUb+LvQDGTRTfQuz22lLl+R2uzkefkzvc2H7pT3hinxdvgAo
	8Zu7PZ/e8gTCV7SsrBJvShsL8sm3qgbo=
X-Gm-Gg: AR+sD130BkyLpgnJy1lFzaSC1OxTEOEWzSbQsxCv5rmOobBd6oI7OSul2B1dVyy8b5X
	wvmYt8MTdTSKHHiyRhonVB/Hg26PF6yEzcexKF2i5JymALCCN0i+rqVtFkPA8NDDls1SDtMKNwU
	I/+RkpBLYncs+yhfOnYB+zdSOvWqbQck4fCNUedx7R5gAmCM9nWzvgMc7xRjAjqqeW5tHvcJhxE
	cStPEN4YA9VpzqlHMF6De58opMQpg6ect7yPNZ5CEX2LmvAc+g6dd/5SbRpyOYohYnV+SW2dbxj
	47eU8vlbHV8hYxljNkG2EiyHJTjNBSoNHufQ+7g/PJ5SvcP3
X-Received: by 2002:a05:690c:4907:b0:81e:6d03:40d2 with SMTP id
 00721157ae682-81ef14c77d8mr45709507b3.15.1784576852654; Mon, 20 Jul 2026
 12:47:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717153238.2002330-1-yaojiale02@163.com> <CABBYNZJdEjqd2eKmQNvPodvifnPgVvih5fnFf5sdA7Kpi7T19w@mail.gmail.com>
 <220b6be5.d3f.19f78e165aa.Coremail.19888972804@163.com>
In-Reply-To: <220b6be5.d3f.19f78e165aa.Coremail.19888972804@163.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 20 Jul 2026 15:47:21 -0400
X-Gm-Features: AUfX_my2ggP47su8evT9XSWj8nSPWthcDwk35Zk4O7Myi8XYD7HX5FST6QinKCM
Message-ID: <CABBYNZLmjDkAGX-mBaySPnxp-mh2bPXaNh=b=dZ8wq9yeS2wRQ@mail.gmail.com>
Subject: Re: Re: [PATCH v2] Bluetooth: HIDP: add missing length check for
 incoming frames
To: jiale yao <19888972804@163.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Tim Bird <tim.bird@sony.com>, 
	Muhammad Bilal <meatuni001@gmail.com>, Kees Cook <kees@kernel.org>, 
	Michael Bommarito <michael.bommarito@gmail.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jul 19, 2026 at 1:38=E2=80=AFAM jiale yao <19888972804@163.com> wro=
te:
>
>
>
>
>
>
>
> In hidp_recv_ctrl_frame() and hidp_recv_intr_frame(), skb->data[0] is
> read without verifying that skb->len >=3D 1.  A zero-length L2CAP PDU
> delivered via the HIDP control or interrupt channel causes an
> out-of-bounds read.
>
> Use skb_pull_data(skb, 1) which combines the length check and pull
> in one operation, matching the existing pattern in hidp_input_report()
> and the fix in commit 6770d3a8acdf ("Bluetooth: bnep: reject short
> frames before parsing") which addressed the same class of bug in BNEP.
>
> Assisted-by: Claude:deepseek-v4-pro
> Signed-off-by: Jiale Yao <yaojiale02@163.com>
> ---
>  net/bluetooth/hidp/core.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
>
> diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
> index 0e24c5e2955e..bb61602b02e1 100644
> --- a/net/bluetooth/hidp/core.c
> +++ b/net/bluetooth/hidp/core.c
> @@ -560,16 +560,18 @@ static int hidp_process_data(struct hidp_session *s=
ession, struct sk_buff *skb,
>  static void hidp_recv_ctrl_frame(struct hidp_session *session,
>                                         struct sk_buff *skb)
>  {
> -       unsigned char hdr, type, param;
> +       unsigned char *hdr;
> +       unsigned char type, param;
>         int free_skb =3D 1;
>
>         BT_DBG("session %p skb %p len %u", session, skb, skb->len);
>
> -       hdr =3D skb->data[0];
> -       skb_pull(skb, 1);
> +       hdr =3D skb_pull_data(skb, 1);
> +       if (!hdr)
> +               return;

https://sashiko.dev/#/patchset/20260717153238.2002330-1-yaojiale02%40163.co=
m

It seems that by early returning we are leaking the skb.

>
> -       type =3D hdr & HIDP_HEADER_TRANS_MASK;
> -       param =3D hdr & HIDP_HEADER_PARAM_MASK;
> +       type =3D *hdr & HIDP_HEADER_TRANS_MASK;
> +       param =3D *hdr & HIDP_HEADER_PARAM_MASK;
>
>         switch (type) {
>         case HIDP_TRANS_HANDSHAKE:
> @@ -597,14 +599,15 @@ static void hidp_recv_ctrl_frame(struct hidp_sessio=
n *session,
>  static void hidp_recv_intr_frame(struct hidp_session *session,
>                                 struct sk_buff *skb)
>  {
> -       unsigned char hdr;
> +       unsigned char *hdr;
>
>         BT_DBG("session %p skb %p len %u", session, skb, skb->len);
>
> -       hdr =3D skb->data[0];
> -       skb_pull(skb, 1);
> +       hdr =3D skb_pull_data(skb, 1);
> +       if (!hdr)
> +               return;
>
> -       if (hdr =3D=3D (HIDP_TRANS_DATA | HIDP_DATA_RTYPE_INPUT)) {
> +       if (*hdr =3D=3D (HIDP_TRANS_DATA | HIDP_DATA_RTYPE_INPUT)) {
>                 hidp_set_timer(session);
>
>                 if (session->input)
> --
> 2.34.1
>
>
>
>
>
>
>
>
>
>
>
>
> At 2026-07-17 23:40:11, "Luiz Augusto von Dentz" <luiz.dentz@gmail.com> w=
rote:
> >Hi,
> >
> >On Fri, Jul 17, 2026 at 11:33=E2=80=AFAM Jiale Yao <yaojiale02@163.com> =
wrote:
> >>
> >> In hidp_recv_ctrl_frame() and hidp_recv_intr_frame(), skb->data[0] is
> >> read without verifying that skb->len >=3D 1.  A zero-length L2CAP PDU
> >> delivered via the HIDP control or interrupt channel causes an
> >> out-of-bounds read.
> >>
> >> Add pskb_may_pull(skb, 1) guards before both reads, matching the fix
> >> in commit 6770d3a8acdf ("Bluetooth: bnep: reject short frames before
> >> parsing") which addressed the same class of bug in BNEP.
> >>
> >> Assisted-by: Claude:deepseek-v4-pro
> >> Signed-off-by: Jiale Yao <yaojiale02@163.com>
> >> ---
> >>  net/bluetooth/hidp/core.c | 4 ++++
> >>  1 file changed, 4 insertions(+)
> >>
> >> diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
> >> index 0e24c5e2955e..6c7da8aca732 100644
> >> --- a/net/bluetooth/hidp/core.c
> >> +++ b/net/bluetooth/hidp/core.c
> >> @@ -565,6 +565,8 @@ static void hidp_recv_ctrl_frame(struct hidp_sessi=
on *session,
> >>
> >>         BT_DBG("session %p skb %p len %u", session, skb, skb->len);
> >>
> >> +       if (!pskb_may_pull(skb, 1))
> >> +               return;
> >
> >We can probably replace this with skb_pull_data.
> >
> >>         hdr =3D skb->data[0];
> >>         skb_pull(skb, 1);
> >>
> >> @@ -601,6 +603,8 @@ static void hidp_recv_intr_frame(struct hidp_sessi=
on *session,
> >>
> >>         BT_DBG("session %p skb %p len %u", session, skb, skb->len);
> >>
> >> +       if (!pskb_may_pull(skb, 1))
> >> +               return;
> >
> >Ditto.
> >
> >>         hdr =3D skb->data[0];
> >>         skb_pull(skb, 1);
> >>
> >> --
> >> 2.34.1
> >>
> >
> >
> >--
> >Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
