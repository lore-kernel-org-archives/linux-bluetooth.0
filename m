Return-Path: <SRS0=DiUs=Z2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5909EC43603
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Dec 2019 17:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A171205ED
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Dec 2019 17:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYrUnVmz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbfLDRF1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Dec 2019 12:05:27 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39470 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728784AbfLDRF0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Dec 2019 12:05:26 -0500
Received: by mail-wm1-f67.google.com with SMTP id s14so531692wmh.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Dec 2019 09:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GVFHi3MqUrVUXKrFAbPrUxTdeWHEh1Utt1wXYo++VEo=;
        b=bYrUnVmzd7rkjaRTv/TXdOfXuMSaqkribKfgdr4TMGfl9bGTHS/JZzeMc47N0qNaw2
         iBhmE3jiJ2H5MZmqm8KDeWgfO4gpo2A4VuvFifh9dExLA4zVaG4JJDa5oooKNlSBMi6n
         kQvRhU+X68Xyt0os8JbC+JqJDQrqEikOyi0IVhf1VJMD4xqyvf2DDKTvw3yevem7WnEA
         fsqTe4zDcPHRx4xVbweONYzEV6jPjRfiW9b+w4yRB2CU2ma2mvOpmrXZeaIbrFdp8FYs
         TYgFvVXGZahMBeiX21E2bVe7c6KcpY8P+4dIxYN1WvTMPyb6eJ0jln7RRU2brxi323P+
         67qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GVFHi3MqUrVUXKrFAbPrUxTdeWHEh1Utt1wXYo++VEo=;
        b=Ifh34pmnX6MaFjWmE668Abix0EctzDHRP7CfROduGA4o8GNFo80Hw8gpYGS/Fep8/m
         RMPvncfoFzTHBJr83yp7zHhLA9xglJh/Yzl/7rhyWWwzihVnBF12cf8zAn8Yq+OLNCsS
         bjvhsObIZyWIHe9E6rqbluqwyOxDez8gyKQpFLZ4nIooqsUJSO9P9YsH63pBf6oECjQG
         oKgy68hIW2NC4ekUTVUUgRFAafsW62XfEuy9eLKfnN41DAa4CBJSON1pFswEHpO9pYfu
         dADLfYMYKbtwCbBf+JUhp3AfnwOoLK04jT47uNGEBsSMmFJnHFqROVOYOifiNhQofnvy
         Qs6g==
X-Gm-Message-State: APjAAAXXTTzQhfSYnWMOMtzz1U3fi9p0babdmIGe8UBdEayIYAbM02oH
        pZK4kmNLR6hQbE60C+5148U=
X-Google-Smtp-Source: APXvYqwC0yxAXmIOmrAQZ885IQT16dci3LhqlDTQJtRZI1SSM/Yu3mL5XkGFs2P2gA4Z+S/M8Hefwg==
X-Received: by 2002:a7b:c759:: with SMTP id w25mr654802wmk.15.1575479124582;
        Wed, 04 Dec 2019 09:05:24 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id u25sm7105756wmj.0.2019.12.04.09.05.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Dec 2019 09:05:23 -0800 (PST)
Date:   Wed, 4 Dec 2019 18:05:21 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Arun Raghavan <arun@arunraghavan.net>
Cc:     Tanu Kaskinen <tanuk@iki.fi>,
        PulseAudio Discussion <pulseaudio-discuss@lists.freedesktop.org>,
        linux-bluetooth@vger.kernel.org, ofono@ofono.org,
        devkit-devel@lists.freedesktop.org,
        Bastien Nocera <hadess@hadess.net>,
        Georg Chini <georg@chini.tk>,
        Russell Treleaven <rtreleaven@bunnykick.ca>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sebastian Reichel <sre@ring0.de>, Pavel Machek <pavel@ucw.cz>,
        Wim Taymans <wim.taymans@gmail.com>,
        George Kiagiadakis <george.kiagiadakis@collabora.com>
Subject: Re: [pulseaudio-discuss] Proposal for a new API and usage of
 Bluetooth HSP and HFP profiles on Linux
Message-ID: <20191204170521.mfo5qtoy65raetwc@pali>
References: <20191201185740.uot7zb2s53p5gu7z@pali>
 <508d35f29c2abc26af15e232a38d3ca53eb33706.camel@iki.fi>
 <20191202184512.rx6p63c6axztnwrw@pali>
 <190b130f-bc84-4af1-a807-5b5fbef3f166@www.fastmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="fjnfaeynkyyttc45"
Content-Disposition: inline
In-Reply-To: <190b130f-bc84-4af1-a807-5b5fbef3f166@www.fastmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--fjnfaeynkyyttc45
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wednesday 04 December 2019 20:45:23 Arun Raghavan wrote:
> Broadly, I think this is a good thing to do. My main concern is having th=
is be adequately maintained over a longer period of time.

I already prepared prototype implementation, so I know how hard is to
write or maintain this new daemon.

Are there any interested people in either implementing, maintaining or
in other way helping with this project?

The main problem in maintaining this HSP/HFP codebase I see that I do
not have enough testing devices. As we know lot of manufactures produce
devices which are not compliant to standards and this needs to be
handled in HSP/HFP codebase.

> The other thing to note is that in PipeWire, it is possible for external =
entities to implement the equivalent of a "sink" or "source" (it's just a n=
ode in PipeWire terminology), so in the long run, it might be good to have =
a single BT audio daemon that manages A2DP and HSP/HFP..

PipeWire or any other audio server (jack or bluez-alsa) can benefit from
this hsphfpd daemon that it does not have to implement (again) parsing
and interpreting AT commands (as needed for HFP standard).

For PipeWire developers: Do you have any special requirements for this
hsphfpd daemon which are needed for processing of audio?

See proposed DBus interface, specially "Audio Agent hierarchy":
https://github.com/pali/hsphfpd-prototype/raw/prototype/hsphfpd.txt

> This would also have the benefit of moving codec dependencies out of Puls=
eAudio (which I'll help mitigate in other ways within PulseAudio anyway).

hsphfpd just prepares SCO audio socket and then via DBus pass it to
target application (pulseaudio, pipewire, jacks, ...). And it is up to
the audio application to do codec processing. hsphfpd is not going to do
anything with audio samples or codecs. So this does not help directly...

=2E.. But I'm planing to try to separate A2DP code from pulseaudio into
some external library which would not depend on pulseaudio. So this
library can help all audio server projects to not re-implement again and
again A2DP (and HSP/HFP) audio processing. This library should do all
needed codec stuff (encoding, decoding, setup of A2DP, ...).

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--fjnfaeynkyyttc45
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXefnTwAKCRCL8Mk9A+RD
UtizAJ4jebcbx+300lfUIYwDo6/CcO8AsQCcCrEwdRrkh+X8gbrX5/qLSQQ3YsQ=
=uINE
-----END PGP SIGNATURE-----

--fjnfaeynkyyttc45--
