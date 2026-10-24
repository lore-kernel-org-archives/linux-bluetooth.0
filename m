Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792855769;
	b=RHwEeYu9fquRt0tZ1S0N/gZEMHxcDTB3tURDY7RvfHCSlVcRDP869m+11GnR8NhiXiMd
	 FuiOCg9MZo5IZRL1e8FCWqDObiursFf5baxCDCx0RDaW0J4o0GhenPm7zM+Q7ClbnRaDp
	 C8lz9H9vekDgIf6SZgrMsp7jZTu0qQQ+91JlLou1vHkLrj3uniB8yDjNq0jjJL7xFDUyP
	 9RMTB3D0dl0odAATZTiml/3SbzOLaS7NkxF5kIa5gQx6iqGY+fm394zgSVf6x8oeCo5eC
	 SJ98YNzqCaVKE+KTERCjyc5schJNE36VzGs9CNZ5eRzmD436255JCqyV+XcfPlgi3oA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792855769;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=HfBEcKEQM55Gq5BbF7CDIH7IhCs3J1u6U0qil8zYnpw=;
	b=n+2na4XoenTPlEAH3+k08Z2IMllk9/Y34Fky3pUmEJZzhcCchZx048Ydy8nNYhyTQtOI
	 VUE7uOIvPsMT0HsfHYZLznCLDMYKJavk2rIdOGdoW4jHnT4A3JxkYALKS9aQdfXpIzsmE
	 O2NlmohxrGt95rTC6QxNB5QT+UHt83APynOzT2mX+gZdqtxmCtXWnYNLl2frUj1Xg9/01
	 wpXmIcP6+nAKqcxlt1nEcqpQQRyQDwowS3AfY7sNLxcZyn3FLC7T5+yntEcV37nhl5qdc
	 pjDuR5PE03FIYytnBDpb1qEGnI1TnNZH+q9nXaL1+EV5JlDVdCm41QC1GXpHQiXEAAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kW8XtCR5;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75864606A31B
	for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2026 15:29:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75864606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kW8XtCR5
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ade49a7ebdso597491a91.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2026 08:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792855769; x=1793460569; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HfBEcKEQM55Gq5BbF7CDIH7IhCs3J1u6U0qil8zYnpw=;
        b=kW8XtCR55ldiSIB/2y/Nkx/a2vJqm3PXPxWinU/vdtHnzNEK9M+7JG101U1YMsYXDx
         OZDHXr/VB1rkEPZGhgd+CCs/atpZQtsmSortkhj7A2EJTAXseFPQozx6x3nSR6/mL4SW
         B5IMc1Du8r189VK9H8tbyy7ZrqBY2/DujRiY58RW936HTrULHKKpufQR5+mTqHcLYalH
         bOdjOIm5zcNAtkU3l49OuUqyBCHWa0Ii3k/zV8ZkeudtceCCBg6v7sOp3juZdpjwLLqL
         zGP6wgwXF4or90myrArDhFlibjDNkmA3WU8WqxjKGlpkxhg8aOjygOkaWXHr4eVOXm/Y
         4ksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792855769; x=1793460569;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HfBEcKEQM55Gq5BbF7CDIH7IhCs3J1u6U0qil8zYnpw=;
        b=q+CDQhFMCGs72G8Rk1t6eOkg6APDSFsuEe8htFEGHrfZ/N0WcsTI/Fn3K/Bkw7wfvq
         acTcQNoH/Ld8P19tCxPLPoNiyCn+gk7No3Gt1MrPFbYMGXA2Zz670ZW8FfAYXvhqSkm3
         hZW6n47beyYEwlRClhJf8PWew/hxl0zfwQF/wYVVMf4R/deIzO4gYVKxRFGdkhHO+2rl
         +XHRk33b3zewx+ANPNcqRUbIBRnYD1EuAyDCz+AvkezALYYQPNJ1aODmNfbtdopoHR1m
         3u8r023Ypei/4EMyGoGFWXX6w0xYmU5vMogTuq97SBc0H1WvpkN1Ao9LHBEKQRwQkxbC
         szZA==
X-Gm-Message-State: AFq9FYImEp7vrDFlsNHi+R0J9Xp8WZS6KRO3yhoEW/rVUxBFBX+bSR+i
	MgdI7QBfJch1sS1aL7ULNyQYuYofuSiN3Z2y2GLqLkzfcJSISAzGN48s
X-Gm-Gg: AYBFou2iVC2uDxHQic3Za1Nhus/pV9xgkxzRyx+OzE5EG52wD8Q+HRN0piIonoeUwTd
	bGPbTKcWYWwWiWEh3daPjSrFabWVjQO9GZjnvAk300LKSjAvtbqQMAhlIvv/m3+IZnK/rr7dc3/
	dBTKn8WGeTc2qGO/b6Qa5ArXNcFYnZHjC8/+umjKxI2Rc2SjFvN8QCQruhSShsyKWFXzYM2a3tB
	DqYdsNE4hJRZEcHWQFupTA4dkuAVZXfvBdkmdSkpVWPhP+D/XGgph630JJ5q9mqMRh7JS15kx0t
	VCgpnVey/MPspqp2XN3N9jYZgqiEE/X0/zPAE0LfPiQ0dd1CWD2asN0Qa4zc/ty+B119j0X19ll
	GcPTM4Us58FSgWSGinC2GJOxg+5MQemeowD+J5tYfU3KE9ZuQ3Lx4PRgJ/4HyqeDDsWHLtF01fr
	bUrYzlySVIJ/SU8qN4FPloOuM9gKwZ+gplMDvrgfH3XgIfUOF7jsovyei5jwZ1++nU0Es9Hl0OQ
	n9HljVW9o2APPHYjKbR47eOnxD1h+0QiGmhLvxAosq9pSx/Aa/fm3hF6YsDpf7ClEWrRrg2
