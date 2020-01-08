Return-Path: <SRS0=1bSD=25=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0126C282DD
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 21:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B40C2206DA
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 21:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEUJcoo0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbgAHVZm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Jan 2020 16:25:42 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38771 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgAHVZl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Jan 2020 16:25:41 -0500
Received: by mail-wr1-f65.google.com with SMTP id y17so5036761wrh.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jan 2020 13:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vYF6F85CJAvt1T7S6voLpFNrHSJS53VgqXA5TcNTGGI=;
        b=cEUJcoo0b0asCr7AQ5QXLZKdu29CU56MDPVyFCQhtOQeOfbgUJmYfpFjaOatwBJoxZ
         t4fMUd5lg0oDZp4VRon1We5rU9afGo6TIGX+XTT8ZMzjU4svDLbty629/ZkSG8Bqq4hv
         Iz1zHSGSc7M3mxbCx5wv+bl1KT+Ds98OyhlThMRT1hzAZR6LCZGgpYpouqb0aTU0TSOH
         eYgYempVPsoNccQEoPJz2PQy1V+aUHuE4E2PSBEYzo+avmp0pv7T+LE/LdoPa0RBNXl6
         +tDd3wAndpsvGvkQRs4nZ0IqRR8BcPX9E1gDvSUclhZXTVhPjo9/ZEqtQbjtFIULSoty
         4S9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vYF6F85CJAvt1T7S6voLpFNrHSJS53VgqXA5TcNTGGI=;
        b=AhRIJUgMLzKUUeVtQGFeBXhZgGgKiqvXwDeUdAUgsGHCSFaMF87FYtXNcCE04HdLr1
         dJnwgwnwsVs2XHlvtFdxNSwIN4Wu72Cf4axCTLYTY4m5eOj87H7wTMjA5l/8fYBAIhiO
         qCmXO+7fT3JbKx1AjF2M0hFzgCrCFiALSQm4puZ8B8I904GrvkLf1b8/u3oGLl+Hs+Eu
         teidhv42T2WvGUXZiGPjcX9Kkmd/S8dfzp9HPfK+7fSQwMvIr0yLJUp1sytnuvBslHzR
         qyOwS/EG8bgHn+0KembEfsX4W16zWxzsfQzqqKnJZFqn7kVlaxTdlUhXVtEpc0HSJpP/
         R3Qw==
X-Gm-Message-State: APjAAAX2sGUnRUV/Bn6+vvUKkASSrksq5Cs7V7mfKukWPCT2jQfCzOpT
        nH8QIwvnPBC06C/A3XDHXpQb/u0e
X-Google-Smtp-Source: APXvYqy3WmbreO4vxS7f368GXBCbEsZjjAhr0yj+uI0ygMNJSa8A1b8GuGZeJDI7UC45SyIHh74CrQ==
X-Received: by 2002:a5d:6b88:: with SMTP id n8mr7192828wrx.288.1578518739585;
        Wed, 08 Jan 2020 13:25:39 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id n16sm6051585wro.88.2020.01.08.13.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 13:25:38 -0800 (PST)
Date:   Wed, 8 Jan 2020 22:25:37 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Denis Kenzior <denkenz@gmail.com>
Cc:     ofono@ofono.org, linux-bluetooth@vger.kernel.org
Subject: Re: HSP/HFP ofono bluetooth support for Linux desktop
Message-ID: <20200108212537.zs6pesil2vjguvu6@pali>
References: <20200107192311.efit6zftt27encdc@pali>
 <721332d3-336a-b9d2-f8cd-72da785fb9dc@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="gjl63b3enwqptwwu"
Content-Disposition: inline
In-Reply-To: <721332d3-336a-b9d2-f8cd-72da785fb9dc@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--gjl63b3enwqptwwu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

