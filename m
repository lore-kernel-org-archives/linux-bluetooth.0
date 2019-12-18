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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FFCC43603
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Dec 2019 17:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8DD72082E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Dec 2019 17:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCT47EGy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfLRRgh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Dec 2019 12:36:37 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36303 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbfLRRgh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Dec 2019 12:36:37 -0500
Received: by mail-wm1-f65.google.com with SMTP id p17so2867995wma.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Dec 2019 09:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4ne2MTEiWb/sGFe8gyoebrpYi6dRMmMV81jCQOHOfAU=;
        b=cCT47EGyjV24XSFTQd+rE2jNF82ob6h4BhFHNJ6EWFa0jXInGEiNZSNOi6h17Q/OQA
         8zLo+GNCpq3fTCFabfqhWWzBYUN7DQKA7ZYJbP3u5F1yFOuVEDMcM4dtUatNSdlGBqkm
         rPi4YNHpxvUJw7bNKeA/2a/GdtabVkGKF3E9cSx0W6uJrVjH6+BjyTZu1toJoY6dQ6ic
         jAILSs604mgdxO0xgxd6+q9iyFYPwHOuiNKKT+4/nDaO6JVEOSk9uqWbUCqlplnPt4V3
         XjdFWEXh4+5cC2KeUSYQdaYcHkt9659gGFioVAcS+fk0AYiV47GtSZTJuEozLxSATYaT
         8yNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4ne2MTEiWb/sGFe8gyoebrpYi6dRMmMV81jCQOHOfAU=;
        b=dejf66kxww9XwvR+8PMXwQbkkGmQXF2z/lR3W4YWcnhxtXDb/wj5YbgJcFzj9ifHEa
         fz1M79PdoFBwqcT7pXhcitm+5C7XSoCsskjTOoD4kG/Ntx4SZ3UDHN416Dfx6bx76YLn
         7deZznZrzDjMlapRPB21vb9j8x+6Ap3lECzM2EZvzc0khGU2kPFLsgqSvqDqSGueHEWy
         Em95+mxxu2qUL5fp5gPQBMZYv+jixNa836dtQHuuPWzeKFUM61SGMWOwMc/QhSXD4jni
         cCbtW6Ztw0A8Sm9vCFUPqmPchRP7AlSHudy/tZ5J0Jp5c9px276T6lk6+YmJa70u1Q6i
         cnoQ==
X-Gm-Message-State: APjAAAVQtNwFLEhY0MP/j6m8WSjLnm8a4imqLUrRDhhUVqdsD+kYzkZZ
        OwzFxA6hAspK6giQkitC6sU=
X-Google-Smtp-Source: APXvYqzh6adUlTNKu13hk9LXrzZrmGyZlke1pd60t6UddFNr3KggosgPb0DcT2Dtj1PlNitkPcNmMQ==
X-Received: by 2002:a1c:c919:: with SMTP id f25mr4506618wmb.49.1576690594194;
        Wed, 18 Dec 2019 09:36:34 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id x18sm3303446wrr.75.2019.12.18.09.36.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Dec 2019 09:36:33 -0800 (PST)
Date:   Wed, 18 Dec 2019 18:36:32 +0100
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
Message-ID: <20191218173632.aqdmdhutu3ruezck@pali>
References: <20191201185740.uot7zb2s53p5gu7z@pali>
 <508d35f29c2abc26af15e232a38d3ca53eb33706.camel@iki.fi>
 <20191202184512.rx6p63c6axztnwrw@pali>
 <20191205093200.x47npi5sxtcphr2o@pali>
 <CABBYNZKi7UUg7kASKadGr7sDJH0-tfuuZr9rd4Xu8ZUA9LqTMA@mail.gmail.com>
 <20191216091521.reh2urr25husschv@pali>
 <3ca53c66-1df0-41bf-710e-dea709906234@gmail.com>
 <20191218172828.vfie4su2whts2fqh@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5xnz3e5qnh4g7aic"
