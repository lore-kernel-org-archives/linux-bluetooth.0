Return-Path: <SRS0=9HFX=YG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AEEEC4360C
	for <linux-bluetooth@archiver.kernel.org>; Sun, 13 Oct 2019 09:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E02B2206A3
	for <linux-bluetooth@archiver.kernel.org>; Sun, 13 Oct 2019 09:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBGyXqz5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbfJMJjz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 13 Oct 2019 05:39:55 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33126 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728469AbfJMJjz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 13 Oct 2019 05:39:55 -0400
Received: by mail-wm1-f67.google.com with SMTP id r17so12342839wme.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Oct 2019 02:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nnzg1+MXM2JlNszaxrzHJa42LDedc+JZ1s8OtalEdfs=;
        b=VBGyXqz5Iplkt8qDMuctTnYb+colYKaI3c0djAETq8c7fxretkgQgtr+GuZ++p230B
         ePbtWbIuPQuIIToWoifKShkyk/FJSdTg+ydjz2c49qrDTYcwIkCrObUWoSds2ZXxUqZw
         9n+t39vnGD8ii/OVEo4g9C0tGLYyxPK3wkaBvTOqcmuj9E6Ue2Kz3lNEPoYfFqEDnZ9Y
         UL5xZS6RCNrtumenchuuAZasKDr/DyCqUrFO2uKUeNhLpqS9etlsLQm0j73/b9Ddb0S4
         24fymmK+xPGCDU5Ud+FRyEetiTWf8Odf2D9GyTdrdSwYjiifp1h8t4gD7sa/iHNHYzvT
         6Z3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nnzg1+MXM2JlNszaxrzHJa42LDedc+JZ1s8OtalEdfs=;
        b=lPt+5D+/ZnfWtN7uJTFpDC5KOiq//5w/lqlgrmnMG1dZU0SNkuWR8lBCQexQxzXOQb
         8PonhC5PdTVVCgTKk8Y02Eby0F81gksVKiwKDSrjXzwc2I/Q/aHYbMGRZLA1KYIpC8Yz
         Nr5yH+6GUTWFDQ3kqUxnEB+DZU4s1fvBGitxGjPHRkfpD14Cv0detTRYw5lvvtCE7IB+
         g1yUEOR2P4IuLtYFoLB2pKR0+jCy/eTad0ZgVjRpEwZ8MRVT6oqAhTSgKPizjQTM8qwb
         q5+vTFsXj5sNQ/vPcy7LuEJRBArXxRZdDg/FNOUpH1rffXiOpdm9FBBUaEBaKiR0Q0EQ
         Mr8w==
X-Gm-Message-State: APjAAAXH6Y3+UFsdHCvMYcL2/ZUL07AFFA7S49L3mIMVqVumZHzeT88E
        rgTGeDi0YRCjiLOkZMhtbaCg47Kb
X-Google-Smtp-Source: APXvYqw1wNRSfAvLzFYFvMvTnt8JRzDCJ9cKUjwJaxqkg2noz3GbErGuZOGenmKGYtrj5hf9mrawAw==
X-Received: by 2002:a1c:4986:: with SMTP id w128mr10200987wma.69.1570959590752;
        Sun, 13 Oct 2019 02:39:50 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id g185sm18538691wme.10.2019.10.13.02.39.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 13 Oct 2019 02:39:48 -0700 (PDT)
Date:   Sun, 13 Oct 2019 11:39:47 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "Gix, Brian" <brian.gix@intel.com>,
        "iam@valdikss.org.ru" <iam@valdikss.org.ru>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Determinate EDR speed
Message-ID: <20191013093947.cbqczgnt3uo3f5wi@pali>
References: <20191011082723.t6w2jcg7v4erlnq6@pali>
 <319f751481bbdb5aa012e5fa4daa1d95965b54c3.camel@intel.com>
 <20191011183502.ao45xlyfabpbadxo@pali>
 <fea0a8efd80c4c444f56d4f3902aeae4f4f9de32.camel@intel.com>
 <64060b6a2bc9aee7b7eef0347ee3bafe3fddd18b.camel@intel.com>
 <20191011200420.hbrutdclfva2uqpv@pali>
 <CABBYNZL8u2kUnPqiA56DtZyAPZEAUQBaBOC-wuqUQmOW6ZJ=Og@mail.gmail.com>
 <20191013073603.6jnczqr4fk7lpyxq@pali>
 <CABBYNZJx6ZKfBftJoZ2b0pdUXyuY23kA1OUAsZTA4KHVLwoF3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="aoooyrovdgck7u5g"
