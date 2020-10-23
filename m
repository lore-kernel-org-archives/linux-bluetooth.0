Return-Path: <SRS0=0zex=D6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265D5C388F9
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Oct 2020 09:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A23D624182
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Oct 2020 09:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAUMTcYA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461371AbgJWJXD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Oct 2020 05:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S461333AbgJWJXC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Oct 2020 05:23:02 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0151FC0613CE
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2020 02:23:02 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id s1so325920qvm.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2020 02:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mEXF+bKpsr+xcwAaHRxjqdIt/0CAKtOwibPq4sqbefM=;
        b=TAUMTcYA1cNuOnsNuc37RYMdsXnw7Zks75pYPdAlfHub5if73qwufCI9BoTGC9YWGv
         PYOyoWJyajDD/OiBrBxgOoK4cHTr8bMG+OybIYKve5cHKKUMs80FJT/m/wX/cSH3ZWZr
         6MnCXTpDkBpZii4qHFUs4//mfMqUcar35tdEIiSPCO3sov5pjkUWg7CJQb2jGTJhq9s7
         AS1GN7QNapxTYVuWuiCFvoSWrthTxTiGR/7L5hw1HvzUoGZypFbETrldRZ3v2ED5IrYG
         gGBEGZk7jsbUErCXX1Atatb5Ab4fVWKKeODGXjX7fKyd5W66FjJ/vfWb4DpCZr++nUN3
         1a/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mEXF+bKpsr+xcwAaHRxjqdIt/0CAKtOwibPq4sqbefM=;
        b=ti2GtXvv3Do1FDW6oVGXHJMi6AhkAeVUimj0bRCSFmH+URvasiOOH1CgzAGpSNBkJb
         PAXcUTDZmDz6LiblJAjZhOQ6VrtVHYPHxENmoWI2zDCuoePDB7j9ORzgRFe69r10NoLt
         ynuEwx548H7kUzUHtGawkaK9KR76cdXS9lFFrAOUt1pkE/x+AWVhzizPn5YJI6CGQlPz
         sG+t2dFTgmtKIHFBE/UZLFKbqCGNG/OY/JfjBNlYGoZV85I8J48nefHPgUEt+8hvArlQ
         nxVytSrErfU16SR2InNPdnbr7nF3rjXDkFfDjv62c5TtMlvPMLOKzUcl6Oo9lCCnNR9b
         ELQg==
X-Gm-Message-State: AOAM532kPXkjCudQ8VGZ1QIbPjFdJm7T2p8Y3OUaM7ncGzMkEf++da27
        4IZ1u5wkdFj782Nd+zJl+hTFcRZMqIBH3w20TB4=
X-Google-Smtp-Source: ABdhPJzcmY9sRvYjuV5bEJDwhFDKCIKoBwNzOO+ty0zxxsoX1yiIWHWNFsvymyumWHGIDp+w/3o9wuKXc7Hg89T4yVM=
X-Received: by 2002:ad4:5901:: with SMTP id ez1mr1145646qvb.56.1603444980560;
 Fri, 23 Oct 2020 02:23:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAOOgLvqcSoaM7hgdzUA+JK0qgHfjhKKcLS2ScWNvsEiEj4xkoQ@mail.gmail.com>
 <20201019141608.401899-1-marijns95@gmail.com> <CAOOgLvoowRsJbdK-nyFi9V8hDAaBBA5j3ohwDoD0QVSdUF3h=A@mail.gmail.com>
 <CABBYNZKxrfR2rKuZt-T2_u2KXcS7d=nE-BuNQm+hZ7zuPb-y5A@mail.gmail.com>
 <CANX-K3s2eRaJeLScJpaUp=idkdjMhLHSAKTkyAhXTBWyK2Chaw@mail.gmail.com>
 <CAOOgLvo321AHC1aEv7N8EC4vzwTNUAohfWd02=Z1g2mt+ia7ew@mail.gmail.com>
 <CANX-K3sX25OwpJSoDkA9=8bZcSD0jME0NsrRj0nk62Dh+NghtQ@mail.gmail.com>
 <CAOOgLvru_gXCs6bNynonTzHBRR1O6uvx=w01+1Ro8dGWX0Xc-Q@mail.gmail.com>
 <CAOOgLvp4KNgxVDpZTPJDunh4eNEL1s3nX2g8jCVh8NCn1yu=Tg@mail.gmail.com>
 <CANX-K3v87MKJB-TCpATMP3D-RO0dSduJgSbbho4RY9TK+a-CRw@mail.gmail.com> <CAOOgLvpos7ka-szKm3OsDQV_GJdyp4EJsS13Q-7nyU+-OWU_Tw@mail.gmail.com>
