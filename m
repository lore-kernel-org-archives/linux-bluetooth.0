Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CD9345CD9
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 16:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771518167; cv=none; b=Y+qr7SwsxC8/yHuemw7D2lvdPFrSoFjBwazybpA9PqwjxXdRYMQnmASRt67asgrhYpUleAi4iyI4qOIwydJ68Z1C5122kg7aQe1GTWySpQ7ZHgFc1jMUQh9bC7NjlCo2C8PRHqtx/QS0QH9b3lUECJSQpfDf5FVrh9NhAkax6PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771518167; c=relaxed/simple;
	bh=DghqkDSZnJx7xPBxaYg1VtWc4EQewhnEUuHyrdZoayQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vERTRrxerW/do54acS8LPnyT088eRzZNCwcpF3owxqqxubnq/GA9ZCY0BpuMhYNowsOlnZ1VsyTNyvybfd/KGZH31wwdCy9QQmJlYy2taILCa1OSVwUQ9CzVZsvY/ZD1KhfGkJ79nYaykh0BwQrr5RgN0jkiPW8MtjwfTUC0iL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SnGljkIs; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SnGljkIs"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5665171836cso1211475e0c.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 08:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771518165; x=1772122965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+fFwFRec0/iMaA81v94JZTtdiByYb3b+1BAjF09gg5c=;
        b=SnGljkIsWasQ3/8kmHP4bwngfp637J/J7drgC0sLI6rwHqa9PhH2bCVy7t/WB9vF5v
         k+ZUbDhE0X2IZpatJRXWpEf4Ktf0e5GY94n8F/jMoHcTZdznKM8+1bnG/Ai4rGYCREJp
         n9/55liMYWTIlrG/mZMhcHjMWJ0ZSLWCdmG+5dEDAT3Q6oEL1mmKvOoqelkXtnsBGb0U
         p9mSX574aTLT9GmCLo4ROPiuVYWl94YNvN/vbArm6NI4p7jMhjUwtGA2Zt99Tm3ScKQu
         Z+nPbKNAjL1AOJfCrwqbJrafla5mT+wikgqXh+6ZVWr1LemPoF0SJB4ZZUrtWcp3A3xR
         CMag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771518165; x=1772122965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+fFwFRec0/iMaA81v94JZTtdiByYb3b+1BAjF09gg5c=;
        b=K7MC+saiLQD1No0HQBJ+WsxjNTewo4rLFgRN+2WbHQspfDjDG119gme4dkEpBXuhXV
         gDkvwcSsop+YYg8Fek803k7YD22S0FguRb+8CGLd293YhydJIONAVGUrIx7ohMtJQ8SY
         68N5Z0OGsjFIFNvphFB+7EZ2vqocK4bOSF6eSDyDDdx881b/VIko4zFf1qbdgGZhOdcI
         qB5Up0RkR8o7nn9wrRs1lqQP4sdr9Bf1zuB1EGhbY8/WEV4Y3dpFGcgX+bRV1REkvswP
         w8GKDKUjGFNcHZaOxbSzJwRFlpxK7Tw0SAESaZoVuUjQISa22UGPTvOvtYGfhIPrM1+X
         SrDQ==
X-Gm-Message-State: AOJu0YyIWtLmaNz5IpRFhwwDXtTMPM+feCrFNU3UWET2Gw7tLJCLa4wl
	Nf3HX+sNLrMpV7CD1+33Jo3284N5sLMQVb9jpcu44DcNs7rIHeiLVjG2NIIErQ==
X-Gm-Gg: AZuq6aIrxBVfEaOrndLX1a+vNhj1ugnF/84xjNtUs+mlUK3mx8qXqWVIBk1n2OlLwMf
	U4PdRmlqdEnaRfGEC7fh4krK7XdzNum4685jT1WsFb90mca6Ks6Jznm2l6PTWXbpMnDz7LpdIld
	HfUVmbLD9RsRmCZbYoi9LxHm4O9icqZGF0s/aD8F1Ges5X7K8jrMVUWKuJ/1upL2cXKgA++l3P4
	oDXuCx8komxjR7H3PBBLWrbM64IeGL3c5fSgPQkMlMUZga47bNnXfrNNlEsvXOeZoxmAAeRH5XG
	kluyy+/HGVTN3Kx4wPLKHD+ZTlJDiE4mB28b2v7UkkNd8/DzvyPD6PUcFbLPFYkfLpryACq+AUo
	LpyKK9ym08Uvy6A9S/wawVBxI0Ee983wtVW7leWcrw39fGwIC/Cnyplx7CCPyP32tpS6wuidFm6
	X8uL/9cLp+6FwLwqwbktUEl4HRcmUn+PtPNnLFZ30r2PET3ZvqpfF5jR3jtN4dl0CIRk+3WH6Gx
	mHxPipN4uIuLbB7iA==
