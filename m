Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12BA1773D
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Feb 2024 22:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707345732; cv=pass; b=iiEw08cF3Rm6OuPMc4oflfnfh0me3ic2wqr7ocJbYwti8dsjQboCPNTLlp/EXENnB8sNhGvc3+jYwV5SjZZvxZ+y0lyb1xO5k1M9qr8S5TFbpW/EUNO60pEFUJuo7aEHRIZkWQ1aawC7AeWDEh9LWLUuw60SAOXWJnQr1f/DlXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707345732; c=relaxed/simple;
	bh=OjfRUSGbnetfcmFK68YV0icp1BIyvRzTqREXGZp4+yQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GrllTcDQqi7/cVyqZN7I6OOwqniUDkb6I7YY8f/KDuDE6YzGSWUX0GjTJ/Uod+B5Y/HyhDfx4ODGOzhCNASP0zhn51ta13iWTBaPYAg/v/ryTSIKy007hyhsFc99wY4owo/EL6YuG7PWQQ9LEzkpEBuYSdvhEjNxV7ulZibnNiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=bHfoJmAM; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="bHfoJmAM"
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4TVZqX46W1z49Pwl;
	Thu,  8 Feb 2024 00:42:00 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1707345721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MV2h7lRPDlwSq60qPQDJA2ZFDMgR0ZEWc0sA0qEJNpg=;
	b=bHfoJmAMeKHEDyzIsmD0bZ9pkm8qQ3UeEXakqBVJsOcdyEDW9AvimWGf541PjJj//K5jlt
	okq2mOwAQZuLezAHsyd92LD5uy6x+7xfL5JgKWeMbcOf1xE+UkgtUKO72TZwN1zm/+fAHD
	/G69wp+NjdN+/2PsvcOq9FIk0iknos46SeHxcEIAA36KeEy7rX7PP12rK8wtcsm9z17hWs
	q4tyx9htzNLfxx+yL3g+hFs/9Y4Plirhc1l28z4jCmH//0QYkNYXO4tno72/Ur/oYhdbRj
	eHq4IvgpOhnGUPIVQ2iMvHKS73JZzqs2xI/uceu2DQIdyLH8i1/EbaYVK7G6OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1707345721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MV2h7lRPDlwSq60qPQDJA2ZFDMgR0ZEWc0sA0qEJNpg=;
	b=gvu75yMlhWMU/t/NZV/dWokGJeJR4TCyD/mkSiaSpAG2hLpFXZn/gh6wWo67Px1NhFXhUQ
	iN3oVQlj/xX+TDMwzKWJkhoLLnD9YEPa6zt8vLnxE4/GusduoBCYHxhECQriETPfRYQfVj
	xn6AELmn2aFxGhjkmYuQp+BfPnx+cLgCPKSGoVMKOYFW5stzyiK1pin/6wO0o2xNEOfjyK
	u9/ATlPorx6WWS6z4xIuZJYulzuQ5W+Qxoai8APN53ERZGVvt9+nzxVXRTK0WmVM95bsP2
	j3BsJKy6598gzvxyBjFmepTE3/JstKrz1cvNWaEKHY3Ylq9BVgIYENS/YWdaIw==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1707345721; a=rsa-sha256;
	cv=none;
	b=SkzLdosND5Z7gm5N7M+M391uM96m8qv9pffueYM9UziCQFv6saag2Bj98pJO5XcaLDfEk2
	gLQxJDKWiHN5BiyneDEbq4aFyCBJfgTzllXoCR2cDWlodCdWBfYXZ4W6NDYgAL/38fgMkH
	BXbjzx1v2rgHYDc1ANincRkUiZQwQTteJK41NegRbFI10jbeokgxmFF05rw2/gC4xhfTRE
	iLEB/VfoL8IbDs/br8sQ94Vf0NSFkp75Icu5tH3v0guE5jz2a2GHoYGvdyhj5oKqgyB/nm
	m8Kh8x7m3SQd+mB+Ho6qkaMOLQY6EBDmDdRdf6rtuDYLlnEx7NvmJKhypnATxA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH] Bluetooth: ISO: add stream synchronization mechanism
Date: Thu,  8 Feb 2024 00:41:47 +0200
Message-ID: <ebaa4168cb73733ae8fca3c8f47fb88b757ebdfe.1707343746.git.pav@iki.fi>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ISO streams in the same group should be synchronized, this is required
e.g. by stereo audio playback in TWS headsets.  Currently the only
synchronization mechanism we use is that the user has to supply data for
each stream at the right time and in right order, and then we send them
to the controller ASAP without explicitly trying to keep streams in sync
and hope for the best.

