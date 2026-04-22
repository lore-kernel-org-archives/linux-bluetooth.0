Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E163EDAD4
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2026 14:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776869090; cv=pass; b=HUqoomoUmostmWxzfeRB9O/2lTB6xX2fWwicvtRpwgT2OeUG7Zwq/tTE3u1lQBUrP7g0J8dGmXT+QGHHM9VREM8wMxOuUC2PzN16Y+ktUuMTLQ6xcNB83BhoorJhPN6hb513fo6xMRlpnHposPWpEKdUIfwAF7FauS7V+67ssr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776869090; c=relaxed/simple;
	bh=v32TmCmNq/RD+F6k7dV0huH6idthcU99m+aMPZoi1hI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nmn6CK2q96R8C3ffw4Nn/Qwj46XabHvaCxTfLHnvSvGYu+bFH/B+AP3EnKIEPSKzEmOBX3OZ/zues1vJ5A+FPGNA4BS+MESCLPGMLVCyHG+Ebs3inw+e0egRFVGImVV+jw7u36LqV5sSn3erO7YsSdkXKlht7b1D1haHTFwDySg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gszs6oBd; arc=pass smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gszs6oBd"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-691de293326so3087623eaf.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2026 07:44:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776869086; cv=none;
        d=google.com; s=arc-20240605;
        b=dOxA4+7A7vl0fcEDGF3ecvq5i+/1UoHk8BsZNJJe/jgy4/L5zT5wgYPmbytzW/HTmi
         t6eVQMvz/RG0KGm7FGp9TEldKSHhVcJEA/cWRrJaxg+W+pMyToAXFiiI0CuNDAOHbA7d
         ojicStEbfUl8HMQd/gK7AHEKXFZpgCL647Mr0w4wPvlnd/xPcywGm9J2cXbCeTC0wwg8
         TrkLeUKIfHvMR8YDBsSOJoyP5Wv9MVYbwKoWYkXenIrTXCTOhA9ULhY/yZLIMZ2IdGea
         yS8PjfJBvX0gf9a+27NQA/+KDgWcmZqOZj9o+GMweJZxDA+Mlh2Ror03XNqKD066kh7+
         dzmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Gz6UAYat0RkKM4CbANaYAtGchON7PySza/VCdUZ5Dq0=;
        fh=6nuunKhVTlNJwshfnepq6h0amBWsBNdxbPzggSOqHxE=;
        b=fdtbnCZd2kBIdip7rgxOpzgw92JilYPSf/RYFYRDSFNsAjp+niUyQiqQB3VCYJZUjW
         cai1GQm9fd2T2h6/FHdl1tkN8bOgvWvoJ3BVOIZRKY3Rb3OmCCRjww6hGdUJmgRaEdNQ
         OquDFdQGj6cBNfowGjjru2TEc0Ddcd9DFFLirVDT1cQRNse2uYnQk32ZOY+1zfuCcy0i
         IWznQ+qP3oVivOeKb1Gksn/tACcu7lgHd6Rtm5DYfLtltgn0oOoxiuQ4lyN8P4juLBkl
         nxAlfbrNj/AKuF8rczirqR8I0tXio8scuuz5FPJfCFmd29wqjFAJQpAtxxHAgpT7tEkx
         lyHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776869086; x=1777473886; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gz6UAYat0RkKM4CbANaYAtGchON7PySza/VCdUZ5Dq0=;
        b=Gszs6oBdsdEDGRzRtwVGyl5CnB1kxrTxXrx6++WTfn7NOv/dckCHaTcJ+unt11wKTH
         wsHP+YFfATdFoWnOoGLZPnAavZPqtGhS/AzP0LlEQjtzVRPaa8/wFHgre0asUmabOEg5
         TvRuHcWhi23n0bWcyoLIEMc2we2z1YSuWAw78/ObmaSJPHpqsYWVC2cxHEcc0WJUHRKH
         eYKZ4TuVpAtH2iybcAaHC2ZpaogM6Dpdr6RDhwyt2H2ygGVTmf4W0ilpVwl48U8TD62J
         AfyYdN1tGo8v9PrsD9jmVTRDuDjQdTL36yYgRdYU0ulnvOWbABBtmb1vUt4AURd6QeTM
         IJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776869086; x=1777473886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gz6UAYat0RkKM4CbANaYAtGchON7PySza/VCdUZ5Dq0=;
        b=FxThFEISvrXvJQbNwV0OnjqAmm+cehvigaqvK1h76ee6ZEFz3ZiP8xbIFlLu9vzSeC
         gyVpyr2Vcqmr0SAf8BuSwFz0Xg6QGYwx5YliMdFFNQesBbjezqfKSeeDX/gZKH7LzP+t
         xxhiyiY57OLroy5r58uCIjPx0M4J1EMf/g/2UI8S/JToFWE5yiSbzTkva2ZYkNx9Ulbr
         Lu/h3bsvQMTdXzOuPvHLsoCp2RLFvyRp9HF21hYL9Ppwr66DAXVLG7lKeZlcm6BFYsZO
         3mLUfADV7KvzPJ9liIpXodOOgGBpw4kiOIu5QdoRmkErocL1t1cwocRiO7LQ948iAUSz
         tVSg==
