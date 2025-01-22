Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FA1AD4B
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jan 2025 19:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737573623; cv=none; b=EgmeUaIj2mjvquAbPOa0CMLZIV/e5ueQP2m2ljOUcTYkQuPohHJZPbCFnMShxdorlUeW98uNXV+6oDckf/FZOe4VjbYj1tGT2CVzq1a2yUM0NB0GntD8ZC3q6NrLtEI9A1jEOnydh0rAVWkTidUOOVFMTn+B3zyfvMrnXEY4uBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737573623; c=relaxed/simple;
	bh=lt+Qi5Fc2MmX6qxby75ik3MK/ZxE+2bbEm0Woeg0yzU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=e72FFhke6CNNdI//ZuT91rGjNLTi2utOaSF0QWKzUzG6XYqcBTah+utMj/SrD5U+m95zRPGdMGeFpoIwS1Bpa5LNBPLukK3A42Z1Guw0FfE/++msiKwNZRQNgGueZALTVMaxWCBARqZ9R1IE8G+T7ExMeXMZ3G4uBqamxBLeZ/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DBcCAi74; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBcCAi74"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-4affbb7ef2dso59901137.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jan 2025 11:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737573620; x=1738178420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pp6SuguMsty8Xk4w15+kmMawZSjdP8kFLKx66LfXb78=;
        b=DBcCAi740tQCB3vluwJ1Yu7hk/r6IK1C59h0Si7J00mQ9KqGnOBVSoEcBuV3RkU4m/
         mVRnJIjT1Agso8X0wUkFSYl/ntZOCymcHWEF8ek+3ZGIKQqbO8WIqW9C0bs2WFlD/6Ua
         0uikAM16t4quTMZQAaKwP2f6pz9ds4PM4C1lb4WzbBz56w8CjSKdMpA0/zIzSkBZY4oP
         V4x6wRu1+gWR6VYUyI94RWW1ab4N24DNbWJL1gONelUG4ZsNNnvJkQb40KaRMoAuSR17
         9ZpeoxWC4aX4zdCe5FXIZdfwbNMBjBoGj3YaMOsRmnCl4viOcNzKFAhRDUYfqRf0NJEq
         O6sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737573620; x=1738178420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pp6SuguMsty8Xk4w15+kmMawZSjdP8kFLKx66LfXb78=;
        b=QPPGBvT22ENxtavk0cyvw6IJk7U0yW2C8N8Cab1AU66rnXn3iZxjHDoclP/+DhPMKa
         Drh4v6NZ2ibRQ36+s9t+cKh2dB6/zB9MK8ZL1H8zsB/cWRlxENhmi2E+eZmGXAK+H8GK
         uZCKDm65A67UgXH2FwTZu1RBi/mTxa1z+OkBH/7wxoHs6xn7KAf7iC1vDcitatOKydKI
         5JkPpqVomnqyhIsbF0LEJVyEU+ZsKBNEK1NjiYlALGu757duC3VBDcSC5DS5pdWGu3Aq
         uSL05GzuP0Ax9qIhnwEpfdnwSoxsWVX+ME0mpwmCqDPzmQpoQr+Wcw3EGc/BJtv0ry/i
         6Beg==
X-Gm-Message-State: AOJu0YySpZO54BMzAzFXMjPvB4cPvg6M9ApB+1sqhr6Eh94k/7gV9FN4
	/A+lQ1//p0nC5N+d/yA29iqnhjmL+mBdYvm1rX3A3oI0KvYCgLsr86TPuS8q
X-Gm-Gg: ASbGncsBmUlhNOCmIq9rSmp/U05LwAynIPGD/TdBlDyFEjPF0TD+4lfxHGdY8T29guu
	sreWJSepR8M4b4rDLySKS+400s/waLjNkC3V6tZDbcthf2Q8ZZtFNwEn8S0K0yJey3kwWRLKtTP
	sX3wfjO9bnBBJQeX1TJZ15aYofDhiFOkwAqv5Zg+JCuZ4ICaQOPNrZycSnB+VUS4dCWjH7B+o7E
	ZyC2yHRd0EJBv7aNjmmZzBjr1fhIucr7BpBccJ5ws8ssur0oTih/m9UViMUCK/OUElc1vswxHiy
	NiClcCQJ+6twLnmaRsek87Pig+tzLCdAE2Ggdbojiw==
