Return-Path: <SRS0=+pQP=5K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B00C2D0E5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Mar 2020 19:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9DA620658
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Mar 2020 19:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=augury.com header.i=@augury.com header.b="BKk1trKh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbgCYTym (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 Mar 2020 15:54:42 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:40080 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbgCYTym (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 Mar 2020 15:54:42 -0400
Received: by mail-lj1-f170.google.com with SMTP id 19so3889378ljj.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2020 12:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=augury.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=Lp74YnbdTTAM9d8j1l/I/lkHM3HvnZhEJRrWh/3Oq9k=;
        b=BKk1trKhhUZ8p9YPK87wuFKw4Fj8E1gxL+druuDQC4LbSv3SD1uO0tuHPit/m9aDJr
         BlGmDaS1yH2Dt9kCiHKztsPdwS0IafGimemg0BA779oBqGUnPPBjSnxjw+NxkcJzcsbz
         h7GR0VbwOAylr3kcbN9dysVn5Cduzhxdms5EA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Lp74YnbdTTAM9d8j1l/I/lkHM3HvnZhEJRrWh/3Oq9k=;
        b=ITodiuleWNLdCWyDK41ILJXfxhciHRjiP0/X3aq9xGd37LjUJS1QfPA0FOlAYv8CTs
         083fCQvy6uCCff5bM9raARWqhdqukZnjTN8Z2G5y2lbkllvH+0qFnlkDqPRxbekjqsZN
         uUOnGtl5hyt6ycBGt8mgYHd6CEhQ3aV3R+HJERnVdVsVbgR78mzJrM3J6t+wJV54Drhp
         On05QBg6xSADipuyw254n24lCy8qboGS6/raIvmgdVl2d9H4z3CrrY7ttO3FQCHyjP0o
         sPn3GNE6ETJdj/ulBRPSiX3Jj6C0RpSuwLVBM3jWRHYW+wRnjQ2C8wSeIySRHoH0IW52
         185w==
X-Gm-Message-State: ANhLgQ3wmNQ+/feRlePtNeMhmxBwN8IXywDyPQVvnxUqOLayiHM8ut5Q
        FcKpAn51sMMubhGv9AnSA+gRn7cFSBJ0mNVwh62bKRGuB4ocDA==
X-Google-Smtp-Source: APiQypLFC6AM6/2acWRM0DrXstFU0nh5hjmoYhEy4Ef0ecHCNv2YSIJEHvWVf35sCfzqdR+XUcmEe1fhxq6yT5i6nk4=
X-Received: by 2002:a2e:9497:: with SMTP id c23mr2947460ljh.286.1585166078563;
 Wed, 25 Mar 2020 12:54:38 -0700 (PDT)
MIME-Version: 1.0
From:   Gal Ben Haim <gbenhaim@augury.com>
Date:   Wed, 25 Mar 2020 21:54:27 +0200
Message-ID: <CAHotPr_tDReMz4DhMNm=U_uEVBusZzjNeWgzfkscD7=L8wuScg@mail.gmail.com>
Subject: Memory leak in l2cap_sock_connect
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

we are experiencing memory leaks in the Bluetooth subsystem,
this is happening in kernel 4.4.x, 4.9.x and 4.14.x, we tried the
Bluetooth subsystem from kernel 4.9.217 to make sure
https://lore.kernel.org/patchwork/patch/1157142/ doesn't solve it.

devices are connected from Bluez v5.50 with experimental flags on via
Adapter.ConnectDevice. we also tried connecting with btmgmt's Add
Device with the same results.

are there any leads on how to fix this? or workarounds?

unreferenced object 0xa592c000 (size 1024):
  comm "bluetoothd", pid 464, jiffies 630386 (age 8911.090s)
  hex dump (first 32 bytes):
    bc c8 27 a9 00 02 00 00 00 00 00 00 f5 46 4a 05  ..'..........FJ.
    8d cd 01 d1 c9 3f 95 01 00 00 00 00 00 00 00 00  .....?..........
  backtrace:
    [<807e8714>] hci_connect_le_scan+0xf0/0x248
    [<80806224>] l2cap_chan_connect+0x4b4/0x6ec
    [<8080bc88>] l2cap_sock_connect+0xe8/0x184
    [<806eca04>] SyS_connect+0x64/0x94
    [<80107780>] ret_fast_syscall+0x0/0x3c
    [<ffffffff>] 0xffffffff
unreferenced object 0xa58dea00 (size 256):
  comm "bluetoothd", pid 464, jiffies 630386 (age 8911.090s)
  hex dump (first 32 bytes):
    00 c0 92 a5 00 16 8c a4 36 01 00 00 00 00 00 00  ........6.......
    00 06 00 00 e0 ff ff ff 18 ea 8d a5 18 ea 8d a5  ................
  backtrace:
    [<80806378>] l2cap_chan_connect+0x608/0x6ec
    [<8080bc88>] l2cap_sock_connect+0xe8/0x184
    [<806eca04>] SyS_connect+0x64/0x94
    [<80107780>] ret_fast_syscall+0x0/0x3c
    [<ffffffff>] 0xffffffff
