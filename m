Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E8B3F1AC6
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Oct 2026 19:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790969296; cv=none; b=RKTO/aVQaxLn0fZJCwk25hDymfOcba6ntGYM0aTMZwHupav2ngMVH0ccClPkzB65je0VoKLk3Hd9wnaisBvK2GGoZbexnV5In2j2ZogmFq1CPzAr5Wb/GMZlapeZy2RQ2jTaz0VcM3xBF9YSEns2TAepLaAYJD1NtsWgP/zT+po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790969296; c=relaxed/simple;
	bh=MjS/1aAE2bXdytnPJxGe+HzfsFngp2RMad7vllfE+Cg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=awHgAQLmw/op87WBJHTNr0+hi5NLXewhky44DxyTTCwEtG4L/nZI70hlfUaBiKHP3hsXBWtBhL2jBbkYDp964q8h62DeFjEo83usQVo9dRMbz0jVSpUHM5QRpF+m9ZdoXJSXQ4AR3jkdhkmsCRzLzS3VFGrXNermV9g94z5hJMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YCDfPf6m; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCDfPf6m"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-98a903b7e1dso1105695241.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 02 Oct 2026 12:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790969290; x=1791574090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=a6fAd4gi9BHa002NExMbcClWymoOSdRYP14YB+LPER8=;
        b=YCDfPf6mLvw4HPjH7AS0NfOHdnocy18LlY9HOux9rIPvo5Io5alYsuxCyxrKlJCoDM
         /7Gt8Pno7DWrA0WFpwtZ6z7tkFw344Yb+XLHt1842SIuAPGC6b1QCRhy5IFYNhd56fNI
         2fy0pPrjaigej0D03oGunza/kMh/0+BR2LZ4lrOLxjEGxCqxfHc4duieoB0exC2EuGeY
         ImFJQ/Iwz5njgNyx7xbmmlpeq0Kx36uqs7EoBETF5mG1F4rT50i1C4Q8i2ZVY5c+5xXe
         V40LRVZY6rOMv9j6y+nx5ogRwvTdBVV+VmbTd5AB5d6BncHCw5HAOLBGSySEF/9TNRgx
         LAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790969290; x=1791574090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=a6fAd4gi9BHa002NExMbcClWymoOSdRYP14YB+LPER8=;
        b=q/yDKkGLVrfv0CJpbtv63e64Q+K8JE0RL0SndVp+fM9mhDr/eI8/fb6HaZQ6zaX9g3
         D+phl524d0BUD8QmvX/TMS2e+IQpiRSw2l8C/O9sySNovSpIlUuu1kTf1rhxp4cU2pHf
         vMNWR3YlIagxWYSE2swB6i9/N71q0AiZYX9hAenYOGqtppc7mkaunsov3SCx9GxodTKZ
         mk6vGxrMyvyJofgbT7/i2tcBUDYa++sWAgP+KyytH/hjrLcAAnIZ8e53nimvFsSxtU7p
         h04PFDHctikCYqUPq8G0uqsORzeUnLSgZDxFPAhYicLWohBVY0fvN5dzfNMuNGxk30Fn
         ht3A==
X-Gm-Message-State: AFq9FYJyvweaJmIjfK0kRgwB++l/Cq8oaDprkQB5qYefkdyr6t9CkWxT
	m4qJ4Pv/s8e8UP0pd7/zOGB6azbUf3L+Cj2nP4x+/W4Anak+eAOksOKjhW3/Oe86
