Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71D840843
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Feb 2024 20:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709150643; cv=pass; b=ERaH9VjhLW0g9MW/KfwoYwglUTQXSdBnM2YTcPZ15H9ScFqQp9Am7H2sQ0z6dYSsEyx1n3coLMbCg+dmEzI8be3IDNbgYjBsNJowWzhfEusEup29BpS217iFPtwsy2NItvwJg5h1KUKBCwgxq+pEPiqpYjSboasczU2QbWTP18I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709150643; c=relaxed/simple;
	bh=9JjouAwOyLhzIlTMD+TGKxS9AKHPZlfeje/8acJem04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XLGtvWF/1I4515EwOrp7bzfH7eW6ZfhzGkRA6uws/QBr8yhHZ4+re0ITH0MemQ1VqibOyaQeKRWh8PMRRV6RuPH1t5SJFBnUuf17CclrMQAfIuQKPbNi79nEAV9Tv26XUcK2PK6NSB7Kz6pSMIaxIazzBfQCEw3t952OlNiuRYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=xHOCFBzO; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="xHOCFBzO"
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4TlQKT5CqlzygB;
	Wed, 28 Feb 2024 22:03:57 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1709150638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DGI5sx30aratdFRZ9rzSr7kDp70SlF9692eNmRNcwXo=;
	b=xHOCFBzOv+Y762z5aafSyeTg9GOZK9jQ1og8V1kkZOgYfVPmUPG5Mq1r+NKLTeUpUIdqlG
	py5C+teB145q4z+2qhxqhS1G1MLvohgsryJgU3clbjhSoNWaID2QwViHTO+Bhit4DKhUl1
	dYMrlGxl7sEuYMqhWdWnp5KjDHOfDWw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1709150638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DGI5sx30aratdFRZ9rzSr7kDp70SlF9692eNmRNcwXo=;
	b=O4+xLrqbHA//aAvA9+RizK8Gj16JrfkitkpE+suwXMbjpko4x9EOzd4wotWSzgTD+mur+s
	YoA1W47qsgiTc+Hlau4VcHsbwpoe75qrqKZzShQx6ITUX89TsB9KeG4KBJopme38v/BMjb
	oeujCJzQi4k5Sn26R1gjESteMcJnr3Q=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1709150638; a=rsa-sha256; cv=none;
	b=OrdlJrpwIno20ThwNZ5E2A2zxnxhCTLPQSU+DvOAD+p64SyFdieJ0FRAFNEA5dNpueCA9H
	aiT/E5HmFgQNfhL3u753FFhcNBhpMnksYDj8KwHCnlgysavafzC0RP512R3efNaEx8yvmp
	CRbi1mcN6CzwPXGGDHfvtHE6mPFnsIE=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH 1/3] Bluetooth: add transmission latency tracking for ISO and ACL
Date: Wed, 28 Feb 2024 22:03:39 +0200
Message-ID: <c99ba1062eea9d1bd463bafc7f052bd2d93de172.1709150574.git.pav@iki.fi>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1709150574.git.pav@iki.fi>
References: <cover.1709150574.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add mechanism to track specific skbs from socket to controller packet
completion.

This will be used to allow users submitting packets to sockets, to find
for the latest completed packet: the total socket+controller queue
length (in packets they submitted), controller packet completion timing,
and current total transmission latency.

This handles fragmentation of user-submitted packets and flow control in
L2CAP, which make raw skb queue lengths not informative to the user, and
does not change skb life cycle.

Implementation:

Sockets may mark selected skbs.  When controller reports the
corresponding packet completed, information in struct tx_latency in the
corresponding hci_conn or hci_chan is updated.

Add struct tx_latency to hci_conn and hci_chan, to track last completed
packet status.

Add hci_tx_info_queue to each hci_conn, and use it to track which
packets they sent to controller.  In packet completion event, pop info
from the queues to find if the packet had marked skb and which hci_chan
it came from.