X-Received: by 2002:a17:90b:55ce:b0:3ac:8fff:5a1b with SMTP id 98e67ed59e1d1-3adead5caa6mr2225695a91.34.1792855768648;
        Sat, 24 Oct 2026 08:29:28 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebfa4102sm3257860a91.12.2026.10.24.08.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 08:29:28 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH] Bluetooth: L2CAP: Protect the receive reject-list lookup
Date: Sat, 24 Oct 2026 23:29:22 +0800
Message-Id: <pm-bluetooth-objects-candidate-0157-v7-408aa9db5365c34b5f8b@gmail.com>
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
Take the same protected snapshot before draining pending receive data.
This completes the list access before management can free the entry,
without retaining a list pointer during frame processing.

Taking the device lock inside l2cap_recv_frame() would reverse the
established hdev->lock to conn->lock order. The pending receive worker
uses mutex_trylock() and requeues its existing work item on contention:
l2cap_conn_del() cancels that work synchronously while holding the
device lock, so the worker must not wait for it. Keep the teardown order
and release the device lock before taking conn->lock.

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
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 83b622a428118..8d0b38f0a0cf8 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7381,7 +7381,19 @@ static void l2cap_conless_channel(struct l2cap_conn *conn, __le16 psm,
 	kfree_skb(skb);
 }
 
-static void l2cap_recv_frame(struct l2cap_conn *conn, struct sk_buff *skb)
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
+static void l2cap_recv_frame(struct l2cap_conn *conn, struct sk_buff *skb,
+			     bool blocked)
 	__must_hold(&conn->lock)
 {
 	struct l2cap_hdr *lh = (void *) skb->data;
@@ -7408,12 +7420,7 @@ static void l2cap_recv_frame(struct l2cap_conn *conn, struct sk_buff *skb)
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
@@ -7450,10 +7457,22 @@ static void process_pending_rx(struct work_struct *work)
 {
 	struct l2cap_conn *conn = container_of(work, struct l2cap_conn,
 					       pending_rx_work);
+	struct hci_conn *hcon = conn->hcon;
 	struct sk_buff *skb;
+	bool blocked = false;
 
 	BT_DBG("");
 
+	if (hcon->type == LE_LINK) {
+		/* Teardown cancels this work while holding hdev->lock. */
+		if (!mutex_trylock(&hcon->hdev->lock)) {
+			queue_work(hcon->hdev->workqueue, work);
+			return;
+		}
+		blocked = l2cap_is_blocked(hcon);
+		hci_dev_unlock(hcon->hdev);
+	}
+
 	mutex_lock(&conn->lock);
 
 	/* l2cap_recv_frame() would queue it all again while the encryption
@@ -7461,7 +7480,7 @@ static void process_pending_rx(struct work_struct *work)
 	 */
 	while (!test_bit(HCI_CONN_ENC_KEY_SIZE_PEND, conn->hcon->flags) &&
 	       (skb = skb_dequeue(&conn->pending_rx)))
-		l2cap_recv_frame(conn, skb);
+		l2cap_recv_frame(conn, skb, blocked);
 
 	mutex_unlock(&conn->lock);
 }
@@ -8141,6 +8160,7 @@ int l2cap_recv_acldata(struct hci_dev *hdev, u16 handle,
 {
 	struct hci_conn *hcon;
 	struct l2cap_conn *conn;
+	bool blocked;
 	int len;
 
 	/* Lock hdev for hci_conn, and race on l2cap_data vs. l2cap_conn_del */
@@ -8163,6 +8183,7 @@ int l2cap_recv_acldata(struct hci_dev *hdev, u16 handle,
 		conn = l2cap_conn_add(hcon);
 
 	conn = l2cap_conn_hold_unless_zero(conn);
+	blocked = l2cap_is_blocked(hcon);
 	hcon = NULL;
 
 	hci_dev_unlock(hdev);
@@ -8199,7 +8220,7 @@ int l2cap_recv_acldata(struct hci_dev *hdev, u16 handle,
 
 		if (len == skb->len) {
 			/* Complete frame received */
-			l2cap_recv_frame(conn, skb);
+			l2cap_recv_frame(conn, skb, blocked);
 			goto unlock;
 		}
 
@@ -8223,7 +8244,7 @@ int l2cap_recv_acldata(struct hci_dev *hdev, u16 handle,
 			 * setting the socket unreliable.
 			 */
 			skb->len = len;
-			l2cap_recv_frame(conn, skb);
+			l2cap_recv_frame(conn, skb, blocked);
 			l2cap_conn_unreliable(conn, ECOMM);
 			goto unlock;
 		}
@@ -8273,7 +8294,7 @@ int l2cap_recv_acldata(struct hci_dev *hdev, u16 handle,
 			 */
 			struct sk_buff *rx_skb = conn->rx_skb;
 			conn->rx_skb = NULL;
-			l2cap_recv_frame(conn, rx_skb);
+			l2cap_recv_frame(conn, rx_skb, blocked);
 		}
 		break;
 	}
