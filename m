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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E721EC2D0CD
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Dec 2019 08:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C3B24650
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Dec 2019 08:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o9QjOY2L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfLRIbE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Dec 2019 03:31:04 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39743 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfLRIbD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Dec 2019 03:31:03 -0500
Received: by mail-wr1-f68.google.com with SMTP id y11so1257256wrt.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Dec 2019 00:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+Ed4E/OzUuINx7LJwq3VrCjiZIkM4gjJIz6PmBZeraE=;
        b=o9QjOY2LPw3R19WEiwVKFQ9UC1Z/62jVymgGEA4q6n2MBUA9Tf+C6dOb3wOQEyH/v4
         ouptbADiMT7dNd2JQ7tF9Qvm0EZrmnX8hv0IiqSIOlOvKaT6UqMIxBZ16IA18t/Owpde
         2hAm3CLnUrjSX6GK1BEppOEBryb/jp3uLGeA/NAeBVdNhDUYux7tMRlTm/6K97ELLcbD
         Dy6VDGH87a7bUXvDKHOySBWOi037j3oeGE+R9NvLcjeiFbP9hU4wAT6i2faHMrTlr4be
         Ra3Y/p2wt+i2gPumK3Kt6psYJ7i5vl2YMSJIO29vYim6TTGjdkec6X+lAy0vpcCG61uQ
         MjNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+Ed4E/OzUuINx7LJwq3VrCjiZIkM4gjJIz6PmBZeraE=;
        b=ZoNsQ4pDNUPLONafGCB2njvqEFFfbVQL4uQEYCZTktg8/vR1G7Wd5AfDM30YGDbGEX
         ZfL1QNhyCkMv8ytRI+TPhy0heuw5BDT47P2APEv31DaeHc25P0bnkrXyfQNSbdAyGkkn
         t1AkDWG5WGuXlQ4y1c7hTQz1NyPd/iQMkL1VPmMI06d3wIhyj6DqccF/d7N6HTiU5LkR
         rvA8+HyijNpvF5SbySmfcwyDFHD04KZFnZX+kywzSzKT47i2v4jXA/uZHoe/JKLisBxJ
         unixyPOmUZbUNcAn0qDP387KNTcrMIZRXmBfwuupLPlLcInssFb1yDrlPHb9/BwJyGwy
         2u1w==
X-Gm-Message-State: APjAAAXCKuLbeac3Y8QlfOK40POlzmLaoW87iFcywMQFDr/RYp3yk9ev
        x8zitR7Q2zmzopx1ib26KxY=
X-Google-Smtp-Source: APXvYqwfvUzRbBm23ZxmPQFVgadkw+DdufG6Ccuopxbq0XVEdFzTQRGxrYtKvtQDIzVHkOV0uMMA3g==
X-Received: by 2002:adf:c446:: with SMTP id a6mr1311269wrg.218.1576657860567;
        Wed, 18 Dec 2019 00:31:00 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id a184sm1652505wmf.29.2019.12.18.00.30.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Dec 2019 00:30:59 -0800 (PST)
Date:   Wed, 18 Dec 2019 09:30:58 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
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
Message-ID: <20191218083058.mmilv3zez2swq3wg@pali>
References: <20191201185740.uot7zb2s53p5gu7z@pali>
 <508d35f29c2abc26af15e232a38d3ca53eb33706.camel@iki.fi>
 <20191202184512.rx6p63c6axztnwrw@pali>
 <20191205093200.x47npi5sxtcphr2o@pali>
 <CABBYNZKi7UUg7kASKadGr7sDJH0-tfuuZr9rd4Xu8ZUA9LqTMA@mail.gmail.com>
 <20191216091521.reh2urr25husschv@pali>
 <CABBYNZKpKyK0Hj2PwD7OmC1yuJU7uniyLd62t5RyVpP7miYqBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="vliiuq7ys4uiwf6n"
