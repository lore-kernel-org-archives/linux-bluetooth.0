Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7801DE3A4
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Jun 2025 19:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750879056; cv=none; b=JtGmRC0j+pJuBDoVHtMXt0MmTcOHvys5F/DENj2pjVX1c73MLMSUPgFZudzC9dSzjQbF7/2e2xaohFaSaTvsL9GE5b2m8R4KVmObNTlIoLuzrTRy5zA3j43aTa04m5PhJe1N6VesxyAB8EkpPHUQ4fqCcE1JswatPtRJJoJdy64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750879056; c=relaxed/simple;
	bh=qgBKTQTihreZgpXGtsLgxek7L4xCsvztLtTYiomOfpY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=j7VIdUX2SNelUfUG64NNLVs1iHaWZjbATuKwokT+xl0EIm5lNlgxcd48XB0CTvL0TzpH1KzbydDt3RYHdyP237fuchMfNv2tIImLNWnKj5iDfk8QPRXobOfi5ASBoOVk4PFY0sxawaPCI3rp01TCTP4nM9Vt/04wN9UW3A+WlSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndrY+lIG; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndrY+lIG"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-531426c7143so79797e0c.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Jun 2025 12:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750879053; x=1751483853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6hfDH/eMMXBjbuafT7I34ztUK00b/g4EIIQZunf5xDU=;
        b=ndrY+lIGMojvjBu1uLpSaOX0AbeLCzqxf3HsnbdP+if8+xVtdT5YjAROxLOqF9ig/N
         huvbGyDS+QVY9TM36ZNE//W4w1l9ZMjxMmzSjef8rlEeNKaBink0jwf1PmSTSqba2lXe
         SXAedWD/pNdnuOnQdsuPwRxXs2Xb5x/zxfQAqbs2RJC/apID//mDHwtOKbCNBZEki//w
         +byvKsDXx2DYxiRHFRUzT6DcE2nfd4+FsShQVbvNI4D26g9BBFNzQ2rSGW2emmy0H7Dz
         VtKIRoSa8Yv0DTru1dmwY2wuUK35y6BLrTGA+/7xXNKAZr9l+/I/E63EVd3ihyJuYpe+
         TwrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750879053; x=1751483853;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6hfDH/eMMXBjbuafT7I34ztUK00b/g4EIIQZunf5xDU=;
        b=xUiTbuoVrWa5n6xyLvQmmNI8E5qYZtXjokXtQ9x3bNX2Zk1W8jVOV/Pyant+TVM7QU
         RHLQrYQjfN+CF8fnVCGXKco+d4aNSmwFv5m2eA3B3Ftz13V+wUK/tJKc45fy6GOVy2aa
         SkG6brEX9CKB4jqYWxtFkD4s1PuEVz/5YztMSeNMVuJEJevhptJfWY4J/iifdhOE6Lav
         lkHQ7yfTuArEyfOtTcRtwGhWAMOya2b4ARVt5gQPHLQMRR6Ix0KFe3WLBGYUYpPMbFpQ
         gD51Xz8bbTMpWU0d02yofyzHJu5xUyZ5CoLWw+hVX8j61wEJ29vJND51Hrx9LxB02V0m
         KzKA==
X-Gm-Message-State: AOJu0Yz8gOdD4+zk2ude9/6MdgcOjTH8rViGPVYRRM13kC4HzFZOW96T
	Z/i6ONQ3WbOk59ODCt6kT7m2alURsMAysaolKRDMyirDrdfIik3Rixv54XOXTp95
X-Gm-Gg: ASbGncs8/RvldNXF7LSKAOw4l+WwMF+dSq0uwjwCraE7Yqg3hOJrg743Fe9SfWAUmpL
	hLr6zbLREfGiLpik3T/ngqoRkq1Bta+W0zFkAckMVyr//ynpz0PZepbw+c0cF1/lH83u+wtaD4q
	Z8IxapUa+U6RFa0uv9TShQelytxhd5CP8SPQQ6oe0Yldsg/+w7jjaF7cRdfKt8CUMUdId1XkARL
	YsXwETyFGH7OwmlnXH3YqUM9Bzi9PcvfIHh6rwRRV4zg1CdjjzbfoW/4GiB/9yJkinp7bK81jhU
	NsO7H8PxSq08QclZw6ho5yfCXFarYWZghrFRSrjoEJ2zx0hCeJr8F9eeT477jLht8VgXQh6/IGe
	ppQPRlE6HS1x6Hh1G4jYegbTRf1oatGXRc1x2PR+njA==
