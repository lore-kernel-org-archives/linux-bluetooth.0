Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61B73DEFF3
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Mar 2026 16:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773245788; cv=pass; b=bV21bzCc+jIqaeTbB+MBECdHC3iv4Rm0IaXMzsNxaT1E78dkn8464Sl6Ok+AUO69efUMcrJJBzeEjFWqAwmTLnUTqO2FQkqqLgU5KgzK+XR1z9bFaPMnkwxaSyjZnYR0uqpUS3RuN4595gVl3Y89peRGHLIrAxuwhA4b2YI7AOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773245788; c=relaxed/simple;
	bh=4/pPvELF3DfD5R2qbLVz47bOxv8PyLce2H1vxXAkMhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KfuSLZWV9PMdWSuQrG8xF6jeNsdEfT/0bfQEpIDXDS/d04+rjokWAhhNgl8XR7Ysc8EYFMd1tD1Z+hovERdXmdeTOGrGdAjg+BppQ+n8fwKvf0DWxbEwMxzQgMMEaaIF7yTfjCQNiWc6jjMn1MauZS8pH4E0w3OeJoTnTKZJHOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=y0SqsIJd; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="y0SqsIJd"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fWG8S1cT0zyVY;
	Wed, 11 Mar 2026 18:16:24 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1773245784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OvdOGguyIkjEQlyxuI0JyDs4Bph26b9gOvXd9RwVxi0=;
	b=y0SqsIJdhjNgMJCRdGbnKXnCIQGPEdCo9HsDrJgmBMFgMuhnYtvNFKczyOJ/3Frit3fF6c
	nT3M7APVu3Lc1UTOZO0ljnpZwnEo5uI3YJWmrqtMx5ZjK9iCw1Mcn8elqEzQ9d3Ast3ZHc
	r3CQsC4k+/VCl5OZ/h1WOuJyefAjcGA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1773245784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OvdOGguyIkjEQlyxuI0JyDs4Bph26b9gOvXd9RwVxi0=;
	b=GJ1/wPNneDmSNJG1k9+TApKi4tZVsgno8xyU5uwhTy5AioRDOW0TnFwyX64ugzHYUdzh1c
	asiTS5DwozRPBj8oCbbSNvnw9Z+wJPaAq+c6sis3RiaWALNdr/3gPmnpOuamRCQi2FSOdm
	tqPKukXxW+vdC2wMlah90zbulkFZaQk=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1773245784;
	b=ogRKF17ZJb0XecgLoneoh3MAysQpFXbvk4wdeNwWpAcEEM8W2vICqz8cOeLg7e0jLnzGXP
	+M/ZD04liU8PppCOEEz6dPd7rOPUd1p5Ic7nh+cL6YUeQTlgi5PR+ynfQ7wNejKfd8nmhC
	lfFH2uMGwz95lbmXI8RbpBxYA3ofTnM=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH BlueZ 2/4] btdev: implement LE Read ISO TX Sync command
Date: Wed, 11 Mar 2026 18:16:18 +0200
Message-ID: <1aca9df696ca4ccf670ea1d49caf7a692b62b67d.1773245672.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773245672.git.pav@iki.fi>
References: <cover.1773245672.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Parse incoming ISO packets and implement LE Read ISO TX Sync.

The timestamps and sequence numbers are just some values; the emulator
does not have real ISOAL or clock, and we don't attempt to add them
here.  The last transmitted numbers are tracked in struct iso_data
attached to each ISO connection.
---
 emulator/btdev.c | 162 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 147 insertions(+), 15 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index d3a9c6735..c5b78a4e9 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -52,10 +52,14 @@
 #define has_bredr(btdev)	(!((btdev)->features[4] & 0x20))
 #define has_le(btdev)		(!!((btdev)->features[4] & 0x40))
 
+#define iso_flags_pb(f)		(f & 0x0003)
+#define iso_flags_ts(f)		((f >> 2) & 0x0001)
+
 #define ACL_HANDLE BIT(0)
 #define SCO_HANDLE BIT(8)
 #define CIS_HANDLE SCO_HANDLE
 #define BIS_HANDLE BIT(9)
+
 #define SYNC_HANDLE 1
 #define INV_HANDLE 0xffff
 
