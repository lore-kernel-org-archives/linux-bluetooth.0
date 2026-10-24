Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792859729;
	b=J2KVjkxBA+2rJ+3Anq/bMQoD9z2xo1at1Uz/dol3nfqGDYx7yvyDmaVdgvVlyni/CVZ4
	 +FDoKhXPDoqh2EFM3CW+BawP09wPN151oEfssiP9R61eNs4VNd9zmD8IspKqJhD74Sl5h
	 0RKhaQ+Lag3eo1ywAc1dVI5hCZ3Bu+ivJeBNNT3Z0UJSGR9hw1TgVlRoJ2LMwHOEixD9N
	 fyOsZh0qXOPLVH4VwzILh7nw8iu4pv765nsFgBMMsT1ho28c5zjcQTJ6F2EqT8Fb/ixGz
	 cgOz7XofmHsJxTDKVfjZdBToVbs0zKadceIjATHo14qzyPbd8+llyTxl1U33G+9F7Pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792859729;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=v9lh+B773rf6GuP384kOjwQkq/y2KVRRLu2l/d+TdUw=;
	b=C066PmjTsIJh7MXj7N2OrQVfp7hju5dl3OZzRnO1plPcDr+b/Lj4fqA48UfuDfXMzaMc
	 hgQyyr/DalOJTf5VndW5+Y5l7zmdp6xIoXcf8d+R2g7OzeSU+vMGI0jLfJnH8l/3GQ235
	 QkGkbLIlmE7AKVDNTljA06FeoaNLAcKal8v9AzOXiJVR1539hEU81DWwCrDYBZSqx3XQ3
	 PFqslnccjtJfiUSXAkxe1Yvk2ByxFLp1rCqGmTAUnIjfCoLiWKsdznbEUdqXCwQolKYBJ
	 rop8CgWqRIvAuzrcPYseGdYRxk//1/Lm5D1K3Dy1dUZzz3RAkp0NyfbdVjU3loWSkFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cj0IM7MX;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3160B606A323
	for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2026 16:35:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3160B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cj0IM7MX
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2e977109392so9817815ad.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2026 09:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792859728; x=1793464528; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v9lh+B773rf6GuP384kOjwQkq/y2KVRRLu2l/d+TdUw=;
        b=cj0IM7MXu4d+VrnTPUtOdeDHOVplQNaTd6KJFLS2ksUTk/tneXL2xjceiGG/Q5jcFt
         uqisNf7l+ieEWxW+pzp/VzV4tCZaQZgi8PoqL7iKI1XQ2ZiM/g9V8LHDTYxPOKCMZ6PS
         846kxjdVokVw3uEw9K1VyN0RbGIYuNjTFNNdvVuzqE6YS5MWjJttPtDDR7oR/Tzf12jz
         zexoarhQsRR0GhYPMeaZcPWMETbn9FQYNmnpJU6dZckuHruvICQLV/SEPiNptz/QYu2R
         z5sIEGZnZLin+R7b2M1KuoM7E1OF2bMHPKLuVO/m7na7fCOKeFugsQQtDlfrj2kEOkTV
         IcuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792859728; x=1793464528;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v9lh+B773rf6GuP384kOjwQkq/y2KVRRLu2l/d+TdUw=;
        b=zqTkH0pYj8IMbaTv25/l16lF0u2kMyfGL3F3y4+11Qsfo93AxnEkuhlgKjUypyIS5o
         DFGe5ebUBYPZ2csvmOFo0P8KSD6QyCGZfUjHx7nt/0NsvFfnlqPpxB5qX4xUQhIvoP7U
         q9wa4Byz9IhqmkeoxSLpYyy0oUPe4/Ph3t8tO1JgZ9vxQEJzsTpPzh0M38w0zvqIjnYx
         cR7TRnYZv6PUylQSL/BaM5N8fA+hGQTsMSKqgkCr5x9TyrkGjMu3lRp3dE4STOx4qMCf
         tfZGfiAkbO3khc3iw9YsSdnA+07D/VmgK63z56P6BXqeBTQDdcunysgcIuZrwlWz17QA
         h24g==
