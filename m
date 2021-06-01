Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEE9C47080
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Jun 2021 21:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32D84610CB
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Jun 2021 21:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234837AbhFAVWk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Jun 2021 17:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234513AbhFAVWk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Jun 2021 17:22:40 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48393C061574
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Jun 2021 14:20:58 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id y2so698586ybq.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Jun 2021 14:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9oWrWaFT76dmJ+pxPALsBiGmNh7RCffkSEZbhWRYhhw=;
        b=Uf0bqkfX3hXX7TM1y9NiIrcmfsXn5e0kkFWOjIhm1pUGT9xI45fqLY4d/6qnigfh2f
         a7Lptz7kmyNXxVP/HbwilXW0r8ND2eAmaxLfx78ymZONzZVuqw+J40yLLffJU9WeErcU
         SxklzMQBhKw5AvypUdXsviEZt1G0uD3d/4ItBUXZrMj4FvkvEQzi42v93hxn2eEa0OHg
         IisHiNknLIcb2GTmvimqC0JZClzpDJe6b692GINhTLR2/vQe9QneP/PskP6chOvKLRRl
         jbCuTQQTckeqDOz4JTvT2cqB6zVnzKlLvHM1X398+k9t4R+tq0Gfd8Sd7vj2IWBR+rY+
         E6hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9oWrWaFT76dmJ+pxPALsBiGmNh7RCffkSEZbhWRYhhw=;
        b=XF/rNMwTzEtJGKX7PKYEMH+VW5XQ53WgScqr+dLLhF0nJqzqBInprnadIH+TDox1CB
         iEUyRwDdvJvF2DW9+J0v+MFMgNguXEmfb6kVpskHtCEeYRHZp7fsTH8XX3ldc0zEfcMO
         TWdLUGGHxIWBYxCHCImzU7y8zAkb/J8tscV5A1hE1G5YEkAyLNMByfCH7UjbK+CePVg3
         eukcdla+zOOf5dP6qMZHnNJiuyMTMAt95aLvVwWdRYtOBQVtV7cLfStL4GqnnbQJ0XtI
         iXLIih1CNLIi201dYuCtTAxi17x3gNdJT6NuKS9d205epb4NY1Uk2LSo5eoXBqa35Qss
         bqPg==
X-Gm-Message-State: AOAM532WCsnjYdzOg3CUQ2BqJB4RXWLEzQL4Lxfd6gcoO1mByPjobihQ
        gfnOctm2Fg1JFQdl56P6LbmteOSNCx1TOHufCc1utRjYOUc=
X-Google-Smtp-Source: ABdhPJwup3P1hCbdL+m1WPL/st8l0bzjHox5EbvUjRI5vIyfwBJA0P/Cs3btRGWuuU2IscDF/1Fn2iIV5/RmeQAzcmI=
X-Received: by 2002:a25:4048:: with SMTP id n69mr37881792yba.91.1622582457202;
 Tue, 01 Jun 2021 14:20:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210528000136.52352-1-luiz.dentz@gmail.com> <20210528000136.52352-5-luiz.dentz@gmail.com>
 <b86289bb96ba971ef5a26b6a255b094cc2d7ffdc.camel@linux.intel.com>
