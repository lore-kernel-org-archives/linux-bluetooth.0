Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7736223BE
	for <linux-bluetooth@vger.kernel.org>; Sun, 29 Dec 2024 04:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735446623; cv=none; b=tGibaOlsDBJgxP3s2ETz1WmxAGmWqnZsQW7EaeHOGGaEu67y2tN/H6vdGz1J+p6dRv6wezU66ui60RU9eh3ADJJ4hKqDlrNA/X1at7Eeyh74Xh7iFqCIoNX2l1fHhBLy8CS/7tM4pV5BLoFYG/fWRmfeJ9/lBsd9LqwRXAO1xBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735446623; c=relaxed/simple;
	bh=Z7YhTX6/uPOjnzMI1UHOMTlHau9QTnJ42oFjs0a4qZM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=C/P/aK9oND+5m5h1dR9RQiJKAkcaeLamAulxAhYfENazBFmuBV83rR/Ebz2C4S24J0uprN2JszrdKWg+qvtgdJCYCI/G25mhZ3gTQ9k0pcOiyYo/kqn4O6rD4fdiepFV0dmmXkDhvqrTAAG6juaONxzpdp6IshX/FTULT/JqaME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3a7e0d5899bso187181975ab.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 28 Dec 2024 20:30:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735446620; x=1736051420;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dF12ViYobOUCOH5ZQAkbdLAFFZ4Bq6Dl8gqtS7xehEI=;
        b=qXo0O3HTNzZ/QKBTPTJnGg1Wb8z8bJuKLwqFNgVuCTaLiM+/zSdln0TcF0PrK+KS1y
         afz3B5bqBgH/noFzCe4+lN08LKvnMHvipq2UeiLgnU179lGf6eW61pzMyAt2972BzqS8
         m60/X0Qq+U8sjde4cK0Q5C0xxDvqWULiExY4CshiobMCIUfoII2+gEjtA0HDvNoIQPDO
         yL3tUkgsqz13HUhX4XKwguBygVJZJp148j5bz1PdZuL0zlb6uF7JdEYP1oesWfBi3gOx
         gNhnqiJhH0Sqwkx3ommM7HLz3+S6JweVbPxtdzDDwJYx1akni5jyVVB41nAbi9bAb9QW
         SohQ==
X-Gm-Message-State: AOJu0Yw022gm2GUACH7L51CEhMvuIijyMl+kakXI4OxM2kfgOlX+Hk3t
	nQ2zkMvUtwDD0etwFwHG2YGG26tVx9nTs/Pfz2b1I4dinxmpy+Si/9aacGsJNJUnuZvdh/zmBBS
	8BEaKtRzCdpih7G8vVQGpuuR1wKJk/qBdLKoccEoBEabSJ6PfaemkOcvYTg==
X-Google-Smtp-Source: AGHT+IGBTj4zHsI8Gx2eln8qKkZdLwhXfG6QvbZmcTI3xHBlHDh3sMj/t9oQ88/JUjf18F5BkNG3j/YLS0rJN82Mc90eUFNWgftS
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aaa:b0:3a7:e01b:6410 with SMTP id
 e9e14a558f8ab-3c2d5151684mr284553515ab.18.1735446620714; Sat, 28 Dec 2024
 20:30:20 -0800 (PST)
Date: Sat, 28 Dec 2024 20:30:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6770d05c.050a0220.2f3838.04a0.GAE@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in full_proxy_write
From: syzbot <syzbot+422b07c3add2219bc947@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    059dd502b263 Merge tag 'block-6.13-20241228' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17abc818580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c078001e66e4a17e
dashboard link: https://syzkaller.appspot.com/bug?extid=422b07c3add2219bc947
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b23b5d964e6e/disk-059dd502.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6c382805ea80/vmlinux-059dd502.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b17a5405f713/bzImage-059dd502.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+422b07c3add2219bc947@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in force_wakeup_write+0x14d/0x170 drivers/bluetooth/hci_vhci.c:188
Read of size 1 at addr ffff888028691a31 by task syz.7.3703/20148

CPU: 1 UID: 0 PID: 20148 Comm: syz.7.3703 Not tainted 6.13.0-rc4-syzkaller-00078-g059dd502b263 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:489
 kasan_report+0xd9/0x110 mm/kasan/report.c:602
 force_wakeup_write+0x14d/0x170 drivers/bluetooth/hci_vhci.c:188
 full_proxy_write+0xfb/0x1b0 fs/debugfs/file.c:356
 vfs_write+0x24c/0x1150 fs/read_write.c:677
 ksys_write+0x12b/0x250 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7feab1385d29
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007feab2194038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007feab1575fa0 RCX: 00007feab1385d29
RDX: 0000000000000001 RSI: 0000000020001780 RDI: 0000000000000003
RBP: 00007feab1401b08 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007feab1575fa0 R15: 00007ffc57227238
 </TASK>

