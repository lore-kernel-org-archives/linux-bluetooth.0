Return-Path: <SRS0=wTyq=D2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5699FC43457
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Oct 2020 19:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18DBE222B8
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Oct 2020 19:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpX56FEd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731594AbgJSTxf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Oct 2020 15:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728488AbgJSTxc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Oct 2020 15:53:32 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BB0C0613CE
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Oct 2020 12:53:32 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id c5so719854qtw.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Oct 2020 12:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WmxybbGi7MZjCM/l1+MezDabmUicvPbi6h5X39biNos=;
        b=fpX56FEdZ9Sytx+3kdUipbLlPhbrCy8+tHSzbXAY2vYMPvi7910K3GNJBK1rq3IaBQ
         6y5+wPQNsRiot3sHE84+wPVTmQHyCv6PLQXpfMXCCHrmsU/sJ6sCgHXxZjPQ7SzOSc+E
         rewM+vwp+XtNhNI0VqsIUFrpYRZ8kxRYEm5EUFvmbx30gwy6MYkY5FWiJPdKpohBUdPl
         MU+IF7pxORZSvHrU9KMZLy6g2m+PvMwGJ3MWatLSh4KD6jYFqm43YzK3X8pBNE+2BnBL
         7ZpPe9OomtOxV3RyptdOt8YU4G9F5v+A6znPspEIrLGojfNCG/D2eQWxzUM1EmxytDKF
         0W/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WmxybbGi7MZjCM/l1+MezDabmUicvPbi6h5X39biNos=;
        b=DT5eCfYmRb7x+J5GygC+vDfnSQBoZXzT8BJ1v+wAa8IJvNrUZJ940jXqBqGvedrdc+
         B7QVD+h3APQYeEGHq5NsMWt4anXzi24xKULEVO1wIq+t+9mhdfSgtUG+hGMZ05kMskNU
         VDXY53w3l3lNBeVA+3vasSACkvEbRF0+8xfGeLsfpzQg+m2aROYx/KWGwepVIJw88ZgI
         ILJFE38kxXMPhhu+55gk1XJtY0zwPusJUBqtT1J8kumd6uPMzoV7vovOEXxE0MRGAUK3
         D0onGeIh9GrdZvzlLon5Drwf9zKpvLfg0Vset2umtEe8MnI+lQMpnkim/CZDV8p8KNpI
         UgqA==
X-Gm-Message-State: AOAM533KRuDUOV7UXRw0+d9Q67ZtDv8lKUcwXkYQc20o2sXumexhscUr
        rSirUq2jRfRFINSt6mLzAxqu05OxkU7kWx3CbO1gKqZSAdNHtg==
X-Google-Smtp-Source: ABdhPJzGP01d57m5VVSZUInd1QY/k3pllSPovPQfwPVR9mYAnQVXd+NNB+79FvbutRMeDyRF3S4LzmG8F0/17AXYfIA=
X-Received: by 2002:aed:3129:: with SMTP id 38mr1129846qtg.362.1603137211089;
 Mon, 19 Oct 2020 12:53:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAOOgLvqcSoaM7hgdzUA+JK0qgHfjhKKcLS2ScWNvsEiEj4xkoQ@mail.gmail.com>
 <20201019141608.401899-1-marijns95@gmail.com> <CAOOgLvoowRsJbdK-nyFi9V8hDAaBBA5j3ohwDoD0QVSdUF3h=A@mail.gmail.com>
 <CABBYNZKxrfR2rKuZt-T2_u2KXcS7d=nE-BuNQm+hZ7zuPb-y5A@mail.gmail.com>
In-Reply-To: <CABBYNZKxrfR2rKuZt-T2_u2KXcS7d=nE-BuNQm+hZ7zuPb-y5A@mail.gmail.com>
From:   Marijn Suijten <marijns95@gmail.com>
Date:   Mon, 19 Oct 2020 21:53:17 +0200
Message-ID: <CANX-K3s2eRaJeLScJpaUp=idkdjMhLHSAKTkyAhXTBWyK2Chaw@mail.gmail.com>
Subject: Re: avrcp: possible race condition during connection establishment
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Marek Czerski <ma.czerski@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz, Marek,