X-Received: by 2002:a05:6123:125:b0:566:2302:f317 with SMTP id 71dfb90a1353d-568bf5faa72mr2958453e0c.20.1771518164714;
        Thu, 19 Feb 2026 08:22:44 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5674c20a659sm14435235e0c.11.2026.02.19.08.22.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 08:22:43 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 6/8] monitor: Annotate ACL/SCO/ISO data with device address
Date: Thu, 19 Feb 2026 11:22:28 -0500
Message-ID: <20260219162230.3074355-6-luiz.dentz@gmail.com>
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

Add the remote device address to ACL, SCO and ISO data packet output
so each data packet line shows which device it belongs to. This makes
it much easier to follow multi-device traces without having to
cross-reference handle numbers with earlier connection events:

< ACL Data TX: Handle 2048 [1/6] [42:96:D7:49:78:CC (Resolvable)] flags 0x00 dlen 7
      ATT: Exchange MTU Request (0x02) len 2
        Client RX MTU: 527
> ACL Data RX: Handle 256 [20:32:C6:09:FF:6C (Apple, Inc.)] flags 0x02 dlen 16
      L2CAP: Connection Response (0x03) ident 33 len 8
        Destination CID: 17169
        Source CID: 64
        Result: Connection successful (0x0000)
        Status: No further information available (0x0000)

Also fix the connection lookup in packet_hci_acldata() to use
acl_handle() to mask off the flags bits, matching what assign_handle()
stores.
---
 monitor/packet.c | 92 +++++++++++++++++++++++++++++++++++++++++++++---
 monitor/packet.h |  4 +++
 2 files changed, 92 insertions(+), 4 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index 3ba33f8f3afa..b8a48bb549af 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -322,6 +322,43 @@ static void assign_handle(uint16_t index, uint16_t handle, uint8_t type,
 		memcpy(conn->dst, dst, sizeof(conn->dst));
 		conn->dst_type = dst_type;
 	}
+
+	switch (conn->dst_type) {
+	case 0x00:
+	case 0x02:
+		/* If address public set dst_oui */
+		hwdb_get_company(conn->dst, &conn->dst_oui);
+		break;
+	case 0x01:
+	case 0x03:
+		/* Attempt to resolve the identity if resolvable */
+		if ((conn->dst[5] & 0xc0) == 0x40) {
+			keys_resolve_identity(conn->dst, conn->dst,
+						&conn->dst_type);
+			/* If identity address is public set dst_out */
+			if (conn->dst_type == 0x00 || conn->dst_type == 0x02) {
+				hwdb_get_company(conn->dst, &conn->dst_oui);
+				break;
+			}
+		}
+
+		/* Set the random type */
+		switch ((conn->dst[5] & 0xc0) >> 6) {
+		case 0x00:
+			conn->dst_rtype = strdup("Non-Resolvable");
+			break;
+		case 0x01:
+			conn->dst_rtype = strdup("Resolvable");
+			break;
+		case 0x03:
+			conn->dst_rtype = strdup("Static");
+			break;
+		default:
+			conn->dst_rtype = strdup("Reserved");
+			break;
+		}
+		break;
+	}
 }
 
 struct packet_conn_data *packet_get_conn_data(uint16_t handle)
@@ -329,7 +366,7 @@ struct packet_conn_data *packet_get_conn_data(uint16_t handle)
 	int i;
 
 	for (i = 0; i < MAX_CONN; i++) {
-		if (conn_list[i].handle == handle)
+		if (conn_list[i].handle == acl_handle(handle))
 			return &conn_list[i];
 	}
 
@@ -14047,6 +14084,43 @@ static void packet_enqueue_tx(struct timeval *tv, uint16_t handle,
 	queue_push_tail(conn->tx_q, frame);
 }
 
