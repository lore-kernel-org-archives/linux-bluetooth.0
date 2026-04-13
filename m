Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199DF346AE8
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 18:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776104376; cv=pass; b=RKAw5OsI3eI/ASjQMhxf5naxel4R/VsTuQ7gra+xqcahxtVqoooir2KhIc9fqEnQ3pAGQuo+C6xtAmqrALGucCtMcPapvbZFwjvWQbSB8e/7Dy2eiKCHP8zKYXIJzAGgskyQ6WYtMV2KrWsf9BY9I1ieA6n08S2h5mnVepORfzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776104376; c=relaxed/simple;
	bh=jbJqRR1YggZpnI4Rc4S8uGMd7E1QTdhbpbMxNX8edgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IXM0dOjo/BvPcW0pNDTgDJH+pLspzmZ+FRmTilWMvQp2mu9imc69iDdWOTKlVRqB5oBCSy8bh8dcQkDQAw3ZK8ssjLFV2OpD2IDpDBn/SbCIVoSN3UeeUfYMTeBR3AhUROChKAifl58FdlU+bV2IGvE3NvgjVQaFg+oGvi0GjFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nymLOk9x; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nymLOk9x"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-651cfaa21e6so1115870d50.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 11:19:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776104370; cv=none;
        d=google.com; s=arc-20240605;
        b=ZZpHbhnRrVnoKIs0KoD46/pKS/uiPLwyTWeHcyjNoU5mTEgR2L6AsBFMeCwD2Wd985
         Y65VnRK0TqVnGHE88qPO0ygfe5tCEV1DLBb6MtaInJ953ZZFYlkEtCtuAzD2LoQsfCbA
         OOVtJRGEjEQx4V6R9hkCwxdB7Sb/jhcsBRRcAVcNKCG/I8kN78y3EgYhZ/nGvbmPfTgw
         HO/Vmyu88IGEIGUCvE44buSygFlHVceeTco8zRALuyYot0lzz1rzsBN1CZUV8J8z55h7
         D7jGBL7MFB7v3haQMx9rmU1GwsuYtXZbutmn3ptjvaZ193yoBARC1dRupIR8yEwJPX7/
         Nuxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XkKaFNaC9wRHn8yqUTeYtI/J85nYir4G+jZWgcFegT8=;
        fh=KzYNgbEMxzQX+tb27lzLJzdc0V45Ib+eXP4A3ZLTCfY=;
        b=EpY2Ho3F+UzjVY3PteBQe918k5UqFgpfwUKF0D5IbeLOYoD9gaKOtCqzEKRy+VQR83
         QSvuMImbbqtzvQZnmaGebO0Dqa4ZkGXVEbbZQPD8Ieh8E+btynAXYKdUKzzzOptPt+fK
         VxpneEYPnwfcfabkPOUfEvp3z3YiAsjSIqM5oIAGOnusY/NOJPkDPvbGx5l6nOqBt3en
         zxOXGdIRz9EzumaUZeU7H8mOa/x9D6WibkNmR4hoqOieaSPt2lxFB4QANXmryGrmpoZk
         AQRJ5xjsO5w3wl1v2zQNp3ENeVZ4pzoNIIHYeHmngGgyvG+QxbwR3e3KxU9wHM5FtJdH
         OHLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776104370; x=1776709170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XkKaFNaC9wRHn8yqUTeYtI/J85nYir4G+jZWgcFegT8=;
        b=nymLOk9xLAgsKbBrnLklVl6a1haIUBSbzM1WfilAxZ9LsoOVgvf6LZr6t6fT6yTZVd
         sLQLsm13Sr2LTCiVlqTzkV1Fw9UYZhPPWKyIkc5p8X5ldbtW8Lrmr4jvFgfxiwlZefwv
         2hODVBZRNmUVKbKhQ+/HPmZP/wHFRS623MVzkM7GCGbSOF/hVrgyc93CcZ/Pp+DDl84a
         K6oHVLTU4lACiRtTz+4dEr9eMaCgHVB/6lFF1TzkRsxdniXrJ+8f86nBreVUG1DKXkrv
         7ImKsLddNTDqnEtkucraliGoaPRBQvKHudHVeLXu3vz74QwEumBpMxqPbzBttR6E1kLu
         TYxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776104370; x=1776709170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XkKaFNaC9wRHn8yqUTeYtI/J85nYir4G+jZWgcFegT8=;
        b=SpeHi7GXQB2m1/6ip8+MLyzgk2t+rXXoW/KEhBcJqSEaCB8N4DneSH4LVeDopKe+zf
         +71u1L9JXPOmDPxfDiv58IhrMImzUzpWOzPppFIzWhKQMSv4aNo6/LEKY+r8CwZt56Dw
         N8XZJ2M71ACt57QHINBOizKOmL0S9UCa92/zQg2toiqPibTAnoTRoiuKSOggMJ/sHEIb
         +IBEyLlZmYBCGB8oHxj+Vrx/IYfV9qfHs/yqEQDnEBmSdsdig1F7xV/BMU8LKx+m7KS4
         ojx/K4ktyKp3AFT3JTNpgEmc3RDjb61seMPn6gslwof9O9FqUURN17AVge3U7VWrkCYD
         EBLA==
