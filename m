Return-Path: <SRS0=JtZ7=24=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D23C282DD
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jan 2020 19:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FD242187F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jan 2020 19:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iz77Dw/E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbgAGTBt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jan 2020 14:01:49 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36422 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728540AbgAGTBs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jan 2020 14:01:48 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so712929wma.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jan 2020 11:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+PtR96xiYtwDK9FqGIGoabHriuTvKB1k4AZZBCYXNgM=;
        b=Iz77Dw/E8YrL3Ni4TEf3kvkAEQp4fVjqAIce3zmiwEogrVMkNcPLNMA/MVc73BbO+d
         CoMT8BgDjB9fsHjcUSuQw8tm/Ynf2ZesQf4D47EvyiQVBx25Zj6DTZGPoUmerUw24arc
         tDLrI1GExpO4uY0sr+w0KyJ2WRwboIsD6670G1rlxDYrxPnKsCSmq1LHRNxvNw2ukxGx
         sowxN3gH6+agVy2f7+VWhWI1ruCwZ4wu3O8JW5jcVQKPNZzchH4pmCAJNd/MSHp18K5q
         1oq1kTE6y0oCpq1GbSoQrGyHTWWg+z/lBfMJRMRw6EpIDdmWNH/fEHChSFiCtOAU5jpE
         eTZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+PtR96xiYtwDK9FqGIGoabHriuTvKB1k4AZZBCYXNgM=;
        b=KloKPXJYcTQo0mnXEW+ocIYrOpihktbvrlFPjWGzJbJT/enWoTV7DGwkA3UMJj9uQo
         HUT15zGz2yXhW9zpDV68KkQjik3IlUZDKXh85e3F5Cghx4SOJFwsecuZUUO7CvNXEC80
         B2YXypOuS+ZzcVUAIhNqmwPjcqPyU765AeuRPkyS1O6JTNStLjijkAhDwZbBrzTkEVZb
         5biwgP/dXuJBe77wO0YUzc4PuEPkdzQETd/MNIRgiKhKZnni0CIsi3oNHDOX/KnXmKXI
         HKRLNL5YH1dS219fIYf6TcetwhasXVZWy3A7p+1NACeXfL/kiD/rzg0ntJRTuR+PFq+r
         2nOA==
X-Gm-Message-State: APjAAAXVwW8clblHSFgd+7+F0XKfxAzlJwuRQKAS4ru2o7T7Z8HWt+0d
        S/qQkhiJf8S4/HGdMLkxM9c=
X-Google-Smtp-Source: APXvYqwyWnbjMsKnSGk7lgkspYLuFk8WkrgkGAe0q6JlB1N9avwigf6dGKnDMgNZiPtOK1iY4mkd0g==
X-Received: by 2002:a1c:1fc5:: with SMTP id f188mr513812wmf.55.1578423705400;
        Tue, 07 Jan 2020 11:01:45 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id b17sm967816wrx.15.2020.01.07.11.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 11:01:43 -0800 (PST)
Date:   Tue, 7 Jan 2020 20:01:42 +0100
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
Message-ID: <20200107190142.vnb4i7jdhd6xhhk6@pali>
References: <20191218173632.aqdmdhutu3ruezck@pali>
 <06eb7e98-1357-afd1-40a5-2ccb139d8dec@gmail.com>
 <20191218213349.2ksew2wnhgu3peub@pali>
 <0cfbe253-417c-e7c0-553a-abf360a80c9f@gmail.com>
 <20191219095132.blj3oyyrlfowv5ik@pali>
 <90261b42-1048-370f-7680-acd9f7e754ed@gmail.com>
 <20191219153344.hxnoa3idqvgdwrp2@pali>
 <76f1cb25-b608-e4e9-6fd9-8da932c56a15@gmail.com>
 <20191220224657.n4m6qkxa4sceau3l@pali>
 <1eeea3f8-d06b-f774-c01d-1c7dbdb71c32@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="u6y2gkpelgu22seo"
Content-Disposition: inline
In-Reply-To: <1eeea3f8-d06b-f774-c01d-1c7dbdb71c32@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--u6y2gkpelgu22seo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tuesday 07 January 2020 11:35:48 Denis Kenzior wrote:
> Hi Pali,
>=20
> <snip>
>=20
> > > I think you will need to do this regardless.  Otherwise I fail to see=
 how
> > > you prevent one 'agent' from consuming AT commands it shouldn't be. T=
his is
> > > a possibility you need to consider, whether it happens by accident or
> > > maliciously.
> >=20
> > Some subset of AT commands are needed to parse and interpret. But not
> > telephony commands and having up-to-date internal telephony state.
>=20
> Please think some more about what I said.  You will need to parse every AT
> command in your daemon, no way around that.  You are right that you do not
> need to keep track of the telephony state, but that is besides the point.
> So if you need an AT parser anyway, the whole reasoning for the proposed
> architecture starts to look shaky.