Content-Disposition: inline
In-Reply-To: <CABBYNZJx6ZKfBftJoZ2b0pdUXyuY23kA1OUAsZTA4KHVLwoF3w@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--aoooyrovdgck7u5g
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sunday 13 October 2019 11:45:58 Luiz Augusto von Dentz wrote:
> Hi Pali,
>=20
> On Sun, Oct 13, 2019 at 10:36 AM Pali Roh=C3=A1r <pali.rohar@gmail.com> w=
rote:
> >
> > On Saturday 12 October 2019 10:23:58 Luiz Augusto von Dentz wrote:
> > > Hi Pali,
> > >
> > > On Fri, Oct 11, 2019 at 11:07 PM Pali Roh=C3=A1r <pali.rohar@gmail.co=
m> wrote:
> > > >
> > > > On Friday 11 October 2019 19:05:56 Gix, Brian wrote:
> > > > > On Fri, 2019-10-11 at 19:00 +0000, Gix, Brian wrote:
> > > > > > Hi Pali,
> > > > > >
> > > > > > On Fri, 2019-10-11 at 20:35 +0200, Pali Roh=C3=A1r wrote:
> > > > > > > Currently bluez API, method Acquire() already inform called a=
pplication
> > > > > > > what is socket MTU for input and output. So from this informa=
tion it is
> > > > > > > possible to detect if device supports EDR 3 or not.
> > > > > > >
> > > > > > > But it is too late to have this information. I need to send S=
BC
> > > > > > > parameters to bluez first when doing A2DP negotiation, this i=
s early
> > > > > > > steps before Acquire() is called.
> > > > > >
> > > > > > This seems to be the kind of information which is fixed, for th=
e life of the pairing.
> > > > > >
> > > > > > What if you assumed the lower speed the first time you connecte=
d, determined the
> > > > > > speed during the first streaming, and then either immediately r=
enegotiate (caching the identifying
> > > > > > information
> > > > > > of the SNK), or just cache the information for future connectio=
ns.
> > > > > >
> > > > > > Or the reverse, and assume fast, but immediately adjust down if=
 you aren't getting what you hoped for.
> > > > > >
> > > > > > In any case, this would be a "Device Setup" glitch which you co=
uld note as a routine part of pairing in the
> > > > > > documentation.
> > > > >
> > > > > Or, Stream "Silence" the first time you connect, in order to dete=
rmine throughput.  It would add 1-2 seconds to
> > > > > your connection time perhaps, but would be less noticable to the =
user.
> > > >
> > > > This increase connection time, increase complexity of implementation
> > > > (lot of things can fail) and just complicate lot of things there. P=
lus
> > > > adds that glitch which is not user friendly.
> > > >
> > > > Also bluetooth devices, like headsets, probably do not expects that
> > > > somebody is going to do such thing and we can hit other implementat=
ion
> > > > problems...
> > > >
> > > > And moreover it is just big hack and workaround for that problem. N=
ot a
> > > > reasonable solution.
> > > >
> > > > In btmon I can see it, so kernel already knows that information. Wh=
y it
> > > > cannot tell it to userspace and bluetooth daemon to client applicat=
ion?
> > > >
> > > > Client application (e.g. pulseaudio) should really know if is going=
 to
> > > > talk with bluetooth device with EDR 2 or EDR 3.
> > > >
> > > > > >
> > > > > > > Therefore I'm asking for some way how to get information if d=
evice
> > > > > > > supports EDR 2 or EDR 3. This is basically requirement for pr=
oper
> > > > > > > implementation of SBC in high quality mode. So if there are n=
ot such API
> > > > > > > yet, could it be exported from kernel to userspace and blueto=
othd
> > > > > > > daemon?
> > > > > > >
> > > > > > > See these two articles for more details about SBC and its hig=
h quality:
> > > > > > >
> > > > > > > https://habr.com/en/post/456182/
> > > > > > > http://soundexpert.org/articles/-/blogs/audio-quality-of-sbc-=
xq-bluetooth-audio-codec
> > > > > > >
> > > > > > > > > Is there any bluez API for it?
> > > > > > > > >
> > >
> > > There quite a few assumption here that are not really how it is
> > > implemented in BlueZ:
> > >
> > > 1. The L2CAP MTU is not based on the ACL link (should be relatively
> > > easy to change)
> > > 2. L2CAP MTU is not required to be symmetric.
> > > 3. Since the ACL link is shared for all channels we shouldn't really
> > > assume all throughput will be available
> > > 4. PA flow control is not just filling up packets and sending them
> > > when they are full to maximize speed, instead it send packets when
> > > necessary to maintain a constant speed so the MTU may not be fully
> > > used, in fact trying to maximize the MTU may result in higher latency
> > > since packets would be sent less frequently.
> > >
> > > With this in mind I think the only thing we should look into is to
> > > adjust the default L2CAP MTU to match the underline ACL Link, so it
> > > maximizes throughput, the remote side may choose a different MTU which
> > > will have to follow though.
> >
> > Hi Luiz! The main problem is not MTU size, as I wrote I cannot use it
> > normally for distinguish for usage of SBC XQ or not. Instead of MTU I
> > rather need to know if device supports EDR 2 or EDR 3.
>=20
> I was trying to implement this on the kernel to match the MTU size of
> L2CAP with ACL but the packet type current in use by the connection is
> not exposed in the connection complete, or at least I couldn't any
> reference to it, we could possibly expose the packet types via socket
> option as well but changing it at runtime is probably not a good idea.

Hello, when I run btmon, I see following information very early before
creating A2DP connection:

HCI Event: Read Remote Supported Features (0x0b) plen 11
        Status: Success (0x00)
        Handle: 35
        Features: 0xff 0xff 0x8f 0xfe 0x9b 0xff 0x59 0x87
          ...
          Enhanced Data Rate ACL 2 Mbps mode
          Enhanced Data Rate ACL 3 Mbps mode

I do not need to change MTU size, I would just like to know EDR features
capabilities. Cannot be those information exported somehow from kernel?
I guess that kernel should have these information if it can send it to
btmon.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--aoooyrovdgck7u5g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXaLw3wAKCRCL8Mk9A+RD
UuimAKCo8Py0OLJChJXAw/cNvuouQOzWHQCfcQmTkl10xJUZkrl3xfBQ5pZLEWM=
=6tvz
-----END PGP SIGNATURE-----

--aoooyrovdgck7u5g--
