Return-Path: <SRS0=msWm=2K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5567C43603
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Dec 2019 22:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72EA72146E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Dec 2019 22:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGQtye0z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfLTWrE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Dec 2019 17:47:04 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56142 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfLTWrD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Dec 2019 17:47:03 -0500
Received: by mail-wm1-f66.google.com with SMTP id q9so10471003wmj.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Dec 2019 14:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g0JArr50jDtrLYo9YnuTexI3fGvnkxmXKrc9pA2ApSM=;
        b=bGQtye0zc22S8wCPgoOkPPQo/Q9tHroCKNcxvPK3qvDbaVtLfYoOoM63S7eGzVI2Dp
         1E2c0u0zWz5WGoaMwSJzP4qndfXxGhCQVem/Abme0uUJXWEalxuzdzq7CyKGP0b75VEt
         xpiWIwnd0nTHDruPBephA+4FrSe2L52/7KFAJIicSY/EYuyMHxcViOZ9b0ry8myCGJ4Q
         kpVYnJtA7MgtYzCNeH0BhhAEM9P34gKEPYRlRiUCzghfQyGKbvFTyTGQ+qvswiT3XpGk
         3OPJe8j4xl8LlcZisQr+4FplXcJi/EKwH1hkpKuVQKUqcgaikCN30KY2M6QdToii4s+9
         wVLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g0JArr50jDtrLYo9YnuTexI3fGvnkxmXKrc9pA2ApSM=;
        b=RiRhxlMZ/2KYwNem7e4BwtV3gsAbpua/fJLB1+K20/F9J1EuL7YttZGzY40ENL/TTK
         fkzesVnHudH3K4+JO+BFYaj/D1qpvCHYKxOrKgbiV2VfhutlF5PR8lATuNBY1T/4KhJb
         5eDse0gKxyZ9rPOhaKi/cTuSsNcsXH7OMB9SQwq73JLfdymsHkpMddySr1YsxM68L8sm
         2I2022J5KBC3YxCfDEVuNymn5lgMRZeYSiY2NIfolTkDyCqUSozm4VffOOcGf8cNtryN
         rvwN1BPqBOtPR7UTqvKWHd5R3oxar5VSDtNYmimAzPkC1K7/3W+w0TFGHzojxeRrVnUB
         oz/w==
X-Gm-Message-State: APjAAAXBDCWKyUt9nGsE+poegS3ehDyaUafHLjYDGiG0GOdn2k5aCUoQ
        rUYNQd5A/3Tts1a9uee2ucI=
X-Google-Smtp-Source: APXvYqxz5s1KaG2bjbO9S86vuZCfcAyYI91bk6EiX3czjR6EKkN1IpdymQ5//ibCIspC2pRYQQCknQ==
X-Received: by 2002:a7b:cb0a:: with SMTP id u10mr18432852wmj.165.1576882019890;
        Fri, 20 Dec 2019 14:46:59 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id l3sm11044513wrt.29.2019.12.20.14.46.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Dec 2019 14:46:58 -0800 (PST)
Date:   Fri, 20 Dec 2019 23:46:57 +0100
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
Message-ID: <20191220224657.n4m6qkxa4sceau3l@pali>
References: <3ca53c66-1df0-41bf-710e-dea709906234@gmail.com>
 <20191218172828.vfie4su2whts2fqh@pali>
 <20191218173632.aqdmdhutu3ruezck@pali>
 <06eb7e98-1357-afd1-40a5-2ccb139d8dec@gmail.com>
 <20191218213349.2ksew2wnhgu3peub@pali>
 <0cfbe253-417c-e7c0-553a-abf360a80c9f@gmail.com>
 <20191219095132.blj3oyyrlfowv5ik@pali>
 <90261b42-1048-370f-7680-acd9f7e754ed@gmail.com>
 <20191219153344.hxnoa3idqvgdwrp2@pali>
 <76f1cb25-b608-e4e9-6fd9-8da932c56a15@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="uyhocsynyyrntqot"
