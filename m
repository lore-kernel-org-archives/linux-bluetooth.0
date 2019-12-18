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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9CCC43603
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Dec 2019 21:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D708218AC
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Dec 2019 21:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FuI9/3kO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfLRVdy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Dec 2019 16:33:54 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38284 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfLRVdy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Dec 2019 16:33:54 -0500
Received: by mail-wr1-f66.google.com with SMTP id y17so3881727wrh.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Dec 2019 13:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X+JhUURclvamF9wiwPgZcOg7r7Y6H/UFTWm8wsalVEI=;
        b=FuI9/3kOVvIWYq9MT98btBbFLuawxx5mBmIWLUootk78xeyGI2if9nPHIxkXLI/S5s
         Ixm+wF/+UXNFGdMvKB2102xpcOyu5k6zJuEHPJYXJBebjCw9ghy84qhrdIIGcT3ue93b
         lisNzt/LwB4MY9BVVXLg9cNzZiTzMGRnz4D13kTWoId387j5J0hih0E2OIAAz/+YXglh
         fb5m7votpsOeAdqhlTt772wd5dJVdds/2rYkn65j7irY7QiLYrdcSlDDC3uKB1vZba49
         YBEiLIHrqnPjzLgPVmD2PG4PKrfIW1j2TW95NOyjzDZfj998X1TOCpRep7ZIERcWlb78
         aG2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X+JhUURclvamF9wiwPgZcOg7r7Y6H/UFTWm8wsalVEI=;
        b=V71hdXhUD0Ci04/eqmvGoOqkzA0QimTTmtyHCd/uWdSv0AqDjdLq788+o5Va2MVtSL
         qEQX4ePL/eHHfAqpf1T75NYxZNOzjDNxdbIAuE2nBjYRzFk7odnzcQ26/u5UeFT6cp+4
         MdaYwRQbM3L8+B0ujI/vqdx9bIpUmuoNcc7ouH4gYcm3GSjx8ODXXG4D3J3XDXh5LiG7
         sdyrIK1jrFt/IC29e15wGW27qe7Ui+29eGCKedbXT2PXcNV0wvXIk6OnjuVYRHnWrgco
         Kv2vCpvv9huG6Lm34CS0VLOfaK78++yricG60G6b7KNuJrmwOjFkOAgzYCJtB3vXZ8Zy
         XCOA==
X-Gm-Message-State: APjAAAUOYBdrgKa/e3x0A9aAAtH5IRyMHEo6KDhX0NIZOy31y+36qnb+
        eiPSGGV7NpEz8HJmLHb/1uU=
X-Google-Smtp-Source: APXvYqyCv1s9ylr1xamXsD1a5IHpT74vOQIzlsKyv5p/E/XlIA6WD1WKVad4vwufIlzpjcq38Ew8RA==
X-Received: by 2002:adf:cf12:: with SMTP id o18mr5233132wrj.361.1576704831521;
        Wed, 18 Dec 2019 13:33:51 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id z8sm3980766wrq.22.2019.12.18.13.33.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Dec 2019 13:33:50 -0800 (PST)
Date:   Wed, 18 Dec 2019 22:33:49 +0100
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
Message-ID: <20191218213349.2ksew2wnhgu3peub@pali>
References: <20191201185740.uot7zb2s53p5gu7z@pali>
 <508d35f29c2abc26af15e232a38d3ca53eb33706.camel@iki.fi>
 <20191202184512.rx6p63c6axztnwrw@pali>
 <20191205093200.x47npi5sxtcphr2o@pali>
 <CABBYNZKi7UUg7kASKadGr7sDJH0-tfuuZr9rd4Xu8ZUA9LqTMA@mail.gmail.com>
 <20191216091521.reh2urr25husschv@pali>
 <3ca53c66-1df0-41bf-710e-dea709906234@gmail.com>
 <20191218172828.vfie4su2whts2fqh@pali>
 <20191218173632.aqdmdhutu3ruezck@pali>
 <06eb7e98-1357-afd1-40a5-2ccb139d8dec@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="aq2axre4gjwrgfjj"
Content-Disposition: inline
In-Reply-To: <06eb7e98-1357-afd1-40a5-2ccb139d8dec@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--aq2axre4gjwrgfjj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Denis!

On Wednesday 18 December 2019 14:53:24 Denis Kenzior wrote:
> Hi Pali,
>=20
> > > > I'm not sure what logic around HSP you really care about.  It is ju=
st a
> > > > single button press in the end.
> > >=20
> > > CSR features (battery status level, ...) and CSR codec selection (e.g.
> > > AuriStream). Also some apple extensions are used in HSP profile.
>=20
> Since HFP can do everything that HSP can and more, I view HSP as deprecat=
ed
> and not to be used.  If these are also available in HFP, then I'd just use
> HFP instead.  But HSP was never my focus, so if you feel there's a need f=
or
> better HSP support, then fair enough.

