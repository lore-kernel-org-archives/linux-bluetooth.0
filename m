Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A886480960
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 16:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787849619; cv=none; b=Mie+baX7lPnnJmsK2GIS18eky83wJNqQHcdnCxsYgIxYZx1fEdyK+JUufd+uCY2yvn8mBEvmuLvIoqchR38gEYAvmhH+bFSH6o4fM+x4jasUPn0xYqFIidFyDlCTZ5h4DEmjdWNZtq7fwNb2XGJn0BGQYQyCrnV+93BjEawZhjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787849619; c=relaxed/simple;
	bh=oM3eaIqzNB9+0OYJYokowPyWonc/h1bpobn9ja5c19Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bKVxcX0ihOsAGF5nTHP0o2+qvZDWn9DztIRJb3r+iJi63sKYfGIk5tc/hwgkQVNCpA7RDq3EEAAbSJifJ62zhuDC0VDqHyERdrbDiHAa12kGg0vutLFtD3D9anYJAnnMx7V0UBHy8LhWZuU9NJrL1xDCaGIxA7GMDKTA8NhTHUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGiZH3Au; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGiZH3Au"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5c2c46a428eso90550e0c.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 09:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787849616; x=1788454416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ItoXqzw7D3Kn9CjbzGw86D5zui1gd6SrgUR+HCgs2Kw=;
        b=XGiZH3AuymPaz0CfitwXN/uw+3uhmzbwmPpTz9BXOFbA2TH935DRFo5NtXxYQ86RUF
         KWK5bLdBu/9Ib73Mr/beQcfSYW7cc+gq4K+kI3UDZZLLJNDxTmUA9BFr4z524yXGUCeC
         ojVvQPd4reEuPV+URCEscQ5v7qDSarGYrfzHRI0H1m0G4R/aJtPgSbGSTEDv7wqxDK5Q
         FtCB4NjWuoV+U33BdT8ssg7DKhIhEiFE/YQQLbGmoMA5oJAmfYgXFTQeRcFD92/Ph49a
         SJWGm8Z6oNXgWMTqcUcTQ/HBgsrefHq0w3d0lYzCNjkv5ozxdCxwUNBMYRoFMf8cFl53
         aDmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787849616; x=1788454416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ItoXqzw7D3Kn9CjbzGw86D5zui1gd6SrgUR+HCgs2Kw=;
        b=OEsXjUtw7tSvDtSYvRtpHF7zqPKcOUP3mRz8lp5cu/5J4UXKLhW2bRukS5rT8gD4bn
         Z7rUtkDC567LYe/KOZUQyQgZiJXzNAdwgAwAQ5igzl2yOy5sr8FMOXbkpHWRkhH5ajUl
         eEhH61+K0UxQ8h6N/hD35bmvSfdOqPOPzcB7B0sn7sT7ZQP8mUBmeKUsSA2NZarLuA+C
         TYWq3JA377EBcHBvqIEbPZklCfgQPB0xXT/2ONq1zzndzIxqlP8/Poetl22FarbJKRHF
         USxOah9cT+VfgRxi7OYHTY+xa3aUHiH9Hih/ay3m9AmReBRyCEC+fxaHvkFuFgxtw2eO
         sNMA==
X-Gm-Message-State: AFuF++nZdZm21HRDsxd95YwBoEqjndxZ/e6c5XWZxxG/4Mr7uJlgfuSi
	QAGqpi0efMvvyfOfLqR8ED9PiFgbEMKudDF7lt63IfC92sCPAy3+7JXeHtWQ9YN2
