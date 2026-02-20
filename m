Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4C835F8D6
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Feb 2026 17:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771608701; cv=none; b=Jh8aGO1UcKqt7E5jWzH7g4CdQrjfqd1uCKZoI3Nl7U6+X/CuirnOyXuulOCVoqTtIam9VoM1vxlkcMzAarksr600x/+YS6mTYsupDAcReZVudLgID4fkIOOmnZZ/KkhNO4SUUjYVKe8Y0KLDmZ3UhmkhFSWy1NoUTD12QDvdZ0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771608701; c=relaxed/simple;
	bh=DghqkDSZnJx7xPBxaYg1VtWc4EQewhnEUuHyrdZoayQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QkSwMBQ01JtOP44GixRSDEEyf7mQvmdOO6ScFRFnwREa0jyL0/GJfUbh8M0eGPkNU2ySs5CzgmX0EPUVIusZTo8gpbtf5+eVYUz1czMENtld4p1X+I/GXXXQB47W7FPkeB2iOIzKU5Em8BPLbLRuitGQzA27vQaaeleIG6MvKZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DdLeni3a; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DdLeni3a"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5662c2937fdso2110977e0c.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Feb 2026 09:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771608699; x=1772213499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+fFwFRec0/iMaA81v94JZTtdiByYb3b+1BAjF09gg5c=;
        b=DdLeni3aCeQ4rK5MEW1O/OJdSEpP634OE6T+9oKRrZdWVQ7J0yPtKEFZSAbnb8NqNr
         N6xHtper2yV30kD1zSoVd07m3efYRKjOe6eqj6HqRRrdkJud7llRboms8vty7CFFVNKt
         6bsDdzDq4QcXdU55201/wllkfLmXS2PBwII7Io9M7k4ldPuwjeGKqt39TMKCr8wE/7yD
         FeWKmODp4KIwn3TDyQHY4ZIaSMIixoOAX9mPesqj7AmVu1IVylWYDOAvqJkYvFpZr7UF
         Uxssf+/ZqgYQDu0v7PgrKBCtJGkkVDdtneIwNt4udlVGLqaVLuVWwrVZ2/dIvFPOEnBM
         7CAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771608699; x=1772213499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+fFwFRec0/iMaA81v94JZTtdiByYb3b+1BAjF09gg5c=;
        b=AvPd4sc5Mcf/IMMi4zI+0V5h6ztK+dnMloVoOBIRg8f1Q0rAXR7dHGhPXfdaqcQ9BF
         LwCaW6oLtaywt7qaGHl01PdP0LLfOAtYJBjUR60j0hkrU2WTXNaopaoAeJeexhYEDpc3
         4ZN281Yu0fy/R09MViBaGeAQITsuHt6O5dPmxHMsv2BQbKxqben0rXluwfntZVYXD3tH
         R3AQSF8+4M30SDeI4uPqNeTFrKIPmXxwJtNUeX7bAL1viH+HdBKq8r2PH+gprIjtofIJ
         jZqN04XsBlK1X40ud25Lp3iMjGPcexliyJPjrz0EafCK2xzHzC/BqvPy49sgCmEDr/wN
         y4pg==
X-Gm-Message-State: AOJu0Yy+H+fP8yVGqNh5Mk+zzWMNGE6w+C5N0UNJKjnSmt1zdwlNDpUa
	F7skk3KX+rrLoekdlofdq/hTfx8vEeZuOEFbA6nZcgk/3wZ7lJZNV6mhDmrliQ==
X-Gm-Gg: AZuq6aJUnwyWDThN9ChrzRYYGDbmZVAirNY0mAWdRBFm3iPxFSGS9H8yfjx4hN+F6UO
	OgQrH+pRYcWsoDdUT34aVgw3kpH8FA0MCH39f8RHFg3udrsyoxyyBR5cQ7UzZ1XCWxfmOHw/aLk
	Yp0XRqYzgeG0hHwv4cCt9j3TnWSvEzkpFxn/1RG/VYBJQCl+JBuUO/bcrYNfEn49KnnnTp5zCEI
	IFJrlheL2t8oBqbpMpMCc+AVa0QtG17qiUNr0DdnQoRlT08ZlyrYCD+uqvVPJ/6hWv8WziZ685D
	/bG32Kmb2Lm8+TRodmS2cjkNyO0uUs4W2RXBf6Y9AU3jozOF9YNTLuK0xISSk2dQ7hKdtIzI359
	f/pn9q/WDUdez2+sRqeG/5wsgRrpe7PnuRy6jWiNGmffpDT3YZ2Stb1JpNPjK3Jd7LDHpymZfnK
	V9U6yspQCksBpRZ5QDK22poF6+T+EZlZhbevDG9LyArsuTquoiig71VyKtrBkxozxsDnezKytz/
	OJcn6Ub8pNFuJXrig==
X-Received: by 2002:a05:6122:3c4e:b0:559:6788:7b55 with SMTP id 71dfb90a1353d-568e452a42emr316290e0c.3.1771608696948;
        Fri, 20 Feb 2026 09:31:36 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94da8b3eefdsm77864241.9.2026.02.20.09.31.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 09:31:36 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 08/12] monitor: Annotate ACL/SCO/ISO data with device address
Date: Fri, 20 Feb 2026 12:31:12 -0500
Message-ID: <20260220173120.3418666-8-luiz.dentz@gmail.com>
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

