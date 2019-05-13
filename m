Return-Path: <SRS0=zNJH=TN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2734C04AA7
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 May 2019 17:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FC0A208CA
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 May 2019 17:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3JeUeVg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730247AbfEMRFy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 May 2019 13:05:54 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51173 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729836AbfEMRFy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 May 2019 13:05:54 -0400
Received: by mail-wm1-f68.google.com with SMTP id f204so131276wme.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 May 2019 10:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=b9Hw9PIZo1GnGSbyaTmg9XDM6xNavPXNDe/9yak5sF4=;
        b=i3JeUeVg7Lg8NWBWYkEcP5LHxpXHPY/vGX8PO45RKUozmui8cKozmGyOjepEGvkOfS
         NOwkOpbzSZC3pFsR1LPD5z7+YelRsvxfrWe44SEy1oP2PS5bt+JM4UefxGymXUB0p/YO
         DS8V0g4aYuxyLybDgK+BwPhOQl6B2GE/lf2H8yCa3vyzGb0nLks5IihJMfO8Bw2+CPQR
         YBw8LYnpLf9W1kU9ol7uvKCVL/KKQWTudIHqs/L+KYAkGCh0JWOShYXOHhE0f08QxndV
         PnUy16oyMLIytpuq384Xb54Uk08UDTgIdCPf1qeLbl63jXSZBPEohlNl7Pt4vCPF4wk+
         h5xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=b9Hw9PIZo1GnGSbyaTmg9XDM6xNavPXNDe/9yak5sF4=;
        b=UeLyGM7rKeNMeG5bF47Va5Zl643dWkmzusnEI5J9CIVsB/QhYAuuodGr3f+cTUmyI2
         H+gBpBb/71SeJOTa/Heh2bXUfHme9jEKoJTD0F3SiGGHbTgqe7iOhSIv5q+i4RAYJvNg
         oDYc0kDxwLcQZRqAyrSiHGiSBKemGvxdNGR1AAUvbSKday3/KS3oeGxqWgvI0EIgBgEK
         /Gs6nwk/YdMWQPq3fLFLiqKuYlzyRZTfgwTiiFx8lbBpt92yBQIGb4OaOcqT0UjxQ2Y1
         HkJw0SVnQvuaNdCqCavpRSURMo96xHHqcelwQZnPSGoESZi7D9xcApVD+lHUKtfxoIOQ
         hgBA==
X-Gm-Message-State: APjAAAVNo/uMII+Da+LXf4bGlap7RHT/V3m+vRr1GzMRdQwNNyautEaS
        UvygQALQyhznozCkN051RbjZp2R7
X-Google-Smtp-Source: APXvYqxmrelbJzIXgLcuC3UMdQ5zE6uVfHH+JL40SpXJJCjBY4d67l0cuc0dVajPFwTbQKMh88UTzQ==
X-Received: by 2002:a1c:4102:: with SMTP id o2mr15406781wma.91.1557767153048;
        Mon, 13 May 2019 10:05:53 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id s10sm13098337wrt.66.2019.05.13.10.05.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 10:05:51 -0700 (PDT)
Date:   Mon, 13 May 2019 19:05:50 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     linux-bluetooth@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: bluez - check for new a2dp features
Message-ID: <20190513170550.bsbr2mh7w36hj7io@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="gi7po7myt6wkgotd"
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--gi7po7myt6wkgotd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

In current git bluez master repository are new features related to A2DP.
E.g. support for codec switching or fallback to other local dbus
endpoints when current selected rejected connection...

Moreover codec switching support is behind experimental runtime switch.

For pulseaudio a2dp module I need to do runtime check if above features
are supported by currently running bluez instance (which registered to
dbus org.bluez. It is needed to ensure that pulseaudio does not
introduce regression for older bluez version without above new A2DP
features.

But currently I have not found any way how to detect if bluez supports
codec switching or if it has support for trying another local SEP for
connection.

So, could you please export e.g. bluez version as dbus property? And
also property if codec switching is supported and enabled by that
experimental flag?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--gi7po7myt6wkgotd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXNmj7AAKCRCL8Mk9A+RD
UkMBAJ9KOFZ8DZGohKVVc/ZJTxKv6viurACgw0Exxu7LzTp1IPGjgCQPiKUS6+I=
=GiIV
-----END PGP SIGNATURE-----

--gi7po7myt6wkgotd--
