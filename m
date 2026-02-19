Received: from mail-vk1-f195.google.com (mail-vk1-f195.google.com [209.85.221.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C366D345CD9
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 16:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771518170; cv=none; b=OLj4jTGxWzDz3tZifAVKT5V+9+tSOKJOgoKZ+/uglLEiJ+Hykv3DX6gUPDJc0ynCYpdeolpEBN8xHuT7pmRB/vlelMPmU4Fs0XONSmNxV+f5jcgrafc/vx5wnaTKDWxlAIBv6fH8RlPZNqnjaK28lJLTyQ2jJ9HCJTN2XfoVJkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771518170; c=relaxed/simple;
	bh=vwSVyKrm1S3cImEjxyS+0Lzvxz2Gcz3bPnd/wChzCKo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X5PyJ3lJCKtDKBdB/9VAXCgAIAL7opgVZtp9XCsGPbMr7bAfOYZy1cyUZijZZ4owRWmeSrMcFtUZHLl88Ti3postpGKk7Ta04k5TWMnliGtQao8ASlX8Vv1CLOEDO0LiLoAOMS3hhexcVTxH5gavMBbEKSZ6LFd+PIJGM0f1jU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ihampDLU; arc=none smtp.client-ip=209.85.221.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihampDLU"
Received: by mail-vk1-f195.google.com with SMTP id 71dfb90a1353d-5673891928cso555608e0c.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 08:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771518167; x=1772122967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+dEW+DH4tW8V4LkU7Pun4JiyvlXapof8twkYuk8NcHc=;
        b=ihampDLULXZCyMNnm57gOg1M/QBgnXUnQLrf1Psh96iOJX/zbTotRVq/aTpnpuUJrR
         jJTluRVva1kKo0uC9O4Ykav77pzb2PTFBW95H3kAhEFUJk6WV9d90fCY2NXQCWObZmAy
         7UnEUpILe8XdARAWRkDosJ1xVX3tVpdQCQ38LprcRl/PS38eH9ss0mtc7gyuvOcyDzUH
         kaNmsrUbOEM6EVs9CsQZntLDKPCeTShnKQWRsPKEp8qu+cnC7wYgqB4uM5HsY8xdKF88
         ljVGnyCsR7detTYplVa5jcKu2ai511SKY0sJSSX7DwWmSZX3161iPfN8tXsnyWstuYn0
         zYSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771518167; x=1772122967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+dEW+DH4tW8V4LkU7Pun4JiyvlXapof8twkYuk8NcHc=;
        b=ZqwxvXY6gPl+FSydgZB2lViLpPFKTsLwcZ6j1w9PYLNJ7RTO3ozqxQHbgxgga2G5VF
         5TN5IBXVY2O/3sroweqUNV3OUOHjCx/Sh3GDjaPyc4Rdg8zJ3eHt8rMOoVBTEy0yRUla
         q2yI5HkI2kUYSCxenQspwfokX0vvJ2gFTz3iafIee2BKgouUOU+hLKuwaj995HDpN4Sm
         fJVuajDcupwo2PqiSwGwRr1waxYA2FQR9vnw3hRqyGKwJ0Y4/kxT7JbN7uOHQPwl0p2a
         am+oUgYCebh1KddRpj8s6oXgpHRxJddfL0c+HPIZwyk4rT4A49f9SHaIJ1t8+jM5Zpok
         f45Q==
X-Gm-Message-State: AOJu0YyN/I/4anwhtxzHRPISimpBNJ1Ri6HC/ITSMD+p61R4aaC1PFPC
	mpitJ+cFfFpph0+bUhbO3xdcV2h8NdvR/0m0SJTxiTlDVyaRLN0lNzRzc/s7oz34
X-Gm-Gg: AZuq6aJFMmd48oOpTmSun2rCbz17L9UlSlbFhUCdQlOk22u4I2PsK4b307vv5r+vxUX
	2EqsdGOm2HnK4G3pySplcn2XePkXTchZsQTUDU8xkQ2qK15nGbrd/mU0uslzpHZ3aKS0y/355Kq
	ZwsNJSFa9vV4iVoyqZYyXO3DtuhNxEm2ZV+wBOTQA8Jk+xmySKcFH0+bcE7aPkw4DaQgWK+71XY
	ULOQQXxHslvJ26i1iiq59wAAWQS+NtEuVrCgLAtTidNsqlBgrsEqZO8PxD4He5hz7GqE9pgoHqk
	DrLWfW81HdeAJzwSygVVraJ1Q5zILGXHZecb1a9B0/aM5xY+fUsCCHNEmxG59KsyzEQ6EEXTTDh
	NpZW6ATCfAoaxLzOiq2M22m8dKADDE1TLVxpZkv1v91xqXORc/EksdbQSLgvbXGihNLcCi6eoZp
	yIB6BTDgslJYJwZl6ZBZWqoDHwXHHkCShcRJLpF/WWNsGKfRS/xplb57cXV5ttGui/1Le4gPNop
	dNlIjHT/C912eqvKg==
X-Received: by 2002:a05:6123:10e:b0:566:29a6:1010 with SMTP id 71dfb90a1353d-56889b787c2mr6037260e0c.7.1771518167321;
        Thu, 19 Feb 2026 08:22:47 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5674c20a659sm14435235e0c.11.2026.02.19.08.22.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 08:22:46 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 8/8] monitor: Add connection lifecycle to analyze summary
Date: Thu, 19 Feb 2026 11:22:30 -0500
Message-ID: <20260219162230.3074355-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260219162230.3074355-1-luiz.dentz@gmail.com>
References: <20260219162230.3074355-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Record the frame number at connection and disconnection time for each
connection. Print the connected and disconnected frame numbers in the
per-connection summary produced by analyze mode so that users can
cross-reference with the btmon trace output:

  Found LE-ACL connection with handle 2051
        Address: 66:B0:26:F1:D3:BC (Resolvable)
        RX packets: 48/48
        RX Latency: 1-7604 msec (~74 msec)
        RX size: 5-51 octets (~13 octets)
        RX speed: ~0 Kb/s
        TX packets: 39/37
        TX Latency: 12-426 msec (~43 msec)
        TX size: 5-97 octets (~15 octets)
        TX speed: ~1 Kb/s
        Connected: #52044
        Disconnected: #53069
        Disconnect Reason: 0x08

Also fix the TODO in conn_destroy() that was passing a hardcoded 0x00
address type by using the stored bdaddr_type from the LE connection
complete events.
---
 monitor/analyze.c | 73 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 59 insertions(+), 14 deletions(-)

diff --git a/monitor/analyze.c b/monitor/analyze.c
index 2cf42f903b61..1db1e7898132 100644
--- a/monitor/analyze.c
+++ b/monitor/analyze.c
@@ -68,8 +68,12 @@ struct hci_conn {
 	uint16_t link;
 	uint8_t type;
 	uint8_t bdaddr[6];
+	uint8_t bdaddr_type;
 	bool setup_seen;
 	bool terminated;
+	uint8_t disconnect_reason;
+	unsigned long frame_connected;
+	unsigned long frame_disconnected;
 	struct queue *tx_queue;
 	struct timeval last_rx;
 	struct queue *chan_list;
@@ -241,13 +245,22 @@ static void conn_destroy(void *data)
 	}
 
 	printf("  Found %s connection with handle %u\n", str, conn->handle);
-	/* TODO: Store address type */
-	packet_print_addr("Address", conn->bdaddr, 0x00);
+	packet_print_addr("Address", conn->bdaddr, conn->bdaddr_type);
 	if (!conn->setup_seen)
 		print_field("Connection setup missing");
 	print_stats(&conn->rx, "RX");
 	print_stats(&conn->tx, "TX");
 
+	if (conn->setup_seen) {
+		print_field("Connected: #%lu", conn->frame_connected);
+		if (conn->terminated) {
+			print_field("Disconnected: #%lu",
+					conn->frame_disconnected);
+			print_field("Disconnect Reason: 0x%02x",
+						conn->disconnect_reason);
+		}
+	}
+
 	queue_destroy(conn->rx.plot, free);
 	queue_destroy(conn->tx.plot, free);
 	queue_destroy(conn->chan_list, chan_destroy);
@@ -465,6 +478,7 @@ static void command_pkt(struct timeval *tv, uint16_t index,
 }
 
 static void evt_conn_complete(struct hci_dev *dev, struct timeval *tv,
+					unsigned long frame,
 					const void *data, uint16_t size)
 {
 	const struct bt_hci_evt_conn_complete *evt = data;
@@ -478,10 +492,12 @@ static void evt_conn_complete(struct hci_dev *dev, struct timeval *tv,
 		return;
 
 	memcpy(conn->bdaddr, evt->bdaddr, 6);
+	conn->frame_connected = frame;
 	conn->setup_seen = true;
 }
 
 static void evt_disconnect_complete(struct hci_dev *dev, struct timeval *tv,
+					unsigned long frame,
 					const void *data, uint16_t size)
 {
 	const struct bt_hci_evt_disconnect_complete *evt = data;
@@ -494,6 +510,8 @@ static void evt_disconnect_complete(struct hci_dev *dev, struct timeval *tv,
 	if (!conn)
 		return;
 
+	conn->frame_disconnected = frame;
+	conn->disconnect_reason = evt->reason;
 	conn->terminated = true;
 }
 
@@ -555,6 +573,7 @@ static void plot_add(struct queue *queue, struct timeval *latency,
 }
 
 static void evt_le_conn_complete(struct hci_dev *dev, struct timeval *tv,
+					unsigned long frame,
 					struct iovec *iov)
 {
 	const struct bt_hci_evt_le_conn_complete *evt;
@@ -569,10 +588,13 @@ static void evt_le_conn_complete(struct hci_dev *dev, struct timeval *tv,
 		return;
 
 	memcpy(conn->bdaddr, evt->peer_addr, 6);
+	conn->bdaddr_type = evt->peer_addr_type;
+	conn->frame_connected = frame;
 	conn->setup_seen = true;
 }
 
 static void evt_le_enh_conn_complete(struct hci_dev *dev, struct timeval *tv,
+					unsigned long frame,
 					struct iovec *iov)
 {
 	const struct bt_hci_evt_le_enhanced_conn_complete *evt;
@@ -587,6 +609,8 @@ static void evt_le_enh_conn_complete(struct hci_dev *dev, struct timeval *tv,
 		return;
 
 	memcpy(conn->bdaddr, evt->peer_addr, 6);
+	conn->bdaddr_type = evt->peer_addr_type;
+	conn->frame_connected = frame;
 	conn->setup_seen = true;
 }
 
@@ -640,6 +664,7 @@ static void evt_num_completed_packets(struct hci_dev *dev, struct timeval *tv,
 }
 
 static void evt_sync_conn_complete(struct hci_dev *dev, struct timeval *tv,
+					unsigned long frame,
 					const void *data, uint16_t size)
 {
 	const struct bt_hci_evt_sync_conn_complete *evt = data;
@@ -653,10 +678,12 @@ static void evt_sync_conn_complete(struct hci_dev *dev, struct timeval *tv,
 		return;
 
 	memcpy(conn->bdaddr, evt->bdaddr, 6);
+	conn->frame_connected = frame;
 	conn->setup_seen = true;
 }
 
 static void evt_le_cis_established(struct hci_dev *dev, struct timeval *tv,
+					unsigned long frame,
 					struct iovec *iov)
 {
 	const struct bt_hci_evt_le_cis_established *evt;
@@ -671,6 +698,7 @@ static void evt_le_cis_established(struct hci_dev *dev, struct timeval *tv,
 	if (!conn)
 		return;
 
+	conn->frame_connected = frame;
 	conn->setup_seen = true;
 
 	link = link_lookup(dev, conn->handle);
@@ -696,6 +724,7 @@ static void evt_le_cis_req(struct hci_dev *dev, struct timeval *tv,
 }
 
 static void evt_le_big_complete(struct hci_dev *dev, struct timeval *tv,
+					unsigned long frame,
 					struct iovec *iov)
 {
 	const struct bt_hci_evt_le_big_complete *evt;
@@ -713,12 +742,15 @@ static void evt_le_big_complete(struct hci_dev *dev, struct timeval *tv,
 			return;
 
 		conn = conn_lookup_type(dev, handle, BTMON_CONN_BIS);
-		if (conn)
+		if (conn) {
 			conn->setup_seen = true;
+			conn->frame_connected = frame;
+		}
 	}
 }
 
 static void evt_le_big_sync_established(struct hci_dev *dev, struct timeval *tv,
+					unsigned long frame,
 					struct iovec *iov)
 {
 	const struct bt_hci_evt_le_big_sync_estabilished *evt;
@@ -736,12 +768,15 @@ static void evt_le_big_sync_established(struct hci_dev *dev, struct timeval *tv,
 			return;
 
 		conn = conn_lookup_type(dev, handle, BTMON_CONN_BIS);
-		if (conn)
+		if (conn) {
 			conn->setup_seen = true;
+			conn->frame_connected = frame;
+		}
 	}
 }
 
 static void evt_le_meta_event(struct hci_dev *dev, struct timeval *tv,
+					unsigned long frame,
 					const void *data, uint16_t size)
 {
 	struct iovec iov = {
@@ -755,27 +790,28 @@ static void evt_le_meta_event(struct hci_dev *dev, struct timeval *tv,
 
 	switch (subevt) {
 	case BT_HCI_EVT_LE_CONN_COMPLETE:
-		evt_le_conn_complete(dev, tv, &iov);
+		evt_le_conn_complete(dev, tv, frame, &iov);
 		break;
 	case BT_HCI_EVT_LE_ENHANCED_CONN_COMPLETE:
-		evt_le_enh_conn_complete(dev, tv, &iov);
+		evt_le_enh_conn_complete(dev, tv, frame, &iov);
 		break;
 	case BT_HCI_EVT_LE_CIS_ESTABLISHED:
-		evt_le_cis_established(dev, tv, &iov);
+		evt_le_cis_established(dev, tv, frame, &iov);
 		break;
 	case BT_HCI_EVT_LE_CIS_REQ:
 		evt_le_cis_req(dev, tv, &iov);
 		break;
 	case BT_HCI_EVT_LE_BIG_COMPLETE:
-		evt_le_big_complete(dev, tv, &iov);
+		evt_le_big_complete(dev, tv, frame, &iov);
 		break;
 	case BT_HCI_EVT_LE_BIG_SYNC_ESTABILISHED:
-		evt_le_big_sync_established(dev, tv, &iov);
+		evt_le_big_sync_established(dev, tv, frame, &iov);
 		break;
 	}
 }
 
 static void event_pkt(struct timeval *tv, uint16_t index,
+					unsigned long frame,
 					const void *data, uint16_t size)
 {
 	const struct bt_hci_evt_hdr *hdr = data;
@@ -793,10 +829,10 @@ static void event_pkt(struct timeval *tv, uint16_t index,
 
 	switch (hdr->evt) {
 	case BT_HCI_EVT_CONN_COMPLETE:
-		evt_conn_complete(dev, tv, data, size);
+		evt_conn_complete(dev, tv, frame, data, size);
 		break;
 	case BT_HCI_EVT_DISCONNECT_COMPLETE:
-		evt_disconnect_complete(dev, tv, data, size);
+		evt_disconnect_complete(dev, tv, frame, data, size);
 		break;
 	case BT_HCI_EVT_CMD_COMPLETE:
 		evt_cmd_complete(dev, tv, data, size);
@@ -805,10 +841,10 @@ static void event_pkt(struct timeval *tv, uint16_t index,
 		evt_num_completed_packets(dev, tv, data, size);
 		break;
 	case BT_HCI_EVT_SYNC_CONN_COMPLETE:
-		evt_sync_conn_complete(dev, tv, data, size);
+		evt_sync_conn_complete(dev, tv, frame, data, size);
 		break;
 	case BT_HCI_EVT_LE_META_EVENT:
-		evt_le_meta_event(dev, tv, data, size);
+		evt_le_meta_event(dev, tv, frame, data, size);
 		break;
 	}
 }
@@ -1047,6 +1083,7 @@ void analyze_trace(const char *path)
 {
 	struct btsnoop *btsnoop_file;
 	unsigned long num_packets = 0;
+	unsigned long num_frames = 0;
 	uint32_t format;
 
 	btsnoop_file = btsnoop_open(path, BTSNOOP_FLAG_PKLG_SUPPORT);
@@ -1084,21 +1121,27 @@ void analyze_trace(const char *path)
 			del_index(&tv, index, buf, pktlen);
 			break;
 		case BTSNOOP_OPCODE_COMMAND_PKT:
+			num_frames++;
 			command_pkt(&tv, index, buf, pktlen);
 			break;
 		case BTSNOOP_OPCODE_EVENT_PKT:
-			event_pkt(&tv, index, buf, pktlen);
+			num_frames++;
+			event_pkt(&tv, index, num_frames, buf, pktlen);
 			break;
 		case BTSNOOP_OPCODE_ACL_TX_PKT:
+			num_frames++;
 			acl_pkt(&tv, index, true, buf, pktlen);
 			break;
 		case BTSNOOP_OPCODE_ACL_RX_PKT:
+			num_frames++;
 			acl_pkt(&tv, index, false, buf, pktlen);
 			break;
 		case BTSNOOP_OPCODE_SCO_TX_PKT:
+			num_frames++;
 			sco_pkt(&tv, index, true, buf, pktlen);
 			break;
 		case BTSNOOP_OPCODE_SCO_RX_PKT:
+			num_frames++;
 			sco_pkt(&tv, index, false, buf, pktlen);
 			break;
 		case BTSNOOP_OPCODE_OPEN_INDEX:
@@ -1123,9 +1166,11 @@ void analyze_trace(const char *path)
 			ctrl_msg(&tv, index, buf, pktlen);
 			break;
 		case BTSNOOP_OPCODE_ISO_TX_PKT:
+			num_frames++;
 			iso_pkt(&tv, index, true, buf, pktlen);
 			break;
 		case BTSNOOP_OPCODE_ISO_RX_PKT:
+			num_frames++;
 			iso_pkt(&tv, index, false, buf, pktlen);
 			break;
 		default:
-- 
2.52.0

