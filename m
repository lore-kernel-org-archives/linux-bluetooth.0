Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793371452;
	b=eaqtba66usgzMA000RKOHvnT4tjGtaK8BnsYJWxRgQuaHCfDzBVsYmKTBoEWobzRPxAT
	 sUp+jkVtoKcJPPZ87bbbRPNyB2YB7hOUpXaoVYjQ0Xy/x8zeA4oa0kdnkrkuryJEA/HLF
	 186fUc9yKr2xauiDaSId8pwTbpNH77VqaY+4rSeVF0+HIIcHJCsweIs41HnE8PhX0dsZ8
	 3ZX05LIS+4iV34zXV18/Z6sbvTdnfGUO3f0vDGmFhwS9mRoWuGjmF1Nz0+0znNBE+xIRX
	 NFtXYyLWRkmAAWRkb9mn4nZ78E5o/96pi58BHB2gf45r883rVjZ5tMirKn40mNiks8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793371452;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8TbTVtISdjoWqoxP0Y5hcU/ryBZFK5rKTG9KYDArboI=;
	b=rCu/69CLfqIgHgWF0d61oZvAHJh9kiRPiX0W38kTXMXnxMQao4UE+UVvEdjVJWpCyTpQ
	 H7RxLAPpsXGNyedPaV3F0eE4pmmXD3waZ09650HKWTiEWJe3OedlvE8Z2Sf9GLkW8P3jK
	 qR3pQOzHzTOWCzyzZtG+JEN8II6QYskWUJFhV94IhI4oZCrLhb6hkBuMo1w1bPOWx0e7S
	 fIwzX3ubOKV2GITs1gokcMQxfo9KOuKzuAlbbwLQ1Sjox2PZYgrZX2gdSd3jopVw5r7zN
	 ro6o6BLCnpti2BaB0+VQw+lLsigtqrom7h/28RB+xleVSUkpe4vPOg8rER3JTGzQv4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UBx9RcDB;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2026606A31C
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 14:44:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2026606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UBx9RcDB
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3acb512a7a0so521208a91.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 07:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793371451; x=1793976251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8TbTVtISdjoWqoxP0Y5hcU/ryBZFK5rKTG9KYDArboI=;
        b=UBx9RcDBaQUlKwsKJnejHgfVpT1dmTXsrdGWcgvnVEjC2m8Tu5MaQmck/CZVPQ5vd9
         t4gp6F1HN9hRD84045BK1Tubm7EDHQqL1k/foejh+nZK5+9AAN1PZKEmJtTEnZB3UF97
         QYHHp/CC0OArc7HMy++hjvRywDbEGTZLHiWbwTal31PE/9eir7XEGTVK4oibUWSOw0D4
         olpXSlHo/Zfoy77ZNvnXWt5g/eorX1DOpk1uGPCGwM9F4mP776NezTHd75pfuXLVCBn5
         vVV4qitlNUbl1vFh1a6NGPusFf7V84QsSFpqXKaeB1wXJH3+x20XSD2ql55BSDUjsooA
         atkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793371451; x=1793976251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8TbTVtISdjoWqoxP0Y5hcU/ryBZFK5rKTG9KYDArboI=;
        b=ULIAwiAveYids8KlGUXRl9lqucxomxE1TyKi1Q+kk/9wSEJ2KD1Xavsa7Ei6FTH/Cc
         gsOhI+TM6RI8tolJujcIAroYzY+ldXlJs9lNbtWoGYRZpxD+wsWZdeua5sChp0tApZKb
         PKJD+cEt+Y9nmm99jkY8VE678bvnbdxHt9l4QsN/eo2wxIMJdtT7pOzgL3qIwrJ/R0w4
         TbqdXHE2eqNMSg1onnCqnjN4j5+XYT/ZQR5GJS8Rqx0H4t51gOpdPZTT37730/FoGDcp
         pFIojhbTMiAq1rMSSrYO+LpPxuQkV8F4/71LQyCBQ0OZa0lEAPrNvQpmlHGRnPhoB6ZQ
         jg1w==
X-Gm-Message-State: AFq9FYKH6BB8YC35baS0D44Knqt8S9v8nQYM7ogqCrmqrfQZLeQjdbX3
	N6fBnHk6BzWtzSs+qPIvjepldBxrLxUSqIWKrVedW/kHgIflyyHFYdD9