X-Google-Smtp-Source: AGHT+IETfAmrPDaM83iANyT0lv2xkev1gOrrMipJjByHDfSLGHaVpkkjozwqgV+IRUc8fv4FeRQdXQ==
X-Received: by 2002:a05:6122:6593:b0:531:2906:7519 with SMTP id 71dfb90a1353d-532ef63b5a7mr3577178e0c.5.1750879052460;
        Wed, 25 Jun 2025 12:17:32 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-531ab37e3absm2063096e0c.39.2025.06.25.12.17.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 12:17:30 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] monitor: Print buffer pool information
Date: Wed, 25 Jun 2025 15:17:28 -0400
Message-ID: <20250625191728.44358-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This prints the number of buffers in transit and total information:

< ISO Data TX: Handle 2304 [1/8] flags 0x02 dlen 64 #1363
< ISO Data TX: Handle 2304 [2/8] flags 0x02 dlen 64 #1364
< ISO Data TX: Handle 2304 [3/8] flags 0x02 dlen 64 #1365
< ISO Data TX: Handle 2304 [4/8] flags 0x02 dlen 64 #1367
< ISO Data TX: Handle 2304 [5/8] flags 0x02 dlen 64 #1368
< ISO Data TX: Handle 2304 [6/8] flags 0x02 dlen 64 #1369
< ISO Data TX: Handle 2304 [7/8] flags 0x02 dlen 64 #1370
< ISO Data TX: Handle 2304 [8/8] flags 0x02 dlen 64 #1371
> HCI Event: Number of Completed Packets (0x13) plen 5
        Num handles: 1
        Handle: 2304 Address: FC:6D:77:BA:CF:A6 (Intel Corporate)
        Count: 1
        Buffers: 7/8
        #1363: len 64 (39 Kb/s)
        Latency: 13 msec (13-13 msec ~13 msec)
