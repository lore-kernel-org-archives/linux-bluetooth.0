Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18E0194094
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Feb 2025 21:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738875679; cv=none; b=gx/rQb8hsz7Jq16eUjNKH+Urx2fhvkjozBHvnzLhy6ybfKl0U/9bG0DdCpbJLW43tZ2rTwAJfgK9h8vZgHifeUmEhWbKjs6Rzr29XWw/Lc+xjHpVpGxywGVGlGcvbY87O2YG9BPychb9EgIHc++bo1uaAZW/pFS5Bci8BFE8yvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738875679; c=relaxed/simple;
	bh=lUG7z+GMLRpGvp0ZNk5JXrc2RlYGiHs7JxC+olMcGtA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=FOqgWqnHpTo7gVNj958GaCOy/7HkIu2pNIJRkKQbL+bn7ae1AWqGVmzL6VswgmTKwpTPRIpt/Vdm3q7UaEi0sBw4Z6rDYb6skCxp3FMCjvoQbjjgWp7dKjolH/8cUH4lTdz79DLDF+xK5m8KQMgbTIHm50mh6Ofry1ui3ZyFSfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QneqZaAs; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QneqZaAs"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-51eb1823a8eso345698e0c.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Feb 2025 13:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738875675; x=1739480475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ODTPIFwYomGmsdifVukaIkfVLIzTYtg92hF7v+es99I=;
        b=QneqZaAsmzVD6vYGHsS6PsLjPtgBVELCUlKGcwehUNPEoH2KE2IVBAKN8YG4zIURoi
         tILSUKkFv9dw+A8MaUeXtSH2E7J/OK0PLeprHpsg95mD35BMjvuIYt2Yu4xpr2w2o1Rt
         wTqXIXh9cc3fmp62lgTLEBr21AUKyuJ28pV+H2libn8P40DZG6X2cvboMklxuI81Q/90
         6jxjAYZw/KRAYm6xPq87a9myvFfqD34y5ovq8yISeAOflDv7GM3dPgb/bLmuQH9kW9bK
         2Dos3nVKYlbwky0ueE5rG2lSfYBhTuWQkDoc1imktq9tf3cA1ik2jUSIOiIU3wjtwpOw
         0zYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738875675; x=1739480475;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ODTPIFwYomGmsdifVukaIkfVLIzTYtg92hF7v+es99I=;
        b=Lg67AD5dkBJZLY3o95w1fBAMklYhLpfAAqjyHxq9ejyHZil9z4DmgGMYLOX9IAgEje
         KHJZwC4TqUTEdF55jnOBqP6yD84oFXCFK9QYRApIlD6pcTg3FHacprc1fwI06EJI7Zkn
         hRUkO4d/Fl7KIXbV1jtxemXV3PxKM6sNON+4fvHsE4TTuWzBCxBUCF5vSlWO6Sv8UjpN
         w8PIfIM37PugFOPAEGBLsqytsaZFt8fFNu1TXyXyowVfs6ATOKKIQwL8AiIvmz8g16St
         Wcebue+8DvA3RLT5cjyTiqOwOeZnzxOAt6WyGH3d5inl9QH4EkF6uZxljzQpUf1j/NWb
         3BAw==
X-Gm-Message-State: AOJu0YyT0Vj6V5QDDo8JsyoL/RXp4eDpELVK3Fb1SRoSq3VCtasLosrj
	O8C2V77lOQDpeqOtWvyuwBZo/CqSP6DDxymjXiADjPIuoPf9iYxwbFVgyQ==
