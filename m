Return-Path: <SRS0=zBEa=4N=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E234C35DEA
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Feb 2020 01:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27205222C2
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Feb 2020 01:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZX0XaM0O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbgBYBgS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Feb 2020 20:36:18 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:39665 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728011AbgBYBgS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Feb 2020 20:36:18 -0500
Received: by mail-ot1-f42.google.com with SMTP id 77so10637373oty.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Feb 2020 17:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hoUWZFubdZALCd9e8O268DXImCxJAVzZhN7QYxJJNnM=;
        b=ZX0XaM0O2DAGMldSKJ9LhXcEH4yaffI4UVFkzQldJ9BTzyJs6m2yTK5TJ9h/4HQm7D
         bjuYxwyJ75NiuJB4DMYTuUwz70xzgqn07gdbe6Qk9kgRSyRE3HJh6IF8gkLVQTYv+eJH
         4EaCSFzBu30USnVjhokf+Vlyj4KxrvzvyHiySDAeVHtSfChKsoy8uSThe0lkjqoY83SB
         eyJE2vm723BABLZ4hW27O9Nd45XGOXHEOd2yoOH+QXn5k2ZRAP5XkW0nbLs4/6HOkocq
         qgzKSG8f3r1DWzqfVnnIm/EJX3cYe9WgKd1F1haImEi81iY1xMGa8/Edxg1FgnaU5qNi
         Q9UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hoUWZFubdZALCd9e8O268DXImCxJAVzZhN7QYxJJNnM=;
        b=R3M8G9G0IkNScN1DHHzC1EYtRf85scO5esrvxFGaoH6u4eu60yQW5oXovqCAzmw2p/
         /DnJiqUN1+9CN/7tl1JcwFMO/1VeFw909I/ZpzK7KsSs1saR8eyCQcYhn3Rb6YDn+Uw7
         5V1IAYnQzzqVV/aiCqWWXZY7jaequY9H4o07wUnC+T2L4m1YOzb8BPgnJ95E81GoBtRy
         w8+ALjTA1FvcEz71YOzsCVih3SeFaNEIiP/XDIx3UCi2h6ZLkAeKLRKc/h9Vrj3jI3kH
         ez2Of0dm1L/g8/hT72aELv7ke0nAugbRNcyISXRItJmEWeHC0kmjjOp/lCn6rxFTc7xi
         2Ifg==
X-Gm-Message-State: APjAAAVa4QAs9rmqUbhDfU2w9FN3WzCNTzdA1ihVtOHu0WRgipd0FKDk
        cE4UuCFSjkbqyPMOCZ47qXjqY89J1/0cibvXqck=
X-Google-Smtp-Source: APXvYqx5UtHf1ca0eOcm4/+pj1xniOa2rCOqb9xUoBSvVo+7j2RgSEm7GbfUFcupbN8IP7PM7E1ELCwdoQU20M4kgyY=
X-Received: by 2002:a9d:58cb:: with SMTP id s11mr43758217oth.55.1582594577205;
 Mon, 24 Feb 2020 17:36:17 -0800 (PST)
MIME-Version: 1.0
References: <CAD3n0hm61cRPK3=Scf02y3Y3aMJ66eCC5nwFh40Y9kfLBWk-tw@mail.gmail.com>
 <CAAu3APZ4WqFd=61eUfbC8biTbygWW4k2Te3De38B2+maYoBePw@mail.gmail.com>
 <CAD3n0hnJkmXGjiei0-u=GBh0xoGb4N7tkuBh_uSvsuT7bAhXLA@mail.gmail.com>
 <CAAu3APbWouHkguPG3_FQmxPY=6q6rzmr_CbOqY2_0a0RzC++XQ@mail.gmail.com>
 <CAD3n0hnWk0rULy+RJNTAujqY5vtTR=zvoB8233rtLSGc3R-9Pw@mail.gmail.com> <CABBYNZJn3-xBUQ8h_akoKAzm4AT1COjAFLhMhg6V=VnjOZVTvQ@mail.gmail.com>