Yes, I see. Also there are devices without HFP support, only with HSP.
pulseaudio support also these devices and pulseaudio is not going to
drop support for them. Last time when I looked at ofono, it has no HSP
support. Is ofono going to add support for HSP?

> > >=20
> > > > For HFP, oFono can already support all sorts of extensions.  See fo=
r example
> > > > how we handled Siri for HFP support in oFono here:
> > > > https://git.kernel.org/pub/scm/network/ofono/ofono.git/tree/doc/sir=
i-api.txt.
> >=20
> > About Siri: In hsphfpd API it is delegated to Telephony Agent. So
> > hsphfpd is not going to (re)implement it.
> >=20
> > > I saw. But it does not support usage of vendor codecs, like CSR
> > > AuriStream and it does not support CSR extensions, like displaying te=
xt
> > > on embedded display.
>=20
> But that's my point, you can easily accomplish this by creating another
> oFono API / atom for HFP CSR extensions and expose this information /
> functionality.  Similar to how Siri was done.  I see no need for a
> completely new external daemon.

Ok. I agree that functionality from my hsphfpd prototype can be "moved"
to ofono.

But would you accept patches which exports DBus API e.g. for displaying text
on HFP headset with embedded display? Or patches which implements 3
different way for reporting battery level status of HFP headset? And API
for sending "computer battery level" to HFP headset? Or implementing
setup of SCO sockets (via RFCOMM layer) for custom codecs? Or exporting
uinput linux device for button press events? Because all these
functionalities looks like not relevant to telephony / modem stack and
for me it seems that ofono is not target application which should be
interested in implementing it.

> > >=20
> > > > Many of the extensions you talked about are also relevant for real =
modems as
> > > > well (like battery reporting, call volume, etc).  Some of these API=
s are
> > > > already defined in fact.
> > > >=20
> > > > Given the above, oFono upstream has no interest in adding or mainta=
ining
> > > > support this new framework.
> >=20
> > Maybe better question: Do you mean that you do not want to maintain
> > hsphfpd, or that you completely do not want to see that ofono would be
> > "Telepony Agent" for hsphfpd?
>=20
> The latter.

Ok.

> >=20
> > > Denis, if you are not interested in my proposed hsphfpd daemon, how y=
ou
> > > want to solve problem with other extensions and other vendor codecs?
> > >=20
>=20
> See above..
>=20
> > > Also in my proposed solution it is possible to use HFP profile without
> > > Telephony Agent (ofono). Do you think it is really a good idea to have
> > > strong dependency on ofono just for bluetooth HFP headset?
> > >=20
>=20
> Why not?  The main purpose of HFP is telephony; whether it is classic pho=
ne
> calls or skype/facetime.  oFono seems a natural fit.

I disagree here. Primary purpose of HFP for desktop users is ability to
use bluetooth's microphone. And not telephony stack and its complicated
features like call hold and others, which are in HFP used and
implemented probably only in car kits.

> > > Also for using ofono with HFP profile is not possible on desktop
> > > computer which do not have any modem as it is hooked to some active
> > > modem.
>=20
> This statement is not true at all.  You can use oFono without any 'real'
> modems attached.  It can happily manage only HFP devices (or modems as we
> call them.)

Ok, can you please provide exact steps how to do it, including
activating of bidirectional audio stream?

Because from all information which I got, and also from talk with other
people, I think it really is not possible.

Also official pulseaudio documentation mention that you need phone sim
simulator for this purpose, see:

https://www.freedesktop.org/wiki/Software/PulseAudio/Documentation/User/Blu=
etooth/#index5h2

> > >=20
> > > There is a way to use ofono sim simulator which provide fake modem, b=
ut
> > > its setup is hard on desktop and it not automated.
> > >=20
>=20
> You must be thinking of the oFono HFP AG implementation...

Yes! For connecting bluetooth headset you need HFP AG implementation.

And I guess this is the reason why simulator is needed. HFP headset acts
as a "client" for modem. Therefore on desktop / laptop you need to
implement "modem server" which will be used by HFP headset "client".

And phone simulator is doing exactly this "modem server", it is
simulator of modem.

> > > So connecting bluetooth headset in HFP profile with ofono is something
> > > not so easy and not an obvious way.
> > >=20
>=20
> Again, not true.  As I said above, you can use oFono for this use case ju=
st
> fine.  Certainly the main driver for the development of oFono was to drive
> real modem hardware, but it isn't limited to that.  So if you want to use=
 it
> only for HFP, you can.

If it is really possible (and need for phone simulator as described
above is not required) then there is completely missing documentation
how to do it. And how should be audio server (pulseaudio) configured to
work in this way.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--aq2axre4gjwrgfjj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXfqbOgAKCRCL8Mk9A+RD
UqYvAKCE2Hx4+jCk9qkhPTJ7xycOsu7aLQCgj5eBXPUcPJFxiX5HeM+38A4mCsE=
=0q2g
-----END PGP SIGNATURE-----

--aq2axre4gjwrgfjj--