In-Reply-To: <b86289bb96ba971ef5a26b6a255b094cc2d7ffdc.camel@linux.intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 1 Jun 2021 14:20:46 -0700
Message-ID: <CABBYNZKpRcvm4JL2+oa=f_Vx=so03Mg+WmuLz48YQNQWeEos9w@mail.gmail.com>
Subject: Re: [RFC 5/5] Bluetooth: hci_sync: Make use of hci_cmd_sync_queue set 3
To:     Tedd Ho-Jeong An <tedd.an@linux.intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On Tue, Jun 1, 2021 at 1:24 PM Tedd Ho-Jeong An <tedd.an@linux.intel.com> wrote:
>
> Hi Luiz,
>
> On Thu, 2021-05-27 at 17:01 -0700, Luiz Augusto von Dentz wrote:
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > This make use of hci_cmd_sync_queue for the following MGMT commands:
> >
> >     Add Device
> >     Remove Device
> >
> > Tested with:
> >
> > mgmt-tester -s "Add Device"
> >
> > Test Summary
> > ------------
> > Add Device - Invalid Params 1                        Passed       0.017 seconds
> > Add Device - Invalid Params 2                        Passed       0.013 seconds
> > Add Device - Invalid Params 3                        Passed       0.013 seconds
> > Add Device - Invalid Params 4                        Passed       0.013 seconds
> > Add Device - Success 1                               Passed       0.014 seconds
> > Add Device - Success 2                               Passed       0.014 seconds
> > Add Device - Success 3                               Passed       0.014 seconds
> > Add Device - Success 4                               Passed       0.017 seconds
> > Add Device - Success 5                               Passed       0.017 seconds
> > Total: 9, Passed: 9 (100.0%), Failed: 0, Not Run: 0
> > Overall execution time: 0.14 seconds
> >
> > mgmt-tester -s "Remove Device"
> >
> > Test Summary
> > ------------
> > Remove Device - Invalid Params 1                     Passed       0.153 seconds
> > Remove Device - Invalid Params 2                     Passed       0.014 seconds
> > Remove Device - Invalid Params 3                     Passed       0.013 seconds
> > Remove Device - Success 1                            Passed       0.016 seconds
> > Remove Device - Success 2                            Passed       0.017 seconds
> > Remove Device - Success 3                            Passed       1.022 seconds
> > Remove Device - Success 4                            Passed       1.021 seconds
> > Remove Device - Success 5                            Passed       1.022 seconds
> > Total: 8, Passed: 8 (100.0%), Failed: 0, Not Run: 0
> > Overall execution time: 3.29 seconds
> >
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> >  net/bluetooth/hci_sync.c | 606 ++++++++++++++++++++++++++++++++++++++-
> >  net/bluetooth/hci_sync.h |   2 +
> >  net/bluetooth/mgmt.c     |  19 +-
> >  3 files changed, 622 insertions(+), 5 deletions(-)
> >
>
> While running new test cases for checking LL Privacy (submitted the series to mailing list),
> some test cases caused the kernel oops:
>
> general protection fault, probably for non-canonical address 0xdead000000000116: 0000 [#1] PTI
> CPU: 0 PID: 113 Comm: kworker/u3:2 Not tainted 5.12.0-g01861ba6bbe9-dirty #11
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-2.fc32 04/01/2014
> Workqueue: hci0 hci_cmd_sync_work
> RIP: 0010:hci_passive_scan_sync.part.0+0xed/0x820
> Code: 7c 24 13 00 75 12 48 8b 85 00 10 00 00 48 0f ba e0 29 0f 83 97 02 00 00 80 44 24 1e 01 4d 8b 3f 4c 39 3c 24 0f 84 25 01 00 00 <41> 0f b6 57 16 4d 8d 67 10 4c 89 ef 4c 89 e6 e8 2f 95 fb ff 41 0f
> RSP: 0018:ffffad9400187dc8 EFLAGS: 00010202
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: ffff8d0a01850ca8 RSI: ffff8d0a0186a210 RDI: ffff8d0a01850000
> RBP: ffff8d0a01850000 R08: ffff8d0a01803ae6 R09: 0000000000004ffb
> R10: 0000000078563412 R11: 3fffffffffffffff R12: ffff8d0a0186a210
> R13: ffff8d0a01850cf8 R14: ffff8d0a01850d08 R15: dead000000000100
> FS:  0000000000000000(0000) GS:ffffffff87846000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000558641956130 CR3: 00000000018a2000 CR4: 00000000000006f0
> Call Trace:
>  ? unblock_device+0xe0/0xe0
>  hci_update_background_scan_sync+0x268/0x310
>  hci_cmd_sync_work+0x91/0xe0
>  process_one_work+0x19d/0x2f0
>  worker_thread+0x5a/0x3b0
>  ? rescuer_thread+0x330/0x330
>  kthread+0x108/0x120
>  ? __kthread_create_worker+0xf0/0xf0
>  ret_from_fork+0x22/0x30
> ---[ end trace efd7eab9e13c521e ]---
> RIP: 0010:hci_passive_scan_sync.part.0+0xed/0x820
> Code: 7c 24 13 00 75 12 48 8b 85 00 10 00 00 48 0f ba e0 29 0f 83 97 02 00 00 80 44 24 1e 01 4d 8b 3f 4c 39 3c 24 0f 84 25 01 00 00 <41> 0f b6 57 16 4d 8d 67 10 4c 89 ef 4c 89 e6 e8 2f 95 fb ff 41 0f
> RSP: 0018:ffffad9400187dc8 EFLAGS: 00010202
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: ffff8d0a01850ca8 RSI: ffff8d0a0186a210 RDI: ffff8d0a01850000
> RBP: ffff8d0a01850000 R08: ffff8d0a01803ae6 R09: 0000000000004ffb
> R10: 0000000078563412 R11: 3fffffffffffffff R12: ffff8d0a0186a210
> R13: ffff8d0a01850cf8 R14: ffff8d0a01850d08 R15: dead000000000100
> FS:  0000000000000000(0000) GS:ffffffff87846000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000558641956130 CR3: 00000000018a2000 CR4: 00000000000006f0

Remove Device - Success 7 - Remove from whitelist - setup complete
Remove Device - Success 7 - Remove from whitelist - run
  Registering Device Removed notification
  Test condition added, total 1
  Registering HCI command callback
  Test condition added, total 2
  Sending Remove Device (0x0034)
  Test condition added, total 3
  Remove Device (0x0034): Success (0x00)
  Test condition complete, 2 left
  New Device Removed event received
  Test condition complete, 1 left
  HCI Command 0x2042 length 6
[   58.818744] ==================================================================
[   58.819253] BUG: KASAN: use-after-free in
hci_passive_scan_sync.part.0+0x52e/0xaf0
[   58.819833] Read of size 6 at addr ffff8880019bca10 by task kworker/u3:0/49
[   58.820305]
[   58.820584]
[   58.820708] Allocated by task 92:
[   58.820979]
[   58.821092] Freed by task 93:
[   58.821345]
[   58.821489] The buggy address belongs to the object at ffff8880019bca00
[   58.821489]  which belongs to the cache kmalloc-32 of size 32
[   58.822488] The buggy address is located 16 bytes inside of
[   58.822488]  32-byte region [ffff8880019bca00, ffff8880019bca20)
[   58.823363] The buggy address belongs to the page:
[   58.823773]
[   58.823881] Memory state around the buggy address:
[   58.824215]  ffff8880019bc900: fb fb fb fb fc fc fc fc fa fb fb fb
fc fc fc fc
[   58.824771]  ffff8880019bc980: 00 00 00 00 fc fc fc fc fb fb fb fb
fc fc fc fc
[   58.825275] >ffff8880019bca00: fa fb fb fb fc fc fc fc fa fb fb fb
fc fc fc fc
[   58.825884]                          ^
[   58.826169]  ffff8880019bca80: fb fb fb fb fc fc fc fc fb fb fb fb
fc fc fc fc
[   58.826790]  ffff8880019bcb00: fb fb fb fb fc fc fc fc fb fb fb fb
fc fc fc fc
[   58.827330] ==================================================================
  HCI Command 0x2012 length 7
  Test condition complete, 0 left

Btw, it is a good idea to enable KSAN when testing, Im afraid this
might be related to hdev_lock.

>
> However, it is not seen on the current bluetooth-next tree.
>
> Regards,
>
> Tedd
>


-- 
Luiz Augusto von Dentz
