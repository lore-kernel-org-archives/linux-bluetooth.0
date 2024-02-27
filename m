Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169EE1D698
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Feb 2024 16:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709051858; cv=none; b=YdmlhxMPDxW7sOA0TNI6ZiXeItNDzzYL2cPIrkFfJ+rLgYualtm1lsRl/7A0G+NSJwS1vWSfDMmYhvl3rt2yEmpNXG3Z9aaN2Sri+gHHEgJ5GzZJ+Adb8w+MktlCDnDlzp3wmB++BgBfdoAetr6xNo9pb30dTDP2ZAvXNUKTlOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709051858; c=relaxed/simple;
	bh=GNQOShF6KwlTPlnQ98YcnG6tb0XiC7wCHCg9Iy/Bu48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YmLazdV70TqI8DZBTKbOi2npxLdyDFXKyWMCZ/f0mYoeY16IhDa5/gG+eW4dpKHx0V8RH1kO5Us9wsAhXf6OWNKc9uplTbxgegJfDfB7Ib/VULh4qUxuciC4rz5YNholu3CmD/p0RcVZXoccEoxbUS600NNzhjWMeW1WWs/gbGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FNYFnYS3; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNYFnYS3"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d220e39907so70779441fa.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Feb 2024 08:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709051855; x=1709656655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZz7EUuJJ4lAo1ptnucB5Zc1fTIKk+0GCjjgLN/Xz2s=;
        b=FNYFnYS3oujx3aLyZQ0dFM6MlY92AUSL9jZkV6cZ6JJwyy6XJeyujsxv+NiRY6G590
         TebnOdRNgiPF7+7fGNL8FmdZy225iTolRtXJD1XDJzadTHLc4alvV4cZLtB+4fRdr+Pt
         9nBKBsBBEUua+zdE7jpnsBPRuMTtai1l/lj0bMcGzwP2eKmWnJDVGawDyU/t8j1g9S27
         QofDcrHgKRXloHuTpTUQNvnTBb/PYa2toSDs8/P2AgQP8cLlhXbwO7K5q8/3LjF9Ojcx
         xcXOfAVOzw2rjJBJMV3oOfnWIm/I6JI/xfqCXKZvbMFrilwAZRbnGj66UUA8sGQ7SUjv
         jQKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709051855; x=1709656655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XZz7EUuJJ4lAo1ptnucB5Zc1fTIKk+0GCjjgLN/Xz2s=;
        b=R8pd4BF1ZOZAUKinWoEGZZukMj2QZvhq42i8hg3QYaELu0vvLOzXv+GdrXTG4E/t6j
         aQvaXV9cqbcMgGyppULGhGjOLTTdpJD0GVhZSTHIljfpN0K7jDBNiE2k0Pl6It9Wkkyv
         Ewb5GBf8rbnRSIQxsiXRQTEsVwR0/k2iAQjH5tRRFH7bFOc/1ddfIlhQIFQQgPEkMYHe
         c4VvxjduAn3VMfagWQhH4G6pI6W2ve8CGUb0OK8tfwJ6pyTpK4Mhowep3yR0ZtbscXnt
         iUDx+o5K7IBqYB1y1cQh/Ec9bP+9YSi7nn/q7/J5Xcf1csXNmaZuN67MZMXCe7tnkxzU
         aQPw==
X-Gm-Message-State: AOJu0YwrGLFWW0Y97D0xQhKENnB9XBJKcRMPA9+GbA1F+eBzl//VM/Mb
	MVSmXjthli2clSI6NwNllPJdJU+S1JZuiYUkTQ4PYT+SA8p1z/o63epuPBE+WYh8LYexg74xOK0
	i/DHeUlyscgePDE1KUqTQShETMRJD8HON
X-Google-Smtp-Source: AGHT+IEcU8Ug3aE2bfPE/N2/BZhNYPxMH2z0/lCkuzhpnmhEXaFZghQ9mOdAR1nZgcLHATVkS5A3Rvn8cUl6c+Df3sY=
X-Received: by 2002:a2e:2281:0:b0:2d2:7f28:2e77 with SMTP id
 i123-20020a2e2281000000b002d27f282e77mr6307705lji.7.1709051854851; Tue, 27
 Feb 2024 08:37:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223152940.40099-1-sibobrenok@salutedevices.com>
In-Reply-To: <20240223152940.40099-1-sibobrenok@salutedevices.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 27 Feb 2024 11:37:22 -0500
Message-ID: <CABBYNZJYd-6f3qq6S-Km6M2Wr-QOc2UydKx26hR=A8n-375HQw@mail.gmail.com>
Subject: Re: [PATCH] main.conf: Introduce GATT.ReverseClient option
To: Sergey Bobrenok <sibobrenok@salutedevices.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sergey,

