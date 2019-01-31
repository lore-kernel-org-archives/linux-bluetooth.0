Return-Path: <SRS0=4ALD=QH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D2DC169C4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 31 Jan 2019 10:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75014218AC
	for <linux-bluetooth@archiver.kernel.org>; Thu, 31 Jan 2019 10:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5yA8uMB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfAaKwV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 31 Jan 2019 05:52:21 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:44866 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfAaKwV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 31 Jan 2019 05:52:21 -0500
Received: by mail-oi1-f180.google.com with SMTP id m6so2304261oig.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 31 Jan 2019 02:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fNuIqYSJAoIV+EZp3y85CTT0NYFiFWlnGC0zCDikn58=;
        b=T5yA8uMBwjNGRaEtsRvEFPhMM473iXXJKzVXBMeDSe5PW3REhzAdKsfET1CzQ0dDwq
         gj0n6fBsBvy93L68VptE9BJr9wuPIe64BMeCSCT5CmFB2v85eBqxIvugyqugX8gq+NSS
         +LsJOjRO7O6Z0f4XZnKSYETHt6Wdfcn8Esoiqy6jJERkVuReD+v++DLWjgmwkPOJraKy
         TZBt1I3+O6x2JHDxCyckuZKxgq5TBjSIn/qSAa3+UZWaIremwXjGm6duvBGqnlW2JlRh
         gWToG0cbOjfs1U6zsGkkKk2w3/vg/CpERJkHlFzW87ZBcg4pc9XNtDuJBlVKF4VBa020
         gIpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fNuIqYSJAoIV+EZp3y85CTT0NYFiFWlnGC0zCDikn58=;
        b=VaZj0bQ1+fxmunAbHgwX53dikmfuf1qMWc6V7W+5KRIpQY3XrTb6txNRXcYjSZ9G/s
         QfzpzQxhMRz1b7EptJGGw3PFb1v/Tg/yBvnQ42yXB2jDZEr+/6e/Ib868AQswZjA7kdl
         k+hmqjzYcpZjHQdwcJ70Ky6cmT8sQlyhmXtV62ZwKhPFVbpTxOVPh28T1fQs3fNAOgwb
         DkChfWsDqOBqwgGCHS0X+t8FGzCR76IaXw6RZ6adHqniJ+nMsnDlX5uLyuFjBNVExdhH
         KW1bG6JJXFhEOeOYqVXUz5Jh3+7tphKd20VuMUnITX7iDGqn1mAHdMuiOnIIYRKS9/7O
         Cc/g==
X-Gm-Message-State: AJcUukdToglMHD8wNeraemOMMz8qxl/0BV4pAraa/v9yhfUR7la5kLEE
        pOc4KcdV5Ga5uWH3dZDQlMG+48FU2krlMAEuc8g=
X-Google-Smtp-Source: ALg8bN4WQ37P/Mr/opw73dVX80ihsHRKr9wsNgQefR2CicZ3beThhOQqYGiBcn5Y34cvNLJr1m63GXJ1WQytJSdb73A=
X-Received: by 2002:aca:aa0d:: with SMTP id t13mr15459740oie.273.1548931940535;
 Thu, 31 Jan 2019 02:52:20 -0800 (PST)
MIME-Version: 1.0
References: <CABBYNZJCKhfX8jdYPqQvXDrtGQvMVT-htqE8WoyGYPLh1E78zA@mail.gmail.com>
 <20190129171207.8976-1-pali.rohar@gmail.com>
In-Reply-To: <20190129171207.8976-1-pali.rohar@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 31 Jan 2019 12:52:09 +0200
Message-ID: <CABBYNZ+dY0pKjie9TxFPQN6TC7Kp4YYQNRii5=m66WKpi8VHNQ@mail.gmail.com>
Subject: Re: [PATCH v3] a2dp-codecs: Fix SBC_MAX_BITPOOL and add SBC quality modes
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On Tue, Jan 29, 2019 at 7:14 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wrot=
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
> index 80e271ed6..b06cafb7b 100644
> --- a/android/hal-audio-sbc.c
> +++ b/android/hal-audio-sbc.c
> @@ -92,7 +92,7 @@ static const a2dp_sbc_t sbc_presets[] =3D {
>                 .block_length =3D SBC_BLOCK_LENGTH_4 | SBC_BLOCK_LENGTH_8=
 |
>                                 SBC_BLOCK_LENGTH_12 | SBC_BLOCK_LENGTH_16=
,
>                 .min_bitpool =3D SBC_MIN_BITPOOL,
> -               .max_bitpool =3D SBC_MAX_BITPOOL
> +               .max_bitpool =3D SBC_BITPOOL_HQ_JOINT_STEREO_44100,
>         },
>         {
>                 .frequency =3D SBC_SAMPLING_FREQ_44100,
> @@ -101,7 +101,7 @@ static const a2dp_sbc_t sbc_presets[] =3D {
>                 .allocation_method =3D SBC_ALLOCATION_LOUDNESS,
>                 .block_length =3D SBC_BLOCK_LENGTH_16,
>                 .min_bitpool =3D SBC_MIN_BITPOOL,
> -               .max_bitpool =3D SBC_MAX_BITPOOL
> +               .max_bitpool =3D SBC_BITPOOL_HQ_JOINT_STEREO_44100,
>         },
>         {
>                 .frequency =3D SBC_SAMPLING_FREQ_48000,
> @@ -110,7 +110,7 @@ static const a2dp_sbc_t sbc_presets[] =3D {
>                 .allocation_method =3D SBC_ALLOCATION_LOUDNESS,
>                 .block_length =3D SBC_BLOCK_LENGTH_16,
>                 .min_bitpool =3D SBC_MIN_BITPOOL,
> -               .max_bitpool =3D SBC_MAX_BITPOOL
> +               .max_bitpool =3D SBC_BITPOOL_HQ_JOINT_STEREO_48000,
>         },
>  };
>
> diff --git a/profiles/audio/a2dp-codecs.h b/profiles/audio/a2dp-codecs.h
> index 16088dc26..0d2cc155b 100644
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
> +#define SBC_BITPOOL_MQ_MONO_44100              19
> +#define SBC_BITPOOL_MQ_MONO_48000              18
> +#define SBC_BITPOOL_MQ_JOINT_STEREO_44100      35
> +#define SBC_BITPOOL_MQ_JOINT_STEREO_48000      33
> +#define SBC_BITPOOL_HQ_MONO_44100              31
> +#define SBC_BITPOOL_HQ_MONO_48000              29
> +#define SBC_BITPOOL_HQ_JOINT_STEREO_44100      53
> +#define SBC_BITPOOL_HQ_JOINT_STEREO_48000      51
>
>  #define MPEG_CHANNEL_MODE_MONO         (1 << 3)
>  #define MPEG_CHANNEL_MODE_DUAL_CHANNEL (1 << 2)
> --
> 2.11.0

Applied, thanks. Note that I did have to change some comments which
had line going over 80 columns.


--=20
Luiz Augusto von Dentz
