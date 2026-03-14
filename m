Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E3D46B5
	for <linux-bluetooth@vger.kernel.org>; Sat, 14 Mar 2026 04:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773463890; cv=none; b=CVfTh+9NVdD/P+LPlhlxTJrSa83Mlk6dvVmkjksLyBXwFe4k7Hp/5AfA4flYajqGw6+Jb/D1yXS5qcBPTRXjEAU9bJhi+Wf5p3Tl9OIV6uTZp4p9qnlGihJ5gbLYPkKeYYm5NBuMlic4zV9fUX7nbhLGLEfgHYUQcoZT9cgqXpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773463890; c=relaxed/simple;
	bh=TyTorOKA7MWmoUEmlFSkSNNCOcpI/NR3lAOSTtox6W8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=iM5W844p0wkCJEdimNtolSZXjxe1EjVL+Dz5G/tUNE2Krb86S/Ams/i9lgE7dLvlVnlaiRVvsF3qFrPNLZreq/CV8edjzb2ZXfwK6j0Fey8lPH7qP8dgX6h8lYydXGVWiwfPzd8EWyI1hSQ7zmW7I5/LX1atWLCfV2xDMd5dtMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-67bbe58b962so22778578eaf.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Mar 2026 21:51:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773463888; x=1774068688;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cQoIEVn5iTQq46B2Rx1CBuZkrVBLJ6R/j+qjIIKeV30=;
        b=VKOzsgsHnBuhmJc+vvUiLM3BmsFU2suj+wnH62W1vKkjlPdxdNXw8A9Wr26vz3FY3X
         qjqEKbN7222Fn4VUz6P7HSGC3VQ7EOcTXhrhRNnqJZSzDaou+/8pkSfM9exJ47NIOaBW
         JkRN0W/MLYjhiXMsidIq2XH+DI+0G+vv6/78N6bOHAzO7WwWgxa/ILr70u8z81NU+E22
         XT//Z3aQlJG0YSuGuENbPKgZMP1U7BORf2cV4jJnHXJdduMSC08Otwx8UuYB8/ebuzVS
         v9eadTfUII3UUe4nLZNhRmhdR3i7FE7/hVe93nEyghrNMp9PEKMh2Qc+zM7aw+ERiJap
         7USA==
X-Forwarded-Encrypted: i=1; AJvYcCVspBgYkYFKIIIj+5y3jrz8R+kB6XV2DeBfJtFkVK4tOB3915eQ5FAijpCUN05D6vi3wK4r8LedVtw4nZYkM/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrTTVsPYtWfgizN38HQZsU16PH5ot9MiVNzLZ3qXtN/Ym9lpkD
	uWFcCeIEuf8YBJKFGBgLY3fMrf9LlhoWuqPvu7hslDOBbM7qLtwY8CHDAG+3oILqVenh9NV/0md
	8K2pxKtPybENv8MXxRolhHtGsGV7yKOPTISspz6uWwhBrcLw46Sg5RtFexuc=
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:16a9:b0:67b:e3cf:a41a with SMTP id
 006d021491bc7-67be3cfa7cdmr2144191eaf.40.1773463887826; Fri, 13 Mar 2026
 21:51:27 -0700 (PDT)
Date: Fri, 13 Mar 2026 21:51:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69b4e94f.050a0220.12d28.0146.GAE@google.com>
Subject: [syzbot] [bluetooth?] KASAN: stack-out-of-bounds Read in l2cap_send_cmd
From: syzbot <syzbot+b7f3e7d9a596bf6a63e3@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    af98e93c5c39 Add linux-next specific files for 20260212
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=170d815a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61690c38d1398936
dashboard link: https://syzkaller.appspot.com/bug?extid=b7f3e7d9a596bf6a63e3
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=167b7a52580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11549994580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d6acde52048b/disk-af98e93c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ea8f872a1b5a/vmlinux-af98e93c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c600c3134b27/bzImage-af98e93c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b7f3e7d9a596bf6a63e3@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: stack-out-of-bounds in skb_put_data include/linux/skbuff.h:2800 [inline]
BUG: KASAN: stack-out-of-bounds in l2cap_build_cmd net/bluetooth/l2cap_core.c:3003 [inline]
BUG: KASAN: stack-out-of-bounds in l2cap_send_cmd+0x2a3/0xb90 net/bluetooth/l2cap_core.c:954
Read of size 22 at addr ffffc90003357540 by task kworker/u9:2/5923

