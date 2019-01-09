Return-Path: <SRS0=eb2H=PR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95C6C43387
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Jan 2019 18:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CD2B20859
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Jan 2019 18:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/FKrCll"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbfAISOk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Jan 2019 13:14:40 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36379 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727478AbfAISOk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Jan 2019 13:14:40 -0500
Received: by mail-wm1-f67.google.com with SMTP id p6so9309080wmc.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Jan 2019 10:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SlP3VweZ6FHsDUICqkIz5Ya3bOmfUACHavuvi+4r0mM=;
        b=E/FKrCllkLUMH0FnreM3axQkWWcrEte+E4nXrv+PDC6vl98HX6YqNoI9KN/drVUNCx
         uyQB95xVaSlV2ATYAnZj2Tim7LvsI0qhkZBTtaUIJByvxycEl5rxdjE3CnCF7eljq83n
         xwAmkduaLf80dyynIRBKrNNf5+snvLvCd5Jih0SfZk6ikzrP/MTrEGz3yBea9C3VenFu
         sWe6W4yLT8kc/PPGjf94EFJJQ5v38fZ+TQ7e7pLgbp9uXOObkQJWt/aSDbTaujsARFYv
         WqPhdb7pa0HmraYg7f9mWDrQJD5b9d2RTuOr8cEovntCOuV0kihuCy1iXM5jtX7jL9Th
         izag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SlP3VweZ6FHsDUICqkIz5Ya3bOmfUACHavuvi+4r0mM=;
        b=BS8xU4JxwLcMPQuuDQrANtKjvvFriBsVphDVVQw2tAhpoqLprcM0FuR3Q+VAQIGXN8
         u0bf1ZToRKMZmT6GeZT5fRiJucwF4ymT/iBWhJ8CPhk1HfUrtYIpqNqHS0egkZL2AZBo
         +cigvnRgYPZ3kReG6KVohHcr4D8/6WUTxEONFzF16LK3mVeV2avrr0oS2Z6QYHdXkHp/
         1+4o1VXYt2x8KGI8Ae95xMKMH2RB2Uk6qebPHqyRFAJJOgg4B4c4xP5vl7MvseT4SH00
         goMB1/2naX4bzPnXvMqVO5tAdvhzeE/ZVuFBBYx0Ll5XwwjsqFe7PBTaY55zmK5sI7sX
         eepQ==
X-Gm-Message-State: AJcUukcn/EZUX8PRKH+O7iqDikxDfnHkvJZQklnD2K744DqQ0XmIyGhe
        uBg9I4DvnI7UDq1hXP3YdIU=
X-Google-Smtp-Source: ALg8bN4pfYOti2YICob7BLJwP4Du8HPcfotV+sgTtMaaAEsDybAS6ulvPJ/5bseq5NxmmXEXN19qEg==
X-Received: by 2002:a1c:1d8e:: with SMTP id d136mr6524268wmd.98.1547057678781;
        Wed, 09 Jan 2019 10:14:38 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id b18sm50266967wrr.43.2019.01.09.10.14.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 10:14:37 -0800 (PST)
Date:   Wed, 9 Jan 2019 19:14:36 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Pasi =?utf-8?B?S8Okcmtrw6RpbmVu?= <pasik@iki.fi>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: bluez: dbus method call for switching endpoint
Message-ID: <20190109181436.atlbhkqclpq3kcta@pali>
References: <CABBYNZJuGT5_zhg-BkAc4XjtVu5His92cHTujrin=SMOVbaodQ@mail.gmail.com>
 <20180711144501.ovdxc2expa4bg6sc@pali>
 <20181215202910.j24amjshrvjqprll@pali>
 <CABBYNZLK4tyL8nvWbXxr6VctyEyJkMdwNiWMy4gUge9h9Vb4SQ@mail.gmail.com>
 <20181228191102.GA31975@reaktio.net>
 <CABBYNZ+bwbSkH4qtkuzhE=JY6KAGwJ_E4ABGT_LE6E277eTNDQ@mail.gmail.com>
 <20181229130818.jdcpwlpyoyhdqlf3@pali>
 <CABBYNZK4+K5vRF0JCHFcUjbfzWanp_ju6XfQQJWBtiLqKi=e7Q@mail.gmail.com>
 <20190108165612.5krhgtmce336xjx3@pali>
 <20190109180340.5fh7adag6buij4px@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="k7es2c5p7bwz2jbl"
Content-Disposition: inline
In-Reply-To: <20190109180340.5fh7adag6buij4px@pali>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--k7es2c5p7bwz2jbl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wednesday 09 January 2019 19:03:40 Pali Roh=C3=A1r wrote:
> On Tuesday 08 January 2019 17:56:12 Pali Roh=C3=A1r wrote:
> > On Tuesday 08 January 2019 13:44:24 Luiz Augusto von Dentz wrote:
> > > > > Regarding the API I still didn't have time to start it, so it will
> > > > > take a little longer than I antecipated.
> > >=20
> > > Ive just sent the patches adding support to switch the endpoints, Ive
> > > only tested with a couple of sony headsets so I would appreciate if
> > > you guys could try it as well. Note that the SetConfiguration must
> > > come from the same D-Bus connection as the endpoint that would be
> > > used, also if there is already an stream in place it must also be from
> > > the same client since it would be terminated in the process, this is
> > > to prevent entities fighting to configure with its own priority though
> > > usually we only PA endpoints, if you want to bypass this just for now
> >=20
> > Great! Once patches would be ready I would look at my last A2DP
> > pulseaudio patches [1] and would try to implement switching, including
> > support for bi-directional FastStream codec -- which can benefit from
> > it.
> >=20
> > [1] - https://lists.freedesktop.org/archives/pulseaudio-discuss/2018-Ju=
ly/030344.html
>=20
> Hi! I applied your 6 patches from https://marc.info/?l=3Dlinux-bluetooth&=
r=3D1&b=3D201901&w=3D2
> but whatever I did I was not able to locate in dbus hierarchy list of
> A2DP codecs supported by device.
>=20
> I thought that somewhere in
>=20
> qdbus --system org.bluez /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX
>=20
> I found A2DP codec capabilities...
>=20
> So how to get list of all supported A2DP codecs for particular device?

Ah, I forgot to start bluetoothd with --experimental option. After that
I see sep*

/
/org
/org/bluez
/org/bluez/hci0
/org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX
/org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/sep1
/org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/sep3
/org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/sep5

and qdbus --system org.bluez /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/sep1 org=
=2Efreedesktop.DBus.Properties.GetAll org.bluez.MediaEndpoint1
list them correctly.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--k7es2c5p7bwz2jbl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXDY6CwAKCRCL8Mk9A+RD
UouEAJ9G5bJHms0ysrVCmXyRnytUythZgwCgp1Xem/SpDmYmBs2+1TzOBDslTw8=
=V+rp
-----END PGP SIGNATURE-----

--k7es2c5p7bwz2jbl--