Content-Disposition: inline
In-Reply-To: <CABBYNZKpKyK0Hj2PwD7OmC1yuJU7uniyLd62t5RyVpP7miYqBg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--vliiuq7ys4uiwf6n
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tuesday 17 December 2019 15:47:16 Luiz Augusto von Dentz wrote:
> Hi Pali,
>=20
> On Mon, Dec 16, 2019 at 1:15 AM Pali Roh=C3=A1r <pali.rohar@gmail.com> wr=
ote:
> >
> > Hi!
> >
> > On Monday 16 December 2019 00:11:04 Luiz Augusto von Dentz wrote:
> > > Hi Pali,
> > >
> > > On Thu, Dec 5, 2019 at 11:32 AM Pali Roh=C3=A1r <pali.rohar@gmail.com=
> wrote:
> > > >
> > > > On Monday 02 December 2019 19:45:12 Pali Roh=C3=A1r wrote:
> > > > > On Monday 02 December 2019 19:01:11 Tanu Kaskinen wrote:
> > > > > > I think hsphfpd should be part of bluetoothd, but if that's not
> > > > > > possible, then that's not possible.
> > > > >
> > > > > I do not know if bluez developers are interested in having this c=
ode as
> > > > > part of bluez project, specially when in bluez4 HFP profile was t=
here
> > > > > and in bluez5 was HFP code completely removed.
> > > >
> > > > Hello, could someone from bluez developers comment this Tanu's poin=
t?
> > >
> > > I would have to say no, we are definitely not interested in yet
> > > another daemon for AT parsing, we actually have too many of these
> > > around, either in a form of Modem Manager, oFono, etc.
> >
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
> Not following you on this one, oFono is intended for telephony
> functionality

and it should still be for telephony functionality.

> and afaik it could parse battery, etc. Also would your
> daemon include such functionality or you are to combine that with
> oFono?

Have you looked at my proposed API and design document? If not, please
really look at it... I already sent links in first email, but here are:

https://github.com/pali/hsphfpd-prototype/raw/prototype/README
https://github.com/pali/hsphfpd-prototype/raw/prototype/hsphfpd.txt

And if it is not clean how API works or how Agent should behave or how
whole ecosystem should work, please let me know which parts are not
clean so I can update it or explain even more.

All telephony AT commands (more specially, those which are not HFP
specific or which should not be handled by hsphfpd itself) are forwarded
to Telephony Agent. Ofono should be that Telephony Agent for hsphfpd for
handling all telephony stuff.

My hsphfpd daemon does not handle telephony functionality (except just
few commands which are required for HFP to work, but hsphfpd handles it
only when Telephony Agent is not connected).

> I do appreciate the effort you have put into the SBC modes and
> codec support but Im afraid you are going to experience some real pain
> to maintain such a system all in your own, there are a lot of features
> being exposed via AT commands and we risk to have yet another daemon
> that just do parts

Intension of hsphfpd is to dead with all these problems. For all new
functionality which would be introduced in future by vendors, hsphfpd
should be easily extended to either directly support this functionality
or to expose DBus API (or DBus file descriptor with AT socket) for
external application which would handle it.

> of them until the next person comes with a
> different use case and we are back to square one.
>=20
> > > That said one
> > > simpler way to resolve all of this is to maintain a plugin to
> > > bluetoothd that way HSP/HFP becomes native again, that can either be
> > > maintained in the tree or out of the tree.
> >
> > I do not see how could just plain plugin for bluez without AT parser
> > could help. This seems to just complicate whole implementation. I
> > already implemented prototype implementation of hsphfpd to see how
> > complicated it is and what is needed...
>=20
> Well the exactly the same thing with yet another daemon, we obviously
> will need an AT parser,

Yes, some AT parser would be still needed...

> but the nice thing of being a native plugin is
> that it can detect if another entity register for HSP/HFP and disable
> itself (or have a policy to control that), the implementation can be
> exactly what you have but without the extra rounds trips involved to
> communicate back and forth with your daemon, so it is pretty straight
> forward in terms o implementation.

I'm not sure if I understand it correctly, but does it mean to include
whole hsphfpd functionality into "bluez plugin" and bluetooth daemon
would then run this plugin, instead having hsphfpd in separate process?

> > So if bluez daemon is not the right place for hsphpfd, it would be
> > separate daemon outside of bluez.
> >
> > --
> > Pali Roh=C3=A1r
> > pali.rohar@gmail.com
>=20
>=20
>=20

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--vliiuq7ys4uiwf6n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXfnjwAAKCRCL8Mk9A+RD
UqcMAKCBDBhIrxk8vDh5cRfNCnhMLM7KtgCfcmbK4F7vAgSm/X/pVafGYZZWpuA=
=ze6J
-----END PGP SIGNATURE-----

--vliiuq7ys4uiwf6n--