CPU: 1 UID: 0 PID: 5923 Comm: kworker/u9:2 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/24/2026
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xba/0x230 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:-1 [inline]
 kasan_check_range+0x264/0x2c0 mm/kasan/generic.c:200
 __asan_memcpy+0x29/0x70 mm/kasan/shadow.c:105
 skb_put_data include/linux/skbuff.h:2800 [inline]
 l2cap_build_cmd net/bluetooth/l2cap_core.c:3003 [inline]
 l2cap_send_cmd+0x2a3/0xb90 net/bluetooth/l2cap_core.c:954
 l2cap_ecred_conn_req net/bluetooth/l2cap_core.c:5192 [inline]
 l2cap_le_sig_cmd net/bluetooth/l2cap_core.c:5494 [inline]
 l2cap_le_sig_channel net/bluetooth/l2cap_core.c:5552 [inline]
 l2cap_recv_frame+0xd352/0x10110 net/bluetooth/l2cap_core.c:6897
 l2cap_recv_acldata+0x7e9/0x13e0 net/bluetooth/l2cap_core.c:7621
 hci_acldata_packet net/bluetooth/hci_core.c:3855 [inline]
 hci_rx_work+0x4f9/0x1040 net/bluetooth/hci_core.c:4082
 process_one_work+0x949/0x1650 kernel/workqueue.c:3279
 process_scheduled_works kernel/workqueue.c:3362 [inline]
 worker_thread+0xb46/0x1140 kernel/workqueue.c:3443
 kthread+0x388/0x470 kernel/kthread.c:467
 ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

The buggy address belongs to stack of task kworker/u9:2/5923
 and is located at offset 128 in frame:
 l2cap_recv_frame+0x0/0x10110 include/linux/skbuff.h:-1

This frame has 26 objects:
 [32, 34) 'rsp.i238.i.i'
 [48, 88) 'chan.i.i.i'
 [128, 146) 'pdu_u.i.i.i'
 [192, 202) 'rsp.i94.i.i'
 [224, 226) 'rsp.i.i.i111'
 [240, 242) 'rej.i'
 [256, 258) 'rej.i145.i'
 [272, 274) 'rej.i143.i'
 [288, 290) 'req.i229.i.i'
 [304, 312) 'buf.i222.i.i'
 [336, 348) 'buf29.i.i.i'
 [368, 372) 'rsp49.i.i.i'
 [384, 393) 'rfc.i.i118.i.i'
 [416, 480) 'buf.i119.i.i'
 [512, 576) 'req.i120.i.i'
 [608, 617) 'rfc.i.i.i.i'
 [640, 656) 'efs.i.i.i.i'
 [672, 678) 'rej.i371.i.i.i'
 [704, 710) 'rej.i.i.i.i'
 [736, 800) 'rsp.i.i.i'
 [832, 896) 'buf.i.i.i'
 [928, 1056) 'req.i.i.i'
 [1088, 1096) 'rsp.i.i.i.i'
 [1120, 1122) 'info.i.i.i.i'
 [1136, 1264) 'buf.i.i.i.i'
 [1296, 1298) 'rej.i.i'

