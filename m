Return-Path: <SRS0=sr2f=PQ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5BCC43612
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Jan 2019 16:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCED020883
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Jan 2019 16:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlCE4f6x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbfAHQ4R (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Jan 2019 11:56:17 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35258 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728788AbfAHQ4Q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Jan 2019 11:56:16 -0500
Received: by mail-wm1-f66.google.com with SMTP id t200so5183081wmt.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Jan 2019 08:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a+bAqw0B2EGsv0BQQ1xbxpfNNqA4lKqTb3ZfNdzj4wQ=;
        b=BlCE4f6xZuGXPQ8iTIxm/yuWI3GZVxo4r5eUWgiKTkJhv3KKMmsz8KIUpncLAqdmiI
         NNz6h2PbWFeflSGFhn++AFm5f+e4kCguYjRyZEkvtMcfodqx70h6smB6RZ85lUEzuxZw
         6DOZ+gkxjnALV3SXFtBDDUbNVkvuJFd7Ul6xfkksf4Qlb1O4otTSDmozQ2WJWUOa7L48
         aOAAT8Fgz8el00cT4iguXKMbWIRWAfjAQH/D7whDvo+MMKhMPKbFZrKeeFa+kHJyLRvg
         4iDy58I0ZqRw6wfwUpszeGm3GLW7SvnLMDmT8hrf8hZFz60ooTIzfSd5QNIVvzQHOKVd
         gIcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a+bAqw0B2EGsv0BQQ1xbxpfNNqA4lKqTb3ZfNdzj4wQ=;
        b=oFAjnLIEiGpd6bQplK4tnAAbestJzmgioy06ZJma+Vqn4OIZSq1UT/ilf19lEfRMEq
         WYithq/APDq45alPivG1aXZAUT/PLs+7EYzsxFm93AGnJldzgcY04EbrSRgGXYiRkZLr
         V/0pfO+EZKDCqEfglDfNMfSEzIBGUR81mumiEmbIeDJu3I2+v/q9EmG+EBzHsCeKnfXD
         3RnXxTGi9Bdu6BaQAj53xPSYdpOb1kmOF1LR7RU1h+uBhVnA5d6tXjURo7w7FKDDqwjo
         b0ONdXZvzk1JUbzTgERYAQhlYMtjJhmdX+gtMpYb3maLu1Vuscu1HD/cTdWLHxxJvHUL
         RCBw==
X-Gm-Message-State: AJcUukd28089YM0wT1KJ7vBLx3zBBtfBEcqKYUyDSU6QPdiZMbIK5tKW
        F8K7+Lb6AuyXLM0C4oQ+80w=
X-Google-Smtp-Source: ALg8bN5IgopfUVcSEuFe3OvZU2YZRVn1ap9Nlfrh6VvZGYDdZbhOcS9FAQukjZz6q7OJjgblsvFzbQ==
X-Received: by 2002:a1c:90cb:: with SMTP id s194mr2297364wmd.57.1546966574653;
        Tue, 08 Jan 2019 08:56:14 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id p139sm20266428wmd.31.2019.01.08.08.56.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 08:56:13 -0800 (PST)
Date:   Tue, 8 Jan 2019 17:56:12 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Pasi =?utf-8?B?S8Okcmtrw6RpbmVu?= <pasik@iki.fi>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: bluez: dbus method call for switching endpoint
Message-ID: <20190108165612.5krhgtmce336xjx3@pali>
References: <20180711082352.oo6srapfnol5nkxq@pali>
 <CABBYNZJuGT5_zhg-BkAc4XjtVu5His92cHTujrin=SMOVbaodQ@mail.gmail.com>
 <20180711144501.ovdxc2expa4bg6sc@pali>
 <20181215202910.j24amjshrvjqprll@pali>
 <CABBYNZLK4tyL8nvWbXxr6VctyEyJkMdwNiWMy4gUge9h9Vb4SQ@mail.gmail.com>
 <20181228191102.GA31975@reaktio.net>
 <CABBYNZ+bwbSkH4qtkuzhE=JY6KAGwJ_E4ABGT_LE6E277eTNDQ@mail.gmail.com>
 <20181229130818.jdcpwlpyoyhdqlf3@pali>
 <CABBYNZK4+K5vRF0JCHFcUjbfzWanp_ju6XfQQJWBtiLqKi=e7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="66g63gj2jo2avyud"
Content-Disposition: inline
In-Reply-To: <CABBYNZK4+K5vRF0JCHFcUjbfzWanp_ju6XfQQJWBtiLqKi=e7Q@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--66g63gj2jo2avyud
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tuesday 08 January 2019 13:44:24 Luiz Augusto von Dentz wrote:
> > > Regarding the API I still didn't have time to start it, so it will
> > > take a little longer than I antecipated.
>=20
> Ive just sent the patches adding support to switch the endpoints, Ive
> only tested with a couple of sony headsets so I would appreciate if
> you guys could try it as well. Note that the SetConfiguration must
> come from the same D-Bus connection as the endpoint that would be
> used, also if there is already an stream in place it must also be from
> the same client since it would be terminated in the process, this is
> to prevent entities fighting to configure with its own priority though
> usually we only PA endpoints, if you want to bypass this just for now

Great! Once patches would be ready I would look at my last A2DP
pulseaudio patches [1] and would try to implement switching, including
support for bi-directional FastStream codec -- which can benefit from
it.

[1] - https://lists.freedesktop.org/archives/pulseaudio-discuss/2018-July/0=
30344.html

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--66g63gj2jo2avyud
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXDTWKgAKCRCL8Mk9A+RD
UlE2AKCkdAxU0ReRC4EnH9F6a3ZTYp2D3gCeJWVBjIIuKjZYF1xrBq2fuE3ffI0=
=HXqO
-----END PGP SIGNATURE-----

--66g63gj2jo2avyud--
