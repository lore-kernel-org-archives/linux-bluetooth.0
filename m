Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70873B7760
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 04:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791433595; cv=none; b=HZ4DD2tbgvngrBSPXMIvbwDNMWz957ABEpj+3vBbUNF4r+h1GmLKe6XRRFINehCm6LHlH9ABcHbRHjUJHec60HCf7FT2boneQk/eAz2hCiqyFTca1dZufGK4y67wGZc6JhXBmA909xJ5hexlLam5q7byoKRA2wgCrMStOioZicI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791433595; c=relaxed/simple;
	bh=DqTU2duYyBXWzQoOOLka3IQuCFv4ZPn00ZNt13C7L74=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=cEomwHQBPkZfXyszhlbf6cDNOHWZaow2iiBVd0vR9tBBflrZE1pRtxSOgkFMexKedPqPvi+OSBmyVA4u9YG4eJMZiDtPBrLHqA3v31QSK01x+X7EJ5niWSihzo7vRwcPp65DjbkqxqjzXUICIktQq/wC5RWjHIH7SXqqWWxunas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxHHSUhY; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxHHSUhY"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3a0aaa0fd13so2898079a91.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Oct 2026 21:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791433593; x=1792038393; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pNV+UbTFRvLIe+SmhBDORMjcpdTmRGfQreujIFKAUyA=;
        b=cxHHSUhY6xngmRkB/pbQVTJ2lf3V0HbEOn/P6JrIkjgw1IOdBfgUt5O3g6W+3wryyX
         IyuMzxCSe8X+FZWcMSj9evvFa0lgteEiPHH0KeGyJTGbSqc7HqW0PVM+o9WwJa11w6GC
         VXsMnsUVcOsMgldIH12GDKmq7Lui8n7xFZVDPUWs/9pZ9Cfme9rSDeI5U4/Dy541ZYQ/
         mT+Qu6DNw552GWWGGu76OMV0IHe5SYpgbkB2NQUuRn5zEEJtg7Np6E+SLbBufenZrogp
         vzQ68/wheCK8zwEQpM9LdDMQ/KkdxMgmjcdpkTi6ZuQzPBw65nNIhSZIta//LlRrE+4P
         sH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791433593; x=1792038393;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pNV+UbTFRvLIe+SmhBDORMjcpdTmRGfQreujIFKAUyA=;
        b=aCZffxOnFnOb47I4/gDoeyZJhUHPpS1vhr2buYP2/ZmmkpDEKUCn/OasLsc8cLAhgG
         /+TpKok5W9CmFMqFHeyuQLDNL9/cYjxStQpq771kQY9W3mHc3w23oY107Gp75rW7oUxh
         Xs6HaGQ7fI8gBDmcDOg+kOozmkPAt7jF/mWItEhYFdAO1SPlxIo5IlVy5FA9kglYjDtf
         gRBMIY2Prhz86RlUb9KfQyvJyQJyxeq/KZiOBWVB2Q+aQzUEgDxtoab6HZPNLsNWd6SO
         E2VUaU4F/OeiLxLJe4wv8beVia32yMkfEaOVkDTpfx18HPUO2hpHDJTCLlq3pzUBftW+
         1ATw==
X-Gm-Message-State: AFq9FYJ7iNCaqj31He8jRizrKt5CGL1XaQN1KFLpaDk6QxnVHAsJ10aj
	Evd/shQSTn5hWXIYQxyHL1LeQXhv0eWW6/LWIPRdh7S1I4VorL7zqS/O
X-Gm-Gg: AYBFou2msjzZQ6AZ1tYYJ67sOYWaQM5vHoAXKfsO/zbkA5G143cFiR/bI827dx8e7MS
	pECajxyFbxLgaOGZ8Cee/Zv4Ao22qA36kDtESZub0jtpOdsT8aUynWSLZVHQjxqQmjJ+Z9OAKVO
	O53jKKgNOGRdbapEq9iHneY58O9SsSqyqNjgzBd0+DfiW0TWilXTm4nxPq2TuApJmsADg+1b/AI
	6ChyE6mAGvW6150e7RS1pZpM04jd/sGmnMqm6ru/CMzCm8siLDM/Rmrcj1SnW/iO76U1t5e5L7i
	tWeHneKmKSq5olZ0cDr5ZTrlXSiKyi6A+69EKxpoFnDw1fzdIA6AczG/vZ9TJtlb/kghnTj59HS
	rK0grYI2jRnzBWCY/pJTCEYcwIsO1YtHMBmTvR5hXTz2GvizILzfXAW1vpKMq+1jyKGRih2KGlS
	To42KFXQTImJInPauI9TVpmIN1CeHj7BtXz7XhrTFdjF3vuCsbtwTcqHycRkMaz7eHnQ+EGmvej
	YwA
X-Received: by 2002:a17:90b:3d90:b0:3a0:8050:2ed1 with SMTP id 98e67ed59e1d1-3a8a14f00f2mr3752310a91.63.1791433593109;
        Wed, 07 Oct 2026 21:26:33 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3aa0cc1fbb2sm2219406a91.17.2026.10.07.21.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 21:26:32 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH] Bluetooth: L2CAP: Hold the listener while notifying child teardown
Date: Thu,  8 Oct 2026 12:26:26 +0800
Message-Id: <pm-bluetooth-objects-candidate-0072-v4-c08f7303b91238d86930@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A pending child's listener must remain alive until the child's teardown
callback finishes notifying it. l2cap_sock_teardown_cb() saves the raw
bt_sk(sk)->parent pointer, calls bt_accept_unlink(), then invokes
parent->sk_data_ready(). The accept queue holds a reference to the
child, but the callback takes no reference to the listener across
unlink.