X-Gm-Gg: ASbGncuXBE2YFMDAeokSKoL5EsInpgXVt/61HpNLlwZQpPq64qRBIZJYPHP18GPsLOv
	zq+kLkSvE88RVCA0KcZmQpiIvHP6dlRyHNPyvTf36gUZZnjSHnHldJIOzwee7CMo1vlpYYOnImQ
	apTKVz9BsCMTa9GuppgEjmDnF1GEaf8peiQ3nqrpu9/28QDJErMKlIv7z0t7bFYndY4ph4PpiVn
	11TT1DBBh5y+ojVPHENzWNyZ5btQhX+esIPPOhaQoDw4FKycqEkbMG94H9+vBzQrxoZVWtIqTBA
	Qo02kf4O7zRR3nq313mdLa82g0bYNswXRk4/oIgLfxhZN5cbLfr7PWySdgacE7w=
X-Google-Smtp-Source: AGHT+IFK4smnnrUcZGlo/TiLllCo7PFojtVJklKPv6OHWNHqBZDG+JNey4F1C65jSr4XT/hP4GWt+A==
X-Received: by 2002:a05:6122:3c85:b0:518:7777:a61e with SMTP id 71dfb90a1353d-51f2e1279f2mr915630e0c.5.1738875674396;
        Thu, 06 Feb 2025 13:01:14 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51f228d5d88sm301762e0c.31.2025.02.06.13.01.11
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 13:01:12 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: L2CAP: Fix corrupted list in hci_chan_del
Date: Thu,  6 Feb 2025 16:01:10 -0500
Message-ID: <20250206210110.3283152-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following trace by reworking the locking of l2cap_conn
so instead of only locking when changing the chan_l list this promotes
chan_lock to a general lock of l2cap_conn so whenever it is being held
it would prevents the likes of l2cap_conn_del to run:

list_del corruption, ffff888021297e00->prev is LIST_POISON2 (dead000000000122)
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:61!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 UID: 0 PID: 5896 Comm: syz-executor213 Not tainted 6.14.0-rc1-next-20250204-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
RIP: 0010:__list_del_entry_valid_or_report+0x12c/0x190 lib/list_debug.c:59
Code: 8c 4c 89 fe 48 89 da e8 32 8c 37 fc 90 0f 0b 48 89 df e8 27 9f 14 fd 48 c7 c7 a0 c0 60 8c 4c 89 fe 48 89 da e8 15 8c 37 fc 90 <0f> 0b 4c 89 e7 e8 0a 9f 14 fd 42 80 3c 2b 00 74 08 4c 89 e7 e8 cb
RSP: 0018:ffffc90003f6f998 EFLAGS: 00010246
RAX: 000000000000004e RBX: dead000000000122 RCX: 01454d423f7fbf00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: dffffc0000000000 R08: ffffffff819f077c R09: 1ffff920007eded0
R10: dffffc0000000000 R11: fffff520007eded1 R12: dead000000000122
R13: dffffc0000000000 R14: ffff8880352248d8 R15: ffff888021297e00
FS:  00007f7ace6686c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7aceeeb1d0 CR3: 000000003527c000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __list_del_entry_valid include/linux/list.h:124 [inline]
 __list_del_entry include/linux/list.h:215 [inline]
 list_del_rcu include/linux/rculist.h:168 [inline]
 hci_chan_del+0x70/0x1b0 net/bluetooth/hci_conn.c:2858
 l2cap_conn_free net/bluetooth/l2cap_core.c:1816 [inline]
 kref_put include/linux/kref.h:65 [inline]
 l2cap_conn_put+0x70/0xe0 net/bluetooth/l2cap_core.c:1830
 l2cap_sock_shutdown+0xa8a/0x1020 net/bluetooth/l2cap_sock.c:1377
 l2cap_sock_release+0x79/0x1d0 net/bluetooth/l2cap_sock.c:1416
 __sock_release net/socket.c:642 [inline]
 sock_close+0xbc/0x240 net/socket.c:1393
 __fput+0x3e9/0x9f0 fs/file_table.c:448
 task_work_run+0x24f/0x310 kernel/task_work.c:227
 ptrace_notify+0x2d2/0x380 kernel/signal.c:2522
 ptrace_report_syscall include/linux/ptrace.h:415 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:477 [inline]
 syscall_exit_work+0xc7/0x1d0 kernel/entry/common.c:173
 syscall_exit_to_user_mode_prepare kernel/entry/common.c:200 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:205 [inline]
 syscall_exit_to_user_mode+0x24a/0x340 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7aceeaf449
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 41 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7ace668218 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: fffffffffffffffc RBX: 00007f7acef39328 RCX: 00007f7aceeaf449
RDX: 000000000000000e RSI: 0000000020000100 RDI: 0000000000000004
RBP: 00007f7acef39320 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
R13: 0000000000000004 R14: 00007f7ace668670 R15: 000000000000000b
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_del_entry_valid_or_report+0x12c/0x190 lib/list_debug.c:59
Code: 8c 4c 89 fe 48 89 da e8 32 8c 37 fc 90 0f 0b 48 89 df e8 27 9f 14 fd 48 c7 c7 a0 c0 60 8c 4c 89 fe 48 89 da e8 15 8c 37 fc 90 <0f> 0b 4c 89 e7 e8 0a 9f 14 fd 42 80 3c 2b 00 74 08 4c 89 e7 e8 cb
RSP: 0018:ffffc90003f6f998 EFLAGS: 00010246
RAX: 000000000000004e RBX: dead000000000122 RCX: 01454d423f7fbf00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: dffffc0000000000 R08: ffffffff819f077c R09: 1ffff920007eded0
R10: dffffc0000000000 R11: fffff520007eded1 R12: dead000000000122
R13: dffffc0000000000 R14: ffff8880352248d8 R15: ffff888021297e00
FS:  00007f7ace6686c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7acef05b08 CR3: 000000003527c000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

