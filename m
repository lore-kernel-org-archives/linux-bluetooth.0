Return-Path: <SRS0=wTyq=D2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05766C433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Oct 2020 16:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94B90222EA
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Oct 2020 16:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UjzwN0L2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729916AbgJSQrW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Oct 2020 12:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729849AbgJSQrV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Oct 2020 12:47:21 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5315C0613CE
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Oct 2020 09:47:21 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id i12so226831ota.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Oct 2020 09:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oS004AGtLfys9V5DlgSN+9XR6F8CjrtK81i4kdJ05vk=;
        b=UjzwN0L2dviYubLNcSqrwdPkpuGasykDgCgSSCg9iGMZoyIU0t+KHLMk/mCmBfkYov
         Fp4yuunz56nRFpuehJPdnTb75ytA+GcwXFrGHXKq6sNZXzHlAPCJalx2J350Cfr46dbb
         ot4uZHihgIP/n1M5u3r6AKEBFjbglFWxvtZOql7dzZnWbIb7KLmSJoJpRmr34K6Szv/2
         4Ups961sWp4857Y2rWdc/1Pe7P2X+NLwP8IhpZr2UM2ekFLVAoTVOehl8Ycncgu0962z
         Hx8QxZOJculE4peIRES17qEl56lHtgO90LpX5rJhuO/55ELMum9mK5mAVWFpf2b381n3
         khWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oS004AGtLfys9V5DlgSN+9XR6F8CjrtK81i4kdJ05vk=;
        b=n+67FeILBhIjipqsARgjjbNniT5qKzq4DCfdts9usma9k3a+qtpuiCct57fZkIwUxB
         RmjtYNm/cy5wLvmdt96TeUXezET+Xcofp/w1lhZyWpj9m954o9A+muW81ZCsY3oMCPi1
         40hEKDJ6ZS4XOiMKVKWUPvGnMULlelGUgLhTH8IMon5/Q7soopzknvN0QVxl+AJHe+Ln
         73sG/4+gLXDvgCySpaj16F7O6stD4MVRXZljVauZIl738tbADp96vG1W8o3ojJd15ljD
         fFl2Y3rDeZbuIb0gYefEU4Ll1RULwqi93e+jE6Gr2foefVpiMTyZYTdvd60rGKvRkFPn
         x4TQ==
X-Gm-Message-State: AOAM5329FrfBfaolK/x6UqMm46lPetjuuJMIf05H+Uje48yRH5HCxkOf
        +gZxHhIgLurcciZu6NroFXLXJahZAQ/y8fi7qoo=
X-Google-Smtp-Source: ABdhPJxcR7P6nP5LdMoRox3ElRaU/6FG059f0FkUSI0QrgHgYhjYtLuloDN8GUF3xvB2aOWTTXZCYzTDRHk5Ri7QD74=
X-Received: by 2002:a05:6830:134c:: with SMTP id r12mr615555otq.240.1603126040287;
 Mon, 19 Oct 2020 09:47:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAOOgLvqcSoaM7hgdzUA+JK0qgHfjhKKcLS2ScWNvsEiEj4xkoQ@mail.gmail.com>
 <20201019141608.401899-1-marijns95@gmail.com> <CAOOgLvoowRsJbdK-nyFi9V8hDAaBBA5j3ohwDoD0QVSdUF3h=A@mail.gmail.com>
In-Reply-To: <CAOOgLvoowRsJbdK-nyFi9V8hDAaBBA5j3ohwDoD0QVSdUF3h=A@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 19 Oct 2020 09:47:08 -0700
Message-ID: <CABBYNZKxrfR2rKuZt-T2_u2KXcS7d=nE-BuNQm+hZ7zuPb-y5A@mail.gmail.com>
Subject: Re: avrcp: possible race condition during connection establishment
To:     Marek Czerski <ma.czerski@gmail.com>
Cc:     Marijn Suijten <marijns95@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marek, Marijn,

