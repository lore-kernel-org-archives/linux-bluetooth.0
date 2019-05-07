Return-Path: <SRS0=jYet=TH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE264C004C9
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 May 2019 08:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB34D204FD
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 May 2019 08:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t6gp+jRg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfEGIxA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 May 2019 04:53:00 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55737 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbfEGIxA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 May 2019 04:53:00 -0400
Received: by mail-wm1-f67.google.com with SMTP id y2so19035251wmi.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 May 2019 01:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Wih2OIcyYsKXpou6CruU54CO0xxCtxd4QblQ3s8rmLc=;
        b=t6gp+jRgeijmWyt+aRY1MyTzJXMbnDC3U+pLAyc/YR9EtQrL/tNAQGBuXV1EKXwveL
         MIMqIiBXtFJuiWNRpcwgEjI+fY5oLLw7OhWcIWbxtaRlfT5h1r1EM/ZNnmoFJquhCvNr
         JO8/6VI94T2JEBaGjdBZpPGLacOnAeuq+mDgUbZtGwU9CJUnkJrCbmI0Mq09Z7/Qjysn
         MSWvwlT6RVMIHw8TET9t9SO/mNZ5/Xt7r3xIGmtgATZJF3zCAhzQg/sGLesTRzbTzm9x
         62EinAZbfpEFwFfD4Wn/QCfaE8qcW0r+EywPRwmQKCYDl77EOm82or1jWX2c8XnEsqIJ
         yDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Wih2OIcyYsKXpou6CruU54CO0xxCtxd4QblQ3s8rmLc=;
        b=CkYcLUKuTgK57qADp+uwdgSqN38AO/ljtSxlwVy1ROjDiuGyTW1iTvUg7I2BPdE98u
         XkCafOkrJzWCMeIXBzp2Z9Y8HNV5XALSxjoriQp8gySEU5FsPCWkzI7zlzqPHlG8elfe
         /8ZdfkA3/Me/x6xSjkqWriRrWrXJtgh0PP/e1oKfJKJQm494LMkD+Q6IUXAJXYsxddCz
         M07EARnvFD4qDkpWLSomusaEuyb79B01HaM/BHgdIgqOdv7hKEAa1TrpqcB0cGrWvuvn
         XnpMUkFgFjtjgCQ7n2wOyKT/J+XPnQnlyTqUwodxVWr32TDRJ5Kt984FJI6I2sKXxEJB
         nwUw==
X-Gm-Message-State: APjAAAUwU6Mcp/5l+wARy4NZ2yEqRDJcQxI4URftF999qz0w5XH8JTHx
        WTCGQY36FxutpaqeKHpflJE=
X-Google-Smtp-Source: APXvYqwui+pUfR6sks2IZdmMpux2FLNX9ocXdpgPkbrgh5xDwore2wVzKH5E1j3rjl0LIZiM0cYUzQ==
X-Received: by 2002:a1c:f311:: with SMTP id q17mr20381804wmq.144.1557219178165;
        Tue, 07 May 2019 01:52:58 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id c11sm10564904wmb.12.2019.05.07.01.52.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 01:52:56 -0700 (PDT)
Date:   Tue, 7 May 2019 10:52:55 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v3 6/6] a2dp: Reword LastUsed
Message-ID: <20190507085255.zplj5ddopl3z5n2v@pali>
References: <20190506124310.19151-1-luiz.dentz@gmail.com>
 <20190506124310.19151-6-luiz.dentz@gmail.com>
 <CABBYNZJ4+Be+sAXVAL_96qov5Go3BpRwmJtkdOVXC4apfL2K9A@mail.gmail.com>
 <20190506130225.smlwgw5cgvhdb35v@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="l6z2737yuj66s7ou"
Content-Disposition: inline
In-Reply-To: <20190506130225.smlwgw5cgvhdb35v@pali>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--l6z2737yuj66s7ou
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Monday 06 May 2019 15:02:25 Pali Roh=C3=A1r wrote:
> On Monday 06 May 2019 15:46:03 Luiz Augusto von Dentz wrote:
> > Hi Pali,
> >=20
> > I hope this fixes the problems you have been seeing, it should at
> > least take care of the issues with wrong order of SelectConfiguration
> > and restoring the exact same endpoint used last time.
>=20
> Hi Luiz! Great, this should make bluez to be more deterministic.

Hi! Now I looked at it and in cache file I see:

LastUsed=3D04:01

What would happen when A2DP application (e.g. pulseaudio) register DBus
endpoints in different order? Or e.g. do not register some endpoints due
to missing codec librayr (aptX).

I guess that in this case LastUsed information stops working...

Should not be there stored rather dbus endpoint name identifier?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--l6z2737yuj66s7ou
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXNFHZQAKCRCL8Mk9A+RD
UkNWAJ9NF2vbHFHhWgcBa1Uamx5sx4EMDACeI81hBG9AVINT4H/JRdT2wPjSdSY=
=4SYd
-----END PGP SIGNATURE-----

--l6z2737yuj66s7ou--