+static void handle_str_append_addr(char *handle_str,
+					struct packet_conn_data *conn)
+{
+	if (!conn)
+		return;
+
+	switch (conn->dst_type) {
+	case 0x00:
+	case 0x02:
+		if (conn->dst_oui) {
+			sprintf(handle_str + strlen(handle_str),
+				" [%2.2X:%2.2X:%2.2X:%2.2X:%2.2X:%2.2X (%.16s)]",
+				conn->dst[5], conn->dst[4], conn->dst[3],
+				conn->dst[2], conn->dst[1], conn->dst[0],
+				conn->dst_oui);
+			return;
+		}
+		break;
+	case 0x01:
+	case 0x03:
+		if (conn->dst_rtype) {
+			sprintf(handle_str + strlen(handle_str),
+				" [%2.2X:%2.2X:%2.2X:%2.2X:%2.2X:%2.2X (%.16s)]",
+				conn->dst[5], conn->dst[4], conn->dst[3],
+				conn->dst[2], conn->dst[1], conn->dst[0],
+				conn->dst_rtype);
+			return;
+		}
+		break;
+	}
+
+	sprintf(handle_str + strlen(handle_str),
+			" [%2.2X:%2.2X:%2.2X:%2.2X:%2.2X:%2.2X]",
+			conn->dst[5], conn->dst[4], conn->dst[3],
+			conn->dst[2], conn->dst[1], conn->dst[0]);
+}
+
 void packet_hci_acldata(struct timeval *tv, struct ucred *cred, uint16_t index,
 				bool in, const void *data, uint16_t size)
 {
@@ -14054,7 +14128,7 @@ void packet_hci_acldata(struct timeval *tv, struct ucred *cred, uint16_t index,
 	uint16_t handle = le16_to_cpu(hdr->handle);
 	uint16_t dlen = le16_to_cpu(hdr->dlen);
 	uint8_t flags = acl_flags(handle);
-	char handle_str[22], extra_str[32];
+	char handle_str[58], extra_str[32];
 	struct packet_conn_data *conn;
 	struct index_buf_pool *pool = &index_list[index].acl;
 
@@ -14089,6 +14163,8 @@ void packet_hci_acldata(struct timeval *tv, struct ucred *cred, uint16_t index,
 	else
 		sprintf(handle_str, "Handle %d", acl_handle(handle));
 
+	handle_str_append_addr(handle_str, conn);
+
 	sprintf(extra_str, "flags 0x%2.2x dlen %d", flags, dlen);
 
 	print_packet(tv, cred, in ? '>' : '<', index, NULL, COLOR_HCI_ACLDATA,
@@ -14118,7 +14194,8 @@ void packet_hci_scodata(struct timeval *tv, struct ucred *cred, uint16_t index,
 	const hci_sco_hdr *hdr = data;
 	uint16_t handle = le16_to_cpu(hdr->handle);
 	uint8_t flags = acl_flags(handle);
-	char handle_str[22], extra_str[32];
+	char handle_str[42], extra_str[32];
+	struct packet_conn_data *conn;
 
 	if (index >= MAX_INDEX) {
 		print_field("Invalid index (%d).", index);
@@ -14140,6 +14217,7 @@ void packet_hci_scodata(struct timeval *tv, struct ucred *cred, uint16_t index,
 
 	data += HCI_SCO_HDR_SIZE;
 	size -= HCI_SCO_HDR_SIZE;
+	conn = packet_get_conn_data(handle);
 
 	if (index_list[index].sco.total && !in)
 		sprintf(handle_str, "Handle %d [%u/%u]", acl_handle(handle),
@@ -14147,6 +14225,8 @@ void packet_hci_scodata(struct timeval *tv, struct ucred *cred, uint16_t index,
 	else
 		sprintf(handle_str, "Handle %d", acl_handle(handle));
 
+	handle_str_append_addr(handle_str, conn);
+
 	sprintf(extra_str, "flags 0x%2.2x dlen %d", flags, hdr->dlen);
 
 	print_packet(tv, cred, in ? '>' : '<', index, NULL, COLOR_HCI_SCODATA,
@@ -14175,8 +14255,9 @@ void packet_hci_isodata(struct timeval *tv, struct ucred *cred, uint16_t index,
 	const struct bt_hci_iso_data_start *start;
 	uint16_t handle = le16_to_cpu(hdr->handle);
 	uint8_t flags = acl_flags(handle);
-	char handle_str[36], extra_str[50], ts_str[16] = { 0 };
+	char handle_str[56], extra_str[50], ts_str[16] = { 0 };
 	struct index_buf_pool *pool = &index_list[index].iso;
+	struct packet_conn_data *conn;
 	size_t ts_size = 0;
 
 	if (index >= MAX_INDEX) {
@@ -14206,6 +14287,7 @@ void packet_hci_isodata(struct timeval *tv, struct ucred *cred, uint16_t index,
 	}
 
 	start = data;
+	conn = packet_get_conn_data(handle);
 
 	if (!in && pool->total)
 		sprintf(handle_str, "Handle %d [%u/%u] SN %u",
@@ -14214,6 +14296,8 @@ void packet_hci_isodata(struct timeval *tv, struct ucred *cred, uint16_t index,
 		sprintf(handle_str, "Handle %u SN %u", acl_handle(handle),
 			start->sn);
 
+	handle_str_append_addr(handle_str, conn);
+
 	sprintf(extra_str, "flags 0x%2.2x dlen %u slen %u%s", flags, hdr->dlen,
 							start->slen, ts_str);
 
diff --git a/monitor/packet.h b/monitor/packet.h
index 2990b795bd3e..f6547ec9b594 100644
--- a/monitor/packet.h
+++ b/monitor/packet.h
@@ -47,6 +47,10 @@ struct packet_conn_data {
 	uint8_t  type;
 	uint8_t  dst[6];
 	uint8_t  dst_type;
+	union {
+		char *dst_oui;
+		char *dst_rtype;
+	};
 	struct queue *tx_q;
 	struct queue *chan_q;
 	struct packet_latency tx_l;
-- 
2.52.0

