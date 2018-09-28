Return-Path: <SRS0=5peh=MK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BBFC04AA5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Sep 2018 18:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D514D206B8
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Sep 2018 18:55:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D514D206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbeI2BU3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Sep 2018 21:20:29 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:56918 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbeI2BU3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Sep 2018 21:20:29 -0400
Received: from marcel-macbook.fritz.box (p4FEFC9BB.dip0.t-ipconnect.de [79.239.201.187])
        by mail.holtmann.org (Postfix) with ESMTPSA id 76D88CF29E;
        Fri, 28 Sep 2018 21:02:37 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [PATCH v3] Bluetooth: Fix debugfs NULL pointer dereference
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180928185430.GA75415@Matias-MacBook-Air.local>
Date:   Fri, 28 Sep 2018 20:55:20 +0200
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <4B0F7B7E-3D59-4441-8FBE-DE72E41A8B53@holtmann.org>
References: <20180928185430.GA75415@Matias-MacBook-Air.local>
To:     Matias Karhumaa <matias.karhumaa@gmail.com>
X-Mailer: Apple Mail (2.3445.100.39)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Matias,

> Fix crash caused by NULL pointer dereference when debugfs functions
> le_max_key_read, le_max_key_size_write, le_min_key_size_read or
> le_min_key_size_write and Bluetooth adapter was powered off.
> 
> Fix is to move max_key_size and min_key_size from smp_dev to hci_dev.
> At the same time they were renamed to le_max_key_size and
> le_min_key_size.
> 
> BUG: unable to handle kernel NULL pointer dereference at 00000000000002e8
> PGD 0 P4D 0
> Oops: 0000 [#24] SMP PTI
> CPU: 2 PID: 6255 Comm: cat Tainted: G      D    OE     4.18.9-200.fc28.x86_64 #1
> Hardware name: LENOVO 4286CTO/4286CTO, BIOS 8DET76WW (1.46 ) 06/21/2018
> RIP: 0010:le_max_key_size_read+0x45/0xb0 [bluetooth]
> Code: 00 00 00 48 83 ec 10 65 48 8b 04 25 28 00 00 00 48 89 44 24 08 31 c0 48 8b 87 c8 00 00 00 48 8d 7c 24 04 48 8b 80 48 0a 00 00 <48> 8b 80 e8 02 00 00 0f b6 48 52 e8 fb b6 b3 ed be 04 00 00 00 48
> RSP: 0018:ffffab23c3ff3df0 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 00007f0b4ca2e000 RCX: ffffab23c3ff3f08
> RDX: ffffffffc0ddb033 RSI: 0000000000000004 RDI: ffffab23c3ff3df4
> RBP: 0000000000020000 R08: 0000000000000000 R09: 0000000000000000
> R10: ffffab23c3ff3ed8 R11: 0000000000000000 R12: ffffab23c3ff3f08
> R13: 00007f0b4ca2e000 R14: 0000000000020000 R15: ffffab23c3ff3f08
> FS:  00007f0b4ca0f540(0000) GS:ffff91bd5e280000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000000002e8 CR3: 00000000629fa006 CR4: 00000000000606e0
> Call Trace:
> full_proxy_read+0x53/0x80
> __vfs_read+0x36/0x180
> vfs_read+0x8a/0x140
> ksys_read+0x4f/0xb0
> do_syscall_64+0x5b/0x160
> entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Signed-off-by: Matias Karhumaa <matias.karhumaa@gmail.com>
> ---
> include/net/bluetooth/hci_core.h |  2 ++
> net/bluetooth/hci_core.c         |  2 ++
> net/bluetooth/smp.c              | 23 +++++++++--------------
> 3 files changed, 13 insertions(+), 14 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