On Wednesday 08 January 2020 14:34:32 Denis Kenzior wrote:
> Hi Pali,
>=20
> > Do you have a reasonable solution also for second issue?
> >=20
>=20
> HSP profile has always been a problem child.  It isn't really all that
> useful as a profile, and given how minimal it is, the right place for it
> always seemed to be inside Pulse Audio itself.  This is what Marcel & I
> agreed upon back about 8-9 years ago anyway.
>=20
> You are advocating that HSP is still useful, particularly with vendor
> extensions.  Which is fair enough, but now you have to figure out how and
> where to put this support.
>=20
> As mentioned earlier, one idea you can explore is to create a small daemon
> (or maybe it can even be part of ofonod itself) that will handle HSP
> client/server roles.  See for example the dundee daemon that is part of
> ofono.git.  dundee handles Bluetooth DUN profile and might be a good mode=
l /
> starting point for what you're trying to accomplish.

I looked at dundee, but it does it is separated service, not on org.ofono
So it looks like it does not fit into HSP / HFP needs.

Currently you can list all audio cards by DBus call:

"org.ofono", "/", "org.ofono.HandsfreeAudioManager", "GetCards"

and so this (or some new) call should list all HSP and HFP devices/cards
for audio application (pulseaudio).

Audio application (e.g. pulseaudio) really do not want to handle two
separate services to monitor and process HSP/HFP devices.

For audio application are HSP and HFP devices equivalent, they provide
same features: SCO socket, API for controlling microphone and speaker
gain; plus optionally specify used codec.

So having two separate services which fully divided for audio
application purpose does not make sense.

So it is possible that both HSP and HFP audio cards would be available
via one audio API? Because I do not see how it could be done via design
like dundee.

> You can then implement the same API interfaces for setting up the HSP aud=
io
> stream as oFono does today (i.e. https://git.kernel.org/pub/scm/network/o=
fono/ofono.git/tree/doc/handsfree-audio-api.txt),

This API is unusable for both HSP and HFP audio streams. In pulseaudio
it is somehow used, but it is not suitable.

In part of designing hsphfpd I created a new DBus API for audio
application to fit for audio daemons. See org.hsphfpd.AudioAgent:
https://github.com/pali/hsphfpd-prototype/blob/prototype/hsphfpd.txt#L600-L=
663

Main objection for handsfree-audio-api.txt is that it does not provide
information about locally used codec and somehow mixes air codec and
local codec. In my hsphfpd.txt I used term "AgentCodec" for bluetooth
local codec and term "AirCodec" for bluetooth air codec format.

Another objection against handsfree-audio-api.txt API is that it is
bound to HF codecs (via number) and does not support for pass e.g. CSR
codecs.

What is completely missing in that API is controlling volume level.

And also API does not provide socket MTU information or ability to
change/specify which codec would be used.

So something like org.hsphfpd.AudioAgent API in my hsphfpd design would
be needed.

> which would make PulseAudio's job much easier, since the audio stream
> aspects would be essentially identical to HFP.  If you're part of oFono's
> tree, then in theory many implementation aspects could be reused.
>=20
> If you want to provide some higher-level APIs for external applications,
> then HSP specific interfaces (APIs) can be added as needed.

Non-audio APIs which are needed to export (for both HSP and HFP profiles):

* battery level (0% - 100%)
* power source (external, battery, unknown)
* ability to send "our laptop" battery level and power source to remote dev=
ice
* send text message to embedded display
* process button press event (exported via linux kernel uinput)

(plus all telephony related operations, but those are already supported
and provided by ofono)

> If you decide this is something you want to pursue, then I'm happy to host
> this in the oFono tree.
>=20
> Regards,
> -Denis

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--gjl63b3enwqptwwu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXhZIzwAKCRCL8Mk9A+RD
UltyAKCxBf9uLNyOoXizkvpJxCovTo8fmwCcCmWvv2YZnGpuuwxc++eR2NCVurQ=
=kE8J
-----END PGP SIGNATURE-----

--gjl63b3enwqptwwu--