Allocated by task 13617:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4298 [inline]
 __kmalloc_noprof+0x21a/0x4f0 mm/slub.c:4310
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 ieee802_11_parse_elems_full+0xe6/0x1630 net/mac80211/parse.c:958
 ieee802_11_parse_elems_crc net/mac80211/ieee80211_i.h:2384 [inline]
 ieee802_11_parse_elems net/mac80211/ieee80211_i.h:2391 [inline]
 ieee80211_inform_bss+0xf1/0x10f0 net/mac80211/scan.c:79
 rdev_inform_bss net/wireless/rdev-ops.h:418 [inline]
 cfg80211_inform_single_bss_data+0x8b1/0x1e40 net/wireless/scan.c:2334
 cfg80211_inform_bss_data+0x254/0x3e40 net/wireless/scan.c:3189
 cfg80211_inform_bss_frame_data+0x252/0x8a0 net/wireless/scan.c:3284
 ieee80211_bss_info_update+0x311/0xab0 net/mac80211/scan.c:226
 ieee80211_rx_bss_info net/mac80211/ibss.c:1101 [inline]
 ieee80211_rx_mgmt_probe_beacon net/mac80211/ibss.c:1580 [inline]
 ieee80211_ibss_rx_queued_mgmt+0x1956/0x3040 net/mac80211/ibss.c:1607
 ieee80211_iface_process_skb net/mac80211/iface.c:1613 [inline]
 ieee80211_iface_work+0xc0b/0xf00 net/mac80211/iface.c:1667
 cfg80211_wiphy_work+0x3de/0x560 net/wireless/core.c:440
 process_one_work+0x958/0x1b30 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Freed by task 13617:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:582
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2353 [inline]
 slab_free mm/slub.c:4613 [inline]
 kfree+0x14f/0x4b0 mm/slub.c:4761
 ieee80211_inform_bss+0xa36/0x10f0 net/mac80211/scan.c:160
 rdev_inform_bss net/wireless/rdev-ops.h:418 [inline]
 cfg80211_inform_single_bss_data+0x8b1/0x1e40 net/wireless/scan.c:2334
 cfg80211_inform_bss_data+0x254/0x3e40 net/wireless/scan.c:3189
 cfg80211_inform_bss_frame_data+0x252/0x8a0 net/wireless/scan.c:3284
 ieee80211_bss_info_update+0x311/0xab0 net/mac80211/scan.c:226
 ieee80211_rx_bss_info net/mac80211/ibss.c:1101 [inline]
 ieee80211_rx_mgmt_probe_beacon net/mac80211/ibss.c:1580 [inline]
 ieee80211_ibss_rx_queued_mgmt+0x1956/0x3040 net/mac80211/ibss.c:1607
 ieee80211_iface_process_skb net/mac80211/iface.c:1613 [inline]
 ieee80211_iface_work+0xc0b/0xf00 net/mac80211/iface.c:1667
 cfg80211_wiphy_work+0x3de/0x560 net/wireless/core.c:440
 process_one_work+0x958/0x1b30 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff888028691800
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 561 bytes inside of
 freed 1024-byte region [ffff888028691800, ffff888028691c00)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x28690
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801ac41dc0 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000100010 00000001f5000000 0000000000000000
head: 00fff00000000040 ffff88801ac41dc0 dead000000000100 dead000000000122
head: 0000000000000000 0000000000100010 00000001f5000000 0000000000000000
head: 00fff00000000003 ffffea0000a1a401 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x252800(GFP_NOWAIT|__GFP_NORETRY|__GFP_COMP|__GFP_THISNODE), pid 53, tgid 53 (kworker/u8:3), ts 17203446730, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1558
 prep_new_page mm/page_alloc.c:1566 [inline]
 get_page_from_freelist+0xfce/0x2f80 mm/page_alloc.c:3476
 __alloc_pages_noprof+0x223/0x25b0 mm/page_alloc.c:4753
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_slab_page mm/slub.c:2425 [inline]
 allocate_slab mm/slub.c:2589 [inline]
 new_slab+0xca/0x410 mm/slub.c:2642
 ___slab_alloc+0xce2/0x1650 mm/slub.c:3830
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3920
 __slab_alloc_node mm/slub.c:3995 [inline]
 slab_alloc_node mm/slub.c:4156 [inline]
 __kmalloc_cache_node_noprof+0xfb/0x3f0 mm/slub.c:4337
 kmalloc_node_noprof include/linux/slab.h:924 [inline]
 blk_mq_alloc_hctx block/blk-mq.c:3935 [inline]
 blk_mq_alloc_and_init_hctx+0x639/0x11b0 block/blk-mq.c:4443
 blk_mq_realloc_hw_ctxs+0x8e0/0xbe0 block/blk-mq.c:4476
 blk_mq_init_allocated_queue+0x39e/0x11f0 block/blk-mq.c:4530
 blk_mq_alloc_queue+0x1ef/0x2e0 block/blk-mq.c:4343
 scsi_alloc_sdev+0x890/0xd80 drivers/scsi/scsi_scan.c:337
 scsi_probe_and_add_lun+0x789/0xda0 drivers/scsi/scsi_scan.c:1210
 __scsi_scan_target+0x1ea/0x580 drivers/scsi/scsi_scan.c:1757
 scsi_scan_channel drivers/scsi/scsi_scan.c:1845 [inline]
 scsi_scan_channel+0x149/0x1e0 drivers/scsi/scsi_scan.c:1821
 scsi_scan_host_selected+0x302/0x400 drivers/scsi/scsi_scan.c:1874
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888028691900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888028691980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888028691a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                     ^
 ffff888028691a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888028691b00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
