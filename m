Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7154241695
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2026 00:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784678796; cv=pass; b=G3IuvmYrO03vf9b5uSYzlh0aMH4yx/el1Ufbhm1RN2oYXogfmFGFYPl3xab7mQjSgYoubp08DsQZaM4Q6nvaLfZOSyZkpK3gWRnoV6n/Dgk7x2WaYUhzque++YsknZL8bL9Z+IQ3REtQKuiwtlQTR6vGR7f3Ty/TC2KOk53WC3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784678796; c=relaxed/simple;
	bh=wMtYh10SKiiWG+RZaqeJCYVCugAbNzk3twBRkN577HM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DQTPHrXCmkFjCj3T/p6NILiLTioRE/9PrC0Fa5sj67FKYYajjwsyku1iHcZuZhqw8jK3GEP29ZYfT4hQSVE0o3dFGpORQjSV1i5xitxYNH6JunOJBkWR4FyLvr5eyPO46XLFbsv2Y80HPgQoU7LH7oeCD7ECckvd3kSCdvF1+V4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fb9AyN1q; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fb9AyN1q"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6983d3dae7aso8016842a12.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 17:06:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784678782; cv=none;
        d=google.com; s=arc-20260327;
        b=esf4Tw6InAkw4GOBr/E6wl8gH2t8eBmSkpU5l5onfosOPm/VMNj3n5EKyYW/gutdSs
         E2kzQ+GNggovkuiB7X/KScCBq2hIR6xoFsD89jyCAiAIaJGCFN4GpwUKk2swTNFZQZJj
         G20hB+7gDjqyuX3bu2ch/YZWb/FWSQGtPs9sK/5c9iDsipKzhsDIXjF60g7GHEhYsMdt
         WI+zUzaNOYiPbx5wA8G3oG6MgPKFVpdQGHzBm8XPSNCn/EsYxF8BcIoHDOKXA2bhSlu+
         pQlKnSdSuIIrN8+HfgRNJsWiLppDASNUssiBGHVeW3g7xwIBwDK2euvc9tNhtT7S1bXt
         A9sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=53PZrj75wts3n5Ecooubh+ftBN8lAgLD2BXECoxLQP4=;
        fh=ciTsz5tBK0j74K9T/JuOW0GmKKNxxEuB5TvkHDUZAFs=;
        b=gw8jvx6iQUjkmiTcIxklakkDE2nW2iun5+f+AULA+SWJ3fgUKFJZIAeNfLSrSIFZO3
         FidHEI35SA0bMOgqbBouj08AETY35FGl5mxUYEFGksByRS/dFYcM6E5hhe6iabWoNVaE
         x2XOfe7ZVE1Z+uiFln0qBKuD2HY4DrU6LDriqidsv01wTRajqA4ghdBDh9sdI1GOmbJr
         SuSH7GrkvNvZ/ASzr6C1WjpX/5X172aNeromkkctrkvsgx3Sz5tAP1ejlXL9wTwApQ9L
         FkN3oqyUFWx+8wFMikLLvuj79GbnkY2AnzVe4k4fQoFSYWaRXyhEgOSIiOptDJdM+vjM
         wVig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784678782; x=1785283582; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=53PZrj75wts3n5Ecooubh+ftBN8lAgLD2BXECoxLQP4=;
        b=fb9AyN1q46RppApAPkU+AB9OV5cnNsfeh3tfzJaYcwwsR/qJ2dGu/hokNKSwcGq7Ve
         L0sbN49MJDYQuYApndzG7cnQZYgw2EY6KbRVpOtdzMn4Tkkhnj2bwkM2x4yAlDJTT6ho
         c8It6sNpwdRFszey0QK5fDF0VsVhqexZo4u27mwKonsTBVvDPjfg36nU9hq20dqCTEYC
         QBG79S39AY7x58Lmc9jQauY0jGyfMSYBuqGnOtFWX0dRElxOjeA6veHHQlGAT2MqzFpu
         4MCqI351t7faGdQJ4ratLngALNwBAzGAGGLBHIKV/UkwaqFUaMfh+9f27P7GJ1j2HNKe
         UOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784678782; x=1785283582;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=53PZrj75wts3n5Ecooubh+ftBN8lAgLD2BXECoxLQP4=;
        b=soCMfJXGdasTRqrrKd6+Mi1yTN9U1OPGjF8dZgSi2Lgpkb2SD7Lb1XOT9rGhJC6TCQ
         1RiwnR6T2z7hTBdcCvGsvFWzSiIFtkLGXWHXxAzFv4y84uOHa89pcix843fFdWBUx/D8
         gnswxS2ICXHXMIgnayz4RCXR4Kz4146QC09XrTrgr8792nkXOYTjMrjtX+8fiziqDd/H
         8CFQMbaQCVMfnUxoin/szkrecsI2+uaVXGxxUzZOtQu9NCIG+uqH1Ptvn7lwrQngdr0+
         82WDNnzpvrDl6NNprHTVo+oMjqtdvQCIECDZOH0HVNzDlp7z1uixm3J52BUwYKhXEq8A
         HmHQ==
