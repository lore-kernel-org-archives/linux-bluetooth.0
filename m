Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA26EC433DB
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Dec 2020 16:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FE052173E
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Dec 2020 16:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbgLZQ3S (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 26 Dec 2020 11:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgLZQ3S (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 26 Dec 2020 11:29:18 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF05C061757
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Dec 2020 08:28:37 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id s75so7361308oih.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Dec 2020 08:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=rUyKawughzUmB069Bb+tIFB7ZnVQz8bUjkTnUAY93Ao=;
        b=p6G6Es5BT2uS0YdKwrcDI+W4GqJTK7gcK7LfUdLc60NT379SQLiPfA9zRMYd0L0pzC
         vX/jVRJwh/jgKsaaXA8KU3oWY+XRy+tMsjrxg4B+t575875KmSUW64aTKlJAEQHWLYT+
         3XdN5fr5HUB39KgwgaqO4ucmfPhJo1Gh8Rk7O36DHEhcyA9GXTObeRXgDHl4gau6yyqw
         Tgq4J6LU1kr+coaiLMZJhBSY9Dw40JIyu9yFefrb3sPceoZATNyUlE9vZL0MWQky5yS1
         6zGLjJUw7syQ+KA+Lvc9GzsQRYinO0IArsXS6UOJY5deVFAV/oH/3pBFEQDP+A3awspQ
         En+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=rUyKawughzUmB069Bb+tIFB7ZnVQz8bUjkTnUAY93Ao=;
        b=e9NGz/sfCSPVcLg96h/YXwfu5rwOfZ6MtFNEB0IoHXqhbvfriWBc37aTTTggBgJtXk
         DgM063N7ZirLx6rv3dLbuY3XAUcOD8ivYnpMOHTXvHH8RX5aNQiGGq/PIkIPEpw0EaZP
         Q8f5h933CZ2AsEJBDnHtRTquSoinMr1uNIcqzzSL5XjLwlhJl+/wovQimxeeiHN2qgSq
         KaxRmHGizaPoxzR8DrogjCClVYmTfMguTwgI5uYDVaXkLKpzxXew44ib9Sp6e1pA5gRK
         r80fNHjEg4VLmlvD+NBN5EU6FKsV0gpchUsmssU/eb0jrsHw4jKVeqz/BQ90Zf6IRw6o
         fvTA==
X-Gm-Message-State: AOAM533zWMkSniv1b68oJepth9180tiEVCNOHiy3wI5+EJoOD5mkYnQj
        Rw6PYZn7+RvtUnTsCo5zXfw4MRdvj61R4Ned/7GJGmPy
X-Google-Smtp-Source: ABdhPJxXeQHoXX5vWoukq9otg0A7k2HQu2amzKfP64h30e1VQ3W644D8Q4sXMKLbNdUFSX5lHpKZw6nLXcUcHR9lpv8=
X-Received: by 2002:aca:f48c:: with SMTP id s134mr7659108oih.150.1609000115405;
 Sat, 26 Dec 2020 08:28:35 -0800 (PST)
MIME-Version: 1.0
References: <CAG17S_Oy_N_YPo6x5pmZ05p4MqH_gDUrRS0TR3ydQVG9BvmYEw@mail.gmail.com>
 <CAAu3APaGmCAA8JGKgFcg4wzJLT4y05BhvYu6uA05COdvEyauow@mail.gmail.com> <CAG17S_Mq+fMy6gGU-dXaNpsNkbqP47YskYJV7SE7mNUtbz=CYg@mail.gmail.com>
In-Reply-To: <CAG17S_Mq+fMy6gGU-dXaNpsNkbqP47YskYJV7SE7mNUtbz=CYg@mail.gmail.com>
From:   KeithG <ys3al35l@gmail.com>
Date:   Sat, 26 Dec 2020 10:28:24 -0600
Message-ID: <CAG17S_MJCuMaqX7uczZBLXn9N-QiDhL-0ASAhMNN-aubbHE8Jw@mail.gmail.com>
Subject: Re: Request for help with btmgmt
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In further reading, it may be that 'bluetoothctl info' should show all
the information about the BT bus but does not? Is that possible?
If I connect a keyboard, 'bluetoothctl info' shows that keyboard. If I
then connect a phone, 'btmgmt con' shows both connected, but
'bluetoothctl info' only shows the keyboard. This is why I was using
btmgmt. I have looked through the code for BlueZ and it is very
complicated. I was trying to figure out why btmgmt does not report
when run 'non interactively' and have given up. I will start
researching dbus to see if I can work with it that way.

Keith


On Fri, Dec 25, 2020 at 2:32 PM KeithG <ys3al35l@gmail.com> wrote:
>
> Barry,
>
> Thanks for the help. I will look into it. I fear it may be a bit 'up
> hill' for me.
>
> Can you shed any light as to why:
> 1) bluetoothctl does not have a command to list the currently connected devices?
> 2) why btmgmt cannot be run except from the command line? Not even
> 'btmgmt info' can be run from a script. If it runs, I cannot tell as
> no output is ever generated and no error is ever listed in the
> journal.
>
> Keith
>
> On Wed, Dec 23, 2020 at 1:53 AM Barry Byford <31baz66@gmail.com> wrote:
> >
> > Hello Keith,
> >
> > On Wed, 23 Dec 2020 at 00:34, KeithG <ys3al35l@gmail.com> wrote:
> > >
> > > I am developing a RPi based audio player. We are trying to add
> > > bluetooth capability to this player. We use alsa and not pulse-audio,
> > > so we need a bit more granular info to get it to run. I have written a
> > > script which is designed to be triggered by udev when a BT device is
> > > added or removed. This script will then use bluetoothctl to get the
> > > capabilities of the device and also add or remove it from a dynamic
> > > database list of MACs in redis. I have a simple script working as I
> > > want from the cli. The key command I am using is 'btmgmt con' which is
> > > the only command I have found that tells me what MACs are currently
> > > connected. I can run this command from the command line as root. I can
> > > set the setuid bit of btmgmt and also get it to run as a user (http in
> > > this case). I cannot, ever, get this command to run when triggered
> > > from udev. I get no response and no error.
> > >
> > > 1) Why is this particular command (query attached BT MACs) not part of
> > > bluetoothctl?  Is there a security issue?
> > > 2) Why can I not run 'btmgmt con' in a script (bash or php) triggered
> > > by udev when the device is added or removed?
> > > 3) is there a 'better way' for me to know what device MAC addresses
> > > are attached? I have not found another simple way to get this info.
> > >
> > > What I am doing in the script is: if an audio source is attached, I
> > > want to run a bluealsa-aplay service. When an audio sink is attached,
> > > I want to re-set my audio output to the bluealsa device. If it is not
> > > an audio device, I do not care, but do keep track of what is attached
> > > in my database so that the next time the script runs that it is not
> > > queried and is 'known'.
> > >
> > > Thanks for the help.
> > >
> > > Keith
> >
> > I would suggest that the D-Bus API would be a more appropriate way to
> > get the information you want.
> >
> > The "get managed objects" functionality is a good way to iterate
> > through all the devices that BlueZ knows about.
> > There are examples at:
> > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/test/bluezutils.py
> > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/test/list-devices
> >
> > The D-Bus API also allows your code to execute callbacks when a device
> > is added or its connection state changes.
> > This is done with the InterfacesAdded and PropertiesChanged signals.
> >
> > If you are going to use Python I would suggest the
> > https://pypi.org/project/pydbus/ library is a more "Pythonic" set of
> > D-Bus bindings.
> >
> > The API is documented at:
> > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc
> >
> > Regards,
> > Barry