X-Google-Smtp-Source: AGHT+IHWUxQuRORV72g9sy7o7KZFm6sUikbvf/7kqNFprME5okEvGqcTocnxFXYSqSCYbnZlNv5C4w==
X-Received: by 2002:a05:6102:32c2:b0:4b2:5d16:2902 with SMTP id ada2fe7eead31-4b690bb51c8mr18487154137.6.1737573620232;
        Wed, 22 Jan 2025 11:20:20 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8642caca4e1sm3033521241.12.2025.01.22.11.20.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 11:20:18 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5] Bluetooth: L2CAP: Fix slab-use-after-free Read in l2cap_send_cmd
Date: Wed, 22 Jan 2025 14:20:16 -0500
Message-ID: <20250122192016.86251-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

After the hci sync command releases l2cap_conn, the hci receive data work
queue references the released l2cap_conn when sending to the upper layer.
Add hci dev lock to the hci receive data work queue to synchronize the two.

[1]
BUG: KASAN: slab-use-after-free in l2cap_send_cmd+0x187/0x8d0 net/bluetooth/l2cap_core.c:954
Read of size 8 at addr ffff8880271a4000 by task kworker/u9:2/5837

CPU: 0 UID: 0 PID: 5837 Comm: kworker/u9:2 Not tainted 6.13.0-rc5-syzkaller-00163-gab75170520d4 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: hci1 hci_rx_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:489
 kasan_report+0x143/0x180 mm/kasan/report.c:602
 l2cap_build_cmd net/bluetooth/l2cap_core.c:2964 [inline]
 l2cap_send_cmd+0x187/0x8d0 net/bluetooth/l2cap_core.c:954
 l2cap_sig_send_rej net/bluetooth/l2cap_core.c:5502 [inline]
 l2cap_sig_channel net/bluetooth/l2cap_core.c:5538 [inline]
 l2cap_recv_frame+0x221f/0x10db0 net/bluetooth/l2cap_core.c:6817
 hci_acldata_packet net/bluetooth/hci_core.c:3797 [inline]
 hci_rx_work+0x508/0xdb0 net/bluetooth/hci_core.c:4040
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 5837:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __kmalloc_cache_noprof+0x243/0x390 mm/slub.c:4329
 kmalloc_noprof include/linux/slab.h:901 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 l2cap_conn_add+0xa9/0x8e0 net/bluetooth/l2cap_core.c:6860
 l2cap_connect_cfm+0x115/0x1090 net/bluetooth/l2cap_core.c:7239
 hci_connect_cfm include/net/bluetooth/hci_core.h:2057 [inline]
 hci_remote_features_evt+0x68e/0xac0 net/bluetooth/hci_event.c:3726
 hci_event_func net/bluetooth/hci_event.c:7473 [inline]
 hci_event_packet+0xac2/0x1540 net/bluetooth/hci_event.c:7525
 hci_rx_work+0x3f3/0xdb0 net/bluetooth/hci_core.c:4035
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Freed by task 54:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:582
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2353 [inline]
 slab_free mm/slub.c:4613 [inline]
 kfree+0x196/0x430 mm/slub.c:4761
 l2cap_connect_cfm+0xcc/0x1090 net/bluetooth/l2cap_core.c:7235
 hci_connect_cfm include/net/bluetooth/hci_core.h:2057 [inline]
 hci_conn_failed+0x287/0x400 net/bluetooth/hci_conn.c:1266
 hci_abort_conn_sync+0x56c/0x11f0 net/bluetooth/hci_sync.c:5603
 hci_cmd_sync_work+0x22b/0x400 net/bluetooth/hci_sync.c:332
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Reported-by: syzbot+31c2f641b850a348a734@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=31c2f641b850a348a734
Tested-by: syzbot+31c2f641b850a348a734@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_core.c | 41 ++++++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 27b4c4a2ba1f..bad2aca96fb6 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -948,6 +948,16 @@ static u8 l2cap_get_ident(struct l2cap_conn *conn)
 	return id;
 }
 
