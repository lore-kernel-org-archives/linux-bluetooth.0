Return-Path: <SRS0=1j7M=2I=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40122C43603
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Dec 2019 17:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B74320717
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Dec 2019 17:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MuFOiQna"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfLRR2d (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Dec 2019 12:28:33 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35745 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727286AbfLRR2d (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Dec 2019 12:28:33 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so2839445wmb.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Dec 2019 09:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hSD6VkJBM8P+vYTSlKWbo2tIq01IgNsmCefTS/C3zOo=;
        b=MuFOiQna1GsrbikwEDpSTt8wiuW5PF0CbS31cqptMlzrN5b5nKyf+qyXTJdFpHZI96
         DVVK1no3UqlYPYtN0SXdCWSP1OOHkfdo0K1Zc0P6ydsh9Z2jux8gkJTStWWfymTqTlXs
         NuSw3+zrDKb8xutp6L9ZSNb7BOjWHrOK6kyAu09Ita1s6YXxqssWSiJ5Wiwca4oHX1eS
         oceXRnvGddtA9zJYLSyVQJA4th7MTqBAzKSrd9eQxk1tTHnx83g47vaq1riR/RhJFIAL
         feJdtJwLfuT3uUZ25dqhrHhsE7kvOcQXZM5H/AfHYFU0JI3IXpsx1P7EfnFRFmRAlRg9
         DhpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hSD6VkJBM8P+vYTSlKWbo2tIq01IgNsmCefTS/C3zOo=;
        b=mxFZ9KL2+PD2upqmDnXhgdbWhsb2FUZB+xcRLO+tnHvZjzXP5B69YYg2Gb4nCgVNJ2
         vvK6fAjh70xdSFlniJ1rIonMILOEYG4wvfolKZoyI/kwjI5cv1374w4kycjQRtqgXMCJ
         KzJeS8VtzdN3TM6WnpQxY5o1TJec66widK/FpiqC1ZjdaAxlopk/Y6ujAJvMX6vocvBT
         j0553Iz5lQBx4861d8bKQ2iQEMy5VYgQDlXKw2ydEjOoK5ZcVndnZ+8/T6JoSEe8Q86V
         yUcUeTjGHW8JJrc0BvkyhvySONRzvgZ0ah5e1qncrX15uF2Dby4ZCpzr3sy58y0GC+e+
         gUCw==
X-Gm-Message-State: APjAAAWvkq08VaBKA0WA9fneuuX+sg6hJiuIBq6z9TdaSu2t02B4jWnr
        RqHRyHN8tB3cJyNUksmJ5oA=
X-Google-Smtp-Source: APXvYqyUbmmJLROsFLEtYlbNTLDAQed80/Co3OuuCHS8HOA4c9CFPfVwflH/Ugoqj/hxkCVdj6+Zbw==
X-Received: by 2002:a7b:c7d4:: with SMTP id z20mr4919379wmk.42.1576690111423;
        Wed, 18 Dec 2019 09:28:31 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id f1sm3319331wro.85.2019.12.18.09.28.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Dec 2019 09:28:30 -0800 (PST)
Date:   Wed, 18 Dec 2019 18:28:28 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Denis Kenzior <denkenz@gmail.com>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Tanu Kaskinen <tanuk@iki.fi>,
        General PulseAudio Discussion 
        <pulseaudio-discuss@lists.freedesktop.org>, ofono@ofono.org,
        devkit-devel@lists.freedesktop.org,
        Bastien Nocera <hadess@hadess.net>,
        Georg Chini <georg@chini.tk>,
        Russell Treleaven <rtreleaven@bunnykick.ca>,
        Arun Raghavan <arun@arunraghavan.net>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sebastian Reichel <sre@ring0.de>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [pulseaudio-discuss] Proposal for a new API and usage of
 Bluetooth HSP and HFP profiles on Linux
Message-ID: <20191218172828.vfie4su2whts2fqh@pali>
References: <20191201185740.uot7zb2s53p5gu7z@pali>
 <508d35f29c2abc26af15e232a38d3ca53eb33706.camel@iki.fi>
 <20191202184512.rx6p63c6axztnwrw@pali>
 <20191205093200.x47npi5sxtcphr2o@pali>
 <CABBYNZKi7UUg7kASKadGr7sDJH0-tfuuZr9rd4Xu8ZUA9LqTMA@mail.gmail.com>
 <20191216091521.reh2urr25husschv@pali>
 <3ca53c66-1df0-41bf-710e-dea709906234@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="va5fw7oilj7u64cd"