X-Forwarded-Encrypted: i=1; AHgh+RodBLL9wZxzIqxpPOSHnI/NIs9XAaGHI2yyHXdnJK0iUozdDGNkmCZO3f0zn0feaLkwNsAXcY0njLif+BtMnYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHYSpd/QsRXNqFoI5MTYc9bcxMMLt1Vr5AKNWmEG6f5/FhE0WU
	2EvrETBrT8XmaM5d4E2utfjly0JtOoh3aKTQbottMhE2ibtUm5ECLdyq2Br86XolT6YYJdFC37l
	413U3vwcLpf6oxoSwIekgfOkftoESW54=
X-Gm-Gg: AR+sD10+oVLjZl6z38d+nhrUA9g3beTvVte3mQ6b0pw37DmwBVozigrDoCCS4/NyYZD
	kQEEtUkXbdJ1SX8kgquKBdJdnxvHfE9KVUeoOQutHXi2xWTIpNM4Q2McjGqaXTdouXjuhNKO/J/
	H1NRfWiqVnMtz97vXT1koySSnh/UcAttlKONoIJyY3USOmrRn2pLHwmiJkq2d+9EoFhymJR8zjX
	Tdz5erfuas7gVJ14EOxOO1CWfWd9mJMIhfNE4zQVbJCv2v9EyUpONsdEe1uLn/i02StZhCvPDhx
	jOKCWhErMDdyDeTxsd6836FymeQ3f0ZguhhFHYwHvd4C92s=
X-Received: by 2002:a17:907:9729:b0:c1c:2253:7744 with SMTP id
 a640c23a62f3a-c1c31015facmr82467866b.16.1784678782275; Tue, 21 Jul 2026
 17:06:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717153238.2002330-1-yaojiale02@163.com> <CABBYNZJdEjqd2eKmQNvPodvifnPgVvih5fnFf5sdA7Kpi7T19w@mail.gmail.com>
 <220b6be5.d3f.19f78e165aa.Coremail.19888972804@163.com> <CABBYNZLmjDkAGX-mBaySPnxp-mh2bPXaNh=b=dZ8wq9yeS2wRQ@mail.gmail.com>
 <7930905e.40fa.19f833db829.Coremail.19888972804@163.com>
In-Reply-To: <7930905e.40fa.19f833db829.Coremail.19888972804@163.com>
From: Muhammad Bilal <meatuni001@gmail.com>
Date: Wed, 22 Jul 2026 05:06:04 +0500
X-Gm-Features: AUfX_mzWtsKF1d_UmZpPNa8IHVsANoTz84hdpZe2LlRTKMVWdA7eyGXYNKdh-9s
Message-ID: <CADqcGBmY9TW+yrG5a3R4_fG_P8Rr2wMJpZkFC87ea=nm2dh+2A@mail.gmail.com>
Subject: Re: Re: Re: [PATCH v3] Bluetooth: HIDP: add missing length check for
 incoming frames
To: jiale yao <19888972804@163.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Tim Bird <tim.bird@sony.com>, Kees Cook <kees@kernel.org>, 
	Michael Bommarito <michael.bommarito@gmail.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jiale,

Looks correct. Both goto failed paths free the skb properly now, and
the intr_frame goto also avoids a NULL hdr deref.

Reviewed-by: Muhammad Bilal <meatuni001@gmail.com>

Thanks,
Muhammad Bilal