@@ -84,6 +88,14 @@ struct btdev_conn {
 	void *data;
 };
 
+struct iso_data {
+	uint16_t tx_seq;
+	uint32_t tx_timestamp;
+	bool tx_active;
+	uint32_t sdu_interval;
+	struct bt_hci_bis bis;
+};
+
 struct btdev_al {
 	uint8_t type;
 	bdaddr_t addr;
@@ -1165,7 +1177,7 @@ static struct btdev_conn *conn_new(struct btdev *dev, uint16_t handle,
 }
 
 static struct btdev_conn *conn_link(struct btdev *dev, struct btdev *remote,
-					uint16_t handle, uint8_t type)
+		uint16_t handle, uint8_t type, struct btdev_conn **remote_conn)
 {
 	struct btdev_conn *conn1, *conn2;
 
@@ -1187,6 +1199,9 @@ static struct btdev_conn *conn_link(struct btdev *dev, struct btdev *remote,
 	util_debug(dev->debug_callback, dev->debug_data,
 				"conn2 %p handle 0x%04x", conn2, conn2->handle);
 
+	if (remote_conn)
+		*remote_conn = conn2;
+
 	return conn1;
 }
 
@@ -1200,7 +1215,7 @@ static struct btdev_conn *conn_add(struct btdev *dev,
 	if (!remote)
 		return NULL;
 
-	return conn_link(dev, remote, handle, type);
+	return conn_link(dev, remote, handle, type, NULL);
 }
 
 static struct btdev_conn *conn_add_acl(struct btdev *dev,
@@ -1211,24 +1226,40 @@ static struct btdev_conn *conn_add_acl(struct btdev *dev,
 
 static struct btdev_conn *conn_add_sco(struct btdev_conn *acl)
 {
-	return conn_link(acl->dev, acl->link->dev, SCO_HANDLE, HCI_SCODATA_PKT);
+	return conn_link(acl->dev, acl->link->dev, SCO_HANDLE, HCI_SCODATA_PKT,
+									NULL);
 }
 
 static struct btdev_conn *conn_add_cis(struct btdev_conn *acl, uint16_t handle)
 {
-	return conn_link(acl->dev, acl->link->dev, handle, HCI_ISODATA_PKT);
+	struct btdev_conn *conn, *remote;
+
+	conn = conn_link(acl->dev, acl->link->dev, handle, HCI_ISODATA_PKT,
+								&remote);
+	if (!conn)
+		return conn;
+
+	conn->data = new0(struct iso_data, 1);
+	remote->data = new0(struct iso_data, 1);
+
+	return conn;
 }
 
 static struct btdev_conn *conn_add_bis(struct btdev *dev, uint16_t handle,
 						const struct bt_hci_bis *bis)
 {
 	struct btdev_conn *conn;
+	struct iso_data *iso_data;
 
 	conn = conn_new(dev, handle, HCI_ISODATA_PKT);
 	if (!conn)
 		return conn;
 
-	conn->data = util_memdup(bis, sizeof(*bis));
+	iso_data = new0(struct iso_data, 1);
+	iso_data->bis = *bis;
+	iso_data->sdu_interval = get_le24(bis->sdu_interval);
+
+	conn->data = iso_data;
 
 	return conn;
 }
@@ -1261,12 +1292,14 @@ static struct btdev_conn *conn_link_bis(struct btdev *dev, struct btdev *remote,
 {
 	struct btdev_conn *conn;
 	struct btdev_conn *bis;
+	struct iso_data *iso_data;
 
 	bis = find_bis_index(remote, index);
 	if (!bis)
 		return NULL;
 
-	conn = conn_add_bis(dev, BIS_HANDLE, bis->data);
+	iso_data = bis->data;
+	conn = conn_add_bis(dev, BIS_HANDLE, &iso_data->bis);
 	if (!conn)
 		return NULL;
 
@@ -5801,12 +5834,14 @@ static void send_biginfo(struct btdev *dev, const struct btdev *remote,
 	struct bt_hci_evt_le_big_info_adv_report ev;
 	const struct btdev_conn *conn;
 	struct bt_hci_bis *bis;
+	struct iso_data *iso_data;
 
 	conn = find_bis_index(remote, 0);
 	if (!conn)
 		return;
 
-	bis = conn->data;
+	iso_data = conn->data;
+	bis = &iso_data->bis;
 
 	memset(&ev, 0, sizeof(ev));
 	ev.sync_handle = cpu_to_le16(sync_handle);
@@ -6772,8 +6807,43 @@ static int cmd_read_size_v2(struct btdev *dev, const void *data,
 static int cmd_read_iso_tx_sync(struct btdev *dev, const void *data,
 							uint8_t len)
 {
-	/* TODO */
-	return -ENOTSUP;
+	const struct bt_hci_cmd_le_read_iso_tx_sync *cmd = data;
+	struct bt_hci_rsp_le_read_iso_tx_sync rsp;
+	struct btdev_conn *conn;
+	struct iso_data *iso_data;
+
+	memset(&rsp, 0, sizeof(rsp));
+
+	rsp.handle = cmd->handle;
+
+	conn = queue_find(dev->conns, match_handle,
+					UINT_TO_PTR(le16_to_cpu(cmd->handle)));
+	if (!conn || conn->type != HCI_ISODATA_PKT) {
+		rsp.status = BT_HCI_ERR_UNKNOWN_CONN_ID;
+		cmd_complete(dev, BT_HCI_CMD_LE_READ_ISO_TX_SYNC, &rsp,
+								sizeof(rsp));
+		return 0;
+	}
+
+	iso_data = conn->data;
+
+	if (!iso_data->tx_active) {
+		rsp.status = BT_HCI_ERR_COMMAND_DISALLOWED;
+		cmd_complete(dev, BT_HCI_CMD_LE_READ_ISO_TX_SYNC, &rsp,
+								sizeof(rsp));
+		return 0;
+	}
+
+	/* TODO: COMMAND_DISALLOWED if not configured for tx */
+
+	/* TODO: time offset for framed packets */
+	rsp.status = BT_HCI_ERR_SUCCESS;
+	rsp.seq = cpu_to_le16(iso_data->tx_seq);
+	rsp.timestamp = cpu_to_le32(iso_data->tx_timestamp);
+
+	cmd_complete(dev, BT_HCI_CMD_LE_READ_ISO_TX_SYNC, &rsp, sizeof(rsp));
+
+	return 0;
 }
 
 static int find_cig(struct btdev *dev, uint8_t cig_id)
@@ -6977,6 +7047,7 @@ static void le_cis_estabilished(struct btdev *dev, struct btdev_conn *conn,
 {
 	struct bt_hci_evt_le_cis_established evt;
 	int cig_idx, cis_idx = -1;
+	struct iso_data *iso_data = conn->data;
 
 	memset(&evt, 0, sizeof(evt));
 
@@ -7017,6 +7088,8 @@ static void le_cis_estabilished(struct btdev *dev, struct btdev_conn *conn,
 				le_cig->params.c_interval), evt.c_latency);
 		put_le24(le_cis_latecy(evt.p_ft, evt.interval,
 				le_cig->params.p_interval), evt.p_latency);
+
+		iso_data->sdu_interval = get_le24(le_cig->params.c_interval);
 	}
 
 	le_meta_event(dev, BT_HCI_EVT_LE_CIS_ESTABLISHED, &evt, sizeof(evt));
@@ -7038,6 +7111,7 @@ static int cmd_create_cis_complete(struct btdev *dev, const void *data,
 		struct btdev_conn *iso;
 		struct bt_hci_evt_le_cis_req evt;
 		struct le_cig *le_cig;
+		struct iso_data *iso_data;
 		int cig_idx, cis_idx;
 
 		cig_idx = parse_cis_handle(le16_to_cpu(cis->cis_handle),
@@ -7073,6 +7147,9 @@ static int cmd_create_cis_complete(struct btdev *dev, const void *data,
 		evt.cig_id = le_cig->params.cig_id;
 		evt.cis_id = le_cig->cis[cis_idx].cis_id;
 
+		iso_data = iso->data;
+		iso_data->sdu_interval = get_le24(le_cig->params.c_interval);
+
 		le_cig->activated = true;
 
 		le_meta_event(iso->link->dev, BT_HCI_EVT_LE_CIS_REQ, &evt,
@@ -7417,6 +7494,7 @@ static int cmd_big_create_sync_complete(struct btdev *dev, const void *data,
 	} pdu;
 	struct btdev *remote;
 	struct btdev_conn *conn = NULL;
+	struct iso_data *iso_data;
 	struct bt_hci_bis *bis;
 	int i;
 	uint16_t sync_handle = le16_to_cpu(cmd->sync_handle);
@@ -7468,7 +7546,8 @@ static int cmd_big_create_sync_complete(struct btdev *dev, const void *data,
 		return 0;
 	}
 
-	bis = conn->data;
+	iso_data = conn->data;
+	bis = &iso_data->bis;
 
 	if (bis->encryption != cmd->encryption) {
 		pdu.ev.status = BT_HCI_ERR_ENC_MODE_NOT_ACCEPTABLE;
@@ -8611,18 +8690,38 @@ static void send_sco(struct btdev *dev, const void *data, uint16_t len)
 
 static void send_iso(struct btdev *dev, const void *data, uint16_t len)
 {
-	struct bt_hci_acl_hdr *hdr;
 	struct iovec iov[2];
-	struct btdev_conn *conn;
 	uint8_t pkt_type = BT_H4_ISO_PKT;
 
 	/* Packet type */
 	iov[0].iov_base = &pkt_type;
 	iov[0].iov_len = sizeof(pkt_type);
 
-	iov[1].iov_base = hdr = (void *) (data);
+	iov[1].iov_base = (void *) data;
 	iov[1].iov_len = len;
 
+	send_packet(dev, iov, 2);
+}
+
+static void process_iso(struct btdev *dev, const void *data, uint16_t len)
+{
+	struct iovec in;
+	struct btdev_conn *conn;
+	struct bt_hci_iso_hdr *hdr;
+	struct iso_data *tx_iso_data;
+	uint8_t pb;
+	bool ts;
+
+	in.iov_base = (void *) data;
+	in.iov_len = len;
+
+	hdr = util_iov_pull_mem(&in, sizeof(*hdr));
+	if (!hdr)
+		return;
+
+	pb = iso_flags_pb(acl_flags(hdr->handle));
+	ts = iso_flags_ts(acl_flags(hdr->handle));
+
 	conn = queue_find(dev->conns, match_handle,
 					UINT_TO_PTR(acl_handle(hdr->handle)));
 	if (!conn)
@@ -8630,8 +8729,41 @@ static void send_iso(struct btdev *dev, const void *data, uint16_t len)
 
 	num_completed_packets(dev, conn);
 
+	tx_iso_data = conn->data;
+
+	if (!(pb & 0x1)) {
+		struct bt_hci_iso_data_start *h;
+		uint32_t timestamp = 0;
+
+		if (ts) {
+			void *t;
+
+			t = util_iov_pull_mem(&in, sizeof(uint32_t));
+			if (!t)
+				return;
+
+			timestamp = get_le32(t);
+		}
+
+		h = util_iov_pull_mem(&in, sizeof(*h));
+		if (!h)
+			return;
+
+		/* TODO: use proper numbers here */
+		if (ts)
+			tx_iso_data->tx_timestamp = timestamp;
+
+		tx_iso_data->tx_active = true;
+		tx_iso_data->tx_seq++;
+		tx_iso_data->tx_timestamp += tx_iso_data->sdu_interval;
+
+		util_debug(dev->debug_callback, dev->debug_data,
+				"ISO tx %u %u",
+				tx_iso_data->tx_seq, tx_iso_data->tx_timestamp);
+	}
+
 	if (conn->link)
-		send_packet(conn->link->dev, iov, 2);
+		send_iso(conn->link->dev, data, len);
 }
 
 void btdev_receive_h4(struct btdev *btdev, const void *data, uint16_t len)
@@ -8660,7 +8792,7 @@ void btdev_receive_h4(struct btdev *btdev, const void *data, uint16_t len)
 		send_sco(btdev, data + 1, len - 1);
 		break;
 	case BT_H4_ISO_PKT:
-		send_iso(btdev, data + 1, len - 1);
+		process_iso(btdev, data + 1, len - 1);
 		break;
 	default:
 		util_debug(btdev->debug_callback, btdev->debug_data,
-- 
2.53.0