X-Gm-Gg: AR+sD13Q2KXdGqbZ3pHbctNaDao6OSyGBPOCgw+RKcSB/o5C/H0018VUgco2AvclRaS
	v/s0JH5RmbkksO3I91IMLkESXDCgGidvO/M+R95GW8/oK0noj/ThpKb6zv9zPgNNH+Gm73YQuOv
	mAdmDssDM9geoYpT5Oyv3stxeB/y/3hPi5wxe+EuuiMpA2dz7e2LwTQPLbvG7JxZpwSPMZOZqdc
	5NUbXiq+371ol0oyW8TJzvGCctXvaYlNliH990YtwEBFHLzdjaZ2D4VZRTe+u2RoIV7ocq5XVBg
	5mFqufYjTD4YtyAKyHEdGHj2/mmVnOXmP99RWBueOkc/GPWzfd16q75PFa1v0Spb9ts0anhrqk1
	CKNPsbmLNyIr7bI8jn7gZhqLoAIffTxeLVAj6olVEutzHT+5F/3J1Im5kOCABa9+W8Uge6vo8jb
	oHoPfCHzoMbVrtbumH1DrBYNit7ZbyrjHfBWx/7gww3V30pDbotsBxZIgbDZskpWJsJQ6ZjhdWq
	gNPamecy/X7yKHkJ8X7oapJVLIanaVw245D2y7cHIcklpJf8M92L6c=
X-Received: by 2002:a05:6122:8f8f:b0:5c2:c0b2:9880 with SMTP id 71dfb90a1353d-5c6813acaaamr185919e0c.1.1787849615670;
        Thu, 27 Aug 2026 09:53:35 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c6600aeabcsm4155489e0c.17.2026.08.27.09.53.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 09:53:35 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ vRFC 3/4] monitor: Add ISO packet loss counters
Date: Thu, 27 Aug 2026 12:53:25 -0400
Message-ID: <20260827165326.350079-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260827165326.350079-1-luiz.dentz@gmail.com>
References: <20260827165326.350079-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Isochronous streams are the one place where HCI hands the host enough
information to tell whether data actually arrived: the ISO data packet
header carries an SDU sequence number and a packet status flag.

Track both per connection and report them during the live decoding and
in the analyze mode. Gaps in the sequence number are counted as lost
SDUs, a packet status flag of 2 is counted as dropped and a flag of 1 as
possibly invalid. Duplicates and reordered sequence numbers are not
counted as loss.

During the live decoding the counters are only printed on the packet
where a discontinuity is detected, so a clean stream produces no extra
output.

The model wrote the sequence number accounting and the ISO header
walking, which the author reviewed and verified against a trace with
known gaps.

Assisted-by: opencode:claude-opus-5
---
 monitor/analyze.c | 39 ++++++++++++++++++++++++++++++++++
 monitor/packet.c  | 53 ++++++++++++++++++++++++++++++++++++++++++++---
 monitor/packet.h  | 11 ++++++++++
 3 files changed, 100 insertions(+), 3 deletions(-)

diff --git a/monitor/analyze.c b/monitor/analyze.c
index b349887716da..9742981ec21a 100644
--- a/monitor/analyze.c
+++ b/monitor/analyze.c
@@ -32,6 +32,12 @@
 #define TIMEVAL_MSEC(_tv) \
 	(long long)((_tv)->tv_sec * 1000 + (_tv)->tv_usec / 1000)
 