On Tue, Jul 21, 2026 at 10:55=E2=80=AFAM jiale yao <19888972804@163.com> wr=
ote:
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
>  net/bluetooth/hidp/core.c | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
>
> diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
> index 0e24c5e2955e..e29fe66f01d4 100644
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
> +               goto failed;
>
> -       type =3D hdr & HIDP_HEADER_TRANS_MASK;
> -       param =3D hdr & HIDP_HEADER_PARAM_MASK;
> +       type =3D *hdr & HIDP_HEADER_TRANS_MASK;
> +       param =3D *hdr & HIDP_HEADER_PARAM_MASK;
>
>         switch (type) {
>         case HIDP_TRANS_HANDSHAKE:
> @@ -590,6 +592,7 @@ static void hidp_recv_ctrl_frame(struct hidp_session =
*session,
>                 break;
>         }
>
> +failed:
>         if (free_skb)
>                 kfree_skb(skb);
>  }
> @@ -597,14 +600,15 @@ static void hidp_recv_ctrl_frame(struct hidp_sessio=
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
> +               goto failed;
>
> -       if (hdr =3D=3D (HIDP_TRANS_DATA | HIDP_DATA_RTYPE_INPUT)) {
> +       if (*hdr =3D=3D (HIDP_TRANS_DATA | HIDP_DATA_RTYPE_INPUT)) {
>                 hidp_set_timer(session);
>
>                 if (session->input)
> @@ -616,9 +620,10 @@ static void hidp_recv_intr_frame(struct hidp_session=
 *session,
>                         BT_DBG("report len %d", skb->len);
>                 }
>         } else {
> -               BT_DBG("Unsupported protocol header 0x%02x", hdr);
> +               BT_DBG("Unsupported protocol header 0x%02x", *hdr);
>         }
>
> +failed:
>         kfree_skb(skb);
>  }
>
> --
> 2.34.1
>
>
>
>
>
>
>
> At 2026-07-21 03:47:21, "Luiz Augusto von Dentz" <luiz.dentz@gmail.com> w=
rote:
> >Hi,
> >
> >On Sun, Jul 19, 2026 at 1:38=E2=80=AFAM jiale yao <19888972804@163.com> =
wrote:
> >>
> >>
> >>
> >>
> >>
> >>
> >>
> >> In hidp_recv_ctrl_frame() and hidp_recv_intr_frame(), skb->data[0] is
> >> read without verifying that skb->len >=3D 1.  A zero-length L2CAP PDU
> >> delivered via the HIDP control or interrupt channel causes an
> >> out-of-bounds read.
> >>
> >> Use skb_pull_data(skb, 1) which combines the length check and pull
> >> in one operation, matching the existing pattern in hidp_input_report()
> >> and the fix in commit 6770d3a8acdf ("Bluetooth: bnep: reject short
> >> frames before parsing") which addressed the same class of bug in BNEP.
> >>
> >> Assisted-by: Claude:deepseek-v4-pro
> >> Signed-off-by: Jiale Yao <yaojiale02@163.com>
> >> ---
> >>  net/bluetooth/hidp/core.c | 21 ++++++++++++---------
> >>  1 file changed, 12 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
> >> index 0e24c5e2955e..bb61602b02e1 100644
> >> --- a/net/bluetooth/hidp/core.c
> >> +++ b/net/bluetooth/hidp/core.c
> >> @@ -560,16 +560,18 @@ static int hidp_process_data(struct hidp_session=
 *session, struct sk_buff *skb,
> >>  static void hidp_recv_ctrl_frame(struct hidp_session *session,
> >>                                         struct sk_buff *skb)
> >>  {
> >> -       unsigned char hdr, type, param;
> >> +       unsigned char *hdr;
> >> +       unsigned char type, param;
> >>         int free_skb =3D 1;
> >>
> >>         BT_DBG("session %p skb %p len %u", session, skb, skb->len);
> >>
> >> -       hdr =3D skb->data[0];
> >> -       skb_pull(skb, 1);
> >> +       hdr =3D skb_pull_data(skb, 1);
> >> +       if (!hdr)
> >> +               return;
> >
> >https://sashiko.dev/#/patchset/20260717153238.2002330-1-yaojiale02%40163=
.com
> >
> >It seems that by early returning we are leaking the skb.
> >
> >>
> >> -       type =3D hdr & HIDP_HEADER_TRANS_MASK;
> >> -       param =3D hdr & HIDP_HEADER_PARAM_MASK;
> >> +       type =3D *hdr & HIDP_HEADER_TRANS_MASK;
> >> +       param =3D *hdr & HIDP_HEADER_PARAM_MASK;
> >>
> >>         switch (type) {
> >>         case HIDP_TRANS_HANDSHAKE:
> >> @@ -597,14 +599,15 @@ static void hidp_recv_ctrl_frame(struct hidp_ses=
sion *session,
> >>  static void hidp_recv_intr_frame(struct hidp_session *session,
> >>                                 struct sk_buff *skb)
> >>  {
> >> -       unsigned char hdr;
> >> +       unsigned char *hdr;
> >>
> >>         BT_DBG("session %p skb %p len %u", session, skb, skb->len);
> >>
> >> -       hdr =3D skb->data[0];
> >> -       skb_pull(skb, 1);
> >> +       hdr =3D skb_pull_data(skb, 1);
> >> +       if (!hdr)
> >> +               return;
> >>
> >> -       if (hdr =3D=3D (HIDP_TRANS_DATA | HIDP_DATA_RTYPE_INPUT)) {
> >> +       if (*hdr =3D=3D (HIDP_TRANS_DATA | HIDP_DATA_RTYPE_INPUT)) {
> >>                 hidp_set_timer(session);
> >>
> >>                 if (session->input)
> >> --
> >> 2.34.1
> >>
> >>
> >>
> >>
> >>
> >>
> >>
> >>
> >>
> >>
> >>
> >>
> >> At 2026-07-17 23:40:11, "Luiz Augusto von Dentz" <luiz.dentz@gmail.com=
> wrote:
> >> >Hi,
> >> >
> >> >On Fri, Jul 17, 2026 at 11:33=E2=80=AFAM Jiale Yao <yaojiale02@163.co=
m> wrote:
> >> >>
> >> >> In hidp_recv_ctrl_frame() and hidp_recv_intr_frame(), skb->data[0] =
is
> >> >> read without verifying that skb->len >=3D 1.  A zero-length L2CAP P=
DU
> >> >> delivered via the HIDP control or interrupt channel causes an
> >> >> out-of-bounds read.
> >> >>
> >> >> Add pskb_may_pull(skb, 1) guards before both reads, matching the fi=
x
> >> >> in commit 6770d3a8acdf ("Bluetooth: bnep: reject short frames befor=
e
> >> >> parsing") which addressed the same class of bug in BNEP.
> >> >>
> >> >> Assisted-by: Claude:deepseek-v4-pro
> >> >> Signed-off-by: Jiale Yao <yaojiale02@163.com>
> >> >> ---
> >> >>  net/bluetooth/hidp/core.c | 4 ++++
> >> >>  1 file changed, 4 insertions(+)
> >> >>
> >> >> diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
> >> >> index 0e24c5e2955e..6c7da8aca732 100644
> >> >> --- a/net/bluetooth/hidp/core.c
> >> >> +++ b/net/bluetooth/hidp/core.c
> >> >> @@ -565,6 +565,8 @@ static void hidp_recv_ctrl_frame(struct hidp_se=
ssion *session,
> >> >>
> >> >>         BT_DBG("session %p skb %p len %u", session, skb, skb->len);
> >> >>
> >> >> +       if (!pskb_may_pull(skb, 1))
> >> >> +               return;
> >> >
> >> >We can probably replace this with skb_pull_data.
> >> >
> >> >>         hdr =3D skb->data[0];
> >> >>         skb_pull(skb, 1);
> >> >>
> >> >> @@ -601,6 +603,8 @@ static void hidp_recv_intr_frame(struct hidp_se=
ssion *session,
> >> >>
> >> >>         BT_DBG("session %p skb %p len %u", session, skb, skb->len);
> >> >>
> >> >> +       if (!pskb_may_pull(skb, 1))
> >> >> +               return;
> >> >
> >> >Ditto.
> >> >
> >> >>         hdr =3D skb->data[0];
> >> >>         skb_pull(skb, 1);
> >> >>
> >> >> --
> >> >> 2.34.1
> >> >>
> >> >
> >> >
> >> >--
> >> >Luiz Augusto von Dentz
> >
> >
> >
> >--
> >Luiz Augusto von Dentz