I do not need to parse and interpret all AT commands. Telephony commands
does not have to parsed and interpreted. They can be forwarded to
telephony agent (if connected) OR replied with ERROR as a result that
command is not supported.

>=20
> >=20
> > > - The other example is more practical. HFP Service Level Connection (=
SLC)
> > > establishment is actually quite tricky.  There are certain limitation=
s on
> > > what can and cannot be done prior to SLC establishment, including how=
 audio
> > > handling is done.
> >=20
> > I know :-) I already implemented prototype implementation to check and
> > see how complicated it is and if API make sense and how hard it is for
> > agents (audio - pulseaudio) implement and maintain it.
> >=20
> > > Unfortunately, codec negotiation, indicator negotiation,
> > > and feature negotiation are part of the SLC. oFono already solves all=
 of
> > > this and handles all of it nicely.
> >=20
> > CSR codecs are not supported nor implemented in ofono. It is more
> > complicated as HFP codecs... and needs a new API for audio application.
> > Another value which brings my hsphfpd is that it handles these CSR
> > codecs and provide API for audio application to use them.
> >=20
>=20
> Again, you're not addressing my main point.  Codec negotiation is part of
> SLC establishment.  SLC has both telephony and audio aspects. They're
> inseparable.  Your architecture fails to address this...

Why? Codec negotiation is part of SLC, but codec can be changed prior
opening SCO connection.

How my architecture failed? What to address?

I implemented it in my prototype and it is working. So I do not
understand your point.

> CSR codecs are not part of SLC and can be bolted on later.  I already told
> you that oFono can easily be changed to support this.

I'm not disagreeing with this.

> > > We have passed all relevant
> > > certification testing.  It is very unclear how you plan to handle thi=
s (or
> > > whether you realistically even can) in your architecture when the
> > > responsibilities are split between the various daemons.  So again, oF=
ono has
> > > nothing to gain here...
> >=20
> > I was not thinking about certification. It is not something which I
> > could do.... And also pulseaudio itself do not have certifications.
>=20
> So again, no reason for us to get involved :)
>=20
> Bottom line is there's no value for us in this architecture.  If you want=
 to
> use the existing oFono APIs, that's fine.  But we're not adding a plugin =
for
> taking arbitrary AT commands from some other daemon :)

I can say exactly same. I'm not interested in any certification, I do
not see reason to care about it. Pulseaudio does not have any and is the
de-facto standard way how to use bluetooth audio on Linux.

> > > Perhaps this can even be solved in oFono itself (since it already doe=
s 90%
> > > of what you want) by making the modem requirement optional.  What we =
could
> > > do for example is to create a dummy modem if an AG connection is requ=
ested
> > > and no other suitable modems are detected in the system.  The resulta=
nt AG
> > > wouldn't have any call control capability, it could still be used for
> > > transferring audio data, battery, etc.  If you want to pursue this, w=
e can
> > > brainstorm further.
> >=20
> > Well, if this would work automatically without any user interaction or
> > without special setup, it seems to be usable.
> >=20
> > But what is needed from this implementation in ofono? Basically API for
> > each functionality designed in hsphfod daemon. And one of it is also
> > support for HSP profile (with CSR and Apple extensions).
>=20
> Start a separate thread on ofono for this.  I already gave you hints on h=
ow
> to solve the 'AG without a real modem' use case.  That would seem to be t=
he
> biggest 'win' and it should be fairly easy to make this work.

Ok, I will start a separate thread.

> >=20
> > I'm not against for it, but I thought that having functionality which is
> > not related to telephony / modem you would not want to see in ofono
> > project (like linux uinput layer for button events or API for displaying
> > raw text on embedded display; or CSR audio codec negotiation).
> >=20
> > So how do you see possibility to have also HSP profile in ofono? So have
> > one place which would provide audio API for SCO? Because this is a big
> > requirements from audio software side, to not use 4 different APIs to
> > access SCO sockets (and its rfcomm / SLC configuration) in HSP and HFP
> > profiles.
> >=20
>=20
> HSP is a separate issue.

It is not separate issue. It is one of the main issues. If ofono is not
going to support HSP then there is absolutely no reason why to use ofono
and extend it to support a new features which currently do not support
(like CSR codecs which are in both HSP and HFP profiles). Basically
without it ofono is unusable for handling bluetooth audio on Linux
desktop.

> Maybe we can handle it like the 'dundee' daemon
> inside oFono (which handles Bluetooth DUN profile).  In other words have a
> dedicated daemon for hsp support that reuses the relevant bits of oFono a=
nd
> maybe exposes the same APIs (i.e the ones documented in
> doc/handsfree-audio-api.txt).  That would make life for PulseAudio pretty
> easy.
>=20
> Regards,
> -Denis

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--u6y2gkpelgu22seo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXhTVkgAKCRCL8Mk9A+RD
Uoj7AKCw5Q4CwIik8i7QhbbqOsYYrSU6sQCgsOJeLedUSek27KcvNuuxng75Xf4=
=IQHq
-----END PGP SIGNATURE-----

--u6y2gkpelgu22seo--