X-Gm-Gg: AYBFou1oCgwvqYNI9bXcebKrQ2XCSn4MCqmMTHxgJGijoR2L0pbEYnxlv8ak5b9ubQy
	8rF2sO8kA+4NS7KfL//9Di3kHDlYDourkFUZjQD3Y97Vmd6ajV+R8TkjDjbzFP2b2Ut1DYnwZIW
	tBSFq56qG0KaHlJbTDXP7rjO6iuppjrE1uveJH0FBn3ZVXisIX4EqgN4y4Zhc5HA/LVWh49yHQX
	yf60FUPTW/TBl5Q+MS7RhgCrWYiCTYzlheYUbjbsb1AYRoCY7w7Q8xb0obNJE8dtthXXGFdYEU8
	vKcCvyE5FIRzB0WlvpAZ7TwYBcKU+LRKfRsU6jB360H8dffEU0mJ72SPZ1QdvnDVS7aKEy0N7JR
	4J6Hda06O9iRYUalY7S4b2RsfAF4LSMCrVTf0d+HnQok6CN/yd4pWMzCrJ75D+x2gRTSQWEApTs
	qQJGj+mmiI6irFgJzKTZA0Z1Y+wUgpa5KwITDgh3/G6IPf//WCTF+HdaooMvUNGRQjsM8ku/4uQ
	fXWYzWA+QwwFaIXOILLsucrGQJ+Udk4XFPSmV8dUM6rTMMWEkoSM2Umgyi4liF+dmK491Ia4LfM
	3B2QWVpsKdlT8IEg2AGR5tNo
X-Received: by 2002:a17:90b:57c5:b0:3ab:31e6:12fc with SMTP id 98e67ed59e1d1-3ae89282d02mr2096843a91.0.1793371450836;
        Fri, 30 Oct 2026 07:44:10 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845d5e62sm4610922a91.13.2026.10.30.07.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 07:44:10 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH 1/2] Bluetooth: SMP: Serialize forced BR/EDR channel changes
Date: Fri, 30 Oct 2026 22:43:56 +0800
Message-Id: <pm-bluetooth-objects-candidate-0184-v7-c26e53b52c260063ab6a-1@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <pm-bluetooth-objects-candidate-0184-v7-c26e53b52c260063ab6a-0@gmail.com>
References: <pm-bluetooth-objects-candidate-0184-v7-c26e53b52c260063ab6a-0@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The force_bredr_smp debugfs switch creates and removes the BR/EDR SMP
root channel in hdev->smp_bredr_data without holding hdev->lock. The
other users of that channel hold the lock: l2cap_connect_cfm() looks up
fixed channels during HCI event processing, and hci_dev_close_sync()
removes the root through smp_unregister().

Enabling the switch can let a connection confirmation use a root that
is not fully initialized. smp_add_cid() publishes the channel through
l2cap_chan_create() and sets BT_LISTEN before it assigns the channel
operations and the parent lock nesting level:

  Debugfs writer                  HCI receive worker
  smp_add_cid()
    l2cap_chan_create()
    l2cap_add_scid()
    chan->state = BT_LISTEN
                                  hci_dev_lock(hdev)
                                  l2cap_connect_cfm()
                                    l2cap_global_fixed_chan()
                                    l2cap_chan_lock(root)
                                    l2cap_new_connection()
                                      root->ops->new_connection()
    chan->ops = &smp_root_chan_ops

Disabling the switch can race with power-off, which releases the same
channel:

  Debugfs writer                  Power-off
  smp_force_bredr(hdev, false)
    chan = hdev->smp_bredr_data
                                  hci_dev_lock(hdev)
                                  smp_unregister(hdev)
                                    smp_del_chan(chan), chan is freed
                                  hci_dev_unlock(hdev)
    smp_del_chan(chan)
      reads chan->data after the free

Hold hdev->lock around smp_force_bredr() in the debugfs writer and
annotate that requirement. smp_unregister() leaves HCI_FORCE_BREDR_SMP
set, so after power-off the slot is empty while the switch still reads
as enabled. Disabling it then passes NULL to smp_del_chan() even without
a race; skip the deletion in that case and only clear the flag.

Both reports below come from test kernels with scheduling hooks that
widen these windows. In the enable case lockdep also reported recursive
locking just before the oops, because the root still had the default
nesting level.

