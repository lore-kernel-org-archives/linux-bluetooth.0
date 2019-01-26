Return-Path: <SRS0=qwpb=QC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E3FC282C7
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Jan 2019 15:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE14F218CD
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Jan 2019 15:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DY8PqP2J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbfAZPZd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 26 Jan 2019 10:25:33 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33404 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfAZPZc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 26 Jan 2019 10:25:32 -0500
Received: by mail-oi1-f194.google.com with SMTP id c206so9919140oib.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Jan 2019 07:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gtX8hOTc78enfbwLS6ePCtcFOwunBGJvUFuXEr22PSY=;
        b=DY8PqP2JQoDP6jcGSB0+JRX5C+Up23PEiCl3wI42YKPcEhgg63WUR2T4q1ecmjuYBa
         XwPolhClfSKe3QQTjjzsjC8Xub3vaaazXAjZp38j7qQJqkOWLWFv201LbIfNzRObu+5+
         c7ss1HyvwFwiyVcuD+EEQtMhTxMYFgTlLNja2+fDUOm5cMYJ1UFA1DMwIqaVYEX/iiGH
         ZrxCxxqCuGpt7p9UY1IAg116M9sFPpcBbCRnP/DMRWR1P0mdsj6V7JauA795vQn2D/Be
         9bia7zC6jftlkGE48QzukTM1YrROeoha4Ux1uqWx+6UBAgbFd6TTc+Mi4FNDLhao28Vi
         pfDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gtX8hOTc78enfbwLS6ePCtcFOwunBGJvUFuXEr22PSY=;
        b=PIGzlVDTTNqZkpZsLGLFjwB1sIz9BQhNq8+a+k0RRoq3jkLcVSS59HZMv80sGti0+2
         DE3xZ/pGQRZ8QFtFHM7ZkPre9m45c0J1yuh/o7pK69GFGcgAHg2JK4RxNbEmSRejxh4p
         YzQ7DriM/iGk5ZTHdoCikSI5QDjsYqHeEG+r6vSaZjNLPZLBEr/e9vMHbmkU3SMRqsaa
         gp6x7pQtjovU8Z9Woux8Eky/hUpqK3HwLUCriF6cDZbgjzT1TTGAov9NqJuTBZiEuk3d
         vvYj2yDiC8wdo5fmKJPy8Cs1UJhwiDZJC2eD0vK21Pxl8lyZYS2aRVdmxFxcjPRD3hsh
         w2TA==
X-Gm-Message-State: AHQUAuazYAQIC/Sf6Gm87CstfxguK4Mh3RgvV0aMdVVrZ0YaXP68kjC4
        2tgR3oJxXF4hBuwEWqn8VqvYjVw1tGfCmQkRcPjl8asK
X-Google-Smtp-Source: ALg8bN7WBRMyynav+UQTsyK0lh/rA6Z2apAmaWzLCh0bXkA0rFFnMHE9blHNPWiuIJJgv9x0D/ZO2IRHZLMSwCJb2kc=
X-Received: by 2002:aca:d509:: with SMTP id m9mr1252635oig.82.1548516331575;
 Sat, 26 Jan 2019 07:25:31 -0800 (PST)
MIME-Version: 1.0
References: <20190126104539.26421-1-pali.rohar@gmail.com>
In-Reply-To: <20190126104539.26421-1-pali.rohar@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Sat, 26 Jan 2019 17:25:18 +0200
Message-ID: <CABBYNZKvzSJWvWrid4wTaLZEnhoUYb-3GtYK3k+EvY922Zxm3g@mail.gmail.com>
Subject: Re: [PATCH] a2dp-codecs: Remove wrong definition of SBC_MAX_BITPOOL
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On Sat, Jan 26, 2019 at 12:47 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wro=
te:
>
> According to A2DP specification; section SBC; Codec Specific Information
> Elements; Minimum / Maximum Bitpool Value, range for Bitpool value is fro=
m
> 2 to 250. Decoder shell support 2 as Minimum Bitpool Value and High Quali=
ty
> Bitpool value as the Maximum Bitpool Value at a minimum. A2DP defines
> maximal High Quality Bitpool value as 53.

