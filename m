Return-Path: <SRS0=Qms+=2J=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A84C43603
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Dec 2019 09:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F06F2465E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Dec 2019 09:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qOmaS3K2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfLSJvh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Dec 2019 04:51:37 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33531 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbfLSJvh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Dec 2019 04:51:37 -0500
Received: by mail-wr1-f65.google.com with SMTP id b6so5320929wrq.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Dec 2019 01:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NBTKKpdpP2QM/IlpQph1XsHUt8jCRweZbWMZSOCU9gI=;
        b=qOmaS3K2ws8QTSSATEYEttMADr2QdrDlNsyLXvx8PX73II5Qq4EFBEK3sAojTc/qAH
         brEZta+qjJmT5G814ZffzG77Q8eZdAwC7vUmeI5C7diLGjW/dOaOWvReSu4c2FrcLmzJ
         qsqspDEnOJRwTaPcc6JwmKV5iVDrK4TJ3Nlh0m02vDqCQ65jMCLRxafUgPNJx9bwGZ5c
         PIcrQ0qOJZ+qEXMI3KuO9M0HfOUM+HMwD3LVy/QAIRWctD4twfw3gmIA80cthjlwigzs
         7oX4kbol3Z/n+jF/JRhjuSVnCQVQVbWxLIZ7mlRLAw457N6+IQyWDAu+DJRdHfY/PSgR
         QPAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NBTKKpdpP2QM/IlpQph1XsHUt8jCRweZbWMZSOCU9gI=;
        b=VjE0iMxd9P68Zyzq7pRsrHLMbdsuC1tcI5bLMAfpLBmbahZ0Cfsx2Jpi8FYIpJbGSi
         JfKmER6Yj+ON+FtlBRLUHZGnXWitjNRU8cHVAoMhtcoh1MS1stZwQa/F8d+FZObJYd7X
         7HR5F7nUp/jIUwNQwozXZHWHczTXOVvMlK0W4EZBTYPprU4S9pCga3gyn5zsfHigeWXJ
         o9tIXfF+vQQfQXf22PRwp+Rf1WPcAAi4oFG6nLof6oKgMqH2JtnJxbUxzVX36fKRO3s/
         WUgFTCRynHzhpK0seDb3ZMVfaEzHLOPCJBsyGUNt542TlXV9icXogqBB/ZYvu02isFdt
         SvMQ==
X-Gm-Message-State: APjAAAUWYnKPRg6YsD2jJEXxT0mZfZsBIp352oPudMD67LnoSSaI9j3t
        gSicH3O4wAOLr43yGu5+B1HlDemY
X-Google-Smtp-Source: APXvYqyRhV/grAv5LxX2S2DdAws4aQxmEXVG1zHRTZrnarSqL6ernqyLYKR46I8hw5ThsCPFmmEv/g==
X-Received: by 2002:a5d:4481:: with SMTP id j1mr8721048wrq.348.1576749094387;
        Thu, 19 Dec 2019 01:51:34 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id z3sm5744682wrs.94.2019.12.19.01.51.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Dec 2019 01:51:33 -0800 (PST)
Date:   Thu, 19 Dec 2019 10:51:32 +0100
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
Message-ID: <20191219095132.blj3oyyrlfowv5ik@pali>
References: <20191202184512.rx6p63c6axztnwrw@pali>
 <20191205093200.x47npi5sxtcphr2o@pali>
 <CABBYNZKi7UUg7kASKadGr7sDJH0-tfuuZr9rd4Xu8ZUA9LqTMA@mail.gmail.com>
 <20191216091521.reh2urr25husschv@pali>
 <3ca53c66-1df0-41bf-710e-dea709906234@gmail.com>
 <20191218172828.vfie4su2whts2fqh@pali>
 <20191218173632.aqdmdhutu3ruezck@pali>
 <06eb7e98-1357-afd1-40a5-2ccb139d8dec@gmail.com>
 <20191218213349.2ksew2wnhgu3peub@pali>
 <0cfbe253-417c-e7c0-553a-abf360a80c9f@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="pwjmxlb54saig4lq"
Content-Disposition: inline
In-Reply-To: <0cfbe253-417c-e7c0-553a-abf360a80c9f@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--pwjmxlb54saig4lq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Denis!

On Wednesday 18 December 2019 19:03:12 Denis Kenzior wrote:
> Hi Pali,
>=20
> > Yes, I see. Also there are devices without HFP support, only with HSP.
> > pulseaudio support also these devices and pulseaudio is not going to
> > drop support for them. Last time when I looked at ofono, it has no HSP
> > support. Is ofono going to add support for HSP?
> >=20
>=20
> No.

So your answer means that we cannot use ofono at all and therefore we
need another daemon (like my proposed hsphfpd).

> <snip>
>=20
> >=20
> > But would you accept patches which exports DBus API e.g. for displaying=
 text
