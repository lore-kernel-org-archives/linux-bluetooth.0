Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79153331EBD
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 19:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781033555; cv=none; b=dWBIa/Xp3ZFGxAfLmNccrUjvrm/V76mTkmTlQKVNKEPoTr+rvJHX0M02AdkSVAlqPhqLmmJvXsfRAwOI3zSzqdRvekmriQBDaX5pznNb5eozbyRuUFkGm8xTMYN2zW9rxw3dW7UKKz5gPhPZuBWXrRB7gm+wd7NzRYgwTkQ/ThU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781033555; c=relaxed/simple;
	bh=r5+TT+K2DshjLbFkS5/29N2Kxy+T4N4Jqt+rXnplWD0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=I4nJ6d1mOycL+XVETDLGQG5n1Se+XijysW82wBKmE+mSJsTWtMkDc64HC9tLMl7aiLqeTyegQcTDQ4RAu2dIzK9ZDwIAU7vo4y8b922cW6h9LVUYZzlWMnqyBVbHaYm9nTusSwlBE5gdFYlQRrGbtOn9zn+kFbfExkbCAqTDAWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZzHrCsQ; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZzHrCsQ"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-59d6e44e5c8so4200283e0c.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 12:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781033552; x=1781638352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=nGoy4wy4fwV3puY0jXBE4oXRISOgmbzm26kgDCWwgE0=;
        b=gZzHrCsQ6mykJ2VOhqkr5JlFcXA0AzvbmYcxZ7uUKxdGoyisYWtM3T4t04i2K5D1K3
         dTLy7dkG80DDfSWudcjWlvZwlTmS7seI3J71OmuMx7mE5znZtiBbiOomk27aE15ov9Pb
         6RhgtwC9vtqKr4mywMB6a+0swDRtRbas27GQ5eLzfi9WYKdWYrJitp5VT36/k1kepNAU
         uPhNdCaVKDLXTB4Xm2Qr7RgYuWu7jtqF6EGFEgvGXWL31l5LuJMWX3UR05hVoSsNlQby
         tfuHODihMSF7iqKJwNhaJ4rH7KDMQoeTO5rjTgzA3R5+zp0Z4XfczoJSYj5FvjLzfQ7V
         M+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781033552; x=1781638352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nGoy4wy4fwV3puY0jXBE4oXRISOgmbzm26kgDCWwgE0=;
        b=qMQNmtV24OrYQjfZvkEt7AYdtdP8yjSTocXkGRLEGhllrEgANadtwKo+FNUlPWEBLt
         foF8A+BWTa5Lb+9ImyJIQPDj2Iirr3jRrWyPZtqMvLB3ZzuOvHtWlWIwMZdgaZqKlgTo
         EwcSwol+o7hZ1QStc7wHL36GIQJgQ0IFR889gUm0ye0MyoohnA1h7nodMXg8rYv3btl4
         1VSMEPnvszFvYAzN4loisTxc2ajfI2Yyt1IgOFK7IUBa9oCPiEJ8niSvY9jOeXakLutn
         ImpU9PGpyj7GrZzABDnI43wESz2s7ZuznOWm5EyF4Wb1715Qw4UtHrItC7xm10wAvi2b
         nuEg==
X-Gm-Message-State: AOJu0YzGkSYbyS1hYMefZU3AzeEs8nb4ZdA2vyDY/vpAt1Jj2cK9ewTk
	CFi0VzZjWGHxgHJdB1z1F1IvyNbKU6e/jbJdkK4pXrJswLh+pQ6hRuOGxFc8Pg==
