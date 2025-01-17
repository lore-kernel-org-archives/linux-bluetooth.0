Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E6715696E
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jan 2025 15:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737129376; cv=none; b=GKKgeRZG/6Xyh2//7g543utWxdwfLl5zM2aJdWdBOQDg4Ze+qiSraUh7t7++YSwd7uNpSo9UhlOjwwp+va0nDEIa0Ni4vBtgchNMyc3568BFAouOTsBJ+tXYwVI3WPy+f/0+H4alwAhebyf9sQII5HWZ9vuXBok9MNfVaTsmEFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737129376; c=relaxed/simple;
	bh=UyPITAPTB00+eWdwhmArZLdgHab27gpNWhGE2rgjF2M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=WSxFPPfD6Oadj7310zBFVbHvyM5y7g7OeEZcMYXq67Nycddep4RDoBSkBYU9nlYbhg0f83VLTqOqRckeZ3L5ERi4/gLKlYHtXsqJnnwIc5oiOYDd1WXCiKib1cx1vAr6icr15DQ4SqsxuA1Xm5ts9B7G5/985ze2qRUkJPXBNFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EbDV3EkG; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EbDV3EkG"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4afd68271b6so648975137.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jan 2025 07:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737129373; x=1737734173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=O5ym1g5UReRkm0KysOx7jjV/maemI5gK0YjbFWcFo2g=;
        b=EbDV3EkGr2M3l3qMWFp56AR60kjX5tAtcfYH2sEk1KV11jM3pv0rc1mXstDjdBzlfx
         gWQfeKjMUSJKadIWxNNOBfgT5PUG+QOX7OGjrBPMVb9ZgmYLdLCZEw+6S+paHDe7kza6
         jvlrLLyq7pTp9m3j5/M71BBuZfrJ1u9w0WOe8OpRC1AAdJAY2v0MftHUln8SzTDtjJ87
         sp8b8BzKkrUOCuprYBDdrYcENSemCeGIOHAxpk8WBDBW1L654SL6nGNbaNKgH8sXXM+X
         L0HFpOyyNSMoZYVGBUHY+PGD/fXP7Npx29AmM03NfUpllt/9RBieGC43VY9Rca6HLg+z
         Yvqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737129373; x=1737734173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O5ym1g5UReRkm0KysOx7jjV/maemI5gK0YjbFWcFo2g=;
        b=YjshVy1MAd28NF2rN7EkdffLzZlcDJbmt42S1MMwoZopvds4XHZHSvNxWTbpUF1bdz
         gJUCXGbGELtaknZQT8y2l6dWUoEhNpWgfyzyVtgSic3e2dh1UFlvGR9kAn/jdXrf/lX8
         2/T76V0DbEKQ9pmzNHt9dDtdENs131xmkk+5brQeviFj4FE0jdE4lM5mlkx2UBYNB7ha
         kEgYqtfx6yzQgn/9WI5H8BoZws2K4m31hqeemwQkPmuq3o0TmKm7BrbZH1dR3ZOL6QFI
         Zp9F1Hdelnoo3GNo/8Q0+3zYrhw4ft7Fyc2PdIgX88fIFCPDMBN7s2aXLiIinaFpA7lj
         6d7Q==
X-Gm-Message-State: AOJu0Yx+E+jUaNZskFTZcDuv3SrYfbKiOAdTPtlu2Ia2eKLC/mMHONdp
	dUPKjfYWVU8rLAyJkWEGkcGJiS8HzAxHlw1SxFzMIxhrCCpE3gj/NQU9DLIY
X-Gm-Gg: ASbGncugWog0Gn72uxS3ArbpcoQw9kcJ9efsC7TOQYEeJPAdjGamd03JsCV7cjX6H4L
	PlJp2oQpRqXYD1VLa62EtNzOK6IOwYI26JsDQ8vdJbBDNH0uBtYjkglPIPorKV28h9jVvsUpkju
	cc6zfP9S4Go+yCdxCvLVY0BdRmlm/Z9XXVP+SyK2RC11xpnYJ25gl4PGoOUNoLC+JtqjVEjd5nu
	uUz/WrNQeb3Q/P0TK75nbgm1Ix7MjSBCxz+FIYoIjMJfGeSgrpX6r7jOga7jF+ceys3X4MKrHF0
	udpNdhbWbBHRe8Evi7YySKW8Br2r
X-Google-Smtp-Source: AGHT+IHASG3dldCHHtZq0285qtamI2BjNWsp5j+VBxFl8HUVIqPBCcsUn/SGjQt270JoyCXcgBJqYQ==
X-Received: by 2002:a05:6102:2921:b0:4b2:5d63:a0f3 with SMTP id ada2fe7eead31-4b690c22b88mr2835882137.15.1737129372674;
        Fri, 17 Jan 2025 07:56:12 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8642cab2d77sm548366241.4.2025.01.17.07.56.09
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 07:56:10 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: L2CAP: Fix slab-use-after-free Read in l2cap_send_cmd
Date: Fri, 17 Jan 2025 10:56:08 -0500
Message-ID: <20250117155608.3836950-1-luiz.dentz@gmail.com>
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
index 27b4c4a2ba1f..025bb038e304 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -951,11 +951,18 @@ static u8 l2cap_get_ident(struct l2cap_conn *conn)
 static void l2cap_send_cmd(struct l2cap_conn *conn, u8 ident, u8 code, u16 len,
 			   void *data)
 {
-	struct sk_buff *skb = l2cap_build_cmd(conn, code, ident, len, data);
+	struct sk_buff *skb;
 	u8 flags;
 
+	/* Check if HCI_CONN_DROP has been set since it means hci_chan_del has
+	 * been called.
+	 */
+	if (test_bit(HCI_CONN_DROP, &conn->hcon->flags))
+		return;
+
 	BT_DBG("code 0x%2.2x", code);
 
+	skb = l2cap_build_cmd(conn, code, ident, len, data);
 	if (!skb)
 		return;
 
@@ -6785,6 +6792,12 @@ static void l2cap_recv_frame(struct l2cap_conn *conn, struct sk_buff *skb)
 	u16 cid, len;
 	__le16 psm;
 
+	/* Check if hcon has been dropped then drop its packets as well */
+	if (test_bit(HCI_CONN_DROP, &hcon->flags)) {
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

