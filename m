Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAE31C2313
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Oct 2024 10:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728295527; cv=none; b=Em4t+8+zgjMpiLlkJB15UHNWUnaUQYvA6+rtDJCFas7Kc0X9Jo7BSSie9PRgfTo82AzaCt+4q74+AcHqTnT+1f0C0Xl1M7+hq3i8pfuiaW2/Nrs54TnkNs4oNTVuFVKN7soQrAECn3NB9Ap9K5cr0OigOex12fZcLmpn8k5el9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728295527; c=relaxed/simple;
	bh=2Wt0V/Vz/aiSpLflh4elr6+OZ4k7gS9jb4qTUdIy1mo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mzo3ZHMr+CV+lH/n6qluzQHaOYC90aVrYYWouATpnnrGciXVffhc0dYst7cVzt94hyPcstBwedGne3HBHiu3fu8IzYm4O5Cky2h+bx1Efqcwptsu+WVmWLdnye+IdWvIiMAwwefo3Fnl0gFr6qvYfj0C5duoIZhqxLd64TbxL8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a1a2af837dso43222165ab.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Oct 2024 03:05:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728295525; x=1728900325;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X01kh1gIFFxGhUhzKX4ciAIgOg6pwgex1rcbKW90r2w=;
        b=vrW3TU25UnBRnIwECgCiz7qJlyZC8KRoly3ec/C8xc14q8W+EqX/5ySTSnp4y9gdiQ
         FMpZlobVicJqSUbgKQhuMowOyY+pFTy0WZp1DwkfczLdiz852qnDAfw398HC6AeBwqaj
         9gMywqKszuflNFojmjHuuvzWOu6vygIgmHifVzPN2ezTN+MjougZM9R5n74OkF0ruMlY
         bH3W9tH1MifZD/5zWou/GemvtT8O805IYMmY8rOZ2dwDBJqrJ6N48lU6RXHCBIhlqqZ5
         bSabWT5cjvn0QefJMoucbS+hsd+qWzeP08l3rziXQjUnCNWMpL7/OBZmgjk26lzFngAa
         ohZg==
X-Forwarded-Encrypted: i=1; AJvYcCW7yv+SGcZ/XO0Kz+t8weuWZScd1Y6sl2zZjUWziAZYKxR/6lIxGhnFV23t5auwR3WlSXl4ffEmPz4bbRzSj/E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7SMyAnpK8s7sL2CQnsWazClhzi9C1XWNiJVsrr+qhWFgo/rF+
	VwQ95xxoI+A3KPJKcKN4wHwn4Rr0ZustOEKWFDGKEkMEUlqqqu+YsaxYLMspM3+M1D0DQV96SF6
	YmYIPWfbJ1ohx6AXyEgagQ5/uT166xhY+FpJXrPgurlCoSW+BzIyiAGw=
X-Google-Smtp-Source: AGHT+IGef1VWg3UYWmhKR/KL/5SC8Mjf6+295aujlCG0T4LoMwGitmfzFiY/lyj3SVtxTNO5XWb6NuoL89PsQZPXXcZqz2gFXuxW
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cdad:0:b0:39f:507a:6170 with SMTP id
 e9e14a558f8ab-3a375cc2165mr85491775ab.8.1728295524904; Mon, 07 Oct 2024
 03:05:24 -0700 (PDT)
Date: Mon, 07 Oct 2024 03:05:24 -0700
In-Reply-To: <00000000000029981d061df08c8d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6703b264.050a0220.49194.0502.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KMSAN: uninit-value in hci_rx_work
From: syzbot <syzbot+6ea290ba76d8c1eb1ac2@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    8cf0b93919e1 Linux 6.12-rc2
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=164bc707980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=981fe2ff8a1e457a
dashboard link: https://syzkaller.appspot.com/bug?extid=6ea290ba76d8c1eb1ac2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=114bc707980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17b74327980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e6ae962426a8/disk-8cf0b939.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6965b62be377/vmlinux-8cf0b939.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1a0056895389/bzImage-8cf0b939.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6ea290ba76d8c1eb1ac2@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in hci_acldata_packet net/bluetooth/hci_core.c:3796 [inline]
BUG: KMSAN: uninit-value in hci_rx_work+0x1092/0x11f0 net/bluetooth/hci_core.c:4030
 hci_acldata_packet net/bluetooth/hci_core.c:3796 [inline]
 hci_rx_work+0x1092/0x11f0 net/bluetooth/hci_core.c:4030
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xae0/0x1c40 kernel/workqueue.c:3310
 worker_thread+0xea7/0x14f0 kernel/workqueue.c:3391
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4091 [inline]
 slab_alloc_node mm/slub.c:4134 [inline]
 kmem_cache_alloc_node_noprof+0x6bf/0xb80 mm/slub.c:4186
 kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:587
 __alloc_skb+0x363/0x7b0 net/core/skbuff.c:678
 alloc_skb include/linux/skbuff.h:1322 [inline]
 bt_skb_alloc include/net/bluetooth/bluetooth.h:493 [inline]
 vhci_get_user drivers/bluetooth/hci_vhci.c:487 [inline]
 vhci_write+0x127/0x900 drivers/bluetooth/hci_vhci.c:607
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0xb28/0x1540 fs/read_write.c:683
 ksys_write+0x24f/0x4c0 fs/read_write.c:736
 __do_sys_write fs/read_write.c:748 [inline]
 __se_sys_write fs/read_write.c:745 [inline]
 __x64_sys_write+0x93/0xe0 fs/read_write.c:745
 x64_sys_call+0x306a/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 UID: 0 PID: 4565 Comm: kworker/u9:1 Not tainted 6.12.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: hci0 hci_rx_work
=====================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
