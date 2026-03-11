Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC063E0C52
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Mar 2026 16:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773245778; cv=pass; b=JvEhYUeVzxFyAzEYgM1a+jZAUKZtb4WF+GuOwsIZkhdQDvkRlSLCBpQMSr2whyggD+EhG0O27rCx6ZIsT0MQ3WEf+NhiXUFhQqwXOGEdEmfJnMKOawhj1B1gQFLC5hmEtnYv6RoyTzDa/D0V0X7hfQsZDhvYgiDPKPvSLIZ22w0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773245778; c=relaxed/simple;
	bh=QTGHL/nK9tfh5kEvhcZfQjl7FyKJvydf5rjyoMs7hgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BE8uyIgTvedUDS1QZcFYieaIYfJDRoP0dOz7W440xn+WevvRB8JBvdIBNSHB0SLkw5uNjzfODD+k58/b7RLotkFG661retYd0KbUe6+eIWdyIZSNz36zbE8QqdVoY2qqSe+Y4abHNs55FowJwHLycBUm+EE+5CpBVv/lSHOcdCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=VSlc8K0c; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="VSlc8K0c"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fWG880Z3zzyw0;
	Wed, 11 Mar 2026 18:16:08 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1773245768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5S5Qqe2q14l/JMcI6/IVoioLUvy7CQ38C/DQtmiPGO4=;
	b=VSlc8K0cftI5i3jxYqo2FZ1nuVPI1XlT2IDCk37BcPytadh3Z3TpVezkwL5L742jgi//I/
	zkj9pnTjpw4uWAvRZ5PyexkG1I+l4ANStQqMHhK62wOopP5u5wvGNOMiQuaQKRi+ZTXNHM
	hv+sBb//hkPlc2J8/A/5XPgv2xuSte0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1773245768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5S5Qqe2q14l/JMcI6/IVoioLUvy7CQ38C/DQtmiPGO4=;
	b=eiWVYKxn2BjMxad47wt6ik4OkMehyOYHKW2cPE5wLZEsZxfVBtDaeyAGDdZVsBcpDG8aVb
	w1I2svKCrOfftf5XD4qKDXfzErF7a7fVjFeqzG9ztqU6WDXssKDfhHayJNkW9cqk5EPxG9
	djQsvFwOwkrno8vH/FkKx7J/RWA7DmI=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1773245768;
	b=xd0wUcBa+H8rrKP1I+0HAm2AMG3HhgF4sP0uooFX6oxhpZarC2JGFBgDuxfeHJbSxl138Q
	LJfUDT0qjVojY4Z09kDZhsNOFLfMsnPQo8uudL4nWhQ52Siu2Oyb8MccrIb8h3nbAn9Ecj
	ko/kcXSeqmfEdBCLgK6bh8WEpVzRic0=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH 2/2] Bluetooth: produce HW TX timestamps for ISO from LE Read ISO TX Sync
Date: Wed, 11 Mar 2026 18:15:51 +0200
Message-ID: <1a4411e9ac1d6b5daa53aac78ca495c2db1b18a4.1773245666.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773245666.git.pav@iki.fi>
References: <cover.1773245666.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For ISO packets with HW TX timestamping enabled, retrieve ISO send
timestamps via LE Read ISO TX Sync. Specification allows retrieving the
timestamp only for the "latest" sent packet.

Report SDU Reference time as the timestamp, as this is the value
relevant for userspace send synchronization.