X-Gm-Message-State: AFq9FYLYLU7+areC8tVj2CFupCU7MEKHleDFKYcOcYJtA5OOWG3UCJQD
	r3bYXyQ7nYaAKgSvaEAo0Vqe63Ygui95pnNDyCHQG6SYIi+ncCgdBEOmuQvJMbYumJNsxg==
X-Gm-Gg: AYBFou3kCQr8QU0yD/tbOaSKuZQJNPOf5eSSnOty8d3ULOca0cNfRJwAo5oK4Cze5GG
	1bSxaQFUz9umW3qlPXevCv86fljwpL7qTZBSRo7bTpjN/EdKjq3MV7i7RbF4ldavPZz6x80BExp
	8eSDc6/Weu6nEnmTdPf4zyvnz0f7BClejWXI5C+0UPTQXs/dO1P4/WPvm0q+DSItCYSAZB6K0Bl
	0le207N6pFw4ltaurTjoMiCG+VRPKVgeicCs/5CX4bxCbG2D1T1nRQn8X/7vCGBRlszlNKG+RZG
	T0YqA+nTub4CaV/MveDgspcheJl4wiYFm3vBbtmKSvR7yyFipcB81Gtoex8uOj3p9aAHbcGOLYI
	E/9BWwDj+OI0deZH2yTdqOSSw3JHybFYw/+YGSkf6LpHCQUIFMLLMPM/lvjSFWRpyoCCl74TD4o
	qO2yZlbdCS2wXv2WjiUxLRFto8omcgcvBxo/AKIktszyfrhKkddtZXTUxpoeswa6gXkf2p0h/wA
	hpr7ZXRy+TPRLZZGglAQ1lXqa+Uc7YhWUYU5nIWXmftnbOptSk=
X-Received: by 2002:a17:902:e946:b0:2e9:a090:dd69 with SMTP id d9443c01a7336-2ea9c80170dmr18935915ad.39.1792859728209;
        Sat, 24 Oct 2026 09:35:28 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b1a1c63sm6159575ad.47.2026.10.24.09.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 09:35:27 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH v2] Bluetooth: L2CAP: Protect the receive reject-list lookup
Date: Sun, 25 Oct 2026 00:35:21 +0800
Message-Id: <pm-bluetooth-objects-candidate-0157-v8-a3b1b1bb30aa6b263b32@gmail.com>
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

Reject-list entries must remain alive throughout a lookup. Management
updates the list under hdev->lock, but l2cap_recv_frame() traverses it
under conn->lock after l2cap_recv_acldata() has released hdev->lock.

An established LE connection can still receive ACL data after its peer
has been added to the reject list. If a management socket unblocks that
peer during the receive-side lookup, the following ordering is possible:

  HCI receive                        Management
  l2cap_recv_acldata()
    release hdev->lock
    acquire conn->lock
  l2cap_recv_frame()
    lookup selects entry
                                     unblock_device()
                                       acquire hdev->lock
                                       hci_bdaddr_list_del()
                                         unlink and kfree(entry)
    read entry->bdaddr_type

Management does not take conn->lock, so deletion can free the selected
entry before the lookup reads its fields. This causes a use-after-free
read in hci_bdaddr_list_lookup().

Compute the reject decision under the existing device lock in
l2cap_recv_acldata() and pass only the boolean to l2cap_recv_frame().
For pending receive data, take the snapshot in l2cap_conn_ready() and
l2cap_security_cfm(), which already hold hdev->lock. Publish it under
conn->lock before queuing the worker on the existing device workqueue:

  HCI callback                       Pending RX worker
    hold hdev->lock
    acquire conn->lock
    lookup reject list
    save boolean; queue work
    release conn->lock
                                       acquire conn->lock
                                       consume boolean
                                       drain pending frames

