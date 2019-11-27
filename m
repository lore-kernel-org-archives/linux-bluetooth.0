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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E25BC432C3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Nov 2019 17:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53F9920665
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Nov 2019 17:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZbhjmLj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfK0Rgq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Nov 2019 12:36:46 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38983 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfK0Rgp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Nov 2019 12:36:45 -0500
Received: by mail-wm1-f68.google.com with SMTP id s14so1723224wmh.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Nov 2019 09:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jsgqLlI0hHlZlQ0Yvz9pX40ytT5TjtxUCjmNOmOD8ZQ=;
        b=CZbhjmLjWXrVr7cb4HWHS7p7W5auMEhQ+GYgR2gSNkn5oT3ncce0qDkKwLNdf0BHAb
         dmSrDRWGYXyjeOZscFJXATrnyCWPbusWxrYPX8V68+xSURfnCb2ECEBzkHJop1br7VLa
         M4nrOk5YIOC0sooNQ9Pn1bkyC/NVPyQcDbytO5GlJ71daBB/twjTnYCVf+Tx4S5HR6JG
         zd0pub9496n794GlI1zaSA27z61VUAQQUl/nT4COLangN4YSDtQ037ezHIbZynzbKdSv
         Nat6grg+zxtW2rJ7yNAQH57rQCxNPMYmR9VrKLrud7CpBRRNrPwpFAfXbtBJixzuWAf7
         7Nhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jsgqLlI0hHlZlQ0Yvz9pX40ytT5TjtxUCjmNOmOD8ZQ=;
        b=RhtiPNDDm9R5aholJmebrRInYYkhhuc7IK5Aa/hUCflr/8g/eRTAJ+orxVco2v0Jc1
         8b5ZpUy0ZlLnoX5o4KT/Ljz1lrK7CSOFMeFInLZb26UgAC7u9FhbRt1Szs61HVlyjkoX
         DLIQv9cdp+7mXBMYj6Qh4DJRNA2dNKpG0KxTZI1OvQMCgYjfEg3V10gVWl4wfJWscfpW
         QCa8h8jQsspvuMmRjw64O9sbxckgReRhz9/4cgIYNbKmUnEETx0dzLrnOP39TDYrY30k
         2MQ206Y8mhBSLkOBKQ0DLJ4uhyCr5wA9bOMon9Eg6MCj0PRToS+ywf2HKB4j2d9/hEbw
         NiPQ==
X-Gm-Message-State: APjAAAUQvulfk+cy+LHBElbBJIRSin1/FvP7C0WJ43E2zPKeFWSqPrB0
        nPmud6IjZKJ7+XdZvgKgPvo=
X-Google-Smtp-Source: APXvYqz2BSi76lyh53zSm0Cbcx0AUVNMidNRvtl7YhNDLhZCx3x3lAyScFw9AkgZAz1h0+A3ML8E5A==
X-Received: by 2002:a7b:cb86:: with SMTP id m6mr5871767wmi.124.1574876202772;
        Wed, 27 Nov 2019 09:36:42 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id k1sm20518103wrp.29.2019.11.27.09.36.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Nov 2019 09:36:41 -0800 (PST)
Date:   Wed, 27 Nov 2019 18:36:41 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] avctp: Set more descriptive name for uinput device
Message-ID: <20191127173641.2zsi7ccsnf3seoev@pali>
References: <20191126212753.18455-1-pali.rohar@gmail.com>
 <CABBYNZ+X1xThm9rrcj7ny9f9r0sVs-fTR2JroQdRgZTRWLcN6g@mail.gmail.com>
 <20191127160720.aleatv6l4swopg57@pali>
 <CANFp7mW47eJ6dquzLYX-uKoAO=Qc=ObgmSWQ5U0Xs7ThEV0Urg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="mz3nyjpvo2oldgpb"
