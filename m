Return-Path: <SRS0=SAxJ=4M=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB0EC38BF9
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Feb 2020 21:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D2DA218AC
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Feb 2020 21:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=adafruit.com header.i=@adafruit.com header.b="LYkE8NUy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbgBXVvr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Feb 2020 16:51:47 -0500
Received: from mail-ed1-f52.google.com ([209.85.208.52]:35447 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgBXVvr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Feb 2020 16:51:47 -0500
Received: by mail-ed1-f52.google.com with SMTP id c7so13757178edu.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Feb 2020 13:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=adafruit.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/2KzdAWi8abyc6w9T5bYnyauAetMCW3/Nm0e3bg2dak=;
        b=LYkE8NUy4QIBmxkl8YiudmoC8zmD2x/wUzB4HxU90gX1Y22cwI6NjZGVAN0ayTbUAv
         MJzTmD7gCF4RA8MFGJSwWVk5POkbz955ndVNGo31fQunBnPy1atXkqC14j6CX2/CjPf7
         +9BfXcryH13LHFabIkarMZHksrpCyV4g+QBi4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/2KzdAWi8abyc6w9T5bYnyauAetMCW3/Nm0e3bg2dak=;
        b=E47TRsyB2MDOTqYvu8oNM88jBGHGBFXC2GSKFQueHnvWLyi3LFU3vXPuG4BdULAcN8
         EYPzTJSY4EZMZyDmyPcQpnnhUqYWm9P0cElKdwEI5OoufvQi5WnlavBjL7cmOTAQm4V5
         23atFQ7WhunTxkliMtL4P+bykRW3c1efSDRidy1l9/5hE/POCjYMEhzXQKP7TzajI65R
         +EKRz2dl9m5OdqZTNbJhKrD9jI0XvYWsx6GQ//KMsq0eIMUeZackE7xzHZFiyowFY014
         xNYnWwJqDBrkFUC/xykURnG+bAMo++5/bhDnW0iBNQcYEuWBgBHA8v7xarop+mApMVn6
         S6rw==
X-Gm-Message-State: APjAAAXoKB7gK1ODbHtpUe7OUoBvzei2i7rG1sATjMGwAspUPPiNqkqC
        k9lNPZANw3oF0sBwjVfFFQ8zZ1NfTQu/wSk0CCVMWA==
X-Google-Smtp-Source: APXvYqzIn48f4d2LhK/MaE1MvbKFWub91wpYWZOSLW9UXVXLXkVSW3t0TjvGMdL01ceD8pkajXw7akJbrQOjB8i4WIk=
X-Received: by 2002:a17:906:e293:: with SMTP id gg19mr48369047ejb.332.1582581104756;
 Mon, 24 Feb 2020 13:51:44 -0800 (PST)
MIME-Version: 1.0
References: <CAJ_gUqbKKxt15OhizRN_x4Dy-RvyuEUH0Bwcah_KEcMsQakQoA@mail.gmail.com>
 <CABBYNZKG6hFMgy7ifuEW2kxyQYd=Gw0cWefjBy-fdWS00OWL+g@mail.gmail.com>
In-Reply-To: <CABBYNZKG6hFMgy7ifuEW2kxyQYd=Gw0cWefjBy-fdWS00OWL+g@mail.gmail.com>
From:   Scott Shawcroft <scott@adafruit.com>
Date:   Mon, 24 Feb 2020 13:51:33 -0800
Message-ID: <CAJ_gUqZ5rsV55tO5O07fUYxEoJa=CG0gAz5P3hJ-Lb-kYws2rg@mail.gmail.com>
Subject: Re: Adding support for DuplicateData into the kernel
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, Feb 24, 2020 at 10:57 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Scott,
>
> On Thu, Feb 20, 2020 at 8:34 PM Scott Shawcroft <scott@adafruit.com> wrote:
> >
> > Hi!
> >
> > I'm trying to create a bridge between BLE advertisements and the web
> > for sensor data logging. The BLE advertisements use manufacturer data
> > to transmit the sensor data. I'm running on a Raspberry Pi 3b.
> >
> > I've been trying to use the Bluez dbus interface with DuplicateData,
> > trying both true and false, and I never seem to get duplicates back. I
> > dug into it via hcidump and noticed that the scan enable still has
> > filter duplicates set to true regardless. I can only manage to get it
> > set to False when using hcitool.
> >
> > I believe I've tracked the issue down into the kernel here:
> > https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/tree/net/bluetooth/hci_request.c#n858
> > where enabling duplicate filtering is hardcoded. It seems that hcitool
> > side steps this by talking directly to the hci device.
>
> Yep, the kernel code don't actually allow setting the duplicate filter
> unfortunately.
>
> > Could someone confirm I'm on the right track? I'd be willing to plumb
> > the DuplicateData value through to the kernel if someone could help me
> > find the call path down.
>
> In the past Marcel was against turning off the duplicate filtering but
> since we do have a similar setting over D-Bus, though the later shall
> not be confused since tracks duplicates by itself since over D-Bus we
> are doing it to prevent duplicate signals, Im with the opinion that
> DuplicateData could be used to disable duplicate filtering, default
> should be still be enabled though.
>
> --
> Luiz Augusto von Dentz

Thanks for the reply!

I agree the default should be to filter duplicates. I'd love to see
the Dbus setting actually used in the kernel. Did I find the correct
place to change? I'm not sure how it is called from bluez though.
(Maybe through the mgmt API?)

In the meantime I'm using hcidump + hcitool just fine.

Thanks,
Scott
