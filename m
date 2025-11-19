Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B2A371DD7
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Nov 2025 19:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763580731; cv=none; b=U80eTvTzq0Su6kfS0omZZqMZvXWWLHjXHmfdwfLze/loEbef5+BkVmXpW3KgPjxoJGDJ+OUDdoKNXui4ErXgM150rv5Af0tbaFWtuhfBnkTqL+RpPRJBZgJX452rdg6VH7m8l50g7mD5Q7b34HTu8NmlraRwwpc5e8MKZOJUJns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763580731; c=relaxed/simple;
	bh=qQBswjc+KeKVbQcXqPf2gLD57YBurjtXsjy/Iv/n7t0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EER0JXAC5TUYhKTIbBXje0TocZnjfEkroGEKpnvO9JY3TS0dIz6tFn+fehexwsqhiY1SAkOPpfiQN3XwHY2aAaEjsp2NCrtuzUn01SwZsEz6xXyUm2KKzkBg8m5h+iOpC/hLdDxsDwMA0XD0dSQFv56l66WnBtH660k6N/BaEe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-43376637642so1770945ab.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Nov 2025 11:32:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763580722; x=1764185522;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H2Le9Fd/fRw3/uMcOxtAMp9dhGa8mALsRSnwHNbxbHg=;
        b=vofnykIhg/FKQxx6OfiSSR+naIsMmlch9t31QfGGwgNlIPVz11/ZcCq+wdnmGU8UA4
         7fqW3kpZFEJsKc8f9QCUUERR4OKG6MMKv8AVgC3Zzbq0l3Ir6ixKtPjDhOonV7WHgDyR
         uL6NloDrqGuM5JraOn7SXRBAo2ZJWWrQTXGfoUsLXD6CfXeI2CO0buixJO8pk1E9vry2
         KiF/WDuQamLVIOCScheO8igcq9NiY56sCtkRHhIqXqPxihm9xlTgno9XDFZIsEKDBlP+
         sz47iBcx4sRG9tRnvN/NrrkXj3cUslBgLzS1KMgLDIt2qoh+eCX4ESEw9mYSYis0v46I
         ITFg==
X-Gm-Message-State: AOJu0YyqvaN5tIp3Uv67HsGX8CVkjyXRIlNq4cMJZEjlz5DO9sNgRhdy
	ANu25TQdfjxbxymIzUr8Crr0mmcQzo4oGy4IudjbxRihyaWWm9xQFUW6Xs0L8poKH0e1DFGBuWP
	O5a9OM9/q61LiL64nAr21ghlWBD/OmyD8q8n9e0ArbAqYbw5JrbtMkalssXg=
X-Google-Smtp-Source: AGHT+IGrQScWWo45LylkuRv5HGDyobczXYWErcXPx1E+v8CRWPcU17DFoElCjn+IhRNe9LH1A9rrr9GFRDwbOs6KC5iTCNajOJ3p
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a0f:b0:431:d864:366a with SMTP id
 e9e14a558f8ab-435a9011733mr8980315ab.2.1763580722699; Wed, 19 Nov 2025
 11:32:02 -0800 (PST)
Date: Wed, 19 Nov 2025 11:32:02 -0800
In-Reply-To: <6d2a1c9f-d4db-496d-9230-e41e5166eb86@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <691e1b32.a70a0220.2ea503.001f.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] [usb?] memory leak in __hci_cmd_sync_sk
From: syzbot <syzbot+f098d64cc684b8dbaf65@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ssranevjti@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
memory leak in __hci_cmd_sync_sk

2025/11/19 19:30:48 executed programs: 47
2025/11/19 19:30:56 executed programs: 49
2025/11/19 19:31:03 executed programs: 51
2025/11/19 19:31:11 executed programs: 53
BUG: memory leak
unreferenced object 0xffff888111aec700 (size 240):
  comm "kworker/u9:1", pid 5135, jiffies 4294955520
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc d1edf5a3):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4983 [inline]
    slab_alloc_node mm/slub.c:5288 [inline]
    kmem_cache_alloc_node_noprof+0x36f/0x5e0 mm/slub.c:5340
    __alloc_skb+0x203/0x240 net/core/skbuff.c:660
    alloc_skb include/linux/skbuff.h:1383 [inline]
    bt_skb_alloc include/net/bluetooth/bluetooth.h:510 [inline]
    hci_cmd_sync_alloc+0x30/0x140 net/bluetooth/hci_sync.c:58
    hci_cmd_sync_add net/bluetooth/hci_sync.c:99 [inline]
    __hci_cmd_sync_sk+0x84/0x290 net/bluetooth/hci_sync.c:168
    __hci_cmd_sync_ev+0x3e/0x50 net/bluetooth/hci_sync.c:255
    send_hci_cmd_sync+0x5e/0xf0 net/bluetooth/mgmt.c:2615
    hci_cmd_sync_work+0xd5/0x160 net/bluetooth/hci_sync.c:337
    process_one_work+0x26b/0x620 kernel/workqueue.c:3263
    process_scheduled_works kernel/workqueue.c:3346 [inline]
    worker_thread+0x2c4/0x4f0 kernel/workqueue.c:3427
    kthread+0x15b/0x310 kernel/kthread.c:463
    ret_from_fork+0x210/0x240 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

BUG: memory leak
unreferenced object 0xffff88810a34a680 (size 704):
  comm "kworker/u9:1", pid 5135, jiffies 4294955520
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 01 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 4e765d9f):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4983 [inline]
    slab_alloc_node mm/slub.c:5288 [inline]
    kmem_cache_alloc_node_noprof+0x36f/0x5e0 mm/slub.c:5340
    kmalloc_reserve+0xe6/0x180 net/core/skbuff.c:579
    __alloc_skb+0xd4/0x240 net/core/skbuff.c:670
    alloc_skb include/linux/skbuff.h:1383 [inline]
    bt_skb_alloc include/net/bluetooth/bluetooth.h:510 [inline]
    hci_cmd_sync_alloc+0x30/0x140 net/bluetooth/hci_sync.c:58
    hci_cmd_sync_add net/bluetooth/hci_sync.c:99 [inline]
    __hci_cmd_sync_sk+0x84/0x290 net/bluetooth/hci_sync.c:168
    __hci_cmd_sync_ev+0x3e/0x50 net/bluetooth/hci_sync.c:255
    send_hci_cmd_sync+0x5e/0xf0 net/bluetooth/mgmt.c:2615
    hci_cmd_sync_work+0xd5/0x160 net/bluetooth/hci_sync.c:337
    process_one_work+0x26b/0x620 kernel/workqueue.c:3263
    process_scheduled_works kernel/workqueue.c:3346 [inline]
    worker_thread+0x2c4/0x4f0 kernel/workqueue.c:3427
    kthread+0x15b/0x310 kernel/kthread.c:463
    ret_from_fork+0x210/0x240 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

connection error: failed to recv *flatrpc.ExecutorMessageRawT: EOF


Tested on:

commit:         23cb64fb Merge tag 'soc-fixes-6.18-3' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13e81a12580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f30cc590c4f6da44
dashboard link: https://syzkaller.appspot.com/bug?extid=f098d64cc684b8dbaf65
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10d6f332580000

