Return-Path: <SRS0=bh0L=UG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D1EC2BCA1
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Jun 2019 15:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0B8E20840
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Jun 2019 15:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VoNLpC+s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729606AbfFGPhT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Jun 2019 11:37:19 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36766 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728247AbfFGPhS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Jun 2019 11:37:18 -0400
Received: by mail-wm1-f66.google.com with SMTP id u8so2374147wmm.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Jun 2019 08:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WQ5BFB32/z9FL2Rjf6S24FVllQJa/5KgD9zIP7bNK68=;
        b=VoNLpC+sbRaLvaMa4OkBZ+0Wtvab92F5NSbUwwNOnwI4G4O+cgEuaOLHKNuP5J+hiW
         DXQlVwuG7u0iCPU1f/yLw2lK6S5FEqx8ArmYYmU6di2vGog360XNEFCILI/wNP72Uuhg
         8vVbB2pg+fsyrmfmQUpJuWj6ex2wHodWGkSqzV5lORjpwxClT4u0hElf2zgQHzDKDUHb
         gdmO9TFtC37a7YS+u+kcWWH4qEEZBggIUzonucmXUXz//RIljU/pKpGQy9Jr8WdFGkN0
         BrPqk3u2KL3TUr8HSoWlUU/EsVFQ2VNEClFKQp286WeEsO1LIC1rrWPB7Hx46AzPmwQ+
         TKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WQ5BFB32/z9FL2Rjf6S24FVllQJa/5KgD9zIP7bNK68=;
        b=OtMkDoUg+KaAR2bJZ8za4e1pfCqUdkxwdlhP4tysY2ocz0v3BbNrxFS7cMq7Gqm7XA
         yXi3EBBqpNc289w8Oq2jgsaV4CP4+nM0QvXbRAAvBRtGni7UaAd3NmTsuz6rh6NWB2LA
         kLsCuTlsZylvohg+e6TafwcmGg5o2TkK0UDNjpPXzCC7wfFMCSp5yLxb0OCTgzVZA8Ps
         melh14dLVEHYK0wq0G9oIDTW901s7vA4Pa7wx0kGWk51PPGLaJ3gM89kOZDof6/a7Xtk
         fWq57wxkqfEbYxW/JSbgTjPfsr/7nX84MEZKAtP4Kd8iSBQM8hiaiJmHWo9yFXHWnSJb
         vtBw==
X-Gm-Message-State: APjAAAXCJYriP6iC0dYydz1nE8gtLURvznKPvxKi67L7pbvyi6nn+EKf
        MdSkoQ4lVG8TWa5AJzFeVkE=
X-Google-Smtp-Source: APXvYqzNjnXm6xNk881+Y7FGECcwyG3oFJULseEY6djTxs/Q7o4r1st/OUrBaNVHEGBrUC1KQcCIKg==
X-Received: by 2002:a1c:988b:: with SMTP id a133mr4074199wme.21.1559921836979;
        Fri, 07 Jun 2019 08:37:16 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id c5sm2849140wma.19.2019.06.07.08.37.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 08:37:15 -0700 (PDT)
Date:   Fri, 7 Jun 2019 17:37:15 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: bluez - check for new a2dp features
Message-ID: <20190607153715.w5exsodd25qxc6xv@pali>
References: <20190513170550.bsbr2mh7w36hj7io@pali>
 <20190607125800.trsx2o3njaiaitu2@pali>
 <CABBYNZLtgaCi5VGHapsKQG4iAC33ySow3AuH0Qkx8iCo3LcZDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5vc2ys24neyidwjr"
Content-Disposition: inline
In-Reply-To: <CABBYNZLtgaCi5VGHapsKQG4iAC33ySow3AuH0Qkx8iCo3LcZDg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--5vc2ys24neyidwjr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Friday 07 June 2019 18:26:02 Luiz Augusto von Dentz wrote:
> Hi Pali,
>=20
> On Fri, Jun 7, 2019 at 3:58 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wro=
te:
> >
> > On Monday 13 May 2019 19:05:50 Pali Roh=C3=A1r wrote:
> > > Hello!
> > >
> > > In current git bluez master repository are new features related to A2=
DP.
> > > E.g. support for codec switching or fallback to other local dbus
> > > endpoints when current selected rejected connection...
> > >
> > > Moreover codec switching support is behind experimental runtime switc=
h.
> > >
> > > For pulseaudio a2dp module I need to do runtime check if above featur=
es
> > > are supported by currently running bluez instance (which registered to
> > > dbus org.bluez. It is needed to ensure that pulseaudio does not
> > > introduce regression for older bluez version without above new A2DP
> > > features.
> > >
> > > But currently I have not found any way how to detect if bluez supports
> > > codec switching or if it has support for trying another local SEP for
> > > connection.
> > >
> > > So, could you please export e.g. bluez version as dbus property? And
> > > also property if codec switching is supported and enabled by that
> > > experimental flag?
> >
> > Hello, I would like to ask for some possibility to export these
> > information. Without them it is not really possible to have stable
> > implementation which would work with both old and new bluez version.
>=20
> I wonder what you are talking about since your changes do have checks
> for when endpoints are detected,

But this does not work as endpoints are available on DBus only when A2DP
connection is active. I already asked to export them always (even when
A2DP is not connected).

Main problem is that when profile switching is not available, there
should be registered only one A2DP codec (SBC in automatic quality) as
changing is not possible. This is to prevent introducing any regression
or having registered codec which would not work correctly.

> isn't that enough to detect if one can switch codecs or not?

Yes, this could be enough... but endpoints on DBus must be always
available, not only when A2DP profile is connected.

> This logic used to work just fine last time I tested it.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--5vc2ys24neyidwjr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXPqEqQAKCRCL8Mk9A+RD
UhyFAKCtXZj++pKqW/L9nH/zZwwVDXwI7gCfSXtX4BLVfrGAKblKUmTAspDLa6A=
=cADY
-----END PGP SIGNATURE-----

--5vc2ys24neyidwjr--
