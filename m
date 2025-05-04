Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D94E320F
	for <linux-bluetooth@vger.kernel.org>; Sun,  4 May 2025 05:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746338312; cv=none; b=u1Toho6CoNcyMbyT6uQO72cbACztqKO2K18HiuJ/xsM8x1Mhkq6y4uZrVUaSTLVdASSihd8QKuYW/As9tZKKJjMS+XNM+sxWuawTrK7BbwuUn7SkUJBIUlSo93e65sBGVIy9S7r2egIci3oqyDl8OpAKiBBAS8IcHF0AtJWXpfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746338312; c=relaxed/simple;
	bh=C+NJREbjZHlkC4SmLpn28LD3vALp7XueDhZJzreDxA0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=EMGregee7toqPLMWxPZQTBWMkCnU7CGEWfydb2WT9AIG4Pj26fu138CRdn37/ZLuRBsZyYDI+Sc72UJV+9gBqYBNpEFZh7Z1fj4S4G4aYZTxkx5nQY480dvow5ZRwwyHacIKykvH1A2iptQHuvctBv9wz9YXogOAk30pOty8it8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3d81bc9b763so60853775ab.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 03 May 2025 22:58:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746338309; x=1746943109;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DbQqApIzvhBjEPXZiijFgh5kmbfJbSGEYB8VYYN9zwk=;
        b=tbu6/YDkNNHB3+OobmRLkUl7iIM3x7WG7nertVR8bn0hDZZPAXsou/biJehYnOGVZ+
         DbNEkW1/D0xktz4TiPIkXVpFvW6GyGsWZB7rxyMM85rsacDNQiK2TFzq1Nfi0axZU1zI
         Kp6u070PQL/mD1dOjC7tkMx+iZfAoG9pqgiuw65rnQJut1v3dxJylwwYYGWhBtU7/3UE
         lC/ubw9dHWUiviBO5bElKKmCgL0bpr4PcvVxywtDVkaTIsuEKYl909Dehm/MeZYUFap4
         2641rhGWOpoFPEqYRGuKeFh2TgUiTY/bGUnuqG4tgX6AO/mNFMPnNNBhqRkFL8m/Bgj2
         NY9g==
X-Forwarded-Encrypted: i=1; AJvYcCVWc8Y45EsDp6NiKOWKsxpBaxeLorQM9ae/qf1FnWj41rSuoD6bcw9UYTTFktr95eQfKrlw4MBhLbE9IYkEzhU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmE95K6tsXXNy/TA1b5RXZoIyK24TsSjP51L9A6el2+tnFp/42
	QtyXoWLsaypJo71RlslHL/NjF7526LLS9OnFoQS/6CfAbqGYVsGa2uVCr2rFLlOTCfw6XTMZ42m
	oZwQRfFhOKrLlfQxzjWeCgbtwoEgvXjEjFai/JzuBrg8RQ/ERFqXjumo=
X-Google-Smtp-Source: AGHT+IFo57YDSpv6K+11CSKhhJqQq1zszsSXLf01+yYrpmsWgKzjemrhfDbmWFJWyZuDaYdGfiNJhzDMWeCqNwfhByLibo4jnIb3
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:258f:b0:3d0:4e0c:2c96 with SMTP id
 e9e14a558f8ab-3da5b23bd18mr29146275ab.2.1746338309265; Sat, 03 May 2025
 22:58:29 -0700 (PDT)
Date: Sat, 03 May 2025 22:58:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68170205.050a0220.11da1b.0028.GAE@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-out-of-bounds Read in hci_cmd_sync_alloc
From: syzbot <syzbot+5fe2d5bfbfbec0b675a0@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8bac8898fe39 Merge tag 'mmc-v6.15-rc1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=137a0f74580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=541aa584278da96c
dashboard link: https://syzkaller.appspot.com/bug?extid=5fe2d5bfbfbec0b675a0
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=102d6774580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1025f368580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-8bac8898.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5f7c2d7e1cd1/vmlinux-8bac8898.xz
kernel image: https://storage.googleapis.com/syzbot-assets/77a157d2769a/bzImage-8bac8898.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5fe2d5bfbfbec0b675a0@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in skb_put_data include/linux/skbuff.h:2752 [inline]
BUG: KASAN: slab-out-of-bounds in hci_cmd_sync_alloc+0x300/0x3a0 net/bluetooth/hci_sync.c:67
Read of size 29542 at addr ffff888025996aa6 by task kworker/u33:0/68