Oops report as below:

    Oops: general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] SMP KASAN NOPTI
    KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
    CPU: 1 UID: 0 PID: 497 Comm: kworker/u17:0 Not tainted 7.2.0-rc6-pmb-bt-functional-v1+ #1 PREEMPT(lazy)
    Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
    Workqueue: hci1 hci_rx_work
    RIP: 0010:l2cap_new_connection+0x16c/0x320
    Code: c1 ea 03 80 3c 02 00 0f 85 70 01 00 00 4c 8b a5 a8 04 00 00 48 b8 00 00 00 00 00 fc ff df 49 8d 7c 24 08 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 6d 01 00 00 4d 8b 64 24 08 4d 85 e4 74 19 e8 2b
    RSP: 0018:ffff88810dd57928 EFLAGS: 00010212
    RAX: dffffc0000000000 RBX: ffff888108959000 RCX: ffffffff85b5ff24
    RDX: 0000000000000001 RSI: 0000000000000008 RDI: 0000000000000008
    RBP: ffff88810895a000 R08: 0000000000000000 R09: 0000000000000000
    R10: ffffffff893d2f57 R11: 0000000000000000 R12: 0000000000000000
    R13: ffff8881089594b0 R14: ffff888100d59800 R15: 0000000000000000
    FS:  0000000000000000(0000) GS:ffff8881fd852000(0000) knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: 0000563a39fc8768 CR3: 00000001069d8004 CR4: 0000000000770ef0
    PKRU: 55555554
    Call Trace:
     <TASK>
     l2cap_connect_cfm+0x46c/0xe60
     ? __pfx_l2cap_connect_cfm+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? trace_hardirqs_on+0x18/0x160
     ? srso_alias_return_thunk+0x5/0xfbef5
     hci_remote_ext_features_evt+0x67d/0xbd0
     ? __pfx_l2cap_connect_cfm+0x10/0x10
     ? __pfx_hci_remote_ext_features_evt+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     hci_event_packet+0x894/0xc70
     ? __pfx_hci_remote_ext_features_evt+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __pfx_hci_event_packet+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? free_zapped_rcu+0xd0/0x1e0
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? lockdep_hardirqs_on_prepare+0xea/0x1a0
     ? trace_hardirqs_on+0x18/0x160
     ? srso_alias_return_thunk+0x5/0xfbef5
     hci_rx_work+0x367/0xf00
     ? srso_alias_return_thunk+0x5/0xfbef5
     process_one_work+0x908/0x19c0
     ? __pfx_process_one_work+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? lock_is_held_type+0x8f/0x100
     ? srso_alias_return_thunk+0x5/0xfbef5
     worker_thread+0x65c/0xe40
     ? __pfx_worker_thread+0x10/0x10
     kthread+0x34f/0x460
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __pfx_kthread+0x10/0x10
     ret_from_fork+0x659/0x940
     ? __pfx_ret_from_fork+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __switch_to+0x74f/0xf80
     ? __pfx_kthread+0x10/0x10
     ret_from_fork_asm+0x1a/0x30
     </TASK>
    Modules linked in:
    ---[ end trace 0000000000000000 ]---

