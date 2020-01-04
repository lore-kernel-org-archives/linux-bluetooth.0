Return-Path: <SRS0=BHgP=2Z=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9769C3276F
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Jan 2020 10:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 853E0215A4
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Jan 2020 10:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrIqSn8I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725827AbgADKve (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 4 Jan 2020 05:51:34 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45421 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgADKve (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 4 Jan 2020 05:51:34 -0500
Received: by mail-wr1-f67.google.com with SMTP id j42so44586577wrj.12
        for <linux-bluetooth@vger.kernel.org>; Sat, 04 Jan 2020 02:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WtuNhMlfabh+DGuYFWBCAuABnXxeYGBtkT2uZTmhVY0=;
        b=SrIqSn8IwKHTGYJ/8kLCqiPLTe1MWOGcVs03NfID2xzjPHhJY1m/k7wsVCPpFbXgn4
         oVcV2QBSEO9wcQqbBiXaQ1UPg9T42APZVfKXQDOSnGY58cmfQqDcqf31rpHclFgZ9W7J
         yAklNJf0Rlz2nIIoPpSywYN+PTZQyZtbD1EqxPHJ212JT5gOvZIKz2FeM8ZaF4ekEpKW
         DST6wQMa4TpSEV2pFzvnmkGTkas17tb9bN+U90caj8dxyCfC0s3hugeXTifcO4L5YCAa
         o2MxY38qNXtQT71ey1krZFW9sB5fj+k5MqJCnswkdeb518SgyDH+G8/iDjAPSPbxU2EP
         53mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WtuNhMlfabh+DGuYFWBCAuABnXxeYGBtkT2uZTmhVY0=;
        b=HnzuYCRrOCpy8xMN39/Sfmhg91VAoyZRQ145JpzAW9Q3QriBv2qUx65mjeungEhUHP
         ghppWsPBioKQl8uku3gRUgkg1WGIEGLiDg6jqTs1bkVL8a9ZYUJLA0UPTRdCYS8l+WXy
         ykAC537smgygfKmUE6DR/7QqHkQ2Nv2oRiW/jisAUQ9YDcuP093Z9sd1eWfrp+jmc7na
         uFoyJQvL2gNKUIlmGo+XfZMmgdxp5bvbwOaRvgH6JbBM5jwpVEuPkCaF0EGgE7qvT0dF
         c0CFhkX8gTi+f1P+52veSiVmIkXQCIIPL06hh1bUJm8O1N+uDizAzqFkoZvXikCLqQvi
         NjMw==
X-Gm-Message-State: APjAAAUDL6bFSBw0GYzW6Qc9NqQFQiZOYsngi4JeacnWDTRefP17ogzL
        yUywt8v6j646EZnGDSK71+w=
X-Google-Smtp-Source: APXvYqyU5EUNsWZ8piBLnvnEy7r77vmapWhdtfqleSBq2A9Peh53iu5IqU1XAOaliPhYI0yI4K141w==
X-Received: by 2002:a5d:49c7:: with SMTP id t7mr90531089wrs.369.1578135090644;
        Sat, 04 Jan 2020 02:51:30 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id u1sm15241852wmc.5.2020.01.04.02.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2020 02:51:29 -0800 (PST)
Date:   Sat, 4 Jan 2020 11:51:28 +0100
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
Message-ID: <20200104105128.jm4drflyjipfo3iz@pali>
References: <20191218172828.vfie4su2whts2fqh@pali>
 <20191218173632.aqdmdhutu3ruezck@pali>
 <06eb7e98-1357-afd1-40a5-2ccb139d8dec@gmail.com>
 <20191218213349.2ksew2wnhgu3peub@pali>
 <0cfbe253-417c-e7c0-553a-abf360a80c9f@gmail.com>
 <20191219095132.blj3oyyrlfowv5ik@pali>
 <90261b42-1048-370f-7680-acd9f7e754ed@gmail.com>
 <20191219153344.hxnoa3idqvgdwrp2@pali>
 <76f1cb25-b608-e4e9-6fd9-8da932c56a15@gmail.com>
 <20191220224657.n4m6qkxa4sceau3l@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="u3wpnxolij2fpwuk"
Content-Disposition: inline
In-Reply-To: <20191220224657.n4m6qkxa4sceau3l@pali>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--u3wpnxolij2fpwuk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Friday 20 December 2019 23:46:57 Pali Roh=C3=A1r wrote:
> Hi!
>=20
> On Friday 20 December 2019 15:19:01 Denis Kenzior wrote:
> > Hi Pali,
> >=20
> > > > There have been one or two implementations of AG role fully externa=
l to
> > > > oFono.  These implementations simply used the existing oFono APIs t=
o drive
> > > > the modem.
> > >=20
> > > bluez & pulseaudio developers told me that it would be a good idea to
> > > avoid implementing a new AT parser for telephony stack. And rather use
> > > ofono implementation for telephony part...
> >=20
> > In my opinion there's nothing scary about AT parsing.  In fact that is =
the
> > easiest part of this whole venture.  If you don't want to roll your own
> > parser, you can borrow one from the oFono project.  We already solved t=
his
> > nicely in the form of the gatchat library.  You could incorporate this =
into
> > your project (if it is GPL compatible).  Or you could wait until we port
> > gatchat to ell which will be under LGPL license.
> >=20
> > >=20
> > > But if I should use existing DBus API provided by ofono, it means tha=
t I
> > > need to do parsing of all AT commands (including telephony) and
> > > translate them to ofono DBus API.
> >=20
> > I think you will need to do this regardless.  Otherwise I fail to see h=
ow
> > you prevent one 'agent' from consuming AT commands it shouldn't be. Thi=
s is
> > a possibility you need to consider, whether it happens by accident or
> > maliciously.
>=20
> Some subset of AT commands are needed to parse and interpret. But not
> telephony commands and having up-to-date internal telephony state.
>=20
> > >=20
> > > I agree, this should work and there is not need to modify ofono. But =
it
> > > means that in hsphfpd daemon I need to have full AT parser for all
> > > telephony commands and it was something which bluez / pa developers
> > > thought that should be avoided. Therefore I come up with idea that
> > > telephony commands would be handled by external Telephony Agent, which
> > > can be ofono.
> >=20
> > Understood.  But I think the metric function was selected inappropriate=
ly in
> > this case.  My opinion is that you should have started with what the ov=
erall
> > architecture should look like; you should not have based design decisio=
ns on
> > which parts might be a little hard to implement.
> >=20
> > >=20
> > > > You could do that.  But as I said, we rejected such a design a
> > > > long time ago due to complexity and other issues.
> > >=20
> > > Anyway, what is the problem with accepting modem socket in ofono via
> > > DBus and starts talking with it like with any other modem which ofono
> > > supports? Currently ofono already takes modem socket from bluez via D=
Bus
> > > API, so in same way hsphfpd can pass modem socket to ofono. Basically
> > > ofono then can reuse same code which already uses for sockets from
> > > bluez, just it do not have to parse and interpret audio related AT
> > > commands (as these are handled by hsphpfd itself).
> > >=20
> > > What are exact issues? I do not see complexity at ofono part (as has
> > > already everything implemented) and currently I do not see those "oth=
er"
> > > issues.
> >=20
> > The issues are many.  And really the question is not whether it 'could =
be'
> > done, but whether it 'should be' done.  Let me describe a couple exampl=
es:
> >=20
> > - In the case of HF role (1), oFono already provides all the necessary =
APIs.
> > So put yourself in oFono's maintainer shoes.  What would we gain by
> > supporting almost the same but different mechanism?  We would have to
> > introduce a new hfp_hf plugin, one that is almost identical, but differ=
ent
> > to hfp_hf_bluez5 plugin.
>=20
> Yes, this would be needed, but because code os very similar it could be
> reused from one common place.
>=20
> > These two plugins would have coexistence issues,
> > which would add more complexity.  Then there's the impact on PulseAudio=
 and
> > other users.  How do they know when to use the HandsfreeAudio API vs so=
me
> > external API?
>=20
> Because pulseaudio has already own implementation of HSP profile and
> some kind of ofono implementation (which you named below "giant hack")
> it already needs to handle such problem.
>=20
> But solution should be relatively simple. If we decide that new daemon
> is "new proper way" then it would have higher priority as current HFP
> API by ofono. So if hsphfpd is registered on dbus && hsphfpd say that it
> is active, then use hsphfpd. Otherwise if ofono is registered on dbus
> and say that device is active/connected use ofono.
>=20
> > Supporting this new way buys us a lot of extra code /
> > complexity with no value added.
>=20
> Value is support for HSP profile and support for HFP AG role without
> modem. And it would provide (for PA) unified same interface as for HFP
> HF role and HFP AG role with modem. I think this is a big value for PA
> (or bluez alsa or pipewire) to have one API which would handle all HSP
> and HFP profile/role combinations.
>=20
> > - The other example is more practical. HFP Service Level Connection (SL=
C)
> > establishment is actually quite tricky.  There are certain limitations =
on
> > what can and cannot be done prior to SLC establishment, including how a=
udio
> > handling is done.
>=20
> I know :-) I already implemented prototype implementation to check and
> see how complicated it is and if API make sense and how hard it is for
> agents (audio - pulseaudio) implement and maintain it.
>=20
> > Unfortunately, codec negotiation, indicator negotiation,
> > and feature negotiation are part of the SLC. oFono already solves all of
> > this and handles all of it nicely.
>=20
> CSR codecs are not supported nor implemented in ofono. It is more
> complicated as HFP codecs... and needs a new API for audio application.
> Another value which brings my hsphfpd is that it handles these CSR
> codecs and provide API for audio application to use them.
>=20
> > We have passed all relevant
> > certification testing.  It is very unclear how you plan to handle this =
(or
> > whether you realistically even can) in your architecture when the
> > responsibilities are split between the various daemons.  So again, oFon=
o has
> > nothing to gain here...
>=20
> I was not thinking about certification. It is not something which I
> could do.... And also pulseaudio itself do not have certifications.
>=20
> > >=20
> > > You suggested to use phone simulator together with ofono and then
> > > starts extending / patching phone simulator to supports all needed pa=
rts
> > > which are in my hsphfpd design (battery status, button press, codec
> > > selection)?
> > >=20
> >=20
> > Not quite.  I suggested you expand oFono's emulator implementation (for=
 AG
> > role) and its DBus APIs (for HF role) to support the new vendor specific
> > features that you want.
> >=20
> > Forget about the phone simulator, it is really irrelevant for what you'=
re
> > trying to accomplish.
>=20
> Ok. I thought that phone simulator =3D ofono emulator. I just saw that
> phone simulator which is described in pulseaudio documentation.
>=20
> > > Also how to handle the main problem of phone simulator that it is too
> > > much complicated to setup it on desktop? Looking at the steps...
> > >=20
> > > https://www.freedesktop.org/wiki/Software/PulseAudio/Documentation/Us=
er/Bluetooth/#index5h2
> > >=20
> > > ... that desktop user needs to run nontrivial commands in command lik=
e,
> > > plus creating configuration file only just to connect bluetooth heads=
et
> > > is ridiculous and non-acceptable for desktop application.
> > >=20
> > > If this problem is not fixed, ofono and phone simulator are not usable
> > > as "main" software implementation of HFP profile for usage of bluetoo=
th
> > > headsets on Linux.
> >=20
> > oFono was never advertised as solving the 'HFP AG without a modem' use =
case.
> > This is something we never had as a requirement / objective. Phonesim i=
s a
> > development tool.  So of course it isn't trivial to setup, it isn't mea=
nt to
> > be used in production in the first place.  The use of phonesim describe=
d in
> > the PA wiki, while creative, is a giant hack ;)
>=20
> Ok, so we definitely agree that ofono currently do not support HFP AG
> without modem for desktop users. And this scenario is needed for
> connecting bluetooth headsets, so we need some solution for it.
>=20
> > Basically it all boils down to the fact that nobody has stepped up all =
this
> > time to solve a particular use case you care about.  But blaming oFono =
for
> > this is misguided.
> >=20
> > So, if you want to solve the HFP AG without a modem case I fully support
> > your efforts.
>=20
> Ok! So which options do we have?
>=20
> > Perhaps this can even be solved in oFono itself (since it already does =
90%
> > of what you want) by making the modem requirement optional.  What we co=
uld
> > do for example is to create a dummy modem if an AG connection is reques=
ted
> > and no other suitable modems are detected in the system.  The resultant=
 AG
