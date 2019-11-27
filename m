Return-Path: <SRS0=/G8r=ZT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA43C432C0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Nov 2019 17:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A4620835
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Nov 2019 17:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C8KUaZ7U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbfK0Rpp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Nov 2019 12:45:45 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:32976 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfK0Rpo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Nov 2019 12:45:44 -0500
Received: by mail-qt1-f195.google.com with SMTP id y39so26210374qty.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Nov 2019 09:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WpgFWue+89CWW2i2l5ZLqhJ1DywJ5ZYFWynOSv2yVMo=;
        b=C8KUaZ7UlUMpfQsUTxwaQjn2PZkQSX29r+KEi28A85qswH+lQSvKSnD4xpL9lUr35b
         LyOpV+EYZfRK5FKWXrv2YUak0NF44HBVXqJfMj2hPW7S0xJtDAvWuR5rWPVrJ3v0vhKv
         vn6hyoU5uVNh4eVle8TeTw+RRpPAjtYRy2NvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WpgFWue+89CWW2i2l5ZLqhJ1DywJ5ZYFWynOSv2yVMo=;
        b=gNvJLGpsdLd9lhg82N2BZf/SvT9WF64JzVHaIaG+5a8409VsNaooICv/c2n8CeH5OM
         x9OGgW45IRceBy5aq21P3feTku7VP5Sx3C1KLvUV4ynY39BSYcbYoerV56e5ZgD43k3z
         DhRv9co9cjQSq0TAfC+pzOuJOABn41wDLS62Gd3Hrtz5Mx8+cGUO/+Seph2GJiV/e7pC
         KcRduxAJl/lThDvSYuZ4wjykyDVUwgh/YQ5tmbrtRCcNyIFU3YMobeP0FvZEYkDq7jwh
         nRXaSrzXxoZEBZ9F/7KiF1m1OvZD1y1ic1cpf9Jrup63bSGVdlaZBi3lU9REBA2xbb9N
         oB/A==
X-Gm-Message-State: APjAAAV2XsznyNMxCOn7omQN4IgHajDZYXZ/zk/85rr81UruKOV3Vo86
        rqm+aMTi5WQ91jEBZipaqo2eZ6zVaQLjid9acU4/pA==
X-Google-Smtp-Source: APXvYqyFPAPCJ2+LWail5p+1dKCUM0w938V5DXx6pdcbIOXLjyA83R1UC+bpn7UXlZ8xVJ2FW52VzAM+F9pOll9mYFY=
X-Received: by 2002:ac8:750b:: with SMTP id u11mr2489114qtq.170.1574876743162;
 Wed, 27 Nov 2019 09:45:43 -0800 (PST)
MIME-Version: 1.0
References: <20191126212753.18455-1-pali.rohar@gmail.com> <CABBYNZ+X1xThm9rrcj7ny9f9r0sVs-fTR2JroQdRgZTRWLcN6g@mail.gmail.com>
 <20191127160720.aleatv6l4swopg57@pali> <CANFp7mW47eJ6dquzLYX-uKoAO=Qc=ObgmSWQ5U0Xs7ThEV0Urg@mail.gmail.com>
 <20191127173641.2zsi7ccsnf3seoev@pali>
