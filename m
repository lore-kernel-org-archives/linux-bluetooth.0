Return-Path: <SRS0=/G8r=ZT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1B2C432C0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Nov 2019 17:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF92D20684
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Nov 2019 17:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="grXg6Fp+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfK0RVg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Nov 2019 12:21:36 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37429 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfK0RVg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Nov 2019 12:21:36 -0500
Received: by mail-qk1-f196.google.com with SMTP id e187so20225106qkf.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Nov 2019 09:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=O1Wv5Fa6y5WJzpCbaVLHvSntoRioiZULlQIXnav1cKs=;
        b=grXg6Fp+3O+OBf4RntdOJlUA3vx0n0EwlB68dbsopOr//2uIYLSLXRgiywaODMPFp8
         lAVNCK9K5sdi4cLWtThJWKu5oVEuQ34M+6vROqMXlS5P9uN307Jstwke0R8xXcG4lmll
         urg/OA0AP5gb0CSGgGwkimkdIe79ca28acZYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=O1Wv5Fa6y5WJzpCbaVLHvSntoRioiZULlQIXnav1cKs=;
        b=aU2XdOGCrjgTo68VA/lNs6dBWUmtxkt2745o8cBToZ1rW69uIQ+VEReW2Sq0JGUpJM
         51Ytsi84R43+4TV7q1ejdg20KzW1ypAx36CM9uR+w16BQ0/HYTaHkToNcQ0qwXojxp82
         zDTouAicifwmtb7QUsD/ddHoOpnen85k2Dnkd6MKwnp7+nslbuKVV6OhDLwtKvig3cSU
         5NrHvBgn4afBc4OsGssULZisOeKJyf0F6uFoLfNMY9QMj737ilYavHjr/ySZxDxLZn8c
         q2GZbmiwMZSxAP4YQ6+CdGPCdDCJe4wAcqJBiD08McMi7N4kOLTUav2NP1Qy+7WWWuB0
         QuSA==
X-Gm-Message-State: APjAAAUTDtIpscqaRzNKg33mJaRJGWKyNuKk1on3yaEiVTHQrNXSvOsr
        dlSEawJtqfY0LALsUBr00nq12qyMBS250U2PW/tyrg==
X-Google-Smtp-Source: APXvYqwLU+FlH/LLtKr0d4TYIEFZw32UlpJG1wW39mouczjgPMaWJG92lrg6+1EJluOKJ8Ntyd2SNdAjINd8u172X3g=
X-Received: by 2002:a05:620a:796:: with SMTP id 22mr4381875qka.419.1574875295112;
 Wed, 27 Nov 2019 09:21:35 -0800 (PST)
MIME-Version: 1.0
References: <20191126212753.18455-1-pali.rohar@gmail.com> <CABBYNZ+X1xThm9rrcj7ny9f9r0sVs-fTR2JroQdRgZTRWLcN6g@mail.gmail.com>
 <20191127160720.aleatv6l4swopg57@pali>
In-Reply-To: <20191127160720.aleatv6l4swopg57@pali>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Wed, 27 Nov 2019 09:21:24 -0800
Message-ID: <CANFp7mW47eJ6dquzLYX-uKoAO=Qc=ObgmSWQ5U0Xs7ThEV0Urg@mail.gmail.com>
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

On Wed, Nov 27, 2019 at 8:07 AM Pali Roh=C3=A1r <pali.rohar@gmail.com> wrot=
e:
>
> Hi!
>
> On Wednesday 27 November 2019 17:50:40 Luiz Augusto von Dentz wrote:
> > Hi Pali,
> >
> > On Tue, Nov 26, 2019 at 11:31 PM Pali Roh=C3=A1r <pali.rohar@gmail.com>=
 wrote:
