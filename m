Return-Path: <SRS0=Xy/k=D4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF578C388F9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Oct 2020 14:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 550D321481
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Oct 2020 14:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gugintsx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442386AbgJUOCU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Oct 2020 10:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408618AbgJUOCU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Oct 2020 10:02:20 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56D3C0613CE
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Oct 2020 07:02:19 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id w23so2049100edl.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Oct 2020 07:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yy2mvHlQrm47eIFOzIfEazwDqvocAj6nfjjbCBjXSgE=;
        b=gugintsxy4d6wfdGdN0P2DNfsFtGtn3zUylgOlOCvRVWvjN9Pb5k7JqXBEQdfyxZb4
         ySNAhW+sac/Qc36LQYdZ5fUnR3bpgzZmGxp9yXdsVQePkGWpfI5Y9OOQk6rDtnCCX56o
         jBjX40dapK1BvUp3Lul8fWTsMLq2a4HDS6BFptGxc/C51S3eNiYAUUr53VHBv4vzqrlv
         TnW7JnUvfdjyL95zKF7ZTn4wcQr4DjGRJBCuHcndWxalkWmynVYWUP9F2jeNQkhGsqxp
         XKQTlAnTTI8bsA2Ol88YhTJt7xg0E757kkODX20SoXk2Fjv6iAn7Tm3kDqriEcPUeooo
         6Fdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yy2mvHlQrm47eIFOzIfEazwDqvocAj6nfjjbCBjXSgE=;
        b=LG69tOWp7nYj19Zo78RvQhejWzxoxzzRv4BCmio8Nv2s4rUxmviyyXjPZDM820K9Eb
         +GAz+FkegD82B9CTwr/nr6v9KXnqi1slJ6XupEJK1pP7wy4k40k75KF0/g9ESyeGsmhB
         b/xXvDsr1eZEdPeeYnvLGyrW5glf9RrnkMKGgVHKfT0XtNSWb5bH0lVWebFpOWyL1AXx
         cPy3Tskm99ZmULY/HjpbSaqKfnIwL9yQHyZpU85WUbP8tOBajkNHUtmHGiUIrmmhx5kU
         O4Z2ewqNQXt/RzbnKd2h7TNHhL5sov2ITSCsCveGS4X/BVSnY5G/zi1+7YlPl+tEz+67
         PdhA==
X-Gm-Message-State: AOAM530gLj/O13opBWv0bY/82Y6BexZMPEfIHApAfpQ1npumZ5ZtwvaV
        bTh5eerYxWNXTcta57mLFtxZqDiOvhuvORmTpaCM+ZB4m0pj
X-Google-Smtp-Source: ABdhPJx/lq1RhUWQfiDSqeSsO058wMGZHKxUOlU+Le9WFHcKGLBYY3N2Br3yvdxBFJTYjO4yOVMlDkS9o9xg0QTKNLQ=
X-Received: by 2002:a05:6402:48d:: with SMTP id k13mr3296068edv.92.1603288937996;
 Wed, 21 Oct 2020 07:02:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAOOgLvqcSoaM7hgdzUA+JK0qgHfjhKKcLS2ScWNvsEiEj4xkoQ@mail.gmail.com>
 <20201019141608.401899-1-marijns95@gmail.com> <CAOOgLvoowRsJbdK-nyFi9V8hDAaBBA5j3ohwDoD0QVSdUF3h=A@mail.gmail.com>
 <CABBYNZKxrfR2rKuZt-T2_u2KXcS7d=nE-BuNQm+hZ7zuPb-y5A@mail.gmail.com>
 <CANX-K3s2eRaJeLScJpaUp=idkdjMhLHSAKTkyAhXTBWyK2Chaw@mail.gmail.com>
 <CAOOgLvo321AHC1aEv7N8EC4vzwTNUAohfWd02=Z1g2mt+ia7ew@mail.gmail.com>
 <CANX-K3sX25OwpJSoDkA9=8bZcSD0jME0NsrRj0nk62Dh+NghtQ@mail.gmail.com> <CAOOgLvru_gXCs6bNynonTzHBRR1O6uvx=w01+1Ro8dGWX0Xc-Q@mail.gmail.com>
