Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2682B2500C5
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Dec 2024 21:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733260525; cv=none; b=erQfowFkkAMSSEy9MpT9sXOJI0/oNbJbScsAGXxujnNSCoZ1QGgFdy7BbaFGlnuxekXV5+H36/UvelekUOCShxXkKVGMcPdcaVCR9jlfbamLTe1PqEIbHtAFTQRv1sqZRYIT2CRSFYsiHKnFZ1IhAd0pgeBC7u9i9kfwT6O7QnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733260525; c=relaxed/simple;
	bh=wirhKRjg8dMmEu8Ol4qjDntVbyIzjdLVGLSASg7E6H8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oasaQaQ8uTiGF/wnV+XPxCd/K4z/PAPxnLHa5nwb7Eitcdaw6GcADX0qs7NdOYZHfMZ1Z3M0ShbULpB3+2n46aFNcWUTufBq87C3xXMHULrZXt7YBZhB9yLFhOSrsXrpin6OWNnaruJYXRIvuFr3MCFMxyyrxvtFDV3yzIVRQIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PYTA4JAy; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYTA4JAy"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5f1d1fdb328so2399811eaf.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Dec 2024 13:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733260522; x=1733865322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JRGcBJZhHnXtaPUCl8Vyhm9Q7sBPRJygEzHzF+6Mggc=;
        b=PYTA4JAyvFPuQ7KzZqqktDhObGFenM18+ybOgWQPRC/1HzFyjniFh39U7PKFMnVjn8
         +FWbTYZLQxOkvXDdbZfmXjqhcm9p5TRIYnMIezuECck0qjn8qiZ1fjCOuRThd0h5i0ba
         f2i9nanlNDW57NE6ccbTYlW1vCtetDe7/fek/1tMderA/4QEpOilsT5pg0HefXmSQ+gg
         1+xHvPN7XrRrY8jkVvdNwl5cZhKU6PE3QVY1LppoVUMpG3xTFoMvsZ3z7lAsO29wdwgh
         vgQ9Vss+P4UU5YS6E5SVIzrYcY05docUEXqJThatiw63tuKmvDwIwoJL8+UC0oONdLRv
         wvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733260522; x=1733865322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JRGcBJZhHnXtaPUCl8Vyhm9Q7sBPRJygEzHzF+6Mggc=;
        b=I/U0d4uOIk4JTkhQMj76shE2dhkEh7AWPXPY7RwTN4TjT7/kzry4mzJkD4DzPN9j8c
         W7KKNMd1uO12PMl7glXzptlnZHSLl4ylZrayiHSQXTpLPd3isBGqhPga7uoGqBGevHaS
         CqpDohNEDQ3kYlo4wJM/dbC9k7CquOuwJeLzyc2YOFRU+fGIz4B60GLAXIl+3e5bpRcl
         5u5Ws86FTf8NK5mKbfRJHe6KDR/jZ9w7jG8yE3aTEEdXxqMjUSyQrB59Ei2qupl2Zmwa
         YLokbOvUS7v8EEAF/SXWnw0srT0vfE94Q+7W3wFXLOi5CQVNf0/fubVR3bCrdM5hv/H+
         uXog==
X-Gm-Message-State: AOJu0Yz/Jb5yEf8Aq07Oy8r/6nyOnG27DeVxzFnDMORVFOVyMureRt/J
	vA36M7aYx6WNh9c+ctB/J3w0loVlPosdk0qq6UspAECJTLccXR1R3Jp20w==
X-Gm-Gg: ASbGncsK39nz2bYNy87EBf07dyU4yj0rsU5DX6m5hxK4GPvXpv+BZbENn+hwsRhxWnT
	H0x8MWzBsBPaRQ2Hxo1dmIIs34hGfmreTTGrKnknI0KbdqCTvA/EgtpIBznXeU25ywfJtsf3QAL
	6hOus0GJV3xf/S201+fEe3PNKu33teoNIbuGdJUNevyHoHXrOJTfLe5tkFgwaa0k3moW8B1QxxQ
	LKIqnKdLtd12BNpkZlFx1a0MiFTOwdLv6cmc3Q++/yZGg53kUthronQfqEH/5QGx5TpCetYy44I
	xPPDhVcXZEq0B/gWw63x4g==
X-Google-Smtp-Source: AGHT+IFuzSf7TL7joKQ/xq185lvnS/lYU3QGwyUXOOEsA2nGIU+ZIdY+WRaOlluqyXA1ZUpJT604OA==
X-Received: by 2002:a05:6359:7748:b0:1ca:a1d1:65dd with SMTP id e5c5f4694b2df-1caeabf9143mr319170455d.25.1733260522301;
        Tue, 03 Dec 2024 13:15:22 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-85b82a89d5csm2138819241.8.2024.12.03.13.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 13:15:20 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: syzbot+2fb0835e0c9cefc34614@syzkaller.appspotmail.com,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH v1] Bluetooth: hci_core: Fix sleeping function called from invalid context