On Mon, 19 Oct 2020 at 18:47, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Marek, Marijn,
>
> On Mon, Oct 19, 2020 at 9:06 AM Marek Czerski <ma.czerski@gmail.com> wrot=
e:
> >
> > Hi Marijn,
> >
> > pon., 19 pa=C5=BA 2020 o 16:16 Marijn Suijten <marijns95@gmail.com> nap=
isa=C5=82(a):
> > >
> > > Hi Marek,
> > >
> > > > Hi all,
> > > >
> > > > I was looking into, so called, absolute volume control that was
> > > > introduced in AVRCP v1.4. What I want to achieve is to send audio f=
rom
> > > > android smartphone to linux based device running bluez and make the
> > > > volume control on the smartphone side to control the volume on the
> > > > device. So the device is the a2dp sink + avrcp CT/TG and the phone =
is
> > > > a2dp source + avrcp CT/TG.
> > > >
> > > > I assume that if all is working correctly then on the dbus the Volu=
me
> > > > property of the org.bluez.MediaTransport1 will be changed by the
> > > > volume control of the phone and changes made to this property from =
the
> > > > device would propagate to the phone volume slider.
> > > >
> > > > This is not happening and what I believe is the cause is that
> > > > AVRCP_EVENT_VOLUME_CHANGED event registration request sent from the
> > > > phone is rejected by the bluez. I can see that on the wireshark sno=
op
> > > > from the device's bluetooth adapter. And on wireshark I see that
> > > > AVRCP_EVENT_VOLUME_CHANGED event registration is sent by the phone
> > > > before bluez initializes session->supported_events variable (not
> > > > really sure about that). I think that this rejection makes the phon=
e
> > > > to not send SetAbsoluteVolume commands to the device on volume chan=
ge.
> > >
> > > I looked into the same issue earlier this year, see
> > > 20200118194841.439036-1-marijns95@gmail.com [1].  The gist of it is t=
hat BlueZ
> > > bases supported_events solely on the remote AVRCP controller version,=
 which
> > > Android sets to 1.3 when it is a media source [2].  This version is n=
ot
> > > relevant in your use-case because the Android phone is the AVRCP targ=
et while
> > > blueZ is the controller.
> > >
> >
> > I didn't tested Your patch but after looking at the code it seems that
> > just applying Your patch would solve my problem.

It should, even though I don't immediately see how swapping
target/controller_init as per your initial email solves the problem.

> > Regarding avrcp version, in android there is developer option to set
> > avrcp version. For example my Xiaomi redmi 8 (android 10) reports
> > version according to this setting, but samsung galaxy s7 (android 8)
> > always report version 1.4 regardless of this setting.

I think this is the version used for the AVRCP Remote Target [1]. The
version linked above, the one that is causing problems here is that of
the AVRCP controller.

There have always been problems changing these settings in developer
options - sometimes they work, sometimes they don't. The system has
been overhauled for Android 11 and is now much more consistent though
avrcp still runs through a property. If I remember correctly
restarting bluetooth or re-adding a device (in case of SDP caching) is
the only solution.

> We need to rework a little bit how the controller/target works, this
> roles are actually supposed to be interpreted as client/server and
> much like GATT they can be used simultaneously, so we need a target
> versions and a controller version and independent supported events.

Yes, I think that's the change we proposed last time and are proposing
now. Unfortunately relevant functions need to know if the local
(BlueZ) end is operating as target or controller for that particular
operation.

> That said if the remote side controller version does not indicate 1.4
> or later we obviously can't support absolute volume control as that is
> reserved in earlier versions.

That depends on the way audio is flowing. When the local (BlueZ) end
is the sink (rendering the audio) meaning it takes the role of AVRCP
controller (the situation in the mail from Marek), the remote must be
the AVRCP target and hence its controller version is irrelevant.
Likewise when BlueZ is the audio source (AVRCP target), it should only
care about the remote controller profile and version.
But that is exactly what you described above: BlueZ needs to attain
separation between handling notification registrations (and perhaps
other code) as a controller and target separately.

> > > It was decided in that mail thread to split supported_events in two; =
one based
> > > on the external controller version (when BlueZ operates as target it'=
ll
> > > validate incoming notification registrations) and the other based on =
what BlueZ
> > > currently supports as controller.
> > >
> > > The second check might not be all too relevant and is already covered=
 by the
