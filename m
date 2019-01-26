Return-Path: <SRS0=qwpb=QC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E03C282C7
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Jan 2019 10:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01217217D7
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Jan 2019 10:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeFgyTLw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfAZKPv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 26 Jan 2019 05:15:51 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34171 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfAZKPv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 26 Jan 2019 05:15:51 -0500
Received: by mail-wr1-f67.google.com with SMTP id f7so12813923wrp.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Jan 2019 02:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rfHb2DEIGpI+8Vk07/ubySXfh40QuvrW6cCf2FQNqoU=;
        b=CeFgyTLwkHd8JRocS4hBazyyRnbsDCA63qMUBMMxFL3y9QqkIKjPUKsERyAyCR+ZmL
         ZHpAEzZawVGpfDjicQ7A7IoNGKZZjUJXkYjrx0LGdCioBc4PRBpEfZ+pxQfPI9CrEsMt
         5Ww75fuda4eafID/ssjnnefOSSKH+6Avg2GavNfKqd7a5Q6/retsJaF//WOpk1AFRpNU
         yVSBGfyvXDDaMEVVZlYwWiECpAN9RaTIz8mGRaVdex6c0bClKcEA/dhLEGpQmZps6B6C
         UtyRTjJLGWLaa2gV4ClzPXgXDaJ8pfXOrQ4dPCwQlfKeVF+uAjmItPTTxjfGP22vO0yO
         shWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rfHb2DEIGpI+8Vk07/ubySXfh40QuvrW6cCf2FQNqoU=;
        b=i9HYAH65Ybi8H0E5BYyeKOVb4VSzEukv0a5/cu4VjHi7oMFoc3s5mzKxLrCgkhqLs4
         4fabFs385YloXI5RgCMMgkCkjKaywVHTtJfzfCqZ/X2N11CvkQyXSL2HO4CbLkG+hqtF
         2xyrPJutBKWSD3MVQjNQGsEK9Ku6fUkovfye0/970srqdNKZnFtLwQxhK9X/eE1ZYINP
         Uv6S5H8EzM3lBohgdFjTcefmrlFVQolwu5K1yqX6RI1YPN09vojiJrEeTusMu2iLta59
         73pVvlTucTxSgayWk6YaFWz3L3ZdSCfodFNg+S0h+kzp8HXuwNR+7TuXthNyqx9QiarF
         pyVw==
X-Gm-Message-State: AJcUukef3vWOGV7NETu/27PRkyPqLeWvQsfiiH2jyxadLJNwCEce3xgI
        oFEJQWdXQYUI/x47qfnNjLQ=
X-Google-Smtp-Source: ALg8bN7qvbuGkybzDGUAKkl5HPMdnCDQpxnIHbKyvR9qpgakC34rwwOncJeCgoi64u5qe/DLf6Mmcw==
X-Received: by 2002:adf:e3c8:: with SMTP id k8mr14650347wrm.83.1548497748915;
        Sat, 26 Jan 2019 02:15:48 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id y138sm76581112wmc.16.2019.01.26.02.15.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 26 Jan 2019 02:15:47 -0800 (PST)
Date:   Sat, 26 Jan 2019 11:15:46 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Pasi =?utf-8?B?S8Okcmtrw6RpbmVu?= <pasik@iki.fi>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: bluez: dbus method call for switching endpoint
Message-ID: <20190126101546.dwingybq7ee4w6lx@pali>
References: <CABBYNZLK4tyL8nvWbXxr6VctyEyJkMdwNiWMy4gUge9h9Vb4SQ@mail.gmail.com>
 <20181228191102.GA31975@reaktio.net>
 <CABBYNZ+bwbSkH4qtkuzhE=JY6KAGwJ_E4ABGT_LE6E277eTNDQ@mail.gmail.com>
 <20181229130818.jdcpwlpyoyhdqlf3@pali>
 <CABBYNZK4+K5vRF0JCHFcUjbfzWanp_ju6XfQQJWBtiLqKi=e7Q@mail.gmail.com>
 <20190108165612.5krhgtmce336xjx3@pali>
 <20190109180340.5fh7adag6buij4px@pali>
 <20190109181436.atlbhkqclpq3kcta@pali>
 <CABBYNZJk=wycGzic5+DqFHg=30KX9NNwnZMpsVdgkLjzseMA2g@mail.gmail.com>
 <20190110115910.jldtfzzrhvta44pa@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="xzosdn77cznlnmzu"
