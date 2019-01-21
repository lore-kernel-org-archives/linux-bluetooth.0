Return-Path: <SRS0=Rr1U=P5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3132C2F421
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Jan 2019 15:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C08D920870
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Jan 2019 15:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYORWy6L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729810AbfAUPC2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Jan 2019 10:02:28 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:38706 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729599AbfAUPC2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Jan 2019 10:02:28 -0500
Received: by mail-ot1-f48.google.com with SMTP id e12so20769212otl.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jan 2019 07:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ivZNpBfTrCO6UPmUfNbGv6rdW0OeYlttBGFZLI0zom8=;
        b=JYORWy6LrKLh5uZs7FqzY1pb6IQ7+CNEwjhEflMp1tX1RRnVLRWeeFvYLUQ+bt6TMP
         XW0X5+CEnAyGYDJ81sVSj1SHLfHm70jG1HQSshMxzo/0AuxBfQvoq5GguxkBmHX20FWU
         JOo0PswqzaAXf8B7OuwyuKz8zdhncdyDfWxzNISwvHzKVSCQeu9GPHKHq4RWJlImWP0t
         63BCv2rVdeBlhkv5oAOPE4jfPoQw8DbC6siCCd5xZVLQ7w6CY2OiC4w+uJIBvA0IT2Kn
         gLRR8ts5WA7Gx1mhUwXlpEDIOMvwHfLfHCEXi3kncCTaUiO2sT8Ead8hvrQC6q+ZX9Um
         cgUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ivZNpBfTrCO6UPmUfNbGv6rdW0OeYlttBGFZLI0zom8=;
        b=JpPSwyEidI7eb/+UcOL7yRNRtgGVMoxmxVHGheF7J936Q6AxtaYLXTmDuyhx7Xq3/t
         SWRaePaHugGUHHcLBFD3zYReXWDuvqM3rsnKjOHJLRPd1NPTkPrj3t6bnyCzhkQVt96L
         PWjXA9nNXOAyRnplGn4F6g44VfPalmfC+kZARRc7DPMkG3qYMQQcf2HFk+79RO28hXkO
         Pax7otBWJHejD0HYhhSJMmNkcfik9VGwhIsTNRAwHiPza3uFbVz1GsXQyt5szy4A7qsB
         +PIfLjXIPOQwVer3FcXRnF+DUwG4V+p+w5xIxx90uiG8K2UKe0pYSflZ442HsX/CyFoz
         bvBw==
X-Gm-Message-State: AJcUukfUILxumPG8vbgaTjHHp2l1iZhmSL7bsDl8tgpWw7fDJE2xDD7V
        cqOxG+9A1H5cnSzggG+jO0l8S6YgyJuPXFN2SGU=
X-Google-Smtp-Source: ALg8bN4KFAu/Fx0xlR4D5cGolqqLpfItQEzCvBnKZhr/Pt64mLDD7SDwnjHDFgL2J9ZjVlh7jZ5ubLp1t8nxFUbbLnI=
X-Received: by 2002:a9d:18f:: with SMTP id e15mr20533722ote.84.1548082946955;
 Mon, 21 Jan 2019 07:02:26 -0800 (PST)
MIME-Version: 1.0
References: <CA+T8qpa+qHK7O6zr+a7CUysPzzR4jce7peCCcuOVN4J9TP6teQ@mail.gmail.com>
 <CABBYNZKGS=AcqtgfFffLBWZX6pxOHmkpnXgW4ddr4hO58a_pHQ@mail.gmail.com> <CA+T8qpb=w5gnYMWh2fv6Q61ssHs1hrvJ=0gh0murxQZsvbt5vA@mail.gmail.com>
