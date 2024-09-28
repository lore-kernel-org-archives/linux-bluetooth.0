Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E231F185B5D
	for <linux-bluetooth@vger.kernel.org>; Sat, 28 Sep 2024 11:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727524587; cv=none; b=c9o+ynrhHFFMR3uaBMgN25csE0wIJMutj15T2dfbFCZLMrUsRwTOM7SXH+0enEn600jnXZShvqgOVrFlC3yV60QGQwNi+qiD0+wAksd+2nv7ofuHiEQKf5A+vVF3woMz/viVqNE7EDCWGjDb070J4+j78BSHUgRkSVNCV9x6o0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727524587; c=relaxed/simple;
	bh=DzzSFxzL5YrSjosk3hduOPQOo3JvODfO7p6VRQP/ppo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=uw4+LJfrxq5yXdXB4T6dkdFzMIFkuIxz69Ef1bZN3tezW+Epgc3aNW1l8b5I8L9O6xt8JDbEuMEI0W5Ozugrjn3z3gJhGgZmIgF15jgN1HktoNeq/DOGhMNzBQHeo8Uq32q5PBJl+OnP5PyibYtvaUrXjfzhK03wrpSQeBLbC24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82cf30e0092so266437639f.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 28 Sep 2024 04:56:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727524585; x=1728129385;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7pxHfMpYhAjjyJ/Vmbefl/vEc6Rrtr4nHXAV1wpaVh8=;
        b=mKCntZcL59s4lwfqHDNcDWkwozEcY00+PvYNdx/fyzkIeHmcPQQli3W0oVN9VQhROx
         zvrfiqb//DXRkWI3N0bBdJ+hxZf3/ZGPrvJ4+sXwWbAr1I1IFfCrMZm/deeQkn0oizsX
         Xiak2/FGr4L8yDPzDWY5CWV2jmBIAzNIIdoZJ5JW0jxvMA40rDN1bb22qtYOVedol2Bv
         B8DjvU6jZolfo0VGDiDO+jJlqmmbzOO81M7TamdgQJIG9Ii2NCgyOn3NwmX1pm43l7Tx
         Zr1FKTXA+5EF8FPgeyi9jLsZMy0lj2su61tre1PRiXi3xPWCOP9FYx5ciQmsLXJnOzbC
         2Aiw==
X-Forwarded-Encrypted: i=1; AJvYcCXKCvzl4MBAj8H7tKZe9Ke/sJarEO5CUnpwX5CgAZK0ogbf3P4UVNNZ7n9qgogTYA8UxMsD6iYjXiF4wQL3oeU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIAbdVCSNMnz/TZFt3jVey5jEHAFbi0iunjhzjF16EM2fJMdyi
	l7ZxArL1dxupalp0wsDsm86aPN5cfiyfMXwIxvNYWRbeM+CWGy2gzJBdfjgc7G8K3Cfe3HDOlj0
	lPUtdzd2LxCU+cEmlblrgqpk9DK9iF9crjpDsPwhpyoBBTOV10bFNBKw=
X-Google-Smtp-Source: AGHT+IG1ctyUmk9aiBaxeVXoL9zbKBPeYIuigRhf6+/CmrZlYJwZkQPqPZ5mWYOF14O7HaZgupTUAgDqOz0elrI9CJ+uDP7URXIb
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2188:b0:3a0:a311:6773 with SMTP id
 e9e14a558f8ab-3a3451b4ba4mr52198975ab.21.1727524584945; Sat, 28 Sep 2024
 04:56:24 -0700 (PDT)
Date: Sat, 28 Sep 2024 04:56:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f7eee8.050a0220.4a974.0006.GAE@google.com>
Subject: [syzbot] [mm?] [bluetooth?] INFO: rcu detected stall in vhci_release
From: syzbot <syzbot+46c3d1706c2d2688baba@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, luiz.dentz@gmail.com, 
	marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    abf2050f51fd Merge tag 'media/v6.12-1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=152252a9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2a8c36c5e2b56016
dashboard link: https://syzkaller.appspot.com/bug?extid=46c3d1706c2d2688baba
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10564c80580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9800778169d6/disk-abf2050f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/32a789de3883/vmlinux-abf2050f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/24e5e7200094/bzImage-abf2050f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+46c3d1706c2d2688baba@syzkaller.appspotmail.com

bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:1b, vlan:0)
rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P5337/1:b..l
rcu: 	(detected by 0, t=10503 jiffies, g=9465, q=61 ncpus=2)
task:syz-executor    state:R  running task     stack:20608 pid:5337  tgid:5337  ppid:1      flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1843/0x4ae0 kernel/sched/core.c:6674
 preempt_schedule_irq+0xfb/0x1c0 kernel/sched/core.c:6996
 irqentry_exit+0x5e/0x90 kernel/entry/common.c:354
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:rol32 include/linux/bitops.h:127 [inline]
RIP: 0010:jhash2 include/linux/jhash.h:129 [inline]
RIP: 0010:hash_stack lib/stackdepot.c:514 [inline]
RIP: 0010:stack_depot_save_flags+0x84/0x830 lib/stackdepot.c:614
Code: 04 72 75 44 89 f3 44 89 f0 4c 8b 44 24 08 4c 89 c2 03 02 03 5a 04 44 03 72 08 44 89 f7 c1 c7 04 44 29 f0 31 c7 41 01 de 29 fb <89> fd c1 c5 06 31 dd 44 01 f7 89 e9 c1 c1 08 41 29 ee 44 31 f1 01
RSP: 0018:ffffc9000366efa0 EFLAGS: 00000287
RAX: 0000000031bf0243 RBX: 00000000c8c2d7b7 RCX: 000000009bd2d361
RDX: ffffc9000366f088 RSI: 000000000000000e RDI: 0000000047e874c2
RBP: 00000000bda8cb9f R08: ffffc9000366f040 R09: 0000000000000010
R10: ffffc9000366eed0 R11: ffffffff818066f0 R12: dffffc0000000000
R13: 1ffff920006cde04 R14: 000000002810c3e1 R15: 1ffff11005c9f0b0
 save_stack+0x109/0x1f0 mm/page_owner.c:157
 __reset_page_owner+0x76/0x430 mm/page_owner.c:297
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_page+0xcd0/0xf00 mm/page_alloc.c:2638
 discard_slab mm/slub.c:2678 [inline]
 __put_partials+0xeb/0x130 mm/slub.c:3146
 put_cpu_partial+0x17c/0x250 mm/slub.c:3221
 __slab_free+0x2ea/0x3d0 mm/slub.c:4450
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:247 [inline]
 slab_post_alloc_hook mm/slub.c:4086 [inline]
 slab_alloc_node mm/slub.c:4135 [inline]
 kmem_cache_alloc_node_noprof+0x16b/0x320 mm/slub.c:4187
 kmalloc_reserve+0xa8/0x2a0 net/core/skbuff.c:587
 __alloc_skb+0x1f3/0x440 net/core/skbuff.c:678
 alloc_skb include/linux/skbuff.h:1322 [inline]
 alloc_uevent_skb+0x74/0x230 lib/kobject_uevent.c:289
 uevent_net_broadcast_untagged lib/kobject_uevent.c:326 [inline]
 kobject_uevent_net_broadcast+0x2fd/0x580 lib/kobject_uevent.c:410
 kobject_uevent_env+0x57d/0x8e0 lib/kobject_uevent.c:608
 device_del+0x7db/0x9b0 drivers/base/core.c:3889
 device_unregister+0x20/0xc0 drivers/base/core.c:3912
 hci_conn_cleanup net/bluetooth/hci_conn.c:174 [inline]
 hci_conn_del+0x8c4/0xc40 net/bluetooth/hci_conn.c:1160
 hci_conn_hash_flush+0x18e/0x240 net/bluetooth/hci_conn.c:2590
 hci_dev_close_sync+0x9ef/0x11a0 net/bluetooth/hci_sync.c:5195
 hci_dev_do_close net/bluetooth/hci_core.c:483 [inline]
 hci_unregister_dev+0x20b/0x510 net/bluetooth/hci_core.c:2698
 vhci_release+0x80/0xd0 drivers/bluetooth/hci_vhci.c:664
 __fput+0x23f/0x880 fs/file_table.c:431
 task_work_run+0x24f/0x310 kernel/task_work.c:228
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0xa2f/0x28e0 kernel/exit.c:939
 do_group_exit+0x207/0x2c0 kernel/exit.c:1088
 get_signal+0x176f/0x1810 kernel/signal.c:2936
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xc9/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4621d7fdea
RSP: 002b:00007ffdfcf10378 EFLAGS: 00000206 ORIG_RAX: 0000000000000036
RAX: 0000000000000000 RBX: 00007ffdfcf10400 RCX: 00007f4621d7fdea
RDX: 0000000000000040 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 0000000000000003 R08: 00000000000002d8 R09: 00007ffdfcf107b7
R10: 00007f4621f08ea0 R11: 0000000000000206 R12: 00007f4621f08e40
R13: 00007ffdfcf1039c R14: 0000000000000000 R15: 00007f4621f0b000
 </TASK>
