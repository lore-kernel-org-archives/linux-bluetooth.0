Return-Path: <SRS0=3wSE=QD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16ACFC282C0
	for <linux-bluetooth@archiver.kernel.org>; Sun, 27 Jan 2019 10:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFF85214C6
	for <linux-bluetooth@archiver.kernel.org>; Sun, 27 Jan 2019 10:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tlsw7MDc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfA0KHh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 27 Jan 2019 05:07:37 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34691 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfA0KHg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 27 Jan 2019 05:07:36 -0500
Received: by mail-wr1-f66.google.com with SMTP id f7so14739108wrp.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Jan 2019 02:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=us6yznpIvUrfFdIYdopiOmWNphm8gSyS4vYPSlnnrVo=;
        b=tlsw7MDcMDvbIa4n3vFhQ0D/61Yr7Dg7QEnR/p870lEhblKao/KJ38prqYtM63ZmLi
         BoYdMm9eHm6HRg0fTjNGuWmm+IV/eIHkj8QC7E+d4p93KYxVyk04LN71ZH4maHsiB5zY
         I1xEJkGkQSbB6QH7QR/Wfb7zgISBYiXxFha0JRsmOn4PBBufct74WrF4+NOi+at3v0kX
         4hDjmEnJClLqWDdH6hyuM8/4vhhak4YwCuWsy+vS3bwpCjDLahE/k3w/lZBOqnsEVkMO
         0umwrf6JA+2tF9BRJ4OWTUFMhRJNeMLJ4Gma7ubzKDcYxDIQ7uTF5cmlsMJlzhoOpn5K
         TrMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=us6yznpIvUrfFdIYdopiOmWNphm8gSyS4vYPSlnnrVo=;
        b=Td2owjcx8qzEL5QatXoUKF1/gxXWUUIqOQ/xPblIosPKeSXBioAWzhuJ5YvmaWb2OH
         jQCz7yIEVsjkc3/xaFxrYQHeYA/ZWvPqcV5Pk7o6+KkCmJVu+CT0XPIYrfVP6xYXG36q
         APhnp1Fprsb9jdVYXRmfg0HHuoRek1k2g5Uh4+tKuj5qe0L+sHnspFZU3N84U0tRgl4n
         XknHSZlsFvWIqoyuKN3nqA2nHPQ84rIjadKw513q2Xz54v8IcPrazJTrO9S3W303bfQq
         d1QawynhWp+Q+rNr4rBCuzdRExa5fX6jkwrrjSsFVTNei7h4F7gIVUkQ5nHnNJvwmpit
         vXpw==
X-Gm-Message-State: AJcUukeFmGT8/lQp5bIM/l97n11mexocBYwn9PC3n0IDpHtoBm8N2F6K
        4I7qxZT8zDN9NBjHUcd0Etc=
X-Google-Smtp-Source: ALg8bN6dF2F+R9X3FTatBUACzr5xFNpEt1w9z61lUafE15v2rVpRO45dlcRg2sVZcK9MFbEgG5Mw1g==
X-Received: by 2002:adf:fdc2:: with SMTP id i2mr18347932wrs.117.1548583654292;
        Sun, 27 Jan 2019 02:07:34 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id 10sm82835609wmy.40.2019.01.27.02.07.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 Jan 2019 02:07:33 -0800 (PST)
Date:   Sun, 27 Jan 2019 11:07:32 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] a2dp-codecs: Remove wrong definition of SBC_MAX_BITPOOL
Message-ID: <20190127100732.zjwt7lepj3r3styy@pali>
References: <20190126104539.26421-1-pali.rohar@gmail.com>
 <CABBYNZKvzSJWvWrid4wTaLZEnhoUYb-3GtYK3k+EvY922Zxm3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="rq3r4jcprqhwnha5"
Content-Disposition: inline
In-Reply-To: <CABBYNZKvzSJWvWrid4wTaLZEnhoUYb-3GtYK3k+EvY922Zxm3g@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--rq3r4jcprqhwnha5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Saturday 26 January 2019 17:25:18 Luiz Augusto von Dentz wrote:
> Hi Pali,
>=20
> On Sat, Jan 26, 2019 at 12:47 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> w=
rote:
> >
> > According to A2DP specification; section SBC; Codec Specific Information
> > Elements; Minimum / Maximum Bitpool Value, range for Bitpool value is f=
rom
> > 2 to 250. Decoder shell support 2 as Minimum Bitpool Value and High Qua=
lity
> > Bitpool value as the Maximum Bitpool Value at a minimum. A2DP defines
> > maximal High Quality Bitpool value as 53.
>=20
> A2DP recommends 53 bitpool for high quality, 64 was used as upper
> bound to limit bandwidth so it had nothing to do with A2DP more like a
> interval detail.

I though that all values in a2dp-codecs.h files matches specifications.
So this value not.