CPU: 3 UID: 0 PID: 68 Comm: kworker/u33:0 Not tainted 6.15.0-rc4-syzkaller-00040-g8bac8898fe39 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: hci0 hci_cmd_sync_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xc3/0x670 mm/kasan/report.c:521
 kasan_report+0xe0/0x110 mm/kasan/report.c:634
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0xef/0x1a0 mm/kasan/generic.c:189
 __asan_memcpy+0x23/0x60 mm/kasan/shadow.c:105
 skb_put_data include/linux/skbuff.h:2752 [inline]
 hci_cmd_sync_alloc+0x300/0x3a0 net/bluetooth/hci_sync.c:67
 hci_cmd_sync_add net/bluetooth/hci_sync.c:99 [inline]
 __hci_cmd_sync_sk+0x157/0xc90 net/bluetooth/hci_sync.c:168
 __hci_cmd_sync_ev+0x3e/0x50 net/bluetooth/hci_sync.c:250
 send_hci_cmd_sync+0x18d/0x3f0 net/bluetooth/mgmt.c:2540
 hci_cmd_sync_work+0x1a8/0x430 net/bluetooth/hci_sync.c:332
 process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c2/0x780 kernel/kthread.c:464
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 5927:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4341 [inline]
 __kmalloc_node_track_caller_noprof+0x221/0x510 mm/slub.c:4360
 kmemdup_noprof+0x29/0x60 mm/util.c:137
 kmemdup_noprof include/linux/fortify-string.h:765 [inline]
 mgmt_pending_new+0x10b/0x290 net/bluetooth/mgmt_util.c:259
 mgmt_hci_cmd_sync net/bluetooth/mgmt.c:2574 [inline]
 mgmt_hci_cmd_sync+0x58/0x1c0 net/bluetooth/mgmt.c:2562
 hci_mgmt_cmd net/bluetooth/hci_sock.c:1712 [inline]
 hci_sock_sendmsg+0x151f/0x25e0 net/bluetooth/hci_sock.c:1832
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg net/socket.c:727 [inline]
 sock_write_iter+0x4fc/0x5b0 net/socket.c:1131
 new_sync_write fs/read_write.c:591 [inline]
 vfs_write+0x5ba/0x1180 fs/read_write.c:684
 ksys_write+0x205/0x240 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888025996aa0
 which belongs to the cache kmalloc-8 of size 8
The buggy address is located 6 bytes inside of
 allocated 7-byte region [ffff888025996aa0, ffff888025996aa7)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x25996
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801b442500 dead000000000100 dead000000000122
raw: 0000000000000000 0000000080800080 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 1, tgid 1 (swapper/0), ts 8553722382, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x181/0x1b0 mm/page_alloc.c:1718
 prep_new_page mm/page_alloc.c:1726 [inline]
 get_page_from_freelist+0x135c/0x3920 mm/page_alloc.c:3688
 __alloc_frozen_pages_noprof+0x263/0x23a0 mm/page_alloc.c:4970
 alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2301
 alloc_slab_page mm/slub.c:2468 [inline]
 allocate_slab mm/slub.c:2632 [inline]
 new_slab+0x244/0x340 mm/slub.c:2686
 ___slab_alloc+0xd9c/0x1940 mm/slub.c:3872
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3962
 __slab_alloc_node mm/slub.c:4037 [inline]
 slab_alloc_node mm/slub.c:4198 [inline]
 __do_kmalloc_node mm/slub.c:4340 [inline]
 __kmalloc_node_noprof+0x2ed/0x500 mm/slub.c:4347
 kmalloc_array_node_noprof include/linux/slab.h:1020 [inline]
 blk_mq_alloc_tag_set+0x414/0x1250 block/blk-mq.c:4788
 loop_add+0x3b7/0xb70 drivers/block/loop.c:1986
 loop_init+0x164/0x270 drivers/block/loop.c:2225
 do_one_initcall+0x120/0x6e0 init/main.c:1257
 do_initcall_level init/main.c:1319 [inline]
 do_initcalls init/main.c:1335 [inline]
 do_basic_setup init/main.c:1354 [inline]
 kernel_init_freeable+0x5c2/0x900 init/main.c:1567
 kernel_init+0x1c/0x2b0 init/main.c:1457
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888025996980: 05 fc fc fc 05 fc fc fc 05 fc fc fc 05 fc fc fc
 ffff888025996a00: 05 fc fc fc 04 fc fc fc 04 fc fc fc 04 fc fc fc
>ffff888025996a80: 00 fc fc fc 07 fc fc fc 06 fc fc fc 06 fc fc fc
                               ^
 ffff888025996b00: 06 fc fc fc 04 fc fc fc 06 fc fc fc 02 fc fc fc
 ffff888025996b80: 02 fc fc fc 05 fc fc fc 05 fc fc fc 05 fc fc fc
==================================================================


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