X-Gm-Gg: AYBFou3z9oXt4dL3o71hFrqmp6sPWMQ4TL5Uoph5VVWePqPwz42QPVWigxyMwhRF9zD
	WxPZ28T2u+ZgjeR2xLyozsFaTw6ZxSz66BP63IQuchZdV/HAT7mRO0yiZN/OpN9y2hd9jfMmc3Y
	JqaIt/erkozpRDT88khFBak8mGhbhRnx26kaEyv/0bfI9n1iQjiJkj5uKl8KOsgpzfDHX314z16
	WHZP2eLYsUFzHouk96A+EslpzadUSUo9qgo0qs0/59+VjA1h98HPwzrjznj2yzf7EYJ3yZzn3q2
	nkKzshB948fGsuvEhleoTyScj7BjnlmfO+tfx1H4zbh7hmYmZJWUG6InkYhAPzSwASnP1jgWCsz
	qcqCjxBy3VaQ9ivJxH6FwwsQxj+lvky4hRxncr1drD+l832WV8UCDoUcSj29S595SSTaQZbwPLm
	9uw+evZDkQUVY6O0cqrOBzjC3yJqXwCMahMswik3kKQmtQ5phvjxe/HSO7MmIyxIRWYBW/LZlhe
	qHNgZN2f7y9vn/WZVuLztBu2dqBmbgUNJzbyelZbBGXPePcXmqrv36f30+ftx6D
X-Received: by 2002:a05:6102:3c14:b0:7b3:9d2e:c1a2 with SMTP id ada2fe7eead31-7bf84c95af5mr1327046137.42.1790969290087;
        Fri, 02 Oct 2026 12:28:10 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-98b2f15ef60sm3857759241.12.2026.10.02.12.28.09
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 12:28:09 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ vRFC 5/7] monitor: Add audio quality statistics for SCO data
Date: Fri,  2 Oct 2026 15:27:57 -0400
Message-ID: <20261002192759.3071262-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002192759.3071262-1-luiz.dentz@gmail.com>
References: <20261002192759.3071262-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Account the Packet_Status_Flag of received SCO data, reported with
Erroneous Data Reporting, as erasures, and the jitter against the time the
data of a packet takes to play, derived from the air mode:

> BR-ESCO: Handle 257 [90:09.. flags 0x01 dlen 120  #1455 [hci0] 19979.296105
        Status: Possibly invalid (0x01)
        Lost: 0/1 (0.00%) missing 0 dropped 0 invalid 1 partial 0 burst 0

  Found BR-ESCO connection with handle 257
        ...
        RX loss: 0/8 (0.00%) missing 0 dropped 0 invalid 1 partial 0
        RX jitter: 0.11 msec (max 0.48 msec, late 0)
        RX interval: 7.50 msec (7-7 msec, ~7 msec +/- 0 msec)

The loss now reports all the erasures, with the missing samples apart.

Assisted-by: OpenCode:claude-opus-5.5
---
 monitor/analyze.c |  15 +++
 monitor/packet.c  | 287 ++++++++++++++++++++++++++++++++--------------
 monitor/packet.h  |   6 +
 3 files changed, 220 insertions(+), 88 deletions(-)

diff --git a/monitor/analyze.c b/monitor/analyze.c
index c5bf88216408..3a11590a0061 100644
--- a/monitor/analyze.c
+++ b/monitor/analyze.c
@@ -108,6 +108,7 @@ struct hci_conn {
 	struct hci_stats tx;
 	struct packet_loss rx_loss;
 	struct packet_jitter rx_jitter;
+	uint8_t sco_rate;
 };
 
 struct hci_conn_tx {
@@ -1072,6 +1073,7 @@ static void evt_sync_conn_complete(struct hci_dev *dev, struct timeval *tv,
 	memcpy(conn->bdaddr, evt->bdaddr, 6);
 	conn->frame_connected = frame;
 	conn->setup_seen = true;
+	conn->sco_rate = packet_sco_rate(evt->air_mode);
 }
 
 /* Nominal SDU interval of an unframed stream: ISO Interval over BN */
@@ -1408,6 +1410,19 @@ static void sco_pkt(struct timeval *tv, uint16_t index, bool out,
 	conn = conn_lookup_types(dev, le16_to_cpu(hdr->handle) & 0x0fff,
 					BTMON_CONN_SCO, BTMON_CONN_ESCO);
 
+	if (!out && size > sizeof(*hdr)) {
+		uint8_t status = (le16_to_cpu(hdr->handle) >> 12) & 0x03;
+
+		packet_loss_add_status(&conn->rx_loss, status);
+
+		if (conn->sco_rate) {
+			conn->rx_jitter.interval = hdr->dlen * 1000 /
+							conn->sco_rate;
+			packet_jitter_add(&conn->rx_jitter, tv,
+						conn->rx_jitter.interval);
+		}
+	}
+
 	if (out) {
 		conn_pkt_tx(conn, tv, size - sizeof(*hdr), NULL);
 	} else {
diff --git a/monitor/packet.c b/monitor/packet.c
index 09603c19e05e..1e177d0abd3d 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -12076,6 +12076,26 @@ void packet_loss_add(struct packet_loss *loss, uint16_t sn, uint8_t sflags)
 	loss->have_sn = true;
 }
 
+/* Packet_Status_Flag of SCO data, reported with Erroneous Data Reporting */
+void packet_loss_add_status(struct packet_loss *loss, uint8_t status)
+{
+	loss->total++;
+
+	switch (status) {
+	case 0x01:
+		loss->invalid++;
+		break;
+	case 0x02:
+		loss->dropped++;
+		break;
+	case 0x03:
+		loss->partial++;
+		break;
+	}
+
+	loss_sample(loss, status == 0x02 || status == 0x03, 1);
+}
+
 size_t packet_loss_burst_max(const struct packet_loss *loss)
 {
 	return loss->burst_max;
@@ -12113,11 +12133,12 @@ void packet_loss_print(const struct packet_loss *loss, const char *label)
 	if (!loss->total)
 		return;
 
-	print_field("%s loss: %zu/%zu (%zu.%02zu%%) dropped %zu invalid %zu",
-				label, loss->lost, loss->total,
-				loss->lost * 100 / loss->total,
-				(loss->lost * 10000 / loss->total) % 100,
-				loss->dropped, loss->invalid);
+	print_field("%s loss: %zu/%zu (%zu.%02zu%%) missing %zu dropped %zu "
+				"invalid %zu partial %zu", label, loss->erased,
+				loss->total, loss->erased * 100 / loss->total,
+				(loss->erased * 10000 / loss->total) % 100,
+				loss->lost, loss->dropped, loss->invalid,
+				loss->partial);
 
 	/* Account for the burst still in progress */
 	loss_burst_end(&tmp);
@@ -12168,6 +12189,18 @@ static void jitter_add(struct packet_jitter *jitter, struct timeval *tv,
 	jitter->jitter16 += (uint64_t)d - ((jitter->jitter16 + 8) >> 4);
 }
 
+void packet_jitter_add(struct packet_jitter *jitter, struct timeval *tv,
+							uint32_t expected)
+{
+	if (!jitter->have_prev) {
+		jitter->prev_tv = *tv;
+		jitter->have_prev = true;
+		return;
+	}
+
+	jitter_add(jitter, tv, expected);
+}
+
 void packet_jitter_add_sn(struct packet_jitter *jitter, struct timeval *tv,
 								uint16_t sn)
 {
@@ -12615,11 +12648,18 @@ static void sync_conn_complete_evt(struct timeval *tv, uint16_t index,
 	print_field("TX packet length: %d", le16_to_cpu(evt->tx_pkt_len));
 	print_air_mode(evt->air_mode);
 
-	if (evt->status == 0x00)
+	if (evt->status == 0x00) {
+		struct packet_conn_data *conn;
+
 		assign_handle(index, le16_to_cpu(evt->handle),
 					evt->link_type ? BTMON_CONN_ESCO :
 					BTMON_CONN_SCO,
 					(void *)evt->bdaddr, BDADDR_BREDR);
+
+		conn = packet_get_conn_data(le16_to_cpu(evt->handle));
+		if (conn)
+			conn->sco_rate = packet_sco_rate(evt->air_mode);
+	}
 }
 
 static void sync_conn_changed_evt(struct timeval *tv, uint16_t index,
@@ -15337,71 +15377,6 @@ void packet_hci_acldata(struct timeval *tv, struct ucred *cred, uint16_t index,
 	packet_set_context(NULL, 0);
 }
 
-void packet_hci_scodata(struct timeval *tv, struct ucred *cred, uint16_t index,
-				bool in, const void *data, uint16_t size)
-{
-	const hci_sco_hdr *hdr = data;
-	uint16_t handle = le16_to_cpu(hdr->handle);
-	uint8_t flags = acl_flags(handle);
-	char label[8];
-	char handle_str[42], extra_str[32];
-	struct packet_conn_data *conn;
-
-	if (index >= MAX_INDEX) {
-		print_field("Invalid index (%d).", index);
-		return;
-	}
-
-	index_list[index].frame++;
-
-	if (size < HCI_SCO_HDR_SIZE) {
-		if (in)
-			print_packet(tv, cred, '*', index, NULL, COLOR_ERROR,
-				"Malformed SCO Data RX packet", NULL, NULL);
-		else
-			print_packet(tv, cred, '*', index, NULL, COLOR_ERROR,
-				"Malformed SCO Data TX packet", NULL, NULL);
-		packet_hexdump(data, size);
-		return;
-	}
-
-	data += HCI_SCO_HDR_SIZE;
-	size -= HCI_SCO_HDR_SIZE;
-	conn = packet_get_conn_data(handle);
-
-	if (index_list[index].sco.total && !in)
-		sprintf(handle_str, "Handle %d [%u/%u]", acl_handle(handle),
-			index_list[index].sco.total, index_list[index].sco.tx);
-	else
-		sprintf(handle_str, "Handle %d", acl_handle(handle));
-
-	handle_str_append_addr(handle_str, conn);
-
-	sprintf(extra_str, "flags 0x%2.2x dlen %d", flags, hdr->dlen);
-
-	if (conn)
-		sprintf(label, "%s", conn_type_str(conn->type));
-	else
-		sprintf(label, "SCO");
-
-	print_packet(tv, cred, in ? '>' : '<', index, NULL, COLOR_HCI_SCODATA,
-				label, handle_str, extra_str);
-
-	if (!in)
-		packet_enqueue_tx(tv, acl_handle(handle),
-					index_list[index].frame, hdr->dlen);
-
-	if (size != hdr->dlen) {
-		print_text(COLOR_ERROR, "invalid packet size (%d != %d)",
-							size, hdr->dlen);
-		packet_hexdump(data, size);
-		return;
-	}
-
-	if (filter_mask & PACKET_FILTER_SHOW_SCO_DATA)
-		packet_hexdump(data, size);
-}
-
 static void print_rx_quality(struct packet_conn_data *conn, size_t erased,
 				size_t late, uint8_t sflags, size_t burst)
 {
@@ -15410,12 +15385,13 @@ static void print_rx_quality(struct packet_conn_data *conn, size_t erased,
 
 	/* Only report the samples that revealed a loss or arrived late */
 	if (loss->erased != erased || sflags)
-		print_field("Lost: %zu/%zu (%zu.%02zu%%) dropped %zu "
-				"invalid %zu burst %zu",
-				loss->lost, loss->total,
-				loss->lost * 100 / loss->total,
-				(loss->lost * 10000 / loss->total) % 100,
-				loss->dropped, loss->invalid, burst);
+		print_field("Lost: %zu/%zu (%zu.%02zu%%) missing %zu "
+				"dropped %zu invalid %zu partial %zu burst %zu",
+				loss->erased, loss->total,
+				loss->erased * 100 / loss->total,
+				(loss->erased * 10000 / loss->total) % 100,
+				loss->lost, loss->dropped, loss->invalid,
+				loss->partial, burst);
 
 	if (jitter->late != late)
 		print_field("Late: +%" PRId64 ".%02" PRId64 " msec "
@@ -15491,6 +15467,150 @@ static void quality_summary(struct timeval *tv, struct ucred *cred,
 	q->burst_max = loss->burst;
 }
 
+static void rx_quality(struct timeval *tv, struct ucred *cred,
+				uint16_t index, struct packet_conn_data *conn,
+				size_t erased, size_t late, uint8_t status)
+{
+	struct packet_loss *loss = &conn->rx_loss;
+	size_t burst = loss->burst;
+
+	/* A burst that this sample has just ended */
+	if (!burst && loss->erased != erased)
+		burst = loss->burst_last;
+
+	print_rx_quality(conn, erased, late, status, burst);
+	quality_summary(tv, cred, index, conn, burst);
+}
+
+static void sco_rx_quality(struct timeval *tv, struct ucred *cred,
+				uint16_t index, struct packet_conn_data *conn,
+				uint8_t status, uint8_t dlen);
+
+void packet_hci_scodata(struct timeval *tv, struct ucred *cred, uint16_t index,
+				bool in, const void *data, uint16_t size)
+{
+	const hci_sco_hdr *hdr = data;
+	uint16_t handle = le16_to_cpu(hdr->handle);
+	uint8_t flags = acl_flags(handle);
+	char label[8];
+	char handle_str[42], extra_str[32];
+	struct packet_conn_data *conn;
+
+	if (index >= MAX_INDEX) {
+		print_field("Invalid index (%d).", index);
+		return;
+	}
+
+	index_list[index].frame++;
+
+	if (size < HCI_SCO_HDR_SIZE) {
+		if (in)
+			print_packet(tv, cred, '*', index, NULL, COLOR_ERROR,
+				"Malformed SCO Data RX packet", NULL, NULL);
+		else
+			print_packet(tv, cred, '*', index, NULL, COLOR_ERROR,
+				"Malformed SCO Data TX packet", NULL, NULL);
+		packet_hexdump(data, size);
+		return;
+	}
+
+	data += HCI_SCO_HDR_SIZE;
+	size -= HCI_SCO_HDR_SIZE;
+	conn = packet_get_conn_data(handle);
+
+	if (index_list[index].sco.total && !in)
+		sprintf(handle_str, "Handle %d [%u/%u]", acl_handle(handle),
+			index_list[index].sco.total, index_list[index].sco.tx);
+	else
+		sprintf(handle_str, "Handle %d", acl_handle(handle));
+
+	handle_str_append_addr(handle_str, conn);
+
+	sprintf(extra_str, "flags 0x%2.2x dlen %d", flags, hdr->dlen);
+
+	if (conn)
+		sprintf(label, "%s", conn_type_str(conn->type));
+	else
+		sprintf(label, "SCO");
+
+	print_packet(tv, cred, in ? '>' : '<', index, NULL, COLOR_HCI_SCODATA,
+				label, handle_str, extra_str);
+
+	if (!in)
+		packet_enqueue_tx(tv, acl_handle(handle),
+					index_list[index].frame, hdr->dlen);
+
+	if (size != hdr->dlen) {
+		print_text(COLOR_ERROR, "invalid packet size (%d != %d)",
+							size, hdr->dlen);
+		packet_hexdump(data, size);
+		return;
+	}
+
+	if (in && conn)
+		sco_rx_quality(tv, cred, index, conn, flags & 0x03,
+								hdr->dlen);
+
+	if (filter_mask & PACKET_FILTER_SHOW_SCO_DATA)
+		packet_hexdump(data, size);
+}
+
+static const char *sco_status_str(uint8_t status)
+{
+	switch (status) {
+	case 0x01:
+		return "Possibly invalid";
+	case 0x02:
+		return "No data";
+	case 0x03:
+		return "Partially lost";
+	}
+
+	return "Correct";
+}
+
+/* Octets per msec of the host data, as configured by the air mode */
+uint8_t packet_sco_rate(uint8_t air_mode)
+{
+	switch (air_mode) {
+	case 0x00:
+	case 0x01:
+		/* 8 kHz 8-bit logarithmic */
+		return 8;
+	case 0x02:
+		/* 8 kHz 16-bit linear */
+		return 16;
+	case 0x03:
+		/* 64 kb/s transparent: mSBC, LC3-SWB */
+		return 8;
+	}
+
+	return 0;
+}
+
+static void sco_rx_quality(struct timeval *tv, struct ucred *cred,
+				uint16_t index, struct packet_conn_data *conn,
+				uint8_t status, uint8_t dlen)
+{
+	size_t erased = conn->rx_loss.erased;
+	size_t late = conn->rx_jitter.late;
+
+	if (status)
+		print_field("Status: %s (0x%2.2x)", sco_status_str(status),
+								status);
+
+	packet_loss_add_status(&conn->rx_loss, status);
+
+	if (tv && conn->sco_rate) {
+		/* The data of a packet takes that long to play */
+		conn->rx_jitter.interval = dlen * 1000 / conn->sco_rate;
+		packet_jitter_add(&conn->rx_jitter, tv,
+						conn->rx_jitter.interval);
+	}
+
+	rx_quality(tv, cred, index, conn, erased, late, status);
+}
+
 void packet_hci_isodata(struct timeval *tv, struct ucred *cred, uint16_t index,
 				bool in, const void *data, uint16_t size)
 {
@@ -15600,17 +15720,8 @@ void packet_hci_isodata(struct timeval *tv, struct ucred *cred, uint16_t index,
 	print_packet(tv, cred, in ? '>' : '<', index, NULL, COLOR_HCI_ISODATA,
 				label, handle_str, extra_str);
 
-	if (in && have_hdr && conn) {
-		struct packet_loss *loss = &conn->rx_loss;
-		size_t burst = loss->burst;
-
-		/* A burst that this sample has just ended */
-		if (!burst && loss->erased != erased)
-			burst = loss->burst_last;
-
-		print_rx_quality(conn, erased, late, sflags, burst);
-		quality_summary(tv, cred, index, conn, burst);
-	}
+	if (in && have_hdr && conn)
+		rx_quality(tv, cred, index, conn, erased, late, sflags);
 
 	if (!in)
 		packet_enqueue_tx(tv, acl_handle(handle),
diff --git a/monitor/packet.h b/monitor/packet.h
index c3e3608bdede..85b7f2ff762c 100644
--- a/monitor/packet.h
+++ b/monitor/packet.h
@@ -42,6 +42,7 @@ struct packet_loss {
 	size_t lost;		/* Samples missing from the SN sequence */
 	size_t invalid;		/* Samples flagged possibly invalid */
 	size_t dropped;		/* Samples flagged as lost data */
+	size_t partial;		/* Samples flagged as partially lost */
 	size_t total;		/* Samples seen, including the lost ones */
 	/* Bursts of erased samples, either missing or flagged as lost */
 	size_t erased;		/* Erased samples */
@@ -118,6 +119,7 @@ struct packet_conn_data {
 	struct packet_loss rx_loss;
 	struct packet_jitter rx_jitter;
 	struct packet_quality rx_quality;
+	uint8_t  sco_rate;	/* SCO octets per msec, 0 if unknown */
 	struct queue *req_q;
 	void     *data;
 	void     (*destroy)(struct packet_conn_data *conn, void *data);
@@ -131,6 +133,10 @@ size_t packet_loss_burst_max(const struct packet_loss *loss);
 bool packet_loss_burst_ratio(const struct packet_loss *loss, double *p,
 						double *q, double *ratio);
 void packet_loss_print(const struct packet_loss *loss, const char *label);
+void packet_loss_add_status(struct packet_loss *loss, uint8_t status);
+void packet_jitter_add(struct packet_jitter *jitter, struct timeval *tv,
+							uint32_t expected);
+uint8_t packet_sco_rate(uint8_t air_mode);
 void packet_jitter_add_sn(struct packet_jitter *jitter, struct timeval *tv,
 								uint16_t sn);
 void packet_jitter_add_ts(struct packet_jitter *jitter, struct timeval *tv,
-- 
2.55.0

