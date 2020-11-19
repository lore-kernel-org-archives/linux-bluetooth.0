Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3907C6379F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Nov 2020 23:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DB0F22240
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Nov 2020 23:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KkE+4W39"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgKSX4X (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Nov 2020 18:56:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727098AbgKSX4X (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Nov 2020 18:56:23 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060EBC0613D4
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2020 15:56:23 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id n11so7130316ota.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2020 15:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LKwvJrSAqDwJVWrXdQ2j2YKSRZdnkIRpsnYMAkNM7Kg=;
        b=KkE+4W39DDOxozFRy6Nk4k+fmZjXCgxFnSeLm1gfEHfIzQnFCfk3WvMIbOa+DGN5xO
         BQq2UMiKf7RNIhkBO6e7kYyB34mpaqUkISxVM0z5hDWebGDb7P6M7aYB/eu3uTGMN1Fs
         FyY80PwtOw6/HX90wrCoT0MnoN1fhquvl+xeCpTgxi0gjQUZicneW9S091WX1HUj8TL4
         B8giKbSg+pEZFJPhmY9w89aMwcM0iISAjF8ZOZMc4ct8fu+v9mZVqE+VRZtqBy41BLKW
         vjJJf7EkX/TIAJkJckKzCiIzOAkEmYW1ieRJxp3uCsEzW/0GEl+YIxfkL7wmYL3DDrNI
         4CZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LKwvJrSAqDwJVWrXdQ2j2YKSRZdnkIRpsnYMAkNM7Kg=;
        b=bhBB4ZxBCqqPgxCdb9FtGVXvSnPrg/O9x7Oldi0E84eFwYKjIxjs310q/cyo4zt6vE
         C4LDrAw2DHkYL4idhUZWHiBIlNqgJrCFzrdzFsON1fU5DN2xlegskbbiyJdKSAWSEVvA
         8LHotItZRyXwHbnJnmcrK+UxFeHuNMIwQiz0SR9jCwzN3/uOCwf0rdSjN3sy5ljvUYFI
         P0xAM1gyrj0RAFxv6NBnCS8UwEjkhgzu3TopOXDyT+WaZDlc9RmwLaP5j6bPDr1vBA/s
         jZBbCusXzBLjcKA04qxIAwsXm+BXqYTa2wZ/2t5kJSS7acncRIvvqSPz1HD6ZGCmyzyi
         tSeA==
X-Gm-Message-State: AOAM531e4jKcoPYJG02k8RXoYTnFeQvBFI9H7lDsPRzHoNrdjXeRatxy
        yCjpwoBRQJWA8j88mI9V7nrP0fREJwlhXjUES4IAhVJ1zbw=
X-Google-Smtp-Source: ABdhPJySnek7pgDm4BsFu4dsEmkUevLc7TbEWjfgQrikVxK7WFRNPzbUbCeahWzlURZpivlS4SNWDafJNq13pM/+3IA=
X-Received: by 2002:a9d:4b81:: with SMTP id k1mr12285314otf.371.1605830182229;
 Thu, 19 Nov 2020 15:56:22 -0800 (PST)
MIME-Version: 1.0
References: <20201111011745.2016-1-sonnysasaka@chromium.org>
 <20201111011745.2016-7-sonnysasaka@chromium.org> <aa1c080e8a7813299e6a093608211684e074e427.camel@hadess.net>
 <CAO271m=O3hyS6Pp4fQ1pnsir7wYbLFwDm7f-a5yd0o4NTUUewA@mail.gmail.com>
 <CABBYNZJjgdjsDXOQk=v4wJ7PLyHr-u2w6d+jgLKgwxV9J5OYdQ@mail.gmail.com> <CAO271m=L8yoD0JO70kVJqmH0+gBkCL=_dtpTKNDZ7ei5jfPz6w@mail.gmail.com>
In-Reply-To: <CAO271m=L8yoD0JO70kVJqmH0+gBkCL=_dtpTKNDZ7ei5jfPz6w@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 19 Nov 2020 15:56:11 -0800
Message-ID: <CABBYNZ+FBdCzqqcOuaKou-A5S_QCZsgHvj0ygyZP3L3v90L_8A@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 7/7] battery: Implement Battery Provider API
To:     Sonny Sasaka <sonnysasaka@chromium.org>
Cc:     Bastien Nocera <hadess@hadess.net>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

