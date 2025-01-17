Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FE21ACECD
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jan 2025 18:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737139331; cv=none; b=r2NH+mfVES6bvQxUFjpXoN1+oG/AjweQnahJHBriuSUo3sLJhzo7ESn8vtwoThxNP3gJAK/zKA1Eex0FnHG6V9QCC8saH39vCsXqpDHhlPUdAY9+8wuvAhKoSgLpxbOXPinEGQBlOAYhZdXNOTXr1XerRT0YersA9CQjtDEtXVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737139331; c=relaxed/simple;
	bh=4pspWkv/HBiayRH0cE4C7ypXWqic3OGRe7DlIFuZkdI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=I0T5N7tkKJNs2zIbKQAxDDZpXcbD1zBOvb7LAfEGMRLi+hYUc1BnfCIT9te8cah8Tva7XXgi+MjbyE6waU+SMLP8vzYJATJ0Dq5yzSr2ix/rzhb6GQAaNGwDWb/8U+sK+FwClQM/btzWwYBlDAmCDOUaLY3zUx+l3RVOsg9JZNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LL8H3Cnr; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LL8H3Cnr"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4afefc876c6so651147137.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jan 2025 10:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737139325; x=1737744125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0umhs9EU7ywfeaCCWU2pxl+l1Vf86Hj5Rh4Caplwt44=;
        b=LL8H3CnrPXoQhQLlTS65pE4UZT944U1buW59AHenNISriLJit0hAKnKRAXc3ARiRMi
         qBFf1JKq9kPJ050yl2hC32a6lQGUrPY7LfEAq85A4gJ2ufbu7Oj6OawULDsfFwWHIogj
         3vtnEsyeKYVHSmpHLt0SXUzXj5K2tQ8c0nYXd1qq2LgV2YqsfUjKTbANorjgyK0CFjqP
         sp55+frCi6Rd/3c8l7/vv0JTsgsbLdonBdqYglOmPmsmIW0Ezttn0oxqtqEFwp2M0TYf
         LW9PrbAniiKAhiszb580p545nkQ5olkoZm8IDyNwL+p8K+A1t3Heu60wqWPZ6Wfuff7w
         dHOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737139325; x=1737744125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0umhs9EU7ywfeaCCWU2pxl+l1Vf86Hj5Rh4Caplwt44=;
        b=l/MmpZh9VhU4Py49ty8CLZvlcM+1Nm2W+GlHdKRgxmG2U4KSTr07piReb65LloyCbP
         HDrvWjhLxxkM1qiyf1MHTLr5RPvqIrCqX8FWX9Ua7Rl9ZgUrRDR4alG+/JYQnBb9jEbj
         hwd95mGsTrQT9Ryvoj4R3fLj1z1eIqDASNrJsr1oNc40LgRJV8Td6/rHQm322fJcDMK9
         KgNsux6gCaBTJ4KrTS2zQfwtkCl2GEgv7xnB96+W0G0Jo7e5DYh82sGG43mRuSRDG4MK
         TQZd12JE3jxdKHN8N8uAk3AL9CKQ+8bmM5zqSY4Ua6Ge4cVlZDhdbTmuFjoyTNLrfbgV
         1qaA==
X-Gm-Message-State: AOJu0YyCVjCQAnI0DNJVPmcX8wSW022BEp40cLlnjI8q6Ta2lKk2hGwj
	tcbGXPXJhaIP04J0/sDbvlDaNemtvO6MuuCV8cZFr+m4Vv2JJw47IgPOPikJ
X-Gm-Gg: ASbGnctcbjE74qSu8NoSc62lvU6uXMYskm0hy6K1tcYrLnf7gduLH7din608R6PE6df
	nsfOPP2vItTqU7Nw5Jll1nRW/A+QQv2pcPSB9VLbPyiWcnMHSLhcYLKTIjM/VQRktaD0hZKWxly
	lW0cmIlaNkhXcGZT4h7RhlvJcQot0whbJ+Ev803aNlOFK+KM50Hg9FxmjsYhIa3E52QgG0Lj3Kh
	mlBzzfAPWeDdqfsXmFZSNMn9bQcMvvOBOpswiOGIfElAjE0qUOtgDzI1AkWgebNzdtkLNLYYeLg
	aOlnP/wInYlCIYIi7s7/G3CSk5ap
X-Google-Smtp-Source: AGHT+IEBsMRwO6dIiueQBFr5i3iDZjjvJmU4kH45sba12q61T53JQR4MJziR+JhgdFDRdJM94s0G/A==
X-Received: by 2002:a05:6102:3fa2:b0:4af:deaf:f891 with SMTP id ada2fe7eead31-4b690b5e789mr4193258137.4.1737139325428;
        Fri, 17 Jan 2025 10:42:05 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b68a33f4dfsm573185137.29.2025.01.17.10.42.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 10:42:03 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4] Bluetooth: L2CAP: Fix slab-use-after-free Read in l2cap_send_cmd
Date: Fri, 17 Jan 2025 13:42:02 -0500
Message-ID: <20250117184202.3895460-1-luiz.dentz@gmail.com>
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
 net/bluetooth/l2cap_core.c | 45 ++++++++++++++++++++++++++++++++++----
 1 file changed, 41 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 27b4c4a2ba1f..cc730135e5d9 100644
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
 
@@ -1751,12 +1758,16 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 {
 	struct l2cap_conn *conn = hcon->l2cap_data;
 	struct l2cap_chan *chan, *l;
+	struct hci_chan *hchan;
 
 	if (!conn)
 		return;
 
 	BT_DBG("hcon %p conn %p, err %d", hcon, conn, err);
 
+	hchan = conn->hchan;
+	conn->hchan = NULL;
+
 	kfree_skb(conn->rx_skb);
 
 	skb_queue_purge(&conn->pending_rx);
@@ -1792,13 +1803,12 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 
 	mutex_unlock(&conn->chan_lock);
 
-	hci_chan_del(conn->hchan);
+	hci_chan_del(hchan);
 
 	if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_SENT)
 		cancel_delayed_work_sync(&conn->info_timer);
 
 	hcon->l2cap_data = NULL;
-	conn->hchan = NULL;
 	l2cap_conn_put(conn);
 }
 
@@ -6785,6 +6795,12 @@ static void l2cap_recv_frame(struct l2cap_conn *conn, struct sk_buff *skb)
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
@@ -7466,14 +7482,33 @@ static void l2cap_recv_reset(struct l2cap_conn *conn)
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
 
@@ -7565,6 +7600,8 @@ void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 		break;
 	}
 
+	l2cap_conn_put(conn);
+
 drop:
 	kfree_skb(skb);
 }
-- 
2.47.1

