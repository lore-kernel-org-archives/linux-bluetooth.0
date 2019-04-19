Return-Path: <SRS0=AkUh=SV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BEEFC282E2
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Apr 2019 20:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A79A20821
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Apr 2019 20:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oX62g4m1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbfDSU0w (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Apr 2019 16:26:52 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40344 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbfDSU0w (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Apr 2019 16:26:52 -0400
Received: by mail-wm1-f68.google.com with SMTP id z24so7477253wmi.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Apr 2019 13:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BEzgpI2AoqZQC0msCyG59vfbPFspOKxh1lflI3Ur01Y=;
        b=oX62g4m18lY2e6xoRDFcHdx8x+ghflTnDUm8ql5XLu1pY9bZNyYr0dWUQbd9wGr8M3
         aUtUR5N8N8qlz8IbuN2Eqs89cnEMIZgjBJQ7p2et4mTEqcWfgAB397UVWW1E+TJgtbyv
         HGn1dXhSxGPCk9jtVndcbPOtFlQWmJEncIngQk+ayD1Pn66x3vRS8s9qJPStWhvsQlGM
         PVGf2wdomR3vsQsS0JUBIgSHBk7YOK0s87zv3gZn9x5wsokT3vfwqmo5pmijvY7ORyMn
         d6ZwpiBDrb3RELeFOj0Bq90uNHeZYbNu1eIDxMzojNOJo+kw7xyQ4F1G9UMAjF8Agxq8
         qCUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BEzgpI2AoqZQC0msCyG59vfbPFspOKxh1lflI3Ur01Y=;
        b=rIIJEj/k4g7nuFIpaBijj0BxoEugGvhDfrXbovcIQX82LNwThNPCo/LBpqwfqRpCl7
         oJwdLRsuV3EALdZft51YITZXaSq+OFkNFQIQzeQF5LnXFSHkS7R1lzXyuEckgmRgtcK7
         KUUTLOUWsujwKAhgrA032poaEtocvvAnElma8QObHwm4IYBnFJrQaawmHnqynYVxCnVF
         mzkiDmzkroueDKs5KauI4G+EE9cnkQglHuUOkp+WUM49s8GOhkiBjgUspWEocHw5xPPQ
         eYavyWJnlavEHrNPm1JIikuUZ3cTeDc238C+nHYWWvEc2uGPixmpt37q4t8kShcPfKCC
         /HXw==
X-Gm-Message-State: APjAAAWXnI4tWiBA1QKtoMqpMBaVFH4e9mfwN6MbhuBZuM/30GdfOLdi
        FsQnBoJCTXCnEWuqWHLQiU6vEgMY
X-Google-Smtp-Source: APXvYqwLokEEiSGskRY7r56I3xw0T06j6pByLdjLgLDyU+8Qk3gydij8U/0THolnx9UAUtf4rloW2g==
X-Received: by 2002:a1c:a683:: with SMTP id p125mr1744299wme.151.1555660993463;
        Fri, 19 Apr 2019 01:03:13 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id o6sm5251587wre.60.2019.04.19.01.03.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Apr 2019 01:03:11 -0700 (PDT)
Date:   Fri, 19 Apr 2019 10:03:10 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v3 1/9] doc/media-api: Enable MediaEndpoint to expose
 remote SEP
Message-ID: <20190419080310.hnohcsvxhudrcqbq@pali>
References: <20190122134524.20509-1-luiz.dentz@gmail.com>
 <CABBYNZLCFpXhbAnVYaA-nVNOY8QRvpR1UZhMHfy-awZxtpSocQ@mail.gmail.com>
 <20190122175622.dj6riiim6zukpetw@pali>
 <CABBYNZJGLGnNzXC_Q+Visk1XPwP9FX+BvJ65UQMj4tMJfL92+Q@mail.gmail.com>
 <20190405164713.cvfciulxnby25o3g@pali>
 <CABBYNZJQvOODiwVcNrDPH7A+5qTM0ZmSHaZ8=+=32CeH1t482A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bn2ewpffzybttnpp"
Content-Disposition: inline
In-Reply-To: <CABBYNZJQvOODiwVcNrDPH7A+5qTM0ZmSHaZ8=+=32CeH1t482A@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--bn2ewpffzybttnpp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Monday 08 April 2019 12:41:06 Luiz Augusto von Dentz wrote:
> Hi Pali,
>=20
> On Fri, Apr 5, 2019 at 7:47 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wro=
te:
> >
> > Hello, I have found another problem with this patch series.
> >
> > I have there Nokia N900 device with Community SSU updates which acts as
> > both A2DP sink and A2DP source.
> >
> > When I scan A2DP capabilities of Nokia N900 I get following output:
> >
> > $ ./tools/avinfo XX:XX:XX:XX:XX:XX
> > Connecting ...
> > Stream End-Point #1: Audio Source
> >         Media Codec: SBC
> >                 Channel Modes: Mono DualChannel Stereo JointStereo
> >                 Frequencies: 16Khz 32Khz 44.1Khz 48Khz
> >                 Subbands: 4 8
> >                 Blocks: 4 8 12 16
> >                 Bitpool Range: 2-64
> > Stream End-Point #2: Audio Sink
> >         Media Codec: SBC
> >                 Channel Modes: Mono DualChannel Stereo JointStereo
> >                 Frequencies: 16Khz 32Khz 44.1Khz 48Khz
> >                 Subbands: 4 8
> >                 Blocks: 4 8 12 16
> >                 Bitpool Range: 2-64
> >
> > $ qdbus --system org.bluez
> > /
> > /org
> > /org/bluez
> > /org/bluez/hci0
> > /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX
> > /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/fd2
> > /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/player0
> > /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/sep1
> > /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/sep2
> > /org/bluez/test
> >
> > So there is one SEP as Audio Source and one SEP as Audio Sink.
> >
> > But when I ask sep1 and sep2 for UUID via dbus, I get that both are just
> > Audio Sinks:
> >
> > $ qdbus --system org.bluez /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/sep1 o=
rg.bluez.MediaEndpoint1.UUID
> > 0000110a-0000-1000-8000-00805f9b34fb
> >
> > $ qdbus --system org.bluez /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/sep2 o=
rg.bluez.MediaEndpoint1.UUID
> > 0000110a-0000-1000-8000-00805f9b34fb
> >
> > So this is a clear bug.
>=20
> I will send a fix shortly.

I tested patch which is in bluez master git repository and it is working
fine. I needed to fix my pulseaudio code as I have there switched SINK
and SOURCE macros.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--bn2ewpffzybttnpp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXLmAvQAKCRCL8Mk9A+RD
UnThAJ0e7me0HFIWVtTNA22J9Ofal6/JagCfRYkzTl2ECWbXl1j96zTTEODKZlM=
=pyEL
-----END PGP SIGNATURE-----

--bn2ewpffzybttnpp--