Due to overall poor description of the timing features in ISO-over-HCI
transport in Core Specification v6.2, it is ambiguous what packet the
command actually reports, so timestamps may not be assigned to the
exactly correct packets, user applications have to deal with it.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 include/net/bluetooth/hci.h      |  2 +-
 include/net/bluetooth/hci_core.h |  3 +-
 net/bluetooth/hci_conn.c         | 53 +++++++++++++++++++--
 net/bluetooth/hci_event.c        | 79 +++++++++++++++++++++++++++++++-
 4 files changed, 131 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 89ad9470fa71..b536587a909f 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -2138,7 +2138,7 @@ struct hci_rp_le_read_iso_tx_sync {
 	__u8    status;
 	__le16  handle;
 	__le16  seq;
-	__le32  imestamp;
+	__le32  timestamp;
 	__u8    offset[3];
 } __packed;
 
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index c82cec45a9a1..5d530349c2a4 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -272,6 +272,7 @@ struct adv_info {
 
 struct tx_queue {
 	struct sk_buff_head queue;
+	struct sk_buff *iso_last_tx;
 	unsigned int extra;
 	unsigned int tracked;
 };
@@ -1630,7 +1631,7 @@ void hci_conn_failed(struct hci_conn *conn, u8 status);
 u8 hci_conn_set_handle(struct hci_conn *conn, u16 handle);
 
 void hci_conn_tx_queue(struct hci_conn *conn, struct sk_buff *skb);
-void hci_conn_tx_dequeue(struct hci_conn *conn);
+void hci_conn_tx_dequeue(struct hci_conn *conn, bool last);
 void hci_setup_tx_timestamp(struct sk_buff *skb, size_t key_offset,
 			    const struct sockcm_cookie *sockc);
 
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index a47f5daffdbf..342747a7c225 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1232,6 +1232,9 @@ void hci_conn_del(struct hci_conn *conn)
 	skb_queue_purge(&conn->data_q);
 	skb_queue_purge(&conn->tx_q.queue);
 
+	kfree_skb(conn->tx_q.iso_last_tx);
+	conn->tx_q.iso_last_tx = NULL;
+
 	/* Remove the connection from the list and cleanup its remaining
 	 * state. This is a separate function since for some cases like
 	 * BT_CONNECT_SCAN we *only* want the cleanup part without the
@@ -2388,6 +2391,20 @@ struct hci_conn *hci_connect_cis(struct hci_dev *hdev, bdaddr_t *dst,
 	return cis;
 }
 
+static int hci_conn_le_read_iso_tx_sync(struct hci_conn *conn)
+{
+	struct hci_cp_le_read_iso_tx_sync cp;
+
+	if (!(conn->hdev->commands[41] & 0x40))
+		return -EOPNOTSUPP;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.handle = cpu_to_le16(conn->handle);
+
+	return hci_send_cmd(conn->hdev, HCI_OP_LE_READ_ISO_TX_SYNC,
+			    sizeof(cp), &cp);
+}
+
 /* Check link security requirement */
 int hci_conn_check_link_mode(struct hci_conn *conn)
 {
@@ -3156,6 +3173,18 @@ void hci_conn_tx_queue(struct hci_conn *conn, struct sk_buff *skb)
 	struct tx_queue *comp = &conn->tx_q;
 	bool track = false;
 
+	/* Check for HW timestamping */
+	switch (conn->type) {
+	case CIS_LINK:
+	case BIS_LINK:
+		if (skb->sk &&
+		    (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP_NOBPF)) {
+			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
+			track = true;
+		}
+		break;
+	}
+
 	/* Emit SND now, ie. just before sending to driver */
 	if (skb_shinfo(skb)->tx_flags & SKBTX_SW_TSTAMP)
 		__skb_tstamp_tx(skb, NULL, NULL, skb->sk, SCM_TSTAMP_SND);
@@ -3214,7 +3243,7 @@ void hci_conn_tx_queue(struct hci_conn *conn, struct sk_buff *skb)
 	skb_queue_purge(&comp->queue);
 }
 
-void hci_conn_tx_dequeue(struct hci_conn *conn)
+void hci_conn_tx_dequeue(struct hci_conn *conn, bool last)
 {
 	struct tx_queue *comp = &conn->tx_q;
 	struct sk_buff *skb;
@@ -3234,8 +3263,24 @@ void hci_conn_tx_dequeue(struct hci_conn *conn)
 
 	if (skb->sk) {
 		comp->tracked--;
-		__skb_tstamp_tx(skb, NULL, NULL, skb->sk,
-				SCM_TSTAMP_COMPLETION);
+
+		if (skb_shinfo(skb)->tx_flags & SKBTX_COMPLETION_TSTAMP)
+			__skb_tstamp_tx(skb, NULL, NULL, skb->sk,
+					SCM_TSTAMP_COMPLETION);
+
+		switch (conn->type) {
+		case CIS_LINK:
+		case BIS_LINK:
+			if (!last)
+				break;
+			if (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP_NOBPF) {
+				kfree_skb(conn->tx_q.iso_last_tx);
+				conn->tx_q.iso_last_tx = skb;
+				hci_conn_le_read_iso_tx_sync(conn);
+				return;
+			}
+			break;
+		}
 	}
 
 	kfree_skb(skb);
@@ -3283,6 +3328,8 @@ int hci_ethtool_ts_info(unsigned int index, int sk_proto,
 
 	switch (sk_proto) {
 	case BTPROTO_ISO:
+		info->so_timestamping |= SOF_TIMESTAMPING_TX_HARDWARE;
+		fallthrough;
 	case BTPROTO_L2CAP:
 		info->so_timestamping |= SOF_TIMESTAMPING_TX_SOFTWARE;
 		info->so_timestamping |= SOF_TIMESTAMPING_TX_COMPLETION;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 286529d2e554..f2aade36a39e 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3777,6 +3777,81 @@ static inline void handle_cmd_cnt_and_timer(struct hci_dev *hdev, u8 ncmd)
 	rcu_read_unlock();
 }
 
+static u8 hci_cc_le_read_iso_tx_sync(struct hci_dev *hdev, void *data,
+				     struct sk_buff *skb)
+{
+	struct hci_rp_le_read_iso_tx_sync *rp = data;
+	struct skb_shared_hwtstamps ssh;
+	struct hci_conn *conn;
+	u32 offset;
+
+	bt_dev_dbg(hdev, "status 0x%2.2x", rp->status);
+
+	if (rp->status)
+		return rp->status;
+
+	offset = rp->offset[0] | (rp->offset[1] << 8) | (rp->offset[2] << 16);
+	bt_dev_dbg(hdev, "ts %u to %u", __le32_to_cpu(rp->timestamp), offset);
+
+	hci_dev_lock(hdev);
+
+	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(rp->handle));
+	if (!conn)
+		goto unlock;
+
+	if (!conn->tx_q.iso_last_tx)
+		goto unlock;
+
+	/* Report SDU synchronization reference as the timestamp. This value is
+	 * most useful for userspace, as it is the Time_Stamp field in sent
+	 * packets. See Fig. 3.1 and 3.2 in Core v6.2 Vol 6 Part G Sec. 3.
+	 *
+	 * Unfortunately, the ISO-over-HCI transport is poorly described in the
+	 * specification.
+	 *
+	 * The HCI specification contradicts itself which packet timestamp is
+	 * reported by Le Read ISO TX Sync: "scheduled for transmission" in Core
+	 * v6.2 Vol 4 Part E Sec 4.7 vs. "transmitted" in Sec. 7.8.96.
+	 * The specification is also unclear on what these words mean.
+	 *
+	 * We assume here it means "transmitted", and additionally that
+	 * "transmitted" means the last packet reported in Number of Completed
+	 * Packets.
+	 *
+	 * The specification is also unclear what sequence number is returned by
+	 * this command. We assume it is a sequence number assigned by the
+	 * controller. These are equivalent to the controller clock, so they are
+	 * useless for generic Host (which we are) with no direct access to
+	 * controller clock.
+	 *
+	 * Userspace application that handle these timestamps must then be
+	 * prepared that the ISO timestamp is reported on the wrong packet
+	 * depending on controller. Actual packet TX must rely on backpressure
+	 * (monitoring packet completion via COMPLETION tstamp), and the
+	 * timestamps are useful only for aligning the playback of multiple ISO
+	 * streams.
+	 */
+
+	memset(&ssh, 0, sizeof(ssh));
+
+	/* SDU Reference = BIG/CIG Reference - Time_Offset */
+	ssh.hwtstamp = us_to_ktime(__le32_to_cpu(rp->timestamp) - offset);
+
+	/* The value may be 0, but skb_tstamp_tx() does not allow reporting zero
+	 * HW timestamp. Offset by 1 ns as a workaround.
+	 */
+	ssh.hwtstamp += 1;
+
+	skb_tstamp_tx(conn->tx_q.iso_last_tx, &ssh);
+
+	kfree_skb(conn->tx_q.iso_last_tx);
+	conn->tx_q.iso_last_tx = NULL;
+
+unlock:
+	hci_dev_unlock(hdev);
+	return rp->status;
+}
+
 static u8 hci_cc_le_read_buffer_size_v2(struct hci_dev *hdev, void *data,
 					struct sk_buff *skb)
 {
@@ -4224,6 +4299,8 @@ static const struct hci_cc {
 	HCI_CC(HCI_OP_LE_READ_TRANSMIT_POWER, hci_cc_le_read_transmit_power,
 	       sizeof(struct hci_rp_le_read_transmit_power)),
 	HCI_CC_STATUS(HCI_OP_LE_SET_PRIVACY_MODE, hci_cc_le_set_privacy_mode),
+	HCI_CC(HCI_OP_LE_READ_ISO_TX_SYNC, hci_cc_le_read_iso_tx_sync,
+	       sizeof(struct hci_rp_le_read_iso_tx_sync)),
 	HCI_CC(HCI_OP_LE_READ_BUFFER_SIZE_V2, hci_cc_le_read_buffer_size_v2,
 	       sizeof(struct hci_rp_le_read_buffer_size_v2)),
 	HCI_CC_VL(HCI_OP_LE_SET_CIG_PARAMS, hci_cc_le_set_cig_params,
@@ -4509,7 +4586,7 @@ static void hci_num_comp_pkts_evt(struct hci_dev *hdev, void *data,
 		}
 
 		for (i = 0; i < count; ++i)
-			hci_conn_tx_dequeue(conn);
+			hci_conn_tx_dequeue(conn, (i == count - 1));
 
 		switch (conn->type) {
 		case ACL_LINK:
-- 
2.53.0