Reported-by: syzbot+10bd8fe6741eedd2be2e@syzkaller.appspotmail.com
Fixes: 6ab54a717189 ("Bluetooth: L2CAP: Fix slab-use-after-free Read in l2cap_send_cmd")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/l2cap.h |   2 +-
 net/bluetooth/l2cap_core.c    | 123 +++++++++++-----------------------
 net/bluetooth/l2cap_sock.c    |   4 +-
 3 files changed, 41 insertions(+), 88 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index d9c767cf773d..6b90cfa15d88 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -668,7 +668,7 @@ struct l2cap_conn {
 	struct l2cap_chan	*smp;
 
 	struct list_head	chan_l;
-	struct mutex		chan_lock;
+	struct mutex		lock;
 	struct kref		ref;
 	struct list_head	users;
 };
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index adb8c33ac595..5eedd6611f6c 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -119,7 +119,6 @@ static struct l2cap_chan *l2cap_get_chan_by_scid(struct l2cap_conn *conn,
 {
 	struct l2cap_chan *c;
 
-	mutex_lock(&conn->chan_lock);
 	c = __l2cap_get_chan_by_scid(conn, cid);
 	if (c) {
 		/* Only lock if chan reference is not 0 */
@@ -127,7 +126,6 @@ static struct l2cap_chan *l2cap_get_chan_by_scid(struct l2cap_conn *conn,
 		if (c)
 			l2cap_chan_lock(c);
 	}
-	mutex_unlock(&conn->chan_lock);
 
 	return c;
 }
@@ -140,7 +138,6 @@ static struct l2cap_chan *l2cap_get_chan_by_dcid(struct l2cap_conn *conn,
 {
 	struct l2cap_chan *c;
 
-	mutex_lock(&conn->chan_lock);
 	c = __l2cap_get_chan_by_dcid(conn, cid);
 	if (c) {
 		/* Only lock if chan reference is not 0 */
@@ -148,7 +145,6 @@ static struct l2cap_chan *l2cap_get_chan_by_dcid(struct l2cap_conn *conn,
 		if (c)
 			l2cap_chan_lock(c);
 	}
-	mutex_unlock(&conn->chan_lock);
 
 	return c;
 }
@@ -418,7 +414,7 @@ static void l2cap_chan_timeout(struct work_struct *work)
 	if (!conn)
 		return;
 
-	mutex_lock(&conn->chan_lock);
+	mutex_lock(&conn->lock);
 	/* __set_chan_timer() calls l2cap_chan_hold(chan) while scheduling
 	 * this work. No need to call l2cap_chan_hold(chan) here again.
 	 */
@@ -439,7 +435,7 @@ static void l2cap_chan_timeout(struct work_struct *work)
 	l2cap_chan_unlock(chan);
 	l2cap_chan_put(chan);
 
-	mutex_unlock(&conn->chan_lock);
+	mutex_unlock(&conn->lock);
 }
 
 struct l2cap_chan *l2cap_chan_create(void)
@@ -641,9 +637,9 @@ void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 
 void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 {
-	mutex_lock(&conn->chan_lock);
+	mutex_lock(&conn->lock);
 	__l2cap_chan_add(conn, chan);
-	mutex_unlock(&conn->chan_lock);
+	mutex_unlock(&conn->lock);
 }
 
 void l2cap_chan_del(struct l2cap_chan *chan, int err)
@@ -731,9 +727,9 @@ void l2cap_chan_list(struct l2cap_conn *conn, l2cap_chan_func_t func,
 	if (!conn)
 		return;
 
-	mutex_lock(&conn->chan_lock);
+	mutex_lock(&conn->lock);
 	__l2cap_chan_list(conn, func, data);
-	mutex_unlock(&conn->chan_lock);
+	mutex_unlock(&conn->lock);
 }
 
 EXPORT_SYMBOL_GPL(l2cap_chan_list);
@@ -745,7 +741,7 @@ static void l2cap_conn_update_id_addr(struct work_struct *work)
 	struct hci_conn *hcon = conn->hcon;
 	struct l2cap_chan *chan;
 
-	mutex_lock(&conn->chan_lock);
+	mutex_lock(&conn->lock);
 
 	list_for_each_entry(chan, &conn->chan_l, list) {
 		l2cap_chan_lock(chan);
@@ -754,7 +750,7 @@ static void l2cap_conn_update_id_addr(struct work_struct *work)
 		l2cap_chan_unlock(chan);
 	}
 
-	mutex_unlock(&conn->chan_lock);
+	mutex_unlock(&conn->lock);
 }
 
 static void l2cap_chan_le_connect_reject(struct l2cap_chan *chan)
@@ -1507,8 +1503,6 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 
 	BT_DBG("conn %p", conn);
 
-	mutex_lock(&conn->chan_lock);
-
 	list_for_each_entry_safe(chan, tmp, &conn->chan_l, list) {
 		l2cap_chan_lock(chan);
 
@@ -1577,8 +1571,6 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 
 		l2cap_chan_unlock(chan);
 	}
-
-	mutex_unlock(&conn->chan_lock);
 }
 
 static void l2cap_le_conn_ready(struct l2cap_conn *conn)
@@ -1624,7 +1616,7 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
 	if (hcon->type == ACL_LINK)
 		l2cap_request_info(conn);
 
-	mutex_lock(&conn->chan_lock);
+	mutex_lock(&conn->lock);
 
 	list_for_each_entry(chan, &conn->chan_l, list) {
 
@@ -1642,7 +1634,7 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
 		l2cap_chan_unlock(chan);
 	}
 
-	mutex_unlock(&conn->chan_lock);
+	mutex_unlock(&conn->lock);
 
 	if (hcon->type == LE_LINK)
 		l2cap_le_conn_ready(conn);
@@ -1657,14 +1649,10 @@ static void l2cap_conn_unreliable(struct l2cap_conn *conn, int err)
 
 	BT_DBG("conn %p", conn);
 
-	mutex_lock(&conn->chan_lock);
-
 	list_for_each_entry(chan, &conn->chan_l, list) {
 		if (test_bit(FLAG_FORCE_RELIABLE, &chan->flags))
 			l2cap_chan_set_err(chan, err);
 	}
-
-	mutex_unlock(&conn->chan_lock);
 }
 
 static void l2cap_info_timeout(struct work_struct *work)
