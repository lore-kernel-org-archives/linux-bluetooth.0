Return-Path: <SRS0=lsET=3L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8823BC2D0CE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jan 2020 00:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 529752253D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jan 2020 00:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sa59Cs6a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbgAVAQo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Jan 2020 19:16:44 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40579 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727969AbgAVAQo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Jan 2020 19:16:44 -0500
Received: by mail-oi1-f196.google.com with SMTP id c77so4452193oib.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jan 2020 16:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HNJ2jUDkPY3P07Z3I+xQuaZgP1/KyFIPVqqkQgaS4jo=;
        b=sa59Cs6alAeYRpQ0eNJifzHJDLE2KghpnrNZshYFHFRnvm/5L/WSO1UO0MdPz3PkkT
         DQpN5GIjg8z494Hl483XPupQecukl4e61ZkIp2ooOED2ZWgbX2QUsY4m7qh0rYFslqNL
         OSwTczH+TtQXLOlgHfWwgAeZ2iMlbnSogbYqMtX2INh7Ei7Z2DjKm//ajGI4UK1T3kH+
         jG11T+ZZ0wbucHpEJsKNtjAUZvqgPSFFqizBpjyC/vgjhxN5Yic5iVyJUbnKmn2FTyaO
         cll0gFJEQA0f9wjmajoSvPjU31ve3p3m09JbRtKYzxRuGUMExRnhapmI9XkJ7xifsRRd
         o5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HNJ2jUDkPY3P07Z3I+xQuaZgP1/KyFIPVqqkQgaS4jo=;
        b=cXV29TnqTdbKBTEna2U668OylnWs3RMwrXxD4dgzvQ7CECEELO43IG/ZktFMo0yHtS
         ezRmQmWoxZMmntmxGIj/MJKoAPhYApCDutGOSp23905La4K2HFIYkNe4FQadtraqpiNb
         G9HTDJbTj8QWpQleuk801yAK9ztq4ezpQFvm3vhqtkajF6coTVWAED+8FZYS/dCOo09m
         xyspLXoSWHpvBU36WBNI4yYtSggJji6lW95y0drSJO8tx6y2b9vU36nZodx2fNh4ftDr
         eHKs1hToIb5VOyA5pTdTF5tUBmzvck2frhp+COo3yPqtRZylR7AzT8/oUrVe1SXZiFHF
         JxVg==
X-Gm-Message-State: APjAAAXHtmXT4Qk2Se6vEN2HshwsEzx71r3+tXuyNjnWb46iH47Ae5hP
        I9cwGMH6N444GOoASX9psxiAHV9D7Dav9YpIeqw=
X-Google-Smtp-Source: APXvYqwZ+kIqISCrdx8k6xacS8ejblWciEXG/1RFV79IDQVnyDp8e3TQaauEiR5HjZNwE41PHahs2PWBDrS+oqRQ8z0=
X-Received: by 2002:aca:1011:: with SMTP id 17mr5031032oiq.72.1579652203324;
 Tue, 21 Jan 2020 16:16:43 -0800 (PST)
MIME-Version: 1.0
References: <20200118194841.439036-1-marijns95@gmail.com> <CABBYNZ+LW-Lp3q9jOjVwFktuLsKajTrmOpUYmQ5SqCUPrGQ7BA@mail.gmail.com>
In-Reply-To: <CABBYNZ+LW-Lp3q9jOjVwFktuLsKajTrmOpUYmQ5SqCUPrGQ7BA@mail.gmail.com>
From:   Marijn <marijns95@gmail.com>
Date:   Wed, 22 Jan 2020 01:16:32 +0100
Message-ID: <CANX-K3vEopmiSATkZyDS38CJ0_uTWd0ArKdyJi1UYQRCN2pELQ@mail.gmail.com>
Subject: Re: [BlueZ PATCH] audio: avrcp: Ignore peer RT supported_events when
 being the RT.
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Tue, 21 Jan 2020 at 23:48, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Marijn,
>
> On Sat, Jan 18, 2020 at 11:52 AM Marijn Suijten <marijns95@gmail.com> wrote:
> >
> > From: Marijn Suijten <marijns95@gmail.com>
> >
> > Remove the check of a received event against supported_events in
> > avrcp_handle_register_notification, which is only called when BlueZ is
> > the RT even though supported_events is only valid when BlueZ is the TG.
> >
> > supported_events is assigned in target_init with events that the
> > corresponding RT on the other side of the Bluetooth connection supports,
> > to ensure the local TG will never report anything unexpected in
> > avrcp_handle_get_capabilities. This value is specific to what the target
> > should support to be compatible with the peer RT, but a locally running
> > RT has nothing to do with the external device being the RT.
> >
> > This addresses the case where Absolute Volume notification registrations
> > are rejected when audio is played from an Android device to a computer
> > running BlueZ. The Android BT stack report an RT of version 1.3 [1]
> > which does not include Absolute Volume support. The RT on the Android
> > device is not involved in such a playback session, instead the computer
> > is the RT and the Android device the TG.
> >
> > This has been tested by disabling registration of the RT service in
> > Android, to make the device a "pure" media player that cannot receive
> > audio: target_init does not get called and supported_events stays 0
> > which would have caused any notification registration to be rejected in
> > the above case.
>
> I assume you have a typo on RT instead of CT, is that right? From
> qualification point of view anything initiated by a device is
> considered a CT role, much like GATT server and client roles, so we
> may have instances where both CT and TG are supported simultaneously.