In-Reply-To: <CAOOgLvpos7ka-szKm3OsDQV_GJdyp4EJsS13Q-7nyU+-OWU_Tw@mail.gmail.com>
From:   Marijn Suijten <marijns95@gmail.com>
Date:   Fri, 23 Oct 2020 11:22:49 +0200
Message-ID: <CANX-K3sn6Te4=_M-0VAjVyLV5SpPwCFxwO-vMgQqu=_1akBTWg@mail.gmail.com>
Subject: Re: avrcp: possible race condition during connection establishment
To:     Marek Czerski <ma.czerski@gmail.com>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marek,

On Thu, 22 Oct 2020 at 15:06, Marek Czerski <ma.czerski@gmail.com> wrote:
>
> Hi Marijn,
>
> czw., 22 pa=C5=BA 2020 o 00:10 Marijn Suijten <marijns95@gmail.com> napis=
a=C5=82(a):
> >
> > Hi Marek,
> >
> > On Wed, 21 Oct 2020 at 16:02, Marek Czerski <ma.czerski@gmail.com> wrot=
e:
> > >
> > > Hi Marijn,
> > >
> > > Regarding the AVRCP version reported by the phone. There is something
> > > weird going on on android regarding avrcp version and mac addresses
> > > and absolute volume. I discovered couple of whings:
> > > 1. galaxy S7 will blacklist some mac addresses to not use absolute
> > > volume for that device (checked it with "adb shell dumpsys
> > > bluetooth_manager"). Changing mac addres of the device to something
> > > other allows for absolute volume to work. For both cases it reports
> > > avrcp version 1.4.
> >
> > There is indeed a database with traits based on mac-addresses [1].
> >
> > > 2. xiaomi redmi note 4 will report different avrcp version depending
> > > on mac address. version 1.3 for mac address that galaxy s7 blacklists
> > > and 1.6 for mac address that galaxy s7 does not blacklist. But in bot=
h
> > > cases the absolute volume does not work ...
> >
> > You confirmed earlier that besides this versioning issue there's also
> > an initialization issue with supported_events. I assume this test was
> > without flipping the _init calls around?
> >
>
> To tests if absolute volume is working on redmi note 4 I used two
> different a2dp sink devices, yamaha rx-v485 av receiver and sony
> wh-ch510 headphones. The AVRCP version was read from "sdptool browse"
> output running on my linux machine.
> So in this case, the absolute volume was not working at all on this
> phone despite the fact that it should (developer options were set to
> enable absolute volume). Also the absolute volume on this phone was
> not working with bluez no matter what the order of init calls.

That's odd, though searching for it shows this is a common problem
across Xiaomi products.  You might want to manually check getprop
persist.bluetooth.disableabsvol and make sure the phone is rebooted
after enabling absolute volume.  Otherwise look around in the Android
logs, they are pretty verbose about absolute volume support.

> > > 3. xiaomi redmi 8 will not even report that it has "A/V_RemoteControl=
"
> > > (UUID 0x110E), it just reports that it has only
> > > "A/V_RemoteControlTarget" (UUID 0x110C) but still it can control
> > > volume on my yamaha av receiver and sony headphones and receive volum=
e
> > > updates from them. Very, very wierd.
> >
> > That's not really surprising to me, in fact it is slightly weird that
> > other phones report the A/V_RemoteControl profile. A phone will always
> > be the audio source (thus the RemoteControlTarget), never the sink.
> >
>
> I know You were explaining that already but for me it is still a mystery =
...
> In AVRCP specification v1.6.2 (this is the newest one on the bluetooth
> sig site) in paragraph 2.2.1 (Roles) there is:
> "The controller (CT) is a device that initiates a transaction by
> sending a command frame to a target."
> So if the device wants to send a command it must play the controller
> role. And SetAbsoluteVolume is the command that is sent from the phone
> when you press volume up/down on the phone. So To support absolute
> volume the phone has to be a controller (and the target to handle
> play/pause etc. commands).
> Next in the same specification in chapter 8 (Service discovery
> interoperability requirements) there is:
> "This profile defines the following service records for the CT and the
> TG, respectively." and below is definition of those records.
> So I understand it that if phone wants to send SetAbsoluteVolume
> command it must implement the controller role (CT) and define the
> service record with services "A/V Remote ControlI" (0x110E) and "A/V
> Remote Control Controller" (0x110F) in "Service Class ID List" field.

Finally, the misunderstanding on my side has been cleared up in
chapter 8.  After reading chapter 2.2.1 I blindly assumed the CT and
TG designation were solely indicating message initiator, while
expecting the Remote Control and Remote Target to be analogous to sink
and source respectively.  That turns out to not be true at all, CT
role =3D=3D Remote Control service, TG =3D=3D Remote Target service.

I honestly wasn't expecting this.  It made too much sense that the
target is where the media player lives, while the controller is where
the "remote controls" are (and usually the rendering device).  That
way headphones would for example not need to expose the "Remote
Control Target" profile, but this finally explains why my headphones
expose that service.

In other words, in order to have any sort of meaningful communication
between two devices (SetAbsoluteVolume from source to sink, and media
controls from sink to source) both peers should handle both services.

This unfortunately means I need to rewrite the patch again and rectify
all earlier conversations in the patch discussion going on
concurrently.

> And in case of redmi 8, this phone does not define such service record
> and still it sends SetAbsoluteVolume commands.
>
> So either this phone is not respecting the specification or I totally
> missed the point. (I guess the second ...)
>
> > (Unless applying some hacks to libfluoride: it is possible to use an
> > older phone as A2DP sink - for example to connect to a receiver at the
> > other side of the room. I would have enabled it on all my phones if it
> > didn't break A2DP source capabilities at the same time... Maybe
> > Gabeldorsche addresses that)
> >
> > > For the record, to check the avrcp version of the phone I use sdptool
> > > browse command (and to be 100% sure I check also the raw communicatio=
n
> > > on wireshark). For example this is one of the records reported for
> > > xiaomi redmi note 4 and avrcp version 1.6:
> > > Service RecHandle: 0x10007
> > > Service Class ID List:
> > >   "AV Remote" (0x110e)
> > >   "AV Remote Controller" (0x110f)
> > > Protocol Descriptor List:
> > >   "L2CAP" (0x0100)
> > >     PSM: 23
> > >   "AVCTP" (0x0017)
> > >     uint16: 0x0104
> > > Profile Descriptor List:
> > >   "AV Remote" (0x110e)
> > >     Version: 0x0106
> > > If there is something more I can do to help please let me know. For
> > > example I can send hci snoop logs for specific cases etc.
> >
> > I will send a _preliminary_ patch to this thread that should resolve
> > both the versioning and ordering issue as I've finally figured a way
> > to check whether the session associated with an AVRCP command is
> > running as source or sink. It is not finalized yet so please don't be
> > too hard on it :)
> >
>
> I will be happy to test it :)

