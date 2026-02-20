Received: from mail-vk1-f194.google.com (mail-vk1-f194.google.com [209.85.221.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D69035F8D3
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Feb 2026 17:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771608701; cv=none; b=g9rX7VpzT3YkkFaW5ywNCgB2qu7C4KrQOa6xOOfya+w7X8lVVhMRVsOieObLqx5WzFvmQJsS6mbsVY/dxBZP+iUkg2fnJfnJ8WoEb08UNLB9AzA9SMS7UBm3DlBtAkXtZ5rkShQDlleSXzdc2a3e5TRtJpee9J6Kb5+D4+b3JMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771608701; c=relaxed/simple;
	bh=vwSVyKrm1S3cImEjxyS+0Lzvxz2Gcz3bPnd/wChzCKo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rv6Bv0A8Kk0sADc5qm44/QbNUk/wmJh+j3oWhK+3tLXQZ/xsaHxfU0Lr13/5zpdmarCm9TSLCXRdhdusGFA/bCRu+inadRjc6bgA1VzcFhXetPln84Y6+h0qIwdwS1X6FpIbfVejcmWDFTssQ8LnAso+cbXdd7uTFE867hYiB7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CsJzKyLh; arc=none smtp.client-ip=209.85.221.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsJzKyLh"
Received: by mail-vk1-f194.google.com with SMTP id 71dfb90a1353d-5665171836cso2484275e0c.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Feb 2026 09:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771608699; x=1772213499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+dEW+DH4tW8V4LkU7Pun4JiyvlXapof8twkYuk8NcHc=;
        b=CsJzKyLhuj9ttLYx9jcbsQYGKPAgmD06xlgz0pQhhiAutwFP7DcCj+igMqUDh9COIT
         Nifmde/6CzzAnYCoQBVUKDxcUX7qCr5nHVGuHjzsSEg3N7GwZvX9ZLjpKNYOYvcTEJAi
         6eh+Jl1sZNbIyej4LHsi3sp+8kGoX3VGvIDut7KJiWkOjM0vAvabknGgMuP70MPWLUFq
         GLrD+a3qHcz/YewjDCBzh0F98CXmXpVs/+/yIu1CNoMDe6vE/9jtNvofAi4ovDszaS33
         ZQl8s1YYO40ILI7mSkcScJXVFKHPL4i5HpTaaVxaELljxPf6S+c15ZFhd+683JXCD196
         1MzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771608699; x=1772213499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+dEW+DH4tW8V4LkU7Pun4JiyvlXapof8twkYuk8NcHc=;
        b=r/9L4riyDfte6T0Y1ALop9o7V8kaTobTq3/XfMTrWSoLL8opdhxIuM2nuhhtM+q9LS
         yFtHaCyy7LnIhqsry/ggB6WVd9Cjxw3OVGr2Q6tAqu1Q6/qqR2FSbBNeqJAipBM20a57
         v1pGjoSCczTsz2NkcsThJZ5InAmPdl7ZEiI1zmKTHDo7S1di5RyRQZ81GVghEZqV9kSJ
         5pCdn1roZPJYyYrPiTjZEBfXC5AgRHX3oIJsow3iPYi6H/pdqCw++7YeITfqJcdJQLit
         ZEczSKOSQMLFCDsjLyLNwQZAFt6yt7bCaW1LbG2rmWlRt8IFY56KOki3BqPWu/4GQSj9
         ze8Q==
X-Gm-Message-State: AOJu0YyG5/kKgaNQnJAUtnRL9p0RYAbl7MUz/tr1wZ6ZVL4PWoJQ9zVF
	+FzW69OEmDFJyjfI037CR+uKp50olFgPolsq4YwSkOypfgzNvIrOV0wH5+sENr4Y
X-Gm-Gg: AZuq6aIjkk+aq7gfclYpIDkzVWOGDVnweXqM54mDH8aDY7ZTzYp9Ag6bNWCYedK1w6m
	klaj4XpHNDmmVicXGHgW7XzHWY8UQx5j5mEdJlY4FGnvaJVTYPYyT0qnyovL4KMlewg9uMUaxxC
	0FaPu990432E88uhfz1ZUeiHUzlizYDnMztrwlUd1F/4GnvhgaQgEZC4T/lDWIHmFm781mkKyed
	Ce05tc2cHADcO2t9jKTfSCml4KTekG/SO7bw8Dh6kPh1XyRim9QfAsHEtl1hF38ehvanuBS7izc
	C3GbQh1l4PEsBDjfcya2FZOOke/917zjMFD9WppTl9ZqzqR1ZtnQpwNPlOlR1KhraDJgLpVaGmw
	GrkPOkOFfvILNLAhuc3kAoZc5IBinIpaPLhzeqen6TyL9ddekA8zdQPW2WUngbsRYceKwelxu9m
	lIi7nLzQ96YO8TKXOHKRXMKBWlc++BfblJLBpJtaHmAyo/2Axb+XK3Yly9D3MIzalPJRD/ulc6S
	oSRbIhXuq1NGrOyBNCpo9ycrZyo
X-Received: by 2002:a05:6122:17a6:b0:566:24fc:9501 with SMTP id 71dfb90a1353d-568e47a9d6fmr295556e0c.6.1771608698725;
        Fri, 20 Feb 2026 09:31:38 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94da8b3eefdsm77864241.9.2026.02.20.09.31.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 09:31:38 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 10/12] monitor: Add connection lifecycle to analyze summary
Date: Fri, 20 Feb 2026 12:31:14 -0500
Message-ID: <20260220173120.3418666-10-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260220173120.3418666-1-luiz.dentz@gmail.com>
References: <20260220173120.3418666-1-luiz.dentz@gmail.com>
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

