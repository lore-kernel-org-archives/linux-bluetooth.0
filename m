Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247531624D2
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Feb 2025 07:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740381566; cv=none; b=jR1mnHhLHKEFQ63bnCz8bEh/KbwaOIEbsK4/fMGQtU+jnTLoGCgeSCKRWXcDx/PYFDqR70QtqDC0NykI5Rnjklb8gReLh5rN0kAVo0hp7GCVk/BCcANeCjnSy6uZoZr4oduc0e4LXbSnzgJK+Fpi0uOgm7kt5dyLHQEiPy/Xjpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740381566; c=relaxed/simple;
	bh=CIDn+ALP5+YZ3X6AHb4m7RHlrOetynMzlJ3aT6RyU/c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NFrKEn/V+Y34OwLpJ/FCvs5im3U2cNj227zcvR0yssHgxrhRR75zDoBsoGxEyjFTs4MMsla/EIJ4qxply1hwNWuLLsBz9o4IggvVHYuLyn3Un0o2bGwh5DBgbpQQ4f83GsFjhq095Upei6ppH469NAO/t2VaphrBQtXtXaNPnys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3ce81a40f5cso89817765ab.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 23 Feb 2025 23:19:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740381564; x=1740986364;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fDkjI7TZQOqzogc1scedMJVDz11Q7QnC3E+tJ2nX3Is=;
        b=HhUZv3rtIdjP4CXqD0qAqb13w5jtw4PeON83oGz6TjQs/r2acH2ubgDBA1M4r21FSn
         e9l8FOcOK6ik80oix9LjafTU0SIwGI5SaKwLHKiPY29ZtQcVFedL7TXsvLYJER1fsarw
         PQQNWKg7HvMLKVA6Nm6UNQ0GBCX2ZMWC9VctnyvxZNEu8RFqiL+xbiSlQphaiRfJK0BT
         YFMW/AC9ePqno2BtR3R/GePxllC6FfzCVz9Z6ugdr52ONEOrwiPrgSKSGz5HLP8EVx9+
         8v/agMC0hcc7t7kCw2yNbmjyhkBJtlk3TfUj9U7VwEONY23SkluF837tzZEJbJ3Qfi8D
         nfZA==
X-Forwarded-Encrypted: i=1; AJvYcCVFfJIeyVqhVlUDmI1CYsV+DGMPekKnUyZ03z4jf4B3mE9a/Ngx/plKXtS4uaL3rC/bNaYiRXQUKES98cyY+Ak=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2vMGlpBiK/S9hw9ceLo2KsUtOv/ioFnQ3fwVdR2OL4jWw9yYC
	fxWT6jYAWVjPij9yre53hPQjqoRtiEg8oyVJD5OflhQ+bwXu9kfzEabRFfktSksmBT9ufZCgTBY
	oGZp5RXTS/H73U9gHSQNJnGn30x0TLN8kaukv/ceGnetWP6DV/AiVCkY=
X-Google-Smtp-Source: AGHT+IH8trvNnw2ARoTG9a/tL6VFuC6N2KzhOY09N04NajQt3QCDKWffEax/FdEfEEsQiFCKawsZKc30X3+0ccRmy1SN5+F9DPwz
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a67:b0:3d0:3851:c3cc with SMTP id
 e9e14a558f8ab-3d2caf19e17mr110305335ab.16.1740381564194; Sun, 23 Feb 2025
 23:19:24 -0800 (PST)
Date: Sun, 23 Feb 2025 23:19:24 -0800
In-Reply-To: <67389a73.050a0220.bb738.000a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67bc1d7c.050a0220.bbfd1.0045.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KMSAN: uninit-value in hci_cmd_complete_evt
From: syzbot <syzbot+a9a4bedfca6aa9d7fa24@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    d082ecbc71e9 Linux 6.14-rc4
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13492db0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d66f6f82ee090382
dashboard link: https://syzkaller.appspot.com/bug?extid=a9a4bedfca6aa9d7fa24
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=122c37f8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10023fdf980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a9f22e75faf0/disk-d082ecbc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/336a72a11410/vmlinux-d082ecbc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7180e4935c41/bzImage-d082ecbc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a9a4bedfca6aa9d7fa24@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in hci_cmd_complete_evt+0xd7b/0xeb0 net/bluetooth/hci_event.c:4226
 hci_cmd_complete_evt+0xd7b/0xeb0 net/bluetooth/hci_event.c:4226
 hci_event_func net/bluetooth/hci_event.c:7470 [inline]
 hci_event_packet+0x11c8/0x1ca0 net/bluetooth/hci_event.c:7525
 hci_rx_work+0x699/0x1260 net/bluetooth/hci_core.c:4015
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xc1a/0x1e80 kernel/workqueue.c:3317
 worker_thread+0xea7/0x14f0 kernel/workqueue.c:3398
 kthread+0x6b9/0xef0 kernel/kthread.c:464
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was stored to memory at:
 hci_cmd_complete_evt+0xaf4/0xeb0
 hci_event_func net/bluetooth/hci_event.c:7470 [inline]
 hci_event_packet+0x11c8/0x1ca0 net/bluetooth/hci_event.c:7525
 hci_rx_work+0x699/0x1260 net/bluetooth/hci_core.c:4015
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xc1a/0x1e80 kernel/workqueue.c:3317
 worker_thread+0xea7/0x14f0 kernel/workqueue.c:3398
 kthread+0x6b9/0xef0 kernel/kthread.c:464
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4121 [inline]
 slab_alloc_node mm/slub.c:4164 [inline]
 kmem_cache_alloc_node_noprof+0x907/0xe00 mm/slub.c:4216
 kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:515
 __alloc_skb+0x363/0x7b0 net/core/skbuff.c:606
 alloc_skb include/linux/skbuff.h:1331 [inline]
 bt_skb_alloc include/net/bluetooth/bluetooth.h:495 [inline]
 vhci_get_user drivers/bluetooth/hci_vhci.c:487 [inline]
 vhci_write+0x127/0x900 drivers/bluetooth/hci_vhci.c:607
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0xb34/0x1540 fs/read_write.c:679
 ksys_write+0x240/0x4b0 fs/read_write.c:731
 __do_sys_write fs/read_write.c:742 [inline]
 __se_sys_write fs/read_write.c:739 [inline]
 __x64_sys_write+0x93/0xe0 fs/read_write.c:739
 x64_sys_call+0x3161/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 UID: 0 PID: 5777 Comm: kworker/u9:2 Not tainted 6.14.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Workqueue: hci0 hci_rx_work
=====================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
