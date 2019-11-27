Return-Path: <SRS0=/G8r=ZT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B354C432C0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Nov 2019 17:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AD9520835
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Nov 2019 17:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHMNMiNk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbfK0R6N (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Nov 2019 12:58:13 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33461 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfK0R6N (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Nov 2019 12:58:13 -0500
Received: by mail-wr1-f65.google.com with SMTP id w9so27815236wrr.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Nov 2019 09:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZlzQRvzdhXQ30RnoxEBqEccJhJi9zE3DBQ/FgCGffrA=;
        b=gHMNMiNknxQMfEZLtqESND4nb0DJ9NAn1yBINq70yxbgLGtRkSk/cxRofRR3eqcAHM
         st4NoAAUZ2OMq7pCcpHKCOfyUb98IwWPZmo7j9oOYeU5gRYETufmg/i74x/J2Okp147I
         hC2iPwgtGKpdEnO9F3xrhR+bUbn0JstSaRRUeeWrTeExGmCG2bnWbf3vgdX+SUvIBI4o
         LwT3gpvVF2BBkLT13vI0KR6BOH+xkxH8wGaFVyPNq/FUTAzdtJqyf5BeIqS+VyN58Y3s
         BUV5R5KGQBYbNt9i4rywmMr+IwHuQlw6YjHCgKu/64gHvNdNmKuJji0ViuU8NKvMnMI0
         AWkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZlzQRvzdhXQ30RnoxEBqEccJhJi9zE3DBQ/FgCGffrA=;
        b=a9EPe+jbtXLeQMVt16vK29Fd6sJrKYgYrQTy5kzb015RC2r9dSFrZLxvft5rStdUzV
         9Ul5ohqTwJhY/hz3PNyT4KmzTlEpeexr8oFF71jjalWneWzzVB1qhtsvEELBE41R5KOy
         bDLm8DoqVWV5V3R20WaKP9hRi7WFfycDjzTPgpBccZcjk2tE7LA72x1Xj8CJg1PM5HHu
         o8Xo86YfPsIlk4v8spkocaltHfxdt3hojvXFP1v/cvVvWXFvyZpHg+b/Pxd7dkviqKWS
         QhaRjSnkAnLRPBTDGRI2SdLpaQFdEU9orMr6jXqs+ITj+yOtwcnviCVdBWv3OlKC6GXl
         iQQA==
X-Gm-Message-State: APjAAAWxo0/dN5/1+jrLmBR/xpG4WJbND1JN3rkasWCyTLSdpTm7u+7q
        9dxjdoVXHgaw051Z+tt9nX0=
X-Google-Smtp-Source: APXvYqx7eL/estF+kGsG5oZHQKArbewgD0n5vBtV0JTpE2xJNBfxb8m14U7TFWGx6gy6KQmRF4a2uw==
X-Received: by 2002:a5d:55c5:: with SMTP id i5mr46622717wrw.385.1574877490504;
        Wed, 27 Nov 2019 09:58:10 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id b2sm20253865wrr.76.2019.11.27.09.58.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Nov 2019 09:58:09 -0800 (PST)
Date:   Wed, 27 Nov 2019 18:58:08 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] avctp: Set more descriptive name for uinput device
Message-ID: <20191127175808.o6ajkrlewiwdsaoj@pali>
References: <20191126212753.18455-1-pali.rohar@gmail.com>
 <CABBYNZ+X1xThm9rrcj7ny9f9r0sVs-fTR2JroQdRgZTRWLcN6g@mail.gmail.com>
 <20191127160720.aleatv6l4swopg57@pali>
 <CANFp7mW47eJ6dquzLYX-uKoAO=Qc=ObgmSWQ5U0Xs7ThEV0Urg@mail.gmail.com>
 <20191127173641.2zsi7ccsnf3seoev@pali>
 <CANFp7mXyUKu7Za02XRcicLgrVUYiDfL-X-Bu6MZV1Of+y8LxgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="juvnz6iw3lqy5w2p"
Content-Disposition: inline
In-Reply-To: <CANFp7mXyUKu7Za02XRcicLgrVUYiDfL-X-Bu6MZV1Of+y8LxgA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--juvnz6iw3lqy5w2p
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wednesday 27 November 2019 09:45:32 Abhishek Pandit-Subedi wrote:
> On Wed, Nov 27, 2019 at 9:36 AM Pali Roh=C3=A1r <pali.rohar@gmail.com> wr=
ote:
> >
> > On Wednesday 27 November 2019 09:21:24 Abhishek Pandit-Subedi wrote:
> > > On Wed, Nov 27, 2019 at 8:07 AM Pali Roh=C3=A1r <pali.rohar@gmail.com=
> wrote:
> > > >
> > > > Hi!
> > > >
> > > > On Wednesday 27 November 2019 17:50:40 Luiz Augusto von Dentz wrote:
> > > > > Hi Pali,
> > > > >
> > > > > On Tue, Nov 26, 2019 at 11:31 PM Pali Roh=C3=A1r <pali.rohar@gmai=
l.com> wrote:
> > > > > >
> > > > > > ---
> > > > > >  profiles/audio/avctp.c | 3 +--
> > > > > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
> > > > > > index 70a3e40b2..ae53587ad 100644
> > > > > > --- a/profiles/audio/avctp.c
> > > > > > +++ b/profiles/audio/avctp.c
> > > > > > @@ -1181,8 +1181,7 @@ static int uinput_create(char *name)
> > > > > >         }
> > > > > >
> > > > > >         memset(&dev, 0, sizeof(dev));
> > > > > > -       if (name)
> > > > > > -               strncpy(dev.name, name, UINPUT_MAX_NAME_SIZE - =
1);
> > > > > > +       snprintf(dev.name, sizeof(dev.name), "Bluetooth Audio/V=
ideo Remote Control%s%s", name ? " " : "", name ? name : "");
> > > > > >
> > > > > >         dev.id.bustype =3D BUS_BLUETOOTH;
> > > > > >         dev.id.vendor  =3D 0x0000;
> > > > > > --
> > > > > > 2.11.0
> > > > >
> > > > > It is already setting a bustype to BUS_BLUETOOTH why do you need =
to
> > > > > make it more specific,
> > > >
> > > > Because more tools shows only device name. Also in kernel dmesg is =
only
> > > > device name. And MAC address is really something which does not say
> > > > anything about device...
> > > >
> > > > For this reason also older input devices (implemented in kernel) ex=
ports
> > > > more descriptive names, e.g. "AT Translated Set 2 keyboard" or "ETP=
S/2
> > > > Elantech TrackPoint" or "Integrated IR Camera".
> > > >
> > > > > btw it needs to be limited to UINPUT_MAX_NAME_SIZE.
> > > >
> > > > Is not this implicitly defined by sizeof()?
> > > >
> > > > > Id say if we want to make it declare the connection type
> > > >
> > > > Yes, connection type would be really useful.
> > > >
> > > > Now I'm playing with exporting "button press even" from HSP profile=
 via
> > > > uinput device too and therefore connection type should be there.
> > > >
> > > > > that probably something that needs to be encoded in
> > > > > the bus itself, like BUS_BLUETOOTH_AVCTP, BUS_BLUETOOTH_HOG, etc.
> > > >
> > > > But bus type is kernel API and there is no such AVCTP or HOG. So we=
 need
> > > > to stick with BUS_BLUETOOH.
> > > >
> > > > Other kernel devices also put protocol information into name (e.g.
> > > > touchpad / trackpoints), so it is ideal place also for bluetooth
> > > > devices.
> > > >
> > > > And probably most userspace devices are mapped to BUS_VIRTUAL. There
> > > > are no subtypes.
> > > >
> > > > --
> > > > Pali Roh=C3=A1r
> > > > pali.rohar@gmail.com
> > >
> > > Wouldn't it be better to use the device name for uinput rather than t=
he address?
> >
> > Hi!
> >
> > Can we access device name in bluez? If yes that would be improvement to=
o!
> >
> > But because more profiles can export input device we still should
> > include profile name (or abbrev) into device name.
>=20
> Yup, I would be totally ok with doing something like "Your Device Name
> Here (AVCTP)"

That it fine for me.

> >
> > > In `init_uinput` (avctp.c), uinput_create is called with
> > > device_get_address instead of device_get_name. It would probably be
> > > better to use the device name for the uinput and set the device
> > > address as the `uniq` attribute (as it is done for /dev/uhid for HID
> > > devices).
> >
> > And how to set uniq attribute? I'm looking at uinput API, but do not see
> > any way how to set such thing.
> >
> > According to uinput kernel documentation there are two ways how to setup
> > uinput device. New one via UI_DEV_SETUP ioctl and the old one by writing
> > structure via write() syscall.
> >
> > https://www.kernel.org/doc/html/latest/input/uinput.html
> >
> > New way which has to call UI_DEV_SETUP ioctl has following struct
> > uinput_setup members:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/include/uapi/linux/uinput.h#n67
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/include/uapi/linux/input.h#n58
> >
> >   u16 bustype;
> >   u16 vendor;
> >   u16 product;
> >   u16 version;
> >   char name[UINPUT_MAX_NAME_SIZE];
> >   u32 ff_effects_max;
> >
> > Old way how to setup uinput is to call write() systecall with struct
> > uinput_user_dev members, which are:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/include/uapi/linux/uinput.h#n223
> >
> >   char name[UINPUT_MAX_NAME_SIZE];
> >   u16 bustype;
> >   u16 vendor;
> >   u16 product;
> >   u16 version;
> >   u32 ff_effects_max;
> >   s32 absmax[ABS_CNT];
> >   s32 absmin[ABS_CNT];
> >   s32 absfuzz[ABS_CNT];
> >   s32 absflat[ABS_CNT];
> >
> > And I do not see any field which could represents that "uniq" attribute.
> > Seems that it can be exported only by kernel input drivers, not uinput
> > userspace drivers...
>=20
> You are correct -- setting uniq is currently missing in uinput.h.
> (https://github.com/torvalds/linux/blob/6f0d349d922ba44e4348a17a78ea51b71=
35965b1/include/uapi/linux/uinput.h#L145
> I'm working on a patch to fix that and will send it to
> linux-bluetooth@ mailing list later today.
>=20
> Setting ATTR{phys} is possible via ioctl(fd, UI_SET_PHYS, phys) and I
> sent a patch to do that yesterday:
> https://lore.kernel.org/linux-bluetooth/20191126160013.BlueZ.1.I95600043f=
fb5b2b6c4782497ff735ab5d3e37c13@changeid/T/#u

Ok, I did not know that there are additional ioctls for setup. Maybe
this should be put also into documentation.

So not only it is possible, but we have already patch for it. Nice!

>=20
> >
> > > So in the following, replace ATTR{name} with something like "Some
> > > Company Headphones", ATTR{uniq} =3D "33:33:33:ff:ff:ff" and ATTR{phys}
> > > with the controller's address.
> > >
> > > $ udevadm info -a -p /sys/devices/virtual/input/input21/
> > > ...
> > >   looking at device '/devices/virtual/input/input21':
> > >     KERNEL=3D=3D"input21"
> > >     SUBSYSTEM=3D=3D"input"
> > >     DRIVER=3D=3D""
> > >     ATTR{inhibited}=3D=3D"0"
> > >     ATTR{name}=3D=3D"33:33:33:FF:FF:FF"
> > >     ATTR{phys}=3D=3D""
> > >     ATTR{properties}=3D=3D"0"
> > >     ATTR{uniq}=3D=3D""
> > >
> > > This is what uhid looks like in comparison:
> > >
> > > $ udevadm info -a -p /sys/class/misc/uhid/0005\:046D\:B33B.0002/input=
/input18/
> > >
> > >   looking at device
> > > '/devices/virtual/misc/uhid/0005:046D:B33B.0002/input/input18':
> > >     KERNEL=3D=3D"input17"
> > >     SUBSYSTEM=3D=3D"input"
> > >     DRIVER=3D=3D""
> > >     ATTR{inhibited}=3D=3D"0"
> > >     ATTR{name}=3D=3D"Keyboard K780 Keyboard"
> > >     ATTR{phys}=3D=3D"ab:cd:ef:12:34:56"
> > >     ATTR{properties}=3D=3D"0"
> > >     ATTR{uniq}=3D=3D"33:33:33:33:ff:ff"
> > >
> > >
> > > Abhishek
> >
> > --
> > Pali Roh=C3=A1r
> > pali.rohar@gmail.com

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--juvnz6iw3lqy5w2p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXd65LwAKCRCL8Mk9A+RD
UhuTAJwMrbOXUI32WSAAAAKwC9FP8zebhgCgxkgWhlh5/GO81E40MO8Ul6m4pT4=
=Dzxj
-----END PGP SIGNATURE-----

--juvnz6iw3lqy5w2p--