X-Gm-Gg: Acq92OEgMKG5hwOQd1afFxfitoJllqkdXBpNU+lksDMp8/V5O+2ZClDtte7TZY6dG2/
	yb/OBoxF7CY8mSchAAxKfelCcoqO0SAsp1zExte1+hGnyGbHOCm5Ed8TZGix14A3cafwAJbWUJk
	qX1GtxxV0Rs2nL69KipRKwF8V2bvEO6qXhntsDu8CsqbCnXMKjEVUTwYaBVLCTYUo2TfZY/efvg
	5K0wfDIFsMGMsgWdMPAlm7gB3M8dT2kED6sBdleEw2VsrBE2870/2klCpRwULdKI4RVJfwo7e5V
	OiEeWJQJcASHS2qxWrnI5tEgk8JbUEElbPYIoP7My7FKJDvJoV2SmoR8UicoLXMqzVNqi6/vmW1
	iGOJgLdvCC3Anp50eATBS7Wl5h+o6t23xDwwkavghry/ZASOHIGe72HAL+g26LiE0xCWaxu6VZ8
	fw6PGjlxF53ZAZesS+N/3iZUKF+pIXkoPevBs+J+665VRzguSXfb3ke5ZEMZV7tLn22/uITBxd9
	hlJbOjYxkJLnhGsYK9tsGs1xmuVTLEjy17isMQ=
X-Received: by 2002:a05:6122:8296:b0:56b:9b7b:83e7 with SMTP id 71dfb90a1353d-5ac4e7acf3cmr11184085e0c.7.1781033552295;
        Tue, 09 Jun 2026 12:32:32 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9641414e193sm16964946241.11.2026.06.09.12.32.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 12:32:31 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3] Bluetooth: L2CAP: Fix UAF in channel timeout by holding conn ref
Date: Tue,  9 Jun 2026 15:32:22 -0400
Message-ID: <20260609193222.192456-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marco Elver <elver@google.com>

l2cap_chan_timeout() runs asynchronously and accesses chan->conn. If
the connection is torn down while the timer is running or pending,
chan->conn can be freed, leading to a use-after-free when the timer
worker attempts to lock conn->lock:

| BUG: KASAN: slab-use-after-free in instrument_atomic_read_write include/linux/instrumented.h:112 [inline]
| BUG: KASAN: slab-use-after-free in atomic_long_try_cmpxchg_acquire include/linux/atomic/atomic-instrumented.h:4456 [inline]
| BUG: KASAN: slab-use-after-free in __mutex_trylock_fast kernel/locking/mutex.c:161 [inline]
| BUG: KASAN: slab-use-after-free in mutex_lock+0x4f/0xa0 kernel/locking/mutex.c:318
| Write of size 8 at addr ffff8881298d9550 by task kworker/2:1/83
|
| CPU: 2 UID: 0 PID: 83 Comm: kworker/2:1 Not tainted 7.1.0-rc6-next-20260601-dirty #6 PREEMPT(full)
| Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
| Workqueue: events l2cap_chan_timeout
| Call Trace:
|  <TASK>
|  instrument_atomic_read_write include/linux/instrumented.h:112 [inline]
|  atomic_long_try_cmpxchg_acquire include/linux/atomic/atomic-instrumented.h:4456 [inline]
|  __mutex_trylock_fast kernel/locking/mutex.c:161 [inline]
|  mutex_lock+0x4f/0xa0 kernel/locking/mutex.c:318
|  l2cap_chan_timeout+0x5d/0x1b0 net/bluetooth/l2cap_core.c:422
|  process_one_work kernel/workqueue.c:3326 [inline]
|  process_scheduled_works+0x7c8/0xfb0 kernel/workqueue.c:3409
|  worker_thread+0x8a9/0xcf0 kernel/workqueue.c:3490
|  kthread+0x346/0x430 kernel/kthread.c:436
|  ret_from_fork+0x1a3/0x470 arch/x86/kernel/process.c:158
|  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
|  </TASK>
|
| Allocated by task 320:
|  l2cap_conn_add+0xa7/0x820 net/bluetooth/l2cap_core.c:7075
|  l2cap_connect_cfm+0xdb/0xd70 net/bluetooth/l2cap_core.c:7452
|  hci_connect_cfm include/net/bluetooth/hci_core.h:2139 [inline]
|  hci_remote_features_evt+0x52f/0x9f0 net/bluetooth/hci_event.c:3760
|  hci_event_func net/bluetooth/hci_event.c:7796 [inline]
|  hci_event_packet+0x561/0xa70 net/bluetooth/hci_event.c:7847
|  hci_rx_work+0x370/0x890 net/bluetooth/hci_core.c:4040
|  process_one_work kernel/workqueue.c:3326 [inline]
|  process_scheduled_works+0x7c8/0xfb0 kernel/workqueue.c:3409
|  worker_thread+0x8a9/0xcf0 kernel/workqueue.c:3490
|  kthread+0x346/0x430 kernel/kthread.c:436
|  ret_from_fork+0x1a3/0x470 arch/x86/kernel/process.c:158
|  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
|
| Freed by task 322:
|  hci_disconn_cfm include/net/bluetooth/hci_core.h:2154 [inline]
|  hci_conn_hash_flush+0x101/0x1f0 net/bluetooth/hci_conn.c:2736
|  hci_dev_close_sync+0x889/0xde0 net/bluetooth/hci_sync.c:5405
|  hci_dev_do_close net/bluetooth/hci_core.c:502 [inline]
|  hci_unregister_dev+0x1f7/0x370 net/bluetooth/hci_core.c:2679
|  vhci_release+0x12a/0x180 drivers/bluetooth/hci_vhci.c:690
|  __fput+0x369/0x890 fs/file_table.c:510
|  task_work_run+0x160/0x1d0 kernel/task_work.c:233
|  get_signal+0xf5b/0x1120 kernel/signal.c:2810
|  arch_do_signal_or_restart+0x4d/0x600 arch/x86/kernel/signal.c:337
|  __exit_to_user_mode_loop kernel/entry/common.c:64 [inline]
|  exit_to_user_mode_loop+0x85/0x510 kernel/entry/common.c:98
|  do_syscall_64+0x263/0x3d0 arch/x86/entry/syscall_64.c:100
|  entry_SYSCALL_64_after_hwframe+0x77/0x7f
|
| The buggy address belongs to the object at ffff8881298d9400
|  which belongs to the cache kmalloc-512 of size 512
| The buggy address is located 336 bytes inside of
|  freed 512-byte region [ffff8881298d9400, ffff8881298d9600)

