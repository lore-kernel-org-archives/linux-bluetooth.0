Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292C3C4338F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Aug 2021 18:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0883B60EE7
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Aug 2021 18:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235348AbhHIShd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Aug 2021 14:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235341AbhHIShd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Aug 2021 14:37:33 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D9BC0613D3
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 Aug 2021 11:37:12 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id k65so31263444yba.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Aug 2021 11:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ieoSd/4crk2PMq98uN5Y0JKi9pDF6i8fsVxQWcUkvSk=;
        b=nMGJbI5pmueawz2m/HBFj+jGeQ9VWvS2rUsbolTVvUjcH4YjbACfQvOvvjCIqLjwo6
         /48WO4PZ6vSY1Usr1FOEmEAi6ofzXAbAC4o1TCh1C2na71XxSayvH5JcomofpzjzxcIA
         uQKJNY7USznm+CWfwRrWt5lNeAx2ceI3ac2fYiRfR3cqc5fEnQaEVbIUTb5sUJfm0huM
         ZHb+NEcI5YcwyWf9lv69x1XOw+O9AeekjhXtVJ97MlLGB2Ug7Q0fzObGVgeywN6lt73O
         6ON2nHh9/Wu6hcqar6lGsrZbQoSEjpy8uibNb/fSdRGqpdzxaAKAf7fT/zG62AATjiHQ
         GALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ieoSd/4crk2PMq98uN5Y0JKi9pDF6i8fsVxQWcUkvSk=;
        b=PrbivqJzpOCuYcpp2jYjq11mu6ONtVGSIwJqxaUbTKFoOQXgpDnPr1xUeYtH34Mfwe
         xWtL2vX4OYQE+R5bvNZ6YXQ/jid7ibzX8a048bcdqM6nOzROSssEbx3JJLg5a4yNGZ+8
         p/WUH5dxgrku1G5oZ0MB0qRIL9gIILWc9BYKW4kzDHhOoSzE5YeY3/6O7IIMZKB75LLi
         TJDjmUERKqx8JOYmV6ZNT4XVR8RKvfHZcYzXtUmqm4767GA8hcSdEvDfe1KLFyYtBioG
         GN5DI+HffSIHq+Kiotn21e0235xjEbl4/O6p1pxnKeoRlFGPtOub3k7N3UAMrMZ7UNVo
         09LQ==
X-Gm-Message-State: AOAM53115jngB5R/R0N5g+DyfzOdbUvEnuutJ66+PBeCu0ETpOJoPgVu
        vhEsKwC2ZBmAK7dfFdL2eUUfE/59LI88hqxrAFo=
X-Google-Smtp-Source: ABdhPJyfBu/y3RKaqOiE4S0B3dGDabnP+CG8GkxkZ3nKLMZaag3F+h7gUVmnVRlyYOMh5MDLvSdXNVW2nJh93BhP+DA=
X-Received: by 2002:a25:9b03:: with SMTP id y3mr30738316ybn.264.1628534231754;
 Mon, 09 Aug 2021 11:37:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210808143555.100258-1-marijn.suijten@somainline.org>
In-Reply-To: <20210808143555.100258-1-marijn.suijten@somainline.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 9 Aug 2021 11:37:00 -0700
Message-ID: <CABBYNZK9Hsf3zL7t62hnOkF1hm=UZNvVj_SQDx2Hxj7d0sB0sA@mail.gmail.com>
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

On Sun, Aug 8, 2021 at 7:35 AM Marijn Suijten
<marijn.suijten@somainline.org> wrote:
>
> By setting a2dp->volume early in set_volume() the resulting call to
> media_transport_update_volume() when an AVRCP reply is received will
> likely see the same volume received (unless the peer rounded it to
> another value) and bail on equality, before emitting a DBus property
> change.  This results in DBus clients not being made aware of the change
> unless the peer is an audio source (that receives a notification about
> changed volume, instead of a command to _set_ a new volume), where
> set_volume() immediately raises the DBus signal.
>
> This issue is observed when playing back audio to headphones through an
> AbsoluteVolume-enabled audio server like PulseAudio, which does not
> receive the "Volume" change (while the peer does change volume) when
> setting this property externally using ie. dbus-send.

Have you confirmed this works with the likes of PulseAudio, afaik
there was some problem when introducing this because the event may
cause a double change on the volume so the server needs to be able to
handle the volume == local volume, anyway if the headset rounds and
the values doesn't match I guess the server will need to be smart
enough to not trigger another volume change otherwise it could cause a
loop where the server request x but the headset rounds to y over and
over. If the server never reacts if volume != local volume and instead
just updates the local volume, which is probably the behavior we want,
then I should be safe to apply this change.

> ---
>  profiles/audio/transport.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
> index 8248014ae..d158fc97a 100644
> --- a/profiles/audio/transport.c
> +++ b/profiles/audio/transport.c
> @@ -659,14 +659,14 @@ static void set_volume(const GDBusPropertyTable *property,
>         if (a2dp->volume == volume)
>                 return;
>
> -       a2dp->volume = volume;
> -
>         notify = transport->source_watch ? true : false;
> -       if (notify)
> +       if (notify) {
> +               a2dp->volume = volume;
>                 g_dbus_emit_property_changed(btd_get_dbus_connection(),
>                                                 transport->path,
>                                                 MEDIA_TRANSPORT_INTERFACE,
>                                                 "Volume");
> +       }
>
>         avrcp_set_volume(transport->device, volume, notify);
>         return;
> --
> 2.32.0
>


-- 
Luiz Augusto von Dentz
