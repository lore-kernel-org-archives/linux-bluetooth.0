Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C3DC433ED
	for <linux-bluetooth@archiver.kernel.org>; Mon,  5 Apr 2021 17:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CEDF6139C
	for <linux-bluetooth@archiver.kernel.org>; Mon,  5 Apr 2021 17:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238727AbhDEReZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 5 Apr 2021 13:34:25 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:34697 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238705AbhDEReZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 5 Apr 2021 13:34:25 -0400
Received: by mail-il1-f197.google.com with SMTP id l7so2118271iln.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Apr 2021 10:34:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=vd51XgEIvP4DQDs0VI5+bjubW08Kj6vjDtH+/7eNtLk=;
        b=r3xigJW+eqEzN4Y+w4jQ7Bj9Gw0chAK3MxC0YB/k/CQd2sTVl/B5WSokKlGvkP8fYi
         ydTMTmIYcFW6v2xnZ8U0NnRr56OuwIpeAkyoWhaF8Ml59jRQAkqvlv8S+sPcwIGgm5IH
         unj1WQXUTGoiAy6KW4Qr05fJULjw8lKGhXIyKHG2Wb6hALoKQAJyeQquZhqQBomPPKzd
         FXDmei1zrYdqx/rW0C3jARNYymSe9pHEnx63W7K8/MFIczePAcoBzg7AaJNcCmiuMjJu
         2Xgng0YkO0I5bItcA1ZuEuyz8F4cRMDTu5UwK2+l/zJ04WGIehtse/pGQIbf8X5JBhUC
         IxWQ==
X-Gm-Message-State: AOAM533IDcCcnC7+eL5/JRNR7DRUJN9564ZozIMbD28XwYyeJwYL1scy
        HgI/nzA/8DUGGN81azYkm2+t/sxyCdyX6jzi4PzFO9FPLRdx
X-Google-Smtp-Source: ABdhPJxoaysSvm/vwPCZE9vCdUOjIG9huA7+Z034KzCf5cRvCelFCyvZ8u9yGuK1MunvlnEZcan1x4bLAO6PZp/nV+pIRNS2I2e7
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:149:: with SMTP id j9mr21536639ilr.57.1617644058638;
 Mon, 05 Apr 2021 10:34:18 -0700 (PDT)
Date:   Mon, 05 Apr 2021 10:34:18 -0700
In-Reply-To: <0000000000003798d705aedd870d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007cfd9b05bf3d1b70@google.com>
Subject: Re: [syzbot] memory leak in mgmt_cmd_status
From:   syzbot <syzbot+80f5bab4eb14d14e7386@syzkaller.appspotmail.com>
To:     anant.thazhemadam@gmail.com, davem@davemloft.net,
        johan.hedberg@gmail.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        luiz.dentz@gmail.com, marcel@holtmann.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    e49d033b Linux 5.12-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12579f11d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b8dbd3c72fdc7777
dashboard link: https://syzkaller.appspot.com/bug?extid=80f5bab4eb14d14e7386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=143b1696d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14c5a30ed00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+80f5bab4eb14d14e7386@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88810ddf4700 (size 232):
  comm "kworker/u5:2", pid 8406, jiffies 4294997792 (age 10.670s)
  hex dump (first 32 bytes):
    d0 f0 af 0e 81 88 ff ff d0 f0 af 0e 81 88 ff ff  ................
    00 00 00 00 00 00 00 00 00 f0 af 0e 81 88 ff ff  ................
  backtrace:
    [<ffffffff8364af8f>] __alloc_skb+0x20f/0x280 net/core/skbuff.c:412
    [<ffffffff83c5f871>] alloc_skb include/linux/skbuff.h:1103 [inline]
    [<ffffffff83c5f871>] mgmt_cmd_status+0x31/0x160 net/bluetooth/mgmt_util.c:102
    [<ffffffff83c2a669>] mgmt_set_discoverable_complete+0x1b9/0x1e0 net/bluetooth/mgmt.c:1357
    [<ffffffff83c579d8>] discoverable_update_work+0x88/0xb0 net/bluetooth/hci_request.c:2806
    [<ffffffff812595d9>] process_one_work+0x2c9/0x600 kernel/workqueue.c:2275
    [<ffffffff81259ec9>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2421
    [<ffffffff812615f8>] kthread+0x178/0x1b0 kernel/kthread.c:292
    [<ffffffff8100227f>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294