< ISO Data TX: Handle 2304 [8/8] flags 0x02 dlen 64
---
 monitor/packet.c | 143 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 123 insertions(+), 20 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index ba4701a35cb0..360cb09c48ee 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -122,6 +122,29 @@ struct ctrl_data {
 
 static struct ctrl_data ctrl_list[MAX_CTRL];
 
+#define MAX_INDEX 16
+
+struct index_buf_pool {
+	uint8_t total;
+	uint8_t tx;
+};
+
+struct index_data {
+	uint8_t  type;
+	uint8_t  bdaddr[6];
+	uint16_t manufacturer;
+	uint16_t msft_opcode;
+	uint8_t  msft_evt_prefix[8];
+	uint8_t  msft_evt_len;
+	size_t   frame;
+	struct index_buf_pool acl;
+	struct index_buf_pool sco;
+	struct index_buf_pool le;
+	struct index_buf_pool iso;
+};
+
+static struct index_data index_list[MAX_INDEX];
+
 static void assign_ctrl(uint32_t cookie, uint16_t format, const char *name)
 {
 	int i;
@@ -190,6 +213,33 @@ static struct packet_conn_data *lookup_parent(uint16_t handle)
 	return NULL;
 }
 
+static struct index_buf_pool *get_pool(uint16_t index, uint8_t type)
+{
+	if (index >= MAX_INDEX)
+		return NULL;
+
+	switch (type) {
+	case 0x00:
+		if (index_list[index].acl.total)
+			return &index_list[index].acl;
+		break;
+	case 0x01:
+		if (index_list[index].le.total)
+			return &index_list[index].le;
+		break;
+	case 0x05:
+		if (index_list[index].iso.total)
+			return &index_list[index].iso;
+		break;
+	default:
+		if (index_list[index].sco.total)
+			return &index_list[index].sco;
+		break;
+	}
+
+	return NULL;
+}
+
 static struct packet_conn_data *release_handle(uint16_t handle)
 {
 	int i;
@@ -198,9 +248,15 @@ static struct packet_conn_data *release_handle(uint16_t handle)
 		struct packet_conn_data *conn = &conn_list[i];
 
 		if (conn->handle == handle) {
+			struct index_buf_pool *pool;
+
 			if (conn->destroy)
 				conn->destroy(conn, conn->data);
 
+			pool = get_pool(conn->index, conn->type);
+			if (pool)
+				pool->tx -= queue_length(conn->tx_q);
+
 			queue_destroy(conn->tx_q, free);
 			queue_destroy(conn->chan_q, free);
 			memset(conn, 0, sizeof(*conn));
@@ -321,20 +377,6 @@ void packet_select_index(uint16_t index)
 
 #define print_space(x) printf("%*c", (x), ' ');
 
-#define MAX_INDEX 16
-
-struct index_data {
-	uint8_t  type;
-	uint8_t  bdaddr[6];
-	uint16_t manufacturer;
-	uint16_t msft_opcode;
-	uint8_t  msft_evt_prefix[8];
-	uint8_t  msft_evt_len;
-	size_t   frame;
-};
-
-static struct index_data index_list[MAX_INDEX];
-
 void packet_set_fallback_manufacturer(uint16_t manufacturer)
 {
 	int i;
@@ -6426,6 +6468,7 @@ static void read_local_ext_features_rsp(uint16_t index, const void *data,
 static void read_buffer_size_rsp(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_rsp_read_buffer_size *rsp = data;
+	struct index_data *ctrl;
 
 	print_status(rsp->status);
 	print_field("ACL MTU: %-4d ACL max packet: %d",
@@ -6434,6 +6477,15 @@ static void read_buffer_size_rsp(uint16_t index, const void *data, uint8_t size)
 	print_field("SCO MTU: %-4d SCO max packet: %d",
 					rsp->sco_mtu,
 					le16_to_cpu(rsp->sco_max_pkt));
+
+	if (index >= MAX_INDEX)
+		return;
+
+	ctrl = &index_list[index];
+	ctrl->acl.total = le16_to_cpu(rsp->acl_max_pkt);
+	ctrl->acl.tx = 0;
+	ctrl->sco.total = le16_to_cpu(rsp->sco_max_pkt);
+	ctrl->sco.tx = 0;
 }
 
 static void read_country_code_rsp(uint16_t index, const void *data,
@@ -7028,10 +7080,18 @@ static void le_read_buffer_size_rsp(uint16_t index, const void *data,
 							uint8_t size)
 {
 	const struct bt_hci_rsp_le_read_buffer_size *rsp = data;
+	struct index_data *ctrl;
 
 	print_status(rsp->status);
 	print_field("Data packet length: %d", le16_to_cpu(rsp->le_mtu));
 	print_field("Num data packets: %d", rsp->le_max_pkt);
+
+	if (index >= MAX_INDEX)
+		return;
+
+	ctrl = &index_list[index];
+	ctrl->le.total = rsp->le_max_pkt;
+	ctrl->le.tx = 0;
 }
 
 static void le_read_local_features_rsp(uint16_t index, const void *data,
@@ -8654,6 +8714,7 @@ static void le_read_buffer_size_v2_rsp(uint16_t index, const void *data,
 							uint8_t size)
 {
 	const struct bt_hci_rsp_le_read_buffer_size_v2 *rsp = data;
+	struct index_data *ctrl;
 
 	print_status(rsp->status);
 
@@ -8664,6 +8725,15 @@ static void le_read_buffer_size_v2_rsp(uint16_t index, const void *data,
 	print_field("ACL max packet: %d", rsp->acl_max_pkt);
 	print_field("ISO MTU: %d", le16_to_cpu(rsp->iso_mtu));
 	print_field("ISO max packet: %d", rsp->iso_max_pkt);
+
+	if (index >= MAX_INDEX)
+		return;
+
+	ctrl = &index_list[index];
+	ctrl->le.total = rsp->acl_max_pkt;
+	ctrl->le.tx = 0;
+	ctrl->iso.total = rsp->iso_max_pkt;
+	ctrl->iso.tx = 0;
 }
 
 static void le_read_iso_tx_sync_cmd(uint16_t index, const void *data,
@@ -11123,12 +11193,23 @@ static void packet_dequeue_tx(struct timeval *tv, uint16_t handle)
 {
 	struct packet_conn_data *conn;
 	struct packet_frame *frame;
+	struct index_buf_pool *pool;
 	struct timeval delta;
 
 	conn = packet_get_conn_data(handle);
 	if (!conn)
 		return;
 
+	pool = get_pool(conn->index, conn->type);
+	if (pool) {
+		if (!pool->tx)
+			print_field("Buffers: underflow/%u", pool->total);
+		else {
+			pool->tx--;
+			print_field("Buffers: %u/%u", pool->tx, pool->total);
+		}
+	}
+
 	frame = queue_pop_head(conn->tx_q);
 	if (!frame)
 		return;
@@ -13853,7 +13934,9 @@ void packet_hci_acldata(struct timeval *tv, struct ucred *cred, uint16_t index,
 	uint16_t handle = le16_to_cpu(hdr->handle);
 	uint16_t dlen = le16_to_cpu(hdr->dlen);
 	uint8_t flags = acl_flags(handle);
-	char handle_str[16], extra_str[32];
+	char handle_str[22], extra_str[32];
+	struct packet_conn_data *conn;
+	struct index_buf_pool *pool = &index_list[index].acl;
 
 	if (index >= MAX_INDEX) {
 		print_field("Invalid index (%d).", index);
@@ -13876,7 +13959,16 @@ void packet_hci_acldata(struct timeval *tv, struct ucred *cred, uint16_t index,
 	data += HCI_ACL_HDR_SIZE;
 	size -= HCI_ACL_HDR_SIZE;
 
-	sprintf(handle_str, "Handle %d", acl_handle(handle));
+	conn = packet_get_conn_data(handle);
+	if (conn && conn->type == 0x01 && index_list[index].le.total)
+		pool = &index_list[index].le;
+
+	if (!in && pool && pool->total)
+		sprintf(handle_str, "Handle %d [%u/%u]", acl_handle(handle),
+				++pool->tx, pool->total);
+	else
+		sprintf(handle_str, "Handle %d", acl_handle(handle));
+
 	sprintf(extra_str, "flags 0x%2.2x dlen %d", flags, dlen);
 
 	print_packet(tv, cred, in ? '>' : '<', index, NULL, COLOR_HCI_ACLDATA,
@@ -13906,7 +13998,7 @@ void packet_hci_scodata(struct timeval *tv, struct ucred *cred, uint16_t index,
 	const hci_sco_hdr *hdr = data;
 	uint16_t handle = le16_to_cpu(hdr->handle);
 	uint8_t flags = acl_flags(handle);
-	char handle_str[16], extra_str[32];
+	char handle_str[22], extra_str[32];
 
 	if (index >= MAX_INDEX) {
 		print_field("Invalid index (%d).", index);
@@ -13929,7 +14021,12 @@ void packet_hci_scodata(struct timeval *tv, struct ucred *cred, uint16_t index,
 	data += HCI_SCO_HDR_SIZE;
 	size -= HCI_SCO_HDR_SIZE;
 
-	sprintf(handle_str, "Handle %d", acl_handle(handle));
+	if (index_list[index].sco.total && !in)
+		sprintf(handle_str, "Handle %d [%u/%u]", acl_handle(handle),
+			index_list[index].sco.total, index_list[index].sco.tx);
+	else
+		sprintf(handle_str, "Handle %d", acl_handle(handle));
+
 	sprintf(extra_str, "flags 0x%2.2x dlen %d", flags, hdr->dlen);
 
 	print_packet(tv, cred, in ? '>' : '<', index, NULL, COLOR_HCI_SCODATA,
@@ -13957,7 +14054,8 @@ void packet_hci_isodata(struct timeval *tv, struct ucred *cred, uint16_t index,
 	const struct bt_hci_iso_hdr *hdr = data;
 	uint16_t handle = le16_to_cpu(hdr->handle);
 	uint8_t flags = acl_flags(handle);
-	char handle_str[16], extra_str[32];
+	char handle_str[22], extra_str[32];
+	struct index_buf_pool *pool = &index_list[index].iso;
 
 	if (index >= MAX_INDEX) {
 		print_field("Invalid index (%d).", index);
@@ -13980,7 +14078,12 @@ void packet_hci_isodata(struct timeval *tv, struct ucred *cred, uint16_t index,
 	data += sizeof(*hdr);
 	size -= sizeof(*hdr);
 
-	sprintf(handle_str, "Handle %d", acl_handle(handle));
+	if (!in && pool->total)
+		sprintf(handle_str, "Handle %d [%u/%u]", acl_handle(handle),
+			++pool->tx, pool->total);
+	else
+		sprintf(handle_str, "Handle %d", acl_handle(handle));
+
 	sprintf(extra_str, "flags 0x%2.2x dlen %d", flags, hdr->dlen);
 
 	print_packet(tv, cred, in ? '>' : '<', index, NULL, COLOR_HCI_ISODATA,
-- 
2.49.0