The snapshot belongs to the scheduled batch. A subsequent scheduling
callback refreshes it under both locks, including when queue_work()
coalesces with already pending work. No reject-list pointer survives the
lookup, and the worker reads the boolean under conn->lock.

Taking the device lock in the worker would deadlock against
l2cap_conn_del(), which holds it while cancelling the work synchronously.
A failed trylock followed by immediate self-requeue would instead keep
retrying without a delay and extend a concurrent workqueue drain. Keep
the lookup in the scheduling callbacks so the worker needs neither the
device lock nor a retry. Skip scheduling when pending_rx is empty.

KASAN report as below:

    ==================================================================
    BUG: KASAN: slab-use-after-free in hci_bdaddr_list_lookup+0x145/0x160
    Read of size 1 at addr ffff88810cba64d6 by task kworker/u17:0/493

    Workqueue: hci0 hci_rx_work
    Call Trace:
     <TASK>
     dump_stack_lvl+0x93/0xd0
     print_report+0xce/0x630
     ? hci_bdaddr_list_lookup+0x145/0x160
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __virt_addr_valid+0x20d/0x410
     ? hci_bdaddr_list_lookup+0x145/0x160
     kasan_report+0xe0/0x110
     ? hci_bdaddr_list_lookup+0x145/0x160
     hci_bdaddr_list_lookup+0x145/0x160
     l2cap_recv_frame+0x865/0x8830
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __mutex_lock+0x182c/0x2590
     ? __pfx_l2cap_recv_frame+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? find_held_lock+0x2b/0x80
     ? l2cap_recv_acldata+0x1eb/0x10e0
     ? __pfx___mutex_lock+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __mutex_unlock_slowpath+0x147/0x920
     ? __pfx_l2cap_conn_hold_unless_zero+0x10/0x10
     ? __pfx_hci_conn_enter_active_mode+0x10/0x10
     ? l2cap_recv_acldata+0x13d/0x10e0
     ? srso_alias_return_thunk+0x5/0xfbef5
     l2cap_recv_acldata+0xe9f/0x10e0
     ? srso_alias_return_thunk+0x5/0xfbef5
     hci_rx_work+0x5a6/0xf00
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

    Allocated by task 604:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     __kasan_kmalloc+0xaa/0xb0
     __kmalloc_cache_noprof+0x251/0x610
     hci_bdaddr_list_add+0xdf/0x2c0
     block_device+0x112/0x260
     hci_sock_sendmsg+0x128b/0x22e0
     sock_write_iter+0x4c0/0x550
     do_iter_readv_writev+0x59c/0x860
     vfs_writev+0x30e/0xc10
     do_writev+0x241/0x2f0
     do_syscall_64+0x115/0x6a0
     entry_SYSCALL_64_after_hwframe+0x77/0x7f

    Freed by task 606:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     kasan_save_free_info+0x3b/0x60
     __kasan_slab_free+0x5f/0x80
     kfree+0x307/0x580
     hci_bdaddr_list_del+0x1a9/0x2a0
     unblock_device+0x112/0x260
     hci_sock_sendmsg+0x128b/0x22e0
     sock_write_iter+0x4c0/0x550
     do_iter_readv_writev+0x59c/0x860
     vfs_writev+0x30e/0xc10
     do_writev+0x241/0x2f0
     do_syscall_64+0x115/0x6a0
     entry_SYSCALL_64_after_hwframe+0x77/0x7f

    The buggy address belongs to the object at ffff88810cba64c0
                                                                which
                                belongs to the cache kmalloc-32 of size 32
    The buggy address is located 22 bytes inside of
                                                                freed
                                32-byte region [ffff88810cba64c0,
                                ffff88810cba64e0)

    The buggy address belongs to the physical page:
        page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0
    pfn:0x10cba6
    flags: 0x200000000000000(node=0|zone=2)
    page_type: f5(slab)
        raw: 0200000000000000 ffff888100042780 dead000000000100
    dead000000000122
        raw: 0000000000000000 0000000000400040 00000000f5000000
    0000000000000000
    page dumped because: kasan: bad access detected

    Memory state around the buggy address:
     ffff88810cba6380: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
     ffff88810cba6400: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
    >ffff88810cba6480: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
                                                     ^
     ffff88810cba6500: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
     ffff88810cba6580: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
    ==================================================================