On Mon, Oct 19, 2020 at 9:06 AM Marek Czerski <ma.czerski@gmail.com> wrote:
>
> Hi Marijn,
>
> pon., 19 pa=C5=BA 2020 o 16:16 Marijn Suijten <marijns95@gmail.com> napis=
a=C5=82(a):
> >
> > Hi Marek,
> >
> > > Hi all,
> > >
> > > I was looking into, so called, absolute volume control that was
> > > introduced in AVRCP v1.4. What I want to achieve is to send audio fro=
m
> > > android smartphone to linux based device running bluez and make the
> > > volume control on the smartphone side to control the volume on the
> > > device. So the device is the a2dp sink + avrcp CT/TG and the phone is
> > > a2dp source + avrcp CT/TG.
> > >
> > > I assume that if all is working correctly then on the dbus the Volume
> > > property of the org.bluez.MediaTransport1 will be changed by the
> > > volume control of the phone and changes made to this property from th=
e
> > > device would propagate to the phone volume slider.
> > >
> > > This is not happening and what I believe is the cause is that
> > > AVRCP_EVENT_VOLUME_CHANGED event registration request sent from the
> > > phone is rejected by the bluez. I can see that on the wireshark snoop
> > > from the device's bluetooth adapter. And on wireshark I see that
> > > AVRCP_EVENT_VOLUME_CHANGED event registration is sent by the phone
> > > before bluez initializes session->supported_events variable (not
> > > really sure about that). I think that this rejection makes the phone
> > > to not send SetAbsoluteVolume commands to the device on volume change=
.
> >
> > I looked into the same issue earlier this year, see
> > 20200118194841.439036-1-marijns95@gmail.com [1].  The gist of it is tha=
t BlueZ
> > bases supported_events solely on the remote AVRCP controller version, w=
hich
> > Android sets to 1.3 when it is a media source [2].  This version is not
> > relevant in your use-case because the Android phone is the AVRCP target=
 while
> > blueZ is the controller.
> >
>
> I didn't tested Your patch but after looking at the code it seems that
> just applying Your patch would solve my problem.
> Regarding avrcp version, in android there is developer option to set
> avrcp version. For example my Xiaomi redmi 8 (android 10) reports
> version according to this setting, but samsung galaxy s7 (android 8)
> always report version 1.4 regardless of this setting.

We need to rework a little bit how the controller/target works, this
roles are actually supposed to be interpreted as client/server and
much like GATT they can be used simultaneously, so we need a target
versions and a controller version and independent supported events.
That said if the remote side controller version does not indicate 1.4
or later we obviously can't support absolute volume control as that is
reserved in earlier versions.

> > It was decided in that mail thread to split supported_events in two; on=
e based
> > on the external controller version (when BlueZ operates as target it'll
> > validate incoming notification registrations) and the other based on wh=
at BlueZ
> > currently supports as controller.
> >
> > The second check might not be all too relevant and is already covered b=
y the
> > switch-case; perhaps it makes more sense to base this check on the exte=
rnal
> > target version, and again validate whether we expect to receive that pa=
rticular
> > notification registration?
> >
> > Both checks together implicitly validate what BlueZ supports locally in=
 its
> > role of controller or target, as remote_{target,controller}_supported_e=
vents
> > (anticipated names of the new members replacing supported_events) will =
only be
> > set to events that BlueZ is able to emit.
> >
>
> One thing is not clear for me, what is the purpose of the
> supported_events ?  It is used in two places:
> First is the avrcp_handle_register_notification function. If the
> remote side want to register itself for specific event notification it
> does not matter what version of avrcp that remote side supports. If it
> ask for specific event it clearly support that event.
> Second is in avrcp_handle_get_capabilities in CAP_EVENTS_SUPPORTED
> case. Does it matter if local side reply with events that are not
> supported in the version of avrcp supported by the remote side ?

As I said we need to split the supported events to
ct(client)/tg(server) to avoid interpreting them as the same, it is
very odd that the remote would have different versions for each role
but it looks like this is happening in this case although it is work
confirming if the CT version if in fact 1.3 as well we cannot enable
absolute volume control as that is not supported by that version, what
we can perhaps is to detect if SetAbsoluteVolume control is used then
update the events for the session.

> > Unfortunately my ramblings in that mail shadowed an important question:=
 how to
> > determine in avrcp_handle_register_notification whether BlueZ is runnin=
g as
> > controller or target?  set_volume in transport.c derives this from
> > transport->source_watch but there seems to be no easy access to the
> > accompanying transport in avrcp_handle_register_notification.  With thi=
s
> > question answered I'll be able to update and resubmit the original patc=
h.
> >
> > > To test my theory i changed the session_init_control function in the
> > > profiles/audio/avrcp.c to call first target_init and then
> > > controller_init. This caused  the AVRCP_EVENT_VOLUME_CHANGED event no=
t
> > > been rejected and the volume control from the phone works as expected=
.
> > >
> > > After reading AVRCP specification I did not find any reason for the C=
T
> > > on the phone side not to send event registration immediately after th=
e
> > > AVCTP connection establishment. So I believe that bluez should not
> > > reject event registration in this case.
> > >
> > > Best Regards,
> > > Marek Czerski
> >
> > Best regards,
> > Marijn Suijten
> >
> > [1]: https://marc.info/?l=3Dlinux-bluetooth&m=3D157937699001093
> > [2]: https://android.googlesource.com/platform/system/bt/+/android-11.0=
.0_r4/bta/av/bta_av_main.cc#761
>
>
> Best regards,
> Marek Czerski



--=20
Luiz Augusto von Dentz