Date: Tue,  3 Dec 2024 16:14:35 -0500
Message-ID: <20241203211435.194301-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This reworks hci_cb_list to not use mutex hci_cb_list_lock to avoid bugs
like the bellow:

BUG: sleeping function called from invalid context at kernel/locking/mutex.c:585
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 5070, name: kworker/u9:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
4 locks held by kworker/u9:2/5070:
 #0: ffff888015be3948 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3229 [inline]
 #0: ffff888015be3948 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0x8e0/0x1770 kernel/workqueue.c:3335
 #1: ffffc90003b6fd00 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3230 [inline]
 #1: ffffc90003b6fd00 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0x91b/0x1770 kernel/workqueue.c:3335
 #2: ffff8880665d0078 (&hdev->lock){+.+.}-{3:3}, at: hci_le_create_big_complete_evt+0xcf/0xae0 net/bluetooth/hci_event.c:6914
 #3: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #3: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #3: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: hci_le_create_big_complete_evt+0xdb/0xae0 net/bluetooth/hci_event.c:6915
CPU: 0 PID: 5070 Comm: kworker/u9:2 Not tainted 6.8.0-syzkaller-08073-g480e035fc4c7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 __might_resched+0x5d4/0x780 kernel/sched/core.c:10187
 __mutex_lock_common kernel/locking/mutex.c:585 [inline]
 __mutex_lock+0xc1/0xd70 kernel/locking/mutex.c:752
 hci_connect_cfm include/net/bluetooth/hci_core.h:2004 [inline]
 hci_le_create_big_complete_evt+0x3d9/0xae0 net/bluetooth/hci_event.c:6939
 hci_event_func net/bluetooth/hci_event.c:7514 [inline]
 hci_event_packet+0xa53/0x1540 net/bluetooth/hci_event.c:7569
 hci_rx_work+0x3e8/0xca0 net/bluetooth/hci_core.c:4171
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 </TASK>