Fix it by having chan->conn hold a reference to l2cap_conn (via
l2cap_conn_get) when the channel is added to the connection, and
releasing it in the channel destructor. This ensures the l2cap_conn
remains alive as long as the channel exists.

A new FLAG_DEL channel flag is introduced to indicate that the channel
has been deleted from its connection. l2cap_chan_del() atomically sets
this flag using test_and_set_bit() instead of setting chan->conn to
NULL. All asynchronous workers (l2cap_chan_timeout, l2cap_ack_timeout,
l2cap_monitor_timeout, l2cap_retrans_timeout) and l2cap_chan_send()
check FLAG_DEL to determine whether the channel has been torn down,
rather than testing chan->conn for NULL.

Fixes: 75780ca4c6a8 ("Bluetooth: L2CAP: use chan timer to close channels in cleanup_listen()")
Cc: <stable@vger.kernel.org>
Cc: Siwei Zhang <oss@fourdim.xyz>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Assisted-by: Gemini:gemini-3.1-pro-preview
Reported-by: https://sashiko.dev/#/patchset/20260521021249.3258069-1-oss%40fourdim.xyz
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/l2cap.h |  1 +
 net/bluetooth/l2cap_core.c    | 34 ++++++++++++++++++++--------------
 2 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 790935950a0c..1640cc9bf83a 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -745,6 +745,7 @@ enum {
 	FLAG_ECRED_CONN_REQ_SENT,
 	FLAG_PENDING_SECURITY,
 	FLAG_HOLD_HCI_CONN,
+	FLAG_DEL,
 };
 
 /* Lock nesting levels for L2CAP channels. We need these because lockdep
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 863fc4b8a55e..a97d492473e2 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -408,7 +408,7 @@ static void l2cap_chan_timeout(struct work_struct *work)
 
 	BT_DBG("chan %p state %s", chan, state_to_string(chan->state));
 
-	if (!conn) {
+	if (test_bit(FLAG_DEL, &chan->flags)) {
 		l2cap_chan_put(chan);
 		return;
 	}
@@ -419,6 +419,9 @@ static void l2cap_chan_timeout(struct work_struct *work)
 	 */
 	l2cap_chan_lock(chan);
 