In-Reply-To: <CABBYNZJn3-xBUQ8h_akoKAzm4AT1COjAFLhMhg6V=VnjOZVTvQ@mail.gmail.com>
From:   chris baker <chrisbkr2020@gmail.com>
Date:   Mon, 24 Feb 2020 17:36:07 -0800
Message-ID: <CAD3n0h=A9UhCd+Aux=GLdQKWPJUma4=eYfV7xUb0tJHgnxUA0A@mail.gmail.com>
Subject: Re: Bluez blotoothctl scan vs hcitool scan
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Barry Byford <31baz66@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, Feb 24, 2020 at 4:33 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Chris,
>
> On Mon, Feb 24, 2020 at 1:56 PM chris baker <chrisbkr2020@gmail.com> wrote:
> >
> > On Mon, Feb 24, 2020 at 9:13 AM Barry Byford <31baz66@gmail.com> wrote:
> > >
> > > If the DBus API is not cutting it for you then using the MGMT API
> > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/mgmt-api.txt
> > > is what has been recommended in the past:
> > > https://www.spinics.net/lists/linux-bluetooth/msg68959.html
> > >
> > > On Mon, 24 Feb 2020 at 16:37, chris baker <chrisbkr2020@gmail.com> wrote:
> > > >
> > > > On Mon, Feb 24, 2020 at 6:08 AM Barry Byford <31baz66@gmail.com> wrote:
> > > > >
> > > > > Hi Chris,
> > > > >
> > > > > On Mon, 24 Feb 2020 at 10:12, chris baker <chrisbkr2020@gmail.com> wrote:
> > > > > >
> > > > >
> > > > > > So my question is, is there a way to get those missing advertisements
> > > > > > through the dbus api, possibly some additional setting somewhere?
> > > > >
> > > > > Duplicates are disabled by default with the DBus API. This can be
> > > > > controlled with the DuplicateData setting:
> > > > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/adapter-api.txt#n107
> > > > >
> > > > > Regards,
> > > > > Barry
> > > >
> > > >
> > > > My apologies, I guess I wasn't clear (long post) but, I turned
> > > > duplicate data on when using the bluetoothctl command (via the "scan"
> > > > submenu) and also used the flag, "hcitool lescan --duplicates", when
> > > > running the hcitool command. So both scans should have included any
> > > > duplicates (unless I've misunderstood something). Additionally, none
> > > > of the missing packets were duplicates (again, unless I'm
> > > > misunderstanding what "duplicates" means). each packet had a unique
> > > > sequence numbers as well as the button data field toggling.
> >
> > Great, thank you. I'll look into the MGMT api in the coming days. That
> > said, is it a problem to use both api's (MGMT/DBus) concurrently from
> > the same app? My application supports both connected BLE sensors as
> > well as BLE beacon type sensors. If possible I can handle them in two
> > different threads, but the DBus thread for connected sensors would
> > still occasionally need to scan for new sensors (using the DBus
> > discovery call) and would still need to get characteristic changed
> > callbacks as well.
>
> Have a look at the other thread subject: Adding support for
> DuplicateData into the kernel
>
> We are discussing adding support to disable duplicate via MGMT since
> DuplicateData does not currently remove it but we might want to change
> that, or at least have some alternative API to do that. We could for
> example have a socket that enables a more direct access to the
> advertisments, that way protocol that work over advertisement would
> have a way to do this, in fact this might be better for things like
> mesh so it can coexist with bluetoothd.
>
> > Out of curiosity though, is the behavior I'm seeing normal? Or is the
> > sensor doing something improper possibly? Seeing as the packets aren't
> > duplicates why would they be filtered (or are they just not being
> > received to begin with for some reason)? The 11 second interval seems
> > kind of strange. Anyway, thanks again for the help! Chris
>
>
>
> --
> Luiz Augusto von Dentz


Thanks Luiz, I don't want to sound dense, and I really appreciate you
and Barry's help, but these aren't duplicate packets (unless, again,
I'm misunderstanding the term). Each packet payload is completely
unique. I'll have a look at the other thread for sure, but I'm really
just trying to understand if the missing packets I identified in the
trace should be there (in the DBus/bluetoothctl trace) or if there's a
reason they were excluded. Again, they weren't duplicates and I'm
reasonably sure I had the duplicate data flags set correctly each
time. Also, whatever is going on is not transient, I can duplicate it
with the senor I'm testing every time (both in my app or via
bluetoothctl). More important for sure is to find a work-around
(hopefully the MGMT api Barry pointed me to) but still just curious
why these packets are getting dropped/filtered... Anyway, thanks again
to you both!
