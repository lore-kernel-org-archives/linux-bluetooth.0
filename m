Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792858534;
	b=vm3XtvRCJcDayBn1Zy6nogyRHlXRTz1tupl/wzHOQp1gnGuiLidJiLc1vRqI2OwbqZNC
	 UxPWW/n2JAlkDDWAxC4tVXiVTSNVRje2qEyUne1V9twh8rHmYdbF25CD2bXiEwy9EHoyI
	 ZGkEmEE8Mf8WG8Mv+V04N+FORdRQHb6ElXDijGNbITHTxfgfJFIfD/kbklX+K2MySP7MK
	 mTqFGs/nhc/G19bpHlDFAE2FIGZJYQ9cqp4gDikcDnInHPKYiaUqn/lD67GMuQQ1OkOjq
	 Q/Uid3gtqVvkC1sBj9DErmwmO8sdNPu7feKeYxi980zvMmgkErdR6w8oN9G8Re3G+Xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792858534;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=AxJv77P2A8G7sVV4M6imNepGwnrQ0bbEBbJ2Pw7OGQY=;
	b=pVePKbTG6H7PjYw0Ex8/2xOHPja4bw6Wpp9tfI4vga4t6lZtR+IlBWVe0jgKVkkig+Dq
	 BDcMWJgS/11HmBinQgkeUP+f9x+4R8xdZvdyM6iYDLK3A8xk1IcLjDjeFPoNF1fHILaNh
	 HRuDsx7XHet/ZegXwzpheCLBEaux+l4cib8bZ8U3IJeJJ0oOw5JhDgCA3sQxqN/5APi8e
	 QXBZ41odrwbHqDttAlH9LTtYMliJrHgUDEIz5+dPFKLlP3w1XYu9AtlScJs/GdVZFEDwN
	 mxGDiF92Qkdydm2POdCewlkZ2zF6AjpYhzvCDqSh1TGW9HGSSzPsOhzjslezcHp4kuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bWoFn1ly;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63F9606A31D
	for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2026 16:15:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E63F9606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bWoFn1ly
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc4dbda1e5dso570343a12.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2026 09:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792858533; x=1793463333; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AxJv77P2A8G7sVV4M6imNepGwnrQ0bbEBbJ2Pw7OGQY=;
        b=bWoFn1lys67WG4H5KaF6UAjNDZyuBx7EBZcOUdw/a9xoO/iVCHUzCdJfkpeDboAk/g
         zFzrTnXhMku+LYtnjo5Byh63yZwOskzJvztBqnXPu8RNgR+BcHZpjUmki9n3GQQJIUm9
         FSR3zCRJfcdsJJulq5js01a3juY3m/Cd+sVUrGmdKIhftNjj6ENYkqnhUE+sqdxLYJpC
         iW05ft0g5j0UGL1D+TqJ+4S590WuIRzDh2kbz6u0LoOTpRyFDIGLVLrnpebYW8Qgt/SF
         a3ZauPhCjg2trngHjoDQ5/cE1xZFT0wZMhk5ix7HJFZNbKyABgtnD0yG4Rpp87P9DZi4
         TjEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792858533; x=1793463333;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AxJv77P2A8G7sVV4M6imNepGwnrQ0bbEBbJ2Pw7OGQY=;
        b=HYm588bqq3ABzZDtM9173LXCkYcQXbPKjVg5WZfjOPOoOdAEwb8VQd4SQi5mTCx7OH
         Dw972tybn2/FizTUJOOFGwkCpukqUZy5PrjpVKD1WtKWd8YJ8GdFskr3hFTifmNCtMdE
         CYJnnS0K1/K1F5W3nIXV3RQdUGADQexhl1MCm7DPxGUcrgYM+pqJYfJKZ+rfvkhm+T/p
         l20AkjSwXwKBkGqoR74BTAI1pUjtilg2w15XwI8omQEkUfwlNeaq+dU0cDDX2fDU/gyz
         3wqi9TXGIl8JyZb+F+xZ0AV46NavWyJ5LvIsoHyrZBZXPRAe3Je18UFlASQRvGhTKqaC
         A2Xg==
X-Gm-Message-State: AFq9FYLk8BzcU7XMf5senw2nOernCKWzuKJ+3jzR5tk+fu6egv9xzkzn
	/Fm7a3LKcXztEv0ec/qdJidszTasLv1738meBnXVd+otf1vNUEmAjJYG
X-Gm-Gg: AYBFou2RPC6nGsWaUOAtg+NUxsFa5mJfko4XvaTjRdnqBWNV8UfCR37sRg/9DXCRGWd
	ClX+T7lODo/0otGvwXx+Fap1AULEzBWk8ke4BlPwhHPJXz7oKivRHRo6BwUP1ULkMI7HDEoglIc
	TujIJD4zLnBn9l42it/X+XG/9YBS4nkf1WcXwZL0l7j9i9AGQqjaUR+zQHgI+kZKZOwkr6wKM9U
	i6ttzmwC9HF21+zfS4IjaBP/Jt5hK/IM4KkiEUgXvOjlvzhGuFx+DEaIjV9uZpND9bSaK6MQbyd
	vu6Jugpx6W+cDQq1JQ91ZfdaaybxRiZyKcxodyXuDJxDK75DgCnJLKMRKS4/iW64C2R4kFtTrsW
	xsK2mkdc5Eon6deNucNBN7eOrEZoaI0NZ3ikEEUG4nliNlV8uwghXDh7bQRFr8ZB6qT++7x6meY
	+Q3Zm2xKq9C4ezRIjpt9AQeGJJSBMXM9k7EIA8OhR3q7Y6y4UCzA9/VKhJumV3xXdUol6zJCoeX
	5RKiDCxsMas25z43QnKmP7YdKJ7nTNsdK6w7bhPXtEt7Ts53uc=