The patch was intended to end up in this mail thread but ended up as a
separate message despite setting in-reply-to correctly.  Am I not
allowed to send in-reply-to on my own message, with the to: field not
matching the original sender of that mail?  Or is it because the
subject does not match this mail thread?  Apologies either way, this
is one of my first dealings with mailing lists :)

> > > wt., 20 pa=C5=BA 2020 o 15:12 Marek Czerski <ma.czerski@gmail.com> na=
pisa=C5=82(a):
> > > >
> > > > Hi Marijn,
> > > >
> > > > wt., 20 pa=C5=BA 2020 o 11:11 Marijn Suijten <marijns95@gmail.com> =
napisa=C5=82(a):
> > > > >
> > > > > Hi Marek,
> > > > >
> > > > > (Apologies for sending this to you twice; missed the reply-all bu=
tton
> > > > > so this didn't end up on the mailing list)
> > > > >
> > > > > On Tue, 20 Oct 2020 at 09:31, Marek Czerski <ma.czerski@gmail.com=
> wrote:
> > > > > >
> > > > > > Hi Marijn,
> > > > > >
> > > > > > pon., 19 pa=C5=BA 2020 o 21:53 Marijn Suijten <marijns95@gmail.=
com> napisa=C5=82(a):
> > > > > > >
> > > > > > > Hi Luiz, Marek,
> > > > > > >
> > > > > > > On Mon, 19 Oct 2020 at 18:47, Luiz Augusto von Dentz
> > > > > > > <luiz.dentz@gmail.com> wrote:
> > > > > > > >
> > > > > > > > Hi Marek, Marijn,
> > > > > > > >
> > > > > > > > On Mon, Oct 19, 2020 at 9:06 AM Marek Czerski <ma.czerski@g=
mail.com> wrote:
> > > > > > > > >
> > > > > > > > > Hi Marijn,
> > > > > > > > >
> > > > > > > > > pon., 19 pa=C5=BA 2020 o 16:16 Marijn Suijten <marijns95@=
gmail.com> napisa=C5=82(a):
> > > > > > > > > >
> > > > > > > > > > Hi Marek,
> > > > > > > > > >
> > > > > > > > > > > Hi all,
> > > > > > > > > > >
> > > > > > > > > > > I was looking into, so called, absolute volume contro=
l that was
> > > > > > > > > > > introduced in AVRCP v1.4. What I want to achieve is t=
o send audio from
> > > > > > > > > > > android smartphone to linux based device running blue=
z and make the
> > > > > > > > > > > volume control on the smartphone side to control the =
volume on the
> > > > > > > > > > > device. So the device is the a2dp sink + avrcp CT/TG =
and the phone is
> > > > > > > > > > > a2dp source + avrcp CT/TG.
> > > > > > > > > > >
> > > > > > > > > > > I assume that if all is working correctly then on the=
 dbus the Volume
> > > > > > > > > > > property of the org.bluez.MediaTransport1 will be cha=
nged by the
> > > > > > > > > > > volume control of the phone and changes made to this =
property from the
> > > > > > > > > > > device would propagate to the phone volume slider.
> > > > > > > > > > >
> > > > > > > > > > > This is not happening and what I believe is the cause=
 is that
> > > > > > > > > > > AVRCP_EVENT_VOLUME_CHANGED event registration request=
 sent from the
> > > > > > > > > > > phone is rejected by the bluez. I can see that on the=
 wireshark snoop
> > > > > > > > > > > from the device's bluetooth adapter. And on wireshark=
 I see that
> > > > > > > > > > > AVRCP_EVENT_VOLUME_CHANGED event registration is sent=
 by the phone
> > > > > > > > > > > before bluez initializes session->supported_events va=
riable (not
> > > > > > > > > > > really sure about that). I think that this rejection =
makes the phone
> > > > > > > > > > > to not send SetAbsoluteVolume commands to the device =
on volume change.
> > > > > > > > > >
> > > > > > > > > > I looked into the same issue earlier this year, see
> > > > > > > > > > 20200118194841.439036-1-marijns95@gmail.com [1].  The g=
ist of it is that BlueZ
> > > > > > > > > > bases supported_events solely on the remote AVRCP contr=
oller version, which
> > > > > > > > > > Android sets to 1.3 when it is a media source [2].  Thi=
s version is not
> > > > > > > > > > relevant in your use-case because the Android phone is =
the AVRCP target while
> > > > > > > > > > blueZ is the controller.
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > I didn't tested Your patch but after looking at the code =
it seems that
> > > > > > > > > just applying Your patch would solve my problem.
> > > > > > >
> > > > > > > It should, even though I don't immediately see how swapping
> > > > > > > target/controller_init as per your initial email solves the p=
roblem.
> > > > > > >
> > > > > >
> > > > > > The sequence of events is important here. The
> > > > > > session->supported_events must be initialised (which is done in
> > > > > > target_init) before first AVRCP_REGISTER_NOTIFICATION command f=
rom the
> > > > > > remote side controller. If supported_events is not initialised =
and
> > > > > > AVRCP_REGISTER_NOTIFICATION arrives the
> > > > > > avrcp_handle_register_notification function rejects the event
> > > > > > registration. And this is what I see in wireshark.
> > > > >
> > > > > That's interesting and means we are dealing with two distinct pro=
blems
> > > > > here. No matter what order I flip controller/target_init in
> > > > > AVRCP_REGISTER_NOTIFICATION is always received after both functio=
ns
> > > > > complete. handle_vendordep_pdu is registered before these
> > > > > initialization functions making this possible though. I wonder if=
 PDUs
> > > > > are dropped when the callback is registered later, after init. Pe=
rhaps
> > > > > controller/target_init need to be split in two, a static
> > > > > initialization part based on the remote profile version followed =
by
> > > > > registering this callback and finally functions that send command=
s to
> > > > > the remote like avrcp_get_capabilities.
> > > > >
> > > > > > And in my case, calling target_init earlier (the is before
> > > > > > controller_init) solves the problem because supported_events is
> > > > > > already initialised at the time the AVRCP_REGISTER_NOTIFICATION
> > > > > > arrives.
> > > > >
> > > > > That means your phone reports an AVRCP remote version of at least
> > > > > 0x104, otherwise supported_events would not contain
> > > > > AVRCP_EVENT_VOLUME_CHANGED. Can you validate this in wireshark or
> > > > > DBG("%p version 0x%04x", ...) in the logs? I'm seeing:
> > > > >
> > > > >     profiles/audio/avrcp.c:target_init() 0x5614a2cbab70 version 0=
x0103
> > > > >
> > > >
> > > > Yes, I get this in my logs when connecting from samsung galaxy S7:
> > > > profiles/audio/avrcp.c:target_init() 0x1103758 version 0x0104
> > > > profiles/audio/avrcp.c:controller_init() 0x1112c18 version 0x0104
> > > >
> > > > > Either way the split Luiz and I mentioned mean one variant of
> > > > > supported_events (the one relevant for registering
> > > > > AVRCP_EVENT_VOLUME_CHANGED) is initialized in controller_init.
> > > > >
> > > > > > But I think that the problem is more general. There is some gap
> > > > > > between AVCTP connection establishment and BlueZ readiness to h=
andle
> > > > > > commands from the remote side. There could be devices that send
> > > > > > commands during this gap and those devices would not work corre=
ctly
> > > > > > with BlueZ despite the fact that they are consistent with the
> > > > > > specification (or not ?).
> > > > > >
> > > > > > > > > Regarding avrcp version, in android there is developer op=
tion to set
> > > > > > > > > avrcp version. For example my Xiaomi redmi 8 (android 10)=
 reports
> > > > > > > > > version according to this setting, but samsung galaxy s7 =
(android 8)
> > > > > > > > > always report version 1.4 regardless of this setting.
> > > > > > >
> > > > > > > I think this is the version used for the AVRCP Remote Target =
[1]. The
> > > > > > > version linked above, the one that is causing problems here i=
s that of
> > > > > > > the AVRCP controller.
> > > > > > >
> > > > > > > There have always been problems changing these settings in de=
veloper
> > > > > > > options - sometimes they work, sometimes they don't. The syst=
em has
> > > > > > > been overhauled for Android 11 and is now much more consisten=
t though
> > > > > > > avrcp still runs through a property. If I remember correctly
> > > > > > > restarting bluetooth or re-adding a device (in case of SDP ca=
ching) is
> > > > > > > the only solution.
> > > > > > >
> > > > > > > > We need to rework a little bit how the controller/target wo=
rks, this
> > > > > > > > roles are actually supposed to be interpreted as client/ser=
ver and
> > > > > > > > much like GATT they can be used simultaneously, so we need =
a target
> > > > > > > > versions and a controller version and independent supported=
 events.
> > > > > > >
> > > > > > > Yes, I think that's the change we proposed last time and are =
proposing
> > > > > > > now. Unfortunately relevant functions need to know if the loc=
al
> > > > > > > (BlueZ) end is operating as target or controller for that par=
ticular
> > > > > > > operation.
> > > > > > >
> > > > > > > > That said if the remote side controller version does not in=
dicate 1.4
> > > > > > > > or later we obviously can't support absolute volume control=
 as that is
> > > > > > > > reserved in earlier versions.
> > > > > > >
> > > > > > > That depends on the way audio is flowing. When the local (Blu=
eZ) end
> > > > > > > is the sink (rendering the audio) meaning it takes the role o=
f AVRCP
> > > > > > > controller (the situation in the mail from Marek), the remote=
 must be
> > > > > > > the AVRCP target and hence its controller version is irreleva=
nt.
> > > > > > > Likewise when BlueZ is the audio source (AVRCP target), it sh=
ould only
> > > > > > > care about the remote controller profile and version.
> > > > > > > But that is exactly what you described above: BlueZ needs to =
attain
> > > > > > > separation between handling notification registrations (and p=
erhaps
> > > > > > > other code) as a controller and target separately.
> > > > > > >
> > > > > >
> > > > > > I don't know if I'm interpreting your words correctly but I thi=
nk that
> > > > > > You make an assumption that a2dp sink must be avrcp CT and a2dp=
 source
> > > > > > is avrcp TG.
> > > > > > In case of the absolute volume control it is not true. For abso=
lute
> > > > > > volume control to work it is the other way around which makes b=
oth
> > > > > > sides be CT and TG at the same time.
> > > > >
> > > > > Quite the contrary, in my previous mail I attempted to explain
> > > > > multiple times that the CT/TG designation in the spec is used for
> > > > > initiator and target respectively, not the AVRCP controller and t=
arget
> > > > > profile. Indeed, depending on the transaction either side (contro=
ller
> > > > > or target) can be the initiator (CT). In other words CT and TG ar=
e
> > > > > _not_ abbreviations for the controller and target profile.
> > > > >
> > > > > > a2dp sink is avrcp CT for
> > > > > > controlling playback and a2dp source is avrcp CT for setting th=
e
> > > > > > volume. It is the a2dp source that is sending
> > > > > > AVRCP_SET_ABSOLUTE_VOLUME commands.
> > > > >
> > > > > Correct, yet the A2DP sink will always take on the AVRCP controll=
er
> > > > > profile where the phone being the A2DP source takes the AVRCP tar=
get
> > > > > profile.
> > > > >
> > > > > > > > > > It was decided in that mail thread to split supported_e=
vents in two; one based
> > > > > > > > > > on the external controller version (when BlueZ operates=
 as target it'll
> > > > > > > > > > validate incoming notification registrations) and the o=
ther based on what BlueZ
> > > > > > > > > > currently supports as controller.
> > > > > > > > > >
> > > > > > > > > > The second check might not be all too relevant and is a=
lready covered by the
> > > > > > > > > > switch-case; perhaps it makes more sense to base this c=
heck on the external
> > > > > > > > > > target version, and again validate whether we expect to=
 receive that particular
> > > > > > > > > > notification registration?
> > > > > > > > > >
> > > > > > > > > > Both checks together implicitly validate what BlueZ sup=
ports locally in its
> > > > > > > > > > role of controller or target, as remote_{target,control=
ler}_supported_events
> > > > > > > > > > (anticipated names of the new members replacing support=
ed_events) will only be
> > > > > > > > > > set to events that BlueZ is able to emit.
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > One thing is not clear for me, what is the purpose of the
> > > > > > > > > supported_events ?  It is used in two places:
> > > > > > > > > First is the avrcp_handle_register_notification function.=
 If the
> > > > > > > > > remote side want to register itself for specific event no=
tification it
> > > > > > > > > does not matter what version of avrcp that remote side su=
pports. If it
> > > > > > > > > ask for specific event it clearly support that event.
> > > > > > >
> > > > > > > Looking at commit 4ae6135 that introduced this check it was a=
pparently
> > > > > > > causing crashes without. I can only guess that devices were s=
ending
> > > > > > > vendor-specific notification requests, assuming implementatio=
ns are
> > > > > > > supposed to filter out anything beyond what their reported ve=
rsion
> > > > > > > supports? Either way input validation is still a sane thing t=
o do.
> > > > > > >
> > > > > > > > > Second is in avrcp_handle_get_capabilities in CAP_EVENTS_=
SUPPORTED
> > > > > > > > > case. Does it matter if local side reply with events that=
 are not
> > > > > > > > > supported in the version of avrcp supported by the remote=
 side ?
> > > > > > >
> > > > > > > I guess it is sane here to not report capabilities the CT sho=
uld -
> > > > > > > given it's version - not know about. I could not find anythin=
g in the
> > > > > > > 1.6.2 spec mandating this though, perhaps Luiz knows.
> > > > > > >
> > > > > > > > As I said we need to split the supported events to
> > > > > > > > ct(client)/tg(server) to avoid interpreting them as the sam=
e, it is
> > > > > > > > very odd that the remote would have different versions for =
each role
> > > > > > >
> > > > > > > Yeah, Android exposes different versions for its AVRCP Remote=
 and
> > > > > > > AVRCP Remote Target.
> > > > > > > This is slightly confusing though: we discussed earlier that =
CT and TG
> > > > > > > is about the initiator and receiver respectively, with no dir=
ect
> > > > > > > mapping to AVRCP remote and target as either side can be the =
initiator
> > > > > > > (sender) of a command. Correct?
> > > > > > > In this specific case a notification registration will always=
 be
> > > > > > > initiated by a CT and fulfilled by the TG, no matter whether =
it is an
> > > > > > > AVRCP remote or target.
> > > > > > >
> > > > > > > > but it looks like this is happening in this case although i=
t is work
> > > > > > > > confirming if the CT version if in fact 1.3 as well we cann=
ot enable
> > > > > > > > absolute volume control as that is not supported by that ve=
rsion, what
> > > > > > > > we can perhaps is to detect if SetAbsoluteVolume control is=
 used then
> > > > > > > > update the events for the session.
> > > > > > >
> > > > > > > Again, in the specific case of this issue it is fine if the C=
T
> > > > > > > (initiator, the Android phone, supposed to behave like the ta=
rget as
> > > > > > > it is the audio source) reports a controller version of 1.3 a=
s we are
> > > > > > > only concerned about the target version, which will be the on=
e
> > > > > > > registering for EVENT_VOLUME_CHANGED notifications from the
> > > > > > > sink/controller (BlueZ). Android always reports the AVRCP Rem=
ote
> > > > > > > Target as 1.4 or higher based on developer settings [1].
> > > > > > >
> > > > > > > > > > Unfortunately my ramblings in that mail shadowed an imp=
ortant question: how to
> > > > > > > > > > determine in avrcp_handle_register_notification whether=
 BlueZ is running as
> > > > > > > > > > controller or target?  set_volume in transport.c derive=
s this from
> > > > > > > > > > transport->source_watch but there seems to be no easy a=
ccess to the
> > > > > > > > > > accompanying transport in avrcp_handle_register_notific=
ation.  With this
> > > > > > > > > > question answered I'll be able to update and resubmit t=
he original patch.
> > > > > > > > > >
> > > > > > > > > > > To test my theory i changed the session_init_control =
function in the
> > > > > > > > > > > profiles/audio/avrcp.c to call first target_init and =
then
> > > > > > > > > > > controller_init. This caused  the AVRCP_EVENT_VOLUME_=
CHANGED event not
> > > > > > > > > > > been rejected and the volume control from the phone w=
orks as expected.
> > > > > > > > > > >
> > > > > > > > > > > After reading AVRCP specification I did not find any =
reason for the CT
> > > > > > > > > > > on the phone side not to send event registration imme=
diately after the
> > > > > > > > > > > AVCTP connection establishment. So I believe that blu=
ez should not
> > > > > > > > > > > reject event registration in this case.
> > > > > > > > > > >
> > > > > > > > > > > Best Regards,
> > > > > > > > > > > Marek Czerski
> > > > > > > > > >
> > > > > > > > > > Best regards,
> > > > > > > > > > Marijn Suijten
> > > > > > > > > >
> > > > > > > > > > [1]: https://marc.info/?l=3Dlinux-bluetooth&m=3D1579376=
99001093
> > > > > > > > > > [2]: https://android.googlesource.com/platform/system/b=
t/+/android-11.0.0_r4/bta/av/bta_av_main.cc#761
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > Best regards,
> > > > > > > > > Marek Czerski
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > --
> > > > > > > > Luiz Augusto von Dentz
> > > > > > >
> > > > > > > P.S.: I hope it is fine to respond to two emails in one, seem=
s like
> > > > > > > that will get confusing real quick if depth increases.
> > > > > > >
> > > > > > > - Marijn
> > > > > > >
> > > > > > > [1]: https://android.googlesource.com/platform/system/bt/+/an=
droid-11.0.0_r4/bta/av/bta_av_main.cc#612
> > > > > >
> > > > > > Best regards,
> > > > > > Marek
> > > > >
> > > > > - Marijn
> > > >
> > > >
> > > >
> > > > --
> > > > mgr in=C5=BC. Marek Czerski
> > > > +48 696 842 686
> > >
> > >
> > >
> > > --
> > > mgr in=C5=BC. Marek Czerski
> > > +48 696 842 686
> >
> > - Marijn
> >
> > [1]: https://android.googlesource.com/platform/system/bt/+/master/devic=
e/include/interop_database.h
>
>
>
> --
> mgr in=C5=BC. Marek Czerski
> +48 696 842 686

Thanks for clearing up my stubbornness in not seeing the relation
between CT/TG and the Remote Control/Remote Control Target service!

- Marijn