+static void l2cap_send_acl(struct l2cap_conn *conn, struct sk_buff *skb,
+			   u8 flags)
+{
+	/* Check if the hcon still valid before attempting to send */
+	if (hci_conn_valid(conn->hcon->hdev, conn->hcon))
+		hci_send_acl(conn->hchan, skb, flags);
+	else
+		kfree_skb(skb);
+}
+
 static void l2cap_send_cmd(struct l2cap_conn *conn, u8 ident, u8 code, u16 len,
 			   void *data)
 {
@@ -970,7 +980,7 @@ static void l2cap_send_cmd(struct l2cap_conn *conn, u8 ident, u8 code, u16 len,
 	bt_cb(skb)->force_active = BT_POWER_FORCE_ACTIVE_ON;
 	skb->priority = HCI_PRIO_MAX;
 
-	hci_send_acl(conn->hchan, skb, flags);
+	l2cap_send_acl(conn, skb, flags);
 }
 
 static void l2cap_do_send(struct l2cap_chan *chan, struct sk_buff *skb)
@@ -993,7 +1003,7 @@ static void l2cap_do_send(struct l2cap_chan *chan, struct sk_buff *skb)
 		flags = ACL_START;
 
 	bt_cb(skb)->force_active = test_bit(FLAG_FORCE_ACTIVE, &chan->flags);
-	hci_send_acl(chan->conn->hchan, skb, flags);
+	l2cap_send_acl(chan->conn, skb, flags);
 }
 
 static void __unpack_enhanced_control(u16 enh, struct l2cap_ctrl *control)
@@ -1792,13 +1802,10 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 
 	mutex_unlock(&conn->chan_lock);
 
-	hci_chan_del(conn->hchan);
-
 	if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_SENT)
 		cancel_delayed_work_sync(&conn->info_timer);
 
 	hcon->l2cap_data = NULL;
-	conn->hchan = NULL;
 	l2cap_conn_put(conn);
 }
 
@@ -1806,6 +1813,7 @@ static void l2cap_conn_free(struct kref *ref)
 {
 	struct l2cap_conn *conn = container_of(ref, struct l2cap_conn, ref);
 
+	hci_chan_del(conn->hchan);
 	hci_conn_put(conn->hcon);
 	kfree(conn);
 }
@@ -7466,14 +7474,33 @@ static void l2cap_recv_reset(struct l2cap_conn *conn)
 	conn->rx_len = 0;
 }
 
+static struct l2cap_conn *l2cap_conn_hold_unless_zero(struct l2cap_conn *c)
+{
+	BT_DBG("conn %p orig refcnt %u", c, kref_read(&c->ref));
+
+	if (!kref_get_unless_zero(&c->ref))
+		return NULL;
+
+	return c;
+}
+
 void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 {
-	struct l2cap_conn *conn = hcon->l2cap_data;
+	struct l2cap_conn *conn;
 	int len;
 
+	/* Lock hdev to access l2cap_data to avoid race with l2cap_conn_del */
+	hci_dev_lock(hcon->hdev);
+
+	conn = hcon->l2cap_data;
+
 	if (!conn)
 		conn = l2cap_conn_add(hcon);
 
+	conn = l2cap_conn_hold_unless_zero(conn);
+
+	hci_dev_unlock(hcon->hdev);
+
 	if (!conn)
 		goto drop;
 
@@ -7565,6 +7592,8 @@ void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 		break;
 	}
 
+	l2cap_conn_put(conn);
+
 drop:
 	kfree_skb(skb);
 }
-- 
2.47.1

