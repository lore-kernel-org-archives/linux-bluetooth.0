Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C96076EE0
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Mar 2024 18:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710440459; cv=pass; b=d1PjbqgSRYscwd7YnvCKFCLnMd8Bi/+N+ql+gg6GHXLcUtdKiZNisNDsS/r6OxpRJmqzNSiNqJWI0BP+4bSWMlZW2aGxxDcPYwgKcyV9YGH4ZzwC7Rgc6UCCGh9u+15zMdnIgmfywARp54nZgP5DfcUBDvavOL/RnQEqdNPYgYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710440459; c=relaxed/simple;
	bh=ww04nNBXqW9V4Apwb6OUoPfqpICo+wTYPi6uL67UQiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YG/Tgs01+SPexZNWn3njm6JVk8WtcFeEciZOpeEwh9GaojsQdazef5vNnzsyGS/YwBAlwhFo2LnGEt2lmPWl1sdUwR55pYeykAfBV+Xli688eSfxmIEh+0hZBGcv2som/VawDBqFb+bL4KINWnCa/u7WLaaazbfbG9JAEbrE7+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=cj7jBaAv; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="cj7jBaAv"
Received: from monolith.lan (unknown [193.138.7.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4TwbKY4jGlzybr;
	Thu, 14 Mar 2024 20:20:49 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1710440450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tFDSTflOUzUHrvHW49pfm4f53rqwHYKvkImE5GOzUqs=;
	b=cj7jBaAvR5hrY8DRJcccgdLBfZHR0Cfc9onavt9aD1Cjz4AOc/IlJnUTROYWaMR9/BYnBK
	AKPospXaoz0JG8/XNUjLBzaYXukQUKzDpMqFp8rt0pSrBuD0JKMR/pO+a3cVW+Roj6syw8
	BzscBf9hflKvrKhPcDSxacH3ThRFLvs=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1710440450; a=rsa-sha256; cv=none;
	b=uVG8FXtOjcls7P44Itjw9lczXX+ae0fxUZgk6l+LxUha0OZb9rLUQBT77P9/cGLg4aQUrX
	npcNgoPmLFGWtbbNJuU03byMPA4zzY/5zQ4/FVMR4PF+l3mwpmP47xfRBjJK2XKsXSin2F
	ArFo5cfHbXWfoKhsM3MnrmizbGKtbT8=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1710440450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tFDSTflOUzUHrvHW49pfm4f53rqwHYKvkImE5GOzUqs=;
	b=UlbHjsn7BFdmFRXCaHqb2F5SOIMjYhSey3oLNF12qLaSq666WXMISZ919tJ9lyWIVTOX9a
	l4nyw2wSv/Euxv0M9eg8iGSIwOLWVg+2aChtUL57spvcBFHRxsTSQQaCXebfob0+aAD6xH
	sLYOAl5UvaWDG8cH0xBVDqci4bytgQU=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH v2 1/5] Bluetooth: add support for skb TX timestamping
Date: Thu, 14 Mar 2024 20:20:17 +0200
Message-ID: <070880b4b69ca8523d08a16433b6f4ae0b1a19cc.1710440392.git.pav@iki.fi>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1710440392.git.pav@iki.fi>
References: <cover.1710440392.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support enabling TX timestamping for some skbs, and track them until
packet completion.  Generate SCM_TSTAMP_SCHED when sending to driver,
and SCM_TSTAMP_SND at packet completion.

Make the default situation with no TX timestamping more efficient by
only counting packets in the queue when there is nothing to track.  When
there is something to track, we need to make clones, since the driver
may modify sent skbs.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 include/net/bluetooth/hci_core.h |  12 ++++
 net/bluetooth/hci_conn.c         | 111 +++++++++++++++++++++++++++++++
 net/bluetooth/hci_core.c         |  19 ++++--
 net/bluetooth/hci_event.c        |  11 ++-
 4 files changed, 146 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 56fb42df44a3..f89c0eee6912 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -267,6 +267,12 @@ struct adv_info {
 	struct delayed_work	rpa_expired_cb;
 };
 
+struct tx_queue {
+	struct sk_buff_head queue;
+	unsigned int extra;
+	unsigned int tracked;
+};
+
 #define HCI_MAX_ADV_INSTANCES		5
 #define HCI_DEFAULT_ADV_DURATION	2
 
@@ -763,6 +769,8 @@ struct hci_conn {
 	struct sk_buff_head data_q;
 	struct list_head chan_list;
 
+	struct tx_queue tx_q;
+
 	struct delayed_work disc_work;
 	struct delayed_work auto_accept_work;
 	struct delayed_work idle_work;
@@ -1546,6 +1554,10 @@ void hci_conn_enter_active_mode(struct hci_conn *conn, __u8 force_active);
 void hci_conn_failed(struct hci_conn *conn, u8 status);
 u8 hci_conn_set_handle(struct hci_conn *conn, u16 handle);
 
+void hci_conn_tx_queue(struct hci_conn *conn, struct sk_buff *skb);
+void hci_conn_tx_dequeue(struct hci_conn *conn);
+void hci_tx_timestamp(struct sk_buff *skb, const struct sockcm_cookie *sockc);
+
 /*
  * hci_conn_get() and hci_conn_put() are used to control the life-time of an
  * "hci_conn" object. They do not guarantee that the hci_conn object is running,
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 3ad74f76983b..ce94ffaf06d4 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -27,6 +27,7 @@
 
 #include <linux/export.h>
 #include <linux/debugfs.h>
+#include <linux/errqueue.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -973,6 +974,7 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
 	}
 
 	skb_queue_head_init(&conn->data_q);
+	skb_queue_head_init(&conn->tx_q.queue);
 
 	INIT_LIST_HEAD(&conn->chan_list);
 	INIT_LIST_HEAD(&conn->link_list);
@@ -1117,6 +1119,7 @@ void hci_conn_del(struct hci_conn *conn)
 	}
 
 	skb_queue_purge(&conn->data_q);
+	skb_queue_purge(&conn->tx_q.queue);
 
 	/* Remove the connection from the list and cleanup its remaining
 	 * state. This is a separate function since for some cases like
@@ -2928,3 +2931,111 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
 
 	return hci_cmd_sync_queue_once(hdev, abort_conn_sync, conn, NULL);
 }
+
+void hci_tx_timestamp(struct sk_buff *skb, const struct sockcm_cookie *sockc)
+{
+	/* This shall be called on a single skb of those generated by user
+	 * sendmsg(), and only when the sendmsg() does not return error to
+	 * user. This is required for keeping the tskey that increments here in
+	 * sync with possible sendmsg() counting by user.
+	 */
+
+	if (!skb || !sockc)
+		return;
+
+	skb_setup_tx_timestamp(skb, sockc->tsflags);
+}
+
+void hci_conn_tx_queue(struct hci_conn *conn, struct sk_buff *skb)
+{
+	struct tx_queue *comp = &conn->tx_q;
+	const unsigned int max_queue_len = 128;
+	bool track = false;
+	bool comp_events = false;
+
+	if (skb->sk) {
+		if (skb_shinfo(skb)->tx_flags & SKBTX_SCHED_TSTAMP)
+			__skb_tstamp_tx(skb, NULL, NULL, skb->sk,
+					SCM_TSTAMP_SCHED);
+
+		if (skb_shinfo(skb)->tx_flags & SKBTX_SW_TSTAMP)
+			track = true;
+	}
+
+	/* If nothing is tracked, just count extra skbs at the queue head */
+	if (!track && !comp->tracked) {
+		comp->extra++;
+		return;
+	}
+
+	/* Emit SND timestamp for the tracked skb later on Number of Completed
+	 * Packets/Data Blocks event, if these events are generated. Otherwise,
+	 * emit it now.
+	 */
+	switch (conn->type) {
+	case ISO_LINK:
+	case ACL_LINK:
+	case LE_LINK:
+		comp_events = true;
+		break;
+	}
+
+	if (!comp_events) {
+		if (track)
+			skb_tstamp_tx(skb, NULL);
+		return;
+	}
+
+	/* Safeguard vs. controller not acking packets */
+	if (skb_queue_len(&comp->queue) >= max_queue_len)
+		goto count_only;
+
+	if (track) {
+		skb = skb_clone_sk(skb);
+		if (!skb)
+			goto count_only;
+
+		comp->tracked++;
+	} else {
+		skb = skb_clone(skb, GFP_KERNEL);
+		if (!skb)
+			goto count_only;
+	}
+
+	skb_queue_tail(&comp->queue, skb);
+	return;
+
+count_only:
+	/* Stop tracking skbs, and only count. This will not emit timestamps for
+	 * the packets, but if we get here something is more seriously wrong.
+	 */
+	comp->tracked = 0;
+	comp->extra += skb_queue_len(&comp->queue) + 1;
+	skb_queue_purge(&comp->queue);
+}
+
+void hci_conn_tx_dequeue(struct hci_conn *conn)
+{
+	struct tx_queue *comp = &conn->tx_q;
+	struct sk_buff *skb;
+
+	/* If there are tracked skbs, the counted extra go before dequeuing real
+	 * skbs, to keep ordering. When nothing is tracked, the ordering doesn't
+	 * matter so dequeue real skbs first to get rid of them ASAP.
+	 */
+	if (comp->extra && (comp->tracked || skb_queue_empty(&comp->queue))) {
+		comp->extra--;
+		return;
+	}
+
+	skb = skb_dequeue(&comp->queue);
+	if (!skb)
+		return;
+
+	if (skb->sk) {
+		comp->tracked--;
+		skb_tstamp_tx(skb, NULL);
+	}
+
+	kfree_skb(skb);
+}
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 1690ae57a09d..b77a8b204f21 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3101,6 +3101,13 @@ static int hci_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 	return 0;
 }
 