I have indeed missed this distinction entirely. Looking at the AVRCP
spec (1.6) section 2.2.1 "Roles" the CT/TG naming indeed denotes
initiator and receiver, respectively. I blindly assumed these matched
the roles of "target" and "remote"/"controller" following the naming
of the profiles. Knowing this makes reading section 6.18 much more
clear; the sink is assumed to be the TG only in the specific case of
the SetAbsoluteVolume call, for example. I will update the commit to
mention "target" and "controller" instead (like the rest of the code),
hopefully finding and clearing up the typo that way.

>
> > [1]: https://android.googlesource.com/platform/system/bt/+/android-10.0.0_r25/bta/av/bta_av_main.cc#712
> > ---
> > Hi,
> >
> > I have a separate patch lying around that - instead of removing
> > supported_events - splits it up in two variables; one for the target and
> > another for the controller. Let me know if this extra safety is desired.
> >
> > According to the AVRCP 1.3 specification GetCapabilities is mandatory,
> > which I have included in that patch. However the documentation also
> > mentions that this function is only supposed to be called by the CT
> > meaning that the call in target_init (introduced in 27efc30f0) is not
> > valid. What is your view on this?
> > Unfortunately even the small pair of in-ears I have lying around report
> > AVRCP TG functionality while they are not nearly capable of being a
> > target/media-source, so I have not been able to confirm how a pure RT
> > device would respond in such case.
>
> As I mentioned above the qualification tests requires both TG and CT
> for things like absolute volume to work as notifications for volume
> changes originate from the device rendering the audio/sink not the
> source, so the typical association of sink/CT, source/TG is no longer
> true and before you ask, yes we have some code and comments leading to
> that assumption which we should probably fix at some point so I guess
> having the supported events in 2 is probably a good idea, though
> notice that it should probably be local and remote events since event
> afaik are always originated from the TG role.

If there is any code it must be very minor, as I have based the
sink/CT, source/TG association solely on the AVRCP documentation. I do
see it in the creation of of sdp records though, is that what you're
hinting at?
According to the documentation it is likely the CT requests a
notification, and the TG completes it in due time. But because both
the controller and the target can fulfill the CT and TG role (keeping
in mind predefined directionality in for example SetAbsoluteVolume), I
don't think that distinction should make it into my patch. Instead,
the separation will be solely based on what the local/peer controller
and target support. The issue still holds that BlueZ in controller
role incorrectly rejects notification registrations, because
supported_events is merely based on the peer controller version.
Splitting supported events seems the way forward: I'll improve the
patch and resubmit it, then we can decide. Likewise, should
registered_events be separated across the target and controller role
too? Or is it unexpected to have a target _and_ controller running on
both devices, simultaneously (this would imply two transports, in both
directions, playing back media)?

Locally supported events seem hard to quantify as BlueZ can send out
events for anything that's physically in the code at any point
(supposedly anything available according to AVRCP_{CT,TG}_VERSION),
unless we want to prevent the CT from requesting notifications it
couldn't realistically support given its profile version.

>
> >
> > - Marijn Suijten
> >
> >  profiles/audio/avrcp.c | 4 ----
> >  1 file changed, 4 deletions(-)
> >
> > diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> > index 7fb8af608..820494d2a 100644
> > --- a/profiles/audio/avrcp.c
> > +++ b/profiles/audio/avrcp.c
> > @@ -1529,10 +1529,6 @@ static uint8_t avrcp_handle_register_notification(struct avrcp *session,
> >         if (len != 5)
> >                 goto err;
> >
> > -       /* Check if event is supported otherwise reject */
> > -       if (!(session->supported_events & (1 << pdu->params[0])))
> > -               goto err;
>
> When receiving a request our role is TG so I don't see why we would
> skip this check, a better way to fix this would be to add the
> separated supported events like discussed above so we have the roles
> operating independent as they should be.

I will update this to take into account the target/controller role at
the time the call is made. Is there any way to figure out what role
the TG is fulfilling? set_volume in transport.c for example bases that
on whether the transport has source_watch set, meaning the device is
the sink playing back audio from a peer device which is the source.

>
> >         switch (pdu->params[0]) {
> >         case AVRCP_EVENT_STATUS_CHANGED:
> >                 len = 2;
> > --
> > 2.25.0
> >
>
>
> --
> Luiz Augusto von Dentz

- Marijn