Content-Disposition: inline
In-Reply-To: <3ca53c66-1df0-41bf-710e-dea709906234@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--va5fw7oilj7u64cd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wednesday 18 December 2019 11:00:07 Denis Kenzior wrote:
> Hi Pali,
>=20
> On 12/16/19 3:15 AM, Pali Roh=C3=A1r wrote:
> > Hi!
> >=20
> > On Monday 16 December 2019 00:11:04 Luiz Augusto von Dentz wrote:
> > > Hi Pali,
> > >=20
> > > On Thu, Dec 5, 2019 at 11:32 AM Pali Roh=C3=A1r <pali.rohar@gmail.com=
> wrote:
> > > >=20
> > > > On Monday 02 December 2019 19:45:12 Pali Roh=C3=A1r wrote:
> > > > > On Monday 02 December 2019 19:01:11 Tanu Kaskinen wrote:
> > > > > > I think hsphfpd should be part of bluetoothd, but if that's not
> > > > > > possible, then that's not possible.
> > > > >=20
> > > > > I do not know if bluez developers are interested in having this c=
ode as
> > > > > part of bluez project, specially when in bluez4 HFP profile was t=
here
> > > > > and in bluez5 was HFP code completely removed.
> > > >=20
> > > > Hello, could someone from bluez developers comment this Tanu's poin=
t?
> > >=20
> > > I would have to say no, we are definitely not interested in yet
> > > another daemon for AT parsing, we actually have too many of these
> > > around, either in a form of Modem Manager, oFono, etc.
> >=20
> > Proposed hsphfpd daemon is not (only) for parsing AT commands, but for
> > implementing logic around HSP and HFP profiles and export either native
> > interfaces (linux uinput) or DBus interfaces for features provided by
> > HSP and HFP specifications and also for current and future vendor
> > extensions. And part of this HSP/HFP implementation is of course needed
> > parsing and interpreting some of AT commands. Look into my design and
> > API proposal. Current daemons which provides AT parsing (like ofono or
> > modem manager) are not suitable for for whole HSP and HFP profiles with
> > all those extensions (like all possible ways for reporting battery
> > level), so for HFP is needed some of custom AT parser.
>=20
> I'm not sure what logic around HSP you really care about.  It is just a
> single button press in the end.

CSR features (battery status level, ...) and CSR codec selection (e.g.
AuriStream). Also some apple extensions are used in HSP profile.

> For HFP, oFono can already support all sorts of extensions.  See for exam=
ple
> how we handled Siri for HFP support in oFono here:
> https://git.kernel.org/pub/scm/network/ofono/ofono.git/tree/doc/siri-api.=
txt.

I saw. But it does not support usage of vendor codecs, like CSR
AuriStream and it does not support CSR extensions, like displaying text
on embedded display.

> Many of the extensions you talked about are also relevant for real modems=
 as
> well (like battery reporting, call volume, etc).  Some of these APIs are
> already defined in fact.
>=20
> Given the above, oFono upstream has no interest in adding or maintaining
> support this new framework.

Denis, if you are not interested in my proposed hsphfpd daemon, how you
want to solve problem with other extensions and other vendor codecs?

Also in my proposed solution it is possible to use HFP profile without
Telephony Agent (ofono). Do you think it is really a good idea to have
strong dependency on ofono just for bluetooth HFP headset?

Also for using ofono with HFP profile is not possible on desktop
computer which do not have any modem as it is hooked to some active
modem.

There is a way to use ofono sim simulator which provide fake modem, but
its setup is hard on desktop and it not automated.

So connecting bluetooth headset in HFP profile with ofono is something
not so easy and not an obvious way.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--va5fw7oilj7u64cd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXfphugAKCRCL8Mk9A+RD
UgoqAJ9PUI8pxEGoA96KV9HXcQ0COyQpWACfcITjlbpJrNEbLSe+9pjPOqW+EKg=
=IMgD
-----END PGP SIGNATURE-----

--va5fw7oilj7u64cd--