Allow safe concurrent reading of struct tx_latency.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 include/net/bluetooth/bluetooth.h |   2 +
 include/net/bluetooth/hci_core.h  |  30 ++++++++
 net/bluetooth/hci_conn.c          | 110 +++++++++++++++++++++++++++++-
 net/bluetooth/hci_core.c          |  14 ++++
 net/bluetooth/hci_event.c         |  66 ++++++++++++++++++
 5 files changed, 221 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 7ffa8c192c3f..f6bdd040adaa 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -462,6 +462,8 @@ struct bt_skb_cb {
 	u8 pkt_type;
 	u8 force_active;
 	u16 expect;
+	u16 user_sn;
+	u8 have_user_sn:1;
 	u8 incoming:1;
 	u8 pkt_status:2;
 	union {
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 56fb42df44a3..e84a37c1e8b1 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -29,6 +29,7 @@
 #include <linux/idr.h>
 #include <linux/leds.h>
 #include <linux/rculist.h>
+#include <linux/seqlock.h>
 
 #include <net/bluetooth/hci.h>
 #include <net/bluetooth/hci_sync.h>
@@ -267,6 +268,26 @@ struct adv_info {
 	struct delayed_work	rpa_expired_cb;
 };
 
+struct tx_latency {
+	seqcount_t	seq;
+	struct {
+		ktime_t		time;
+		__s64		offset;
+		unsigned int	queue;
+	} now;
+	__u16		sn;
+};
+
+struct tx_info_queue {
+	struct {
+		__u16	sn;
+		void	*data;
+	} *info;
+	unsigned int	size;
+	unsigned int	head;
+	unsigned int	num;
+};
+
 #define HCI_MAX_ADV_INSTANCES		5
 #define HCI_DEFAULT_ADV_DURATION	2
 
@@ -746,6 +767,9 @@ struct hci_conn {
 	struct bt_iso_qos iso_qos;
 	unsigned long	flags;
 
+	struct tx_latency tx_latency;
+	struct tx_info_queue tx_info_queue;
+
 	enum conn_reasons conn_reason;
 	__u8		abort_reason;
 
@@ -803,6 +827,7 @@ struct hci_chan {
 	unsigned int	sent;
 	__u8		state;
 	bool		amp;
+	struct tx_latency tx_latency;
 };
 
 struct hci_conn_params {
@@ -1546,6 +1571,11 @@ void hci_conn_enter_active_mode(struct hci_conn *conn, __u8 force_active);
 void hci_conn_failed(struct hci_conn *conn, u8 status);
 u8 hci_conn_set_handle(struct hci_conn *conn, u16 handle);
 
+void hci_conn_tx_info_push(struct hci_conn *conn, void *ptr, __u16 sn);
+void *hci_conn_tx_info_pop(struct hci_conn *conn, __u16 *sn);
+void hci_mark_tx_latency(struct tx_latency *tx, struct sk_buff *skb);
+void hci_copy_tx_latency(struct tx_latency *dst, struct tx_latency *src);
+
 /*
  * hci_conn_get() and hci_conn_put() are used to control the life-time of an
  * "hci_conn" object. They do not guarantee that the hci_conn object is running,
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 3ad74f76983b..2c557eb63b93 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -138,6 +138,12 @@ void hci_connect_le_scan_cleanup(struct hci_conn *conn, u8 status)
 	hci_update_passive_scan(hdev);
 }
 
+static void hci_conn_tx_info_cleanup(struct hci_conn *conn)
+{
+	kfree(conn->tx_info_queue.info);
+	conn->tx_info_queue.info = NULL;
+}
+
 static void hci_conn_cleanup(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
@@ -158,6 +164,8 @@ static void hci_conn_cleanup(struct hci_conn *conn)
 	if (conn->cleanup)
 		conn->cleanup(conn);
 
+	hci_conn_tx_info_cleanup(conn);
+
 	if (conn->type == SCO_LINK || conn->type == ESCO_LINK) {
 		switch (conn->setting & SCO_AIRMODE_MASK) {
 		case SCO_AIRMODE_CVSD:
@@ -904,6 +912,39 @@ static int hci_conn_hash_alloc_unset(struct hci_dev *hdev)
 			       U16_MAX, GFP_ATOMIC);
 }
 
+static int hci_conn_tx_info_init(struct hci_conn *conn)
+{
+	struct tx_info_queue *txq = &conn->tx_info_queue;
+	size_t size = 0;
+
+	switch (conn->type) {
+	case ISO_LINK:
+		size = conn->hdev->iso_pkts;
+		if (!size)
+			size = conn->hdev->le_pkts;
+		if (!size)
+			size = conn->hdev->acl_pkts;
+		break;
+	case ACL_LINK:
+		size = conn->hdev->acl_pkts;
+		break;
+	}
+
+	if (size) {
+		txq->info = kcalloc(size, sizeof(txq->info[0]), GFP_KERNEL);
+		if (!txq->info)
+			return -ENOMEM;
+	} else {
+		txq->info = NULL;
+	}
+
+	txq->size = size;
+	txq->head = 0;
+	txq->num = 0;
+
+	return 0;
+}
+
 struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
 			      u8 role, u16 handle)
 {
@@ -932,6 +973,12 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
 	conn->max_tx_power = HCI_TX_POWER_INVALID;
 	conn->sync_handle = HCI_SYNC_HANDLE_INVALID;
 
+	seqcount_init(&conn->tx_latency.seq);
+	if (hci_conn_tx_info_init(conn) < 0) {
+		kfree(conn);
+		return NULL;
+	}
+
 	set_bit(HCI_CONN_POWER_SAVE, &conn->flags);
 	conn->disc_timeout = HCI_DISCONN_TIMEOUT;
 
@@ -1005,6 +1052,7 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
 struct hci_conn *hci_conn_add_unset(struct hci_dev *hdev, int type,
 				    bdaddr_t *dst, u8 role)
 {
+	struct hci_conn *conn;
 	int handle;
 
 	bt_dev_dbg(hdev, "dst %pMR", dst);
@@ -1013,7 +1061,11 @@ struct hci_conn *hci_conn_add_unset(struct hci_dev *hdev, int type,
 	if (unlikely(handle < 0))
 		return NULL;
 
-	return hci_conn_add(hdev, type, dst, role, handle);
+	conn = hci_conn_add(hdev, type, dst, role, handle);
+	if (!conn)
+		ida_free(&hdev->unset_handle_ida, handle);
+
+	return conn;
 }
 
 static void hci_conn_cleanup_child(struct hci_conn *conn, u8 reason)
@@ -2711,6 +2763,8 @@ struct hci_chan *hci_chan_create(struct hci_conn *conn)
 	skb_queue_head_init(&chan->data_q);
 	chan->state = BT_CONNECTED;
 
+	seqcount_init(&chan->tx_latency.seq);
+
 	list_add_rcu(&chan->list, &conn->chan_list);
 
 	return chan;
@@ -2928,3 +2982,57 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
 
 	return hci_cmd_sync_queue_once(hdev, abort_conn_sync, conn, NULL);
 }
+
+void hci_conn_tx_info_push(struct hci_conn *conn, void *ptr, __u16 sn)
+{
+	struct tx_info_queue *txq = &conn->tx_info_queue;
+	unsigned int tail;
+
+	if (!txq->num && !ptr)
+		return;
+	if (txq->num >= txq->size || !txq->info)
+		return;
+
+	tail = (txq->head + txq->num) % txq->size;
+	txq->info[tail].data = ptr;
+	txq->info[tail].sn = sn;
+	txq->num++;
+}
+
+void *hci_conn_tx_info_pop(struct hci_conn *conn, __u16 *sn)
+{
+	struct tx_info_queue *txq = &conn->tx_info_queue;
+	void *ptr;
+
+	if (!txq->num || !txq->info || !txq->size)
+		return NULL;
+
+	ptr = txq->info[txq->head].data;
+	*sn = txq->info[txq->head].sn;
+	txq->head = (txq->head + 1) % txq->size;
+	txq->num--;
+
+	return ptr;
+}
+
+void hci_mark_tx_latency(struct tx_latency *tx, struct sk_buff *skb)
+{
+	if (!skb)
+		return;
+
+	/* Reads may be concurrent */
+	WRITE_ONCE(tx->sn, tx->sn + 1u);
+
+	bt_cb(skb)->user_sn = tx->sn;
+	bt_cb(skb)->have_user_sn = true;
+}
+
+void hci_copy_tx_latency(struct tx_latency *dst, struct tx_latency *src)
+{
+	unsigned int seq;
+
+	do {
+		seq = read_seqcount_begin(&src->seq);
+		dst->now = src->now;
+	} while (read_seqcount_retry(&src->seq, seq));
+}
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 6ca4c0df9f9c..bbdd8b28fb2c 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3703,6 +3703,9 @@ static void hci_sched_acl_pkt(struct hci_dev *hdev)
 	       (chan = hci_chan_sent(hdev, ACL_LINK, &quote))) {
 		u32 priority = (skb_peek(&chan->data_q))->priority;
 		while (quote-- && (skb = skb_peek(&chan->data_q))) {
+			u16 sn = bt_cb(skb)->user_sn;
+			bool have_sn = bt_cb(skb)->have_user_sn;
+
 			BT_DBG("chan %p skb %p len %d priority %u", chan, skb,
 			       skb->len, skb->priority);
 
@@ -3722,6 +3725,11 @@ static void hci_sched_acl_pkt(struct hci_dev *hdev)
 			chan->sent++;
 			chan->conn->sent++;
 
+			if (have_sn)
+				hci_conn_tx_info_push(chan->conn, chan, sn);
+			else
+				hci_conn_tx_info_push(chan->conn, NULL, 0);
+
 			/* Send pending SCO packets right away */
 			hci_sched_sco(hdev);
 			hci_sched_esco(hdev);
@@ -3875,9 +3883,15 @@ static void hci_sched_iso(struct hci_dev *hdev)
 		hdev->le_pkts ? &hdev->le_cnt : &hdev->acl_cnt;
 	while (*cnt && (conn = hci_low_sent(hdev, ISO_LINK, &quote))) {
 		while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
+			u16 sn = bt_cb(skb)->user_sn;
+			bool have_sn = bt_cb(skb)->have_user_sn;
+
 			BT_DBG("skb %p len %d", skb, skb->len);
+
 			hci_send_frame(hdev, skb);
 
+			hci_conn_tx_info_push(conn, UINT_PTR(have_sn), sn);
+
 			conn->sent++;
 			if (conn->sent == ~0)
 				conn->sent = 0;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index bffd2c7ff608..144d4b481309 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4417,10 +4417,72 @@ static void hci_role_change_evt(struct hci_dev *hdev, void *data,
 	hci_dev_unlock(hdev);
 }
 
+static void update_acl_tx_latency(struct hci_conn *conn, int count, ktime_t now)
+{
+	unsigned int i;
+
+	rcu_read_lock();
+
+	for (i = 0; i < count; ++i) {
+		struct hci_chan *chan;
+		void *ptr;
+		u16 sn;
+
+		ptr = hci_conn_tx_info_pop(conn, &sn);
+		if (!ptr)
+			continue;
+
+		list_for_each_entry_rcu(chan, &conn->chan_list, list) {
+			struct tx_latency *tx = &chan->tx_latency;
+
+			if (chan != ptr)
+				continue;
+
+			preempt_disable();
+			write_seqcount_begin(&tx->seq);
+			tx->now.time = now;
+			tx->now.queue = (u16)(READ_ONCE(tx->sn) - sn);
+			tx->now.offset = 0;
+			write_seqcount_end(&tx->seq);
+			preempt_enable();
+		}
+	}
+
+	rcu_read_unlock();
+}
+
+static void update_iso_tx_latency(struct hci_conn *conn, int count, ktime_t now)
+{
+	struct tx_latency *tx = NULL;
+	u16 sn;
+	unsigned int i;
+
+	for (i = 0; i < count; ++i) {
+		u16 tx_sn;
+
+		if (hci_conn_tx_info_pop(conn, &tx_sn)) {
+			tx = &conn->tx_latency;
+			sn = tx_sn;
+		}
+	}
+
+	if (!tx)
+		return;
+
+	preempt_disable();
+	write_seqcount_begin(&tx->seq);
+	tx->now.time = now;
+	tx->now.queue = (u16)(READ_ONCE(tx->sn) - sn);
+	tx->now.offset = 0;
+	write_seqcount_end(&tx->seq);
+	preempt_enable();
+}
+
 static void hci_num_comp_pkts_evt(struct hci_dev *hdev, void *data,
 				  struct sk_buff *skb)
 {
 	struct hci_ev_num_comp_pkts *ev = data;
+	ktime_t now = ktime_get();
 	int i;
 
 	if (!hci_ev_skb_pull(hdev, skb, HCI_EV_NUM_COMP_PKTS,
@@ -4450,6 +4512,8 @@ static void hci_num_comp_pkts_evt(struct hci_dev *hdev, void *data,
 
 		switch (conn->type) {
 		case ACL_LINK:
+			update_acl_tx_latency(conn, count, now);
+
 			hdev->acl_cnt += count;
 			if (hdev->acl_cnt > hdev->acl_pkts)
 				hdev->acl_cnt = hdev->acl_pkts;
@@ -4474,6 +4538,8 @@ static void hci_num_comp_pkts_evt(struct hci_dev *hdev, void *data,
 			break;
 
 		case ISO_LINK:
+			update_iso_tx_latency(conn, count, now);
+
 			if (hdev->iso_pkts) {
 				hdev->iso_cnt += count;
 				if (hdev->iso_cnt > hdev->iso_pkts)
-- 
2.44.0

