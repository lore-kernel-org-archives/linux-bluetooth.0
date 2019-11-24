Return-Path: <SRS0=IqEA=ZQ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040E0C432C3
	for <linux-bluetooth@archiver.kernel.org>; Sun, 24 Nov 2019 23:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB4C22067D
	for <linux-bluetooth@archiver.kernel.org>; Sun, 24 Nov 2019 23:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khFz0xjh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfKXXR5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 24 Nov 2019 18:17:57 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35964 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfKXXR5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 24 Nov 2019 18:17:57 -0500
Received: by mail-wm1-f68.google.com with SMTP id n188so11761863wme.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 24 Nov 2019 15:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YnXGwJdqPKQ3omg/jd31KX6F4G+ZZOWT8nOX5ocwo1o=;
        b=khFz0xjhHezMpIqm2UkfJlllCbUaiuHlyS++l5zjD22mfx7czeIT4rCAEp5eiqsVhW
         RntFYw/sB0EqFkr0HtntuvZUjKedhIqqt0HDlUBqqm4W9+sS584+EijOSS82HH3WBNkt
         tyDyBLiLsuYE863LVaf+S4Tepqt0P3hZmatwRfloFzx9lsJ7Df8yUdFWshYXiW7WFOV8
         QmrltjgXUQdfz4DvlXhEimvFNWYf4py7ocbuM0390z9KvtGZN1RwqURoWvZwUF84Q0yh
         IO8oMJZg9JRKeEXO6Nx0BzNql6Jo1v8c/xW4TjDJBBzhQpAHCg2YlsYWI+58TcsWPVzQ
         t6Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YnXGwJdqPKQ3omg/jd31KX6F4G+ZZOWT8nOX5ocwo1o=;
        b=p9NnRmAkIGE9KT4SFFCUtXwCn5JMXv7md0cmuhOd8K1GCoLmx8X6rPUYIIz09cayj9
         JBo7883fc8eWuUmfQP8OUUPdHcI9M1ww7NYUpOQnH3Q0JIuTn0TPDnUl6i3YxQpINWXj
         A9eyVADcuJWA2boAkOjWb+8m9RQB3jKbuVSPQMxX9Js7WT31ErgkPhUZdCahR98QzPBA
         mjY7cT4prNs3s7COWggdm3GczrRq/TmZn9xYKajIxyTugrxd6fw5Xy6Kd3bOSYO2pVQX
         SQdOdkNtz/26R7PIJ4CoNLE7hdN5QsTU4xC8NbcmQ4UzwZ7rI9lLp2RU38hOm7IK3zYt
         uzxg==
X-Gm-Message-State: APjAAAVnTHkdKyTe3mhrbO2qaA0w6oChRGDxSwgxsmWfITJAoFlWzK4F
        +6PX/aJnqd2wEyw+dmuku2AS05vf
X-Google-Smtp-Source: APXvYqwgTzYiB0en5tiPdv+Q08An52HMNohMv2/qxl54omo2gSAZhWtnlG9PItDPgcEHl0rkLd3VbQ==
X-Received: by 2002:a1c:740a:: with SMTP id p10mr25873239wmc.121.1574637474600;
        Sun, 24 Nov 2019 15:17:54 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id m13sm6655050wmc.41.2019.11.24.15.17.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Nov 2019 15:17:53 -0800 (PST)
Date:   Mon, 25 Nov 2019 00:17:52 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: Re: Bluetooth HFP 0.96 specification
Message-ID: <20191124231752.bfjbshqaihopwxd6@pali>
References: <20191122220842.5ofrsakoyebs5wgk@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="yhweoli7pgsk6mki"
Content-Disposition: inline
In-Reply-To: <20191122220842.5ofrsakoyebs5wgk@pali>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--yhweoli7pgsk6mki
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Friday 22 November 2019 23:08:42 Pali Roh=C3=A1r wrote:
> Hello!
>=20
> I would like to ask if somebody has specification for bluetooth HFP
> profile, version 0.96 or older.
>=20
> I tried to find it, but from official site version 0.95 was removed [1].
> On web.archive.org is mentioned new version V0.96, in file HFP_0_96.pdf
> but it was not archived.
>=20
> Why I'm asking for older version? Because there are still devices which
> support only HFP version 0.96 and I want to look what was changed...
>=20
> So has somebody copy of that HFP_0_96.pdf file? Or access to removed
> 0.95 version official site?
>=20
> [1] - https://www.bluetooth.com/specifications/archived-specifications/
> [2] - http://web.archive.org/web/20021204225514/http://www.bluetooth.org/=
specifications.htm

Now I found some copy on internet. If somebody is interested, this
specification was mentioned on bluetooth.com in past [3] under file
Hands_Free_Profile_0_96.pdf. Web archive does did not archived this
file, but I found copy of such file with same name at [4].

[3] - http://web.archive.org/web/20020407225138/http://bluetooth.com/dev/sp=
ecifications.asp
[4] - http://simon.dehartog.nl/datasheets/protocols/Hands_Free_Profile_0_96=
=2Epdf

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--yhweoli7pgsk6mki
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXdsPngAKCRCL8Mk9A+RD
UrDAAJ9h0tKXGNHl1booHrFgmOmzBi9gcgCfdgtxf8hNbA1LwoGXau0EYBKb9T8=
=KZGC
-----END PGP SIGNATURE-----

--yhweoli7pgsk6mki--