However, it is observed e.g. with Intel AX210 that rather often a packet
for one of the streams does not get sent but is left in the queue and
postponed, even if submitted to controller queue at the same time (as
far as able). After this, that ISO stream latency is persistently one
packet larger relative to the other streams in the group, and e.g. TWS
stereo audio is ruined.  User sending packets to the ISO sockets cannot
know this occurred, nor can it easily correct for it.

The issue can e.g. be triggered by bad transmission (e.g. cover one of
the TWS earbuds with hand, or move the device further away), which
appears to make a random change to the latency of its stream.

Fix the problem by adding an explicit stream synchronization mechanism
to ISO sockets, and handling stream synchronization in packet
scheduling.

The user may tag each packet sent to ISO socket via CMSG with a
monotonically increasing sequence number.  The kernel shall ensure that
SDU timings within ISO group are such that packets with same CMSG
sequence number are aligned.

The implementation here does this by delaying sending some packets until
the streams are aligned.  It will also wait for controller queue to
flush sufficiently, if it appears that streams are out of sync on the
controller side.  See the code for explanation.

This patch fixes the observed TWS desynchronization issue (currently not
completely, see below), if the sound server is modified to add the
packet seq,
https://gitlab.freedesktop.org/pvir/pipewire/-/commits/iso-seqnum

I tried various other things to try to fix this (FIFO scheduling,
different number of packets submitted at the same time, etc.), without
much success, and this is the first one to give results.  Requiring
conn->sent alignment before sending more stuff to the controller seemed
the important step here.

There are a few things to think about, hence RFC:

- Any better ideas?

  The spec seems vague here (if we can't set SDU timestamps), so some
  approach that's not based on guessing what the controller internally
  does could be better.

- The conn->sent alignment check probably should be somehow refined.  It
  seems to be enough with low transport latency, but with larger
  transport latencies one can still get streams out of sync,
  characterized by the controller not reporting Number of Completed
  packets for all streams in one go, but sending completed packet events
  for some of the streams only a bit later.

- This sort of scheduling thing that depends on controller queue or
  clock IMO needs to be done in kernel, user should just tell the kernel
  how stuff is supposed to be scheduled.

- However, not clear if packet sequence number is the best way to for
  this sort of thing, or if user should specify some sort of timestamps
  or other information instead.

  E.g. we might change this to use SDU timestamps (if they can be used),
  but user would communicate the scheduling info still the same way.

- Ideally we probably should use SDU timestamps to explicitly tell the
  controller which packets go to same interval, but at least when last
  tried AX210 didn't support HCI_LE_Read_ISO_TX_Sync, and it appears
  clock synchronization is required which cannot(?) be obtained without
  it.

- This patch can make latency to grow on transmission glitch, if it
  needs to wait for controller queue to drain so that streams can be
  aligned again. For proper flow control especially in audio use cases,
  but also more generally, would be better to have for user a way to
  know the number of packets in queue, in socket buf, and in controller,
  and the max.  TIOCOUTQ is similar, but does not give packet counts nor
  controller queue so is insufficient.

Link: https://github.com/bluez/bluez/issues/515
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 include/net/bluetooth/bluetooth.h |   6 +
 include/net/bluetooth/iso.h       |   3 +
 net/bluetooth/hci_core.c          | 262 ++++++++++++++++++++++++++++--
 net/bluetooth/iso.c               |  46 ++++++
 4 files changed, 305 insertions(+), 12 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 7ffa8c192c3f..f93149740207 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -458,6 +458,11 @@ struct mgmt_ctrl {
 	u16 opcode;
 };
 
+struct iso_ctrl {
+	u16 seq;
+	u8 have_seq:1;
+};
+
 struct bt_skb_cb {
 	u8 pkt_type;
 	u8 force_active;
@@ -469,6 +474,7 @@ struct bt_skb_cb {
 		struct hci_ctrl hci;
 		struct mgmt_ctrl mgmt;
 		struct scm_creds creds;
+		struct iso_ctrl iso;
 	};
 };
 #define bt_cb(skb) ((struct bt_skb_cb *)((skb)->cb))
diff --git a/include/net/bluetooth/iso.h b/include/net/bluetooth/iso.h
index 3f4fe8b78e1b..a68ddd99232f 100644
--- a/include/net/bluetooth/iso.h
+++ b/include/net/bluetooth/iso.h
@@ -29,4 +29,7 @@ struct sockaddr_iso {
 	struct sockaddr_iso_bc iso_bc[];
 };
 
+/* ISO socket CMSG */
+#define ISO_CMSG_SEQ			0x01	/* u16 data */
+
 #endif /* __ISO_H */
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 34c8dca2069f..706784aa8bb4 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3330,6 +3330,7 @@ static void hci_queue_iso(struct hci_conn *conn, struct sk_buff_head *queue,
 {
 	struct hci_dev *hdev = conn->hdev;
 	struct sk_buff *list;
+	ktime_t now = ktime_get();
 	__u16 flags;
 
 	skb->len = skb_headlen(skb);
@@ -3346,6 +3347,7 @@ static void hci_queue_iso(struct hci_conn *conn, struct sk_buff_head *queue,
 		/* Non fragmented */
 		BT_DBG("%s nonfrag skb %p len %d", hdev->name, skb, skb->len);
 
+		skb_set_delivery_time(skb, now, true);
 		skb_queue_tail(queue, skb);
 	} else {
 		/* Fragmented */
@@ -3353,6 +3355,7 @@ static void hci_queue_iso(struct hci_conn *conn, struct sk_buff_head *queue,
 
 		skb_shinfo(skb)->frag_list = NULL;
 
+		skb_set_delivery_time(skb, now, true);
 		__skb_queue_tail(queue, skb);
 
 		do {
@@ -3365,6 +3368,7 @@ static void hci_queue_iso(struct hci_conn *conn, struct sk_buff_head *queue,
 
 			BT_DBG("%s frag %p len %d", hdev->name, skb, skb->len);
 
+			skb_set_delivery_time(skb, now, true);
 			__skb_queue_tail(queue, skb);
 		} while (list);
 	}
@@ -3461,6 +3465,237 @@ static struct hci_conn *hci_low_sent(struct hci_dev *hdev, __u8 type,
 	return conn;
 }
 
+static unsigned int iso_group_id(struct hci_conn *conn)
+{
+	if (!conn)
+		return 0xff;
+
+	if (bacmp(&conn->dst, BDADDR_ANY))
+		return (u8)conn->iso_qos.ucast.cig;
+	else
+		return (u8)conn->iso_qos.bcast.big + 0x100;
+}
+
+static int iso_seq_cmp(u16 a, u16 b)
+{
+	u16 diff = a - b;
+
+	return (diff == 0) ? 0 : (diff < U16_MAX / 2) ? 1 : -1;
+}
+
+static struct hci_conn *hci_low_iso_group(struct hci_dev *hdev, u16 group_id,
+					  int pkt, int max_pkt,
+					  ktime_t *res_time)
+{
+	struct hci_conn_hash *h = &hdev->conn_hash;
+	struct hci_conn *c;
+	bool ready = true;
+	bool same_sent = true;
+	struct hci_conn *early_c = NULL;
+	ktime_t early_time = KTIME_MAX;
+	struct hci_conn *seq_c = NULL;
+	u16 seq = 0;
+	unsigned int sent = ~0;
+	int group_size = 0;
+
+	/* The controller may use packet arrival times to assign timestamps
+	 * (Core v5.4 Vol 6 Part G Sec 3.3). We should try to send packets that
+	 * correspond to same interval in ISO group at the same time, so that
+	 * streams in the group stay in sync with each other.
+	 *
+	 * User may attach a sequence number (seq) to each skb via cmsg.  We try
+	 * to send, within a group, the skb that have the same seq at the same
+	 * time.
+	 *
+	 * skb seq and ktime (when we received it from user) are used for
+	 * scheduling. The seq of a stream is the one of its first skb.
+	 *
+	 * First:
+	 *
+	 * - For each stream in a group, clear seq that are earlier than other
+	 *   seq in the group.
+	 *
+	 * - If all streams in a group have same seq, those streams are
+	 *   "ready".
+	 *
+	 * - If a stream in a group has no seq, that stream is "ready".
+	 *
+	 * Then:
+	 *
+	 * Select the "ready" stream that has earliest ktime, of those in all
+	 * groups.
+	 *
+	 * If the stream has seq (= its group as a whole is "ready"):
+	 *
+	 * - If controller does not have enough free packet slots to receive
+	 *   the whole group at once, but in principle can have enough slots,
+	 *   don't send anything and wait for queue to clear.
+	 *
+	 * - If conn->sent in the group are not equal, don't send anything
+	 *   and wait for queue to clear.
+	 *
+	 * The conn->sent one is important, and is what recovers synchronization
+	 * when the controller loses it. It appears that e.g. with Intel AX210
+	 * sometimes one of packets of a group, even when submitted immediately
+	 * after each other to all streams in a group, fails to be sent but is
+	 * left in the queue instead of being discarded. It gets postponed for
+	 * later, but this destroys synchronization between streams, and we have
+	 * to compensate for this if we see it.
+	 *
+	 * Core v5.4 Vol 6 Part G does not give much tools to do things properly
+	 * when HCI_LE_Read_ISO_TX_Sync does not work and we can't set
+	 * timestamps, hence the contortions here.
+	 */
+
+	/* called with rcu lock held */
+	list_for_each_entry_rcu(c, &h->list, list) {
+		struct sk_buff *skb;
+
+		if (c->type != ISO_LINK || c->state != BT_CONNECTED)
+			continue;
+		if (iso_group_id(c) != group_id)
+			continue;
+
+		++group_size;
+
+		if (sent == ~0)
+			sent = c->sent;
+		if (c->sent != sent)
+			same_sent = false;
+
+		if (skb_queue_empty(&c->data_q)) {
+			ready = false;
+			continue;
+		}
+
+		skb = skb_peek(&c->data_q);
+
+		/* Earliest skb */
+		if (!early_c || skb_get_ktime(skb) < early_time) {
+			early_c = c;
+			early_time = skb_get_ktime(skb);
+		}
+
+		if (bt_cb(skb)->iso.have_seq) {
+			u16 cseq = bt_cb(skb)->iso.seq;
+			int diff = iso_seq_cmp(cseq, seq);
+
+			if (seq_c && diff != 0)
+				ready = false;
+
+			/* Largest seq */
+			if (!seq_c || diff > 0) {
+				seq = cseq;
+				seq_c = c;
+			}
+		} else {
+			ready = false;
+		}
+	}
+
+	if (!early_c) {
+		*res_time = KTIME_MAX;
+		return NULL;
+	}
+
+	/* Group has seq and is ready? */
+	if (ready) {
+		*res_time = early_time;
+
+		/* Need to wait for queue to clear? */
+		if (!same_sent && pkt < max_pkt) {
+			BT_DBG("group %u !same_sent", group_id);
+			return NULL;
+		}
+		if (group_size <= max_pkt && group_size > pkt) {
+			BT_DBG("group %u wait queue", group_id);
+			return NULL;
+		}
+
+		BT_DBG("group %u ready %u", group_id, seq);
+	} else {
+		early_c = NULL;
+		early_time = KTIME_MAX;
+
+		if (seq_c)
+			BT_DBG("group %u seq %u", group_id, seq);
+	}
+
+	list_for_each_entry_rcu(c, &h->list, list) {
+		struct sk_buff *skb;
+
+		if (c->type != ISO_LINK || c->state != BT_CONNECTED)
+			continue;
+		if (iso_group_id(c) != group_id || skb_queue_empty(&c->data_q))
+			continue;
+
+		skb = skb_peek(&c->data_q);
+
+		/* Clear seq */
+		if (ready) {
+			bt_cb(skb)->iso.have_seq = false;
+			skb_set_delivery_time(skb, early_time, true);
+		} else if (bt_cb(skb)->iso.have_seq && seq_c) {
+			u16 cseq = bt_cb(skb)->iso.seq;
+
+			if (cseq != seq)
+				bt_cb(skb)->iso.have_seq = false;
+		}
+
+		/* Conn with earliest non-seq skb */
+		if (!bt_cb(skb)->iso.have_seq) {
+			if (!early_c || skb_get_ktime(skb) < early_time) {
+				early_c = c;
+				early_time = skb_get_ktime(skb);
+			}
+		}
+	}
+
+	*res_time = early_time;
+	return early_c;
+}
+
+static struct hci_conn *hci_low_iso(struct hci_dev *hdev, int pkt, int max_pkt)
+{
+	struct hci_conn_hash *h = &hdev->conn_hash;
+	struct hci_conn *c;
+	unsigned long group_done[BITS_TO_LONGS(0x200)];
+	ktime_t min = KTIME_MAX;
+	struct hci_conn *conn = NULL;
+
+	/* See hci_low_iso_group() for explanation */
+
+	bitmap_zero(group_done, 0x200);
+
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(c, &h->list, list) {
+		struct hci_conn *c2;
+		ktime_t t;
+
+		if (c->type != ISO_LINK || c->state != BT_CONNECTED)
+			continue;
+		if (test_bit(iso_group_id(c), group_done))
+			continue;
+
+		c2 = hci_low_iso_group(hdev, iso_group_id(c), pkt, max_pkt, &t);
+		if (t < min) {
+			conn = c2;
+			min = t;
+		}
+
+		BT_DBG("group %u conn %p", iso_group_id(c), c2);
+
+		set_bit(iso_group_id(c), group_done);
+	}
+
+	rcu_read_unlock();
+
+	BT_DBG("conn %p", conn);
+
+	return conn;
+}
+
 static void hci_link_tx_to(struct hci_dev *hdev, __u8 type)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
@@ -3846,12 +4081,11 @@ static void hci_sched_le(struct hci_dev *hdev)
 		hci_prio_recalculate(hdev, LE_LINK);
 }
 
-/* Schedule CIS */
+/* Schedule CIS/BIS */
 static void hci_sched_iso(struct hci_dev *hdev)
 {
 	struct hci_conn *conn;
-	struct sk_buff *skb;
-	int quote, *cnt;
+	unsigned int max, *cnt;
 
 	BT_DBG("%s", hdev->name);
 
@@ -3860,16 +4094,20 @@ static void hci_sched_iso(struct hci_dev *hdev)
 
 	cnt = hdev->iso_pkts ? &hdev->iso_cnt :
 		hdev->le_pkts ? &hdev->le_cnt : &hdev->acl_cnt;
-	while (*cnt && (conn = hci_low_sent(hdev, ISO_LINK, &quote))) {
-		while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
-			BT_DBG("skb %p len %d", skb, skb->len);
-			hci_send_frame(hdev, skb);
+	max = (cnt == &hdev->iso_cnt) ? hdev->iso_pkts : 0;
 
-			conn->sent++;
-			if (conn->sent == ~0)
-				conn->sent = 0;
-			(*cnt)--;
-		}
+	while (*cnt && (conn = hci_low_iso(hdev, *cnt, max))) {
+		struct sk_buff *skb;
+
+		skb = skb_dequeue(&conn->data_q);
+
+		BT_DBG("skb %p len %d", skb, skb->len);
+		hci_send_frame(hdev, skb);
+
+		conn->sent++;
+		if (conn->sent == ~0)
+			conn->sent = 0;
+		(*cnt)--;
 	}
 }
 
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 04f6572d35f1..58d9ec8ce298 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1240,12 +1240,48 @@ static int iso_sock_getname(struct socket *sock, struct sockaddr *addr,
 	return sizeof(struct sockaddr_iso);
 }
 
+static int iso_cmsg_parse_one(struct cmsghdr *cmsg, struct iso_ctrl *ctrl)
+{
+	switch (cmsg->cmsg_type) {
+	case ISO_CMSG_SEQ:
+		if (cmsg->cmsg_len != CMSG_LEN(sizeof(ctrl->seq)))
+			return -EINVAL;
+
+		memcpy(&ctrl->seq, CMSG_DATA(cmsg), sizeof(ctrl->seq));
+		ctrl->have_seq = true;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int iso_cmsg_parse(struct sock *sk, struct msghdr *msg, struct iso_ctrl *ctrl)
+{
+	struct cmsghdr *cmsg;
+	int err;
+
+	for_each_cmsghdr(cmsg, msg) {
+		if (!CMSG_OK(msg, cmsg))
+			return -EINVAL;
+
+		if (cmsg->cmsg_level != SOL_BLUETOOTH)
+			continue;
+
+		err = iso_cmsg_parse_one(cmsg, ctrl);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
 static int iso_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 			    size_t len)
 {
 	struct sock *sk = sock->sk;
 	struct sk_buff *skb, **frag;
 	size_t mtu;
+	struct iso_ctrl ctrl = {};
 	int err;
 
 	BT_DBG("sock %p, sk %p", sock, sk);
@@ -1257,6 +1293,12 @@ static int iso_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 	if (msg->msg_flags & MSG_OOB)
 		return -EOPNOTSUPP;
 
+	if (msg->msg_controllen) {
+		err = iso_cmsg_parse(sk, msg, &ctrl);
+		if (err < 0)
+			return err;
+	}
+
 	lock_sock(sk);
 
 	if (sk->sk_state != BT_CONNECTED) {
@@ -1274,6 +1316,8 @@ static int iso_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 
 	len -= skb->len;
 
+	bt_cb(skb)->iso = ctrl;
+
 	BT_DBG("skb %p len %d", sk, skb->len);
 
 	/* Continuation fragments */
@@ -1294,6 +1338,8 @@ static int iso_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 		skb->len += tmp->len;
 		skb->data_len += tmp->len;
 
+		bt_cb(tmp)->iso.have_seq = false;
+
 		BT_DBG("frag %p len %d", *frag, tmp->len);
 
 		frag = &(*frag)->next;
-- 
2.43.0