On Thu, Nov 19, 2020 at 12:15 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>
> Hi Luiz,
>
>
> On Tue, Nov 17, 2020 at 2:26 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Sonny,
> >
> > On Tue, Nov 17, 2020 at 2:20 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> > >
> > > Hi Bastien,
> > >
> > > Thank you for the feedback. Please find my answers below.
> > >
> > > On Tue, Nov 17, 2020 at 2:51 AM Bastien Nocera <hadess@hadess.net> wrote:
> > > >
> > > > Hey Sonny,
> > > >
> > > > On Tue, 2020-11-10 at 17:17 -0800, Sonny Sasaka wrote:
> > > > > This patch implements the BatteryProvider1 and
> > > > > BatteryProviderManager1
> > > > > API. This is a means for external clients to feed battery information
> > > > > to
> > > > > BlueZ if they handle some profile and can decode battery reporting.
> > > > >
> > > > > The battery information is then exposed externally via the existing
> > > > > Battery1 interface. UI components can consume this API to display
> > > > > Bluetooth peripherals' battery via a unified BlueZ API.
> > > >
> > > > Was this patch reviewed for potential security problems? From the top
> > > > of my head, the possible problems would be:
> > > > - I don't see any filters on which user could register battery
> > > > providers, so on a multi user system, you could have a user logged in
> > > > via SSH squatting all the battery providers, while the user "at the
> > > > console" can't have their own providers. Also, what happens if the user
> > > > at the console changes (fast user switching)?
> > > > - It looks like battery providers don't check for paired, trusted or
> > > > even connected devices, so I would be able to create nearly unbound
> > > > number of battery providers depending on how big the cache for "seen"
> > > > devices is.
> > > For security, the API can be access-limited at D-Bus level using D-Bus
> > > configuration files. For example, we can let only trusted UNIX users
> > > as the callers for this API. This D-Bus config file would be
> > > distribution-specific. In Chrome OS, for example, only the "audio" and
> > > "power" users are allowed to call this API. This way we can make sure
> > > that the callers do not abuse the API for denial-of-service kind of
> > > attack.
> >
> > I guess there is still some the risk of conflicts even with the use of
> > D-Bus policy blocking roge applications, there could still be multiple
> > entities providing the battery status from the same source, which is
> > why I suggested we couple the Battery1 with the Profile1, so only the
> > entity that has registered to handle let say HFP can provide a battery
> > status and we automatically deduce the source is from HFP.
>
> These are two different issues. The issue with bad applications can be
> overcome with D-Bus policy. The issue with multiple providers is
> inherent: we have to have a duplicate resolution because one device
> may report battery from different sources, e.g. via HFP and A2DP at
> the same time. The latter case is rare in practice but still possible,
> so I propose the simplest duplication resolution which is accept the
> first provider registered (of that specific device) and ignore the
> rest.
>
> Coupling Battery1 with Profile1 will limit the flexibility of this
> feature. For example, some speakers report battery status via a
> separate LE channel (GATT). If we require Battery provider to be also
> a registered Profile, we won't be able to support these cases since
> GATT clients do not register any profile.

Actually it is a good policy to provide GattProfile1 if you are
interested in enabling auto-connect, which I suppose most third-party
services would like to enable:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/gatt-api.txt#n367

Note that we are doing to avoid complicate conflict resolution since
profiles by design can only be registered once that means Battery
sources will also be limited to one per profile, Im fine if you choose
not to have this integration in the first version .

>
> >
> > > >
> > > > Given that the interface between upower and bluez is supposedly
> > > > trusted, it might be good to ensure that there are no fuzzing problems
> > > > on the bluez API side that could translate to causing problems in
> > > > upower itself.
> > > Could you give an example of what potential problems of upower can be
> > > caused by communicating with BlueZ through this API?
> > >
> > > >
> > > > I didn't review the code in depth, but, having written this mechanism
> > > > for Bluetooth battery reporting, I think that this is the right way to
> > > > go to allow daemons like pulseaudio to report battery status.
> > > >
> > > > Cheers
> > > >
> >
> >
> >
> > --
> > Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