X-Gm-Message-State: AOJu0Ywm/IDnia0/7vtx3UmV09hiWvt/b/qv/xSbFpKgs4r2UIMKugeU
	VR7JZXDJGIZsnCZ1Oaj8r5A85bfmEsmoyKZtUwTTu6GwwLjaYortwuRy/hd7NuDla29k9dNp8Qz
	HDjdHaFott+b9g4AKbqpxc/swuyb5HBo=
X-Gm-Gg: AeBDiesLX1H4x/6A4aV6GF4CU7rbw8/8yrhGInJcmc26c+UOW8rR8FKeck/4f6g7/B2
	rDQF9ltFT4YbJu0haiSButvDYG0YKLTtDlp5/p04h3ai1/Lbrlatyyg1C+opsW/BRP53oi3h8p0
	D9k99nlKEAo/vA/JS1jycD+Va9nJh0D4DNagiEynZMRrvgyT3nKtIazsIaq2mPuERhiCTBHE51p
	5VXmW8LevDl0lNPKAG4RAXRSmyqCc+hHCT0CNX4O9yTxisNP5siKMfyBDV5/NfjhhPY9Bjcar8a
	Iqj72a/RWdlgs2AWtWt7/fTQFxzDQRSr1nxfo29Lptx8HOaI21r8PjTKDHPlfQrKtDRvkEqvRNE
	6mBMg
X-Received: by 2002:a05:690e:151b:b0:650:3124:b8c9 with SMTP id
 956f58d0204a3-6519905ad2emr9242035d50.20.1776104370232; Mon, 13 Apr 2026
 11:19:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260412045457.53100-1-suunj1331@gmail.com>
In-Reply-To: <20260412045457.53100-1-suunj1331@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 13 Apr 2026 14:19:18 -0400
X-Gm-Features: AQROBzCdKwpPui8YqC4XYEkRd6Gjs6_0AK6EB80Qj12VEVPJMNFfoS1gMurMSa0
Message-ID: <CABBYNZJVasjYjX-Jq0rPCTVPruBOYevUgxVtPsRfLUX1VJtiSw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: RFCOMM: validate skb length in MCC handlers
To: SeungJu Cheon <suunj1331@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, kees@kernel.org, 
	kuba@kernel.org, me@brighamcampbell.com, shuah@kernel.org, 
	linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Apr 12, 2026 at 12:55=E2=80=AFAM SeungJu Cheon <suunj1331@gmail.com=
