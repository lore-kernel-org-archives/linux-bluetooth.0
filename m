Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412F52206A5
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Dec 2024 18:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733508821; cv=none; b=P/69Hh7If3Eyd0uZJ/IM++Dzexqb63e4vgAUi2gkqYIUVUx9+RssLbvmNi0w83QerR3BxZ2B+sn4h+2kH+tbkNRosTUtJ7gKMO3HNYy6w234dwJWPbmHgaSz58TwTxX++4LavKjPBrLFrmb0qWfdpm314TOhwrNQwZOT2OHLr6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733508821; c=relaxed/simple;
	bh=+y3jeevQsSUOs2LolQMqdndXNvdYAc0atx5Ecyy98Ek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CgwiXI92VUSETeRcECUJhFg0dnCzMh00nJU4VYrDnloKzRgcvowfw9KMwHnGDrBd+LemYowo17CuCkaQ8vonowueY3o/wUppiTO57wFA8IMil/aaQcz6mpy9rs5TmN0l2K/veJ9Sw1513AT+Pdw1zKSz07vcLtgzIfutRrrUcx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D1YQ5gKv; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1YQ5gKv"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ffc016f301so20529431fa.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Dec 2024 10:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733508817; x=1734113617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JpOkqbIggZUUgV7cZ5/IKcq9/+/gEGJeM7LnuaKpuMs=;
        b=D1YQ5gKvmJuqENJdAZO+LrCvLOn7BWNNku9yvVg6DEoi/uolIMgElwtW01DMC0R1k7
         s12bmbQcL36yJZ6zFMNmU9WLapjRY107LVtDE6vnZipaXQEDRAFtiLcjzu/6h3YZvvNe
         uqdVEsmk2Cu0Zh1BlIyeqGVNqlbc+CF6S7iTJe2zajBzz396J8VS/hHFwOgwPpkbHrxP
         WG9oX/gPrOROJIdqKbMtNL+Yp8HERuAnb8xXUgCQLSo4sPTm0X66zKpgvu2EFM7g7e4F
         dn0EMyewtVNlKmSQEDc10lYfX8YIuFxKf7xex1x8CUT4EweOQr4mvSlevqyV+nuuO3A+
         OqxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733508817; x=1734113617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JpOkqbIggZUUgV7cZ5/IKcq9/+/gEGJeM7LnuaKpuMs=;
        b=MT5wH+dJErMeCTH1tjmjctSrLkIn7FZ5Y5qosxBCoE1WYSCDVpCU8qKQXTYpMGsv98
         JUoyktHvh08QktjgSKl2HdZRHNjw9fyjaWPN5+Kyf3ShTGdr4zR6LS1qBhE0bsZvWcwS
         iBbHQ1+dcILGcUgtvBL52vd2xMQzGikm9/5pfG6974xuTr8aOnfff+I/4CUQPm4ww5Xp
         FVmV7hsbfapPGbcNj6mDS5qATNGNzvv6bgsay4frvNNxwPFv9NVmLKVHKsW4/dzayVc2
         uH7h51GngVtWyw5XstCz0ttcIkZ9GGsHp3x48bFu/135SmcnWn85Xs87HIGR3mozS4w9
         AwFw==
X-Gm-Message-State: AOJu0YwNCdXdtpYIHO66WWw4LnYnDHIjbiRVOyaFEcVJfc1IQXnpyQVs
	hYTBzYT4GJQaagg+OwI0F/kGspLjRW36V2SQXHSehME8GB+1osXqownYpdsMcQX62UYxWRC+U+O
	oVysh506qPGy1rtwp/TuldQv0/Hrhd2t9
X-Gm-Gg: ASbGncuso4cMcdS/pz5m+TefN5ZsprYBL2urYePguCFSka0GQqQIlUZ7wdLLMe1Snqp
	SwRnhrN9pJx+4B+Kp0mF1XKnROsBQCyFe
X-Google-Smtp-Source: AGHT+IFmsuFlrHl6ZwC5EV/zyC4Pvrnjj1m+ZdQSojUvkIIOnX+IDSpq8lDXPdJZIjVsPZdNJGZy/AxmQY7Idmm/g20=
X-Received: by 2002:a05:651c:506:b0:300:28b4:163 with SMTP id
 38308e7fff4ca-3002f8c3a34mr11568971fa.9.1733508816992; Fri, 06 Dec 2024
 10:13:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205155159.461032-1-frederic.danis@collabora.com>
In-Reply-To: <20241205155159.461032-1-frederic.danis@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 6 Dec 2024 13:13:24 -0500
Message-ID: <CABBYNZ+tXJDNUdd4Ar-6hCy+uT75MqA3w0FsSyJB1ymfx-tAwA@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: SCO: Add support for 16 bits transparent
 voice setting
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Frederic,

On Thu, Dec 5, 2024 at 10:52=E2=80=AFAM Fr=C3=A9d=C3=A9ric Danis
<frederic.danis@collabora.com> wrote:
>
> The voice setting is used by sco_connect() or sco_conn_defer_accept()
> after being set by sco_sock_setsockopt().
>
> The PCM part of the voice setting is used for offload mode through PCM
> chipset port.
> This commits add support for mSBC 16 bits offloading, i.e. audio data
> not transported over HCI.
>
> The BCM4349B1 supports 16 bits transparent data on its I2S port.
> If BT_VOICE_TRANSPARENT is used when accepting a SCO connection, this
> gives only garbage audio while using BT_VOICE_TRANSPARENT_16BIT gives
> correct audio.
> This has been tested with connection to iPhone 14 and Samsung S24.
>
> Signed-off-by: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
> ---
> v1 -> v2: Enhance commit message
> v2 -> v3: Enhance commit message
>
>  include/net/bluetooth/bluetooth.h | 1 +
>  net/bluetooth/sco.c               | 7 +++++--
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bl=
uetooth.h
> index e6760c11f007..435250c72d56 100644
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
> index 7eb8d3e04ec4..7b54d8826bcc 100644
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

We might need to allow all valid settings here, since there can be
different PCM settings other than just these which is probably why the
HCI field is a bitmask, so I suggest we do something like this:

https://gist.github.com/Vudentz/ae1502e6e402ae95aca330bae6096941

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
