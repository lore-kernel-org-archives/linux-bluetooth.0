Return-Path: <SRS0=pKZ6=Z5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 540F2C43603
	for <linux-bluetooth@archiver.kernel.org>; Sat,  7 Dec 2019 20:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 171FF2176D
	for <linux-bluetooth@archiver.kernel.org>; Sat,  7 Dec 2019 20:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pBOzJWAf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfLGUJq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 7 Dec 2019 15:09:46 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39995 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbfLGUJq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 7 Dec 2019 15:09:46 -0500
Received: by mail-wm1-f68.google.com with SMTP id t14so10830371wmi.5
        for <linux-bluetooth@vger.kernel.org>; Sat, 07 Dec 2019 12:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zTFcQGgt0y0+1Vt9m3JmGh3/7BPWh/hEqRDqL2dWFZs=;
        b=pBOzJWAfTXXwxzzV6+GKPLT5V9F44f9MOMf87T+XnRPwtKAmiS3ZyQ/oUtmC157WmF
         psYFqsKNVQT993kLOmWeuSH0zKt6Ji2xl1obDhXrAyUnt54F5oi9xf+IW5T1lr1PzMzn
         q1J9Co2ShGxUgeEtkenAK7RPKRyoyIV/HTSsohEYvZFRc8EorducZPtty8HfzMGeXU/c
         THK/FPyTyz6QxY5zR/1dJqGTLL7HS9KOJie1HEhhmi9G7uwuDhGvfNEl19uzTbx2m+LU
         N+VZZV84OJ+4qotBE8LZa6ac5zoQA6yO23cvkLUlFd2UntHWz818PYc8DSQpnAChxLba
         yqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zTFcQGgt0y0+1Vt9m3JmGh3/7BPWh/hEqRDqL2dWFZs=;
        b=NmX6j+ssAnfM3TVLyzCbJAvBGztAHJ7ofzs0IZUSTARiHBe38B+qmrVtj6Oh2xCfgX
         iXAl5UhcZCVVG5zSQvaaOnYnmv4FxgTuRHxYxK3MqHWMJuEwNZWXchVJvj0/eQCITRx0
         cY0LsxHftyGQ/74qNCDav92sfugOjDhuNsU/dybdiD6QHIyotp3EYHmGLtlg5b1FTXIi
         YlHUphmsWGWNrag0ixDTuAI+tjRMq+tvMTZzodOIqMBP0HhxturQfCWT5n0NgXGxPE4e
         y9IJETMkPSzuOYg9QZxXI59SEOnDZ0usyP2GJNG1xLHZYn4xlDRUrfDEMz3qYZ5KPsqo
         stPQ==
X-Gm-Message-State: APjAAAWRKMJjf/Py0UsoG4JaKVUuBhlykaYp2tAfV5FUDb0SgW8aQ9C2
        ory9hc+n6O9aw/t/qAtW6j4=
X-Google-Smtp-Source: APXvYqxscLg9bUT1EVIcDfcl6isnLbMKu1bIr4Lan7YVAZPmi+Z2xbFuysgnUdMekSdfolBseU1w5g==
X-Received: by 2002:a1c:5603:: with SMTP id k3mr17518729wmb.150.1575749384277;
        Sat, 07 Dec 2019 12:09:44 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id n16sm20851924wro.88.2019.12.07.12.09.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 07 Dec 2019 12:09:43 -0800 (PST)
Date:   Sat, 7 Dec 2019 21:09:42 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Denis Kenzior <denkenz@gmail.com>, linux-bluetooth@vger.kernel.org,
        General PulseAudio Discussion 
        <pulseaudio-discuss@lists.freedesktop.org>, ofono@ofono.org,
        devkit-devel@lists.freedesktop.org,
        Bastien Nocera <hadess@hadess.net>,
        Georg Chini <georg@chini.tk>,
        Russell Treleaven <rtreleaven@bunnykick.ca>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Tanu Kaskinen <tanuk@iki.fi>,
        Arun Raghavan <arun@arunraghavan.net>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sebastian Reichel <sre@ring0.de>, Pavel Machek <pavel@ucw.cz>,
        Wim Taymans <wim.taymans@gmail.com>,
        George Kiagiadakis <george.kiagiadakis@collabora.com>
Subject: Re: Proposal for a new API and usage of Bluetooth HSP and HFP
 profiles on Linux