@@ -1675,7 +1663,9 @@ static void l2cap_info_timeout(struct work_struct *work)
 	conn->info_state |= L2CAP_INFO_FEAT_MASK_REQ_DONE;
 	conn->info_ident = 0;
 
+	mutex_lock(&conn->lock);
 	l2cap_conn_start(conn);
+	mutex_unlock(&conn->lock);
 }
 
 /*
@@ -1767,6 +1757,8 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 
 	BT_DBG("hcon %p conn %p, err %d", hcon, conn, err);
 
+	mutex_lock(&conn->lock);
+
 	kfree_skb(conn->rx_skb);
 
 	skb_queue_purge(&conn->pending_rx);
@@ -1785,8 +1777,6 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 	/* Force the connection to be immediately dropped */
 	hcon->disc_timeout = 0;
 
-	mutex_lock(&conn->chan_lock);
-
 	/* Kill channels */
 	list_for_each_entry_safe(chan, l, &conn->chan_l, list) {
 		l2cap_chan_hold(chan);
@@ -1800,12 +1790,11 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 		l2cap_chan_put(chan);
 	}
 
-	mutex_unlock(&conn->chan_lock);
-
 	if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_SENT)
 		cancel_delayed_work_sync(&conn->info_timer);
 
 	hcon->l2cap_data = NULL;
