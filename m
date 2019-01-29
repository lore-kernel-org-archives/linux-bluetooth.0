Return-Path: <SRS0=G1v0=QF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72973C169C4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Jan 2019 11:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 438C520880
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Jan 2019 11:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vheS+8El"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbfA2L70 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:59:26 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35884 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731148AbfA2LrJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Jan 2019 06:47:09 -0500
Received: by mail-oi1-f194.google.com with SMTP id x23so15869853oix.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jan 2019 03:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QSgDslKGqSXD6PcfaVNKARg8F+izff6+e40hMRnL4T0=;
        b=vheS+8ElhkrvXJZxiJEDVg1P9zD7c3qHrfcxGO3mIx2vSgL07czy6JUZ/HWDCGPkxO
         aecEcGBfjiJ+qYdcFmz533AGrA4omnpfSGhZR7ntvMKtpnqysHg5tyzADDTiGD/cmHWo
         Dnu5Wc7NeQSVRpDamUwvhHwRADQF8fb3k8BeObX7ljKQQUldJmFA+nf5J6TMhkGiIGF8
         VskyQgiN5dBXjkKi8f8t+B6lL4lKh+tTE18VTG/SYImh7xMRPP3vI5GjYUtk0DiSGS9N
         kS3wcbkl4KBSlpMPptNWYpfn2zzDVBlYKc4slPZzBsGuzi1uSV0dZgZ4Ameh2onzCQVw
         uhDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QSgDslKGqSXD6PcfaVNKARg8F+izff6+e40hMRnL4T0=;
        b=NrvnxKnsHNgR+BqOtHUd+1cdvPTA7x9VXd9fvT7PHt6o4K6bW6GRXunXonoLPYM74D
         of4iIl32VmSJtAqdrfo01rcOHuFUzorliiQ/9QNzpVTrzlgRGLVG+dc5EiRSWVZq6Prs
         lLE8crhKn3O+94zNAdtdR9kIImFTu8HmcWyecZligJ7ppz2nLH1nTuuu0TIW2YxaAtRW
         1Ga90VuhwL4fkV3mgr7uUzOmQHMT5W2imbY1JkaUddxPA3W89GCi0MeujefKt8Knqzj8
         80sNJKro8BsPchojJDPO8MlCnxJBmpMN90RHcTa9sNL1CIGaRXtNFOUAJfXbVRg6wuqm
         +zBA==
X-Gm-Message-State: AHQUAuZQ3V5dbl90rO429zweXPxlNbJ1BO23THGbo59f//nlXcOC73jV
        fmVRYjhyx7+oK68VkTyC4M8Y77lEyKxqFbin/aXlYA==
X-Google-Smtp-Source: ALg8bN4WAao3Sen4HFw4nunvrjJQ8fHolMLzvmejG4WhOXb9C3fLCy8ImlXu9NFt6EMcfu1tRttbZXKN3VGA6WUcHc0=
X-Received: by 2002:aca:d509:: with SMTP id m9mr8886163oig.82.1548762428758;
 Tue, 29 Jan 2019 03:47:08 -0800 (PST)