Content-Disposition: inline
In-Reply-To: <20191218172828.vfie4su2whts2fqh@pali>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--5xnz3e5qnh4g7aic
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wednesday 18 December 2019 18:28:28 Pali Roh=C3=A1r wrote:
> On Wednesday 18 December 2019 11:00:07 Denis Kenzior wrote:
> > Hi Pali,
> >=20
> > On 12/16/19 3:15 AM, Pali Roh=C3=A1r wrote:
> > > Hi!
> > >=20
> > > On Monday 16 December 2019 00:11:04 Luiz Augusto von Dentz wrote:
> > > > Hi Pali,
> > > >=20
> > > > On Thu, Dec 5, 2019 at 11:32 AM Pali Roh=C3=A1r <pali.rohar@gmail.c=
om> wrote:
> > > > >=20
> > > > > On Monday 02 December 2019 19:45:12 Pali Roh=C3=A1r wrote:
> > > > > > On Monday 02 December 2019 19:01:11 Tanu Kaskinen wrote:
> > > > > > > I think hsphfpd should be part of bluetoothd, but if that's n=
ot
> > > > > > > possible, then that's not possible.
> > > > > >=20
> > > > > > I do not know if bluez developers are interested in having this=
 code as
> > > > > > part of bluez project, specially when in bluez4 HFP profile was=
 there
> > > > > > and in bluez5 was HFP code completely removed.
> > > > >=20
> > > > > Hello, could someone from bluez developers comment this Tanu's po=
int?
> > > >=20
> > > > I would have to say no, we are definitely not interested in yet
> > > > another daemon for AT parsing, we actually have too many of these
> > > > around, either in a form of Modem Manager, oFono, etc.
> > >=20
> > > Proposed hsphfpd daemon is not (only) for parsing AT commands, but for
> > > implementing logic around HSP and HFP profiles and export either nati=
ve
> > > interfaces (linux uinput) or DBus interfaces for features provided by
> > > HSP and HFP specifications and also for current and future vendor
> > > extensions. And part of this HSP/HFP implementation is of course need=
ed
> > > parsing and interpreting some of AT commands. Look into my design and
> > > API proposal. Current daemons which provides AT parsing (like ofono or
> > > modem manager) are not suitable for for whole HSP and HFP profiles wi=
th
> > > all those extensions (like all possible ways for reporting battery
> > > level), so for HFP is needed some of custom AT parser.
> >=20
> > I'm not sure what logic around HSP you really care about.  It is just a
> > single button press in the end.
>=20
> CSR features (battery status level, ...) and CSR codec selection (e.g.
> AuriStream). Also some apple extensions are used in HSP profile.
>=20
> > For HFP, oFono can already support all sorts of extensions.  See for ex=
ample
> > how we handled Siri for HFP support in oFono here:
> > https://git.kernel.org/pub/scm/network/ofono/ofono.git/tree/doc/siri-ap=
i.txt.

About Siri: In hsphfpd API it is delegated to Telephony Agent. So
hsphfpd is not going to (re)implement it.

> I saw. But it does not support usage of vendor codecs, like CSR
> AuriStream and it does not support CSR extensions, like displaying text
> on embedded display.
>=20
> > Many of the extensions you talked about are also relevant for real mode=
ms as
> > well (like battery reporting, call volume, etc).  Some of these APIs are
> > already defined in fact.
> >=20
> > Given the above, oFono upstream has no interest in adding or maintaining
> > support this new framework.

Maybe better question: Do you mean that you do not want to maintain
hsphfpd, or that you completely do not want to see that ofono would be
"Telepony Agent" for hsphfpd?

> Denis, if you are not interested in my proposed hsphfpd daemon, how you
> want to solve problem with other extensions and other vendor codecs?
>=20
> Also in my proposed solution it is possible to use HFP profile without
> Telephony Agent (ofono). Do you think it is really a good idea to have
> strong dependency on ofono just for bluetooth HFP headset?
>=20
> Also for using ofono with HFP profile is not possible on desktop
> computer which do not have any modem as it is hooked to some active
> modem.
>=20
> There is a way to use ofono sim simulator which provide fake modem, but
> its setup is hard on desktop and it not automated.
>=20
> So connecting bluetooth headset in HFP profile with ofono is something
> not so easy and not an obvious way.
>=20

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--5xnz3e5qnh4g7aic
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXfpjngAKCRCL8Mk9A+RD
UqJUAJwNMk2Z7genvy1W1QH1M4L73zuDMACgriBL2hAuFn5zLbH/OhDpsHbUioQ=
=37s1
-----END PGP SIGNATURE-----

--5xnz3e5qnh4g7aic--
