Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738002E6CCD
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 16:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783700711; cv=pass; b=Dz5J06ZYmvzjh1UAQw6OtFc6mxohoDcMOJM6MP1NTqdtvs3Uc5gSlvTqACpnIE6h2vXYswDoZ/6KaPbik3XFxENr6/Pxmi1pl5r6NDzxNTzuDMVoAeon97+ti1nJFF9wcalYFHNA3XE1bXRl/SQSWoj80thAlLI/MQll2yxFdAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783700711; c=relaxed/simple;
	bh=thWwuiCcUUk01HF5ro3ZbhRseVjTwDa5KlXpABiLoNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xcdp9uVX/HR/Ymkc3F8bsLm3RhfWqDxjBIIZ62+HqB9CNlFryu4NlFrEV1KMg7LrlijfhgwyOjjMG2jYHC5Sn385B0xNibMcNhmcXXVowHee+0Gb+VBMIZRf8h9UH4Nuf71YI9loRmdDyIk2zRZoB+XumAv74RaiWJ0qgumdZe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=Vt4YGCAm; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="Vt4YGCAm"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a03d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gxccg5qvSzybm;
	Fri, 10 Jul 2026 19:25:07 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1783700708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A7z30uCdMI8arYU8WZehy3Bxzf2fKIUUzI/mIDHTpdc=;
	b=Vt4YGCAmzNmtaUUGHnOSdBAIzqP5cE+QGGB0FMQh43w3EScTcDItRRnalFt3ls/uqOe9Me
	l5SFMAwVjiRtZo8wDlun3GwGx5RZDMcw6ecVW0MaN4vO+STLtKp28mBb3xIUxLGUN76NRZ
	vbuArkFS5FTEp406jGzij/PbGqct+FU=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1783700708;
	b=eIb8JPsKjlqovU+FsAiy8KxdCocGbF+bdF/26f36hdNDNrEdT0C+usea8MZW5xcenlYegJ
	S5ZpUcu7RP3x9uW9OcOGc41Gp9htLOreEHIdMPzTJg0empb/E/+JaJgEKe7/x7IPCG4CKX
	6kimbCn7FLDlOjfvrXSma3S0L0nU4as=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1783700708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A7z30uCdMI8arYU8WZehy3Bxzf2fKIUUzI/mIDHTpdc=;
	b=d9Y1QWOb01ELBAG4G//Fe7YVwwedRIEHoU/MQI+DtYYxPbcO/DWSjEYVSihOZ8QMb4k1TX
	xMu1Mh0aigOZL5+pfoHZ7kHmsz4P5Edf0uRgz2A8pPiYt50QuznNU1+ZrqwZyaCfn13l8M
	mGORiWQwCswu9cHZRnQ9vqnYrNZL63c=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 2/2] monitor: fix parsing of ISO packet data header and slen check
Date: Fri, 10 Jul 2026 19:25:02 +0300
Message-ID: <484a5fa9911e1e31de58caa0deee234a0ed6d52b.1783700260.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <e2b3c5425a653eb198700cb28c453607e2d82840.1783700260.git.pav@iki.fi>
References: <e2b3c5425a653eb198700cb28c453607e2d82840.1783700260.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check PB flag to see whether timestamp and data headers are present.

Check bounds before accessing data. Bump handle_str length to fit
maximum.

Byteswap length values, and mask Packet_Status_Flag correctly.  Remove
SDU length check, as we are not tracking fragmentation.