rcu: rcu_preempt kthread starved for 10514 jiffies! g9465 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:25136 pid:17    tgid:17    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1843/0x4ae0 kernel/sched/core.c:6674
 __schedule_loop kernel/sched/core.c:6751 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6766
 schedule_timeout+0x1be/0x310 kernel/time/timer.c:2615
 rcu_gp_fqs_loop+0x2df/0x1330 kernel/rcu/tree.c:2045
 rcu_gp_kthread+0xa7/0x3b0 kernel/rcu/tree.c:2247
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 0 UID: 0 PID: 16 Comm: ksoftirqd/0 Not tainted 6.11.0-syzkaller-09959-gabf2050f51fd #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:rcu_read_lock_bh_held+0xe5/0x120 kernel/rcu/update.c:377
Code: 8f 44 24 20 43 80 3c 34 00 74 08 4c 89 ff e8 b2 0c 82 00 45 31 ff f7 44 24 20 00 02 00 00 41 0f 94 c7 48 c7 04 24 0e 36 e0 45 <49> c7 04 1e 00 00 00 00 65 48 8b 04 25 28 00 00 00 48 3b 44 24 48
RSP: 0018:ffffc90000156080 EFLAGS: 00000206
RAX: 0000000080000300 RBX: 1ffff9200002ac10 RCX: 0000000080000300
RDX: ffff88801d2cda00 RSI: ffffffff8c601ba0 RDI: ffff8880b863fa20
RBP: ffffc90000156110 R08: ffffffff8987a996 R09: 1ffffffff2845505
R10: dffffc0000000000 R11: fffffbfff2845506 R12: 1ffff1100c8bf400
R13: ffff8880a6ab4081 R14: dffffc0000000000 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4621f08ef8 CR3: 000000002e03e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 </IRQ>
 <TASK>
 __dev_queue_xmit+0x95f/0x3e80 net/core/dev.c:4386
 dev_queue_xmit include/linux/netdevice.h:3094 [inline]
 br_dev_queue_push_xmit+0x703/0x8d0 net/bridge/br_forward.c:53
 NF_HOOK+0x700/0x7c0 include/linux/netfilter.h:314
 br_nf_post_routing+0xa20/0xe80 net/bridge/br_netfilter_hooks.c:989
 nf_hook_entry_hookfn include/linux/netfilter.h:154 [inline]
 nf_hook_slow+0xc3/0x220 net/netfilter/core.c:626
 nf_hook include/linux/netfilter.h:269 [inline]
 NF_HOOK+0x2a7/0x460 include/linux/netfilter.h:312
 br_forward_finish+0xd8/0x130 net/bridge/br_forward.c:66
 br_nf_forward_finish+0xb49/0xfb0 net/bridge/br_netfilter_hooks.c:689
 NF_HOOK+0x700/0x7c0 include/linux/netfilter.h:314
 br_nf_forward_ip+0x61e/0x7b0 net/bridge/br_netfilter_hooks.c:743
 nf_hook_entry_hookfn include/linux/netfilter.h:154 [inline]
 nf_hook_slow+0xc3/0x220 net/netfilter/core.c:626
 nf_hook include/linux/netfilter.h:269 [inline]
 NF_HOOK+0x2a7/0x460 include/linux/netfilter.h:312
 __br_forward+0x489/0x660 net/bridge/br_forward.c:115
 deliver_clone net/bridge/br_forward.c:131 [inline]
 maybe_deliver+0xb3/0x150 net/bridge/br_forward.c:190
 br_flood+0x2e4/0x660 net/bridge/br_forward.c:236
 br_handle_frame_finish+0x18ba/0x1fe0 net/bridge/br_input.c:215
 br_nf_hook_thresh+0x472/0x590
 br_nf_pre_routing_finish_ipv6+0xaa0/0xdd0
 NF_HOOK include/linux/netfilter.h:314 [inline]
 br_nf_pre_routing_ipv6+0x379/0x770 net/bridge/br_netfilter_ipv6.c:184
 nf_hook_entry_hookfn include/linux/netfilter.h:154 [inline]
 nf_hook_bridge_pre net/bridge/br_input.c:277 [inline]
 br_handle_frame+0x9fd/0x1530 net/bridge/br_input.c:424
 __netif_receive_skb_core+0x13e8/0x4570 net/core/dev.c:5556
 __netif_receive_skb_one_core net/core/dev.c:5660 [inline]
 __netif_receive_skb+0x12f/0x650 net/core/dev.c:5775
 process_backlog+0x662/0x15b0 net/core/dev.c:6107
 __napi_poll+0xcb/0x490 net/core/dev.c:6771
 napi_poll net/core/dev.c:6840 [inline]
 net_rx_action+0x89b/0x1240 net/core/dev.c:6962
 handle_softirqs+0x2c5/0x980 kernel/softirq.c:554
 run_ksoftirqd+0xca/0x130 kernel/softirq.c:927
 smpboot_thread_fn+0x544/0xa30 kernel/smpboot.c:164
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
net_ratelimit: 27510 callbacks suppressed
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:1b, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:1b, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:1b, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:1b, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:1b, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:1b, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:1b, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:1b, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:1b, vlan:0)
bridge0: received packet on bridge_slave_0 with own address as source address (addr:aa:aa:aa:aa:aa:1b, vlan:0)


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