Fixes: cc8dba2bc302 ("Bluetooth: Block ATT connection on LE when device is blocked")
Assisted-by: LLM
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
Changes in v2:
- Address the immediate self-requeue concern raised by Sashiko:
  https://sashiko.dev/#/patchset/95508
- Snapshot reject-list membership under hdev->lock in the connection and
  security callbacks, and pass the decision to pending RX under conn->lock.
- Remove the worker trylock and self-requeue, and avoid scheduling an empty
  pending RX queue.

Link to v1: https://lore.kernel.org/r/pm-bluetooth-objects-candidate-0157-v7-408aa9db5365c34b5f8b@gmail.com

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 54eddcdd341f9..bca4a16c99b54 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -636,6 +636,7 @@ struct l2cap_conn {
 
 	struct sk_buff_head	pending_rx;
 	struct work_struct	pending_rx_work;
+	bool			pending_rx_blocked __guarded_by(&lock);
 
 	struct delayed_work	id_addr_timer;
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 83b622a428118..fda25fe726c26 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1759,10 +1759,40 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 	}
 }
 
-static void l2cap_conn_ready(struct l2cap_conn *conn)
+static bool l2cap_is_blocked(struct hci_conn *hcon)
+	__must_hold(&hcon->hdev->lock)
+{
+	/* Since we can't actively block incoming LE connections we must
+	 * at least ensure that we ignore incoming data from them.
+	 */
+	return hcon->type == LE_LINK &&
+	       hci_bdaddr_list_lookup(&hcon->hdev->reject_list, &hcon->dst,
+				      bdaddr_dst_type(hcon));
+}
+
+static void l2cap_queue_pending_rx(struct hci_conn *hcon)
+	__must_hold(&hcon->hdev->lock)
 {
+	struct l2cap_conn *conn = hcon->l2cap_data;
+
+	mutex_lock(&conn->lock);
+
+	if (!skb_queue_empty(&conn->pending_rx)) {
+		/* Teardown holds hdev->lock while cancelling the worker.
+		 * Pass the decision under conn->lock to avoid that lock.
+		 */
+		conn->pending_rx_blocked = l2cap_is_blocked(hcon);
+		queue_work(hcon->hdev->workqueue, &conn->pending_rx_work);
+	}
+
+	mutex_unlock(&conn->lock);
+}
+
+static void l2cap_conn_ready(struct hci_conn *hcon)
+	__must_hold(&hcon->hdev->lock)
+{
+	struct l2cap_conn *conn = hcon->l2cap_data;
 	struct l2cap_chan *chan;
-	struct hci_conn *hcon = conn->hcon;
 
 	BT_DBG("conn %p", conn);
 
@@ -1794,7 +1824,7 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
 	if (hcon->type == LE_LINK)
 		l2cap_le_conn_ready(conn);
 
-	queue_work(hcon->hdev->workqueue, &conn->pending_rx_work);
+	l2cap_queue_pending_rx(hcon);
 }
 
 /* Notify sockets that we cannot guaranty reliability anymore */
@@ -7381,7 +7411,8 @@ static void l2cap_conless_channel(struct l2cap_conn *conn, __le16 psm,
 	kfree_skb(skb);
 }
 
