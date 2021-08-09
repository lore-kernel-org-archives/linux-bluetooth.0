Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114ADC4338F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Aug 2021 20:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E865160EE9
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Aug 2021 20:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234962AbhHIUgZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Aug 2021 16:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233281AbhHIUgY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Aug 2021 16:36:24 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28B0C0613D3
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 Aug 2021 13:36:03 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id a201so31890743ybg.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Aug 2021 13:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ldCuEgAmbjuKrD+sw36As0E4P3wQfku6RkjemjD5tRY=;
        b=RUxwChjpdXbppWDPpOxl7h62QWlj3NXn1kpP5t+pXpMEXjWOQ4WH/weCBgfvuNJuKF
         vR+GxQqtWNsgZjWzMoACfUu2xrkkakhsZ3PmrdKhtvQsNNT8qq+U09m+0t5m8eQrZ7oe
         T7w3SRJMAvuLMiPELXkILe6SRa6YdjXz0e0TjxRDc4ZTmqDpBrs0JQ8mKYgwezFLPerU
         q14qwEO9UoJUWFqJxB37x2dv0QDuxkMuD5pa/86eYDX49cdoLBDKpPDbPjbkgei9w3kj
         PSXGHwz4SUDrLJmTMVAxlUcfQ9buSdI7R4e7iKRju5tSq3iajAB4pZsnDw5mTsJj5Yl4
         JXxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ldCuEgAmbjuKrD+sw36As0E4P3wQfku6RkjemjD5tRY=;
        b=UI7Hu8EBKQ7LFSW4GtMGDfGLPBtrNIJLEvI/R9//+Q71pScNxYS9yyB9XaOM4J4ZqW
         srJUoStsFFLwORNg03qfUX4vZyiMqcFFuTuuByrPfIRxFrJ6lmz82y7l8OrLYUw7CrqK
         xIHRnr1X1N2uTMInc7Z6Ghk10kHdX/IthqaG/g++OUIapugLY9c1uFy2RTceybl/Qawm
         alqvxuVzxCmMQ+X7oflcSDk3jcbsV6z9WrYK+5QPjJXEAr8pd5ztBgCrVoB6v/NnSidF
         DFXKofUVGqGdoS0dgMEjlT8dsjQk8uJe8en2r2tb/HC1XC0G1smYonJPIlNKKpoXhkR7
         64VQ==
X-Gm-Message-State: AOAM532jSKYSsW2Q/wO++U6ymEHsfjCKOsR2yftcKdhbTfHn2dIMqfNX
        WHcyYfkAqGNt+gKnZRGD/4QK5sCEObNUDpDxKyw=
X-Google-Smtp-Source: ABdhPJyTUnqeT909MDyshugOMdWtKYUon7Pa0tWRBJno+rnpFP0B8Y3YEWzRTIbWhHk8PC25RuJFBowSjWw9OCjh8OI=
X-Received: by 2002:a25:bd89:: with SMTP id f9mr27037805ybh.222.1628541362916;
 Mon, 09 Aug 2021 13:36:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210808143555.100258-1-marijn.suijten@somainline.org>
 <CABBYNZK9Hsf3zL7t62hnOkF1hm=UZNvVj_SQDx2Hxj7d0sB0sA@mail.gmail.com> <f681b6d4-2a84-28cd-e779-268b0a5b32eb@somainline.org>
In-Reply-To: <f681b6d4-2a84-28cd-e779-268b0a5b32eb@somainline.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 9 Aug 2021 13:35:51 -0700
Message-ID: <CABBYNZKwSNKyNW9kHW=S5wPeiTzNwL2_Qt5o5F67=wSN23TCpQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] audio/transport: Only store volume when also
 emitting DBus prop change
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marijn,

