Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439BF25F98A
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Nov 2025 14:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763389473; cv=none; b=PNNB5Htk3ktBGEbldPBqkJenuw6V5uj/g889CjviIyLXoZzpFYGsj3v5gZfOYxz/qoY83bDXKo7Pe1lYcjfoImGyqjV2GzsKZiZSpfXtC+XP9vbMrtdMMPhHTEqQJP2GwVcTZdAoaaBjH+CNYacZkzGaNiTXEdD5URSPwf6XTog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763389473; c=relaxed/simple;
	bh=+WnHARyZtydI4Bj4wx3QFcE2kybwmprPbxnEnrPT52Q=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Gm42IUJ9zBtIAh0D8dHQJoOPKzDexrT8OF+Ze442j6t8fZWI2JZCHTcQ2Ji4SIi8HuExVZQi7zygqKw3mTJgZP8eN68blalfVDmanfQ4Y9HBcwMbxYt9qrFOhYw0ANcJY557+0OW6Zfg1t8Q9aBMmsn2sLj4XvaMD+dZAEjuGjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-434a83cd402so12235245ab.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Nov 2025 06:24:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763389470; x=1763994270;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TroKSSOOY32YSuyTmBNMMILgpi/Ky4EqsVpoXNyy8L4=;
        b=QtYJWBG/7lFiryzJtC/HEKVYg+Yn+SflcWcndtgvomgd+17CDDrOXGhy5rnLassjsh
         dZ/1KUvKG8LnJfsxyHHi8oItUK3HMoYIZcR5jeMbEO76tidux29WopXr+77TQEdd4dWw
         qOn2G3l2dn4cTkXD616cx27K7iPDzO+pbjDdzf2m7nXS/HQ55LvrYXwsbM81KuMzGgOP
         HDHTJ/cQZc+i5M6dROUq5gvCiS9OE5on6YHregwkUxIxxR8I8gsNV1OsCLMAAt9yZIFD
         rbb7es5d849uHawiQY+QuZz5hBM3MCxorkTruFtY3uGiRWbNHbfOwRZiAD+9aG1X0Jmj
         7QAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVz2qHWIgssRyqJQUD9M+Eoog3ubBpMZ0yghwQgMSGXHlyy0tIPPfpXt9cp6Y2ObwlhBo/aE2fJKGz6jcimcDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhSLGDBAoKK/ThThlmo2xApNsIa9PQQLKQwN0tqBQxucd5QDxq
	KPdMpOf69EhPAHTMr1243corlz4PrNkUctWs8jbX9Xb2If4IMGR9Av+uT1mvA8yz7iMXR3NRPnh
	slJsj0ZIad52yDb5ODeIMYkebHkFS+qX29mAVR/8oAyGoVpWilmErRqYLwF8=
X-Google-Smtp-Source: AGHT+IEQkT1KcZ/RnyNM7F0CuS3t9HPv2teDm+oZFDsOR2tvuvSHefwFo7D0TP62D+CKHT1/OwGORuLrSVYAuTuaxqpNR+yoBtT8
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3389:b0:433:74ba:8bf5 with SMTP id
 e9e14a558f8ab-4348c9496e4mr153121245ab.23.1763389470497; Mon, 17 Nov 2025
 06:24:30 -0800 (PST)
Date: Mon, 17 Nov 2025 06:24:30 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <691b301e.a70a0220.f6df1.0011.GAE@google.com>
Subject: [syzbot] [bluetooth?] [usb?] memory leak in __hci_cmd_sync_sk
From: syzbot <syzbot+f098d64cc684b8dbaf65@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, luiz.dentz@gmail.com, 
	marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e927c520e1ba Merge tag 'loongarch-fixes-6.18-1' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10158d32580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb128cd5cb439809
dashboard link: https://syzkaller.appspot.com/bug?extid=f098d64cc684b8dbaf65
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1782c914580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10a5f0b4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b755c257d71b/disk-e927c520.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b906cb4856d7/vmlinux-e927c520.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bb3525aba146/bzImage-e927c520.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f098d64cc684b8dbaf65@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff888112c22900 (size 240):
  comm "kworker/u9:1", pid 5133, jiffies 4294947154
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 6c5ee80a):
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
    __hci_cmd_sync_ev+0x3e/0x50 net/bluetooth/hci_sync.c:250
    send_hci_cmd_sync+0x5e/0xf0 net/bluetooth/mgmt.c:2615
    hci_cmd_sync_work+0xd5/0x160 net/bluetooth/hci_sync.c:332
    process_one_work+0x26b/0x620 kernel/workqueue.c:3263
    process_scheduled_works kernel/workqueue.c:3346 [inline]
    worker_thread+0x2c4/0x4f0 kernel/workqueue.c:3427
    kthread+0x15b/0x310 kernel/kthread.c:463
    ret_from_fork+0x210/0x240 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

BUG: memory leak
unreferenced object 0xffff88810b0ee3c0 (size 704):
  comm "kworker/u9:1", pid 5133, jiffies 4294947154
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
    __hci_cmd_sync_ev+0x3e/0x50 net/bluetooth/hci_sync.c:250
    send_hci_cmd_sync+0x5e/0xf0 net/bluetooth/mgmt.c:2615
    hci_cmd_sync_work+0xd5/0x160 net/bluetooth/hci_sync.c:332
    process_one_work+0x26b/0x620 kernel/workqueue.c:3263
    process_scheduled_works kernel/workqueue.c:3346 [inline]
    worker_thread+0x2c4/0x4f0 kernel/workqueue.c:3427
    kthread+0x15b/0x310 kernel/kthread.c:463
    ret_from_fork+0x210/0x240 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

BUG: memory leak
unreferenced object 0xffff888112c22b00 (size 240):
  comm "kworker/u9:1", pid 5133, jiffies 4294947360
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc a204b710):
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
    __hci_cmd_sync_ev+0x3e/0x50 net/bluetooth/hci_sync.c:250
    send_hci_cmd_sync+0x5e/0xf0 net/bluetooth/mgmt.c:2615
    hci_cmd_sync_work+0xd5/0x160 net/bluetooth/hci_sync.c:332
    process_one_work+0x26b/0x620 kernel/workqueue.c:3263
    process_scheduled_works kernel/workqueue.c:3346 [inline]
    worker_thread+0x2c4/0x4f0 kernel/workqueue.c:3427
    kthread+0x15b/0x310 kernel/kthread.c:463
    ret_from_fork+0x210/0x240 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

BUG: memory leak
unreferenced object 0xffff88810b0edb80 (size 704):
  comm "kworker/u9:1", pid 5133, jiffies 4294947360
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
    __hci_cmd_sync_ev+0x3e/0x50 net/bluetooth/hci_sync.c:250
    send_hci_cmd_sync+0x5e/0xf0 net/bluetooth/mgmt.c:2615
    hci_cmd_sync_work+0xd5/0x160 net/bluetooth/hci_sync.c:332
    process_one_work+0x26b/0x620 kernel/workqueue.c:3263
    process_scheduled_works kernel/workqueue.c:3346 [inline]
    worker_thread+0x2c4/0x4f0 kernel/workqueue.c:3427
    kthread+0x15b/0x310 kernel/kthread.c:463
    ret_from_fork+0x210/0x240 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

connection error: failed to recv *flatrpc.ExecutorMessageRawT: EOF


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
