Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623C9C6FD19
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Mar 2023 23:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjCMXaG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Mar 2023 19:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjCMXaF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Mar 2023 19:30:05 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED8428225
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Mar 2023 16:30:03 -0700 (PDT)
Received: from [192.168.1.195] (91-152-123-43.elisa-laajakaista.fi [91.152.123.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav@iki.fi)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4PbCYh4xpVz4BKKC;
        Tue, 14 Mar 2023 01:29:59 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1678750201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SqasoCGUA3s88oV4rKwqoNgfr1p6YLq/4HQH5PDoulE=;
        b=L2YG+vJInWsWTQpEn82ENm+R4fLud4qDSweIUFEgwF/ZAIiHWS5dT+lcBvzo2PmcISqF6I
        ruvraRBdE/6R0HemGKCiNIXcqu1SbfNSDb2SUxegrOBhUOka51/xi1FBqhfWtfbbUE9365
        NBkLf1Da5oNZLs8S5zj5a6Q6eHap7adDarYMm1XmHmMX7KwVjikcUrWtctmIw/eYcTxV6r
        Z7K7L1AxIAb4B0gQRsA//z2TDlDf18/3dfvBVCBJ3LWBliRucDsJkom60xuVOXMfs1fRIo
        juyJ0+A6jgyZ7eciqjQjB7cX6vb1N3b6HwHzMjUUDuhUI0gwDkPCSeJQQ4IRVg==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1678750201; a=rsa-sha256;
        cv=none;
        b=X3XDjrBPBoKy+gsOagqWKmSc2osGNXFP18X0JmjyrGliLPdvLuMLs79r0VQjjnygqbrHt8
        1Wn69E3ggwNhBjt8VFnwLVQhYhV9bYjTOokrqwun+QoeSZiF0hrVrIg3nbeCPub1KOAljN
        96sD9Hs1YiaqrX0zrQd1Zzw4eXi6U6Mzf4cGgV1c4myPfUp7yW/3YTIodTRvlt7WsbRF28
        dFybFuHvuMGLSKc1hgZVo9aJFYiFRTlssflOv2V4pLuoO/7+nIgwa+4F+e8+OqYXAvBP80
        wLyHOAxM3OvBzLdRfOtivyWSUEDmrcESI5B6eVkwdawlG/iQJTJjV2jxDRNpHQ==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1678750201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SqasoCGUA3s88oV4rKwqoNgfr1p6YLq/4HQH5PDoulE=;
        b=S2heNRasTRW8RbnfUSOUMl70xEJ6/2EgHDsSCngB70MuhOcFcvHwlAm2W/GRq7R+QAqqQU
        Ai/OoIHvqRFPwEbRpa4hLMkiRMyZus3OJl5urVtiO4It0fT2bF6CH2ZH25gJ8UU3dh3EBf
        v4san5frpbq2dHyioiS1qaW7S/s0LaD7B8ieKhQPNV0viDNiZNXxV7yFt24s5v99kLwz+g
        jW41C4VM5xGgdQ1DQhP3tyjAJNfydLZxoh/HC2Kl+AabNApZTbe2Ofpi1n9yws7DstRqeC
        DU0Ib4BpU2/boXaRbTqOWIPCc2XV6NbpI5uIILRldifR7+AeUjmErulWIwHeUw==
Message-ID: <f86f2896be923a9caa5625457fea46d1c32b3114.camel@iki.fi>
Subject: Re: [RFC v2 01/12] shared/crypto: Add bt_crypto_sirk
From:   Pauli Virtanen <pav@iki.fi>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org,
        =?ISO-8859-1?Q?Fr=E9d=E9ric?= Danis 
        <frederic.danis@collabora.com>
Date:   Tue, 14 Mar 2023 01:29:59 +0200
In-Reply-To: <CABBYNZJ8GbCic4+dAz-04vji3xgtqYnXRUjTuWHSk3oGjXxA=Q@mail.gmail.com>
References: <20230307222422.2608483-1-luiz.dentz@gmail.com>
         <167849522070.21816.4954897604805294201.git-patchwork-notify@kernel.org>
         <CABBYNZJ8GbCic4+dAz-04vji3xgtqYnXRUjTuWHSk3oGjXxA=Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

su, 2023-03-12 kello 22:36 -0700, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli, Frederic,
>=20
> On Fri, Mar 10, 2023 at 4:40=E2=80=AFPM <patchwork-bot+bluetooth@kernel.o=
rg> wrote:
> >=20
> > Hello:
> >=20
> > This series was applied to bluetooth/bluez.git (master)
> > by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
> >=20
> > On Tue,  7 Mar 2023 14:24:11 -0800 you wrote:
> > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > >=20
> > > This adds bt_crypto_sirk which attempts to generate a unique SIRK usi=
ng
> > > the following steps:
> > >=20
> > >  - Generate a hash (k) using the str as input
> > >  - Generate a hash (sirk) using vendor, product, version and source a=
s input
> > >  - Encrypt sirk using k as LTK with sef function.
> > >=20
> > > [...]
> >=20
> > Here is the summary with links:
> >   - [RFC,v2,01/12] shared/crypto: Add bt_crypto_sirk
> >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Dc1dd94cc7f=
81
> >   - [RFC,v2,02/12] shared/ad: Add RSI data type
> >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Dc2e99aefd3=
37
> >   - [RFC,v2,03/12] doc: Add set-api
> >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D6477522e92=
e3
> >   - [RFC,v2,04/12] device-api: Add Set property
> >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D5bac4cddb1=
91
> >   - [RFC,v2,05/12] core: Add initial implementation of DeviceSet interf=
ace
> >     (no matching commit)
> >   - [RFC,v2,06/12] core: Check if device has RSI
> >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Df95ffcc8b1=
fe
> >   - [RFC,v2,07/12] main.conf: Add CSIP profile configurable options
> >     (no matching commit)
> >   - [RFC,v2,08/12] shared/csip: Add initial code for handling CSIP
> >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Dd297a03b7a=
61
> >   - [RFC,v2,09/12] profiles: Add initial code for csip plugin
> >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D9e1eb0a62b=
3f
> >   - [RFC,v2,10/12] tools: Add support to generate RSI using SIRK
> >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Dc446a64d46=
1b
> >   - [RFC,v2,11/12] client: Add support for DeviceSet proxy
> >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D373bafc34c=
e6
> >   - [RFC,v2,12/12] client: Use AdvertisingFlags when available
> >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D815f779aa8=
e4
> >=20
> > You are awesome, thank you!
> > --
> > Deet-doot-dot, I am a bot.
> > https://korg.docs.kernel.org/patchwork/pwbot.html
>=20
> Let me know if you guys are happy with this interface to detect
> Coordinated Sets, it still experimental so we can experiment with it
> until we think it is stable, regarding the implementation of the
> transports one major difference here is that we will need to encode
> left and right separately, not sure how hard it is to do that in
> pipewire?

As far as the device set DBus interface is concerned, it seems to work
fine for me currently (in wip implementation for PW [0]). Don't right
now see something that would need to be added/changed in it.

Channel splitting/merging is generally easy in PW. How the playback
synchronization is going to work on socket level may determine a bit at
what level in PW it is convenient to do though.


---

Laundry list for PW related to this:

* How to do TX syncronization properly with the ISO sockets needs still
some thinking. I have some wip patches [2] that add the timestamps and
other socket API that provide timing information to allow
synchronization to the Number of Completed packets events.
Corresponding Pipewire implementation [3] rate matches to keep the time
difference between those events and our audio reference time fixed at
e.g. 25ms (2 packets in controller). Not really clear yet if this is a
right thing to do to help the controller send packets at the right
time.

Here I see LE Read ISO TX Sync with Intel AX210 returning only zero
values in Command Complete in btmon for running CIS, so that command
doesn't seem to help here.

* BlueZ doesn't seem to pass on the PAC audio location it reads via
read_sink/source_pac_loc, probably very easy to fix.

* The CIS in a CIG cannot be started one by one, or connected to same
destination. The kernel appears to wait until all CIS sockets in same
CIG go to connect state before proceeding to create CIS. The spec does
not seem to require this (I have some pre-rfc patches to make it more
flexible [1].)

* PW currently does transport acquires synchronously and fails because
of that with multiple CIS, but it probably should do them async.


[0] https://gitlab.freedesktop.org/pipewire/pipewire/-/merge_requests/1564
[1] https://github.com/pv/linux/commits/iso-fix-multicis
[2] https://github.com/pv/linux/commits/iso-timestamp
[3] https://gitlab.freedesktop.org/pvir/pipewire/-/commits/iso-timestamp-te=
st

--=20
Pauli Virtanen