In-Reply-To: <CAOOgLvru_gXCs6bNynonTzHBRR1O6uvx=w01+1Ro8dGWX0Xc-Q@mail.gmail.com>
From:   Marek Czerski <ma.czerski@gmail.com>
Date:   Wed, 21 Oct 2020 16:02:06 +0200
Message-ID: <CAOOgLvp4KNgxVDpZTPJDunh4eNEL1s3nX2g8jCVh8NCn1yu=Tg@mail.gmail.com>
Subject: Re: avrcp: possible race condition during connection establishment
To:     Marijn Suijten <marijns95@gmail.com>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marijn,

Regarding the AVRCP version reported by the phone. There is something
weird going on on android regarding avrcp version and mac addresses
and absolute volume. I discovered couple of whings:
1. galaxy S7 will blacklist some mac addresses to not use absolute
volume for that device (checked it with "adb shell dumpsys
bluetooth_manager"). Changing mac addres of the device to something
other allows for absolute volume to work. For both cases it reports
avrcp version 1.4.
2. xiaomi redmi note 4 will report different avrcp version depending
on mac address. version 1.3 for mac address that galaxy s7 blacklists
and 1.6 for mac address that galaxy s7 does not blacklist. But in both
cases the absolute volume does not work ...
3. xiaomi redmi 8 will not even report that it has "A/V_RemoteControl"
(UUID 0x110E), it just reports that it has only
"A/V_RemoteControlTarget" (UUID 0x110C) but still it can control
volume on my yamaha av receiver and sony headphones and receive volume
updates from them. Very, very wierd.

For the record, to check the avrcp version of the phone I use sdptool
browse command (and to be 100% sure I check also the raw communication
on wireshark). For example this is one of the records reported for
xiaomi redmi note 4 and avrcp version 1.6:
Service RecHandle: 0x10007
Service Class ID List:
  "AV Remote" (0x110e)
  "AV Remote Controller" (0x110f)
Protocol Descriptor List:
  "L2CAP" (0x0100)
    PSM: 23
  "AVCTP" (0x0017)
    uint16: 0x0104
Profile Descriptor List:
  "AV Remote" (0x110e)
    Version: 0x0106

If there is something more I can do to help please let me know. For
example I can send hci snoop logs for specific cases etc.

wt., 20 pa=C5=BA 2020 o 15:12 Marek Czerski <ma.czerski@gmail.com> napisa=
=C5=82(a):
>
> Hi Marijn,
>
> wt., 20 pa=C5=BA 2020 o 11:11 Marijn Suijten <marijns95@gmail.com> napisa=
=C5=82(a):
> >
> > Hi Marek,
> >
> > (Apologies for sending this to you twice; missed the reply-all button
> > so this didn't end up on the mailing list)
> >
> > On Tue, 20 Oct 2020 at 09:31, Marek Czerski <ma.czerski@gmail.com> wrot=
e:
> > >
> > > Hi Marijn,
> > >
> > > pon., 19 pa=C5=BA 2020 o 21:53 Marijn Suijten <marijns95@gmail.com> n=
apisa=C5=82(a):
> > > >
> > > > Hi Luiz, Marek,
> > > >
> > > > On Mon, 19 Oct 2020 at 18:47, Luiz Augusto von Dentz
> > > > <luiz.dentz@gmail.com> wrote:
> > > > >
> > > > > Hi Marek, Marijn,
> > > > >
> > > > > On Mon, Oct 19, 2020 at 9:06 AM Marek Czerski <ma.czerski@gmail.c=
om> wrote:
> > > > > >
> > > > > > Hi Marijn,
> > > > > >
> > > > > > pon., 19 pa=C5=BA 2020 o 16:16 Marijn Suijten <marijns95@gmail.=
com> napisa=C5=82(a):
> > > > > > >
> > > > > > > Hi Marek,
> > > > > > >
> > > > > > > > Hi all,
> > > > > > > >
> > > > > > > > I was looking into, so called, absolute volume control that=
 was
> > > > > > > > introduced in AVRCP v1.4. What I want to achieve is to send=
 audio from
> > > > > > > > android smartphone to linux based device running bluez and =
make the
> > > > > > > > volume control on the smartphone side to control the volume=
 on the
> > > > > > > > device. So the device is the a2dp sink + avrcp CT/TG and th=
e phone is
> > > > > > > > a2dp source + avrcp CT/TG.
> > > > > > > >
> > > > > > > > I assume that if all is working correctly then on the dbus =
the Volume
> > > > > > > > property of the org.bluez.MediaTransport1 will be changed b=
y the
> > > > > > > > volume control of the phone and changes made to this proper=
ty from the
> > > > > > > > device would propagate to the phone volume slider.
> > > > > > > >
> > > > > > > > This is not happening and what I believe is the cause is th=
at
> > > > > > > > AVRCP_EVENT_VOLUME_CHANGED event registration request sent =
from the
> > > > > > > > phone is rejected by the bluez. I can see that on the wires=
hark snoop
> > > > > > > > from the device's bluetooth adapter. And on wireshark I see=
 that
> > > > > > > > AVRCP_EVENT_VOLUME_CHANGED event registration is sent by th=
e phone
> > > > > > > > before bluez initializes session->supported_events variable=
 (not
> > > > > > > > really sure about that). I think that this rejection makes =
the phone
> > > > > > > > to not send SetAbsoluteVolume commands to the device on vol=
ume change.
> > > > > > >
> > > > > > > I looked into the same issue earlier this year, see
> > > > > > > 20200118194841.439036-1-marijns95@gmail.com [1].  The gist of=
 it is that BlueZ
> > > > > > > bases supported_events solely on the remote AVRCP controller =
version, which
> > > > > > > Android sets to 1.3 when it is a media source [2].  This vers=
ion is not
> > > > > > > relevant in your use-case because the Android phone is the AV=
RCP target while
> > > > > > > blueZ is the controller.
> > > > > > >
> > > > > >
> > > > > > I didn't tested Your patch but after looking at the code it see=
ms that
> > > > > > just applying Your patch would solve my problem.
> > > >
> > > > It should, even though I don't immediately see how swapping
> > > > target/controller_init as per your initial email solves the problem=
.
> > > >
> > >
> > > The sequence of events is important here. The
> > > session->supported_events must be initialised (which is done in
> > > target_init) before first AVRCP_REGISTER_NOTIFICATION command from th=
e
> > > remote side controller. If supported_events is not initialised and
> > > AVRCP_REGISTER_NOTIFICATION arrives the
> > > avrcp_handle_register_notification function rejects the event
> > > registration. And this is what I see in wireshark.
> >
> > That's interesting and means we are dealing with two distinct problems
> > here. No matter what order I flip controller/target_init in
> > AVRCP_REGISTER_NOTIFICATION is always received after both functions
> > complete. handle_vendordep_pdu is registered before these
> > initialization functions making this possible though. I wonder if PDUs
> > are dropped when the callback is registered later, after init. Perhaps
> > controller/target_init need to be split in two, a static
> > initialization part based on the remote profile version followed by
> > registering this callback and finally functions that send commands to
> > the remote like avrcp_get_capabilities.
> >
> > > And in my case, calling target_init earlier (the is before
> > > controller_init) solves the problem because supported_events is
> > > already initialised at the time the AVRCP_REGISTER_NOTIFICATION
> > > arrives.
> >
> > That means your phone reports an AVRCP remote version of at least
> > 0x104, otherwise supported_events would not contain
> > AVRCP_EVENT_VOLUME_CHANGED. Can you validate this in wireshark or
> > DBG("%p version 0x%04x", ...) in the logs? I'm seeing:
> >
> >     profiles/audio/avrcp.c:target_init() 0x5614a2cbab70 version 0x0103
> >
>
> Yes, I get this in my logs when connecting from samsung galaxy S7:
> profiles/audio/avrcp.c:target_init() 0x1103758 version 0x0104
> profiles/audio/avrcp.c:controller_init() 0x1112c18 version 0x0104
>
> > Either way the split Luiz and I mentioned mean one variant of
> > supported_events (the one relevant for registering
> > AVRCP_EVENT_VOLUME_CHANGED) is initialized in controller_init.
> >
> > > But I think that the problem is more general. There is some gap
> > > between AVCTP connection establishment and BlueZ readiness to handle
> > > commands from the remote side. There could be devices that send
> > > commands during this gap and those devices would not work correctly
> > > with BlueZ despite the fact that they are consistent with the
> > > specification (or not ?).
> > >
> > > > > > Regarding avrcp version, in android there is developer option t=
o set
> > > > > > avrcp version. For example my Xiaomi redmi 8 (android 10) repor=
ts
> > > > > > version according to this setting, but samsung galaxy s7 (andro=
id 8)
> > > > > > always report version 1.4 regardless of this setting.
> > > >
> > > > I think this is the version used for the AVRCP Remote Target [1]. T=
he
> > > > version linked above, the one that is causing problems here is that=
 of
> > > > the AVRCP controller.
> > > >
> > > > There have always been problems changing these settings in develope=
r
> > > > options - sometimes they work, sometimes they don't. The system has
> > > > been overhauled for Android 11 and is now much more consistent thou=
gh
> > > > avrcp still runs through a property. If I remember correctly
> > > > restarting bluetooth or re-adding a device (in case of SDP caching)=
 is
> > > > the only solution.
> > > >
> > > > > We need to rework a little bit how the controller/target works, t=
his
> > > > > roles are actually supposed to be interpreted as client/server an=
d
> > > > > much like GATT they can be used simultaneously, so we need a targ=
et
> > > > > versions and a controller version and independent supported event=
s.
> > > >
> > > > Yes, I think that's the change we proposed last time and are propos=
ing
> > > > now. Unfortunately relevant functions need to know if the local
> > > > (BlueZ) end is operating as target or controller for that particula=
r
> > > > operation.
> > > >
> > > > > That said if the remote side controller version does not indicate=
 1.4
> > > > > or later we obviously can't support absolute volume control as th=
at is
> > > > > reserved in earlier versions.
> > > >
> > > > That depends on the way audio is flowing. When the local (BlueZ) en=
d
> > > > is the sink (rendering the audio) meaning it takes the role of AVRC=
P
> > > > controller (the situation in the mail from Marek), the remote must =
be
> > > > the AVRCP target and hence its controller version is irrelevant.
> > > > Likewise when BlueZ is the audio source (AVRCP target), it should o=
nly
> > > > care about the remote controller profile and version.
> > > > But that is exactly what you described above: BlueZ needs to attain
> > > > separation between handling notification registrations (and perhaps
> > > > other code) as a controller and target separately.
> > > >
> > >
> > > I don't know if I'm interpreting your words correctly but I think tha=
t
> > > You make an assumption that a2dp sink must be avrcp CT and a2dp sourc=
e
> > > is avrcp TG.
> > > In case of the absolute volume control it is not true. For absolute
> > > volume control to work it is the other way around which makes both
> > > sides be CT and TG at the same time.
> >
> > Quite the contrary, in my previous mail I attempted to explain
> > multiple times that the CT/TG designation in the spec is used for
> > initiator and target respectively, not the AVRCP controller and target
> > profile. Indeed, depending on the transaction either side (controller
> > or target) can be the initiator (CT). In other words CT and TG are
> > _not_ abbreviations for the controller and target profile.
> >
> > > a2dp sink is avrcp CT for
> > > controlling playback and a2dp source is avrcp CT for setting the
> > > volume. It is the a2dp source that is sending
> > > AVRCP_SET_ABSOLUTE_VOLUME commands.
> >
> > Correct, yet the A2DP sink will always take on the AVRCP controller
> > profile where the phone being the A2DP source takes the AVRCP target
> > profile.
> >
> > > > > > > It was decided in that mail thread to split supported_events =
in two; one based
> > > > > > > on the external controller version (when BlueZ operates as ta=
rget it'll
> > > > > > > validate incoming notification registrations) and the other b=
ased on what BlueZ
> > > > > > > currently supports as controller.
> > > > > > >
> > > > > > > The second check might not be all too relevant and is already=
 covered by the
> > > > > > > switch-case; perhaps it makes more sense to base this check o=
n the external
> > > > > > > target version, and again validate whether we expect to recei=
ve that particular
> > > > > > > notification registration?
> > > > > > >
> > > > > > > Both checks together implicitly validate what BlueZ supports =
locally in its
> > > > > > > role of controller or target, as remote_{target,controller}_s=
upported_events
> > > > > > > (anticipated names of the new members replacing supported_eve=
nts) will only be
> > > > > > > set to events that BlueZ is able to emit.
> > > > > > >
> > > > > >
> > > > > > One thing is not clear for me, what is the purpose of the
> > > > > > supported_events ?  It is used in two places:
> > > > > > First is the avrcp_handle_register_notification function. If th=
e
> > > > > > remote side want to register itself for specific event notifica=
tion it
> > > > > > does not matter what version of avrcp that remote side supports=
. If it
> > > > > > ask for specific event it clearly support that event.
> > > >
> > > > Looking at commit 4ae6135 that introduced this check it was apparen=
tly
> > > > causing crashes without. I can only guess that devices were sending
> > > > vendor-specific notification requests, assuming implementations are
> > > > supposed to filter out anything beyond what their reported version
> > > > supports? Either way input validation is still a sane thing to do.
> > > >
> > > > > > Second is in avrcp_handle_get_capabilities in CAP_EVENTS_SUPPOR=
TED
> > > > > > case. Does it matter if local side reply with events that are n=
ot
> > > > > > supported in the version of avrcp supported by the remote side =
?
> > > >
> > > > I guess it is sane here to not report capabilities the CT should -
> > > > given it's version - not know about. I could not find anything in t=
he
> > > > 1.6.2 spec mandating this though, perhaps Luiz knows.
> > > >
> > > > > As I said we need to split the supported events to
> > > > > ct(client)/tg(server) to avoid interpreting them as the same, it =
is
> > > > > very odd that the remote would have different versions for each r=
ole
> > > >
> > > > Yeah, Android exposes different versions for its AVRCP Remote and
> > > > AVRCP Remote Target.
> > > > This is slightly confusing though: we discussed earlier that CT and=
 TG
> > > > is about the initiator and receiver respectively, with no direct
> > > > mapping to AVRCP remote and target as either side can be the initia=
tor
> > > > (sender) of a command. Correct?
> > > > In this specific case a notification registration will always be
> > > > initiated by a CT and fulfilled by the TG, no matter whether it is =
an
> > > > AVRCP remote or target.
> > > >
> > > > > but it looks like this is happening in this case although it is w=
ork
> > > > > confirming if the CT version if in fact 1.3 as well we cannot ena=
ble
> > > > > absolute volume control as that is not supported by that version,=
 what
> > > > > we can perhaps is to detect if SetAbsoluteVolume control is used =
then
> > > > > update the events for the session.
> > > >
> > > > Again, in the specific case of this issue it is fine if the CT
> > > > (initiator, the Android phone, supposed to behave like the target a=
s
> > > > it is the audio source) reports a controller version of 1.3 as we a=
re
> > > > only concerned about the target version, which will be the one
> > > > registering for EVENT_VOLUME_CHANGED notifications from the
> > > > sink/controller (BlueZ). Android always reports the AVRCP Remote
> > > > Target as 1.4 or higher based on developer settings [1].
> > > >
> > > > > > > Unfortunately my ramblings in that mail shadowed an important=
 question: how to
> > > > > > > determine in avrcp_handle_register_notification whether BlueZ=
 is running as
> > > > > > > controller or target?  set_volume in transport.c derives this=
 from
> > > > > > > transport->source_watch but there seems to be no easy access =
to the
> > > > > > > accompanying transport in avrcp_handle_register_notification.=
  With this
> > > > > > > question answered I'll be able to update and resubmit the ori=
ginal patch.
> > > > > > >
> > > > > > > > To test my theory i changed the session_init_control functi=
on in the
> > > > > > > > profiles/audio/avrcp.c to call first target_init and then
> > > > > > > > controller_init. This caused  the AVRCP_EVENT_VOLUME_CHANGE=
D event not
> > > > > > > > been rejected and the volume control from the phone works a=
s expected.
> > > > > > > >
> > > > > > > > After reading AVRCP specification I did not find any reason=
 for the CT
> > > > > > > > on the phone side not to send event registration immediatel=
y after the
> > > > > > > > AVCTP connection establishment. So I believe that bluez sho=
uld not
> > > > > > > > reject event registration in this case.
> > > > > > > >
> > > > > > > > Best Regards,
> > > > > > > > Marek Czerski
> > > > > > >
> > > > > > > Best regards,
> > > > > > > Marijn Suijten
> > > > > > >
> > > > > > > [1]: https://marc.info/?l=3Dlinux-bluetooth&m=3D1579376990010=
93
> > > > > > > [2]: https://android.googlesource.com/platform/system/bt/+/an=
droid-11.0.0_r4/bta/av/bta_av_main.cc#761
> > > > > >
> > > > > >
> > > > > > Best regards,
> > > > > > Marek Czerski
> > > > >
> > > > >
> > > > >
> > > > > --
> > > > > Luiz Augusto von Dentz
> > > >
> > > > P.S.: I hope it is fine to respond to two emails in one, seems like
> > > > that will get confusing real quick if depth increases.
> > > >
> > > > - Marijn
> > > >
> > > > [1]: https://android.googlesource.com/platform/system/bt/+/android-=
11.0.0_r4/bta/av/bta_av_main.cc#612
> > >
> > > Best regards,
> > > Marek
> >
> > - Marijn
>
>
>
> --
> mgr in=C5=BC. Marek Czerski
> +48 696 842 686



--=20
mgr in=C5=BC. Marek Czerski
+48 696 842 686