-static void l2cap_recv_frame(struct l2cap_conn *conn, struct sk_buff *skb)
+static void l2cap_recv_frame(struct l2cap_conn *conn, struct sk_buff *skb,
+			     bool blocked)
 	__must_hold(&conn->lock)
 {
 	struct l2cap_hdr *lh = (void *) skb->data;
@@ -7408,12 +7439,7 @@ static void l2cap_recv_frame(struct l2cap_conn *conn, struct sk_buff *skb)
 		return;
 	}
 
-	/* Since we can't actively block incoming LE connections we must
-	 * at least ensure that we ignore incoming data from them.
-	 */
-	if (hcon->type == LE_LINK &&
-	    hci_bdaddr_list_lookup(&hcon->hdev->reject_list, &hcon->dst,
-				   bdaddr_dst_type(hcon))) {
+	if (blocked) {
 		kfree_skb(skb);
 		return;
 	}
@@ -7461,7 +7487,7 @@ static void process_pending_rx(struct work_struct *work)
 	 */
 	while (!test_bit(HCI_CONN_ENC_KEY_SIZE_PEND, conn->hcon->flags) &&
 	       (skb = skb_dequeue(&conn->pending_rx)))
-		l2cap_recv_frame(conn, skb);
+		l2cap_recv_frame(conn, skb, conn->pending_rx_blocked);
 
 	mutex_unlock(&conn->lock);
 }
@@ -7912,7 +7938,7 @@ static void l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
 
 	mutex_unlock(&conn->lock);
 
-	l2cap_conn_ready(conn);
+	l2cap_conn_ready(hcon);
 }
 
 int l2cap_disconn_ind(struct hci_conn *hcon)
@@ -8051,8 +8077,7 @@ static void l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 	mutex_unlock(&conn->lock);
 
 	/* Process data held back while the encryption key size was read */
-	if (!skb_queue_empty(&conn->pending_rx))
-		queue_work(hcon->hdev->workqueue, &conn->pending_rx_work);
+	l2cap_queue_pending_rx(hcon);
 }
 
 /* Append fragment into frame respecting the maximum len of rx_skb */
@@ -8141,6 +8166,7 @@ int l2cap_recv_acldata(struct hci_dev *hdev, u16 handle,
 {
 	struct hci_conn *hcon;
 	struct l2cap_conn *conn;
+	bool blocked;
 	int len;
 
 	/* Lock hdev for hci_conn, and race on l2cap_data vs. l2cap_conn_del */
@@ -8163,6 +8189,7 @@ int l2cap_recv_acldata(struct hci_dev *hdev, u16 handle,
 		conn = l2cap_conn_add(hcon);
 
 	conn = l2cap_conn_hold_unless_zero(conn);
+	blocked = l2cap_is_blocked(hcon);
 	hcon = NULL;
 
 	hci_dev_unlock(hdev);
@@ -8199,7 +8226,7 @@ int l2cap_recv_acldata(struct hci_dev *hdev, u16 handle,
 
 		if (len == skb->len) {
 			/* Complete frame received */
-			l2cap_recv_frame(conn, skb);
+			l2cap_recv_frame(conn, skb, blocked);
 			goto unlock;
 		}
 
@@ -8223,7 +8250,7 @@ int l2cap_recv_acldata(struct hci_dev *hdev, u16 handle,
 			 * setting the socket unreliable.
 			 */
 			skb->len = len;
-			l2cap_recv_frame(conn, skb);
+			l2cap_recv_frame(conn, skb, blocked);
 			l2cap_conn_unreliable(conn, ECOMM);
 			goto unlock;
 		}
@@ -8273,7 +8300,7 @@ int l2cap_recv_acldata(struct hci_dev *hdev, u16 handle,
 			 */
 			struct sk_buff *rx_skb = conn->rx_skb;
 			conn->rx_skb = NULL;
-			l2cap_recv_frame(conn, rx_skb);
+			l2cap_recv_frame(conn, rx_skb, blocked);
 		}
 		break;
 	}