On Mon, Aug 9, 2021 at 1:26 PM Marijn Suijten
<marijn.suijten@somainline.org> wrote:
>
> Hi Luiz,
>
> On 8/9/21 8:37 PM, Luiz Augusto von Dentz wrote:
> > Hi Marijn,
> >
> > On Sun, Aug 8, 2021 at 7:35 AM Marijn Suijten
> > <marijn.suijten@somainline.org> wrote:
> >>
> >> By setting a2dp->volume early in set_volume() the resulting call to
> >> media_transport_update_volume() when an AVRCP reply is received will
> >> likely see the same volume received (unless the peer rounded it to
> >> another value) and bail on equality, before emitting a DBus property
> >> change.  This results in DBus clients not being made aware of the change
> >> unless the peer is an audio source (that receives a notification about
> >> changed volume, instead of a command to _set_ a new volume), where
> >> set_volume() immediately raises the DBus signal.
> >>
> >> This issue is observed when playing back audio to headphones through an
> >> AbsoluteVolume-enabled audio server like PulseAudio, which does not
> >> receive the "Volume" change (while the peer does change volume) when
> >> setting this property externally using ie. dbus-send.
> >
> > Have you confirmed this works with the likes of PulseAudio, afaik
> > there was some problem when introducing this because the event may
> > cause a double change on the volume so the server needs to be able to
> > handle the volume == local volume, anyway if the headset rounds and
> > the values doesn't match I guess the server will need to be smart
> > enough to not trigger another volume change otherwise it could cause a
> > loop where the server request x but the headset rounds to y over and
> > over.
>
>
> Thank you for your concerns.  I as the author of AVRCP Absolute Volume
> support in PulseAudio made sure to insert these equality checks against
> the last known Absolute Volume value (separate from user-visible volume
> managed by PA), both when Volume is received from the peer:
>
> https://gitlab.freedesktop.org/pulseaudio/pulseaudio/-/blob/1a575bb0a708bc455e977629cb99412551867982/src/modules/bluetooth/bluez5-util.c#L614-621
>
> And when sending a new Volume back:
>
> https://gitlab.freedesktop.org/pulseaudio/pulseaudio/-/blob/1a575bb0a708bc455e977629cb99412551867982/src/modules/bluetooth/bluez5-util.c#L554-557
>
> These together make it impossible to call ".Set" on a value that is
> identical to the last value received through the "PropertiesChanged"
> signal.  It was made this way to prevent round-trips in the first place,
> as receiving a Volume change and applying it to PA's sink/source would
> also trigger the "volume changed" handler.  Even if the peer decides to
> reply with Volume-1 for every request, there will still be no round-trip.
>
> > If the server never reacts if volume != local volume and instead
> > just updates the local volume, which is probably the behavior we want,
> > then I should be safe to apply this change.
> That is exactly what happens because PA cannot distinguish between
> replies to SetAbsoluteVolume and the ABSOLUTE_VOLUME_CHANGED
> notification caused by button presses, when just looking at the Volume
> property.
>
> Finally, I don't know what PipeWire does.  Someone will have to look
> through the codebase and confirm that it performs the same checks, or
> loop in one of the authors in cc to confirm.  Sonny from CrOS is already
> included to make sure this doesn't break anything on their end.
>
> >
> >> ---
> >>   profiles/audio/transport.c | 6 +++---
> >>   1 file changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
> >> index 8248014ae..d158fc97a 100644
> >> --- a/profiles/audio/transport.c
> >> +++ b/profiles/audio/transport.c
> >> @@ -659,14 +659,14 @@ static void set_volume(const GDBusPropertyTable *property,
> >>          if (a2dp->volume == volume)
> >>                  return;
> >>
> >> -       a2dp->volume = volume;
> >> -
> >>          notify = transport->source_watch ? true : false;
> >> -       if (notify)
> >> +       if (notify) {
> >> +               a2dp->volume = volume;
> >>                  g_dbus_emit_property_changed(btd_get_dbus_connection(),
> >>                                                  transport->path,
> >>                                                  MEDIA_TRANSPORT_INTERFACE,
> >>                                                  "Volume");
> >> +       }
> >>
> >>          avrcp_set_volume(transport->device, volume, notify);
> >>          return;
> >> --
> >> 2.32.0

Applied, thanks.

-- 
Luiz Augusto von Dentz
