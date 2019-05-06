Return-Path: <SRS0=wqlf=TG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E06BC04A6B
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 May 2019 13:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DB38206BF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 May 2019 13:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PViFR1YK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbfEFNC3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 May 2019 09:02:29 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39486 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfEFNC2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 May 2019 09:02:28 -0400
Received: by mail-wm1-f68.google.com with SMTP id n25so15045279wmk.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 May 2019 06:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=akvDnnEUVH5uT0k7//j/34GEP7XFXCVdG9ZHZ7LRTQY=;
        b=PViFR1YKFUAWJ+kyDaynsfkY2wqXs1ZfIC8/PYCBqh6lQLUUngf3HzrcWBRud1Azga
         Hlxzfmwp7f5eg7QsE4kro2W9Uv1l6Sfoc3CYTZaQJ1ny+VAg7KQaQvE4UTXFFNh+ADPM
         p3RRsrwwQ5fZinTcHPGvd63zvJRrTpLo0ZGorFVbH3Zw6EPDgqpGbA5dsSSDlrcotxNp
         Q0jRyUKxtUMmqgqojdkQeoTTu7RBhhRqScJO88mg9AZBJGAoJTA19REqZQY8/4yvbiRc
         Or7Hy1dY20Yuvvaa8auL7HcR9GfdP3QsevjXnADpQD7sh4MIilucM0O61q4Bn1pTAqbX
         WYAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=akvDnnEUVH5uT0k7//j/34GEP7XFXCVdG9ZHZ7LRTQY=;
        b=NgieUfAu4R9WFREKfr4W2ElNHnxzTT2hGAdGlul9f+Oy7APip6sBqv78H+rjIxOxG3
         691PB6dkMVaPvoWowDeNDf+laIdyE61OVqpeVrYyGCW1h5XfBKc/iwKf4y8Q+oSyqDlO
         48a0eccDvN90mHMzwlsCe2xFKOGj9gAPggW8MmzfF7ETIKijjoHmLWV96jMCsaEcOFhO
         faaeYVBMhOFbBTY1RTzfDOBHeHLZoA5pJomGPn4X94/ds2/lk66cGEtVrsWsrHwY3Ipk
         JI4P4D+OopjkHQkhu+r5VrDA7J1YAcLSCv5P1KYCbBn65GHjCx54K6KHUqM56jqYMnHM
         Fdpg==
X-Gm-Message-State: APjAAAVXqrc/xt446iWtJ99P+nd0x5L0kQNQfKjvQ0vnOG+fQfh2Dcci
        MIvE2wrKaDxiMFWkf+jJcic=
X-Google-Smtp-Source: APXvYqx7Me+jKFcyVwrS3RXd9xn3Hb/Rs9GjBpcQ/FMUUaCaWu1JI4t/LrfhyDRCbFH/5DbCxjAatQ==
X-Received: by 2002:a1c:e912:: with SMTP id q18mr16281505wmc.137.1557147747275;
        Mon, 06 May 2019 06:02:27 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id g12sm10945971wmh.17.2019.05.06.06.02.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 06:02:26 -0700 (PDT)
Date:   Mon, 6 May 2019 15:02:25 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v3 6/6] a2dp: Reword LastUsed
Message-ID: <20190506130225.smlwgw5cgvhdb35v@pali>
References: <20190506124310.19151-1-luiz.dentz@gmail.com>
 <20190506124310.19151-6-luiz.dentz@gmail.com>
 <CABBYNZJ4+Be+sAXVAL_96qov5Go3BpRwmJtkdOVXC4apfL2K9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="57esw22e3rq4vw7o"
Content-Disposition: inline
In-Reply-To: <CABBYNZJ4+Be+sAXVAL_96qov5Go3BpRwmJtkdOVXC4apfL2K9A@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--57esw22e3rq4vw7o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Monday 06 May 2019 15:46:03 Luiz Augusto von Dentz wrote:
> Hi Pali,
>=20
> I hope this fixes the problems you have been seeing, it should at
> least take care of the issues with wrong order of SelectConfiguration
> and restoring the exact same endpoint used last time.

Hi Luiz! Great, this should make bluez to be more deterministic.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--57esw22e3rq4vw7o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXNAwXwAKCRCL8Mk9A+RD
UhYeAKCi7lIzpbtGEoKA2qFZAFYXyWG4yACeP9Pp4M+NXQbxrYJ3qaefINdhb/Q=
=KXcI
-----END PGP SIGNATURE-----

--57esw22e3rq4vw7o--