+/* Same layout as the ISO handle/flags fields decoded in packet.c */
+#define ISO_FLAGS(_h)		((_h) >> 12)
+#define ISO_FLAGS_PB(_f)	((_f) & 0x0003)
+#define ISO_FLAGS_TS(_f)	(((_f) >> 2) & 0x0001)
+#define ISO_DATA_FLAGS(_h)	((_h) >> 14)
+
 struct hci_dev {
 	uint16_t index;
 	uint8_t type;
@@ -87,6 +93,7 @@ struct hci_conn {
 	struct queue *chan_list;
 	struct hci_stats rx;
 	struct hci_stats tx;
+	struct packet_loss rx_loss;
 };
 
 struct hci_conn_tx {
@@ -357,6 +364,15 @@ static void conn_destroy(void *data)
 	print_stats(&conn->rx, "RX");
 	print_stats(&conn->tx, "TX");
 
+	if (conn->rx_loss.total)
+		print_field("RX loss: %zu/%zu (%zu.%02zu%%) "
+				"dropped %zu invalid %zu",
+				conn->rx_loss.lost, conn->rx_loss.total,
+				conn->rx_loss.lost * 100 / conn->rx_loss.total,
+				(conn->rx_loss.lost * 10000 /
+					conn->rx_loss.total) % 100,
+				conn->rx_loss.dropped, conn->rx_loss.invalid);
+
 	if (conn->setup_seen) {
 		print_field("Connected: #%lu", conn->frame_connected);
 		if (conn->terminated) {
@@ -1338,8 +1354,11 @@ static void iso_pkt(struct timeval *tv, uint16_t index, bool out,
 					const void *data, uint16_t size)
 {
 	const struct bt_hci_iso_hdr *hdr = data;
+	struct iovec iov = { .iov_base = (void *)data, .iov_len = size };
 	struct hci_conn *conn;
 	struct hci_dev *dev;
+	uint16_t handle;
+	uint8_t flags, pb_flag;
 
 	dev = dev_lookup(index);
 	if (!dev)
@@ -1357,6 +1376,26 @@ static void iso_pkt(struct timeval *tv, uint16_t index, bool out,
 			return;
 	}
 
+	handle = le16_to_cpu(hdr->handle);
+	flags = ISO_FLAGS(handle);
+	pb_flag = ISO_FLAGS_PB(flags);
+
+	/* Only the first fragment of an SDU carries the sequence number */
+	if (!out && (pb_flag == 0x00 || pb_flag == 0x02)) {
+		const struct bt_hci_iso_data_start *start;
+
+		util_iov_pull_mem(&iov, sizeof(*hdr));
+
+		/* Skip the timestamp when present */
+		if (ISO_FLAGS_TS(flags))
+			util_iov_pull_mem(&iov, sizeof(uint32_t));
+
+		start = util_iov_pull_mem(&iov, sizeof(*start));
+		if (start)
+			packet_loss_add(&conn->rx_loss, le16_to_cpu(start->sn),
+				ISO_DATA_FLAGS(le16_to_cpu(start->slen)));
+	}
+
 	if (out) {
 		conn_pkt_tx(conn, tv, size - sizeof(*hdr), NULL);
 	} else {
diff --git a/monitor/packet.c b/monitor/packet.c
index 174d844c05cb..db52eb789629 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -11588,6 +11588,37 @@ long long packet_latency_stddev(const struct packet_latency *latency)
 	return (long long)sqrt(var);
 }
 
+void packet_loss_add(struct packet_loss *loss, uint16_t sn, uint8_t sflags)
+{
+	loss->total++;
+
+	switch (sflags) {
+	case 0x01:
+		loss->invalid++;
+		break;
+	case 0x02:
+		loss->dropped++;
+		break;
+	}
+
+	if (loss->have_sn) {
+		uint16_t gap = sn - loss->last_sn - 1;
+
+		/*
+		 * A sequence number that did not advance is a duplicate or a
+		 * retransmission, and one that moved backwards is a reorder.
+		 * Neither is a loss, so only account for forward gaps.
+		 */
+		if (sn != loss->last_sn && gap < 0x8000) {
+			loss->lost += gap;
+			loss->total += gap;
+		}
+	}
+
+	loss->last_sn = sn;
+	loss->have_sn = true;
+}
+
 static void packet_dequeue_tx(struct timeval *tv, uint16_t handle)
 {
 	struct packet_conn_data *conn;
@@ -14587,6 +14618,8 @@ void packet_hci_isodata(struct timeval *tv, struct ucred *cred, uint16_t index,
 	struct packet_conn_data *conn;
 	size_t ts_size = 0;
 	bool have_hdr;
+	uint16_t sn = 0;
+	uint8_t sflags = 0;
 
 	if (index >= MAX_INDEX) {
 		print_field("Invalid index (%d).", index);
@@ -14625,12 +14658,12 @@ void packet_hci_isodata(struct timeval *tv, struct ucred *cred, uint16_t index,
 
 	if (have_hdr) {
 		const struct bt_hci_iso_data_start *start = data;
-		uint8_t sflags;
 		uint16_t slen;
 
 		if (size < sizeof(*start))
 			goto malformed;
 
+		sn = le16_to_cpu(start->sn);
 		sflags = iso_data_flags(le16_to_cpu(start->slen));
 		slen = iso_data_len(le16_to_cpu(start->slen));
 
@@ -14641,12 +14674,14 @@ void packet_hci_isodata(struct timeval *tv, struct ucred *cred, uint16_t index,
 					sizeof(slen_str) - strlen(slen_str),
 					" sflags %u", sflags);
 
-		snprintf(sn_str, sizeof(sn_str), " SN %u",
-							le16_to_cpu(start->sn));
+		snprintf(sn_str, sizeof(sn_str), " SN %u", sn);
 	}
 
 	conn = packet_get_conn_data(handle);
 
+	if (in && have_hdr && conn)
+		packet_loss_add(&conn->rx_loss, sn, sflags);
+
 	if (!in && pool->total)
 		sprintf(handle_str, "Handle %d [%u/%u]%s",
 			acl_handle(handle), ++pool->tx, pool->total, sn_str);
@@ -14666,6 +14701,18 @@ void packet_hci_isodata(struct timeval *tv, struct ucred *cred, uint16_t index,
 	print_packet(tv, cred, in ? '>' : '<', index, NULL, COLOR_HCI_ISODATA,
 				label, handle_str, extra_str);
 
+	if (in && conn) {
+		struct packet_loss *loss = &conn->rx_loss;
+
+		if (loss->lost || loss->dropped || loss->invalid)
+			print_field("Lost: %zu/%zu (%zu.%02zu%%) "
+				"dropped %zu invalid %zu",
+				loss->lost, loss->total,
+				loss->lost * 100 / loss->total,
+				(loss->lost * 10000 / loss->total) % 100,
+				loss->dropped, loss->invalid);
+	}
+
 	if (!in)
 		packet_enqueue_tx(tv, acl_handle(handle),
 					index_list[index].frame, dlen);
diff --git a/monitor/packet.h b/monitor/packet.h
index 6b792c0e420c..9d1efdf45258 100644
--- a/monitor/packet.h
+++ b/monitor/packet.h
@@ -36,6 +36,15 @@ struct packet_latency {
 	uint64_t sum_sq_msec;	/* Sum of squared samples, in msec^2 */
 };
 
+struct packet_loss {
+	uint16_t last_sn;
+	bool have_sn;
+	size_t lost;		/* Samples missing from the SN sequence */
+	size_t invalid;		/* Samples flagged possibly invalid */
+	size_t dropped;		/* Samples flagged as lost data */
+	size_t total;		/* Samples seen, including the lost ones */
+};
+
 struct packet_frame {
 	struct timeval tv;
 	size_t num;
@@ -66,6 +75,7 @@ struct packet_conn_data {
 	struct queue *tx_q;
 	struct queue *chan_q;
 	struct packet_latency tx_l;
+	struct packet_loss rx_loss;
 	void     *data;
 	void     (*destroy)(struct packet_conn_data *conn, void *data);
 };
@@ -73,6 +83,7 @@ struct packet_conn_data {
 struct packet_conn_data *packet_get_conn_data(uint16_t handle);
 void packet_latency_add(struct packet_latency *latency, struct timeval *delta);
 long long packet_latency_stddev(const struct packet_latency *latency);
+void packet_loss_add(struct packet_loss *loss, uint16_t sn, uint8_t sflags);
 
 bool packet_has_filter(unsigned long filter);
 void packet_set_filter(unsigned long filter);
-- 
2.54.0