> > wouldn't have any call control capability, it could still be used for
> > transferring audio data, battery, etc.  If you want to pursue this, we =
can
> > brainstorm further.
>=20
> Well, if this would work automatically without any user interaction or
> without special setup, it seems to be usable.
>=20
> But what is needed from this implementation in ofono? Basically API for
> each functionality designed in hsphfod daemon. And one of it is also
> support for HSP profile (with CSR and Apple extensions).
>=20
> I'm not against for it, but I thought that having functionality which is
> not related to telephony / modem you would not want to see in ofono
> project (like linux uinput layer for button events or API for displaying
> raw text on embedded display; or CSR audio codec negotiation).
>=20
> So how do you see possibility to have also HSP profile in ofono? So have
> one place which would provide audio API for SCO? Because this is a big
> requirements from audio software side, to not use 4 different APIs to
> access SCO sockets (and its rfcomm / SLC configuration) in HSP and HFP
> profiles.

Hi Denis! Can you look at this email? I would like to know what could be
next steps, specially if ofono (in some way) could be extended for all
use-cases and would be usable for Linux desktop. Or not and I rather
should continue with my hsphfpd proposal.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--u3wpnxolij2fpwuk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXhBuLgAKCRCL8Mk9A+RD
Uu8cAJ0SBw0hnyo7gbt+6hKxDWJcsw5AjgCfVl0OXHhSWcx/it47Rkt+adhX5k8=
=1e7m
-----END PGP SIGNATURE-----

--u3wpnxolij2fpwuk--
