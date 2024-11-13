Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44C31632E3
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Nov 2024 16:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731515012; cv=none; b=lT2JFztCb8Sl5rXmv/SK43WpUxv93Uwm79yasxpMuve0xC5P/WRAcYPItv2sP/gB2Yn7ytwaTd7sU6QWJjjHbuNh3gqSF2wbuovl4B2iiieZI2mN/B4Yf/L/8D6XTqnmrmdrDd+3hmTLTSFTvATJuR8a83rMBLPO5D06BzR98zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731515012; c=relaxed/simple;
	bh=ut1rOtVFQw1mkh3d/DspwnRJTOe02Iyge/mnhV5W2VI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IyWENXaY0cL6LZP2J9Qk/9ZrPBjy6JpCX8WxgKhotp0QP/7n/wslwZ8ekrWGcOUwBYIwgmGzCb3pKIM7f84jnBy84ziLmoZvKz1Rdrf8AkOPlEJbEx5VrrvNtvhCuvoPcdjFfRuSc8cZroDWL/7hbbLp/9W0I00d5UjgpIxMgrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BRYpoF6e; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRYpoF6e"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fb5fa911aaso97456661fa.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Nov 2024 08:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731515009; x=1732119809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IXInHd7VD8gtgLXVBlRzh7W0vbq2MFWqbJMEpOB9XSc=;
        b=BRYpoF6ei5bDq0ef9pVwizGr3cQNTEM5uNE1S2iy8oq5jPupVg2ffLDMUCR7KN3sSV
         Hh5GZ5fpRJ5968L9FBLIrXJye97jWbE2Yd2e1GYDkF3hl4fhAyIYIEQaPXIdMHp5flG5
         cTU8TEMG2NzMMtXYLrTh468gt6BTQrWTdp3Ud1mSURx8gIU1sSmn9ctkFZsTx7Ufst3d
         hkBLQrsDVf5eSiQbDk4Cg+TDw096R1x9hsrzXXkzqzVnlmJfUSLlqaUi4NujkiuNqsgA
         lMQiSZvFYRmuq6POJj+jpr9u7j3e/3/VKyQ37yM3YSvL/3EvKdc1/IIgleFUVnzKQBfG
         sSBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731515009; x=1732119809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IXInHd7VD8gtgLXVBlRzh7W0vbq2MFWqbJMEpOB9XSc=;
        b=rNNRZHfv6Nmq9DmwNRdkch2cY4DmiwjLg48pfefEGOexYR3BvX09wEjzqPmwD/ZuZX
         gCzmcFGP4vSB55K7GmHKnN49PQm758agS/QrK5V8uROzHUhkQPMdfTOgn26Oa/SCJfgq
         zVFeBRf0EayLQKZHBPNL5GBqk/jwOHPyAqllGPc7Adv1BhiK2xUvn6lMEwgym1SBvNoK
         4JxyWTHYXSQwZcUb2RUzZxUt46Bjv3SVdT7z0+1jmscZwtv33w4aZKIre5JNbA0Y5jfN
         J+E7piDWbq5D9hSEW790LDi28XEjxtK3b7pz4O5LfRrE+npC92gCqgefAjC2D+4yVTzA
         9pFQ==
X-Gm-Message-State: AOJu0YyLSSMySdU9RfBjlNc7scHgfxC0RLcR1btAFCFApUMfPW+lNblh
	+0sPySuZPec44fEYAvf6DDjKxV+aGjxxpKQEyrZ81C6UDBcBKp44UrodenoS0DVh39fuPAKHmkK
	X+RLuVtc5T5lZ/NAcdyFeU/g7GEfKIw==
X-Google-Smtp-Source: AGHT+IHI5NGCQ84Oit2/eyiNuY2+KQXLTtZudf42ksV32ghcu8kmT5gPvpU4/+kY2g67cpeCy3K6yx82XeOozKsgTfY=
X-Received: by 2002:a05:651c:1551:b0:2fc:9674:60b5 with SMTP id
 38308e7fff4ca-2ff2028afd3mr172841061fa.25.1731515008428; Wed, 13 Nov 2024
 08:23:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112152020.147178-1-frederic.danis@collabora.com>
In-Reply-To: <20241112152020.147178-1-frederic.danis@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 13 Nov 2024 11:23:16 -0500
Message-ID: <CABBYNZJ1RiT53navDpTiCx+jo1Ynsobs7cggk=7Jibry+iJpwg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: SCO: Add support for 16 bits transparent voice setting
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On Tue, Nov 12, 2024 at 10:31=E2=80=AFAM Fr=C3=A9d=C3=A9ric Danis
<frederic.danis@collabora.com> wrote:
>
> The BCM4349B1 supports 16 bits transparent data on its I2S port.

Ok, but what difference does it make if transparent data or transparent 16 =
bits?

> Signed-off-by: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
> ---
>  include/net/bluetooth/bluetooth.h | 1 +
>  net/bluetooth/sco.c               | 7 +++++--
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bl=
uetooth.h
> index f66bc85c6411..21e93640c229 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -123,6 +123,7 @@ struct bt_voice {
>
>  #define BT_VOICE_TRANSPARENT                   0x0003
>  #define BT_VOICE_CVSD_16BIT                    0x0060
> +#define BT_VOICE_TRANSPARENT_16BIT             0x0063
>
>  #define BT_SNDMTU              12
>  #define BT_RCVMTU              13
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index 1b8e468d24cf..baaac4d65a5a 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -319,7 +319,8 @@ static int sco_connect(struct sock *sk)
>         else
>                 type =3D SCO_LINK;
>
> -       if (sco_pi(sk)->setting =3D=3D BT_VOICE_TRANSPARENT &&
> +       if ((sco_pi(sk)->setting =3D=3D BT_VOICE_TRANSPARENT ||
> +            sco_pi(sk)->setting =3D=3D BT_VOICE_TRANSPARENT_16BIT) &&
>             (!lmp_transp_capable(hdev) || !lmp_esco_capable(hdev))) {
>                 err =3D -EOPNOTSUPP;
>                 goto unlock;
> @@ -922,6 +923,7 @@ static int sco_sock_setsockopt(struct socket *sock, i=
nt level, int optname,
>
>                 /* Explicitly check for these values */
>                 if (voice.setting !=3D BT_VOICE_TRANSPARENT &&
> +                   voice.setting !=3D BT_VOICE_TRANSPARENT_16BIT &&
>                     voice.setting !=3D BT_VOICE_CVSD_16BIT) {
>                         err =3D -EINVAL;
>                         break;
> @@ -935,7 +937,8 @@ static int sco_sock_setsockopt(struct socket *sock, i=
nt level, int optname,
>                         break;
>                 }
>                 if (enhanced_sync_conn_capable(hdev) &&
> -                   voice.setting =3D=3D BT_VOICE_TRANSPARENT)
> +                   (voice.setting =3D=3D BT_VOICE_TRANSPARENT ||
> +                    voice.setting =3D=3D BT_VOICE_TRANSPARENT_16BIT))
>                         sco_pi(sk)->codec.id =3D BT_CODEC_TRANSPARENT;
>                 hci_dev_put(hdev);
>                 break;
> --
> 2.34.1
>
>


--=20
Luiz Augusto von Dentz
