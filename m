Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28C8405CB
	for <linux-bluetooth@vger.kernel.org>; Sat,  2 Mar 2024 20:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709410072; cv=pass; b=gwQuHO8vB9QyBXIPm0CFfApLBNZfiD0UcPFDYXTslA+hrjrKFOwqzDaXXj2mD2t+cdpV5sa9jpur3q9YuLVeIuHHLdKZZEGqI9woOp1T7G3KlqzFy47w/rSkk1AFdW23nJOV18LgXQNY7HS4xd8eiJrEhIs8SpWr9Ej/KykT9dA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709410072; c=relaxed/simple;
	bh=ROFbXOLH3jHR0dXu+krzdnYD20zsq9MJmvsRKJnOHu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tvHeueacD0sl+0nWFnH8MdOzJB82Dw9npAiATDWZuCi9FcG7V46TFIyqFLyvmC+p8tgMrgMhS8sUe1t6SJXEyTiC5Grjba9ERYfMNbe4Muxms42bYsjB7h33JmHiWr9115ScnU5cMGJUs2QCJHK6pVdOmgUoazxY70W4NZ5zQFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=dPUXuXgH; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="dPUXuXgH"
Received: from monolith.lan (unknown [193.138.7.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4TnGGW4mM4z100r;
	Sat,  2 Mar 2024 22:07:47 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1709410068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=An/mj6d1gOGyrMkwQ6JKMbWIX5kfocAe+0oQz/NspZ0=;
	b=dPUXuXgHFtwegrRPFvBOzVhuNi1j8CYgK1uL7955JVaXtX8WBCJkRslEgOhZNETc6M9TI/
	P4Sg5/oUSq8dyMSiz3e5NwLM7HqXLZXNPQ2mNLMPDKWnuAbkbyDY44s6oVHWR5ySqgW0t+
	qWHFHklwCgd57EXSnCqdJ40iK0pfctA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1709410068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=An/mj6d1gOGyrMkwQ6JKMbWIX5kfocAe+0oQz/NspZ0=;
	b=Qa89ptPTpHMlMKVyI+O2KLD3a0OLPboUDvsnJdg8DyFHgvfQqJZTm5aEGWXmZw23Wnwf1F
	M2EDTIAI9J8PxzbrsNYRU3ajjLHFFUdI2cYHsKTcCs6AB/mKNuUH4YJCMrq6ek7kuUGqcX
	rqFZFvGgbTYlZnVIi54sDvVaERZAMiQ=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1709410068; a=rsa-sha256; cv=none;
	b=CTp9sGCG4dXnaOCRt3svo8RezEruSHEr8zfAVBpiK7uaojqHX6By37ao8CvGD3zUU0m8dI
	PBTD1zVX0FmqYANMOQtaX6Ipke9sh6box3LxOt5jnT+4aeKkolXTyyVXs4sVRvcEuOVfC9
	ij+Owx0FanCnBiRjiL+6wYU1UDEsFzQ=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH 1/3] Bluetooth: add support for skb TX timestamping
Date: Sat,  2 Mar 2024 22:07:36 +0200
Message-ID: <d19187ab9842df2565d1d82beb171a8967d2ea94.1709409547.git.pav@iki.fi>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1709409547.git.pav@iki.fi>
References: <cover.1709409547.git.pav@iki.fi>
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
 include/net/bluetooth/hci_core.h | 12 +++++
 net/bluetooth/hci_conn.c         | 78 ++++++++++++++++++++++++++++++++
 net/bluetooth/hci_core.c         |  5 ++
 net/bluetooth/hci_event.c        |  4 ++
 4 files changed, 99 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 56fb42df44a3..51b556612a6b 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -267,6 +267,12 @@ struct adv_info {
 	struct delayed_work	rpa_expired_cb;
 };
 
+struct tx_comp_queue {
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
 
+	struct tx_comp_queue tx_comp_queue;
+
 	struct delayed_work disc_work;
 	struct delayed_work auto_accept_work;
 	struct delayed_work idle_work;
@@ -1546,6 +1554,10 @@ void hci_conn_enter_active_mode(struct hci_conn *conn, __u8 force_active);
 void hci_conn_failed(struct hci_conn *conn, u8 status);
 u8 hci_conn_set_handle(struct hci_conn *conn, u16 handle);
 
+void hci_conn_tx_comp_queue(struct hci_conn *conn, struct sk_buff *skb);
+void hci_conn_tx_comp_dequeue(struct hci_conn *conn);
+void hci_tx_timestamp(struct sk_buff *skb, const struct sockcm_cookie *sockc);
+
 /*
  * hci_conn_get() and hci_conn_put() are used to control the life-time of an
  * "hci_conn" object. They do not guarantee that the hci_conn object is running,
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 3ad74f76983b..f44d4b8fa0c6 100644
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
+	skb_queue_head_init(&conn->tx_comp_queue.queue);
 
 	INIT_LIST_HEAD(&conn->chan_list);
 	INIT_LIST_HEAD(&conn->link_list);
@@ -1117,6 +1119,7 @@ void hci_conn_del(struct hci_conn *conn)
 	}
 
 	skb_queue_purge(&conn->data_q);
+	skb_queue_purge(&conn->tx_comp_queue.queue);
 
 	/* Remove the connection from the list and cleanup its remaining
 	 * state. This is a separate function since for some cases like
@@ -2928,3 +2931,78 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
 
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
+void hci_conn_tx_comp_queue(struct hci_conn *conn, struct sk_buff *skb)
+{
+	struct tx_comp_queue *comp = &conn->tx_comp_queue;
+	bool track = false;
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
+	if (track) {
+		skb = skb_clone_sk(skb);
+		if (!skb)
+			return;
+
+		comp->tracked++;
+	} else {
+		skb = skb_clone(skb, GFP_KERNEL);
+		if (!skb)
+			return;
+	}
+
+	skb_queue_tail(&comp->queue, skb);
+}
+
+void hci_conn_tx_comp_dequeue(struct hci_conn *conn)
+{
+	struct tx_comp_queue *comp = &conn->tx_comp_queue;
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
index df3aa41e376d..f4af6e99d798 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3715,6 +3715,8 @@ static void hci_sched_acl_pkt(struct hci_dev *hdev)
 			hci_conn_enter_active_mode(chan->conn,
 						   bt_cb(skb)->force_active);
 
+			hci_conn_tx_comp_queue(chan->conn, skb);
+
 			hci_send_frame(hdev, skb);
 			hdev->acl_last_tx = jiffies;
 
@@ -3876,6 +3878,9 @@ static void hci_sched_iso(struct hci_dev *hdev)
 	while (*cnt && (conn = hci_low_sent(hdev, ISO_LINK, &quote))) {
 		while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
 			BT_DBG("skb %p len %d", skb, skb->len);
+
+			hci_conn_tx_comp_queue(conn, skb);
+
 			hci_send_frame(hdev, skb);
 
 			conn->sent++;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index bffd2c7ff608..f56211d8ff7a 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4438,6 +4438,7 @@ static void hci_num_comp_pkts_evt(struct hci_dev *hdev, void *data,
 		struct hci_comp_pkts_info *info = &ev->handles[i];
 		struct hci_conn *conn;
 		__u16  handle, count;
+		unsigned int i;
 
 		handle = __le16_to_cpu(info->handle);
 		count  = __le16_to_cpu(info->count);
@@ -4448,6 +4449,9 @@ static void hci_num_comp_pkts_evt(struct hci_dev *hdev, void *data,
 
 		conn->sent -= count;
 
+		for (i = 0; i < count; ++i)
+			hci_conn_tx_comp_dequeue(conn);
+
 		switch (conn->type) {
 		case ACL_LINK:
 			hdev->acl_cnt += count;
-- 
2.44.0

