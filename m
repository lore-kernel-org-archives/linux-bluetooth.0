Return-Path: <SRS0=//f6=62=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5517CCA90AF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 May 2020 19:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F4CC2492B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 May 2020 19:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abB91SRV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730988AbgELTKw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 May 2020 15:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgELTKw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 May 2020 15:10:52 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C96C061A0C
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2020 12:10:51 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id d21so7275445ljg.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2020 12:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=NnYUItCS9E6tNFKVpaJY3DNqG6BTFsC7YWrbfDd6hTk=;
        b=abB91SRVCNZhpk2J7WLX8eWPvBL53fyfNkGsbDjZmcd7uHRVw4pqNLpGWBINz3hL6X
         3kYplVxWGXQ8Pk160O8ULvsDnU+h0iQDi1Qg1e1Gbp/Bsh+JazVnQlI/1484/S9uGR8M
         +zShmlMFHOTnLFYPMEXts8h3og+HLuMn9ZLiZ8g2EkJl4PgIUBDA/FtL2PuAC+wMQZ+E
         MJwm5vZ+CKHFdp4jnftSl8uHsoCAD5ZrYuj+RRKDpVt33Hgjxe48XX0Abur4CGCqq8fV
         7N8GbMvDTJRUg2O629w/hWO7VbtSNXg5r4Iu/1iB3nGhXUJ/nVOEt39VHYMs6gAwU1/F
         baVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=NnYUItCS9E6tNFKVpaJY3DNqG6BTFsC7YWrbfDd6hTk=;
        b=W8ZTYAMqJiOtUT0fdVHKVfG52PqWjLPQZ+JEXzhws/o/jMjEFSMYHTBwYWxaoBkUQ1
         0x0v++RKY641/3hogZM9ccJ3oNYFpbBG+ipMSJTBkKvlApNF+1Nu0ntfAIQ/Va0tzOJW
         L/XLrQuO+asS1OvO74rhBa+IL1m+D7oTUIhNdV1ys/QgtQZpgpZH5fxb146NBAl9LAgO
         G7dMx1V1xYcXG3NoQOr1RMS4q/ODHaEZHj17U7x3hCrlkikcbQmwaVI9zQ4z96TjboPH
         0vdY/zMKdcyiXQBMcT+VEDmTN4kw1TfHVAIwtOqPpxEacb6QauesLJ5xaijDDDd0dB/J
         0RYw==
X-Gm-Message-State: AOAM532vz1ix07mHlfoP3HHI7MxRPdhp9cIN9kJT2g0ocg4Zd46Ye3jX
        5uoV0AZYcphuwRo0z9mubYz5qhQm/0DeHyFfEDHUuY12
X-Google-Smtp-Source: ABdhPJwZQ87WKiwzmmhUoUo72bHYgIozk85+j5Eu0ksSi62em0SUbwO7XXAjQeJJSTuxsM7ZL2z0V8AU0GkIa9FFEGI=
X-Received: by 2002:a05:651c:112c:: with SMTP id e12mr14807397ljo.127.1589310649749;
 Tue, 12 May 2020 12:10:49 -0700 (PDT)
MIME-Version: 1.0
From:   Andrew Fuller <mactalla.obair@gmail.com>
Date:   Tue, 12 May 2020 12:10:38 -0700
Message-ID: <CAB5wbS-P6VkJF9L7BZW-F9ztENzrROWcBpFzqaZXBGssAddq4w@mail.gmail.com>
Subject: Intel AX200 not receiving SCO data
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I sent this email yesterday, but it doesn't seem to have gone through.
I'm re-sending it now but this time without the attachments (maybe
that caused it to be redirected to /dev/null?)
If the attachments would be useful, please advise how to manage them
-- direct paste into the body?

If the first was just delayed, then this becomes a double-post.
Apologies in advance if that happens.

Original message below,
-Andrew


---- 8< ----------


First of all, I hope I'm in the right place for this, and if not
please direct me to where this is better suited.

Secondly, I know very little about Bluetooth, so please excuse my ignorance.

I have an Intel AX200 chip in my laptop and wish to use my Plantronics
Voyager Legend for teleconferencing under Linux.  It didn't work out
of the box, so I've been learning little pieces of Bluetooth and
profiles and such as I've dug progressively deeper into this.

I am now at the point where I understand (thanks Pali!) that SCO is
required for HSP/HFP and that my device doesn't seem to be receiving
any SCO packets.

Attached are the HCI logs from btmon and bluetoothd debug logs
(running master from a couple days ago).

Notably I see:

$ ag "SCO Data" hcitrace.txt
2048:< SCO Data TX: Handle 257 flags 0x00 dlen 96              #386
[hci0] 66.554983
2055:< SCO Data TX: Handle 257 flags 0x00 dlen 96              #387
[hci0] 66.554998
2690:< SCO Data TX: Handle 257 flags 0x00 dlen 96             #473
[hci0] 123.337072
2697:< SCO Data TX: Handle 257 flags 0x00 dlen 96             #474
[hci0] 123.337084

Looks like 4 SCO transmits, but 0 SCO receives.

Also looking peculiar to me is the content:

< SCO Data TX: Handle 257 flags 0x00 dlen 96              #386 [hci0] 66.554983
       00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
       00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
       00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
       00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
       00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
       00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
< SCO Data TX: Handle 257 flags 0x00 dlen 96              #387 [hci0] 66.554998
       00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
       00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
       00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
       00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
       00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
       00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................

Is it typical/good/happy to be sending 96 bytes of nothing?

A little more detail about the bt chip in question:

$ lsusb
Bus 001 Device 006: ID 8087:0029 Intel Corp.

$  dmesg | ag blue
[    4.762863] Bluetooth: Core ver 2.22
[    4.762877] Bluetooth: HCI device and connection manager initialized
[    4.762879] Bluetooth: HCI socket layer initialized
[    4.762881] Bluetooth: L2CAP socket layer initialized
[    4.762887] Bluetooth: SCO socket layer initialized
[    4.975584] Bluetooth: hci0: Firmware revision 0.0 build 128 week 11 2020
[    5.037566] thinkpad_acpi: rfkill switch tpacpi_bluetooth_sw: radio
is unblocked
[    5.821248] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    5.821249] Bluetooth: BNEP filters: protocol multicast
[    5.821253] Bluetooth: BNEP socket layer initialized
[   17.926249] Bluetooth: RFCOMM TTY layer initialized
[   17.926262] Bluetooth: RFCOMM socket layer initialized
[   17.926268] Bluetooth: RFCOMM ver 1.11

"Firmware revision 0.0" also looks strange to me, but AFAICT it's
loading ibt-20-1-3.sfi from the linux-firmware package.  Week 11 2020
certainly looks in line with what I would expect.

Googling has suggested that in the case of another vendor's chip SCO
traffic was being routed to PCI pins instead of HCI and that a
vendor-specific HCI command switched it to HCI, fixing the issue.

So, my questions are:
1. Am I in the right place?
2. Does this chip require a magic HCI command to route SCO to HCI?  It
appears some Intel folks are active here, perhaps they could chime in?
2a. If yes, where do I find the magic command?
3. Is the missing SCO Rx likely a symptom of something else gone wrong
in software, or likely the first indication of a hardware/firmware
issue?
4. Is there somewhere else I should be looking?

Thanks in advance,
-Andrew
