Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AB82D73A0
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 15:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784302825; cv=pass; b=XrE8Y9VtIyoVrReLPTppCd8b96KGDJmbRKAniP+GDrDgqkRZwFCJ/3kf4Bm/FP+X9wrpMkAf4QPGHXdhPGjaCV131PXWEOd3ek+MHGg03tMi/uNCfbWA4C7M2SB9Po4rAM+FifKI2i3WrHe5fPYUUOmpg8L6WTcgFGR6oLBsqfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784302825; c=relaxed/simple;
	bh=AFo5kLLW8flrz9VNDmtBh07/uM3Kc6Uh9pkLYM97mKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GVLk5HTL8aVKFCyiMQ/oz0llbaJYTdPZpbyg6ncOUspsWiNq55SW/9xxbq8vy2zy6ySwiKScxqckBaFhtIW/BVrF7Aa8indkPRM7cpnhGqHXbe7yM2YJE8KpWXrCWhu5XQZeX2tQNawTzDSbpH+9t6ZtXXkyKDeYPXwlGVjmup8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CtpR8VYr; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CtpR8VYr"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-81eaf3709b4so56035147b3.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 08:40:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784302822; cv=none;
        d=google.com; s=arc-20260327;
        b=dCFrY/qAdwHZNWg9V2+UalhgeYXJu8Th8lDa9RY5yfCGj2p5Dnxk3o2yBNuMawLVJO
         whbstXC2FJmR20A1gemuAPMTUbBxYvkWBzCnagk9ffhvgBfkuQ23NHNGBXT5DTppyGAA
         5QE/LUPEO5qO3CMOwJph0PMncsa7dI/y5qd3HcGi/B5uKOSHHwciEwtuc4bzpGk2LzDL
         zA7bCTLQiz/lfxQ2vV9BSDVtQ22J3AC8i0j7yLJa29eiTFW+gIfwNmjPReRRB4cFf7Ks
         G+QtWUb+nlHvj6Ft+kTZyBgQRaiCelZrgFGgRUk0MJtWPmZsFVzcaaIEVb+EzFlUYGP5
         bF+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TLOe0uQw1SbLg/aiA+B7xsb1mAQuV0hty3B7/SGXTbo=;
        fh=sdvLDxMYW9Mo2nSFc8XDk8YEjz60EkfzYvrAOtgI4cQ=;
        b=QvJ2bdbe2YfU6p2UyaVD0lqLBX4p4i+Il19FBTXKTgfNcLz3XHMjfns350fi+bSy4y
         87EiZ+taTZZ6CAt5oCOWsZTiG/pVqnOuntmJbSY4CJy6ah+f5plZQ33t+0HwlPfIFGIj
         dpiyEUINAQv8epBe6+04/AGEbtq9ZV7mesJnxLA56A8w+MYNRv4IFYWYa8oHk/p/QlMD
         ncG5ueOUMXg+S+FEuqnPiSuhnVUPPg4Ox3Hv2dCeXGnnBctsGsdbGy2N9+WiBzK8M23q
         f1OSAQ8w/1xefZQS/oGYl+BYB0wIziG5b3ec3sN8oKzAR+VN3bVHuXDk1lM/5wCVX58e
         3IgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784302822; x=1784907622; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TLOe0uQw1SbLg/aiA+B7xsb1mAQuV0hty3B7/SGXTbo=;
        b=CtpR8VYrPmfP6iDnOyzWHeGpIdom9F9ER+ed8I9MTpM39iSMv/TzU5/BxK/+BS6Q/R
         Wm7ClZBp5dcc9bOhlgo2UoMD9RD2+orJBuymdVc/0N2r6yAfeavz+IPSjg2bHTDK4dpO
         kQkzeYvW8nl0n4YfFH660nCRiKzn3BePyA+yNkJ6ZN90/CckMah9T2rOUvNem1FeUvqd
         0US4BSOiGGJHr9mwOnUyGjKdAQQn3lwRR/VuYSYxLbhGSNrnZh0lVetlt983OHwno9Tf
         CEMNGr4gWCWXtKq2UGTiBsRwoVMxMRQ9PWipy3OBm3k6oTDBXmxw6WMFdJZkTPfWabuO
         uNHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784302822; x=1784907622;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TLOe0uQw1SbLg/aiA+B7xsb1mAQuV0hty3B7/SGXTbo=;
        b=EDJWQxpBmqUl2ExqTXBiJtEYEZ2ftme1WmBFmR46fl//hcZ17QYKnkg3I+HwXthtZ0
         xqtmSF1Xs4KsWlImuR/BuY5VGZPCegdZ1nYKGX0SVG8PU4s8ijhnfJQmE4ZnNhU5PHHv
         ZtmR/yqqucDkH+nral+u1CJDe0VlLBbgVTq5SAPyTdfXTszIA9BSxKCawEg2kbM9ZDPP
         y3FzuhzRKFRV+sHiBtgJ2phvAeA061vqFo1OKI9pJHr4txOq2TzVzrdM9wFRqezWozuV
         g0hHJ43o/z9tYKbqIZsIblY2KVDUlG/+nOCM8aix0R13RzINouY5yPvz2+LllWOgQS1i
         m7wg==