Fixes: https://github.com/bluez/bluez/issues/2292
Assisted-by: GLM-5.2
---
 monitor/packet.c | 60 +++++++++++++++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 23 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index e62ad4cfb..afa43eac8 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -14540,20 +14540,23 @@ void packet_hci_isodata(struct timeval *tv, struct ucred *cred, uint16_t index,
 				bool in, const void *data, uint16_t size)
 {
 	const struct bt_hci_iso_hdr *hdr = data;
-	const struct bt_hci_iso_data_start *start;
-	uint16_t handle = le16_to_cpu(hdr->handle);
-	uint8_t flags = acl_flags(handle);
+	uint16_t handle, dlen;
+	uint8_t flags, pb_flag;
 	char label[8];
-	char handle_str[56], extra_str[50], ts_str[16] = { 0 };
-	struct index_buf_pool *pool = &index_list[index].iso;
+	char handle_str[100], extra_str[60], ts_str[16] = { 0 };
+	char sn_str[16] = { 0 }, slen_str[32] = { 0 };
+	struct index_buf_pool *pool;
 	struct packet_conn_data *conn;
 	size_t ts_size = 0;
+	bool have_hdr;
 
 	if (index >= MAX_INDEX) {
 		print_field("Invalid index (%d).", index);
 		return;
 	}
 
+	pool = &index_list[index].iso;
+
 	index_list[index].frame++;
 
 	if (size < sizeof(*hdr))
@@ -14562,11 +14565,18 @@ void packet_hci_isodata(struct timeval *tv, struct ucred *cred, uint16_t index,
 	data += sizeof(*hdr);
 	size -= sizeof(*hdr);
 
+	handle = le16_to_cpu(hdr->handle);
+	flags = acl_flags(handle);
+	pb_flag = iso_flags_pb(flags);
+	dlen = le16_to_cpu(hdr->dlen);
+
+	have_hdr = (pb_flag == 0x00 || pb_flag == 0x02);
+
 	/* Detect if timestamp field is preset */
 	if (iso_flags_ts(flags)) {
 		ts_size = sizeof(uint32_t);
 
-		if (size < ts_size)
+		if (size < ts_size || !have_hdr)
 			goto malformed;
 
 		snprintf(ts_str, sizeof(ts_str), " ts %u", get_le32(data));
@@ -14575,20 +14585,31 @@ void packet_hci_isodata(struct timeval *tv, struct ucred *cred, uint16_t index,
 		size -= ts_size;
 	}
 
-	start = data;
+	if (have_hdr) {
+		const struct bt_hci_iso_data_start *start = data;
+
+		if (size < sizeof(*start))
+			goto malformed;
+
+		snprintf(sn_str, sizeof(sn_str), " SN %u",
+							le16_to_cpu(start->sn));
+		snprintf(slen_str, sizeof(slen_str), " slen %u sflags %u",
+				iso_data_len(le16_to_cpu(start->slen)),
+				iso_data_flags(le16_to_cpu(start->slen)));
+	}
+
 	conn = packet_get_conn_data(handle);
 
 	if (!in && pool->total)
-		sprintf(handle_str, "Handle %d [%u/%u] SN %u",
-			acl_handle(handle), ++pool->tx, pool->total, start->sn);
+		sprintf(handle_str, "Handle %d [%u/%u]%s",
+			acl_handle(handle), ++pool->tx, pool->total, sn_str);
 	else
-		sprintf(handle_str, "Handle %u SN %u", acl_handle(handle),
-			start->sn);
+		sprintf(handle_str, "Handle %u%s", acl_handle(handle), sn_str);
 
 	handle_str_append_addr(handle_str, conn);
 
-	sprintf(extra_str, "flags 0x%2.2x dlen %u slen %u%s", flags, hdr->dlen,
-							start->slen, ts_str);
+	sprintf(extra_str, "flags 0x%2.2x dlen %u%s%s", flags, dlen, slen_str,
+									ts_str);
 
 	if (conn)
 		sprintf(label, "%s", conn_type_str(conn->type));
@@ -14600,18 +14621,11 @@ void packet_hci_isodata(struct timeval *tv, struct ucred *cred, uint16_t index,
 
 	if (!in)
 		packet_enqueue_tx(tv, acl_handle(handle),
-					index_list[index].frame, hdr->dlen);
+					index_list[index].frame, dlen);
 
-	if (size + ts_size != hdr->dlen) {
+	if (size + ts_size != dlen) {
 		print_text(COLOR_ERROR, "invalid packet size (%d != %d)",
-						size + (int)ts_size, hdr->dlen);
-		packet_hexdump(data, size);
-		return;
-	}
-
-	if (size != start->slen + 4) {
-		print_text(COLOR_ERROR, "invalid packet slen (%d+4 != %d)",
-							start->slen, size);
+						size + (int)ts_size, dlen);
 		packet_hexdump(data, size);
 		return;
 	}
-- 
2.55.0