Content-Disposition: inline
In-Reply-To: <CANFp7mW47eJ6dquzLYX-uKoAO=Qc=ObgmSWQ5U0Xs7ThEV0Urg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--mz3nyjpvo2oldgpb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wednesday 27 November 2019 09:21:24 Abhishek Pandit-Subedi wrote:
> On Wed, Nov 27, 2019 at 8:07 AM Pali Roh=C3=A1r <pali.rohar@gmail.com> wr=
ote:
> >
> > Hi!
> >
> > On Wednesday 27 November 2019 17:50:40 Luiz Augusto von Dentz wrote:
> > > Hi Pali,
> > >
> > > On Tue, Nov 26, 2019 at 11:31 PM Pali Roh=C3=A1r <pali.rohar@gmail.co=
m> wrote:
> > > >
> > > > ---
> > > >  profiles/audio/avctp.c | 3 +--
> > > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > >
> > > > diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
> > > > index 70a3e40b2..ae53587ad 100644
> > > > --- a/profiles/audio/avctp.c
> > > > +++ b/profiles/audio/avctp.c
> > > > @@ -1181,8 +1181,7 @@ static int uinput_create(char *name)
> > > >         }
> > > >
> > > >         memset(&dev, 0, sizeof(dev));
> > > > -       if (name)
> > > > -               strncpy(dev.name, name, UINPUT_MAX_NAME_SIZE - 1);
> > > > +       snprintf(dev.name, sizeof(dev.name), "Bluetooth Audio/Video=
 Remote Control%s%s", name ? " " : "", name ? name : "");
> > > >
> > > >         dev.id.bustype =3D BUS_BLUETOOTH;
> > > >         dev.id.vendor  =3D 0x0000;
> > > > --
> > > > 2.11.0
> > >
> > > It is already setting a bustype to BUS_BLUETOOTH why do you need to
> > > make it more specific,
> >
> > Because more tools shows only device name. Also in kernel dmesg is only
> > device name. And MAC address is really something which does not say
> > anything about device...
> >
> > For this reason also older input devices (implemented in kernel) exports
> > more descriptive names, e.g. "AT Translated Set 2 keyboard" or "ETPS/2
> > Elantech TrackPoint" or "Integrated IR Camera".
> >
> > > btw it needs to be limited to UINPUT_MAX_NAME_SIZE.
> >
> > Is not this implicitly defined by sizeof()?
> >
> > > Id say if we want to make it declare the connection type
> >
> > Yes, connection type would be really useful.
> >
> > Now I'm playing with exporting "button press even" from HSP profile via
> > uinput device too and therefore connection type should be there.
> >
> > > that probably something that needs to be encoded in
> > > the bus itself, like BUS_BLUETOOTH_AVCTP, BUS_BLUETOOTH_HOG, etc.
> >
> > But bus type is kernel API and there is no such AVCTP or HOG. So we need
> > to stick with BUS_BLUETOOH.
> >
> > Other kernel devices also put protocol information into name (e.g.
> > touchpad / trackpoints), so it is ideal place also for bluetooth
> > devices.
> >
> > And probably most userspace devices are mapped to BUS_VIRTUAL. There
> > are no subtypes.
> >
> > --
> > Pali Roh=C3=A1r
> > pali.rohar@gmail.com
>=20
> Wouldn't it be better to use the device name for uinput rather than the a=
ddress?

Hi!

Can we access device name in bluez? If yes that would be improvement too!

But because more profiles can export input device we still should
include profile name (or abbrev) into device name.

> In `init_uinput` (avctp.c), uinput_create is called with
> device_get_address instead of device_get_name. It would probably be
> better to use the device name for the uinput and set the device
> address as the `uniq` attribute (as it is done for /dev/uhid for HID
> devices).

And how to set uniq attribute? I'm looking at uinput API, but do not see
any way how to set such thing.

According to uinput kernel documentation there are two ways how to setup
uinput device. New one via UI_DEV_SETUP ioctl and the old one by writing
structure via write() syscall.

https://www.kernel.org/doc/html/latest/input/uinput.html

New way which has to call UI_DEV_SETUP ioctl has following struct
uinput_setup members:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/inc=
lude/uapi/linux/uinput.h#n67
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/inc=
lude/uapi/linux/input.h#n58

  u16 bustype;
  u16 vendor;
  u16 product;
  u16 version;
  char name[UINPUT_MAX_NAME_SIZE];
  u32 ff_effects_max;

Old way how to setup uinput is to call write() systecall with struct
uinput_user_dev members, which are:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/inc=
lude/uapi/linux/uinput.h#n223

  char name[UINPUT_MAX_NAME_SIZE];
  u16 bustype;
  u16 vendor;
  u16 product;
  u16 version;
  u32 ff_effects_max;
  s32 absmax[ABS_CNT];
  s32 absmin[ABS_CNT];
  s32 absfuzz[ABS_CNT];
  s32 absflat[ABS_CNT];

And I do not see any field which could represents that "uniq" attribute.
Seems that it can be exported only by kernel input drivers, not uinput
userspace drivers...

> So in the following, replace ATTR{name} with something like "Some
> Company Headphones", ATTR{uniq} =3D "33:33:33:ff:ff:ff" and ATTR{phys}
> with the controller's address.
>=20
> $ udevadm info -a -p /sys/devices/virtual/input/input21/
> ...
>   looking at device '/devices/virtual/input/input21':
>     KERNEL=3D=3D"input21"
>     SUBSYSTEM=3D=3D"input"
>     DRIVER=3D=3D""
>     ATTR{inhibited}=3D=3D"0"
>     ATTR{name}=3D=3D"33:33:33:FF:FF:FF"
>     ATTR{phys}=3D=3D""
>     ATTR{properties}=3D=3D"0"
>     ATTR{uniq}=3D=3D""
>=20
> This is what uhid looks like in comparison:
>=20
> $ udevadm info -a -p /sys/class/misc/uhid/0005\:046D\:B33B.0002/input/inp=
ut18/
>=20
>   looking at device
> '/devices/virtual/misc/uhid/0005:046D:B33B.0002/input/input18':
>     KERNEL=3D=3D"input17"
>     SUBSYSTEM=3D=3D"input"
>     DRIVER=3D=3D""
>     ATTR{inhibited}=3D=3D"0"
>     ATTR{name}=3D=3D"Keyboard K780 Keyboard"
>     ATTR{phys}=3D=3D"ab:cd:ef:12:34:56"
>     ATTR{properties}=3D=3D"0"
>     ATTR{uniq}=3D=3D"33:33:33:33:ff:ff"
>=20
>=20
> Abhishek

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--mz3nyjpvo2oldgpb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXd60JwAKCRCL8Mk9A+RD
Ui4NAJ9pc/Y0V92BC9RZFroimf+fNU9ULQCcCEM1NumNEn7ObhejOSAPlnPpfBY=
=v7B8
-----END PGP SIGNATURE-----

--mz3nyjpvo2oldgpb--
