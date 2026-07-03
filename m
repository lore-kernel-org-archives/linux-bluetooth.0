Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E32369D6D
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jul 2026 06:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783058433; cv=none; b=EDAHwtcKnCNHrBqarxPJgIAGvmGwyGybDNHnzYoj6VzxJ16a944uOezGjzYQt1rmBlzwqf7b+7jcelPue0dyqDlgiTQ8K7G6BlhIltu9ZWW523hFxHfrxSVEtVCoqaT/ALd5jimRJ4H5A7+2L8pkKkN/a0gm6uKpX1iRzxsLI+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783058433; c=relaxed/simple;
	bh=atP7g4IBtupcIE+IdB1OY+5/KuPkN9O3UpoGrIHTXZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WH3S+auC8REABWhOdOv4On6hnuYmYL+vDvBYW6sAMdXhPrbD3eyw3AgbFnAdm/lLhKsijzN5jp2LvXNUVqS4mlW+Idz0to7Qta8Tuu2mJAmPCoPu6VzGN9GFnW+My1/EMg5AiY56KvZzhMFE7YGjf0E18sDoSKbYOahi5drOd3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fdUp4NNZ; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdUp4NNZ"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-37d55e8d3e3so200513a91.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Jul 2026 23:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783058432; x=1783663232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uY0YIBWdRXialTsUhw9JLtYE3cJC3MxCLmqngIB1YE0=;
        b=fdUp4NNZU4h43d6TdpkDvClKdeq+MzvB1z1qNa/6vz+gxZRzGeFd066HqQFw8FX8b1
         kzL3gYLpRh48c19CW1FAIEq+vrkQ45o+pU7papqXHnwVrlNfk1MT6AIyK8EXz+uV+3iK
         oHLGH3yKjNsDYZFHlPK4CKQ6ooOUlY796tvpBHgi0LovJ2Jzs/Z+p+DfMavkItbZVEqF
         7VsOt3q5Hepw7li+udj/HqnA2Uhe+disUpnzkEtmZPVWERKYmYRclZVLEaBy/qX+sFhG
         mwE0OwipyiwQsJYCE+PIMmsoLc3XciTtl3a5qRU8+zr7JptiorkGCUJN7xulsQSNBrOz
         UTtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783058432; x=1783663232;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uY0YIBWdRXialTsUhw9JLtYE3cJC3MxCLmqngIB1YE0=;
        b=fUjw1zHCCTByPqqDUXmIQ1fALHZOC8eB921GV80b0b4Y9j6Kn+QTZuLX94vGT0pvtl
         hP+nDMOV8dZ4CuGch6apAkK7hV0mWfHhEzGLwSaxx7H2/Tcc53bcFUNcAd3seAEuXkqx
         4HDy3EqLgJOEf4Y1tsmfx6GACPyTYldcig0LDs4gzlJeaI5I2j54VOl15h1XnjL0iVDm
         90ubkV4Erqgh4XzmdnVXrkWONrU0P1nxyqp03WkWceogpLhDCH0+eOd1aK7TNiu7YZQb
         5Bx0HAGZzGOJ3IoFDO5rRjD7OTSzncQ+RnwhIgcVrZ6GsMnIxBHHzvuK37JTzs1hfRHI
         Ld5w==
X-Gm-Message-State: AOJu0YyHSyKkoYZxajdcmROaCidYRS0sB5XXpdI8UMpmtwQWZEWM3/8M
	KdbtvH23a5x4/rSzaRthlht04hu82lfW4Ay0D57O/rTiUn4KdpTTbUiR
X-Gm-Gg: AfdE7cmXiUxBU0DFkXQjGuzU8laUSSZ362N2hc35PPCZ/QGu9T1nP2i9kGIUqHz+Tp7
	CWHRmDum6bAJmhnj8+jYhVI/4A41fgj6cQwCJWjcBh6xnd0JlrucMx7agiviF/3y/5g/dNFwYhk
	eAGd3sm6/fCbqeNdOf37sqW25B3eRjvhyyLNgJLiG5rJg84drGjr0jhP92ixFy7qTRGBcvtk/79
	g4kyGa3IbUsKnRQoetNRdwiUGKbx0KkvP/UP1LFE8r6gIp6qCu4q5/RR1RVcZC4KCvV4sOTs2Sg
	IskDNWNhI2erYt9/CChR+zsGMNir3Y7dU0mF5ljLfg5bysEXFbIEKnGm0Nh8Wt9KWOgbDD38UJ/
	vu/HWU0Lsitj+V5X+3L8PLkVku/RDUKHGX9BJudgDUHK3SmR6aaY7uC567YntVIfCCIA09SNRIL
	2REYe9Lcc=
X-Received: by 2002:a17:90b:4c4e:b0:37f:b80c:980d with SMTP id 98e67ed59e1d1-3811209124amr2771810a91.4.1783058431136;
        Thu, 02 Jul 2026 23:00:31 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38097e81d81sm2317016a91.0.2026.07.02.23.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 23:00:30 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	baijiaju1990@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH] Bluetooth: MGMT: dequeue queued mesh send before freeing canceled tx