+static int hci_send_conn_frame(struct hci_dev *hdev, struct hci_conn *conn,
+			       struct sk_buff *skb)
+{
+	hci_conn_tx_queue(conn, skb);
+	return hci_send_frame(hdev, skb);
+}
+
 /* Send HCI command */
 int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen,
 		 const void *param)
@@ -3657,7 +3664,7 @@ static void hci_sched_sco(struct hci_dev *hdev)
 	while (hdev->sco_cnt && (conn = hci_low_sent(hdev, SCO_LINK, &quote))) {
 		while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
 			BT_DBG("skb %p len %d", skb, skb->len);
-			hci_send_frame(hdev, skb);
+			hci_send_conn_frame(hdev, conn, skb);
 
 			conn->sent++;
 			if (conn->sent == ~0)
@@ -3681,7 +3688,7 @@ static void hci_sched_esco(struct hci_dev *hdev)
 						     &quote))) {
 		while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
 			BT_DBG("skb %p len %d", skb, skb->len);
-			hci_send_frame(hdev, skb);
+			hci_send_conn_frame(hdev, conn, skb);
 
 			conn->sent++;
 			if (conn->sent == ~0)
@@ -3715,7 +3722,7 @@ static void hci_sched_acl_pkt(struct hci_dev *hdev)
 			hci_conn_enter_active_mode(chan->conn,
 						   bt_cb(skb)->force_active);
 
-			hci_send_frame(hdev, skb);
+			hci_send_conn_frame(hdev, chan->conn, skb);
 			hdev->acl_last_tx = jiffies;
 
 			hdev->acl_cnt--;
@@ -3771,7 +3778,7 @@ static void hci_sched_acl_blk(struct hci_dev *hdev)
 			hci_conn_enter_active_mode(chan->conn,
 						   bt_cb(skb)->force_active);
 
-			hci_send_frame(hdev, skb);
+			hci_send_conn_frame(hdev, chan->conn, skb);
 			hdev->acl_last_tx = jiffies;
 
 			hdev->block_cnt -= blocks;
@@ -3837,7 +3844,7 @@ static void hci_sched_le(struct hci_dev *hdev)
 
 			skb = skb_dequeue(&chan->data_q);
 
-			hci_send_frame(hdev, skb);
+			hci_send_conn_frame(hdev, chan->conn, skb);
 			hdev->le_last_tx = jiffies;
 
 			cnt--;
@@ -3876,7 +3883,7 @@ static void hci_sched_iso(struct hci_dev *hdev)
 	while (*cnt && (conn = hci_low_sent(hdev, ISO_LINK, &quote))) {
 		while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
 			BT_DBG("skb %p len %d", skb, skb->len);
-			hci_send_frame(hdev, skb);
+			hci_send_conn_frame(hdev, conn, skb);
 
 			conn->sent++;
 			if (conn->sent == ~0)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 4ae224824012..fd18c2810eb7 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4439,6 +4439,7 @@ static void hci_num_comp_pkts_evt(struct hci_dev *hdev, void *data,
 		struct hci_comp_pkts_info *info = &ev->handles[i];
 		struct hci_conn *conn;
 		__u16  handle, count;
+		unsigned int i;
 
 		handle = __le16_to_cpu(info->handle);
 		count  = __le16_to_cpu(info->count);
@@ -4449,6 +4450,9 @@ static void hci_num_comp_pkts_evt(struct hci_dev *hdev, void *data,
 
 		conn->sent -= count;
 
+		for (i = 0; i < count; ++i)
+			hci_conn_tx_dequeue(conn);
+
 		switch (conn->type) {
 		case ACL_LINK:
 			hdev->acl_cnt += count;
@@ -4543,10 +4547,12 @@ static void hci_num_comp_blocks_evt(struct hci_dev *hdev, void *data,
 	for (i = 0; i < ev->num_hndl; i++) {
 		struct hci_comp_blocks_info *info = &ev->handles[i];
 		struct hci_conn *conn = NULL;
-		__u16  handle, block_count;
+		__u16  handle, block_count, pkt_count;
+		unsigned int i;
 
 		handle = __le16_to_cpu(info->handle);
 		block_count = __le16_to_cpu(info->blocks);
+		pkt_count = __le16_to_cpu(info->pkts);
 
 		conn = __hci_conn_lookup_handle(hdev, handle);
 		if (!conn)
@@ -4554,6 +4560,9 @@ static void hci_num_comp_blocks_evt(struct hci_dev *hdev, void *data,
 
 		conn->sent -= block_count;
 
+		for (i = 0; i < pkt_count; ++i)
+			hci_conn_tx_dequeue(conn);
+
 		switch (conn->type) {
 		case ACL_LINK:
 		case AMP_LINK:
-- 
2.44.0