When an incoming child has not been accepted, HCI disconnection can
reach l2cap_conn_del() and the child's teardown callback while another
task closes the listener. The listener channel has no connection, so the
child's connection and channel locks do not serialize listener release.
The following ordering is possible:

  HCI child teardown                 Listener release
  lock the child socket
  save parent
  bt_accept_unlink(sk)
                                     drain the empty accept queue
                                     bt_sock_unlink()
                                     shut down the listener channel
                                     sock_orphan()
                                     l2cap_sock_kill()
  parent->sk_data_ready(parent)

If no other reference delays freeing the listener, the final
notification reads sk_data_ready through freed socket storage. The child
lock cannot stop listener release once the child is no longer on the
accept queue.

Take a listener socket reference before unlinking the child and release
it after sk_data_ready() returns. While the child remains queued, its
socket lock prevents listener cleanup from completing the dequeue, so
the listener is still alive when the reference is acquired. The
reference then protects the notification after unlink without changing
lock order or the ordering of queue removal and wakeup.

KASAN report as below:

    ==================================================================
    BUG: KASAN: slab-use-after-free in l2cap_sock_teardown_cb+0x467/0x490
    Read of size 8 at addr ffff88810b99b188 by task kworker/u17:3/516

    Workqueue: hci1 hci_rx_work
    Call Trace:
     <TASK>
     dump_stack_lvl+0x93/0xd0
     print_report+0xce/0x630
     ? l2cap_sock_teardown_cb+0x467/0x490
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __virt_addr_valid+0x20d/0x410
     ? l2cap_sock_teardown_cb+0x467/0x490
     kasan_report+0xe0/0x110
     ? l2cap_sock_teardown_cb+0x467/0x490
     l2cap_sock_teardown_cb+0x467/0x490
     l2cap_chan_del+0x123/0x8f0
     l2cap_conn_del+0x31b/0x740
     ? hci_cmd_sync_submit+0x264/0x320
     ? __pfx_l2cap_disconn_cfm+0x10/0x10
     l2cap_disconn_cfm+0x87/0xd0
     hci_disconn_complete_evt+0x30f/0x990
     ? srso_alias_return_thunk+0x5/0xfbef5
     hci_event_packet+0x894/0xc70
     ? __pfx_hci_disconn_complete_evt+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __pfx_hci_event_packet+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? free_zapped_rcu+0xd0/0x1e0
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? lockdep_hardirqs_on_prepare+0xea/0x1a0
     ? __pfx_hci_cmd_sync_complete+0x10/0x10
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

    Allocated by task 502:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     __kasan_kmalloc+0xaa/0xb0
     __kmalloc_noprof+0x2d7/0x770
     sk_prot_alloc+0x13e/0x260
     sk_alloc+0x37/0xb40
     bt_sock_alloc+0x40/0x3b0
     l2cap_sock_create+0x116/0x310
     bt_sock_create+0x171/0x330
     __sock_create+0x2c4/0x730
     __sys_socket+0x141/0x210
     __x64_sys_socket+0x77/0xc0
     do_syscall_64+0x115/0x6a0
     entry_SYSCALL_64_after_hwframe+0x77/0x7f

    Freed by task 502:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     kasan_save_free_info+0x3b/0x60
     __kasan_slab_free+0x5f/0x80
     kfree+0x307/0x580
     __sk_destruct+0x64f/0x790
     sk_destruct+0xb3/0xd0
     __sk_free+0xdd/0x370
     sk_free+0x51/0x80
     l2cap_sock_kill+0x17a/0x2a0
     l2cap_sock_release+0x1d0/0x310
     __sock_release+0xb8/0x270
     sock_close+0x21/0x30
     __fput+0x39f/0xa60
     fput_close_sync+0xff/0x200
     __x64_sys_close+0x8c/0xf0
     do_syscall_64+0x115/0x6a0
     entry_SYSCALL_64_after_hwframe+0x77/0x7f

    The buggy address belongs to the object at ffff88810b99b000
                                                                which
                                belongs to the cache kmalloc-2k of size
                                2048
    The buggy address is located 392 bytes inside of
                                                                freed
                                2048-byte region [ffff88810b99b000,
                                ffff88810b99b800)

    The buggy address belongs to the physical page:
        page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0
    pfn:0x10b998
    head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
    flags: 0x200000000000040(head|node=0|zone=2)
    page_type: f5(slab)
        raw: 0200000000000040 ffff888100042f00 dead000000000100
    dead000000000122
        raw: 0000000000000000 0000000000080008 00000000f5000000
    0000000000000000
        head: 0200000000000040 ffff888100042f00 dead000000000100
    dead000000000122
        head: 0000000000000000 0000000000080008 00000000f5000000
    0000000000000000
        head: 0200000000000003 fffffffffffffe01 00000000ffffffff
    00000000ffffffff
        head: 0000000000000000 0000000000000000 00000000ffffffff
    0000000000000000
    page dumped because: kasan: bad access detected

    Memory state around the buggy address:
     ffff88810b99b080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
     ffff88810b99b100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
    >ffff88810b99b180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                          ^
     ffff88810b99b200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
     ffff88810b99b280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
    ==================================================================

Assisted-by: LLM
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index c92f31b997ddb0e2290194e30117cd81e1851949..c86f8d8691d1aeb002cbf5f9aeb321f9d308fa1a 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1751,8 +1751,14 @@
 		sk->sk_err = err;
 
 		if (parent) {
+			/*
+			 * Keep the listener alive after unlinking the
+			 * child.
+			 */
+			sock_hold(parent);
 			bt_accept_unlink(sk);
 			parent->sk_data_ready(parent);
+			sock_put(parent);
 		} else {
 			sk->sk_state_change(sk);
 		}