The buggy address belongs to a 8-page vmalloc region starting at 0xffffc90003350000 allocated at copy_process+0x508/0x3cf0 kernel/fork.c:2050
The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x36e0f
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 0000000000000000 ffffea0000db83c8 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x29c2(GFP_NOWAIT|__GFP_HIGHMEM|__GFP_IO|__GFP_FS|__GFP_ZERO), pid 174, tgid 174 (kworker/u8:6), ts 80851768066, free_ts 75368874415
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x231/0x280 mm/page_alloc.c:1889
 prep_new_page mm/page_alloc.c:1897 [inline]
 get_page_from_freelist+0x24dc/0x2580 mm/page_alloc.c:3962
 __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5250
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2485
 alloc_frozen_pages_noprof mm/mempolicy.c:2556 [inline]
 alloc_pages_noprof+0xa8/0x190 mm/mempolicy.c:2576
 vm_area_alloc_pages mm/vmalloc.c:3662 [inline]
 __vmalloc_area_node mm/vmalloc.c:3876 [inline]
 __vmalloc_node_range_noprof+0x79b/0x1730 mm/vmalloc.c:4064
 __vmalloc_node_noprof+0xc2/0x100 mm/vmalloc.c:4124
 alloc_thread_stack_node kernel/fork.c:355 [inline]
 dup_task_struct+0x228/0x9a0 kernel/fork.c:924
 copy_process+0x508/0x3cf0 kernel/fork.c:2050
 kernel_clone+0x248/0x8e0 kernel/fork.c:2654
 user_mode_thread+0x110/0x180 kernel/fork.c:2730
 call_usermodehelper_exec_sync kernel/umh.c:132 [inline]
 call_usermodehelper_exec_work+0x9c/0x230 kernel/umh.c:163
 process_one_work+0x949/0x1650 kernel/workqueue.c:3279
 process_scheduled_works kernel/workqueue.c:3362 [inline]
 worker_thread+0xb46/0x1140 kernel/workqueue.c:3443
 kthread+0x388/0x470 kernel/kthread.c:467
 ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
page last free pid 5825 tgid 5825 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1433 [inline]
 __free_frozen_pages+0xc2b/0xdb0 mm/page_alloc.c:2978
 __folio_put+0x414/0x4f0 mm/swap.c:112
 put_netmem include/net/netmem.h:420 [inline]
 skb_page_unref include/linux/skbuff_ref.h:43 [inline]
 __skb_frag_unref include/linux/skbuff_ref.h:56 [inline]
 skb_release_data+0x4cb/0x940 net/core/skbuff.c:1122
 skb_release_all net/core/skbuff.c:1203 [inline]
 napi_consume_skb+0x1d8/0x290 net/core/skbuff.c:1550
 skb_defer_free_flush+0x191/0x260 net/core/dev.c:6807
 net_rx_action+0x455/0xf70 net/core/dev.c:7875
 handle_softirqs+0x22a/0x870 kernel/softirq.c:626
 do_softirq+0x76/0xd0 kernel/softirq.c:523
 __local_bh_enable_ip+0xf8/0x130 kernel/softirq.c:450
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 rcu_read_unlock_bh include/linux/rcupdate.h:924 [inline]
 __dev_queue_xmit+0x1e6c/0x38a0 net/core/dev.c:4857
 dev_queue_xmit include/linux/netdevice.h:3390 [inline]
 neigh_hh_output include/net/neighbour.h:540 [inline]
 neigh_output include/net/neighbour.h:554 [inline]
 ip_finish_output2+0xc68/0x1070 net/ipv4/ip_output.c:237
 NF_HOOK_COND include/linux/netfilter.h:307 [inline]
 ip_output+0x29f/0x450 net/ipv4/ip_output.c:438
 ip_local_out net/ipv4/ip_output.c:131 [inline]
 __ip_queue_xmit+0x1198/0x1be0 net/ipv4/ip_output.c:534
 __tcp_transmit_skb+0x2b30/0x43e0 net/ipv4/tcp_output.c:1693
 tcp_transmit_skb net/ipv4/tcp_output.c:1711 [inline]
 tcp_write_xmit+0x16e8/0x6980 net/ipv4/tcp_output.c:3064
 tcp_sendmsg_locked+0x2dc9/0x5490 net/ipv4/tcp.c:1407

Memory state around the buggy address:
 ffffc90003357400: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc90003357480: 00 00 00 00 00 00 00 00 f1 f1 f1 f1 f8 f2 f8 f8
>ffffc90003357500: f8 f8 f8 f2 f2 f2 f2 f2 00 00 02 f2 f2 f2 f2 f2
                                                 ^
 ffffc90003357580: f8 f8 f2 f2 f8 f2 f8 f2 f8 f2 f8 f2 f8 f2 f8 f2
 ffffc90003357600: f2 f2 f8 f8 f2 f2 f8 f2 f8 f8 f2 f2 f8 f8 f8 f8
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
