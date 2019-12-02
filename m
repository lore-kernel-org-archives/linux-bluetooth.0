Return-Path: <SRS0=9PGa=ZY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2840CC432C0
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Dec 2019 18:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2A0920717
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Dec 2019 18:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlGgQ6yi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbfLBSpR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Dec 2019 13:45:17 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37770 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727938AbfLBSpR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Dec 2019 13:45:17 -0500
Received: by mail-wr1-f67.google.com with SMTP id w15so458741wru.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Dec 2019 10:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TnAYlKhcW8HfNthmxHYZljU0jXGrgSJD86HbMkHrXH8=;
        b=KlGgQ6yiXxMJLyp1xzcgM3U/58iC6PR0trXxihgWd3CPgPfd/l+7pfcXQlsVgkFGs7
         26/YU6WwNj2+YpKcSskORJTu2wh/DHKyrfAX5J/eUC+UWf2Fwy4AMMOy/llOJYXGGDr1
         0FDQ3JYtpjybx5ORO/rjGzaZoTuU49xNBYo0yNd3YJLJfMUh8mxGWqJ+jDTeDYRwQDzK
         Jb0YfshAbxglJANT/6lY0tGoIC5eaVD423W0rXUhCVynKZyVor6q+KKHrGQqa3DIYo8x
         fLF2XRWBw5euQD8M9IMLFLz+GkHmlvi7W2DWQ29WW2DlpVBdh6D7lWJlLwqiVkOfnwSb
         0QDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TnAYlKhcW8HfNthmxHYZljU0jXGrgSJD86HbMkHrXH8=;
        b=d8OdbNa/p7jPLmuCMANRMHrmzNFfJJbpXmHQyJvh131m5b7pdJ6HbifqeS2aYlLjCc
         7kore436yE0SmpD6xN62RgtadcXuzOJh4IIjmjKCGzCr0TmpTtfWhHiL/K8kiMAs2TTf
         EunTSI+rEe7Wxk83InWLgA3nOH2OPUICKlnLUD8OkoBAkpmIYiE6NnCV6G+AJuorUdol
         nqm/iGsVMQwz/O1TzW/DaeW0Tf06NkhBux9vCzV+S4mqIDL5hoIXuD13NhgxY+2Bpptb
         3wXuo/e3OS2ATGLLgRll1iscQMxBWY77uGHuEB7KqxU+mU23EjSLosKKxaHpW5GlGxJD
         SU8Q==
X-Gm-Message-State: APjAAAXZQJxrjisV4cVysy0q1QCSYG1cA8NAt491tLA/b8wEyvznZ+dY
        OmFtow9dhOwCXLU9f8yvAqk=
X-Google-Smtp-Source: APXvYqxP99K9MaWyi0tLAbu+mhQdWtKdR1wri+01Rei4iSIdE27R20sMDbNy5Hz6kcfIooYthyi7eA==
X-Received: by 2002:adf:f504:: with SMTP id q4mr345944wro.299.1575312314444;
        Mon, 02 Dec 2019 10:45:14 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id x125sm290128wmx.43.2019.12.02.10.45.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Dec 2019 10:45:13 -0800 (PST)
Date:   Mon, 2 Dec 2019 19:45:12 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Tanu Kaskinen <tanuk@iki.fi>
Cc:     General PulseAudio Discussion 
        <pulseaudio-discuss@lists.freedesktop.org>,
        linux-bluetooth@vger.kernel.org, ofono@ofono.org,
        devkit-devel@lists.freedesktop.org,
        Bastien Nocera <hadess@hadess.net>,
        Georg Chini <georg@chini.tk>,
        Russell Treleaven <rtreleaven@bunnykick.ca>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Arun Raghavan <arun@arunraghavan.net>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sebastian Reichel <sre@ring0.de>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [pulseaudio-discuss] Proposal for a new API and usage of
 Bluetooth HSP and HFP profiles on Linux
Message-ID: <20191202184512.rx6p63c6axztnwrw@pali>
References: <20191201185740.uot7zb2s53p5gu7z@pali>
 <508d35f29c2abc26af15e232a38d3ca53eb33706.camel@iki.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="wa3ntqaf7xojq3qv"
