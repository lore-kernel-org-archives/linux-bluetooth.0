Return-Path: <SRS0=8ZYm=YJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 853D0FA372A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Oct 2019 19:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 538EE20854
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Oct 2019 19:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uwc4jY2c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390908AbfJPTNs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Oct 2019 15:13:48 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40205 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731321AbfJPTNs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Oct 2019 15:13:48 -0400
Received: by mail-wm1-f66.google.com with SMTP id b24so3949003wmj.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Oct 2019 12:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VwkACeI83Oz0cwtY9JcF7fy7xApXlsvT5t1ZIq+Bhw8=;
        b=uwc4jY2cEgUWDbb4UqYPdPu3EpfZ/i89ZG2Ut0pICiJa9vDljpMYHbAsIBWm7ZuVsq
         D4Ny/c4N79kAMojMijVprw9+TgOF/Uv7dxD9ZhFeArV+qms4AppxvEFRI8MMytLM834A
         hhTTYBc9K/bD1aPH+GjVdiyYa3CGDF3E+fHOGL6mZPknuNMJch8EECAvtUsKw2I+CAeI
         pA1/ZQ2z5wyCIw5IcBvaThq5fJsNPk6ev0s/JoZx3ASTjwmlsVtNT8+APwXigPClXHt6
         HfmTWqJ3HyQ7GnMWzwKe9ShzfzBW7HD5k0UPwRZxITp3DHIcJOcy7PYlCp32+67JpNRf
         6uzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VwkACeI83Oz0cwtY9JcF7fy7xApXlsvT5t1ZIq+Bhw8=;
        b=Bn4Oxf3JHe87GIkUJ31YLxp/hDDKjf/Zj6Jm4fe6wxUH9QntyMbtxA6EiVmeis8x/K
         eEiVP3uB4zoWycdFyn97oxY7IKwXGhNuY3yXmbwASx6xyAt4eO0V5Evl6hLkWgDX8jGL
         YtgcyDmtUenCMxRTCcoS3NKZb8OgNmuCVCWN7XWk7OKd6tw1ydqzLJbdwlEamWcJLUu+
         MkFvmzYZI3SAgVyk5+nBjZVjzNeaQS7pjYUDV71TZQa95frYdlOIVYvYbIbBTUCXTFBK
         l2oGtl2JldQVLfw39H44iP5pXnpLFUG/SSPNvhoj+jlhtLCLYwM7LqnnFVNWu/7HjW5A
         3yLA==
X-Gm-Message-State: APjAAAVJMp7Zn40I0E66pAwlsI9KrcHGeavwnca+jwGe4UD2qHgPk/DX
        1zCIeN5+hk/M4rmj0A+i2jY=
X-Google-Smtp-Source: APXvYqxnwU+o1ieiimdBfStApZ11h+OHK1e1C1DGiJJCKQTBsCqFfS2uB3H0yFPyGeAzrRdRKAb0Kg==
X-Received: by 2002:a1c:990a:: with SMTP id b10mr4673997wme.39.1571253225871;
        Wed, 16 Oct 2019 12:13:45 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id r140sm3857175wme.47.2019.10.16.12.13.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Oct 2019 12:13:44 -0700 (PDT)
Date:   Wed, 16 Oct 2019 21:13:43 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Brian Gix <brian.gix@intel.com>,
        "iam@valdikss.org.ru" <iam@valdikss.org.ru>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Determinate EDR speed
Message-ID: <20191016191343.clby7pmkdq3q2i7s@pali>
References: <319f751481bbdb5aa012e5fa4daa1d95965b54c3.camel@intel.com>
 <20191011183502.ao45xlyfabpbadxo@pali>
 <fea0a8efd80c4c444f56d4f3902aeae4f4f9de32.camel@intel.com>
 <64060b6a2bc9aee7b7eef0347ee3bafe3fddd18b.camel@intel.com>
 <20191011200420.hbrutdclfva2uqpv@pali>
 <CABBYNZL8u2kUnPqiA56DtZyAPZEAUQBaBOC-wuqUQmOW6ZJ=Og@mail.gmail.com>
 <20191013073603.6jnczqr4fk7lpyxq@pali>
 <CABBYNZJx6ZKfBftJoZ2b0pdUXyuY23kA1OUAsZTA4KHVLwoF3w@mail.gmail.com>
 <20191013093947.cbqczgnt3uo3f5wi@pali>
 <FE2F255A-6762-485B-9166-8348CFB18168@holtmann.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="cwaqzk2yyjodwvxh"
Content-Disposition: inline
In-Reply-To: <FE2F255A-6762-485B-9166-8348CFB18168@holtmann.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--cwaqzk2yyjodwvxh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wednesday 16 October 2019 21:06:41 Marcel Holtmann wrote:
> Hi Pali,
>=20
> >>>>>>>> Currently bluez API, method Acquire() already inform called appl=
ication
> >>>>>>>> what is socket MTU for input and output. So from this informatio=
n it is
> >>>>>>>> possible to detect if device supports EDR 3 or not.
> >>>>>>>>=20
> >>>>>>>> But it is too late to have this information. I need to send SBC
> >>>>>>>> parameters to bluez first when doing A2DP negotiation, this is e=
arly
> >>>>>>>> steps before Acquire() is called.
> >>>>>>>=20
> >>>>>>> This seems to be the kind of information which is fixed, for the =
life of the pairing.
> >>>>>>>=20
> >>>>>>> What if you assumed the lower speed the first time you connected,=
 determined the