X-Forwarded-Encrypted: i=1; AHgh+RpnUPO3N+3Fw48OjPd6pkf2RC2XC20XozxR1PTTLg1NFsM7AZLlc+NG1rfRCvILh+mGe1Nr9V+g+o8ThBCXqGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHWwUfsLRka13gfbr9M6WO2pIHGNjUj9SRgbLOXn/VMPHfKPAR
	VvzQ4LshOaK05/J7vNjwWlYuVR4dzjQrjAsT6F0f6tf2NHTTmmfI0QkVsr28FPbralqRee5pgT1
	ymXU15aEf9ZEFJxv9wiDXqVEB8GFX6Pk=
X-Gm-Gg: AfdE7cm9WBuW+6r3cjSVlM06fXiiVJ3nWi2TzN/JE8y6ijyr3hgrXiWTDukDYoLnMNQ
	xeJSswyCMVr/O7p6uyJSpaYXP5/JKeAxAHm44/k1pEACI7Ok8Qf27SoeIhve3G5Hl6VsnNfPCNF
	KgeGuUw9h889N2E7NRuyjmiYMWr/nJi4JDHKkRbF2U6G+IlftApE+FveoJklKCV7ym7kJUURWHT
	38sCwIL3GbhJXh/1wKRtPnseNqzuV+IxsgdTaOsku2NTY6+SgJWtGOly32vgu2HNyKIHN+G5jRi
	Jy57MDcu7d7WFxVzZh7dLy6wPVV4b/v1Ts+YVnCsX9ZsvMnK
X-Received: by 2002:a05:690c:4913:b0:814:6dc6:114e with SMTP id
 00721157ae682-81ef2714e84mr10054577b3.25.1784302822461; Fri, 17 Jul 2026
 08:40:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717153238.2002330-1-yaojiale02@163.com>
In-Reply-To: <20260717153238.2002330-1-yaojiale02@163.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 17 Jul 2026 11:40:11 -0400
X-Gm-Features: AUfX_mxBJft8OdJyn4U4b-yx5jgmrpeYHKXN9Q7QSYWrl50S_060lXTDgb21iJk
Message-ID: <CABBYNZJdEjqd2eKmQNvPodvifnPgVvih5fnFf5sdA7Kpi7T19w@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: HIDP: add missing length check for incoming frames
To: Jiale Yao <yaojiale02@163.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Tim Bird <tim.bird@sony.com>, 
	Muhammad Bilal <meatuni001@gmail.com>, Kees Cook <kees@kernel.org>, 
	Michael Bommarito <michael.bommarito@gmail.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 17, 2026 at 11:33=E2=80=AFAM Jiale Yao <yaojiale02@163.com> wro=
te:
>
> In hidp_recv_ctrl_frame() and hidp_recv_intr_frame(), skb->data[0] is
> read without verifying that skb->len >=3D 1.  A zero-length L2CAP PDU
> delivered via the HIDP control or interrupt channel causes an
> out-of-bounds read.
>
> Add pskb_may_pull(skb, 1) guards before both reads, matching the fix
> in commit 6770d3a8acdf ("Bluetooth: bnep: reject short frames before
> parsing") which addressed the same class of bug in BNEP.
>
> Assisted-by: Claude:deepseek-v4-pro
> Signed-off-by: Jiale Yao <yaojiale02@163.com>
> ---
>  net/bluetooth/hidp/core.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
> index 0e24c5e2955e..6c7da8aca732 100644
> --- a/net/bluetooth/hidp/core.c
> +++ b/net/bluetooth/hidp/core.c
> @@ -565,6 +565,8 @@ static void hidp_recv_ctrl_frame(struct hidp_session =
*session,
>
>         BT_DBG("session %p skb %p len %u", session, skb, skb->len);
>
> +       if (!pskb_may_pull(skb, 1))
> +               return;

We can probably replace this with skb_pull_data.

>         hdr =3D skb->data[0];
>         skb_pull(skb, 1);
>
> @@ -601,6 +603,8 @@ static void hidp_recv_intr_frame(struct hidp_session =
*session,
>
>         BT_DBG("session %p skb %p len %u", session, skb, skb->len);
>
> +       if (!pskb_may_pull(skb, 1))
> +               return;

Ditto.

>         hdr =3D skb->data[0];
>         skb_pull(skb, 1);
>
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