+	mutex_unlock(&conn->lock);
 	l2cap_conn_put(conn);
 }
 
@@ -2924,8 +2913,6 @@ static void l2cap_raw_recv(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	BT_DBG("conn %p", conn);
 
-	mutex_lock(&conn->chan_lock);
-
 	list_for_each_entry(chan, &conn->chan_l, list) {
 		if (chan->chan_type != L2CAP_CHAN_RAW)
 			continue;
@@ -2940,8 +2927,6 @@ static void l2cap_raw_recv(struct l2cap_conn *conn, struct sk_buff *skb)
 		if (chan->ops->recv(chan, nskb))
 			kfree_skb(nskb);
 	}
-
-	mutex_unlock(&conn->chan_lock);
 }
 
 /* ---- L2CAP signalling commands ---- */
@@ -3960,7 +3945,6 @@ static void l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
 		goto response;
 	}
 
-	mutex_lock(&conn->chan_lock);
 	l2cap_chan_lock(pchan);
 
 	/* Check if the ACL is secure enough (if not SDP) */
@@ -4067,7 +4051,6 @@ static void l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
 	}
 
 	l2cap_chan_unlock(pchan);
-	mutex_unlock(&conn->chan_lock);
 	l2cap_chan_put(pchan);
 }
 
@@ -4106,27 +4089,19 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 	BT_DBG("dcid 0x%4.4x scid 0x%4.4x result 0x%2.2x status 0x%2.2x",
 	       dcid, scid, result, status);
 
-	mutex_lock(&conn->chan_lock);
-
 	if (scid) {
 		chan = __l2cap_get_chan_by_scid(conn, scid);
-		if (!chan) {
-			err = -EBADSLT;
-			goto unlock;
-		}
+		if (!chan)
+			return -EBADSLT;
 	} else {
 		chan = __l2cap_get_chan_by_ident(conn, cmd->ident);
-		if (!chan) {
-			err = -EBADSLT;
-			goto unlock;
-		}
+		if (!chan)
+			return -EBADSLT;
 	}
 
 	chan = l2cap_chan_hold_unless_zero(chan);
-	if (!chan) {
-		err = -EBADSLT;
-		goto unlock;
-	}
+	if (!chan)
+		return -EBADSLT;
 
 	err = 0;
 
@@ -4164,9 +4139,6 @@ static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
 	l2cap_chan_unlock(chan);
 	l2cap_chan_put(chan);
 