> >>>>>>> speed during the first streaming, and then either immediately ren=
egotiate (caching the identifying
> >>>>>>> information
> >>>>>>> of the SNK), or just cache the information for future connections.
> >>>>>>>=20
> >>>>>>> Or the reverse, and assume fast, but immediately adjust down if y=
ou aren't getting what you hoped for.
> >>>>>>>=20
> >>>>>>> In any case, this would be a "Device Setup" glitch which you coul=
d note as a routine part of pairing in the
> >>>>>>> documentation.
> >>>>>>=20
> >>>>>> Or, Stream "Silence" the first time you connect, in order to deter=
mine throughput.  It would add 1-2 seconds to
> >>>>>> your connection time perhaps, but would be less noticable to the u=
ser.
> >>>>>=20
> >>>>> This increase connection time, increase complexity of implementation
> >>>>> (lot of things can fail) and just complicate lot of things there. P=
lus
> >>>>> adds that glitch which is not user friendly.
> >>>>>=20
> >>>>> Also bluetooth devices, like headsets, probably do not expects that
> >>>>> somebody is going to do such thing and we can hit other implementat=
ion
> >>>>> problems...
> >>>>>=20
> >>>>> And moreover it is just big hack and workaround for that problem. N=
ot a
> >>>>> reasonable solution.
> >>>>>=20
> >>>>> In btmon I can see it, so kernel already knows that information. Wh=
y it
> >>>>> cannot tell it to userspace and bluetooth daemon to client applicat=
ion?
> >>>>>=20
> >>>>> Client application (e.g. pulseaudio) should really know if is going=
 to
> >>>>> talk with bluetooth device with EDR 2 or EDR 3.
> >>>>>=20
> >>>>>>>=20
> >>>>>>>> Therefore I'm asking for some way how to get information if devi=
ce
> >>>>>>>> supports EDR 2 or EDR 3. This is basically requirement for proper
> >>>>>>>> implementation of SBC in high quality mode. So if there are not =
such API
> >>>>>>>> yet, could it be exported from kernel to userspace and bluetoothd
> >>>>>>>> daemon?
> >>>>>>>>=20
> >>>>>>>> See these two articles for more details about SBC and its high q=
uality:
> >>>>>>>>=20
> >>>>>>>> https://habr.com/en/post/456182/
> >>>>>>>> http://soundexpert.org/articles/-/blogs/audio-quality-of-sbc-xq-=
bluetooth-audio-codec
> >>>>>>>>=20
> >>>>>>>>>> Is there any bluez API for it?
> >>>>>>>>>>=20
> >>>>=20
> >>>> There quite a few assumption here that are not really how it is
> >>>> implemented in BlueZ:
> >>>>=20
> >>>> 1. The L2CAP MTU is not based on the ACL link (should be relatively
> >>>> easy to change)
> >>>> 2. L2CAP MTU is not required to be symmetric.
> >>>> 3. Since the ACL link is shared for all channels we shouldn't really
> >>>> assume all throughput will be available
> >>>> 4. PA flow control is not just filling up packets and sending them
> >>>> when they are full to maximize speed, instead it send packets when
> >>>> necessary to maintain a constant speed so the MTU may not be fully
> >>>> used, in fact trying to maximize the MTU may result in higher latency
> >>>> since packets would be sent less frequently.
> >>>>=20
> >>>> With this in mind I think the only thing we should look into is to
> >>>> adjust the default L2CAP MTU to match the underline ACL Link, so it
> >>>> maximizes throughput, the remote side may choose a different MTU whi=
ch
> >>>> will have to follow though.
> >>>=20
> >>> Hi Luiz! The main problem is not MTU size, as I wrote I cannot use it
> >>> normally for distinguish for usage of SBC XQ or not. Instead of MTU I
> >>> rather need to know if device supports EDR 2 or EDR 3.
> >>=20
> >> I was trying to implement this on the kernel to match the MTU size of
> >> L2CAP with ACL but the packet type current in use by the connection is
> >> not exposed in the connection complete, or at least I couldn't any
> >> reference to it, we could possibly expose the packet types via socket
> >> option as well but changing it at runtime is probably not a good idea.
> >=20
> > Hello, when I run btmon, I see following information very early before
> > creating A2DP connection:
> >=20
> > HCI Event: Read Remote Supported Features (0x0b) plen 11
> >        Status: Success (0x00)
> >        Handle: 35
> >        Features: 0xff 0xff 0x8f 0xfe 0x9b 0xff 0x59 0x87
> >          ...
> >          Enhanced Data Rate ACL 2 Mbps mode
> >          Enhanced Data Rate ACL 3 Mbps mode
> >=20
> > I do not need to change MTU size, I would just like to know EDR features
> > capabilities. Cannot be those information exported somehow from kernel?
> > I guess that kernel should have these information if it can send it to
> > btmon.
>=20
> so I have not seen a single device that only supports one of these two mo=
des. They all support both and if possible you want to use 3 Mpbs anyway si=
nce that safes power.

Hi! But there are devices which support none of the two modes?

Anyway, could be these "features" exported as dbus property from bluez?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--cwaqzk2yyjodwvxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXadr5QAKCRCL8Mk9A+RD
UioQAJ9u9sBltnhZu1mSkoV2jRwcPDaWRgCfbbk0YJjPLvD7X3JlpAf0hsOT10g=
=V8fg
-----END PGP SIGNATURE-----

--cwaqzk2yyjodwvxh--
