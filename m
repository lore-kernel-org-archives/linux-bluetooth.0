Return-Path: <SRS0=gGyw=WC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A525C433FF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Aug 2019 09:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CA512070C
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Aug 2019 09:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQigdikT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731922AbfHFJ0a (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 6 Aug 2019 05:26:30 -0400
Received: from mail-qk1-f176.google.com ([209.85.222.176]:35475 "EHLO
        mail-qk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfHFJ0a (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 6 Aug 2019 05:26:30 -0400
Received: by mail-qk1-f176.google.com with SMTP id r21so62393199qke.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Aug 2019 02:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Pmm2J9IWq0FYjrq2NGmdxul8f3IJ6ZYnFNy75QgBxnY=;
        b=nQigdikTr8zkV/z1KMrTc9dNDt9lZw7FCoJNMXF1dfEur5Jgl2nmorsf3anpi6MmXM
         LdiuC3t7VYNG81WTlnpEW3GGarkB0AmKvaO0xcKGRoGGhZW/N5YIhegrI8NBIp1vLrOi
         nBtTbdaUi3Jt2wj+gBMFMiPM1qgSD+ix25rwlqCNsN8VyrXiSFJ8jF1o/EYUnyOlsa5D
         SQVuo1QPY/1GOr6QyIyCBYWWuk2ylWp+4ZPuE6bLzc1WV+jtAQEy6VBAxhci+v+Sf8X4
         7+ZMJZFBaJuh+YZXivghqhSmfpWfp3f/+X4x1ZzTH8c42V50HorDZeHH9Ouw1LLOLOi6
         BfeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Pmm2J9IWq0FYjrq2NGmdxul8f3IJ6ZYnFNy75QgBxnY=;
        b=J4+5NtwB9CxetEy/WCUi4d9DjCGvv/rx6XNFD+HqAzkViMWd5soTBkV0QA7ZYJzHZ5
         UZOrIDKSSjz5BgOGvn2U2rhg6ChmywkHotra41rZBlZeIsFnA+fi6SBQJk64RoWtuGh7
         6aar3bBzcsHvp1TLGD5846QNaIy2wym4DTqD/EXIwwyVajfdsCGjRaylHAmDO+KeCeBL
         F6pUMArozbsUf6r40GzjL7TAXF55afyMXScsNhILPH3MhnSzFrCuNNBhaqZx68riRtts
         Na9Q09FYXm6tPkKbHkJ2OL4rgANANJS0SLsyLKamw9J/EM9O64bWtU4BKdQMPf2wAoJf
         4/9Q==
X-Gm-Message-State: APjAAAWyA8lHdNSS1O15hZA5vRFsY/E3aCQ70BS5oXyLdS1mmrdxj8B2
        CgOxmj7QY1HXGySo7M8R+uwAKc0FQ/PpqSwrLneyjBmS
X-Google-Smtp-Source: APXvYqyCKf9xNC3cbzgbEs0Xzhx3Ppor61XslZTvnmWclBB6AnL91mJFl9rkEEWdXHhJnTYO9rMv+uat4PFhHt+sC1U=
X-Received: by 2002:a37:a603:: with SMTP id p3mr2308595qke.297.1565083588998;
 Tue, 06 Aug 2019 02:26:28 -0700 (PDT)
MIME-Version: 1.0
References: <CANKzOHAsWzZR3aXWnh9-bYJoO=d124KD+C5gPmot5fMfEH_G9Q@mail.gmail.com>
 <CANKzOHCJKAnrCBV8Pmbm1XiOSZ-+U8o=ps247FUHHwS7=oL=UQ@mail.gmail.com>
In-Reply-To: <CANKzOHCJKAnrCBV8Pmbm1XiOSZ-+U8o=ps247FUHHwS7=oL=UQ@mail.gmail.com>
From:   Axelle <aafortinet@gmail.com>
Date:   Tue, 6 Aug 2019 11:26:17 +0200
Message-ID: <CANKzOHBJSS6wyX1=+N5dLj8G6suZ_H56GfJL0_B_G_P3tJez0w@mail.gmail.com>
Subject: Re: Pairing request ends in timeout
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Solved this issue. The remote device apparently disconnects depending
on what is in the write request before.
Don't bother any longer.

On Mon, Aug 5, 2019 at 4:56 PM Axelle <aafortinet@gmail.com> wrote:
>
> I managed to pair, by a mix of factory reset + ensuring that other
> devices previously paired were unpaired.
>
> Now, I can pair. However I continue to experience disconnections. Typically,
>
> - I connect, I pair
> - I send a Write Request
> - I receive a Write Response which looks
> - Immediately after I also receive a Disconnect Complete with reason
> "Remote User Terminated Connection". This is not meant to happen.
>
> Can I do something about this?
>
> This behaviour is exactly the same on two different hosts: Linux Mint,
> and a Rpi 3. Using Bluez 5.50.
>
> < ACL Data TX: Hand.. flags 0x00 dlen 15  #47 [hci0] 2019-08-05 16:37:27.290456
>       ATT: Write Request (0x12) len 10
>         Handle: 0x0014
>           Data: xxxxxxxxxxxxxxxx
> > HCI Event: Number of C.. (0x13) plen 5  #48 [hci0] 2019-08-05 16:37:27.295258
>         Num handles: 1
>         Handle: 70
>         Count: 1
> > ACL Data RX: Handl.. flags 0x02 dlen 5  #49 [hci0] 2019-08-05 16:37:27.324637
>       ATT: Write Response (0x13) len 0
> > HCI Event: Disconnect... (0x05) plen 4  #50 [hci0] 2019-08-05 16:37:27.341258
>         Status: Success (0x00)
>         Handle: 70
>
>         Reason: Remote User Terminated Connection (0x13)
>
> Thanks
>
> -- Axelle
>
> On Thu, Aug 1, 2019 at 4:10 PM Axelle <aafortinet@gmail.com> wrote:
> >
> > Hello list,
> >
> > I (again) face problems pairing with a BLE device.
> >
> > Using bluetoothctl (v5.50), I connected to the device (connect).  Then
> > I try to pair but it fails (org.bluez.Error.AuthenticationCanceled).
> > The hcidump show a connection timeout.
> >
> > NB:
> > - I have a registered agent (although I do not think it is useful in my case)
> > - I am using Linux Mint 19.1. The same error occurs on a Raspberry Pi
> > 3 with Raspbian.
> > - I have some bluez distrib packages v5.48 installed. Can this be an issue?
> > - I got this to work a while ago with the help of someone of bluez on
> > IRC, doing power off/power on, but this is not working this time...
> >
> > Thanks
> >
> > -- Axelle
> >
> > What bluetoothctl says:
> >
> > [D2A74C76F3E0]# pair D2:A7:4C:76:F3:E0
> > Attempting to pair with D2:A7:4C:76:F3:E0
> > [CHG] Device D2:A7:4C:76:F3:E0 ServicesResolved: no
> > [CHG] Device D2:A7:4C:76:F3:E0 Connected: no
> > Failed to pair: org.bluez.Error.AuthenticationCanceled
> >
> > The corresponding hcidump shows that the connection times out:
> >
> > < ACL data: handle 71 flags 0x00 dlen 11
> >     SMP: Pairing Request (0x01)
> >       capability 0x04 oob 0x00 auth req 0x2d
> >       max key size 0x10 init key dist 0x0d resp key dist 0x0f
> >       Capability: KeyboardDisplay (OOB data not present)
> >       Authentication: Bonding (MITM Protection)
> >       Initiator Key Distribution:  LTK  CSRK
> >       Responder Key Distribution:  LTK IRK CSRK
> > > HCI Event: Number of Completed Packets (0x13) plen 5
> >     handle 71 packets 1
> > > HCI Event: Disconn Complete (0x05) plen 4
> >     status 0x00 handle 71 reason 0x08
> >     Reason: Connection Timeout