Content-Disposition: inline
In-Reply-To: <76f1cb25-b608-e4e9-6fd9-8da932c56a15@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--uyhocsynyyrntqot
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Friday 20 December 2019 15:19:01 Denis Kenzior wrote:
> Hi Pali,
>=20
> > > There have been one or two implementations of AG role fully external =
to
> > > oFono.  These implementations simply used the existing oFono APIs to =
drive
> > > the modem.
> >=20
> > bluez & pulseaudio developers told me that it would be a good idea to
> > avoid implementing a new AT parser for telephony stack. And rather use
> > ofono implementation for telephony part...
>=20
> In my opinion there's nothing scary about AT parsing.  In fact that is the
> easiest part of this whole venture.  If you don't want to roll your own
> parser, you can borrow one from the oFono project.  We already solved this
> nicely in the form of the gatchat library.  You could incorporate this in=
to
> your project (if it is GPL compatible).  Or you could wait until we port
> gatchat to ell which will be under LGPL license.
>=20
> >=20
> > But if I should use existing DBus API provided by ofono, it means that I
> > need to do parsing of all AT commands (including telephony) and
> > translate them to ofono DBus API.
>=20
> I think you will need to do this regardless.  Otherwise I fail to see how
> you prevent one 'agent' from consuming AT commands it shouldn't be. This =
is
> a possibility you need to consider, whether it happens by accident or
> maliciously.

Some subset of AT commands are needed to parse and interpret. But not
telephony commands and having up-to-date internal telephony state.

> >=20
> > I agree, this should work and there is not need to modify ofono. But it
> > means that in hsphfpd daemon I need to have full AT parser for all
> > telephony commands and it was something which bluez / pa developers
> > thought that should be avoided. Therefore I come up with idea that
> > telephony commands would be handled by external Telephony Agent, which
> > can be ofono.
>=20
> Understood.  But I think the metric function was selected inappropriately=
 in
> this case.  My opinion is that you should have started with what the over=
all
> architecture should look like; you should not have based design decisions=
 on
> which parts might be a little hard to implement.
>=20
> >=20
> > > You could do that.  But as I said, we rejected such a design a
> > > long time ago due to complexity and other issues.
> >=20
> > Anyway, what is the problem with accepting modem socket in ofono via
> > DBus and starts talking with it like with any other modem which ofono
> > supports? Currently ofono already takes modem socket from bluez via DBus
> > API, so in same way hsphfpd can pass modem socket to ofono. Basically
> > ofono then can reuse same code which already uses for sockets from
> > bluez, just it do not have to parse and interpret audio related AT
> > commands (as these are handled by hsphpfd itself).
> >=20
> > What are exact issues? I do not see complexity at ofono part (as has
> > already everything implemented) and currently I do not see those "other"
> > issues.
>=20
> The issues are many.  And really the question is not whether it 'could be'
> done, but whether it 'should be' done.  Let me describe a couple examples:
>=20
> - In the case of HF role (1), oFono already provides all the necessary AP=
Is.
> So put yourself in oFono's maintainer shoes.  What would we gain by
> supporting almost the same but different mechanism?  We would have to
> introduce a new hfp_hf plugin, one that is almost identical, but different
> to hfp_hf_bluez5 plugin.

Yes, this would be needed, but because code os very similar it could be
reused from one common place.

> These two plugins would have coexistence issues,
> which would add more complexity.  Then there's the impact on PulseAudio a=
nd
> other users.  How do they know when to use the HandsfreeAudio API vs some
> external API?

Because pulseaudio has already own implementation of HSP profile and
some kind of ofono implementation (which you named below "giant hack")
it already needs to handle such problem.

But solution should be relatively simple. If we decide that new daemon
is "new proper way" then it would have higher priority as current HFP
API by ofono. So if hsphfpd is registered on dbus && hsphfpd say that it
is active, then use hsphfpd. Otherwise if ofono is registered on dbus
and say that device is active/connected use ofono.

> Supporting this new way buys us a lot of extra code /
> complexity with no value added.

Value is support for HSP profile and support for HFP AG role without
modem. And it would provide (for PA) unified same interface as for HFP
HF role and HFP AG role with modem. I think this is a big value for PA
(or bluez alsa or pipewire) to have one API which would handle all HSP
and HFP profile/role combinations.

> - The other example is more practical. HFP Service Level Connection (SLC)
> establishment is actually quite tricky.  There are certain limitations on
> what can and cannot be done prior to SLC establishment, including how aud=
io
> handling is done.

