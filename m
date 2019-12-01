Return-Path: <SRS0=ukjF=ZX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21126C432C0
	for <linux-bluetooth@archiver.kernel.org>; Sun,  1 Dec 2019 18:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D38AC20715
	for <linux-bluetooth@archiver.kernel.org>; Sun,  1 Dec 2019 18:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EO4pYNi0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbfLAS5p (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 1 Dec 2019 13:57:45 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39351 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfLAS5p (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 1 Dec 2019 13:57:45 -0500
Received: by mail-wm1-f68.google.com with SMTP id s14so13854288wmh.4
        for <linux-bluetooth@vger.kernel.org>; Sun, 01 Dec 2019 10:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Xq/RBPSQFJmYhLWpg2XwhynnGZ7roEU4Z9UWkc+CqJM=;
        b=EO4pYNi0T2YYJN4pwhNnqw3RUJ2SV8fb6k372cxlQgVTvnGwsIZUhYD4dQrMSceBkQ
         4ghqDUcXfzlKsaEXXZTv1lrh/5ivNUSF9TXJddb4gPDkcgukTz3ueoRdKH8yyl8pus/W
         MhrTpu7Ep7CooUogomPoQc0ueFKkYdw7lZZbWFB2L1ojYZPGiV1wFOcRPn+cPL4w0Zw4
         t6zwnjxz2SCyZ54+xjNzyqfaRM1UYG47PJYdgFLjaKbt/1TZ3CDsebn2CxYniJHEJ1zZ
         Nsn4shUej4p0I8NEaptz3A0DRAR0ajs6kZgECvylbjUui/4TWiggL+ESRTDZzqbDkWM8
         PUJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Xq/RBPSQFJmYhLWpg2XwhynnGZ7roEU4Z9UWkc+CqJM=;
        b=dtxMzyyeY8zN7ghvksdehN+i/mfLGDuIFeqwvuh0JrQU9rvnbQUdnt6jPO2MJubOBp
         GvGdVhlBCefFvccjay/iBeOCE5h6BB0V/vFWcWh/ZybPgsiEICkXtow9GDlzb7ZloO/f
         fWpUuL2frHvWTb+RLOiDPBRkJGzx+cMpf2F5zmDKXg1TaRp3C6eGC/nbA36iiujoD3wA
         yLzk6C0Xkbg4UtN+Ug53ME2QzO0SSIjtt9B7joq+AvmdKHUatb2plqmG4oWBOwaMRboE
         kmzXwbKu2Jr+foF6r8jXb1wles1OEkXyawexGudE0DadN6fOjWhMJjsG+oVVNekRFg8g
         UMNA==
X-Gm-Message-State: APjAAAXcv77SuP3dfZgQcGsi6zHa8YaO6dPUhiCX87Mqf5rsThxARBBj
        emE2JZXkWKxcutpln07kctfRZw+u
X-Google-Smtp-Source: APXvYqw+uF4dnINJX8oJwu2GzOcm6uAEavb/AsO43+QBwA48mcTUBQg3+CjTsQkWsbNFPu9eD4ruvQ==
X-Received: by 2002:a1c:a78f:: with SMTP id q137mr25409349wme.8.1575226661897;
        Sun, 01 Dec 2019 10:57:41 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id t8sm14007822wrp.69.2019.12.01.10.57.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 01 Dec 2019 10:57:40 -0800 (PST)
Date:   Sun, 1 Dec 2019 19:57:40 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     linux-bluetooth@vger.kernel.org,
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
        Sebastian Reichel <sre@ring0.de>, Pavel Machek <pavel@ucw.cz>
Subject: Proposal for a new API and usage of Bluetooth HSP and HFP profiles
 on Linux
Message-ID: <20191201185740.uot7zb2s53p5gu7z@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="nxj6qpmarjtupful"
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--nxj6qpmarjtupful
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

I'm sending this email to relevant mailing lists and other people who
could be interested in it. (I'm not subscribed to all of ML, so please
CC me when replying).


I would like to open a discussion about a completely new way of handling
Bluetooth HSP and HFP profiles on Linux. These two profiles are the only
standard way how to access microphone data from Bluetooth Headsets.


Previously in bluez4, HFP profile was implemented by bluez daemon and
telephony HFP functionality was provided by either dummy modem, ofono
modem or by Nokia's CSD Maemo modem.

In bluez5 version was modem code together with implementation of HFP
profile removed. And let implementation of HSP and HFP profiles to
external application.

Currently HSP profile is implemented in pulseaudio daemon to handle
microphone and Bluetooth speakers. HFP profile is not implemented yet.


HSP and HFP profiles use AT modem commands, so its implementation needs
to parse and generates AT commands, plus implement needed state machine
for it.

And now problem is that last version of HFP profile specification is too
complicated, plus Bluetooth headsets vendors started to inventing and
using of own custom extensions to HFP profile and AT commands.

Main problem of this "external" implementation outside of bluez is that
only one application can communicate with remote Bluetooth device. It
is application which received needed socket from bluez.

So in this design if audio daemon (pulseaudio) implements HFP profile
for processing audio, and e.g. power supply application wants to
retrieve battery level from Bluetooth device, it means that audio daemon
needs to implement also battery related functionality.

It does not make sense to force power supply daemon (upower) to
implement audio routing/encoding/decoding or audio daemon (power supply)
to force implementing battery related operations.


For handle this problem I would like to propose a new way how to use and
implement HSP and HFP profiles on Linux.

Implement a new HSP/HFP daemon (I called it hsphfpd) which register HSP
and HFP profiles in bluez and then exports functionality for all other
specific applications via DBus API (API for audio, power supply, input
layer, telephony functions, vendor extensions, etc...). So it would acts
as proxy daemon between bluez and target applications (pulseaudio,
upower, ofono, ...)

This would simplify whole HFP usage as applications would not need to
re-implement parsing and processing of AT commands and it would allow
more applications to use HFP profile at one time. And also it means that
audio software does not have to implement telephony stack or power
supply operations.


I wrote a document how such DBus API could look like, see here:

  https://github.com/pali/hsphfpd-prototype/raw/prototype/hsphfpd.txt


And also I implemented "prototype" implementation to verify that
designed API make sense and can be really implemented. Prototype fully
supports HSP profile in both HS and AG role, plus HFP profile in HF
role. This prototype implementation is available here:

  https://github.com/pali/hsphfpd-prototype

Some other details are written in README:

  https://github.com/pali/hsphfpd-prototype/raw/prototype/README


What do you think about it? Does it make sense to have such design?
Would you accept usage of such hsphfpd daemon, implemented according to
specification, on Linux desktop?

I would like to hear your opinion if I should continue with this hsphfpd
design, or not.


With this design and implementation of hsphfpd is possible to easily fix
pulseaudio issue about power supply properties:

  https://gitlab.freedesktop.org/pulseaudio/pulseaudio/issues/722


--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nxj6qpmarjtupful
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXeQNHwAKCRCL8Mk9A+RD
Uv8dAJ44NtFBzWdDMuQhQHUa8FkjxL6wFwCgrje2yhXpUyxbGBbOLrUkx/iRams=
=6fKI
-----END PGP SIGNATURE-----

--nxj6qpmarjtupful--