Date: Fri,  3 Jul 2026 14:00:24 +0800
Message-Id: <20260703060024.570535-1-zzzccc427@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mesh_next() queues mesh_send_sync() with a raw mgmt_mesh_tx pointer after
a previous mesh send completes. MGMT_OP_MESH_SEND_CANCEL can already be
queued on the same hci_cmd_sync_work list. If cancel runs before the queued
send, it can remove and free the same mgmt_mesh_tx while mesh_send_sync()
still carries that pointer as callback data.

The buggy scenario involves two paths, with each column showing the order
within that path:

  mesh completion path:              cancel command path:
  1. mesh_send_done_sync() returns   1. send_cancel is already queued
  2. mesh_next() selects next_tx     2. send_cancel finds next_tx
  3. mesh_next() queues              3. send_cancel frees next_tx
     mesh_send_sync(next_tx)
  4. mesh_send_sync() later
     dereferences next_tx

Validation reproduced this kernel report:
BUG: KASAN: slab-use-after-free in mesh_send_sync+0x5a/0x1c0 [bluetooth]
Read of size 1 at addr ffff88811a01d13b by task kworker/u17:0/562
Workqueue: hci0 hci_cmd_sync_work [bluetooth]

Call Trace:
 <TASK>
 dump_stack_lvl+0x66/0xa0
 print_report+0xce/0x5f0
 ? mesh_send_sync+0x5a/0x1c0 [bluetooth]
 ? __virt_addr_valid+0x19f/0x330
 ? mesh_send_sync+0x5a/0x1c0 [bluetooth]
 kasan_report+0xe0/0x110
 ? mesh_send_sync+0x5a/0x1c0 [bluetooth]
 ? __pfx_mesh_send_sync+0x10/0x10 [bluetooth]
 mesh_send_sync+0x5a/0x1c0 [bluetooth]
 ? mesh_send_sync+0x9/0x1c0 [bluetooth]
 ? __pfx_mesh_send_sync+0x10/0x10 [bluetooth]
 hci_cmd_sync_work+0x187/0x210 [bluetooth]
 process_one_work+0x4fd/0xbc0
 worker_thread+0x2d8/0x570
 kthread+0x1ad/0x1f0
 ret_from_fork+0x3c9/0x540
 ret_from_fork_asm+0x1a/0x30

Allocated by task 602:
 kasan_save_stack+0x33/0x60
 kasan_save_track+0x17/0x60
 __kasan_kmalloc+0xaa/0xb0
 mgmt_mesh_add+0x41/0x1a0 [bluetooth]
 mesh_send+0x197/0x3a0 [bluetooth]
 hci_sock_sendmsg+0x96b/0xf80 [bluetooth]
 __sys_sendto+0x2bc/0x2d0
 __x64_sys_sendto+0x76/0x90
 do_syscall_64+0x115/0x6a0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 562:
 kasan_save_stack+0x33/0x60
 kasan_save_track+0x17/0x60
 kasan_save_free_info+0x3b/0x60
 __kasan_slab_free+0x5f/0x80
 kfree+0x313/0x590
 send_cancel+0x1d8/0x210 [bluetooth]
 hci_cmd_sync_work+0x187/0x210 [bluetooth]
 process_one_work+0x4fd/0xbc0
 worker_thread+0x2d8/0x570
 kthread+0x1ad/0x1f0
 ret_from_fork+0x3c9/0x540
 ret_from_fork_asm+0x1a/0x30

Dequeue any queued mesh_send_sync() for the target tx from send_cancel().
When a queued send is found, the dequeue path invokes
mesh_send_start_complete(), which completes and frees the tx; send_cancel()
must not complete it again.

Fixes: b338d91703fa ("Bluetooth: Implement support for Mesh")
Assisted-by: Codex:gpt-5.5
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
 net/bluetooth/mgmt.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 733a4b70e10c..ac4922cb39b5 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2416,17 +2416,28 @@ static int send_cancel(struct hci_dev *hdev, void *data)
 	struct mgmt_mesh_tx *mesh_tx;
 
 	if (!cancel->handle) {
-		do {
+		for (;;) {
 			mesh_tx = mgmt_mesh_next(hdev, cmd->sk);
 
-			if (mesh_tx)
-				mesh_send_complete(hdev, mesh_tx, false);
-		} while (mesh_tx);
+			if (!mesh_tx)
+				break;
+
+			/* Dequeue any queued send before freeing the tx. */
+			if (hci_cmd_sync_dequeue(hdev, mesh_send_sync, mesh_tx,
+						 mesh_send_start_complete))
+				continue;
+
+			mesh_send_complete(hdev, mesh_tx, false);
+		}
 	} else {
 		mesh_tx = mgmt_mesh_find(hdev, cancel->handle);
 
-		if (mesh_tx && mesh_tx->sk == cmd->sk)
-			mesh_send_complete(hdev, mesh_tx, false);
+		if (mesh_tx && mesh_tx->sk == cmd->sk) {
+			/* Dequeue any queued send before freeing the tx. */
+			if (!hci_cmd_sync_dequeue(hdev, mesh_send_sync, mesh_tx,
+						  mesh_send_start_complete))
+				mesh_send_complete(hdev, mesh_tx, false);
+		}
 	}
 
 	mgmt_cmd_complete(cmd->sk, hdev->id, MGMT_OP_MESH_SEND_CANCEL,
-- 
2.43.0