Reported-by: syzbot+2fb0835e0c9cefc34614@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2fb0835e0c9cefc34614
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h | 89 ++++++++++++++++++++++----------
 net/bluetooth/hci_core.c         |  9 ++--
 2 files changed, 65 insertions(+), 33 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index ea798f07c5a2..95f11f04e24a 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -804,7 +804,6 @@ struct hci_conn_params {
 extern struct list_head hci_dev_list;
 extern struct list_head hci_cb_list;
 extern rwlock_t hci_dev_list_lock;
-extern struct mutex hci_cb_list_lock;
 
 #define hci_dev_set_flag(hdev, nr)             set_bit((nr), (hdev)->dev_flags)
 #define hci_dev_clear_flag(hdev, nr)           clear_bit((nr), (hdev)->dev_flags)
@@ -2029,12 +2028,18 @@ static inline void hci_connect_cfm(struct hci_conn *conn, __u8 status)
 {
 	struct hci_cb *cb;
 
-	mutex_lock(&hci_cb_list_lock);
-	list_for_each_entry(cb, &hci_cb_list, list) {
-		if (cb->connect_cfm)
-			cb->connect_cfm(conn, status);
+	rcu_read_lock();
+	list_for_each_entry_rcu(cb, &hci_cb_list, list) {
+		if (cb->connect_cfm) {
+			struct hci_cb cpy = *cb;
+
+			/* Callback may block so release RCU read lock */
+			rcu_read_unlock();
+			cpy.connect_cfm(conn, status);
+			rcu_read_lock();
+		}
 	}
-	mutex_unlock(&hci_cb_list_lock);
+	rcu_read_unlock();
 
 	if (conn->connect_cfm_cb)
 		conn->connect_cfm_cb(conn, status);
@@ -2044,12 +2049,18 @@ static inline void hci_disconn_cfm(struct hci_conn *conn, __u8 reason)
 {
 	struct hci_cb *cb;
 
-	mutex_lock(&hci_cb_list_lock);
+	rcu_read_lock();
 	list_for_each_entry(cb, &hci_cb_list, list) {
-		if (cb->disconn_cfm)
-			cb->disconn_cfm(conn, reason);
+		if (cb->disconn_cfm) {
+			struct hci_cb cpy = *cb;
+
+			/* Callback may block so release RCU read lock */
+			rcu_read_unlock();
+			cpy.disconn_cfm(conn, reason);
+			rcu_read_lock();
+		}
 	}
-	mutex_unlock(&hci_cb_list_lock);
+	rcu_read_unlock();
 
 	if (conn->disconn_cfm_cb)
 		conn->disconn_cfm_cb(conn, reason);
@@ -2065,12 +2076,18 @@ static inline void hci_auth_cfm(struct hci_conn *conn, __u8 status)
 
 	encrypt = test_bit(HCI_CONN_ENCRYPT, &conn->flags) ? 0x01 : 0x00;
 
-	mutex_lock(&hci_cb_list_lock);
+	rcu_read_lock();
 	list_for_each_entry(cb, &hci_cb_list, list) {
-		if (cb->security_cfm)
-			cb->security_cfm(conn, status, encrypt);
+		if (cb->security_cfm) {
+			struct hci_cb cpy = *cb;
+
+			/* Callback may block so release RCU read lock */
+			rcu_read_unlock();
+			cpy.security_cfm(conn, status, encrypt);
+			rcu_read_lock();
+		}
 	}
-	mutex_unlock(&hci_cb_list_lock);
+	rcu_read_unlock();
 
 	if (conn->security_cfm_cb)
 		conn->security_cfm_cb(conn, status);
@@ -2105,12 +2122,18 @@ static inline void hci_encrypt_cfm(struct hci_conn *conn, __u8 status)
 			conn->sec_level = conn->pending_sec_level;
 	}
 
-	mutex_lock(&hci_cb_list_lock);
+	rcu_read_lock();
 	list_for_each_entry(cb, &hci_cb_list, list) {
-		if (cb->security_cfm)
-			cb->security_cfm(conn, status, encrypt);
+		if (cb->security_cfm) {
+			struct hci_cb cpy = *cb;
+
+			/* Callback may block so release RCU read lock */
+			rcu_read_unlock();
+			cpy.security_cfm(conn, status, encrypt);
+			rcu_read_lock();
+		}
 	}
-	mutex_unlock(&hci_cb_list_lock);
+	rcu_read_unlock();
 
 	if (conn->security_cfm_cb)
 		conn->security_cfm_cb(conn, status);
@@ -2120,12 +2143,18 @@ static inline void hci_key_change_cfm(struct hci_conn *conn, __u8 status)
 {
 	struct hci_cb *cb;
 
-	mutex_lock(&hci_cb_list_lock);
+	rcu_read_lock();
 	list_for_each_entry(cb, &hci_cb_list, list) {
-		if (cb->key_change_cfm)
-			cb->key_change_cfm(conn, status);
+		if (cb->key_change_cfm) {
+			struct hci_cb cpy = *cb;
+
+			/* Callback may block so release RCU read lock */
+			rcu_read_unlock();
+			cpy.key_change_cfm(conn, status);
+			rcu_read_lock();
+		}
 	}
-	mutex_unlock(&hci_cb_list_lock);
+	rcu_read_unlock();
 }
 
 static inline void hci_role_switch_cfm(struct hci_conn *conn, __u8 status,
@@ -2133,12 +2162,18 @@ static inline void hci_role_switch_cfm(struct hci_conn *conn, __u8 status,
 {
 	struct hci_cb *cb;
 
-	mutex_lock(&hci_cb_list_lock);
-	list_for_each_entry(cb, &hci_cb_list, list) {
-		if (cb->role_switch_cfm)
-			cb->role_switch_cfm(conn, status, role);
+	rcu_read_lock();
+	list_for_each_entry_rcu(cb, &hci_cb_list, list) {
+		if (cb->role_switch_cfm) {
+			struct hci_cb cpy = *cb;
+
+			/* Callback may block so release RCU read lock */
+			rcu_read_unlock();
+			cpy.role_switch_cfm(conn, status, role);
+			rcu_read_lock();
+		}
 	}
-	mutex_unlock(&hci_cb_list_lock);
+	rcu_read_unlock();
 }
 
 static inline bool hci_bdaddr_is_rpa(bdaddr_t *bdaddr, u8 addr_type)
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index f9e19f9cb5a3..25d180d225c1 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2993,9 +2993,7 @@ int hci_register_cb(struct hci_cb *cb)
 {
 	BT_DBG("%p name %s", cb, cb->name);
 
-	mutex_lock(&hci_cb_list_lock);
-	list_add_tail(&cb->list, &hci_cb_list);
-	mutex_unlock(&hci_cb_list_lock);
+	list_add_tail_rcu(&cb->list, &hci_cb_list);
 
 	return 0;
 }
@@ -3005,9 +3003,8 @@ int hci_unregister_cb(struct hci_cb *cb)
 {
 	BT_DBG("%p name %s", cb, cb->name);
 
-	mutex_lock(&hci_cb_list_lock);
-	list_del(&cb->list);
-	mutex_unlock(&hci_cb_list_lock);
+	list_del_rcu(&cb->list);
+	synchronize_rcu();
 
 	return 0;
 }
-- 
2.47.1