I know :-) I already implemented prototype implementation to check and
see how complicated it is and if API make sense and how hard it is for
agents (audio - pulseaudio) implement and maintain it.

> Unfortunately, codec negotiation, indicator negotiation,
> and feature negotiation are part of the SLC. oFono already solves all of
> this and handles all of it nicely.

CSR codecs are not supported nor implemented in ofono. It is more
complicated as HFP codecs... and needs a new API for audio application.
Another value which brings my hsphfpd is that it handles these CSR
codecs and provide API for audio application to use them.

> We have passed all relevant
> certification testing.  It is very unclear how you plan to handle this (or
> whether you realistically even can) in your architecture when the
> responsibilities are split between the various daemons.  So again, oFono =
has
> nothing to gain here...

I was not thinking about certification. It is not something which I
could do.... And also pulseaudio itself do not have certifications.

> >=20
> > You suggested to use phone simulator together with ofono and then
> > starts extending / patching phone simulator to supports all needed parts
> > which are in my hsphfpd design (battery status, button press, codec
> > selection)?
> >=20
>=20
> Not quite.  I suggested you expand oFono's emulator implementation (for AG
> role) and its DBus APIs (for HF role) to support the new vendor specific
> features that you want.
>=20
> Forget about the phone simulator, it is really irrelevant for what you're
> trying to accomplish.

Ok. I thought that phone simulator =3D ofono emulator. I just saw that
phone simulator which is described in pulseaudio documentation.

> > Also how to handle the main problem of phone simulator that it is too
> > much complicated to setup it on desktop? Looking at the steps...
> >=20
> > https://www.freedesktop.org/wiki/Software/PulseAudio/Documentation/User=
/Bluetooth/#index5h2
> >=20
> > ... that desktop user needs to run nontrivial commands in command like,
> > plus creating configuration file only just to connect bluetooth headset
> > is ridiculous and non-acceptable for desktop application.
> >=20
> > If this problem is not fixed, ofono and phone simulator are not usable
> > as "main" software implementation of HFP profile for usage of bluetooth
> > headsets on Linux.
>=20
> oFono was never advertised as solving the 'HFP AG without a modem' use ca=
se.
> This is something we never had as a requirement / objective. Phonesim is a
> development tool.  So of course it isn't trivial to setup, it isn't meant=
 to
> be used in production in the first place.  The use of phonesim described =
in
> the PA wiki, while creative, is a giant hack ;)

Ok, so we definitely agree that ofono currently do not support HFP AG
without modem for desktop users. And this scenario is needed for
connecting bluetooth headsets, so we need some solution for it.

> Basically it all boils down to the fact that nobody has stepped up all th=
is
> time to solve a particular use case you care about.  But blaming oFono for
> this is misguided.
>=20
> So, if you want to solve the HFP AG without a modem case I fully support
> your efforts.

Ok! So which options do we have?

> Perhaps this can even be solved in oFono itself (since it already does 90%
> of what you want) by making the modem requirement optional.  What we could
> do for example is to create a dummy modem if an AG connection is requested
> and no other suitable modems are detected in the system.  The resultant AG
> wouldn't have any call control capability, it could still be used for
> transferring audio data, battery, etc.  If you want to pursue this, we can
> brainstorm further.

Well, if this would work automatically without any user interaction or
without special setup, it seems to be usable.

But what is needed from this implementation in ofono? Basically API for
each functionality designed in hsphfod daemon. And one of it is also
support for HSP profile (with CSR and Apple extensions).

I'm not against for it, but I thought that having functionality which is
not related to telephony / modem you would not want to see in ofono
project (like linux uinput layer for button events or API for displaying
raw text on embedded display; or CSR audio codec negotiation).

So how do you see possibility to have also HSP profile in ofono? So have
one place which would provide audio API for SCO? Because this is a big
requirements from audio software side, to not use 4 different APIs to
access SCO sockets (and its rfcomm / SLC configuration) in HSP and HFP
profiles.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--uyhocsynyyrntqot
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXf1PXwAKCRCL8Mk9A+RD
UjJiAJ9i1heVz0qZRiSLX16RevVqDNVS+gCfdzK0KjKbjIAgcFHOt/Mxm+5Pdp4=
=O2VP
-----END PGP SIGNATURE-----

--uyhocsynyyrntqot--