+	if (test_bit(FLAG_DEL, &chan->flags))
+		goto unlock;
+
 	if (chan->state == BT_CONNECTED || chan->state == BT_CONFIG)
 		reason = ECONNREFUSED;
 	else if (chan->state == BT_CONNECT &&
@@ -431,10 +434,10 @@ static void l2cap_chan_timeout(struct work_struct *work)
 
 	chan->ops->close(chan);
 
+unlock:
 	l2cap_chan_unlock(chan);
-	l2cap_chan_put(chan);
-
 	mutex_unlock(&conn->lock);
+	l2cap_chan_put(chan);
 }
 
 struct l2cap_chan *l2cap_chan_create(void)
@@ -487,6 +490,9 @@ static void l2cap_chan_destroy(struct kref *kref)
 	list_del(&chan->global_l);
 	write_unlock(&chan_list_lock);
 
+	if (chan->conn)
+		l2cap_conn_put(chan->conn);
+
 	kfree(chan);
 }
 
@@ -590,7 +596,7 @@ void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 
 	conn->disc_reason = HCI_ERROR_REMOTE_USER_TERM;
 
-	chan->conn = conn;
+	chan->conn = l2cap_conn_get(conn);
 
 	switch (chan->chan_type) {
 	case L2CAP_CHAN_CONN_ORIENTED:
@@ -645,30 +651,26 @@ void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 
 void l2cap_chan_del(struct l2cap_chan *chan, int err)
 {
-	struct l2cap_conn *conn = chan->conn;
-
 	__clear_chan_timer(chan);
 
-	BT_DBG("chan %p, conn %p, err %d, state %s", chan, conn, err,
+	BT_DBG("chan %p, err %d, state %s", chan, err,
 	       state_to_string(chan->state));
 
 	chan->ops->teardown(chan, err);
 
-	if (conn) {
+	if (!test_and_set_bit(FLAG_DEL, &chan->flags)) {
 		/* Delete from channel list */
 		list_del(&chan->list);
 
 		l2cap_chan_put(chan);
 
-		chan->conn = NULL;
-
 		/* Reference was only held for non-fixed channels or
 		 * fixed channels that explicitly requested it using the
 		 * FLAG_HOLD_HCI_CONN flag.
 		 */
 		if (chan->chan_type != L2CAP_CHAN_FIXED ||
 		    test_bit(FLAG_HOLD_HCI_CONN, &chan->flags))
-			hci_conn_drop(conn->hcon);
+			hci_conn_drop(chan->conn->hcon);
 	}
 
 	if (test_bit(CONF_NOT_COMPLETE, &chan->conf_state))
@@ -1900,7 +1902,7 @@ static void l2cap_monitor_timeout(struct work_struct *work)
 
 	l2cap_chan_lock(chan);
 
-	if (!chan->conn) {
+	if (test_bit(FLAG_DEL, &chan->flags)) {
 		l2cap_chan_unlock(chan);
 		l2cap_chan_put(chan);
 		return;
@@ -1921,7 +1923,7 @@ static void l2cap_retrans_timeout(struct work_struct *work)
 
 	l2cap_chan_lock(chan);
 
-	if (!chan->conn) {
+	if (test_bit(FLAG_DEL, &chan->flags)) {
 		l2cap_chan_unlock(chan);
 		l2cap_chan_put(chan);
 		return;
@@ -2562,7 +2564,7 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
 	int err;
 	struct sk_buff_head seg_queue;
 
-	if (!chan->conn)
+	if (test_bit(FLAG_DEL, &chan->flags))
 		return -ENOTCONN;
 
 	/* Connectionless channel */
@@ -3157,12 +3159,16 @@ static void l2cap_ack_timeout(struct work_struct *work)
 
 	l2cap_chan_lock(chan);
 
+	if (test_bit(FLAG_DEL, &chan->flags))
+		goto unlock;
+
 	frames_to_ack = __seq_offset(chan, chan->buffer_seq,
 				     chan->last_acked_seq);
 
 	if (frames_to_ack)
 		l2cap_send_rr_or_rnr(chan, 0);
 
+unlock:
 	l2cap_chan_unlock(chan);
 	l2cap_chan_put(chan);
 }
-- 
2.54.0

