Return-Path: <SRS0=OoMZ=VO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB6EC76186
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jul 2019 09:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F37CB2173E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jul 2019 09:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIgRbG9b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbfGQJfz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Jul 2019 05:35:55 -0400
Received: from mail-yw1-f52.google.com ([209.85.161.52]:43914 "EHLO
        mail-yw1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfGQJfz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Jul 2019 05:35:55 -0400
Received: by mail-yw1-f52.google.com with SMTP id n205so10318623ywb.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jul 2019 02:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SLD6MlZPAe/x0wDV+rwAx3kLgKZLRVt04PdNzaINfJ8=;
        b=bIgRbG9bZyrTF6vL9T821fZxNlDa+SMoEl7f00W4Y9d7SAqskkjM1f/0bHwi3XNxiN
         x4Jebp4V44K3+oXAoAS1kv8G8fkXAJGlHILit+6Jc4KQJldJKKBRAUoL+f8fMjrlNXLm
         PCh+LgpSa1evu7fBa13BdYdfZrnIMOQNvvA5XAgY6/UQ+xBCSL8E2x8e/4IlIznHROaH
         otVxiwUKqRsSbmZH/xoYBht2KyHmwzUyRup0UGZaGc5yRxwSpX8wP/quW1em5G6vX9C9
         k0rQiY1zGugSk1pTP/4pZ3XZLJfn2PzPk4DS3TvzbqTC28/ywxo6rsS40oC2aom6MnWl
         T+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SLD6MlZPAe/x0wDV+rwAx3kLgKZLRVt04PdNzaINfJ8=;
        b=QLPuAW6TVbJExvko3EjdJ/Mwyd0GMOUNJrljcqa/X1/bGFS88biMo0v6oaDOk7BWQt
         gRXELHawXbEFwac4SASEpVxecTZGXB1rj2y8Wxr8P1tRkpEfQ5CuBiVHwMHXSsZA3OSg
         hc2B5Gfho7S+BW96grK+JJIBu7vdwinko2vR8tRTtskkee+/gL3AsUAw4WRarlYSzYOs
         IfwhvW95wx3Grs1MZfDMt1EXoApxDuOaIr142OJyNjWRBqeRYzTSTIhNJxUXREzndnI+
         muOE2sBH4TXqVrILLwaf2+H/Zqmw0OgPvIRg1gyzlyUUnLoOGbeQ7bg7UKGlDY30//7U
         +Siw==
X-Gm-Message-State: APjAAAUsE0ZIdNmt1O9ad7AkQpnwOHSjk3mTACU07TaRypAlj+wwdx6s
        14t2Bcgy3iLiU+I2c0IHdv52vYof3tmppAPJ4LUWug==
X-Google-Smtp-Source: APXvYqxCmW+KhgBHOouH2K8ZqQMBncKfgpdS1seO4tRnIT5F6VFwCOJPBCppg9huj2E2YxIlWkQmmjvhw3WQhNc5iWw=
X-Received: by 2002:a81:a511:: with SMTP id u17mr24170398ywg.54.1563356154495;
 Wed, 17 Jul 2019 02:35:54 -0700 (PDT)
MIME-Version: 1.0
References: <c6e32190-c23d-2311-10f0-b5dcd58784bf@gmail.com>
 <c08604d7-5708-ed37-9e55-93e67e06a3da@gmail.com> <16286916.LhmCvT1dVb@ix>
In-Reply-To: <16286916.LhmCvT1dVb@ix>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Date:   Wed, 17 Jul 2019 11:35:43 +0200
Message-ID: <CACna6rzhfQnwy0yeb+9wVaPqQXLYErx4-Kv5+ivk47WOAhHqjw@mail.gmail.com>
Subject: Re: bluetoothctl: list-attributes doesn't list services from example-gatt-server
To:     Szymon Janc <szymon.janc@codecoup.pl>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, 17 Jul 2019 at 11:26, Szymon Janc <szymon.janc@codecoup.pl> wrote:
> On Tuesday, 9 July 2019 14:14:07 CEST Rafa=C5=82 Mi=C5=82ecki wrote:
> > On 07.07.2019 12:14, Rafa=C5=82 Mi=C5=82ecki wrote:
> > > I decided to test GATT. On elitebook I started:
> > > ./test/example-gatt-server
> > > and waited to let matebook refresh all info.
> > >
> > > After that I got:
> > >
> > > [elitebook]# info 20:16:B9:D8:A9:3B
> > > Device 20:16:B9:D8:A9:3B (public)
> > >
> > >          Name: elitebook
> > >          Alias: elitebook
> > >          Class: 0x001c010c
> > >          Icon: computer
> > >          Paired: yes
> > >          Trusted: yes
> > >          Blocked: no
> > >          Connected: yes
> > >          LegacyPairing: no
> > >          UUID: IrMC Sync
> > >  (00001104-0000-1000-8000-00805f9b34fb) UUID: OBEX Object Push
> > >  (00001105-0000-1000-8000-00805f9b34fb) UUID: OBEX File Transfer
> > >  (00001106-0000-1000-8000-00805f9b34fb) UUID: Headset
> > >  (00001108-0000-1000-8000-00805f9b34fb) UUID: Audio Source
> > >  (0000110a-0000-1000-8000-00805f9b34fb) UUID: Audio Sink
> > >  (0000110b-0000-1000-8000-00805f9b34fb) UUID: A/V Remote Control Targ=
et
> > >  (0000110c-0000-1000-8000-00805f9b34fb) UUID: A/V Remote Control
> > >  (0000110e-0000-1000-8000-00805f9b34fb) UUID: Headset AG
> > >  (00001112-0000-1000-8000-00805f9b34fb) UUID: Phonebook Access Server
> > >  (0000112f-0000-1000-8000-00805f9b34fb) UUID: Message Access Server
> > >  (00001132-0000-1000-8000-00805f9b34fb) UUID: Message Notification Se=
..
> > >  (00001133-0000-1000-8000-00805f9b34fb) UUID: PnP Information
> > >  (00001200-0000-1000-8000-00805f9b34fb) UUID: Heart Rate
> > >  (0000180d-0000-1000-8000-00805f9b34fb) UUID: Battery Service
> > >  (0000180f-0000-1000-8000-00805f9b34fb) UUID: Vendor specific
> > >  (00005005-0000-1000-8000-0002ee000001) UUID: Vendor specific
> > >  (12345678-1234-5678-1234-56789abcdef0) Modalias: usb:v1D6Bp0246d0532
> > >
> > > That seems all correct for now. Test example-gatt-server registers
> > > Heart Rate, Battery & Test services. All of them appeared as expected=
.
> > >
> > > My problem is that I can't list GATT attributes. I don't any output.
> > > Is there anything I'm doing incorrectly?
> >
> > I decided to test nRF Connect Android app. It showed something
> > interesting about my bluetooth devices. It nicely displays & parses
> > advertising data.
> >
> > Logitech M590 advertises:
> > 0x01 Flags
> > 0x03 Complete List of 16-bit Service Class UUIDs
> > 0x09 Complete Local Name
> > 0x0A Tx Power Level
> > 0x19 Appearance
> >
> > BlueZ on "elitebook" advertises:
> > 0xFF Manufacturer Specific Data
> > or to say precisely:
> > 0x1BFF750042040180AE78BDBC0B7E307ABDBC0B7E2F01000000000000
> >
> > Any idea/hint why BlueZ 5.30 on my "elitebook" notebook doesn't
> > advertise more data?
>
> Just to be sure, are you using 5.30? If so, update to 5.50..

Sorry for that typo, that was meant to be 5.50.

--=20
Rafa=C5=82