MIME-Version: 1.0
References: <20190126104539.26421-1-pali.rohar@gmail.com> <20190128231021.22363-1-pali.rohar@gmail.com>
In-Reply-To: <20190128231021.22363-1-pali.rohar@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 29 Jan 2019 13:46:56 +0200
Message-ID: <CABBYNZJCKhfX8jdYPqQvXDrtGQvMVT-htqE8WoyGYPLh1E78zA@mail.gmail.com>
Subject: Re: [PATCH v2] a2dp-codecs: Fix SBC_MAX_BITPOOL and add SBC quality modes
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,
On Tue, Jan 29, 2019 at 1:12 AM Pali Roh=C3=A1r <pali.rohar@gmail.com> wrot=
e:
>
> According to A2DP specification; section SBC; Codec Specific Information
> Elements; Minimum / Maximum Bitpool Value, range for Bitpool value is fro=
m
> 2 to 250.
>
> A2DP specification also defines bitpool values for two SBC modes: Middle
> Quality and High Quality. They depends on channel mode and frequency. So
> add definitions for them into a2dp-codecs file too.
>
> File android/hal-audio-sbc.c was updated to use High Quality mode for
> chosen frequency.
> ---
>  android/hal-audio-sbc.c      |  6 +++---
>  profiles/audio/a2dp-codecs.h | 12 +++++++++++-
>  2 files changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/android/hal-audio-sbc.c b/android/hal-audio-sbc.c
> index 80e271ed6..f11f40108 100644
> --- a/android/hal-audio-sbc.c
> +++ b/android/hal-audio-sbc.c
> @@ -92,7 +92,7 @@ static const a2dp_sbc_t sbc_presets[] =3D {
>                 .block_length =3D SBC_BLOCK_LENGTH_4 | SBC_BLOCK_LENGTH_8=
 |
>                                 SBC_BLOCK_LENGTH_12 | SBC_BLOCK_LENGTH_16=
,
>                 .min_bitpool =3D SBC_MIN_BITPOOL,
> -               .max_bitpool =3D SBC_MAX_BITPOOL
> +               .max_bitpool =3D SBC_BITPOOL_HIGH_QUALITY_JOINT_STEREO_44=
100,
>         },
>         {
>                 .frequency =3D SBC_SAMPLING_FREQ_44100,
> @@ -101,7 +101,7 @@ static const a2dp_sbc_t sbc_presets[] =3D {
>                 .allocation_method =3D SBC_ALLOCATION_LOUDNESS,
>                 .block_length =3D SBC_BLOCK_LENGTH_16,
>                 .min_bitpool =3D SBC_MIN_BITPOOL,
> -               .max_bitpool =3D SBC_MAX_BITPOOL
> +               .max_bitpool =3D SBC_BITPOOL_HIGH_QUALITY_JOINT_STEREO_44=
100,
>         },
>         {
>                 .frequency =3D SBC_SAMPLING_FREQ_48000,
> @@ -110,7 +110,7 @@ static const a2dp_sbc_t sbc_presets[] =3D {
>                 .allocation_method =3D SBC_ALLOCATION_LOUDNESS,
>                 .block_length =3D SBC_BLOCK_LENGTH_16,
>                 .min_bitpool =3D SBC_MIN_BITPOOL,
> -               .max_bitpool =3D SBC_MAX_BITPOOL
> +               .max_bitpool =3D SBC_BITPOOL_HIGH_QUALITY_JOINT_STEREO_48=
000,
>         },
>  };
>
> diff --git a/profiles/audio/a2dp-codecs.h b/profiles/audio/a2dp-codecs.h
> index 16088dc26..9bdd0f0b8 100644
> --- a/profiles/audio/a2dp-codecs.h
> +++ b/profiles/audio/a2dp-codecs.h
> @@ -53,8 +53,18 @@
>  #define SBC_ALLOCATION_SNR             (1 << 1)
>  #define SBC_ALLOCATION_LOUDNESS                1
>
> -#define SBC_MAX_BITPOOL                        64
>  #define SBC_MIN_BITPOOL                        2
> +#define SBC_MAX_BITPOOL                        250
> +
> +/* Other settings: Block length =3D 16, Allocation method =3D Loudness, =
Subbands =3D 8 */
> +#define SBC_BITPOOL_MIDDLE_QUALITY_MONO_44100          19
> +#define SBC_BITPOOL_MIDDLE_QUALITY_MONO_48000          18
> +#define SBC_BITPOOL_MIDDLE_QUALITY_JOINT_STEREO_44100  35
> +#define SBC_BITPOOL_MIDDLE_QUALITY_JOINT_STEREO_48000  33
> +#define SBC_BITPOOL_HIGH_QUALITY_MONO_44100            31
> +#define SBC_BITPOOL_HIGH_QUALITY_MONO_48000            29
> +#define SBC_BITPOOL_HIGH_QUALITY_JOINT_STEREO_44100    53
> +#define SBC_BITPOOL_HIGH_QUALITY_JOINT_STEREO_48000    51

Im quite fine with the new defines just their names could be a bit
shorter, perhaps use MQ and HQ for middle and high quality.

>  #define MPEG_CHANNEL_MODE_MONO         (1 << 3)
>  #define MPEG_CHANNEL_MODE_DUAL_CHANNEL (1 << 2)
> --
> 2.11.0
>


--=20
Luiz Augusto von Dentz
