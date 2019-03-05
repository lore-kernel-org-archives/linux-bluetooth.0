Return-Path: <SRS0=u2q6=RI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4722C43381
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Mar 2019 10:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91C51206DD
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Mar 2019 10:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9t7Dnny"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfCEKy0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Mar 2019 05:54:26 -0500
Received: from mail-lj1-f174.google.com ([209.85.208.174]:42372 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfCEKy0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Mar 2019 05:54:26 -0500
Received: by mail-lj1-f174.google.com with SMTP id d14so7191800ljl.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 Mar 2019 02:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=UghJTOSdtkY+/mr1kPkE0FOO30MGMt47jYA0aw+M/jA=;
        b=Q9t7Dnnyu2RTOf7Xt7TX9l0duWnQiHs9NdLHiDBerENAgWos3JU+hvH3ahjrF6q2ae
         queP0y2GpfK14zoPQXRgOmO04vh/N81fSGnWP9Wik6dyusQf84hGb2VuqS0oU+ZmdvtO
         sTG/KbTe2gX2Ck+D7wQ8K4JPBzZk+MBcGyufX9/0J4PrD38mxoe8wDcEUg72Uv1tydpz
         xGBGpA032bAUryK5CgVYpZNOXOt/JV/WpfK4GA1OR2vMMAkj50pTNG+/krOVWwgDyZon
         mQ1uXH2gZEt/8PYklpYI7CepMlGJ+hks1DVdEJ1+jGCix8FfyKQROo/umx9olh5h3wvg
         lu2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=UghJTOSdtkY+/mr1kPkE0FOO30MGMt47jYA0aw+M/jA=;
        b=btVtZZlIw6CauNMQABaDOqvp2rZp0VJqLWjLXTYT9B7AVhPEwqZH125fRjbm16gPUj
         oRtw2ET3UxEXSzxCKdFpn2+YVy8TC5JsRBaYnEpPNHDjooKczCzzjeAAPmIl88dMLOOe
         KT6yA1fYgHlb3UFCIRfunpJKCU/No+yIGTI0uDzbgZMH/UDAH76DR39YAXbKL6LnLQsP
         TZWmzZotLUThjwOmVD3b2ZnWJEwW/2c+ntGtDpZE8rhPzqooXwHTKTtKtp+0IbguJScK
         7h7TP5NTKlWq5HQIb0EZ7jp20/3/XjkAX9iB1ndrCw9XPksqRRG1h1DIc/t3TyHoelf2
         1TGg==
X-Gm-Message-State: APjAAAVDGCehGhZtHAtKwp4N+qgQc3kktMSQTumsp7M3cvp5bb2xoB1I
        rtBLzscFvOOLr3o9dcqFwxThbdqcBLmvXTfeF3Y=
X-Google-Smtp-Source: APXvYqyeZxcsKBqi2roWf+820hUQ+STqSTL0lOWePDUeTwEkdooQJ5S/2Pd0G4LOqOQGtwfJOTpdbMIjmmQyE6FYCm8=
X-Received: by 2002:a2e:6309:: with SMTP id x9mr13007397ljb.75.1551783263808;
 Tue, 05 Mar 2019 02:54:23 -0800 (PST)
MIME-Version: 1.0
From:   Martin Townsend <mtownsend1973@gmail.com>
Date:   Tue, 5 Mar 2019 10:54:12 +0000
Message-ID: <CABatt_z4bC6fGY9+4fLN5JNu7r8VYyEZJ5MvtArS195TpWAjeg@mail.gmail.com>
Subject: Operating central and peripheral roles concurrently
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        Emil Lenngren <emil.lenngren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

I sent an email November last year about Operating central and
peripheral roles concurrently
https://www.spinics.net/lists/linux-bluetooth/msg77673.html

And although we had the dual roles working thanks to the suggested
patch the dev team has reported that if the device (central) connects
to the board (peripheral) first, and then having the board (central)
connecting to a sensor (peripheral), dual roles work fine.

But the other way around, board (central) connects to a sensor (peripheral),
advertisements stop being sent and no other device can no longer connect to
the board (peripheral).

Here's the hcidump trace after running 'hciconfig hci0 leadv 1':

HCI Command: LE Set Advertise Enable (0x08|0x000a) plen 1
   0000: 01
HCI Event: Command Complete (0x0e) plen 4
   LE Set Advertise Enable (0x08|0x000a) ncmd 1
   status 0x00

Then within a second we get the following in hcidump which shows it
being disabled

HCI Command: LE Set Advertise Enable (0x08|0x000a) plen 1
   0000: 00
HCI Event: Command Complete (0x0e) plen 4
   LE Set Advertise Enable (0x08|0x000a) ncmd 1
   status 0x00

I would really appreciate it if someone could point me to the relevant
place in the Kernel code where this could be occurring so I can start
to debug this or even suggest a patch I could try.  The kernel version
is v4.9.

Many Thanks,

Martin.
