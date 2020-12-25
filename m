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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BD9C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Dec 2020 21:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D232022255
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Dec 2020 21:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbgLYUdT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 25 Dec 2020 15:33:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgLYUdT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 25 Dec 2020 15:33:19 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C7BC061757
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Dec 2020 12:32:39 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id d20so4443326otl.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Dec 2020 12:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IjQcd2H3mHQ8IPa8tQ5kDw7zy6LluBe8VOLHE+DMLkU=;
        b=bbj7sqCoGqHKy9byDmc1EbOEpPTtDQ1dtq7jp0usASaBGV99ye5Y4V/BmX7RhHoEyx
         eiTXmNKZl1oiTPV8qoIRlKu9hCGiTb5FYWe/BCPxjt8tblQlt0Ff/BmMTY6+gcGWambo
         +z8m1njb9feUnfP3IvGF0u0Jj+jHXvw/yzm9J4mMqF2JaCngBww7PUDx/snVUhny0yCb
         0M5VUp8ZyuGSiumutVG4IoLb4xqof/wivg6GkcBArnFsYo6RIJWmSX1k82SMvJoKQ3ns
         suQ9BCUIMp6tMyXNTtzv9CYBuKhekZYcen+f7L7noEkhrKHN9UCB9dd/e+Wuo47c4H9A
         u96A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IjQcd2H3mHQ8IPa8tQ5kDw7zy6LluBe8VOLHE+DMLkU=;
        b=iA5N0MTjixv1m7ToF0+yK7uMCwio7p5vk6Kt3/o/aUSIZVfKiejhJ5FZmjgQqgCgzV
         fE84X7N4tJoHL0iY1OA6iRF9jzunHagbRrK6NI7rloKWk06Di6+IXPbDghf5QwP8F7Lb
         Qan5l6sLs8BpbchkPgvk/39HAEwvsaMDX+4MD4onp5i4b4i/xHzwlIzC/S/bbeR9qOFr
         0Rf1e0sDzBEBPcHq6JuIKEEp1fTttA0EXR9DPP8cxjGnhv1mhKHf065tJraPgEI0EGjp
         /KqM2fqt9T6zGAI9cm9fT5c042DM+8w+pkwaaGpr0EfCp2nBKdCs+O3J2IdX8eZDNoMR
         bYJQ==
X-Gm-Message-State: AOAM530N5gt/1hyjiIw9WXiqBgdL4NxFNmwPeoJlxQtOnnNFm1Vcloi8
        nO5XHXHKd7MxRrXRaNoiU1/QcJXMVOWv7wsj/ZdG7Qzs
X-Google-Smtp-Source: ABdhPJzAwDzN9PoqrV9jVmKQIJRan3zA6hnMMWPP8q0jAIdqZ7Gpyb8I3PJD1+g3I/Wng2MTcKnfb1GftwjkhkJmcQk=
X-Received: by 2002:a9d:6255:: with SMTP id i21mr26611022otk.346.1608928357692;
 Fri, 25 Dec 2020 12:32:37 -0800 (PST)
MIME-Version: 1.0
References: <CAG17S_Oy_N_YPo6x5pmZ05p4MqH_gDUrRS0TR3ydQVG9BvmYEw@mail.gmail.com>
 <CAAu3APaGmCAA8JGKgFcg4wzJLT4y05BhvYu6uA05COdvEyauow@mail.gmail.com>
In-Reply-To: <CAAu3APaGmCAA8JGKgFcg4wzJLT4y05BhvYu6uA05COdvEyauow@mail.gmail.com>
From:   KeithG <ys3al35l@gmail.com>
Date:   Fri, 25 Dec 2020 14:32:26 -0600
Message-ID: <CAG17S_Mq+fMy6gGU-dXaNpsNkbqP47YskYJV7SE7mNUtbz=CYg@mail.gmail.com>
Subject: Re: Request for help with btmgmt
To:     Barry Byford <31baz66@gmail.com>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Barry,

Thanks for the help. I will look into it. I fear it may be a bit 'up
hill' for me.

Can you shed any light as to why:
1) bluetoothctl does not have a command to list the currently connected devices?
2) why btmgmt cannot be run except from the command line? Not even
'btmgmt info' can be run from a script. If it runs, I cannot tell as
no output is ever generated and no error is ever listed in the
journal.

Keith

On Wed, Dec 23, 2020 at 1:53 AM Barry Byford <31baz66@gmail.com> wrote:
>
> Hello Keith,
>
> On Wed, 23 Dec 2020 at 00:34, KeithG <ys3al35l@gmail.com> wrote:
> >
> > I am developing a RPi based audio player. We are trying to add
> > bluetooth capability to this player. We use alsa and not pulse-audio,
> > so we need a bit more granular info to get it to run. I have written a
> > script which is designed to be triggered by udev when a BT device is
> > added or removed. This script will then use bluetoothctl to get the
> > capabilities of the device and also add or remove it from a dynamic
> > database list of MACs in redis. I have a simple script working as I
> > want from the cli. The key command I am using is 'btmgmt con' which is
> > the only command I have found that tells me what MACs are currently
> > connected. I can run this command from the command line as root. I can
> > set the setuid bit of btmgmt and also get it to run as a user (http in
> > this case). I cannot, ever, get this command to run when triggered
> > from udev. I get no response and no error.
> >
> > 1) Why is this particular command (query attached BT MACs) not part of
> > bluetoothctl?  Is there a security issue?
> > 2) Why can I not run 'btmgmt con' in a script (bash or php) triggered
> > by udev when the device is added or removed?
> > 3) is there a 'better way' for me to know what device MAC addresses
> > are attached? I have not found another simple way to get this info.
> >
> > What I am doing in the script is: if an audio source is attached, I
> > want to run a bluealsa-aplay service. When an audio sink is attached,
> > I want to re-set my audio output to the bluealsa device. If it is not
> > an audio device, I do not care, but do keep track of what is attached
> > in my database so that the next time the script runs that it is not
> > queried and is 'known'.
> >
> > Thanks for the help.
> >
> > Keith
>
> I would suggest that the D-Bus API would be a more appropriate way to
> get the information you want.
>
> The "get managed objects" functionality is a good way to iterate
> through all the devices that BlueZ knows about.
> There are examples at:
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/test/bluezutils.py
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/test/list-devices
>
> The D-Bus API also allows your code to execute callbacks when a device
> is added or its connection state changes.
> This is done with the InterfacesAdded and PropertiesChanged signals.
>
> If you are going to use Python I would suggest the
> https://pypi.org/project/pydbus/ library is a more "Pythonic" set of
> D-Bus bindings.
>
> The API is documented at:
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc
>
> Regards,
> Barry
