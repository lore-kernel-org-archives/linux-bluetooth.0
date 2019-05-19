Return-Path: <SRS0=+1pe=TT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A72C04AB4
	for <linux-bluetooth@archiver.kernel.org>; Sun, 19 May 2019 18:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 754F620449
	for <linux-bluetooth@archiver.kernel.org>; Sun, 19 May 2019 18:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0zotp9f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbfESSPY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 19 May 2019 14:15:24 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51846 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729251AbfESSPY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 19 May 2019 14:15:24 -0400
Received: by mail-wm1-f66.google.com with SMTP id c77so9565958wmd.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 19 May 2019 11:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=45H88xIFMNjPIFDsXs6zJ1PsG04q6nnPFSOR1yduZ9Y=;
        b=k0zotp9fh6GT3ggN29bNbDiiEt2rVuen+qmN6AgvuBENZ/8lOOfqwLyoRrMr7BpCqN
         +7ZPNXUGEhmlwMfJpItMBZyG2C6piAXmcZanQz0yFPIEu52qopOfoaShYOgDKOR6k+Nq
         MnwbYl89NetlHxp6+X28lKzMSmI7U5jyXnEkbIk+qlL5WUeC8P354ZTKLmGrAGL+Smlf
         ECAwYJBgVeznXhtWSxtu2H7P4YlL6mBdhxKm3rnwNbMESPMq3qRP3cW7dfb2LQPRfsWH
         tS+lGmTZtN7dx755+FT9S1JdJfo6dLt/7zKYBFagawwtIbKNwqB5NeDVgCSZzD5TBrpy
         bDgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=45H88xIFMNjPIFDsXs6zJ1PsG04q6nnPFSOR1yduZ9Y=;
        b=cLiOcUU8qRWAOioCv+sfD90VXsUgTKXmn4ULhJ9i/C4fDnNw0EPreaNDMwpCys3IVs
         VtFd938Szk9Y5qLECt204JBHowl34XU/tt0rziTgmn1GKr2Y0mww/DA7UZzeG4E7vrdK
         55M2ul6tIusj6AJjl/QAQcpGZnKxm8gqdHnxpMHiW3JtEaRwSTnAX4r6AWiTMNOeP+pJ
         ld+8Um4MvcPxnLRaurqXiO50anRTXyskYGS0teo/TjOREq7xMwzYFVy6sZqxNbV9Tsu0
         TXXIK9kHKSc3fNDmEcdXJ2lHQr1QPxuz2q/IARejnLilvhcu9QynoHt7shlGW2oaO7zW
         Dahw==
X-Gm-Message-State: APjAAAUgtkXE2mvUvSem/OwWy+uHeiehgn3Tvga0k7LWh7IPOrmLpzH/
        yRzTdQn2kDoEcdyocSdLk70vKJVY
X-Google-Smtp-Source: APXvYqybOI27PAHoPoC7hjHmxbWiztFs7f5hEN6dfuiHN9oJGzMLXXCmdsjvJR8A0dDuB/AMEsiTng==
X-Received: by 2002:a1c:6c0a:: with SMTP id h10mr8508114wmc.135.1558261136176;
        Sun, 19 May 2019 03:18:56 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id 88sm32822666wrc.33.2019.05.19.03.18.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 May 2019 03:18:55 -0700 (PDT)
Date:   Sun, 19 May 2019 12:18:54 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: Is BT_VOICE_TRANSPARENT correctly defined?
Message-ID: <20190519101854.2ygwxeqbixappks4@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="d2jhcayimzemsazp"
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--d2jhcayimzemsazp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

Now I'm looking at BT_VOICE_TRANSPARENT definition which comes from file
include/net/bluetooth/bluetooth.h and it has value 0x0003. It is really
correct? Because it means following format:

  Linear Coding, 8-bit without padding bits, 1's complement

I think that usage of 1's complement is not easy as there is no C type
which matches it. Should not it be 2's complement or rather Unsigned
type?

Seems that main usage of BT_VOICE_TRANSPARENT is mSBC codec and I doubt
that it uses 1's complement signed format (specially as it should be
modification of SBC codec which encode bytes as unsigned type).

There is another define BT_VOICE_CVSD_16BIT with value 0x0060 which
seems to be correct as it means Linear Coding, 16-bit without padding
bits, 2's complement and encoded by CVSD codec.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--d2jhcayimzemsazp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXOEtjAAKCRCL8Mk9A+RD
UtUvAJ4s2ar8XjVsJ12OJXicje8exPkMDgCfZq3yM7weF4mMxWHqsNWnVQPfV1s=
=Aa5s
-----END PGP SIGNATURE-----

--d2jhcayimzemsazp--