Message-ID: <20191207200942.nbao4mxsqw4sp67v@pali>
References: <20191201185740.uot7zb2s53p5gu7z@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="r6rwmkxghqiyn573"
Content-Disposition: inline
In-Reply-To: <20191201185740.uot7zb2s53p5gu7z@pali>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--r6rwmkxghqiyn573
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

+Denis from ofono

ofono and pulseaudio are two main users of HFP profile on Linux...

On Sunday 01 December 2019 19:57:40 Pali Roh=C3=A1r wrote:
> Hello!
>=20
> I'm sending this email to relevant mailing lists and other people who
> could be interested in it. (I'm not subscribed to all of ML, so please
> CC me when replying).
>=20
>=20
> I would like to open a discussion about a completely new way of handling
> Bluetooth HSP and HFP profiles on Linux. These two profiles are the only
> standard way how to access microphone data from Bluetooth Headsets.
>=20
>=20
> Previously in bluez4, HFP profile was implemented by bluez daemon and
> telephony HFP functionality was provided by either dummy modem, ofono
> modem or by Nokia's CSD Maemo modem.
>=20
> In bluez5 version was modem code together with implementation of HFP
> profile removed. And let implementation of HSP and HFP profiles to
> external application.
>=20
> Currently HSP profile is implemented in pulseaudio daemon to handle
> microphone and Bluetooth speakers. HFP profile is not implemented yet.
>=20
>=20
> HSP and HFP profiles use AT modem commands, so its implementation needs
> to parse and generates AT commands, plus implement needed state machine
> for it.
>=20
> And now problem is that last version of HFP profile specification is too
> complicated, plus Bluetooth headsets vendors started to inventing and
> using of own custom extensions to HFP profile and AT commands.
>=20
> Main problem of this "external" implementation outside of bluez is that
> only one application can communicate with remote Bluetooth device. It
> is application which received needed socket from bluez.
>=20
> So in this design if audio daemon (pulseaudio) implements HFP profile
> for processing audio, and e.g. power supply application wants to
> retrieve battery level from Bluetooth device, it means that audio daemon
> needs to implement also battery related functionality.
>=20
> It does not make sense to force power supply daemon (upower) to
> implement audio routing/encoding/decoding or audio daemon (power supply)
> to force implementing battery related operations.
>=20
>=20
> For handle this problem I would like to propose a new way how to use and
> implement HSP and HFP profiles on Linux.
>=20
> Implement a new HSP/HFP daemon (I called it hsphfpd) which register HSP
> and HFP profiles in bluez and then exports functionality for all other
> specific applications via DBus API (API for audio, power supply, input
> layer, telephony functions, vendor extensions, etc...). So it would acts
> as proxy daemon between bluez and target applications (pulseaudio,
> upower, ofono, ...)
>=20
> This would simplify whole HFP usage as applications would not need to
> re-implement parsing and processing of AT commands and it would allow
> more applications to use HFP profile at one time. And also it means that
> audio software does not have to implement telephony stack or power
> supply operations.
>=20
>=20
> I wrote a document how such DBus API could look like, see here:
>=20
>   https://github.com/pali/hsphfpd-prototype/raw/prototype/hsphfpd.txt
>=20
>=20
> And also I implemented "prototype" implementation to verify that
> designed API make sense and can be really implemented. Prototype fully
> supports HSP profile in both HS and AG role, plus HFP profile in HF
> role. This prototype implementation is available here:
>=20
>   https://github.com/pali/hsphfpd-prototype
>=20
> Some other details are written in README:
>=20
>   https://github.com/pali/hsphfpd-prototype/raw/prototype/README
>=20
>=20
> What do you think about it? Does it make sense to have such design?
> Would you accept usage of such hsphfpd daemon, implemented according to
> specification, on Linux desktop?
>=20
> I would like to hear your opinion if I should continue with this hsphfpd
> design, or not.
>=20
>=20
> With this design and implementation of hsphfpd is possible to easily fix
> pulseaudio issue about power supply properties:
>=20
>   https://gitlab.freedesktop.org/pulseaudio/pulseaudio/issues/722
>=20
>=20

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--r6rwmkxghqiyn573
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXewHBAAKCRCL8Mk9A+RD
UqQ1AJ9sturaMWoPNc/GGe5V2RKHs9wE2wCgh5c5h3TYdzekd5gkej2oie6n8xk=
=8Z4+
-----END PGP SIGNATURE-----

--r6rwmkxghqiyn573--
