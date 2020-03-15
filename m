Return-Path: <SRS0=4xDg=5A=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C9FC10DCE
	for <linux-bluetooth@archiver.kernel.org>; Sun, 15 Mar 2020 14:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 976F8205C9
	for <linux-bluetooth@archiver.kernel.org>; Sun, 15 Mar 2020 14:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8gHr01g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbgCOOR6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 15 Mar 2020 10:17:58 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40336 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbgCOOR6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 15 Mar 2020 10:17:58 -0400
Received: by mail-wm1-f66.google.com with SMTP id z12so5989771wmf.5
        for <linux-bluetooth@vger.kernel.org>; Sun, 15 Mar 2020 07:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/s8nkDjkjeb1f4qspOqB1mWwGjc55UtxOthye7DEkK4=;
        b=Y8gHr01gtl75iiVU92I33vsHGNKaxjgfn8oRnzh/1FTJvCdT8hBeeKzeb9jPY81DQC
         6v+ud2dkYG3erFsxUj49qKt/++E4X10YsQgbKhZF0Xr+FwoiFWtfO8FakCxtZnxgtsWr
         59EgHLY9C0iHCKxWaJYmJS4HlcqCwL54ZZbHyfyWuEWzOXuYZH342w6CVszImA4te5Fd
         m8EDYY2A16mYVPAxQKw7vgBGELagyi1H7yUFd9UJmq3gbjFUHuQQ9pI0WJEdE8U1/4CP
         XLRbs4QSMXBhlV7Bz1aaJVUyW6EyVrCFlI0Tri98ZGr5vSCxO6snRS/P0zv19ur+HrRf
         SZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/s8nkDjkjeb1f4qspOqB1mWwGjc55UtxOthye7DEkK4=;
        b=j7wfD/fyrNI+508pACJV6E4GJ0pAk4qqPdQE6wmOZJZlqf8ThbcdJ5QnD6jA2ZUjiA
         /uvhdVb+H20iPcedyyVnErP6uTG33AKCarUS+luny8jH0NGUyUseKdcSFuUC6lSMcDtr
         5ZKJzSkrnUtHRlPppxli22XFhMvA0Di0BLr49IC2IqanCT7K9Fwul3ECpBopG8tzmdrz
         GLEUpI1agaGZD7mdmOhczKB4y22uk7Ihu7k9MqeDU3vCRMpS9pPFaOqftx7dBohdDNj8
         1/Oc1ResDB6hecUlZqQUtHzuXNTPBOKU7zfMPrsrMK+8rQkY3zVVduPoh8RzPooETO6u
         i7pg==
X-Gm-Message-State: ANhLgQ1lLYw02UdhPrbu9WswJSfGhtuE0ze8MPf0A1FNaImo/atakCoH
        f9URyXwV60FlGqvgOSKSQvnOU8S+
X-Google-Smtp-Source: ADFU+vuRB0Jn1aWk+Iy4l23NaPg7SMRVujPHxAW31R2F7e21Nq7dhR0xFgldINIXW1Mc2BW6ytT21A==
X-Received: by 2002:a1c:2784:: with SMTP id n126mr22046448wmn.111.1584281875347;
        Sun, 15 Mar 2020 07:17:55 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id g3sm6596492wro.93.2020.03.15.07.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 07:17:53 -0700 (PDT)
Date:   Sun, 15 Mar 2020 15:17:52 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     linux-bluetooth@vger.kernel.org,
        pulseaudio-discuss@lists.freedesktop.org,
        devkit-devel@lists.freedesktop.org,
        Bastien Nocera <hadess@hadess.net>,
        Russell Treleaven <rtreleaven@bunnykick.ca>,
        Sebastian Reichel <sre@ring0.de>, Pavel Machek <pavel@ucw.cz>,
        Wim Taymans <wim.taymans@gmail.com>,
        Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>,
        George Kiagiadakis <george.kiagiadakis@collabora.com>,
        Stuart Naylor <stuartiannaylor@outlook.com>,
        emmanuel.fuste@laposte.net, David Heidelberg <david@ixit.cz>,
        "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: Proposal for a new API and usage of Bluetooth HSP and HFP
 profiles on Linux
Message-ID: <20200315141752.s5ocejrpzabxbuzn@pali>
References: <20191201185740.uot7zb2s53p5gu7z@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="qpxjrbavgrhmnt5e"
Content-Disposition: inline
In-Reply-To: <20191201185740.uot7zb2s53p5gu7z@pali>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--qpxjrbavgrhmnt5e
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello! Below is my email from December 2019 about a new and I think
proper way how to handle Bluetooth HSP and HFP profiles on Linux desktop
system which do not have any cellular modem or other mobile hardware.

I would like to ask audio people and teams (bluez-alsa, pipewire) and
also other people around. Are you interested in using my hsphfpd DBus
API in audio applications? And if yes, would you implement this API in
audio routing software? Do you have some comments or review of hsphfpd
API? Or would you like to somehow extend it? Also who could be
interesting in helping, developing, testing or maintaining hsphfpd
daemon itself?

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

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--qpxjrbavgrhmnt5e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXm45DgAKCRCL8Mk9A+RD
UpVQAJ93zll75qBfqwJZCzwO9Xhh9FdclwCgjQ9B4hqPG0qjVvYM6Xc56Mz54zQ=
=ky5G
-----END PGP SIGNATURE-----

--qpxjrbavgrhmnt5e--
