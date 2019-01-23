Return-Path: <SRS0=X26K=P7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BC8C282C0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jan 2019 17:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C23621872
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jan 2019 17:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u58VZ9xa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfAWRyv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Jan 2019 12:54:51 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46007 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfAWRyv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Jan 2019 12:54:51 -0500
Received: by mail-wr1-f66.google.com with SMTP id t6so3507469wrr.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jan 2019 09:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6W4EO/uPGGNHDzuzrAgH7PyfhfuINf/YGdzMN44ufzs=;
        b=u58VZ9xaKuK0LFtRyIk5lCi58pjICUxiZZnSPOMMZkcit2740N6/OlHkjmSJrJe3yt
         EuhC0XRnNToI73iAu3uI71tRY1+5K3EM1vTeidtIpq0YG5JiFKvn0CufaxPp/pCmZqBi
         L9L2P+dAnoHtvCQ1cH+A6Ajy6ztGGE/xaRUmdmQjGg5/EIAapgDNRkthRoIxihl3K/c9
         8m3Qc04eNdgUQKxf1Y245CnxIje6Jy5szqqXVciE/pZ9D7S9VMX8q8HleCBu8V++UorG
         F4cv4b8wEQxiUNPHpJahNxj0AGDOchDQQS0wj2HSWOPnlSK5cMDFh/JfHAcwBPrB1HoJ
         +Jgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6W4EO/uPGGNHDzuzrAgH7PyfhfuINf/YGdzMN44ufzs=;
        b=NsHzG5Iv8m1oyWRqSG5N5+WAtpca+/pQJ/Ns7pynxhXhLVEiQiLzaJ/fdyqxZkNKe4
         sWUX1X81SF23kCnLOAzVzldg9MSTWNCzsoMDBNa/fE8S1r2nTIqrwL6HWWG0kNOi21Po
         DBZ8Gw/u0C6feV7KJLDErHHkTrTt0W+XNudWPVnAoZV/Gw26BuKs4w+ExJXscualeK2i
         WI2ziFOtTiOApW6VpjQYl17AnZ158UHztWql/iIwLmKv8M3Kn6rz5xyIvDlop5voWAyP
         bJ2qSCQizlFqhfdH9m8am06FDgr3oP7l5l4smLJsK0RXkv/8JjVY0T/Fpf9UO0TfxXpu
         5pAg==
X-Gm-Message-State: AJcUukclKdzUZ808+IStViheQePAHSLhZcGbroFDUj1PremEHkTTkobY
        7x03dOsX6PdKqRo7ysTbSJdckxeN
X-Google-Smtp-Source: ALg8bN4DR/aBNqg0NsS2TD8x9BnVr567wppdHoD4HStSg7AugX9BvLbNRtdC9vo/auOfzaJpGHQ0SQ==
X-Received: by 2002:a05:6000:10d1:: with SMTP id b17mr3771755wrx.306.1548266089787;
        Wed, 23 Jan 2019 09:54:49 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id b129sm47098029wmd.24.2019.01.23.09.54.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 09:54:49 -0800 (PST)
Date:   Wed, 23 Jan 2019 18:54:48 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] tools/hcidump: Decode FastStream, aptX Low Latency, aptX
 HD and LDAC
Message-ID: <20190123175448.cdkdpnk6i5r4rzjs@pali>
References: <20190123174504.12350-1-pali.rohar@gmail.com>
 <8D9BABBE-2BBC-4BFE-BF7C-3BE24AF4DD10@holtmann.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="mw6qrruw7sdr4cyf"
Content-Disposition: inline
In-Reply-To: <8D9BABBE-2BBC-4BFE-BF7C-3BE24AF4DD10@holtmann.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--mw6qrruw7sdr4cyf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wednesday 23 January 2019 18:46:18 Marcel Holtmann wrote:
> Hi Pali,
>=20
> > ---
> > tools/parser/avdtp.c | 58 +++++++++++++++++++++++++++++++++++++++++++++=
++++---
> > 1 file changed, 55 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/tools/parser/avdtp.c b/tools/parser/avdtp.c
> > index 18569c895..a21410f5a 100644
> > --- a/tools/parser/avdtp.c
> > +++ b/tools/parser/avdtp.c
> > @@ -155,6 +155,12 @@ static char *vndcodec2str(uint32_t vendor, uint16_=
t vndcodec)
> > {
> > 	if (vendor =3D=3D 0x0000004f && vndcodec =3D=3D 0x0001)
> > 		return "aptX";
> > +	else if (vendor =3D=3D 0x0000000a && vndcodec =3D=3D 0x0001)
> > +		return "FastStream";
> > +	else if (vendor =3D=3D 0x0000000a && vndcodec =3D=3D 0x0002)
> > +		return "aptX Low Latency";
> > +	else if (vendor =3D=3D 0x000000d7 && vndcodec =3D=3D 0x0024)
> > +		return "aptX HD";
> > 	else if (vendor =3D=3D 0x0000012d && vndcodec =3D=3D 0x00aa)
> > 		return "LDAC";
> > 	return "Unknown=E2=80=9D;
>=20
> lets keep the focus on btmon support since nobody should be using hcidump=
 anymore.

In btmon I already implemented it and patches are now merged. I just
found another place where this capability parsing is implemented and
based on fact that users still use hcidump I quickly looked at it and
implemented this parsing.

> Regards
>=20
> Marcel
>=20

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--mw6qrruw7sdr4cyf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXEiqZgAKCRCL8Mk9A+RD
Uvd4AJ9hoY/F69pDIVQ8vf2mOa/Obftz0QCeKiZlZX7AwXZEfFhHy7sa8neW76M=
=gPTF
-----END PGP SIGNATURE-----

--mw6qrruw7sdr4cyf--
