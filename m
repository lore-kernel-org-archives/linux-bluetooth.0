Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi, pkrystad@codeaurora.org,
	marcel@holtmann.org, Mat Martineau <mathewm@codeaurora.org>
Subject: [PATCHv2 1/2] Bluetooth: Add the l2cap_seq_list structure for tracking frames
Date: Thu, 29 Mar 2012 17:32:48 -0700
Message-Id: <1333067569-19247-2-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1333067569-19247-1-git-send-email-mathewm@codeaurora.org>
References: <1333067569-19247-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

A sequence list is a data structure used to track frames that need to
be retransmitted, and frames that have been requested for
retransmission by the remote device.  It can compactly represent a
list of sequence numbers within the ERTM transmit window.  Memory for
the list is allocated once at connection time, and common operations
in ERTM are O(1).

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 include/net/bluetooth/l2cap.h |   12 ++++
 net/bluetooth/l2cap_core.c    |  132 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 144 insertions(+)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index f6f0500..5d65b3d 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -407,6 +407,16 @@ struct l2cap_conn_param_update_rsp {
 #define L2CAP_CONN_PARAM_REJECTED	0x0001
 
 /* ----- L2CAP channels and connections ----- */
+struct l2cap_seq_list {
+	__u16	head;
+	__u16	tail;
+	__u16	mask;
+	__u16	*list;
+};
+
+#define L2CAP_SEQ_LIST_CLEAR	0xFFFF
+#define L2CAP_SEQ_LIST_TAIL	0x8000
+
 struct srej_list {
 	__u16	tx_seq;
 	struct list_head list;
@@ -501,6 +511,8 @@ struct l2cap_chan {
 	struct sk_buff		*tx_send_head;
 	struct sk_buff_head	tx_q;
 	struct sk_buff_head	srej_q;
+	struct l2cap_seq_list	srej_list;
+	struct l2cap_seq_list	retrans_list;
 	struct list_head	srej_l;
 
 	struct list_head	list;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 3caff27..2414ddd 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -233,6 +233,134 @@ static inline void l2cap_chan_set_err(struct l2cap_chan *chan, int err)
 	release_sock(sk);
 }
 
+/* ---- L2CAP sequence number lists ---- */
+
+/* For ERTM, ordered lists of sequence numbers must be tracked for
+ * SREJ requests that are received and for frames that are to be
+ * retransmitted. These seq_list functions implement a singly-linked
+ * list in an array, where membership in the list can also be checked
+ * in constant time. Items can also be added to the tail of the list
+ * and removed from the head in constant time, without further memory
+ * allocs or frees.
+ */
+
+static int l2cap_seq_list_init(struct l2cap_seq_list *seq_list, u16 size)
+{
+	u16 alloc_size = 1;
+	int err = 0;
+	int i;
+
+	/* Allocated size is a power of 2 to map sequence numbers
+	 * (which may be up to 14 bits) in to a smaller array that is
+	 * sized for the negotiated ERTM transmit windows.
+	 */
+	while (alloc_size && alloc_size <= size)
+		alloc_size <<= 1;
+	if (!alloc_size)
+		return -ENOMEM;
+
+	seq_list->list = kzalloc(sizeof(u16) * alloc_size, GFP_KERNEL);
+	if (!seq_list->list)
+		return -ENOMEM;
+
+	seq_list->mask = alloc_size - 1;
+	seq_list->head = L2CAP_SEQ_LIST_CLEAR;
+	seq_list->tail = L2CAP_SEQ_LIST_CLEAR;
+	for (i = 0; i < alloc_size; i++)
+		seq_list->list[i] = L2CAP_SEQ_LIST_CLEAR;
+
+	return err;
+}
+
+static inline void l2cap_seq_list_free(struct l2cap_seq_list *seq_list)
+{
+	kfree(seq_list->list);
+}
+
+static inline bool l2cap_seq_list_contains(struct l2cap_seq_list *seq_list,
+					   u16 seq)
+{
+	/* Constant-time check for list membership */
+	return seq_list->list[seq & seq_list->mask] != L2CAP_SEQ_LIST_CLEAR;
+}
+
+static u16 l2cap_seq_list_remove(struct l2cap_seq_list *seq_list, u16 seq)
+{
+	u16 mask = seq_list->mask;
+
+	BT_DBG("seq_list %p, seq %d", seq_list, (int) seq);
+
+	if (seq_list->head == L2CAP_SEQ_LIST_CLEAR) {
+		/* In case someone tries to pop the head of an empty list */
+		BT_DBG("List empty");
+		return L2CAP_SEQ_LIST_CLEAR;
+	} else if (seq_list->head == seq) {
+		/* Head can be removed in constant time */
+		BT_DBG("Remove head");
+		seq_list->head = seq_list->list[seq & mask];
+		seq_list->list[seq & mask] = L2CAP_SEQ_LIST_CLEAR;
+
+		if (seq_list->head == L2CAP_SEQ_LIST_TAIL) {
+			seq_list->head = L2CAP_SEQ_LIST_CLEAR;
+			seq_list->tail = L2CAP_SEQ_LIST_CLEAR;
+		}
+	} else {
+		/* Walk the list to find the sequence number */
+		u16 prev = seq_list->head;
+		BT_DBG("Find and remove");
+		while (seq_list->list[prev & mask] != seq) {
+			prev = seq_list->list[prev & mask];
+			if (prev == L2CAP_SEQ_LIST_TAIL) {
+				BT_DBG("seq %d not in list", (int) seq);
+				return L2CAP_SEQ_LIST_CLEAR;
+			}
+		}
+
+		/* Unlink the number from the list and clear it */
+		seq_list->list[prev & mask] = seq_list->list[seq & mask];
+		seq_list->list[seq & mask] = L2CAP_SEQ_LIST_CLEAR;
+		if (seq_list->tail == seq)
+			seq_list->tail = prev;
+	}
+	return seq;
+}
+
+static u16 l2cap_seq_list_pop(struct l2cap_seq_list *seq_list)
+{
+	/* Remove the head in constant time */
+	return l2cap_seq_list_remove(seq_list, seq_list->head);
+}
+
+static void l2cap_seq_list_clear(struct l2cap_seq_list *seq_list)
+{
+	if (seq_list->head != L2CAP_SEQ_LIST_CLEAR) {
+		u16 i;
+		for (i = 0; i <= seq_list->mask; i++)
+			seq_list->list[i] = L2CAP_SEQ_LIST_CLEAR;
+
+		seq_list->head = L2CAP_SEQ_LIST_CLEAR;
+		seq_list->tail = L2CAP_SEQ_LIST_CLEAR;
+	}
+}
+
+static void l2cap_seq_list_append(struct l2cap_seq_list *seq_list, u16 seq)
+{
+	u16 mask = seq_list->mask;
+
+	/* All appends happen in constant time */
+	BT_DBG("seq_list %p, seq %d", seq_list, (int) seq);
+
+	if (seq_list->list[seq & mask] == L2CAP_SEQ_LIST_CLEAR) {
+		if (seq_list->tail == L2CAP_SEQ_LIST_CLEAR)
+			seq_list->head = seq;
+		else
+			seq_list->list[seq_list->tail & mask] = seq;
+
+		seq_list->tail = seq;
+		seq_list->list[seq & mask] = L2CAP_SEQ_LIST_TAIL;
+	}
+}
+
 static void l2cap_chan_timeout(struct work_struct *work)
 {
 	struct l2cap_chan *chan = container_of(work, struct l2cap_chan,
@@ -404,6 +532,8 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
 
 		skb_queue_purge(&chan->srej_q);
 
+		l2cap_seq_list_free(&chan->srej_list);
+		l2cap_seq_list_free(&chan->retrans_list);
 		list_for_each_entry_safe(l, tmp, &chan->srej_l, list) {
 			list_del(&l->list);
 			kfree(l);
@@ -2052,6 +2182,8 @@ static inline void l2cap_ertm_init(struct l2cap_chan *chan)
 
 	skb_queue_head_init(&chan->srej_q);
 
+	l2cap_seq_list_init(&chan->srej_list, chan->tx_win);
+	l2cap_seq_list_init(&chan->retrans_list, chan->remote_tx_win);
 	INIT_LIST_HEAD(&chan->srej_l);
 }
 
-- 
1.7.9.4

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