KASAN report as below:

    ==================================================================
    BUG: KASAN: slab-use-after-free in smp_del_chan+0xd2/0xe0
    Read of size 8 at addr ffff888112a2e4a0 by task sh/493

    CPU: 1 UID: 0 PID: 493 Comm: sh Not tainted 7.2.0-rc6-pmb-bt-functional-v1+ #2 PREEMPT(lazy)
    Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
    Call Trace:
     <TASK>
     dump_stack_lvl+0x93/0xd0
     print_report+0xce/0x630
     ? smp_del_chan+0xd2/0xe0
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __virt_addr_valid+0x20d/0x410
     ? smp_del_chan+0xd2/0xe0
     kasan_report+0xe0/0x110
     ? smp_del_chan+0xd2/0xe0
     smp_del_chan+0xd2/0xe0
     smp_force_bredr+0xda/0x200
     force_bredr_smp_write+0xc9/0x130
     ? __pfx_force_bredr_smp_write+0x10/0x10
     ? __entry_text_end+0x1020f5/0x1020f9
     ? lock_acquire+0x17b/0x2f0
     ? ksys_write+0x111/0x200
     full_proxy_write+0x11f/0x180
     vfs_write+0x25a/0x1010
     ? __pfx_full_proxy_write+0x10/0x10
     ? __pfx_vfs_write+0x10/0x10
     ksys_write+0x111/0x200
     ? __pfx_ksys_write+0x10/0x10
     do_syscall_64+0x115/0x6a0
     entry_SYSCALL_64_after_hwframe+0x77/0x7f
    RIP: 0033:0x7f4692518687
    Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
    RSP: 002b:00007ffd467e8b10 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
    RAX: ffffffffffffffda RBX: 00007f4692486780 RCX: 00007f4692518687
    RDX: 0000000000000002 RSI: 0000555ac2951a80 RDI: 0000000000000001
    RBP: 0000555ac2951a80 R08: 0000000000000000 R09: 0000000000000000
    R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000001
    R13: 0000000000000002 R14: 0000000000000000 R15: 0000555abc0f2988
     </TASK>

    Allocated by task 493:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     __kasan_kmalloc+0xaa/0xb0
     __kmalloc_cache_noprof+0x251/0x610
     l2cap_chan_create+0x47/0x930
     smp_add_cid+0x309/0x4f0
     smp_force_bredr+0x17d/0x200
     force_bredr_smp_write+0xc9/0x130
     full_proxy_write+0x11f/0x180
     vfs_write+0x25a/0x1010
     ksys_write+0x111/0x200
     do_syscall_64+0x115/0x6a0
     entry_SYSCALL_64_after_hwframe+0x77/0x7f

    Freed by task 496:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     kasan_save_free_info+0x3b/0x60
     __kasan_slab_free+0x5f/0x80
     kfree+0x307/0x580
     l2cap_chan_put+0x273/0x3a0
     smp_unregister+0x59/0xe0
     hci_dev_close_sync+0x4c9/0x1150
     hci_set_powered_sync+0x4a7/0x680
     set_powered_sync+0xaa/0x150
     hci_cmd_sync_work+0x1b3/0x450
     process_one_work+0x908/0x19c0
     worker_thread+0x65c/0xe40
     kthread+0x34f/0x460
     ret_from_fork+0x659/0x940
     ret_from_fork_asm+0x1a/0x30

    The buggy address belongs to the object at ffff888112a2e000
     which belongs to the cache kmalloc-2k of size 2048
    The buggy address is located 1184 bytes inside of
     freed 2048-byte region [ffff888112a2e000, ffff888112a2e800)

    The buggy address belongs to the physical page:
    page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x112a28
    head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
    flags: 0x200000000000040(head|node=0|zone=2)
    page_type: f5(slab)
    raw: 0200000000000040 ffff888100042f00 dead000000000100 dead000000000122
    raw: 0000000000000000 0000000000080008 00000000f5000000 0000000000000000
    head: 0200000000000040 ffff888100042f00 dead000000000100 dead000000000122
    head: 0000000000000000 0000000000080008 00000000f5000000 0000000000000000
    head: 0200000000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
    head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
    page dumped because: kasan: bad access detected

    Memory state around the buggy address:
     ffff888112a2e380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
     ffff888112a2e400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
    >ffff888112a2e480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                   ^
     ffff888112a2e500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
     ffff888112a2e580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
    ==================================================================

Fixes: 300acfdec916 ("Bluetooth: Introduce force_bredr_smp debugfs option for testing")
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
Assisted-by: LLM

 net/bluetooth/hci_debugfs.c | 2 ++
 net/bluetooth/smp.c         | 2 +-
 net/bluetooth/smp.h         | 3 ++-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index cd5ef398f2382..f513731053d28 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -525,7 +525,9 @@ static ssize_t force_bredr_smp_write(struct file *file,
 	if (err)
 		return err;
 
+	hci_dev_lock(hdev);
 	err = smp_force_bredr(hdev, enable);
+	hci_dev_unlock(hdev);
 	if (err)
 		return err;
 
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 984b2d0b5e3e9..0e442cc2a35da 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -3356,7 +3356,7 @@ int smp_force_bredr(struct hci_dev *hdev, bool enable)
 			return PTR_ERR(chan);
 
 		hdev->smp_bredr_data = chan;
-	} else {
+	} else if (hdev->smp_bredr_data) {
 		struct l2cap_chan *chan;
 
 		chan = hdev->smp_bredr_data;
diff --git a/net/bluetooth/smp.h b/net/bluetooth/smp.h
index c86c463890078..13fe40c0cb244 100644
--- a/net/bluetooth/smp.h
+++ b/net/bluetooth/smp.h
@@ -193,7 +193,8 @@ bool smp_irk_matches(struct hci_dev *hdev, const u8 irk[16],
 int smp_generate_rpa(struct hci_dev *hdev, const u8 irk[16], bdaddr_t *rpa);
 int smp_generate_oob(struct hci_dev *hdev, u8 hash[16], u8 rand[16]);
 
-int smp_force_bredr(struct hci_dev *hdev, bool enable);
+int smp_force_bredr(struct hci_dev *hdev, bool enable)
+	__must_hold(&hdev->lock);
 
 int smp_register(struct hci_dev *hdev);
 void smp_unregister(struct hci_dev *hdev);