In-Reply-To: <CA+T8qpb=w5gnYMWh2fv6Q61ssHs1hrvJ=0gh0murxQZsvbt5vA@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 21 Jan 2019 17:02:14 +0200
Message-ID: <CABBYNZ+p_BLtLvWYm3A1gzYY8uo8F2S1evuYTfkg8SST8zfD=Q@mail.gmail.com>
Subject: Re: BlueZ 5.50: Browsing local GATT table
To:     Youssif Saeed <youssif.am.saeed@gmail.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Youssif,
On Mon, Jan 21, 2019 at 3:57 PM Youssif Saeed
<youssif.am.saeed@gmail.com> wrote:
>
> Hi Luiz
>
> On Mon, Jan 21, 2019 at 12:12 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Youssif,
> >
> > On Mon, Jan 21, 2019 at 1:05 PM Youssif Saeed
> > <youssif.am.saeed@gmail.com> wrote:
> > >
> > > Hi
> > >
> > > Is there a tool/utility for browsing the local GATT table. I have so
> > > far used "bluetoothctl info" as follows:-
> > >
> > > [bluetooth]menu gatt
> > > [bluetooth]register-service 0xFFFF
> > > [bluetooth]register-characteristic 0xAAAA read,write
> > > [bluetooth]register-application
> > > [bluetooth]back
> > > [bluetooth]info
> > > Controller 00:16:A4:09:31:11 (public)
> > > Name: linuxvm
> > > Alias: linuxvm
> > > Class: 0x000c0000
> > > Powered: yes
> > > Discoverable: no
> > > Pairable: yes
> > > UUID: Headset AG                (00001112-0000-1000-8000-00805f9b34fb)
> > > UUID: Generic Attribute Profile (00001801-0000-1000-8000-00805f9b34fb)
> > > UUID: A/V Remote Control        (0000110e-0000-1000-8000-00805f9b34fb)
> > > UUID: Generic Access Profile    (00001800-0000-1000-8000-00805f9b34fb)
> > > UUID: PnP Information           (00001200-0000-1000-8000-00805f9b34fb)
> > > UUID: A/V Remote Control Target (0000110c-0000-1000-8000-00805f9b34fb)
> > > UUID: Audio Source              (0000110a-0000-1000-8000-00805f9b34fb)
> > > UUID: Audio Sink                (0000110b-0000-1000-8000-00805f9b34fb)
> > > UUID: Unknown                   (0000ffff-0000-1000-8000-00805f9b34fb)
> > > UUID: Headset                   (00001108-0000-1000-8000-00805f9b34fb)
> > > Modalias: usb:v1D6Bp0246d0532
> > > Discovering: no
> > >
> > > However, this does not show the list of characteristics/descriptors
> > > and their handles which is what I am after.
> > >
> > > I am using BlueZ 5.50 on an Ubuntu machine running Linux 4.15.0-43-generic.
> >
> > I guess you would be after the registered local attributes, command
> > info doesn't print that only the UUID of the services, we could have
> > then as part of list-attributes perhaps but it would only show the
> > attributes register by that instance of bluetoothctl nothing else. As
> > for the handles that is currently not exposed to the application, do
> > you require them perhaps to restore them in the same location?
> >
> > --
> > Luiz Augusto von Dentz
>
> Thanks for getting back to me. Yes I am after the registered local
> attributes. We're working on PTS testing the BlueZ stack and a few
> tests require you to submit handles for the local GATT
> services/characteristics, which is why having this would be very
> useful. In my personal opinion the output to the deprecated "gatttool
> primary/characteristics/descriptors" is ideal for displaying all the
> necessary information. Something similar to this but for the local
> GATT table can be very beneficial for future users even outside the
> scope of PTS testing.

I will need to look into that, we actually intend to have this all
automated with auto-pts:

https://github.com/intel/auto-pts

Though that is not complete for BlueZ, only Zephyr, and even in case
of Zephyr we hardcoded the handles, but I agree it is better to
somehow notify the handle back to the application. Also another thing
that we might have to improve in the future is a way to pin services
so even if one reboot the system, or just restart bluetoothd, the
application can have its services in the same region once again.

-- 
Luiz Augusto von Dentz
