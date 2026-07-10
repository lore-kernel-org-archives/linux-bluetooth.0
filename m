Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCD0378824
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 18:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783707182; cv=pass; b=JzO1NXIHWvCCGisOcqO/DGWhc4isfCHOIRSXqT8O2NciWQDdH9CUm4fcJKqdbz1n4KNAAFuZnQdKZQ7n3KHxFvdIZ3aR68Ds+ltUCRkS8EDeVJpmdIuz3yARcWqye3Ffj1OF+ikfTMumldvVjt/vpVUoUisAWcqYrbuGQNEqzpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783707182; c=relaxed/simple;
	bh=3hWGxbGh62ZLIREDvTUfTavw/+JyMhe7l092RH9KSsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MPe83iroBOHb/GqqDeUA9Cu038mkIHQbT62o2nrarg3oJ8T6boRNCz4raleTR34QTh1gekHFS/A/ix04ySK/8IO7pHDAm4aQ0ivPeMJzNO/is5V1FFfnJndUb9PJEJWouRHgmTwuQ3MdYodtqlSBk7hyGw3WwVzmQiRW/LZVcX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=GfDVBlwr; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="GfDVBlwr"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a03d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gxg155gJRzybm;
	Fri, 10 Jul 2026 21:12:57 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1783707177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZCtNrYl/jlanyfHK8K0VVhig17Ne58hLlc5SxTirAiU=;
	b=GfDVBlwrajTnNFr5GD0lWhP2GID8vosuUyiyzMIduNJ5VGbMwkUHJYaH7yzuh4uySOJqiU
	IWTEb1oJPKjwrZW0PnmooGUYDsk3Djlpdosf0EvK+uYCevgy++Xyu2QmKXlYipycib2Ayz
	3bXk1/AhnCx51bMDHJrwasRoOoCwH1w=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1783707178;
	b=L9KY4e4G19LqzUEJ1he91SWFNvJVCoc1si1z7w02c2z82KL4+sewbbMPsImmc7YRw8ADTS
	EbsCTotJTjH/IUz5TmKjbQenX2nO9Vm36FxUYlnwilFtE43Hjlg8ioLB97SdkWzI0kPqYV
	r2aYO+fBGakjEHPCFKfBcHwvmehlN0g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1783707177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZCtNrYl/jlanyfHK8K0VVhig17Ne58hLlc5SxTirAiU=;
	b=HlnDMup0Jkg4jOCp+gzcAv7y0veLu9l6l+ehWwAlh8u0H6RXK//jrnWG+URHbp3TzyqMOO
	anC2xOCj2qZhx+WCvo/WlqzPOtPB+ROaK2x5PQcl+hQMmQxJ5onCYkN+O20OEus03yULkE
	P/jrUkVSAtk+2B0YVj07CxiVqudEbBA=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 2/2] monitor: fix parsing of ISO packet data header and slen check
Date: Fri, 10 Jul 2026 21:12:55 +0300
Message-ID: <c3adb30ff640e151c09b50fd7a560111f0cd6cf8.1783707145.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <e2b3c5425a653eb198700cb28c453607e2d82840.1783707145.git.pav@iki.fi>
References: <e2b3c5425a653eb198700cb28c453607e2d82840.1783707145.git.pav@iki.fi>
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

Notes:
    v2:
    - increase extra_str size to avoid old gcc version static analysis
      false positive

 monitor/packet.c | 60 +++++++++++++++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 23 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index e62ad4cfb..a478cf93a 100644
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
+	char handle_str[100], extra_str[70], ts_str[16] = { 0 };
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