-unlock:
-	mutex_unlock(&conn->chan_lock);
-
 	return err;
 }
 
@@ -4454,11 +4426,7 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn,
 
 	chan->ops->set_shutdown(chan);
 
-	l2cap_chan_unlock(chan);
-	mutex_lock(&conn->chan_lock);
-	l2cap_chan_lock(chan);
 	l2cap_chan_del(chan, ECONNRESET);
-	mutex_unlock(&conn->chan_lock);
 
 	chan->ops->close(chan);
 
@@ -4495,11 +4463,7 @@ static inline int l2cap_disconnect_rsp(struct l2cap_conn *conn,
 		return 0;
 	}
 
-	l2cap_chan_unlock(chan);
-	mutex_lock(&conn->chan_lock);
-	l2cap_chan_lock(chan);
 	l2cap_chan_del(chan, 0);
-	mutex_unlock(&conn->chan_lock);
 
 	chan->ops->close(chan);
 
@@ -4697,13 +4661,9 @@ static int l2cap_le_connect_rsp(struct l2cap_conn *conn,
 	BT_DBG("dcid 0x%4.4x mtu %u mps %u credits %u result 0x%2.2x",
 	       dcid, mtu, mps, credits, result);
 
-	mutex_lock(&conn->chan_lock);
-
 	chan = __l2cap_get_chan_by_ident(conn, cmd->ident);
-	if (!chan) {
-		err = -EBADSLT;
-		goto unlock;
-	}
+	if (!chan)
+		return -EBADSLT;
 
 	err = 0;
 
@@ -4751,9 +4711,6 @@ static int l2cap_le_connect_rsp(struct l2cap_conn *conn,
 
 	l2cap_chan_unlock(chan);
 
-unlock:
-	mutex_unlock(&conn->chan_lock);
-
 	return err;
 }
 
@@ -4865,7 +4822,6 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 		goto response;
 	}
 
-	mutex_lock(&conn->chan_lock);
 	l2cap_chan_lock(pchan);
 
 	if (!smp_sufficient_security(conn->hcon, pchan->sec_level,
@@ -4931,7 +4887,6 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 
 response_unlock:
 	l2cap_chan_unlock(pchan);
-	mutex_unlock(&conn->chan_lock);
 	l2cap_chan_put(pchan);
 
 	if (result == L2CAP_CR_PEND)
@@ -5065,7 +5020,6 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 		goto response;
 	}
 
-	mutex_lock(&conn->chan_lock);
 	l2cap_chan_lock(pchan);
 
 	if (!smp_sufficient_security(conn->hcon, pchan->sec_level,
@@ -5140,7 +5094,6 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 
 unlock:
 	l2cap_chan_unlock(pchan);
-	mutex_unlock(&conn->chan_lock);
 	l2cap_chan_put(pchan);
 
 response:
@@ -5177,8 +5130,6 @@ static inline int l2cap_ecred_conn_rsp(struct l2cap_conn *conn,
 	BT_DBG("mtu %u mps %u credits %u result 0x%4.4x", mtu, mps, credits,
 	       result);
 
-	mutex_lock(&conn->chan_lock);
-
 	cmd_len -= sizeof(*rsp);
 
 	list_for_each_entry_safe(chan, tmp, &conn->chan_l, list) {
@@ -5264,8 +5215,6 @@ static inline int l2cap_ecred_conn_rsp(struct l2cap_conn *conn,
 		l2cap_chan_unlock(chan);
 	}
 
-	mutex_unlock(&conn->chan_lock);
-
 	return err;
 }
 
@@ -5378,8 +5327,6 @@ static inline int l2cap_le_command_rej(struct l2cap_conn *conn,
 	if (cmd_len < sizeof(*rej))
 		return -EPROTO;
 
-	mutex_lock(&conn->chan_lock);
-
 	chan = __l2cap_get_chan_by_ident(conn, cmd->ident);
 	if (!chan)
 		goto done;
@@ -5394,7 +5341,6 @@ static inline int l2cap_le_command_rej(struct l2cap_conn *conn,
 	l2cap_chan_put(chan);
 
 done:
-	mutex_unlock(&conn->chan_lock);
 	return 0;
 }
 
@@ -6849,8 +6795,12 @@ static void process_pending_rx(struct work_struct *work)
 
 	BT_DBG("");
 
+	mutex_lock(&conn->lock);
+
 	while ((skb = skb_dequeue(&conn->pending_rx)))
 		l2cap_recv_frame(conn, skb);
+
+	mutex_unlock(&conn->lock);
 }
 
 static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon)
@@ -6889,7 +6839,7 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon)
 		conn->local_fixed_chan |= L2CAP_FC_SMP_BREDR;
 
 	mutex_init(&conn->ident_lock);
-	mutex_init(&conn->chan_lock);
+	mutex_init(&conn->lock);
 
 	INIT_LIST_HEAD(&conn->chan_l);
 	INIT_LIST_HEAD(&conn->users);
@@ -7080,7 +7030,7 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 		}
 	}
 