Content-Disposition: inline
In-Reply-To: <20190110115910.jldtfzzrhvta44pa@pali>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--xzosdn77cznlnmzu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thursday 10 January 2019 12:59:10 Pali Roh=C3=A1r wrote:
> On Thursday 10 January 2019 08:29:02 Luiz Augusto von Dentz wrote:
> > Hi Pali,
> >=20
> > On Wed, Jan 9, 2019 at 3:14 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> w=
rote:
> > >
> > > On Wednesday 09 January 2019 19:03:40 Pali Roh=C3=A1r wrote:
> > > > On Tuesday 08 January 2019 17:56:12 Pali Roh=C3=A1r wrote:
> > > > > On Tuesday 08 January 2019 13:44:24 Luiz Augusto von Dentz wrote:
> > > > > > > > Regarding the API I still didn't have time to start it, so =
it will
> > > > > > > > take a little longer than I antecipated.
> > > > > >
> > > > > > Ive just sent the patches adding support to switch the endpoint=
s, Ive
> > > > > > only tested with a couple of sony headsets so I would appreciat=
e if
> > > > > > you guys could try it as well. Note that the SetConfiguration m=
ust
> > > > > > come from the same D-Bus connection as the endpoint that would =
be
> > > > > > used, also if there is already an stream in place it must also =
be from
> > > > > > the same client since it would be terminated in the process, th=
is is
> > > > > > to prevent entities fighting to configure with its own priority=
 though
> > > > > > usually we only PA endpoints, if you want to bypass this just f=
or now
> > > > >
> > > > > Great! Once patches would be ready I would look at my last A2DP
> > > > > pulseaudio patches [1] and would try to implement switching, incl=
uding
> > > > > support for bi-directional FastStream codec -- which can benefit =
=66rom
> > > > > it.
> > > > >
> > > > > [1] - https://lists.freedesktop.org/archives/pulseaudio-discuss/2=
018-July/030344.html
> > > >
> > > > Hi! I applied your 6 patches from https://marc.info/?l=3Dlinux-blue=
tooth&r=3D1&b=3D201901&w=3D2
> > > > but whatever I did I was not able to locate in dbus hierarchy list =
of
> > > > A2DP codecs supported by device.
> > > >
> > > > I thought that somewhere in
> > > >
> > > > qdbus --system org.bluez /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX
> > > >
> > > > I found A2DP codec capabilities...
> > > >
> > > > So how to get list of all supported A2DP codecs for particular devi=
ce?
> > >
> > > Ah, I forgot to start bluetoothd with --experimental option. After th=
at
> > > I see sep*
> > >
> > > /
> > > /org
> > > /org/bluez
> > > /org/bluez/hci0
> > > /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX
> > > /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/sep1
> > > /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/sep3
> > > /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/sep5
> > >
> > > and qdbus --system org.bluez /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/se=
p1 org.freedesktop.DBus.Properties.GetAll org.bluez.MediaEndpoint1
> > > list them correctly.
> >=20
> > You can use d-feet as well, btw did you forget to paste sep2 and sep4
> > or the device just skip them?
>=20
> No. This headset exports only sep1, sep3 and sep5. And supports SBC,
> aptX and FastStream codecs. So count is correct, just numbering is not
> canonical.

Still, I have a question. Why there is only sep1, sep3 and sep5? Where
are numbers 2 and 4? Why numbering is not canonical: 1, 2, 3?

If it could help, here is output from avinfo:

Connecting ...=20
Stream End-Point #1: Audio Sink=20
	Media Codec: SBC
		Channel Modes: Mono DualChannel Stereo JointStereo
		Frequencies: 16Khz 32Khz 44.1Khz 48Khz=20
		Subbands: 4 8
		Blocks: 4 8 12 16=20
		Bitpool Range: 2-53
	Content Protection: SCMS-T
Stream End-Point #5: Audio Sink=20
	Media Codec: Vendor Specific A2DP Codec
		Vendor ID 0x0000004f
		Vendor Specific Codec ID 0x0001
		Vendor Specific Data: 0xf2
		Vendor Specific Value (aptX)
			Frequencies: 16kHz 32kHz 44.1kHz 48kHz=20
			Channel modes: Stereo=20
Stream End-Point #3: Audio Sink=20
	Media Codec: Vendor Specific A2DP Codec
		Vendor ID 0x0000000a
		Vendor Specific Codec ID 0x0001
		Vendor Specific Data: 0x03 0x23
		Vendor Specific Value (FastStream)
			Directions: sink source=20
			Sink Frequencies: 44.1kHz 48kHz=20
			Source Frequencies: 16kHz=20

You can see that there is endpoint 1, 5 and 3.

Who choose numbers for endpoints?

> > Ive made sure not to filter any
> > endpoints even if they would not have any matching local endpoints so
> > we allow new endpoints to be registered later, anyway SetConfiguration
> > actually checks that endpoints matches.
> >=20
>=20

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--xzosdn77cznlnmzu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXEwzUAAKCRCL8Mk9A+RD
UsG2AKCxeLwHSKxocUa9/Xqpo+5z9nzRMgCgoTTsWvsOSiD7LqiSXbAIR4YJ7oc=
=QmcS
-----END PGP SIGNATURE-----

--xzosdn77cznlnmzu--