X-Received: by 2002:a17:90b:5823:b0:3ac:8897:7b98 with SMTP id 98e67ed59e1d1-3adeae7644emr2310820a91.32.1792858533010;
        Sat, 24 Oct 2026 09:15:33 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adeb82761esm1972001a91.0.2026.10.24.09.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 09:15:32 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH] Bluetooth: vhci: Flush suspend work after removing debugfs
Date: Sun, 25 Oct 2026 00:15:17 +0800
Message-Id: <pm-bluetooth-objects-candidate-0146-v7-4a901c7fb65111f006fe@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The VHCI controller must remain alive until suspend_work finishes.
vhci_release() flushes the work before removing the force_suspend
debugfs entry, so an active writer can queue work after that flush.

A force_suspend write changing the suspend state can overlap the last
close of /dev/vhci as follows:

    /dev/vhci close          Debugfs writer        Suspend worker
    ---------------          --------------        --------------
    vhci_release()           force_suspend_write()
      flush_work() returns     [not queued yet]
                               schedule_work() -->
                                                   hci_suspend_dev()
                                                     check powered
                                                     check !HCI_UNREGISTER
                                                     hci_suspend_sync()
                                                     unlock(req_lock)
      vhci_debugfs_remove()
        wait for writer
      hci_unregister_dev()
      hci_free_dev()
        drop last reference
        free hdev
                                                   hci_clear_wake_reason()
                                                     lock freed mutex
                                                     use-after-free

The controller locks serialize state access but do not retain the
allocation. Unregister drains HCI-owned work, but does not cover VHCI's
suspend_work on the system workqueue.

Flush suspend_work again after removing the debugfs entries and before
unregistering the controller. Removal waits for active writers and
prevents new callbacks, so the second flush drains all remaining work
while the controller and driver data are still alive. Retain the initial
flush to preserve the existing teardown order.

Runtime testing of this change was not performed.

KASAN report as below:

    ==================================================================
    BUG: KASAN: use-after-free in __mutex_lock+0x1e68/0x2590
    Read of size 8 at addr ffff8881011b80b0 by task kworker/0:0/9

    Workqueue: events vhci_suspend_work
    Call Trace:
     <TASK>
     dump_stack_lvl+0x93/0xd0
     print_report+0xce/0x630
     ? __mutex_lock+0x1e68/0x2590
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __virt_addr_valid+0x20d/0x410
     ? __mutex_lock+0x1e68/0x2590
     kasan_report+0xe0/0x110
     ? __mutex_lock+0x1e68/0x2590
     __mutex_lock+0x1e68/0x2590
     ? hci_suspend_dev+0x1ff/0x650
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? mark_held_locks+0x40/0x70
     ? _raw_spin_unlock_irqrestore+0x44/0x60
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? lockdep_hardirqs_on_prepare+0xea/0x1a0
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __pfx___mutex_lock+0x10/0x10
     ? _raw_spin_unlock_irqrestore+0x44/0x60
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? pmbd_gate_site_armed+0x31/0x1c0
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __pfx_pmbd_probe_hit_cookie+0x10/0x10
     ? hci_suspend_dev+0x1ff/0x650
     hci_suspend_dev+0x1ff/0x650
     vhci_suspend_work+0xa5/0x190
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

    The buggy address belongs to the physical page:
        page: refcount:0 mapcount:0 mapping:0000000000000000
    index:0xffff8881011b9040 pfn:0x1011b8
    flags: 0x200000000000000(node=0|zone=2)
        raw: 0200000000000000 ffffea0004073308 ffff88818863f180
    0000000000000000
        raw: ffff8881011b9040 0000000000000000 00000000ffffffff
    0000000000000000
    page dumped because: kasan: bad access detected

    Memory state around the buggy address:
     ffff8881011b7f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
     ffff8881011b8000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
    >ffff8881011b8080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                         ^
     ffff8881011b8100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
     ffff8881011b8180: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
    ==================================================================

Fixes: d16e6d19ccc6 ("Bluetooth: hci_vhci: Fix calling hci_{suspend,resume}_dev")
Assisted-by: LLM
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index 8f7db0102b25f..bedba3c140ac2 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -701,6 +701,8 @@ static int vhci_release(struct inode *inode, struct file *file)
 	if (hdev) {
 		if (!IS_ERR_OR_NULL(hdev->debugfs))
 			vhci_debugfs_remove(hdev);
+		/* Drain work queued by the last force_suspend writers. */
+		flush_work(&data->suspend_work);
 		hci_unregister_dev(hdev);
 		hci_free_dev(hdev);
 	}
