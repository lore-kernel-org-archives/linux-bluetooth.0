Return-Path: <SRS0=PQ2f=6Z=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB02BC47255
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 May 2020 20:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9177F206D5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 May 2020 20:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DaddU6ne"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730938AbgEKUIl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 May 2020 16:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727873AbgEKUIk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 May 2020 16:08:40 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6968C061A0C
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2020 13:08:39 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id o7so16254815oif.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2020 13:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z1SHrHlDW+MWuLmM7/m+qu0/VEJmLCfEEzNNBpOM/1Q=;
        b=DaddU6neE1ujlBznYfV6tO0faLGWBLWfzaScKBEcYqXunJDbh0JxFrn4+6c30Y9ltM
         z3uuJybe99SjLnn+nIn+FEQMgpYfJA2ayaWFUaeI/PvXdlW//KvaOH1ULfVf8unBEPci
         57xxWjvefYbEehIaBDdUU2LO367TH90SZaEO72qdW2ssMgTamLHNhQWPJxxuAPh6aIkG
         N16iTwSzL04vnScxqIDwAsfyPpNHBDF0NRX06rNGbO0Yy5HWSbqRuxI6Awp0J1xbP9ke
         8cJi0NsLFzS4xAVRNmt23v9pCl5M8eErBqESKHzKSK0/NSvUmjYrS32duPeqg13y4Ub/
         JnJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z1SHrHlDW+MWuLmM7/m+qu0/VEJmLCfEEzNNBpOM/1Q=;
        b=aZ7bW3YUhbQ5cQN7DgmYjlkXTw1TOqQ56OYuGPR3Yx3xG5unDS5x66mDOJwWo3gsgQ
         l/n3SBCofvdpIDzBdWLNwVo4YHaU5tod4v6K4ht7TvZrIpIWP5MP76eyI54Gmz+LyCBz
         uBRGD41VIHM7N7RD0u6sxcfcCSYatKmfr/o/j5AM1QoI8/tQ3qQX6ibcWB8zrPLbtTZt
         P0qPG2wgCSioUG4CbFuT+rVxovENgOXMsNEODQYTgJtcfkWA5r9xhNwgzD+JuI5l8wNw
         qh7bp8TGtvYPINdpGrGsHBuHLQkFx6uzKdpcvLtLd6+C5GuCFoGQyc1y/F+2NlDMbGnY
         Zs7Q==
X-Gm-Message-State: AGi0PuZLv7k3LR8woeKGZ73//cYbkqUUlfTVXQu/QN3T298E6X7gRXf4
        QtKbuGm5+7plN2DzUyhi1kaC2i0faI8BWeILBeqjha3d
X-Google-Smtp-Source: APiQypKpQ2DiloEmI+Mi9B8MN3hX0/7x5MaMrTb+Sq+wrNU2G41Ewivy8GFGD3ygpLOQqGhPnDD/6EssyWonISeWYmM=
X-Received: by 2002:aca:b155:: with SMTP id a82mr21729559oif.110.1589227718857;
 Mon, 11 May 2020 13:08:38 -0700 (PDT)
MIME-Version: 1.0
References: <875zd33bsf.fsf@espindo.la>
In-Reply-To: <875zd33bsf.fsf@espindo.la>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 11 May 2020 13:08:27 -0700
Message-ID: <CABBYNZJj-cwY6dOf37GH4Yxi_P41CwRSN7sZ3b-vugACa_i8vw@mail.gmail.com>
Subject: Re: git bluetoothd getting disconnected from dbus
To:     Rafael Avila de Espindola <rafael@espindo.la>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Rafael,

On Sun, May 10, 2020 at 11:11 AM Rafael Avila de Espindola
<rafael@espindo.la> wrote:
>
> I compiled a new version of bluez to try help test an
> issue
> (https://gitlab.freedesktop.org/pulseaudio/pulseaudio/-/issues/880), but
> now bluetoothd is being disconnected from dbus.
>
> This is on a fedora 32, so the dbus is actually
> https://github.com/bus1/dbus-broker.
>
> The bluz revision is 3146b7a0785758be2d4e894d44e99d29c0db983e.
>
> The behavior is that I can start bluetoothd with
>
> $ sudo ./src/bluetoothd -n --debug='*' -f ./src/main.conf
>
> and pulse audio with
>
> $ ./src/pulseaudio -p $(pwd)/src/ --daemonize=no -v -v -v
>
> Everything looks fine until I turn on a bluetooth device that was
> already paired and trusted. As far as I can tell, it connects correctly,
> but then the bluetoothd log shows
>
> May 10 10:18:41 raspberrypi.local bluetoothd[3127]: profiles/audio/transport.c:transport_update_playing() /org/bluez/hci0/dev_EC_81_93_4A_C7_7E/fd0 State=TRANSPORT_STATE_ACTIVE Playing=1
> May 10 10:18:41 raspberrypi.local bluetoothd[3127]: Disconnected from D-Bus. Exiting.

I suspect this is due to fd hand over, I usually have to
SELINUX=disabled to disable SELinux policies when running bluetoothd
from source because it seems there is some policy the prevents fd
passing over D-Bus,  we should probably add this to HACKING if we
confirm that this is in fact SELinux policy.

> I can't quite figure out what is going on, but dbus-monitor around the
> time shows:
>
> signal time=1589131121.073746 sender=org.freedesktop.DBus -> destination=:1.65 serial=4294967295 path=/org/freedesktop/DBus; interface=org.freedesktop.DBus; member=NameLost
>    string "org.bluez"
> signal time=1589131121.073832 sender=org.freedesktop.DBus -> destination=(null destination) serial=4294967295 path=/org/freedesktop/DBus; interface=org.freedesktop.DBus; member=NameOwnerChanged
>    string "org.bluez"
>    string ":1.65"
>    string ""
>
> Which is suspicious. I have attached the full logs starting just before
> the bluetooth speaker is turned on.
>
> What I have checked so far
>
> * I removed the system bluez and pulse audio
> * I checked that ./src/bluetooth.conf has been copied to /etc/dbus-1/system.d/bluetooth.conf
>
> Any suggestions as to where I should look next?
>
> Thanks,
> Rafael
>
>


-- 
Luiz Augusto von Dentz