> > > switch-case; perhaps it makes more sense to base this check on the ex=
ternal
> > > target version, and again validate whether we expect to receive that =
particular
> > > notification registration?
> > >
> > > Both checks together implicitly validate what BlueZ supports locally =
in its
> > > role of controller or target, as remote_{target,controller}_supported=
_events
> > > (anticipated names of the new members replacing supported_events) wil=
l only be
> > > set to events that BlueZ is able to emit.
> > >
> >
> > One thing is not clear for me, what is the purpose of the
> > supported_events ?  It is used in two places:
> > First is the avrcp_handle_register_notification function. If the
> > remote side want to register itself for specific event notification it
> > does not matter what version of avrcp that remote side supports. If it
> > ask for specific event it clearly support that event.

Looking at commit 4ae6135 that introduced this check it was apparently
causing crashes without. I can only guess that devices were sending
vendor-specific notification requests, assuming implementations are
supposed to filter out anything beyond what their reported version
supports? Either way input validation is still a sane thing to do.

> > Second is in avrcp_handle_get_capabilities in CAP_EVENTS_SUPPORTED
> > case. Does it matter if local side reply with events that are not
> > supported in the version of avrcp supported by the remote side ?

I guess it is sane here to not report capabilities the CT should -
given it's version - not know about. I could not find anything in the
1.6.2 spec mandating this though, perhaps Luiz knows.

> As I said we need to split the supported events to
> ct(client)/tg(server) to avoid interpreting them as the same, it is
> very odd that the remote would have different versions for each role

Yeah, Android exposes different versions for its AVRCP Remote and
AVRCP Remote Target.
This is slightly confusing though: we discussed earlier that CT and TG
is about the initiator and receiver respectively, with no direct
mapping to AVRCP remote and target as either side can be the initiator
(sender) of a command. Correct?
In this specific case a notification registration will always be
initiated by a CT and fulfilled by the TG, no matter whether it is an
AVRCP remote or target.

> but it looks like this is happening in this case although it is work
> confirming if the CT version if in fact 1.3 as well we cannot enable
> absolute volume control as that is not supported by that version, what
> we can perhaps is to detect if SetAbsoluteVolume control is used then
> update the events for the session.

Again, in the specific case of this issue it is fine if the CT
(initiator, the Android phone, supposed to behave like the target as
it is the audio source) reports a controller version of 1.3 as we are
only concerned about the target version, which will be the one
registering for EVENT_VOLUME_CHANGED notifications from the
sink/controller (BlueZ). Android always reports the AVRCP Remote
Target as 1.4 or higher based on developer settings [1].

> > > Unfortunately my ramblings in that mail shadowed an important questio=
n: how to
> > > determine in avrcp_handle_register_notification whether BlueZ is runn=
ing as
> > > controller or target?  set_volume in transport.c derives this from
> > > transport->source_watch but there seems to be no easy access to the
> > > accompanying transport in avrcp_handle_register_notification.  With t=
his
> > > question answered I'll be able to update and resubmit the original pa=
tch.
> > >
> > > > To test my theory i changed the session_init_control function in th=
e
> > > > profiles/audio/avrcp.c to call first target_init and then
> > > > controller_init. This caused  the AVRCP_EVENT_VOLUME_CHANGED event =
not
> > > > been rejected and the volume control from the phone works as expect=
ed.
> > > >
> > > > After reading AVRCP specification I did not find any reason for the=
 CT
> > > > on the phone side not to send event registration immediately after =
the
> > > > AVCTP connection establishment. So I believe that bluez should not
> > > > reject event registration in this case.
> > > >
> > > > Best Regards,
> > > > Marek Czerski
> > >
> > > Best regards,
> > > Marijn Suijten
> > >
> > > [1]: https://marc.info/?l=3Dlinux-bluetooth&m=3D157937699001093
> > > [2]: https://android.googlesource.com/platform/system/bt/+/android-11=
.0.0_r4/bta/av/bta_av_main.cc#761
> >
> >
> > Best regards,
> > Marek Czerski
>
>
>
> --
> Luiz Augusto von Dentz

P.S.: I hope it is fine to respond to two emails in one, seems like
that will get confusing real quick if depth increases.

- Marijn

[1]: https://android.googlesource.com/platform/system/bt/+/android-11.0.0_r=
4/bta/av/bta_av_main.cc#612