In-Reply-To: <20191127173641.2zsi7ccsnf3seoev@pali>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Wed, 27 Nov 2019 09:45:32 -0800
Message-ID: <CANFp7mXyUKu7Za02XRcicLgrVUYiDfL-X-Bu6MZV1Of+y8LxgA@mail.gmail.com>
Subject: Re: [PATCH] avctp: Set more descriptive name for uinput device
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, Nov 27, 2019 at 9:36 AM Pali Roh=C3=A1r <pali.rohar@gmail.com> wrot=
e:
>
> On Wednesday 27 November 2019 09:21:24 Abhishek Pandit-Subedi wrote:
> > On Wed, Nov 27, 2019 at 8:07 AM Pali Roh=C3=A1r <pali.rohar@gmail.com> =
wrote:
> > >
> > > Hi!
> > >
> > > On Wednesday 27 November 2019 17:50:40 Luiz Augusto von Dentz wrote:
> > > > Hi Pali,
> > > >
> > > > On Tue, Nov 26, 2019 at 11:31 PM Pali Roh=C3=A1r <pali.rohar@gmail.=
com> wrote:
> > > > >
> > > > > ---
> > > > >  profiles/audio/avctp.c | 3 +--
> > > > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
> > > > > index 70a3e40b2..ae53587ad 100644
> > > > > --- a/profiles/audio/avctp.c
> > > > > +++ b/profiles/audio/avctp.c
> > > > > @@ -1181,8 +1181,7 @@ static int uinput_create(char *name)
> > > > >         }
> > > > >
> > > > >         memset(&dev, 0, sizeof(dev));
> > > > > -       if (name)
> > > > > -               strncpy(dev.name, name, UINPUT_MAX_NAME_SIZE - 1)=
;
> > > > > +       snprintf(dev.name, sizeof(dev.name), "Bluetooth Audio/Vid=
eo Remote Control%s%s", name ? " " : "", name ? name : "");
> > > > >
> > > > >         dev.id.bustype =3D BUS_BLUETOOTH;
> > > > >         dev.id.vendor  =3D 0x0000;
> > > > > --
> > > > > 2.11.0
> > > >
> > > > It is already setting a bustype to BUS_BLUETOOTH why do you need to
> > > > make it more specific,
> > >
> > > Because more tools shows only device name. Also in kernel dmesg is on=
ly
> > > device name. And MAC address is really something which does not say
> > > anything about device...
> > >
> > > For this reason also older input devices (implemented in kernel) expo=
rts
> > > more descriptive names, e.g. "AT Translated Set 2 keyboard" or "ETPS/=
2
> > > Elantech TrackPoint" or "Integrated IR Camera".
> > >
> > > > btw it needs to be limited to UINPUT_MAX_NAME_SIZE.
> > >
> > > Is not this implicitly defined by sizeof()?
> > >
> > > > Id say if we want to make it declare the connection type
> > >
> > > Yes, connection type would be really useful.
> > >
> > > Now I'm playing with exporting "button press even" from HSP profile v=
ia
> > > uinput device too and therefore connection type should be there.
> > >
> > > > that probably something that needs to be encoded in
> > > > the bus itself, like BUS_BLUETOOTH_AVCTP, BUS_BLUETOOTH_HOG, etc.
> > >
> > > But bus type is kernel API and there is no such AVCTP or HOG. So we n=
eed
> > > to stick with BUS_BLUETOOH.
> > >
> > > Other kernel devices also put protocol information into name (e.g.
> > > touchpad / trackpoints), so it is ideal place also for bluetooth
> > > devices.
> > >
> > > And probably most userspace devices are mapped to BUS_VIRTUAL. There
> > > are no subtypes.
> > >
> > > --
> > > Pali Roh=C3=A1r
> > > pali.rohar@gmail.com
> >
> > Wouldn't it be better to use the device name for uinput rather than the=
 address?
>
> Hi!
>
> Can we access device name in bluez? If yes that would be improvement too!
>
> But because more profiles can export input device we still should
> include profile name (or abbrev) into device name.

Yup, I would be totally ok with doing something like "Your Device Name
Here (AVCTP)"

>
> > In `init_uinput` (avctp.c), uinput_create is called with
> > device_get_address instead of device_get_name. It would probably be
> > better to use the device name for the uinput and set the device
> > address as the `uniq` attribute (as it is done for /dev/uhid for HID
> > devices).
>
> And how to set uniq attribute? I'm looking at uinput API, but do not see
> any way how to set such thing.
>
> According to uinput kernel documentation there are two ways how to setup
> uinput device. New one via UI_DEV_SETUP ioctl and the old one by writing
> structure via write() syscall.
>
> https://www.kernel.org/doc/html/latest/input/uinput.html
>
> New way which has to call UI_DEV_SETUP ioctl has following struct
> uinput_setup members:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/i=
nclude/uapi/linux/uinput.h#n67
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/i=
nclude/uapi/linux/input.h#n58
>
>   u16 bustype;
>   u16 vendor;
>   u16 product;
>   u16 version;
>   char name[UINPUT_MAX_NAME_SIZE];
>   u32 ff_effects_max;
>
> Old way how to setup uinput is to call write() systecall with struct
> uinput_user_dev members, which are:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/i=
nclude/uapi/linux/uinput.h#n223
>
>   char name[UINPUT_MAX_NAME_SIZE];
>   u16 bustype;
>   u16 vendor;
>   u16 product;
>   u16 version;
>   u32 ff_effects_max;
>   s32 absmax[ABS_CNT];
>   s32 absmin[ABS_CNT];
>   s32 absfuzz[ABS_CNT];
>   s32 absflat[ABS_CNT];
>
> And I do not see any field which could represents that "uniq" attribute.
> Seems that it can be exported only by kernel input drivers, not uinput
> userspace drivers...

You are correct -- setting uniq is currently missing in uinput.h.
(https://github.com/torvalds/linux/blob/6f0d349d922ba44e4348a17a78ea51b7135=
965b1/include/uapi/linux/uinput.h#L145
I'm working on a patch to fix that and will send it to
linux-bluetooth@ mailing list later today.

Setting ATTR{phys} is possible via ioctl(fd, UI_SET_PHYS, phys) and I
sent a patch to do that yesterday:
https://lore.kernel.org/linux-bluetooth/20191126160013.BlueZ.1.I95600043ffb=
5b2b6c4782497ff735ab5d3e37c13@changeid/T/#u


>
> > So in the following, replace ATTR{name} with something like "Some
> > Company Headphones", ATTR{uniq} =3D "33:33:33:ff:ff:ff" and ATTR{phys}
> > with the controller's address.
> >
> > $ udevadm info -a -p /sys/devices/virtual/input/input21/
> > ...
> >   looking at device '/devices/virtual/input/input21':
> >     KERNEL=3D=3D"input21"
> >     SUBSYSTEM=3D=3D"input"
> >     DRIVER=3D=3D""
> >     ATTR{inhibited}=3D=3D"0"
> >     ATTR{name}=3D=3D"33:33:33:FF:FF:FF"
> >     ATTR{phys}=3D=3D""
> >     ATTR{properties}=3D=3D"0"
> >     ATTR{uniq}=3D=3D""
> >
> > This is what uhid looks like in comparison:
> >
> > $ udevadm info -a -p /sys/class/misc/uhid/0005\:046D\:B33B.0002/input/i=
nput18/
> >
> >   looking at device
> > '/devices/virtual/misc/uhid/0005:046D:B33B.0002/input/input18':
> >     KERNEL=3D=3D"input17"
> >     SUBSYSTEM=3D=3D"input"
> >     DRIVER=3D=3D""
> >     ATTR{inhibited}=3D=3D"0"
> >     ATTR{name}=3D=3D"Keyboard K780 Keyboard"
> >     ATTR{phys}=3D=3D"ab:cd:ef:12:34:56"
> >     ATTR{properties}=3D=3D"0"
> >     ATTR{uniq}=3D=3D"33:33:33:33:ff:ff"
> >
> >
> > Abhishek
>
> --
> Pali Roh=C3=A1r
> pali.rohar@gmail.com