X-Forwarded-Encrypted: i=1; AFNElJ8Gxx6RGm1tbRl/bvcwDJJE+OqOH6rbPkryFQPb9UXPyxKcHa4OpfW8M/Bpa35+/fPpPWz1D0c8wokGEwDzWRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAofLnuM6QFN3z9lO47qiSu80Oxpms94KL45LFzd+d7Ocy6kKt
	Q/jQ3XSffostb9B/YBg0hdq57f1oAe8/raKSowFBX8XFkE8wix9noIIWER6WfixfLZid2UZjpFV
	g7ZR+dpEe9T9apPNQAsQGBNh9TUbi8eU=
X-Gm-Gg: AeBDieu6fS56F1rn/ru/YlPkGlMGRRnWZJXlCVnVB7gy8uo1rc7QfnmmP8AUx+pm+D5
	XK+uIn6uYAza+jW9+m/a1N9Nu10+LyzJ2McxoqB1fkZEcdyfIgScscti+4IdckjzyvJExbYjyYh
	M56iQ4Z53f33Zh1r235dRUUANTs3e4Iat88euD6ji//75vJgFWkLaQ36vsrLtpSvLX5MOG5SHjb
	4AIHSJE80eGEW9s3zGshts70GGVtn5FKE0jele6YFsCvVtA7G8voG5+I2H3fNWXEFJqm8K4UCUm
	GEAx1jI4hkDnAvOddBm0aXTOHk1Oo7otIvrTxkuXmpr3yNMpKNo+4wRIATA4ZAqgqX9bK37Lnhv
	6lw==
X-Received: by 2002:a05:6820:220d:b0:689:7ad4:cba2 with SMTP id
 006d021491bc7-69462ed34c4mr12412601eaf.35.1776869086092; Wed, 22 Apr 2026
 07:44:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417221628.1674866-1-michael.bommarito@gmail.com>
 <CABBYNZ+f3pur4cSsanQ1kvv-yORp2E0qmVLt9si_+FnnJup4Ng@mail.gmail.com> <20260421135639.3185653-2-michael.bommarito@gmail.com>
In-Reply-To: <20260421135639.3185653-2-michael.bommarito@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 22 Apr 2026 10:44:34 -0400
X-Gm-Features: AQROBzBk-rigpQSaLKFocLT0t5YdnBlXkxlJCl3AdoKv2wzeySP57ww4q73Vi_c
Message-ID: <CABBYNZKS5Prm+BTkpdPgArgODTEDgHXLjecfux=3ZW0r2x=UXw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Bluetooth: L2CAP: handle zero txwin_size in ERTM
 RFC option
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Mat Martineau <martineau@kernel.org>, 
	Hyunwoo Kim <imv4bel@gmail.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Tue, Apr 21, 2026 at 9:56=E2=80=AFAM Michael Bommarito
