Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E52513792B
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jan 2025 17:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737134073; cv=none; b=AErssy55tsc5rAhXuBv/bbLNtXoTkXOLZbKIfQaRzplLUh53FcUTsi/yzpLqMMfkKGkz8pBoDhH6rvWSGn7bKscuyE6KHHnz+FVZ4ZKPXB184/wL4hHZeUavta6iwckSOBrOTWxQqbD2SDTtsHqJFXowhWuwrw92sA4o5R/p85Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737134073; c=relaxed/simple;
	bh=Ud6VL847lfrg2qyhF+AbZg4RARE2QkrDF3Ouemb8ifA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=pf4WqabUjRguO08zwzS/NW4dKlkTwSEZYEi2WKzbS0Wlf+mcZz2kTDQrO8kWG7IDhq+iIU7W5ZQtcBuGrkw6N7G6CYrBrjS3jiN0ZdSHQ5FtlzSqeCnRmGIh3RfXx1PlP9NO5tNIDvhRi6IQ4YTCDbyyRuhThZjJyyu3e9t16DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=icgXa/mK; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icgXa/mK"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-46c8474d8f6so20583481cf.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jan 2025 09:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737134069; x=1737738869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=U3fEvWzZNrRs7uIHTTeQE2GB2Hlrpx+o57vnxtcn+OM=;
        b=icgXa/mKdRLRauaU4tjdWLV+spegyMi5EJkOHW657PPlj5wKkWfHieipALAFydTwB6
         YR3xgZzuooCN3lwBqbR+xMJSw9mnCD9RnjvRY/6dfm4JBYzfUG2srhPOb7K+MhWun0hy
         LBfrocjHj08Dk8ilsc53vIyJEMvTUCVgIjwCAe1o6bLeeI6cQ6YI1Za5wmV48NZfpQay
         O74DfTBUTd8Gj/9vBxQwG3RXQC5AAcqJuXUB+6Vs511hwCKZoKvzKDr41LaXxoPFnxWT
         9oO/pICB6+Sjj9zvTKNgtCLN26Uo3j/Bx9OzsPW1fKnonuuMXL9XKNXzZSXw6ZbqSYmV
         5JxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737134069; x=1737738869;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U3fEvWzZNrRs7uIHTTeQE2GB2Hlrpx+o57vnxtcn+OM=;
        b=wVeiA84IQo+cAN9AnMqG96y/BMkRp22LLyOgSpRkA73uXwK1WAveJoz3Bdk4q0Mq57
         dmJ6vLvMJsJ8zEpfR8W6HLTGx/NuEeIMb/CtcKdVOV8QMAO6hw+YRqDYiY2xqnf/6Xy5
         A6HrBw35aCD0HwvCiWQdRU4yd+V5ocbqRynjskl4gewLLRy4xhFUb7205Z7Hda6fRxU0
         SktZDdUiG5H5cSMQCsNsJ4/Pgetum8LZZF3DvAQ4QxJt+bFdYvbXSsziBZZLMJ+9HRdk
         GN8RVekq+lCbTg1WYWSz1ptnzgGPAP3E9YqA0IM6w7UzcLuJnFaDw584WSDdjk4Xh+Sc
         TCIg==
X-Gm-Message-State: AOJu0YzubhPwcG6D9iuZGtsoBZRxbuspgrOinZVi8q6G8E6DuQ/jeWlZ
	jRqkZu7yXt5S7dO2E3/vw2+Tat0E+ISiI79dKPm+Pqjw5MNJqja/iZD7En/q
X-Gm-Gg: ASbGnctsKRWuncrCc5aKW41T+HMH6jqI/rgTmltNcRyrxDXtJ+LwdxAARWP5pCZRUo8
	dbMR5wWCk/tQtHltBFhQCVwpyiNNlQSl4cycry5h89Wfxlb7pWpHcDCm6wydgRNVmIi5d9DPjVw
	VVTLXDCHIN3Ca/brOeKL+hojpgVGy4RtDcAHxi9SUEfcJbKfJ+Hu+d1NfeDK1jesD1f/xw19IyA
	n5yoO3rzD4a3sEhgbQG2enc/q5EAkwrZwYO5K0Dw4FWAGPvRil2fUk4qB7KcH/5yDwOEv1kdgp8
	zM0wtRrltSzR3r2V+dG1kxE4o1/m
X-Google-Smtp-Source: AGHT+IGYBnN1TEv2vsHv78zS5Cv4/ObL86x4K13f60Wdfc5fjFrf1F1KMSh8cLoOVZHqXwo556Gohg==
X-Received: by 2002:a05:622a:1820:b0:467:7ff3:e4bf with SMTP id d75a77b69052e-46e12bb505emr48291751cf.51.1737134069396;
        Fri, 17 Jan 2025 09:14:29 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8642cab2d48sm573071241.1.2025.01.17.09.14.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 09:14:27 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3] Bluetooth: L2CAP: Fix slab-use-after-free Read in l2cap_send_cmd
Date: Fri, 17 Jan 2025 12:14:25 -0500
Message-ID: <20250117171425.3881114-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.1
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
 net/bluetooth/l2cap_core.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 27b4c4a2ba1f..cf3597682011 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -951,11 +951,18 @@ static u8 l2cap_get_ident(struct l2cap_conn *conn)
 static void l2cap_send_cmd(struct l2cap_conn *conn, u8 ident, u8 code, u16 len,
 			   void *data)
 {
-	struct sk_buff *skb = l2cap_build_cmd(conn, code, ident, len, data);
+	struct sk_buff *skb;
 	u8 flags;
 
+	/* Check if hchan has been dropped since it means hci_chan_del has
+	 * been called.
+	 */
+	if (!conn->hchan)
+		return;
+
 	BT_DBG("code 0x%2.2x", code);
 
+	skb = l2cap_build_cmd(conn, code, ident, len, data);
 	if (!skb)
 		return;
 
@@ -6785,6 +6792,12 @@ static void l2cap_recv_frame(struct l2cap_conn *conn, struct sk_buff *skb)
 	u16 cid, len;
 	__le16 psm;
 
+	/* Check if hchan has been dropped then drop any packets as well */
+	if (!conn->hchan) {
+		kfree_skb(skb);
+		return;
+	}
+
 	if (hcon->state != BT_CONNECTED) {
 		BT_DBG("queueing pending rx skb");
 		skb_queue_tail(&conn->pending_rx, skb);
@@ -7466,14 +7479,33 @@ static void l2cap_recv_reset(struct l2cap_conn *conn)
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
 
@@ -7565,6 +7597,8 @@ void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 		break;
 	}
 
+	l2cap_conn_put(conn);
+
 drop:
 	kfree_skb(skb);
 }
-- 
2.47.1