> > on HFP headset with embedded display? Or patches which implements 3
> > different way for reporting battery level status of HFP headset? And API
> > for sending "computer battery level" to HFP headset? Or implementing
> > setup of SCO sockets (via RFCOMM layer) for custom codecs? Or exporting
> > uinput linux device for button press events? Because all these
>=20
> So which roles are we talking about here?  Your Design document shows
> hsphfpd registering for both HFP AG and HFP HF roles, but maybe this was =
not
> the intent?

My proposed hsphfpd is going to support both roles. Which means to
implement whole HFP profile. So for connecting bluetooth headsets (when
AG role is needed on desktop) and also for connecting mobile phones
(when HF role is needed on desktop).

And my primary motivation is for bluetooth headsets as this is what are
asking desktop and laptop users again and again that is missing on Linux
systems.

So higher priority has AG role and slightly lower priority has HF role.

> If you're talking about extending oFono APIs when it is acting as the HF
> connecting to the AG, then codec setup APIs, etc are definitely something
> that would be welcome.
>=20
> If you're talking about AG role, then that is different... In general, if
> the oFono is in an AG role, then there should be nothing to configure and
> there are no APIs for this role.

Codecs needs to be configured also in AG role. Before accepting SCO
connection you need to configure SCO socket for correct codec. Also for
vendor codecs it needs to be properly negotiated via AT commands.

> Things like reporting AG battery level to
> HFP headset are done directly using plugins.  See
> ofono_emulator_set_indicator and how this is done by upower.c for example.
> I happily take patches for any additional features (codecs, etc) you want=
 to
> support here.
>=20
> But... oFono upstream has no interest in accepting forwarded AT commands
> from some external daemon if we're in AG role.  We rejected such a design
> years ago and nothing has changed.
>=20
> AG role is already quite tricky to implement without additional complexity
> introduced by having multiple applications and IPC.  "Its your funeral" as
> the saying goes if you want to go that route.

I know that it is not so easy to implement --- I already created
prototype implementation and proposed API how to do it.

But=20

> <snip>
>=20
> > I disagree here. Primary purpose of HFP for desktop users is ability to
> > use bluetooth's microphone. And not telephony stack and its complicated
> > features like call hold and others, which are in HFP used and
> > implemented probably only in car kits.
>=20
> So your primary goal here is to have the desktop play the role of the AG,
> purely so you can forward the audio from a headset out to whatever it is
> that you want.  And you want oFono (or some other daemon) to (optionally)
> handle the call related AT commands in the HFP AG role.

Yes. Exactly.

> Such a design will get a NAK from me on the oFono side.  But don't let th=
at
> stop you.  You can simply invoke oFono APIs directly from your daemon.  No
> need for any changes in oFono itself.  As mentioned above, I wouldn't
> recommend it, but... :)

So if you are disagreeing with this design, can you propose alternative?
Which would support needs for desktop users? Support for HSP profile (in
AG role), support for HFP profile (in AG role), ability to parse and
interpret needed AT commands. And later also HS and HF role of these
profiles.

> >=20
> > > > > Also for using ofono with HFP profile is not possible on desktop
> > > > > computer which do not have any modem as it is hooked to some acti=
ve
> > > > > modem.
> > >=20
> > > This statement is not true at all.  You can use oFono without any 're=
al'
> > > modems attached.  It can happily manage only HFP devices (or modems a=
s we
> > > call them.)
> >=20
> > Ok, can you please provide exact steps how to do it, including
> > activating of bidirectional audio stream?
>=20
> So again, which role?  If we're the HF connecting to the AG, then things
> just work without a modem.  If we're the AG, then yes you need a modem to=
 be
> driven by the AG connection.

AG.

> > >=20
> > > You must be thinking of the oFono HFP AG implementation...
> >=20
> > Yes! For connecting bluetooth headset you need HFP AG implementation.
> >=20
> > And I guess this is the reason why simulator is needed. HFP headset acts
> > as a "client" for modem. Therefore on desktop / laptop you need to
> > implement "modem server" which will be used by HFP headset "client".
> >=20
> > And phone simulator is doing exactly this "modem server", it is
> > simulator of modem.
> >=20
>=20
> Okay, I see now.  Yes, the above is correct.  My comments about not needi=
ng
> a modem device hold true only if oFono is in HFP HF role connecting to an
> AG.

Ok. So I guess now you understood main problem. I thought it was
obvious, but seems that bluetooth HFP is too complicated, so talking
about it always needs more detailed explanation. Sorry for that if it
was not clear from my side since beginning what are requirements for my
setup.

And question now is how to solve this problem for desktop computers?
Users who want to use their bluetooth headset (HF role on headset; AG
role on laptop) really do not want to do complicated setup of modem
simulator just to use microphone input from headset.

This is reason why I'm proposing hsphfpd daemon and with its API to work
without any modem emulator or ofono software (but optionally modem could
be connected).

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--pwjmxlb54saig4lq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXftIHwAKCRCL8Mk9A+RD
Ui3+AKC/GG+Spr8Je8AT0Fk2lzvTXfmyyQCgmPK+WhcPq1+kW+0VS/Y+X+db6mY=
=VYUR
-----END PGP SIGNATURE-----

--pwjmxlb54saig4lq--