A2DP recommends 53 bitpool for high quality, 64 was used as upper
bound to limit bandwidth so it had nothing to do with A2DP more like a
interval detail.

> Therefore instead of SBC_MAX_BITPOOL macro, defines two macros, one for
> minimal value of "Maximum Bitpool Value" and maximal value of "Maximum
> Bitpool Value".

We could define the recommended bitpools by quality, like the A2DP do,
and then the MAX to 250, that should make it a bit more clearer.

> I have no idea what is origin of value 64 as it does not match minimum no=
r
> maximum bitpool value. Lot of headsets declares maximum value to 53, so u=
se
> this value also in android/hal-audio-sbc.c

We could define 64 as ultra high quality for those that wish a better
quality than 53, past that there a very limited return in terms of
quality.

> ---
>  android/hal-audio-sbc.c      | 6 +++---
>  profiles/audio/a2dp-codecs.h | 3 ++-
>  2 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/android/hal-audio-sbc.c b/android/hal-audio-sbc.c
> index 80e271ed6..541b2d6a7 100644
> --- a/android/hal-audio-sbc.c
> +++ b/android/hal-audio-sbc.c
> @@ -92,7 +92,7 @@ static const a2dp_sbc_t sbc_presets[] =3D {
>                 .block_length =3D SBC_BLOCK_LENGTH_4 | SBC_BLOCK_LENGTH_8=
 |
>                                 SBC_BLOCK_LENGTH_12 | SBC_BLOCK_LENGTH_16=
,
>                 .min_bitpool =3D SBC_MIN_BITPOOL,
> -               .max_bitpool =3D SBC_MAX_BITPOOL
> +               .max_bitpool =3D SBC_MAX_BITPOOL_MIN,
>         },
>         {
>                 .frequency =3D SBC_SAMPLING_FREQ_44100,
> @@ -101,7 +101,7 @@ static const a2dp_sbc_t sbc_presets[] =3D {
>                 .allocation_method =3D SBC_ALLOCATION_LOUDNESS,
>                 .block_length =3D SBC_BLOCK_LENGTH_16,
>                 .min_bitpool =3D SBC_MIN_BITPOOL,
> -               .max_bitpool =3D SBC_MAX_BITPOOL
> +               .max_bitpool =3D SBC_MAX_BITPOOL_MIN,
>         },
>         {
>                 .frequency =3D SBC_SAMPLING_FREQ_48000,
> @@ -110,7 +110,7 @@ static const a2dp_sbc_t sbc_presets[] =3D {
>                 .allocation_method =3D SBC_ALLOCATION_LOUDNESS,
>                 .block_length =3D SBC_BLOCK_LENGTH_16,
>                 .min_bitpool =3D SBC_MIN_BITPOOL,
> -               .max_bitpool =3D SBC_MAX_BITPOOL
> +               .max_bitpool =3D SBC_MAX_BITPOOL_MIN,
>         },
>  };
>
> diff --git a/profiles/audio/a2dp-codecs.h b/profiles/audio/a2dp-codecs.h
> index 0bdd29110..f31f3a311 100644
> --- a/profiles/audio/a2dp-codecs.h
> +++ b/profiles/audio/a2dp-codecs.h
> @@ -53,8 +53,9 @@
>  #define SBC_ALLOCATION_SNR             (1 << 1)
>  #define SBC_ALLOCATION_LOUDNESS                1
>
> -#define SBC_MAX_BITPOOL                        64
>  #define SBC_MIN_BITPOOL                        2
> +#define SBC_MAX_BITPOOL_MIN            53
> +#define SBC_MAX_BITPOOL_MAX            250
>
>  #define MPEG_CHANNEL_MODE_MONO         (1 << 3)
>  #define MPEG_CHANNEL_MODE_DUAL_CHANNEL (1 << 2)
> --
> 2.11.0
>


--=20
Luiz Augusto von Dentz