On Fri, Feb 23, 2024 at 10:30=E2=80=AFAM Sergey Bobrenok
<sibobrenok@salutedevices.com> wrote:
>
> General.ReverseServiceDiscovery option is responsible for two
> different things:
>  1. It disables SDP reverse discovering. As a side effect, some BR/EDR
>  profiles cannot operate properly. E.g. AVRCP-target profile needs SDP
>  results to determine the peer's AVRCP version.
>  2. It disables GATT-client creation back to the GATT connection
>  initiator. It may be useful for peripheral devices, especially if the
>  peer doesn't expect them to connect back (and currently some IOS
>  versions don't). This behavior was introduced in
>  8de73cd12 ("main.conf: Make ReverseServiceDiscovery work with LE")
>
> For peripheral devices implementing only A2DP-sink, AVRCP-target, and
> GATT profiles (e.g. BT loudspeakers), it may be useful to disable
> GATT-client functionality, but still have SDP reverse discovering.
>
> Unfortunately, splitting the General.ReverseServiceDiscovery option
> into two different options will break backward compatibility on the
> configuration file level. So a new configuration option has been
> introduced in addition to the old one.

While I agree we need some option to handle such cases where the
remote end don't expects us to act as GATT Client the option name
shall probably be just to disable the GATT client entirely not just
reverse discovery so it an independent which affects
ReverseServiceDiscovery implicitly otherwise there is a dependency on
one another which may lead to confusions like setting
ReverseServiceDiscovery=3Dfalse and then ReverseClient=3Dtrue would have
no effect.

> Signed-off-by: Sergey Bobrenok <sibobrenok@salutedevices.com>
> ---
>  src/btd.h     | 1 +
>  src/device.c  | 4 ++++
>  src/main.c    | 4 ++++
>  src/main.conf | 7 ++++++-
>  4 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/src/btd.h b/src/btd.h
> index 7166e2168..f85b119b7 100644
> --- a/src/btd.h
> +++ b/src/btd.h
> @@ -140,6 +140,7 @@ struct btd_opts {
>         bt_gatt_cache_t gatt_cache;
>         uint16_t        gatt_mtu;
>         uint8_t         gatt_channels;
> +       gboolean        gatt_reverse_client;
>         enum mps_mode_t mps;
>
>         struct btd_avdtp_opts avdtp;
> diff --git a/src/device.c b/src/device.c
> index 1db96d9a6..e8d66ffe4 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -5452,6 +5452,10 @@ static void gatt_client_init(struct btd_device *de=
vice)
>                 DBG("Reverse service discovery disabled: skipping GATT cl=
ient");
>                 return;
>         }
> +       if (!device->connect && !btd_opts.gatt_reverse_client) {
> +               DBG("Reverse gatt client disabled: skipping GATT client")=
;
> +               return;
> +       }
>
>         device->client =3D bt_gatt_client_new(device->db, device->att,
>                                                         device->att_mtu, =
0);
> diff --git a/src/main.c b/src/main.c
> index b1339c230..f0c2c4311 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -145,6 +145,7 @@ static const char *gatt_options[] =3D {
>         "KeySize",
>         "ExchangeMTU",
>         "Channels",
> +       "ReverseClient",
>         NULL
>  };
>
> @@ -1058,6 +1059,8 @@ static void parse_gatt(GKeyFile *config)
>                                 BT_ATT_DEFAULT_LE_MTU, BT_ATT_MAX_LE_MTU)=
;
>         parse_config_u8(config, "GATT", "Channels", &btd_opts.gatt_channe=
ls,
>                                 1, 5);
> +       parse_config_bool(config, "GATT", "ReverseClient",
> +                               &btd_opts.gatt_reverse_client);
>  }
>
>  static void parse_csis_sirk(GKeyFile *config)
> @@ -1190,6 +1193,7 @@ static void init_defaults(void)
>         btd_opts.gatt_cache =3D BT_GATT_CACHE_ALWAYS;
>         btd_opts.gatt_mtu =3D BT_ATT_MAX_LE_MTU;
>         btd_opts.gatt_channels =3D 1;
> +       btd_opts.gatt_reverse_client =3D TRUE;
>
>         btd_opts.avdtp.session_mode =3D BT_IO_MODE_BASIC;
>         btd_opts.avdtp.stream_mode =3D BT_IO_MODE_BASIC;
> diff --git a/src/main.conf b/src/main.conf
> index 085c81a46..a617eec6b 100644
> --- a/src/main.conf
> +++ b/src/main.conf
> @@ -33,7 +33,7 @@
>  # us. For BR/EDR this option is really only needed for qualification sin=
ce the
>  # BITE tester doesn't like us doing reverse SDP for some test cases, for=
 LE
>  # this disables the GATT client functionally so it can be used in system=
 which
> -# can only operate as peripheral.
> +# can only operate as peripheral (see also GATT ReverseClient).
>  # Defaults to 'true'.
>  #ReverseServiceDiscovery =3D true
>
> @@ -283,6 +283,11 @@
>  # Defaults to 0
>  #Rank =3D 0
>
> +# This disables the GATT client functionally so it can be used in system=
 which
> +# can only operate as peripheral.
> +# Defaults to 'true'.
> +#ReverseClient =3D true

Like explained above I'd suggest we go with just a Client setting here.

>  [AVDTP]
>  # AVDTP L2CAP Signalling Channel Mode.
>  # Possible values:
>
> base-commit: a16c2ccf9c256285188f4549b7b767cf31b100eb
> --
> 2.43.2
>
>


--=20
Luiz Augusto von Dentz
