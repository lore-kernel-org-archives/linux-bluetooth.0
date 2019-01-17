Return-Path: <SRS0=DBgY=PZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3EEC43387
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Jan 2019 23:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE5C920855
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Jan 2019 23:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOgRY7h+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbfAQXFC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Jan 2019 18:05:02 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55611 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfAQXFB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Jan 2019 18:05:01 -0500
Received: by mail-wm1-f67.google.com with SMTP id y139so2789773wmc.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Jan 2019 15:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=55o13HJck10oRkGTq0EgmfCtEOc98yEdzzewwYqRyag=;
        b=YOgRY7h+WvoBTs0uIXXCR+Hs3PNriOS/Z4t47/Mbi+TGG76ZRYWZ+K6kihkXWoeg7W
         QzXprseXVAwNQruG+A/BqbJ6dHZ7fYMRXzHuaaiEvwE7z67kKYBZyiteJYzgo1CcnaIV
         RisrNOycfNfaKjLSTQ+IYokOBBFmf4l8dM54f/4Sal76j5HpP36EjSsiphrIw5LlVisN
         hUZrauefHfkSd7q2LjkFReRjunuRj2Sa/kku2RA6NRgQlkdf2ZVOLXyLbzZKuffpNGqb
         JgMfJNcAr/6Y6mJJLPCEoAM55Gt6UkTv1wggev8OlT1glteDoDXJmYbTI5HBkW/AWx7S
         48Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=55o13HJck10oRkGTq0EgmfCtEOc98yEdzzewwYqRyag=;
        b=YAgow3V/1Ib+HkhJT7su0z7QPHFijfFgDvKzHBpOYMP/e9ZA0TyotQDCwIyEtavyyV
         usbFG6kMc647EEjIgE/wYplJvF+Z00i1uSkf2+NIsjjXlSt9hBhg+lUqiyAt9jfVK1gL
         2zj3YS2lBZuEJFM7deaGXmMCn0Eb9R41H1Cz1iA74JJuyshD0B7mIbYutf64IvysJd/B
         K+ikHC3kdKjVDTlxupA0uurIr61aED1gaIrXPzGHuLBrat6nu9+ZSwhwglGk2POw6O6+
         ZjqZApyLKp4PhfjvA/RoBg0YZRe1jQ9O51GVO/+Mtm+Vc9uw34RPPID2HVZVmSRB+rGf
         LGYw==
X-Gm-Message-State: AJcUukeMx0rvuFjYDCXAl56l77rb3jaqtiRTJAz+96eY9hFwVJpPlpgM
        AEMJ2mLlVEJW4mzMPXEdCFRDHmtG
X-Google-Smtp-Source: ALg8bN5CQi4ZkDgk4dI7S6KmN8Klyvkck+a4VwRKBTV8wpfe5emzoTlaxNEYQG+K96G8TjPH0w0bGQ==
X-Received: by 2002:a7b:c757:: with SMTP id w23mr12743201wmk.59.1547766300063;
        Thu, 17 Jan 2019 15:05:00 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id n6sm39484671wmk.9.2019.01.17.15.04.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 15:04:59 -0800 (PST)
Date:   Fri, 18 Jan 2019 00:04:52 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] btmon: Fix parsing A2DP FastStream codec configuration
Message-ID: <20190117230452.hsxwmoz4oks3snrs@pali>
References: <20190113172320.17586-1-pali.rohar@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="6vtn5guzkmdwtkbh"
Content-Disposition: inline
In-Reply-To: <20190113172320.17586-1-pali.rohar@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--6vtn5guzkmdwtkbh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sunday 13 January 2019 18:23:20 Pali Roh=C3=A1r wrote:
> This codec is bi-directional, therefore both sink and source directions m=
ay
> be present in configuration at same time.
>=20
> Some Creative headsets send more frequency bits in configuration and when
> both 41kHz and 48kHz are present then headset expects 48kHz. So adjust
> FastStream frequency table as find_value_bit() takes first matched bit.
> ---
>  monitor/a2dp.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Hello, can somebody review this bluez patch?

> diff --git a/monitor/a2dp.c b/monitor/a2dp.c
> index ffdcbb962..42fe395a1 100644
> --- a/monitor/a2dp.c
> +++ b/monitor/a2dp.c
> @@ -201,8 +201,10 @@ static const struct bit_desc faststream_direction_ta=
ble[] =3D {
>  };
> =20
>  static const struct bit_desc faststream_sink_frequency_table[] =3D {
> -	{  1, "44100" },
> +	/* in config buffer, there may be more frequency bits
> +	 * and 48kHz takes precedence over 41kHz */
>  	{  0, "48000" },
> +	{  1, "44100" },
>  	{ }
>  };
> =20
> @@ -746,9 +748,9 @@ static bool codec_vendor_faststream_cfg(uint8_t losc,=
 struct l2cap_frame *frame)
> =20
>  	l2cap_frame_get_u8(frame, &cap);
> =20
> -	print_field("%*cDirection: %s (0x%02x)", BASE_INDENT + 2, ' ',
> -			find_value_bit(cap, faststream_direction_table),
> -			cap);
> +	/* FastStream codec is bi-directional */
> +	print_field("%*cDirection: 0x%02x", BASE_INDENT + 2, ' ', cap);
> +	print_value_bits(BASE_INDENT + 2, cap, faststream_direction_table);
> =20
>  	l2cap_frame_get_u8(frame, &cap);
> =20

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--6vtn5guzkmdwtkbh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXEEKDgAKCRCL8Mk9A+RD
UrCVAJ92UACitunOvsIG3W5C+QHNz6l8xgCfVEOKa6DonPHTneroHyHDuH6Tac0=
=ZYPr
-----END PGP SIGNATURE-----

--6vtn5guzkmdwtkbh--
