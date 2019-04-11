Return-Path: <SRS0=EB+V=SN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AEA7C10F11
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Apr 2019 01:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FDEC20850
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Apr 2019 01:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbfDKBnI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Apr 2019 21:43:08 -0400
Received: from mail-it1-f199.google.com ([209.85.166.199]:60217 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfDKBnH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Apr 2019 21:43:07 -0400
Received: by mail-it1-f199.google.com with SMTP id 75so4260070itz.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Apr 2019 18:43:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=CoAqwgkJTZGzhrINrMhNBhLM2XrD+z6ak1UE+j6qdNA=;
        b=QBTa7XL7foCx2mCHGRyb0Mujjl4DtekTypmh3hTnKPiVJ4b3qJDs7jk4eSC/0/s36K
         uawnliGgH/76BnJJnZWRZ2zZItuljtUF5we3vRd/UUGvbvU8tDEDgF6yeAU4p5boO/9a
         djatE80Ao0q9gbH2a3cTxQOdYxYI9zY5mCE0QXSc2W7wLNtcwMXx536jvN7kwtf+SLZk
         asS+LYmeGhrL3pGPBKtorlq7T92HI9PSVI0lvvGrd4+5/qJB6H+DegjQFRIMSHG4ttYY
         TymNzuiP+a3nySYn+yAVAQRHOw5G+jhafEUCMZja0sKY6B2eEZsZq8/Gtdvba+AEj+Jw
         EAgQ==
X-Gm-Message-State: APjAAAX92UQIjwivpZZtfvGl2IgNdxp7qAlwDVoqSeKjIpJ26l8NRlKS
        Z1gSVp3zreT4iAzAI5qFbMFk7R0nvsAi0Kbi6QHVHHzxHyyf
X-Google-Smtp-Source: APXvYqwI14HeeShtsJgRzzVTmduxOBHZd181aUzkxgDkHozaJaiO/h0W6D6jSBmhZXmN5gGQhUUHDXQiCHuaq5XBrMWfC+CXhO32
MIME-Version: 1.0
X-Received: by 2002:a24:7f52:: with SMTP id r79mr1646970itc.33.1554946987067;
 Wed, 10 Apr 2019 18:43:07 -0700 (PDT)
Date:   Wed, 10 Apr 2019 18:43:07 -0700
In-Reply-To: <000000000000b7fd51058370d0d9@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cf0d860586374ecb@google.com>
Subject: Re: BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
From:   syzbot <syzbot+91fd909b6e62ebe06131@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        marcel@holtmann.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    771acc7e Bluetooth: btusb: request wake pin with NOAUTOEN
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15f58add200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4fb64439e07a1ec0
dashboard link: https://syzkaller.appspot.com/bug?extid=91fd909b6e62ebe06131
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11770a8f200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=128c945b200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+91fd909b6e62ebe06131@syzkaller.appspotmail.com

BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
turning off the locking correctness validator.
CPU: 0 PID: 1174 Comm: kworker/u5:0 Not tainted 5.1.0-rc4+ #63
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: hci1 hci_power_on
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  add_chain_cache kernel/locking/lockdep.c:2591 [inline]
  lookup_chain_cache_add kernel/locking/lockdep.c:2665 [inline]
  validate_chain kernel/locking/lockdep.c:2685 [inline]
  __lock_acquire.cold+0x250/0x50d kernel/locking/lockdep.c:3701
  lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:4211
  __mutex_lock_common kernel/locking/mutex.c:925 [inline]
  __mutex_lock+0xf7/0x1310 kernel/locking/mutex.c:1072
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1087
  hci_dev_do_close+0x317/0xf20 net/bluetooth/hci_core.c:1696
  hci_power_on+0x1d2/0x580 net/bluetooth/hci_core.c:2191
  process_one_work+0x98e/0x1790 kernel/workqueue.c:2269
  worker_thread+0x98/0xe40 kernel/workqueue.c:2415
  kthread+0x357/0x430 kernel/kthread.c:253
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