> > Therefore instead of SBC_MAX_BITPOOL macro, defines two macros, one for
> > minimal value of "Maximum Bitpool Value" and maximal value of "Maximum
> > Bitpool Value".
>=20
> We could define the recommended bitpools by quality, like the A2DP do,
> and then the MAX to 250, that should make it a bit more clearer.

There are eight recommended bitpool values in A2DP (2x quality; 2x mode;
2x frequency). Do you think that it is useful?

Currently I defined these values in pulseaudio sbc codec in "quality"
structure...

=2E.. but seems that a2dp-codecs.h is the place where it should be
defined. So should I put all these recommended values into this file? Or
have it only in pulseaudio?

> > I have no idea what is origin of value 64 as it does not match minimum =
nor
> > maximum bitpool value. Lot of headsets declares maximum value to 53, so=
 use
> > this value also in android/hal-audio-sbc.c
>=20
> We could define 64 as ultra high quality for those that wish a better
> quality than 53, past that there a very limited return in terms of
> quality.

I'm experimenting with value 76 for ultra high quality mode. It has
bitrate 454.8 kbps and minimize unused bytes in A2DP transfer.

But question is, what value do you want to have in file
android/hal-audio-sbc.c? This file is not used on Linux desktop, so I
cannot test this module...

> > ---
> >  android/hal-audio-sbc.c      | 6 +++---
> >  profiles/audio/a2dp-codecs.h | 3 ++-
> >  2 files changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/android/hal-audio-sbc.c b/android/hal-audio-sbc.c
> > index 80e271ed6..541b2d6a7 100644
> > --- a/android/hal-audio-sbc.c
> > +++ b/android/hal-audio-sbc.c
> > @@ -92,7 +92,7 @@ static const a2dp_sbc_t sbc_presets[] =3D {
> >                 .block_length =3D SBC_BLOCK_LENGTH_4 | SBC_BLOCK_LENGTH=
_8 |
> >                                 SBC_BLOCK_LENGTH_12 | SBC_BLOCK_LENGTH_=
16,
> >                 .min_bitpool =3D SBC_MIN_BITPOOL,
> > -               .max_bitpool =3D SBC_MAX_BITPOOL
> > +               .max_bitpool =3D SBC_MAX_BITPOOL_MIN,
> >         },
> >         {
> >                 .frequency =3D SBC_SAMPLING_FREQ_44100,
> > @@ -101,7 +101,7 @@ static const a2dp_sbc_t sbc_presets[] =3D {
> >                 .allocation_method =3D SBC_ALLOCATION_LOUDNESS,
> >                 .block_length =3D SBC_BLOCK_LENGTH_16,
> >                 .min_bitpool =3D SBC_MIN_BITPOOL,
> > -               .max_bitpool =3D SBC_MAX_BITPOOL
> > +               .max_bitpool =3D SBC_MAX_BITPOOL_MIN,
> >         },
> >         {
> >                 .frequency =3D SBC_SAMPLING_FREQ_48000,
> > @@ -110,7 +110,7 @@ static const a2dp_sbc_t sbc_presets[] =3D {
> >                 .allocation_method =3D SBC_ALLOCATION_LOUDNESS,
> >                 .block_length =3D SBC_BLOCK_LENGTH_16,
> >                 .min_bitpool =3D SBC_MIN_BITPOOL,
> > -               .max_bitpool =3D SBC_MAX_BITPOOL
> > +               .max_bitpool =3D SBC_MAX_BITPOOL_MIN,
> >         },
> >  };
> >
> > diff --git a/profiles/audio/a2dp-codecs.h b/profiles/audio/a2dp-codecs.h
> > index 0bdd29110..f31f3a311 100644
> > --- a/profiles/audio/a2dp-codecs.h
> > +++ b/profiles/audio/a2dp-codecs.h
> > @@ -53,8 +53,9 @@
> >  #define SBC_ALLOCATION_SNR             (1 << 1)
> >  #define SBC_ALLOCATION_LOUDNESS                1
> >
> > -#define SBC_MAX_BITPOOL                        64
> >  #define SBC_MIN_BITPOOL                        2
> > +#define SBC_MAX_BITPOOL_MIN            53
> > +#define SBC_MAX_BITPOOL_MAX            250
> >
> >  #define MPEG_CHANNEL_MODE_MONO         (1 << 3)
> >  #define MPEG_CHANNEL_MODE_DUAL_CHANNEL (1 << 2)
> > --
> > 2.11.0
> >
>=20
>=20

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--rq3r4jcprqhwnha5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXE2C4QAKCRCL8Mk9A+RD
UvZHAKDFi8TvUTo+GqUecobga+6D0DX5HACeM8At9sSwqXouqvYvdN0LOzDfnwY=
=gH6o
-----END PGP SIGNATURE-----

--rq3r4jcprqhwnha5--
