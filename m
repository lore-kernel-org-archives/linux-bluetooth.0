Return-Path: <SRS0=7kT9=QA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E7CC282C3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Jan 2019 15:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B51721872
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Jan 2019 15:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tGBR4HM5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbfAXPHe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Jan 2019 10:07:34 -0500
Received: from mail-pg1-f180.google.com ([209.85.215.180]:37649 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727755AbfAXPHe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Jan 2019 10:07:34 -0500
Received: by mail-pg1-f180.google.com with SMTP id c25so2781122pgb.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Jan 2019 07:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8He5aJOawlVwF+Rbc6HeoRcT9c4DstVdG8eXEMUaRag=;
        b=tGBR4HM55lRDkp+GjlIqOmlf3yUut6FKcBV5N9mL4HnsJY2+KADaqwkduLKP4o8QbG
         HykYufWR4LSNKk4QCndWGgSqDOCeSKLOvgzlz6kLQl3/Xxt1hmnZsJ7KEYmz9rY6+IzJ
         w0ItlJvhU1VuAJLYMN10Or+DsYx1iQmdgxV/YxQtc4q0YDyKc1nKb5NHuoQhz3caQES/
         P8bQyf3ZstCANdRyHK+SATuREsc8NeSAnU7ciZQkiGhQqg5mDVyyjWkr/OdsgfTMU9t5
         r3ZNmxgWh+acznQUjHpFsNDmoGHcP1PuTWMz2jYsHVSrxgKA+Rye6Gm7QSyRMt3D20OX
         uCAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8He5aJOawlVwF+Rbc6HeoRcT9c4DstVdG8eXEMUaRag=;
        b=QgJeO3MRNtB9RRKNklbgICoPiF0DGyd0c7WmCFy9Gej6x1wvYC1jEdMP78um6N8Afy
         WqRZAcJPbmL3xvbfntHQ4W5QYJip5JtyY/aJ6WRA6oipWAzl4eZ/3kED/0HMPHdVphFC
         VWPGs5Aehe31ObDDW2jvRKpPodlTxfwBJaBB7lDrzN54sRyqROxP/izJMamU+1gnnkq6
         m6zZevXWWG2LPfuKFylnCkLyTJyMejWQbJ/CPDGebE5CWNpo51U/q542msyD2fZm17Um
         zy4cu30M1XTRBMl4IVPMIQ88GDJX0H6ZmeSZmPOC1ks1ME301LLsiEXHM7GY/t7D+vSJ
         OqAA==
X-Gm-Message-State: AJcUukejv8rB0gWK85e0cXWnViOKYbs1zDPaymbjBwDFYB6Jf3+QX8Jp
        W0nb4J3tpyN5d5lVuzici0mQV6kb7WjNURL6BBM=
X-Google-Smtp-Source: ALg8bN5LvwvHlEpGlrmvoFOaEptYKscgy8JTB6a32d8J8hLwTSyZw3fJwzd11BET51TQuKJgss6k+KBp4b7Zh40yLD4=
X-Received: by 2002:a63:381c:: with SMTP id f28mr6273438pga.330.1548342453341;
 Thu, 24 Jan 2019 07:07:33 -0800 (PST)
MIME-Version: 1.0
References: <CA+T8qpa+qHK7O6zr+a7CUysPzzR4jce7peCCcuOVN4J9TP6teQ@mail.gmail.com>
 <CABBYNZKGS=AcqtgfFffLBWZX6pxOHmkpnXgW4ddr4hO58a_pHQ@mail.gmail.com>
 <CA+T8qpb=w5gnYMWh2fv6Q61ssHs1hrvJ=0gh0murxQZsvbt5vA@mail.gmail.com> <CABBYNZ+p_BLtLvWYm3A1gzYY8uo8F2S1evuYTfkg8SST8zfD=Q@mail.gmail.com>
In-Reply-To: <CABBYNZ+p_BLtLvWYm3A1gzYY8uo8F2S1evuYTfkg8SST8zfD=Q@mail.gmail.com>
From:   Youssif Saeed <youssif.am.saeed@gmail.com>
Date:   Thu, 24 Jan 2019 15:07:23 +0000
Message-ID: <CA+T8qpbbi+7=8bNdiJFstFTWHAUXmUYtcL6x4=PVLKsppb9GrQ@mail.gmail.com>
Subject: Re: BlueZ 5.50: Browsing local GATT table
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, Jan 21, 2019 at 3:02 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Youssif,
> On Mon, Jan 21, 2019 at 3:57 PM Youssif Saeed
> <youssif.am.saeed@gmail.com> wrote:
> >
> > Hi Luiz
> >
> > On Mon, Jan 21, 2019 at 12:12 PM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Youssif,
> > >
> > > On Mon, Jan 21, 2019 at 1:05 PM Youssif Saeed
> > > <youssif.am.saeed@gmail.com> wrote:
> > > >
> > > > Hi
> > > >
> > > > Is there a tool/utility for browsing the local GATT table. I have so
> > > > far used "bluetoothctl info" as follows:-
> > > >
> > > > [bluetooth]menu gatt
> > > > [bluetooth]register-service 0xFFFF
> > > > [bluetooth]register-characteristic 0xAAAA read,write
> > > > [bluetooth]register-application
> > > > [bluetooth]back
> > > > [bluetooth]info
> > > > Controller 00:16:A4:09:31:11 (public)
> > > > Name: linuxvm
> > > > Alias: linuxvm
> > > > Class: 0x000c0000
> > > > Powered: yes
> > > > Discoverable: no
> > > > Pairable: yes
> > > > UUID: Headset AG                (00001112-0000-1000-8000-00805f9b34fb)
> > > > UUID: Generic Attribute Profile (00001801-0000-1000-8000-00805f9b34fb)
> > > > UUID: A/V Remote Control        (0000110e-0000-1000-8000-00805f9b34fb)
> > > > UUID: Generic Access Profile    (00001800-0000-1000-8000-00805f9b34fb)
> > > > UUID: PnP Information           (00001200-0000-1000-8000-00805f9b34fb)
> > > > UUID: A/V Remote Control Target (0000110c-0000-1000-8000-00805f9b34fb)
> > > > UUID: Audio Source              (0000110a-0000-1000-8000-00805f9b34fb)
> > > > UUID: Audio Sink                (0000110b-0000-1000-8000-00805f9b34fb)
> > > > UUID: Unknown                   (0000ffff-0000-1000-8000-00805f9b34fb)
> > > > UUID: Headset                   (00001108-0000-1000-8000-00805f9b34fb)
> > > > Modalias: usb:v1D6Bp0246d0532
> > > > Discovering: no
> > > >
> > > > However, this does not show the list of characteristics/descriptors
> > > > and their handles which is what I am after.
> > > >
> > > > I am using BlueZ 5.50 on an Ubuntu machine running Linux 4.15.0-43-generic.
> > >
> > > I guess you would be after the registered local attributes, command
> > > info doesn't print that only the UUID of the services, we could have
> > > then as part of list-attributes perhaps but it would only show the
> > > attributes register by that instance of bluetoothctl nothing else. As
> > > for the handles that is currently not exposed to the application, do
> > > you require them perhaps to restore them in the same location?
> > >
> > > --
> > > Luiz Augusto von Dentz
> >
> > Thanks for getting back to me. Yes I am after the registered local
> > attributes. We're working on PTS testing the BlueZ stack and a few
> > tests require you to submit handles for the local GATT
> > services/characteristics, which is why having this would be very
> > useful. In my personal opinion the output to the deprecated "gatttool
> > primary/characteristics/descriptors" is ideal for displaying all the
> > necessary information. Something similar to this but for the local
> > GATT table can be very beneficial for future users even outside the
> > scope of PTS testing.
>
> I will need to look into that, we actually intend to have this all
> automated with auto-pts:
>
> https://github.com/intel/auto-pts
>
> Though that is not complete for BlueZ, only Zephyr, and even in case
> of Zephyr we hardcoded the handles, but I agree it is better to
> somehow notify the handle back to the application. Also another thing
> that we might have to improve in the future is a way to pin services
> so even if one reboot the system, or just restart bluetoothd, the
> application can have its services in the same region once again.
>
> --
> Luiz Augusto von Dentz

Thanks for the link. I've seen the auto-pts project and it's quite
impressive. It's definitely helpful when doing PTS tests but as you
said it is missing a big portion for the BlueZ stack.

Is there a place where we can post feature requests and unconfirmed
bugs, or is this mailing list the best location for that?

I think it will be handy as well to report the handle back for remote
services/characteristics. As an example, this is the response for
"list-attributes":-

Primary Service
        /org/bluez/hci0/dev_00_1B_DC_08_0A_D4/service0014
        00001801-0000-1000-8000-00805f9b34fb
        Generic Attribute Profile
Characteristic
        /org/bluez/hci0/dev_00_1B_DC_08_0A_D4/service0014/char0015
        00002a05-0000-1000-8000-00805f9b34fb
        Service Changed

Unfortunately there are many PTS tests that list multiple attributes
with the same UUID but different handles. This is rare for everyday
application but it is not impossible. Again, the output of the
deprecated "gatttool primary/characteristics/descriptors" showed all
the necessary information including the properties and permissions,
and it would be extremely useful if something similar was implemented
to bluetoothctl.

Youssif Saeed