> > >
> > > ---
> > >  profiles/audio/avctp.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > >
> > > diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
> > > index 70a3e40b2..ae53587ad 100644
> > > --- a/profiles/audio/avctp.c
> > > +++ b/profiles/audio/avctp.c
> > > @@ -1181,8 +1181,7 @@ static int uinput_create(char *name)
> > >         }
> > >
> > >         memset(&dev, 0, sizeof(dev));
> > > -       if (name)
> > > -               strncpy(dev.name, name, UINPUT_MAX_NAME_SIZE - 1);
> > > +       snprintf(dev.name, sizeof(dev.name), "Bluetooth Audio/Video R=
emote Control%s%s", name ? " " : "", name ? name : "");
> > >
> > >         dev.id.bustype =3D BUS_BLUETOOTH;
> > >         dev.id.vendor  =3D 0x0000;
> > > --
> > > 2.11.0
> >
> > It is already setting a bustype to BUS_BLUETOOTH why do you need to
> > make it more specific,
>
> Because more tools shows only device name. Also in kernel dmesg is only
> device name. And MAC address is really something which does not say
> anything about device...
>
> For this reason also older input devices (implemented in kernel) exports
> more descriptive names, e.g. "AT Translated Set 2 keyboard" or "ETPS/2
> Elantech TrackPoint" or "Integrated IR Camera".
>
> > btw it needs to be limited to UINPUT_MAX_NAME_SIZE.
>
> Is not this implicitly defined by sizeof()?
>
> > Id say if we want to make it declare the connection type
>
> Yes, connection type would be really useful.
>
> Now I'm playing with exporting "button press even" from HSP profile via
> uinput device too and therefore connection type should be there.
>
> > that probably something that needs to be encoded in
> > the bus itself, like BUS_BLUETOOTH_AVCTP, BUS_BLUETOOTH_HOG, etc.
>
> But bus type is kernel API and there is no such AVCTP or HOG. So we need
> to stick with BUS_BLUETOOH.
>
> Other kernel devices also put protocol information into name (e.g.
> touchpad / trackpoints), so it is ideal place also for bluetooth
> devices.
>
> And probably most userspace devices are mapped to BUS_VIRTUAL. There
> are no subtypes.
>
> --
> Pali Roh=C3=A1r
> pali.rohar@gmail.com

Wouldn't it be better to use the device name for uinput rather than the add=
ress?

In `init_uinput` (avctp.c), uinput_create is called with
device_get_address instead of device_get_name. It would probably be
better to use the device name for the uinput and set the device
address as the `uniq` attribute (as it is done for /dev/uhid for HID
devices).

So in the following, replace ATTR{name} with something like "Some
Company Headphones", ATTR{uniq} =3D "33:33:33:ff:ff:ff" and ATTR{phys}
with the controller's address.

$ udevadm info -a -p /sys/devices/virtual/input/input21/
...
  looking at device '/devices/virtual/input/input21':
    KERNEL=3D=3D"input21"
    SUBSYSTEM=3D=3D"input"
    DRIVER=3D=3D""
    ATTR{inhibited}=3D=3D"0"
    ATTR{name}=3D=3D"33:33:33:FF:FF:FF"
    ATTR{phys}=3D=3D""
    ATTR{properties}=3D=3D"0"
    ATTR{uniq}=3D=3D""

This is what uhid looks like in comparison:

$ udevadm info -a -p /sys/class/misc/uhid/0005\:046D\:B33B.0002/input/input=
18/

  looking at device
'/devices/virtual/misc/uhid/0005:046D:B33B.0002/input/input18':
    KERNEL=3D=3D"input17"
    SUBSYSTEM=3D=3D"input"
    DRIVER=3D=3D""
    ATTR{inhibited}=3D=3D"0"
    ATTR{name}=3D=3D"Keyboard K780 Keyboard"
    ATTR{phys}=3D=3D"ab:cd:ef:12:34:56"
    ATTR{properties}=3D=3D"0"
    ATTR{uniq}=3D=3D"33:33:33:33:ff:ff"


Abhishek