<michael.bommarito@gmail.com> wrote:
>
> Peer-supplied ERTM RFC txwin_size =3D 0 can still propagate into the
> ERTM transmit-window state, and the same invalid value can be
> introduced locally through L2CAP_OPTIONS. In the request path that zero
> reaches l2cap_seq_list_init(..., 0); in the response path it can shrink
> ack_win to 0 and leave ERTM sequencing in a nonsensical state.
>
> Normalize zero tx window values back to L2CAP_DEFAULT_TX_WINDOW
> wherever they enter the ERTM state machine: local socket options,
> outgoing tx_win setup, incoming config requests, and config-response
> parsing. Also make l2cap_seq_list_free() clear its metadata after kfree
> so an init failure after freeing srej_list cannot be freed a second time
> during later channel teardown.
>
> Fixes: 3c588192b5e5 ("Bluetooth: Add the l2cap_seq_list structure for tra=
cking frames")
> Cc: stable@vger.kernel.org
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> Assisted-by: Claude:claude-opus-4-7
> ---
> Changes in v2:
> - drop the v1 `l2cap_seq_list_init(size =3D=3D 0) -> -EINVAL` approach
>   and instead normalize zero tx window values at the socket /
>   request / response inputs
> - clamp the local `L2CAP_OPTIONS` txwin_size =3D 0 case back to
>   `L2CAP_DEFAULT_TX_WINDOW`
> - make `l2cap_seq_list_free()` clear its metadata after `kfree()` so
>   later teardown cannot trip over a previously freed list
> - split the repeated `CONFIG_RSP` ERTM re-init fix into patch 2
>
>  net/bluetooth/l2cap_core.c | 23 +++++++++++++++++++----
>  net/bluetooth/l2cap_sock.c |  3 +++
>  2 files changed, 22 insertions(+), 4 deletions(-)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 95c65fece39b..7ffafd117817 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -345,6 +345,10 @@ static int l2cap_seq_list_init(struct l2cap_seq_list=
 *seq_list, u16 size)
>  static inline void l2cap_seq_list_free(struct l2cap_seq_list *seq_list)
>  {
>         kfree(seq_list->list);
> +       seq_list->list =3D NULL;
> +       seq_list->mask =3D 0;
> +       seq_list->head =3D L2CAP_SEQ_LIST_CLEAR;
> +       seq_list->tail =3D L2CAP_SEQ_LIST_CLEAR;
>  }
>
>  static inline bool l2cap_seq_list_contains(struct l2cap_seq_list *seq_li=
st,
> @@ -3234,8 +3238,15 @@ static void __l2cap_set_ertm_timeouts(struct l2cap=
_chan *chan,
>         rfc->monitor_timeout =3D cpu_to_le16(L2CAP_DEFAULT_MONITOR_TO);
>  }
>
> +static inline u16 l2cap_txwin_default(u16 txwin)
> +{
> +       return txwin ? txwin : L2CAP_DEFAULT_TX_WINDOW;
> +}
> +
>  static inline void l2cap_txwin_setup(struct l2cap_chan *chan)
>  {
> +       chan->tx_win =3D l2cap_txwin_default(chan->tx_win);
> +
>         if (chan->tx_win > L2CAP_DEFAULT_TX_WINDOW &&
>             __l2cap_ews_supported(chan->conn)) {
>                 /* use extended control field */
> @@ -3593,6 +3604,8 @@ static int l2cap_parse_conf_req(struct l2cap_chan *=
chan, void *data, size_t data
>                         break;
>
>                 case L2CAP_MODE_ERTM:
> +                       rfc.txwin_size =3D l2cap_txwin_default(rfc.txwin_=
size);
> +
>                         if (!test_bit(CONF_EWS_RECV, &chan->conf_state))
>                                 chan->remote_tx_win =3D rfc.txwin_size;
>                         else
> @@ -3715,7 +3728,8 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *=
chan, void *rsp, int len,
>                 case L2CAP_CONF_EWS:
>                         if (olen !=3D 2)
>                                 break;
> -                       chan->ack_win =3D min_t(u16, val, chan->ack_win);
> +                       chan->ack_win =3D min_t(u16, l2cap_txwin_default(=
val),
> +                                             chan->ack_win);
>                         l2cap_add_conf_opt(&ptr, L2CAP_CONF_EWS, 2,
>                                            chan->tx_win, endptr - ptr);
>                         break;
> @@ -3756,7 +3770,7 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *=
chan, void *rsp, int len,
>                         chan->mps    =3D le16_to_cpu(rfc.max_pdu_size);
>                         if (!test_bit(FLAG_EXT_CTRL, &chan->flags))
>                                 chan->ack_win =3D min_t(u16, chan->ack_wi=
n,
> -                                                     rfc.txwin_size);
> +                                                     l2cap_txwin_default=
(rfc.txwin_size));
>
>                         if (test_bit(FLAG_EFS_ENABLE, &chan->flags)) {
>                                 chan->local_msdu =3D le16_to_cpu(efs.msdu=
);
> @@ -3970,10 +3984,11 @@ static void l2cap_conf_rfc_get(struct l2cap_chan =
*chan, void *rsp, int len)
>                 chan->monitor_timeout =3D le16_to_cpu(rfc.monitor_timeout=
);
>                 chan->mps =3D le16_to_cpu(rfc.max_pdu_size);
>                 if (test_bit(FLAG_EXT_CTRL, &chan->flags))
> -                       chan->ack_win =3D min_t(u16, chan->ack_win, txwin=
_ext);
> +                       chan->ack_win =3D min_t(u16, chan->ack_win,
> +                                             l2cap_txwin_default(txwin_e=
xt));
>                 else
>                         chan->ack_win =3D min_t(u16, chan->ack_win,
> -                                             rfc.txwin_size);
> +                                             l2cap_txwin_default(rfc.txw=
in_size));
>                 break;
>         case L2CAP_MODE_STREAMING:
>                 chan->mps    =3D le16_to_cpu(rfc.max_pdu_size);
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index 71e8c1b45bce..3b53e967bf40 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -765,6 +765,9 @@ static int l2cap_sock_setsockopt_old(struct socket *s=
ock, int optname,
>                         break;
>                 }
>
> +               if (!opts.txwin_size)
> +                       opts.txwin_size =3D L2CAP_DEFAULT_TX_WINDOW;
> +
>                 if (!l2cap_valid_mtu(chan, opts.imtu)) {
>                         err =3D -EINVAL;
>                         break;
> --
> 2.53.0

This seems to be going sideways:

https://sashiko.dev/#/patchset/CABBYNZ%2Bf3pur4cSsanQ1kvv-yORp2E0qmVLt9si_%=
2BFnnJup4Ng%40mail.gmail.com

Patch 2/2 seems totally broken.

--=20
Luiz Augusto von Dentz
