Return-Path: <SRS0=eb2H=PR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93387C43387
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Jan 2019 18:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 649D620859
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Jan 2019 18:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qKkJM8JZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfAISDr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Jan 2019 13:03:47 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53316 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbfAISDr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Jan 2019 13:03:47 -0500
Received: by mail-wm1-f66.google.com with SMTP id d15so8643782wmb.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Jan 2019 10:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qhMaRELgGLfsYapUzzp0gcSDYgeYkedK//IzIVqSWRg=;
        b=qKkJM8JZl3DaSvlqP6mOs1wIA56K0HmuzmlUWWamCglctMHkjnM7duKOoHegoXxen1
         Lkq63pF6dI4OdOl5IVNQss+Ttl/thnwHW3r/7zFuddEUvaCCi/NAcRvr+dSCPdGk2f5k
         44gCoS47B6i8dqPirvDcPLvQTpAxuxh07fQIHVb78zjd9QSiC7PN9EoeMSLdCn9z+xaX
         gINwYzwVCJcL/ZZo3rz2mDLjhTvxZ0u4+lGRIstXeQHAFKT7FiPH8SvqFFd0DioTNwbD
         xLr4s1Q2wkkiSMewu3WFbjOjVZ+RimYmYtq7/jzBxkO+X7wGzMZsCHpjRG0xwSTYid3c
         2lCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qhMaRELgGLfsYapUzzp0gcSDYgeYkedK//IzIVqSWRg=;
        b=PS9wwuagsw9r3niHYzNGKCztTJraVIdq3/9Ug990ksIfGVeir+uIOBlbWT7QiXE4pX
         jQXH6kKrIJZlO1PA/oAFeNRWG7vRNNDYrPOqFCzdS8SQ9whxIu+smFHEHRtzinBpMqgM
         wYWHF1vfjvuJrmfZHD++DLpzalenHufjpslG8SqQU6AjMQGohRIRreqG1wK+dEeS3k6q
         lZIt7tXUGAv97cv4erR21G+v4gn8bL56Gcn2BO/PAnaMgbpydeCEDiYqgs0WsEGT9Q5b
         kD5M02T9D0skvW5i9TpXv05WKR9Lr2uzed8bhAmrF7GzJFXhvdMJ6TALWdkmmmyCG5kv
         Di2Q==
X-Gm-Message-State: AJcUukf3vz+r/aVy1TNfRBz1qK9NL3KHrOQvsVvzs0MdCn17qB6OX5CK
        eFWRk+gIJeyrfCdLDjlqROw=
X-Google-Smtp-Source: ALg8bN4ALKTXDX0ue4bksdAp8vW3sQOSbSc3H3ytKRLf7qVKYv5tqpyudgQ0wWT4jpUsI7mS4J46Ww==
X-Received: by 2002:a1c:5dd1:: with SMTP id r200mr6948549wmb.93.1547057024416;
        Wed, 09 Jan 2019 10:03:44 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id h184sm3025568wmf.0.2019.01.09.10.03.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 10:03:42 -0800 (PST)
Date:   Wed, 9 Jan 2019 19:03:40 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Pasi =?utf-8?B?S8Okcmtrw6RpbmVu?= <pasik@iki.fi>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: bluez: dbus method call for switching endpoint
Message-ID: <20190109180340.5fh7adag6buij4px@pali>
References: <20180711082352.oo6srapfnol5nkxq@pali>
 <CABBYNZJuGT5_zhg-BkAc4XjtVu5His92cHTujrin=SMOVbaodQ@mail.gmail.com>
 <20180711144501.ovdxc2expa4bg6sc@pali>
 <20181215202910.j24amjshrvjqprll@pali>
 <CABBYNZLK4tyL8nvWbXxr6VctyEyJkMdwNiWMy4gUge9h9Vb4SQ@mail.gmail.com>
 <20181228191102.GA31975@reaktio.net>
 <CABBYNZ+bwbSkH4qtkuzhE=JY6KAGwJ_E4ABGT_LE6E277eTNDQ@mail.gmail.com>
 <20181229130818.jdcpwlpyoyhdqlf3@pali>
 <CABBYNZK4+K5vRF0JCHFcUjbfzWanp_ju6XfQQJWBtiLqKi=e7Q@mail.gmail.com>
 <20190108165612.5krhgtmce336xjx3@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2jqdqnxblwzpyd23"
Content-Disposition: inline
In-Reply-To: <20190108165612.5krhgtmce336xjx3@pali>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--2jqdqnxblwzpyd23
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tuesday 08 January 2019 17:56:12 Pali Roh=C3=A1r wrote:
> On Tuesday 08 January 2019 13:44:24 Luiz Augusto von Dentz wrote:
> > > > Regarding the API I still didn't have time to start it, so it will
> > > > take a little longer than I antecipated.
> >=20
> > Ive just sent the patches adding support to switch the endpoints, Ive
> > only tested with a couple of sony headsets so I would appreciate if
> > you guys could try it as well. Note that the SetConfiguration must
> > come from the same D-Bus connection as the endpoint that would be
> > used, also if there is already an stream in place it must also be from
> > the same client since it would be terminated in the process, this is
> > to prevent entities fighting to configure with its own priority though
> > usually we only PA endpoints, if you want to bypass this just for now
>=20
> Great! Once patches would be ready I would look at my last A2DP
> pulseaudio patches [1] and would try to implement switching, including
> support for bi-directional FastStream codec -- which can benefit from
> it.
>=20
> [1] - https://lists.freedesktop.org/archives/pulseaudio-discuss/2018-July=
/030344.html

Hi! I applied your 6 patches from https://marc.info/?l=3Dlinux-bluetooth&r=
=3D1&b=3D201901&w=3D2
but whatever I did I was not able to locate in dbus hierarchy list of
A2DP codecs supported by device.

I thought that somewhere in

qdbus --system org.bluez /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX

I found A2DP codec capabilities...

So how to get list of all supported A2DP codecs for particular device?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--2jqdqnxblwzpyd23
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXDY3ewAKCRCL8Mk9A+RD
Ul/6AKCLTI39N0rCVclnQCCHIduKl+Z/CwCfRNDf7vURAMtpJmNDUBrill/TY1U=
=oGsg
-----END PGP SIGNATURE-----

--2jqdqnxblwzpyd23--