Content-Disposition: inline
In-Reply-To: <508d35f29c2abc26af15e232a38d3ca53eb33706.camel@iki.fi>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--wa3ntqaf7xojq3qv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Monday 02 December 2019 19:01:11 Tanu Kaskinen wrote:
> On Sun, 2019-12-01 at 19:57 +0100, Pali Roh=C3=A1r wrote:
> > Hello!
> >=20
> > I'm sending this email to relevant mailing lists and other people who
> > could be interested in it. (I'm not subscribed to all of ML, so please
> > CC me when replying).
> >=20
> >=20
> > I would like to open a discussion about a completely new way of handling
> > Bluetooth HSP and HFP profiles on Linux. These two profiles are the only
> > standard way how to access microphone data from Bluetooth Headsets.
> >=20
> >=20
> > Previously in bluez4, HFP profile was implemented by bluez daemon and
> > telephony HFP functionality was provided by either dummy modem, ofono
> > modem or by Nokia's CSD Maemo modem.
> >=20
> > In bluez5 version was modem code together with implementation of HFP
> > profile removed. And let implementation of HSP and HFP profiles to
> > external application.
> >=20
> > Currently HSP profile is implemented in pulseaudio daemon to handle
> > microphone and Bluetooth speakers. HFP profile is not implemented yet.
> >=20
> >=20
> > HSP and HFP profiles use AT modem commands, so its implementation needs
> > to parse and generates AT commands, plus implement needed state machine
> > for it.
> >=20
> > And now problem is that last version of HFP profile specification is too
> > complicated, plus Bluetooth headsets vendors started to inventing and
> > using of own custom extensions to HFP profile and AT commands.
> >=20
> > Main problem of this "external" implementation outside of bluez is that
> > only one application can communicate with remote Bluetooth device. It
> > is application which received needed socket from bluez.
> >=20
> > So in this design if audio daemon (pulseaudio) implements HFP profile
> > for processing audio, and e.g. power supply application wants to
> > retrieve battery level from Bluetooth device, it means that audio daemon
> > needs to implement also battery related functionality.
> >=20
> > It does not make sense to force power supply daemon (upower) to
> > implement audio routing/encoding/decoding or audio daemon (power supply)
> > to force implementing battery related operations.
> >=20
> >=20
> > For handle this problem I would like to propose a new way how to use and
> > implement HSP and HFP profiles on Linux.
> >=20
> > Implement a new HSP/HFP daemon (I called it hsphfpd) which register HSP
> > and HFP profiles in bluez and then exports functionality for all other
> > specific applications via DBus API (API for audio, power supply, input
> > layer, telephony functions, vendor extensions, etc...). So it would acts
> > as proxy daemon between bluez and target applications (pulseaudio,
> > upower, ofono, ...)
> >=20
> > This would simplify whole HFP usage as applications would not need to
> > re-implement parsing and processing of AT commands and it would allow
> > more applications to use HFP profile at one time. And also it means that
> > audio software does not have to implement telephony stack or power
> > supply operations.
> >=20
> >=20
> > I wrote a document how such DBus API could look like, see here:
> >=20
> >   https://github.com/pali/hsphfpd-prototype/raw/prototype/hsphfpd.txt
> >=20
> >=20
> > And also I implemented "prototype" implementation to verify that
> > designed API make sense and can be really implemented. Prototype fully
> > supports HSP profile in both HS and AG role, plus HFP profile in HF
> > role. This prototype implementation is available here:
> >=20
> >   https://github.com/pali/hsphfpd-prototype
> >=20
> > Some other details are written in README:
> >=20
> >   https://github.com/pali/hsphfpd-prototype/raw/prototype/README
> >=20
> >=20
> > What do you think about it? Does it make sense to have such design?
> > Would you accept usage of such hsphfpd daemon, implemented according to
> > specification, on Linux desktop?
> >=20
> > I would like to hear your opinion if I should continue with this hsphfpd
> > design, or not.
> >=20
> >=20
> > With this design and implementation of hsphfpd is possible to easily fix
> > pulseaudio issue about power supply properties:
> >=20
> >   https://gitlab.freedesktop.org/pulseaudio/pulseaudio/issues/722
>=20
> I quite like this proposal. Avoiding the need to implement the button
> press, battery level etc. handling separately in PulseAudio, oFono and
> PipeWire seems like a pretty good justification to me. I assume you're
> volunteering to maintain this new daemon?

Yes, I can maintain this new daemon.

> It's not clear to me how this would affect the PulseAudio <-> oFono
> interaction, if at all.

Only one application can register to bluez and "own" bluez socket for
communication with bluetooth headset. Currently it can be either
pulseaudio (with native backend in pulseaudio for HSP profile) or ofono
(with ofono backend in pulseaudio for HFP profile).

So if hsphfpd would be in use, then ofono would not be able to get
socket from bluez. And it would be needed to add a new "plugin" into
ofono to use hsphpfd for telephony operations. See hsphfpd.txt file
(there is diagram of usage).

> When oFono is used, would PulseAudio get the
> audio socket from oFono or hsphfpd?

Always from hsphfpd.

> What about volume commands, would they go through oFono or would
> PulseAudio interact with hsphfpd directly?

Internally they are handled by hsphpfd directly and appropriate API is
exported via DBus for audio application daemon (pulseaudio). For details
see hsphfpd.txt file, interface org.hsphfpd.AudioTransport.

> I think hsphfpd should be part of bluetoothd, but if that's not
> possible, then that's not possible.

I do not know if bluez developers are interested in having this code as
part of bluez project, specially when in bluez4 HFP profile was there
and in bluez5 was HFP code completely removed.

But it should not matter where hsphpfd is implemented.

> (I don't want to get into a lengthy discussion about programming
> languages, but I'll just note here that I don't like Perl.)

It is just a prototype. I used Perl just because it is faster for me to
implement parsing of AT commands needed for prototype purposes.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--wa3ntqaf7xojq3qv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXeVbtQAKCRCL8Mk9A+RD
UhyiAKCzu8rpGdjcNAU1TA0hLcZPVUa3pACfWZA39CkdG3uSovRwbC9f8F1jr7M=
=oksS
-----END PGP SIGNATURE-----

--wa3ntqaf7xojq3qv--