-	mutex_lock(&conn->chan_lock);
+	mutex_lock(&conn->lock);
 	l2cap_chan_lock(chan);
 
 	if (cid && __l2cap_get_chan_by_dcid(conn, cid)) {
@@ -7121,7 +7071,7 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 
 chan_unlock:
 	l2cap_chan_unlock(chan);
-	mutex_unlock(&conn->chan_lock);
+	mutex_unlock(&conn->lock);
 done:
 	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
@@ -7333,7 +7283,7 @@ static void l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 
 	BT_DBG("conn %p status 0x%2.2x encrypt %u", conn, status, encrypt);
 
-	mutex_lock(&conn->chan_lock);
+	mutex_lock(&conn->lock);
 
 	list_for_each_entry(chan, &conn->chan_l, list) {
 		l2cap_chan_lock(chan);
@@ -7407,7 +7357,7 @@ static void l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 		l2cap_chan_unlock(chan);
 	}
 
-	mutex_unlock(&conn->chan_lock);
+	mutex_unlock(&conn->lock);
 }
 
 /* Append fragment into frame respecting the maximum len of rx_skb */
@@ -7506,6 +7456,8 @@ void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 
 	BT_DBG("conn %p len %u flags 0x%x", conn, skb->len, flags);
 
+	mutex_lock(&conn->lock);
+
 	switch (flags) {
 	case ACL_START:
 	case ACL_START_NO_FLUSH:
@@ -7530,7 +7482,7 @@ void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 		if (len == skb->len) {
 			/* Complete frame received */
 			l2cap_recv_frame(conn, skb);
-			return;
+			goto unlock;
 		}
 
 		BT_DBG("Start: total len %d, frag len %u", len, skb->len);
@@ -7592,10 +7544,11 @@ void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 		break;
 	}
 
-	l2cap_conn_put(conn);
-
 drop:
 	kfree_skb(skb);
+unlock:
+	mutex_unlock(&conn->lock);
+	l2cap_conn_put(conn);
 }
 
 static struct hci_cb l2cap_cb = {
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 46ea0bee2259..831ab9b97001 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1366,14 +1366,14 @@ static int l2cap_sock_shutdown(struct socket *sock, int how)
 
 	if (conn)
 		/* mutex lock must be taken before l2cap_chan_lock() */
-		mutex_lock(&conn->chan_lock);
+		mutex_lock(&conn->lock);
 
 	l2cap_chan_lock(chan);
 	l2cap_chan_close(chan, 0);
 	l2cap_chan_unlock(chan);
 
 	if (conn) {
-		mutex_unlock(&conn->chan_lock);
+		mutex_unlock(&conn->lock);
 		l2cap_conn_put(conn);
 	}
 
-- 
2.48.1