> wrote:
>
> rfcomm_recv_pn(), rfcomm_recv_rpn(), rfcomm_recv_rls(), and
> rfcomm_recv_msc() cast skb->data to their respective structs
> without first checking skb->len. A remote device can send a
> short MCC frame, causing out-of-bounds reads from the skb buffer.
>
> For rfcomm_recv_pn(), the uninitialized pn->mtu value is stored
> in d->mtu via rfcomm_apply_pn(), then echoed back to the remote
> device in the PN response, leaking kernel heap data.
>
> This results in use of uninitialized memory, as reported by KMSAN.
>
> Add explicit skb->len checks against the expected structure size
> at the start of each handler before accessing the payload.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> BUG: KMSAN: uninit-value in rfcomm_run+0x7eae/0xee90
>  rfcomm_run+0x7eae/0xee90
>  kthread+0x53f/0x600
>  ret_from_fork+0x20f/0x910
>  ret_from_fork_asm+0x1a/0x30
>
> Uninit was created at:
>  kmem_cache_alloc_node_noprof+0x3cd/0x12d0
>  __alloc_skb+0x855/0x1190
>  vhci_write+0x125/0x960
>  vfs_write+0xbe1/0x15c0
>  ksys_write+0x1d9/0x470
>  __x64_sys_write+0x97/0xf0
>  x64_sys_call+0x2ff0/0x3ea0
>  do_syscall_64+0x134/0xf80
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> CPU: 0 UID: 0 PID: 3374 Comm: krfcommd Tainted: G        W           7.0.=
0-rc7
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
> Kernel panic - not syncing: kmsan.panic set ...
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>
> ---
>  net/bluetooth/rfcomm/core.c | 40 +++++++++++++++++++++++++++++--------
>  1 file changed, 32 insertions(+), 8 deletions(-)
>
> diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
> index 611a9a94151e..daeba71a1514 100644
> --- a/net/bluetooth/rfcomm/core.c
> +++ b/net/bluetooth/rfcomm/core.c
> @@ -1431,9 +1431,15 @@ static int rfcomm_apply_pn(struct rfcomm_dlc *d, i=
nt cr, struct rfcomm_pn *pn)
>
>  static int rfcomm_recv_pn(struct rfcomm_session *s, int cr, struct sk_bu=
ff *skb)
>  {
> -       struct rfcomm_pn *pn =3D (void *) skb->data;
> +       struct rfcomm_pn *pn;
>         struct rfcomm_dlc *d;
> -       u8 dlci =3D pn->dlci;
> +       u8 dlci;
> +
> +       if (skb->len < sizeof(*pn))
> +               return -EINVAL;
> +
> +       pn =3D (void *) skb->data;
> +       dlci =3D pn->dlci;

How about using skb_pull_data?

>         BT_DBG("session %p state %ld dlci %d", s, s->state, dlci);
>
> @@ -1483,8 +1489,8 @@ static int rfcomm_recv_pn(struct rfcomm_session *s,=
 int cr, struct sk_buff *skb)
>
>  static int rfcomm_recv_rpn(struct rfcomm_session *s, int cr, int len, st=
ruct sk_buff *skb)
>  {
> -       struct rfcomm_rpn *rpn =3D (void *) skb->data;
> -       u8 dlci =3D __get_dlci(rpn->dlci);
> +       struct rfcomm_rpn *rpn;
> +       u8 dlci;
>
>         u8 bit_rate  =3D 0;
>         u8 data_bits =3D 0;
> @@ -1495,6 +1501,12 @@ static int rfcomm_recv_rpn(struct rfcomm_session *=
s, int cr, int len, struct sk_
>         u8 xoff_char =3D 0;
>         u16 rpn_mask =3D RFCOMM_RPN_PM_ALL;
>
> +       if (skb->len < sizeof(*rpn))
> +               return -EINVAL;
> +
> +       rpn =3D (void *) skb->data;
> +       dlci =3D __get_dlci(rpn->dlci);

Ditto

>         BT_DBG("dlci %d cr %d len 0x%x bitr 0x%x line 0x%x flow 0x%x xonc=
 0x%x xoffc 0x%x pm 0x%x",
>                 dlci, cr, len, rpn->bit_rate, rpn->line_settings, rpn->fl=
ow_ctrl,
>                 rpn->xon_char, rpn->xoff_char, rpn->param_mask);
> @@ -1589,8 +1601,14 @@ static int rfcomm_recv_rpn(struct rfcomm_session *=
s, int cr, int len, struct sk_
>
>  static int rfcomm_recv_rls(struct rfcomm_session *s, int cr, struct sk_b=
uff *skb)
>  {
> -       struct rfcomm_rls *rls =3D (void *) skb->data;
> -       u8 dlci =3D __get_dlci(rls->dlci);
> +       struct rfcomm_rls *rls;
> +       u8 dlci;
> +
> +       if (skb->len < sizeof(*rls))
> +               return -EINVAL;
> +
> +       rls =3D (void *) skb->data;
> +       dlci =3D __get_dlci(rls->dlci);

Ditto

>         BT_DBG("dlci %d cr %d status 0x%x", dlci, cr, rls->status);
>
> @@ -1608,9 +1626,15 @@ static int rfcomm_recv_rls(struct rfcomm_session *=
s, int cr, struct sk_buff *skb
>
>  static int rfcomm_recv_msc(struct rfcomm_session *s, int cr, struct sk_b=
uff *skb)
>  {
> -       struct rfcomm_msc *msc =3D (void *) skb->data;
> +       struct rfcomm_msc *msc;
>         struct rfcomm_dlc *d;
> -       u8 dlci =3D __get_dlci(msc->dlci);
> +       u8 dlci;
> +
> +       if (skb->len < sizeof(*msc))
> +               return -EINVAL;
> +
> +       msc =3D (void *) skb->data;
> +       dlci =3D __get_dlci(msc->dlci);

Ditto.

>         BT_DBG("dlci %d cr %d v24 0x%x", dlci, cr, msc->v24_sig);
>
> --
> 2.52.0
>


--=20
Luiz Augusto von Dentz
