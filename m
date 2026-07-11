Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527CB182D6
	for <linux-bluetooth@vger.kernel.org>; Sat, 11 Jul 2026 09:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783761348; cv=pass; b=QBFfchGJdSSzeVIlZ3Bvb8TBX9sqxrKaTeKbeKbr85E92FT8L7Jutydi3iYvvfY6G9BESxO2T7wDmNWQ5Kbq7BMvM5B9awQpBjSYddZ2q6S9tNGvwUqi4bX6QrtesapjgvZKjcErzzKhENnRddW1Tw8+leW1VeJR/ikymOvwbIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783761348; c=relaxed/simple;
	bh=5vbR6cnJxMuzGWPLYMvwFpOhqYW62WxrxSO1/BAiFQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uA0pMAk1rmiQUDNmsXt8M+oMj6YwXBxigIGgVjt5896LCJGh6I6/0xH1ZgpeDYcOtsFJhIx8j0ZmQ7H6cpjab+hBYhsyOu7NQc3+JH/PhxJSpqI4YjjfGbi9/MCZk6VkZBlLALnQTNjzFz1xuhBJSm+4Jt/8XWmFHNKHrNcOVgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=n35bOrVR; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="n35bOrVR"
Received: from monolith.lan (unknown [185.65.133.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4gy32Y43Ndz49Q3W;
	Sat, 11 Jul 2026 12:15:33 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1783761333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KWnupiAEhIuOFVB3qOe/HiAanH8B1zEo1n7JPifjXQs=;
	b=n35bOrVREdSyLq1zEvxdKmmMuLtbgioz1KpCJ3aJYomW2H0vq9PvXgHpiZDGNBQ2wyooB/
	yXZS6cx41hDWQqb/vtVuiDGfPVjg520hkEO+l7H7iJz5t2HNIqYamGr6VMN62BmsDRHemm
	l/S7ODox2cmFI9CQoQOgvFd59gTw1R0bCfxWlHiluP8/svudpzfQTdZwwaz4C12zIvdKSx
	ZuK31cuzxogEtDyKkgb1y1f0/efZ4UV0bTbPqblztq4CS3S/gK4k1wTjgU+MKL4jDhiWPN
	iZWGHZxy2jo6YFoCa2UUykwG96yHW9UpGJJLnBQlaq3m6Kj0zCGIzx/b4ZAVoQ==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1783761333;
	b=NWYCkwKhusIz7BM7d9U5sBL6GTAbON/JCzxvLfYHfkBLKUeb990blenJ7rQMcYKU2Vlpcn
	dQ8H3FKkm+HZZG6sp1v8aNVdjJB2TLyGfJXwethvDfTjZfaDg/54zL2vlAJk0eMCB1dy5l
	SqK0XzRRgb18vLQVKjVgOcW567ClsoXFEnqOKlgLrip7p+/xEAN8+FMus7yDWr6bRDGc2S
	n6jB7blHRDhlscK/U9e+DydtYd6coibSXHjxeZ4jrtrkv5VrO55/G8xwnwXuLeb0LWQWxH
	Z02t/FYscZyUyY7eA9CEBjEmyLctDCurZy4OldI+BR/r6ICoFelL4eX6BKg0CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1783761333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KWnupiAEhIuOFVB3qOe/HiAanH8B1zEo1n7JPifjXQs=;
	b=G6tK0m2jd/eAmrJ3Qq8GumyoNCbxWhuXY0dGzofCP1h9SPoZkLQnkv8eXMY0H7DmwCJ3QF
	F/lJ1cUCblNhgFsUvPuf9CCQMeC7U6JdnWFARmn5iUyO/p0cpAIus32nwuv2ercrz1wmqq
	b58f4s+ce7KLw0FZGnjJc7er4dEWM/6MnrhzZQknmAo9xOY5LKS03e2/ykM2Ajdu22EW5R
	xocv/0YnRKAoHqTUuqfLtO4qEBtJ0F7h/KAh3UY4Fp4qdWFJ3LWrdp2UWX7UMTIGbHOcNu
	8zSWE7nD0rZEUpe6iY8Nit0skyExEeTZladvo3zeu6cCD+uUwsQUZ+FHcmiKRA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v3 2/2] monitor: fix parsing of ISO packet data header and slen check
Date: Sat, 11 Jul 2026 12:15:26 +0300
Message-ID: <695bfe0d406785fd2dd75ca5b59410cca5885fc9.1783761325.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <e2b3c5425a653eb198700cb28c453607e2d82840.1783761325.git.pav@iki.fi>
References: <e2b3c5425a653eb198700cb28c453607e2d82840.1783761325.git.pav@iki.fi>
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
    v3:
    - show slen and sflags only if nonzero
    v2:
    - increase extra_str size to avoid old gcc version static analysis
      false positive

 monitor/packet.c | 69 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 46 insertions(+), 23 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index e62ad4cfb..4420efffe 100644
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
@@ -14575,20 +14585,40 @@ void packet_hci_isodata(struct timeval *tv, struct ucred *cred, uint16_t index,
 		size -= ts_size;
 	}
 
-	start = data;
+	if (have_hdr) {
+		const struct bt_hci_iso_data_start *start = data;
+		uint8_t sflags;
+		uint16_t slen;
+
+		if (size < sizeof(*start))
+			goto malformed;
+
+		sflags = iso_data_flags(le16_to_cpu(start->slen));
+		slen = iso_data_len(le16_to_cpu(start->slen));
+
+		if (slen)
+			snprintf(slen_str, sizeof(slen_str), " slen %u", slen);
+		if (sflags)
+			snprintf(slen_str + strlen(slen_str),
+					sizeof(slen_str) - strlen(slen_str),
+					" sflags %u", sflags);
+
+		snprintf(sn_str, sizeof(sn_str), " SN %u",
+							le16_to_cpu(start->sn));
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
@@ -14600,18 +14630,11 @@ void packet_hci_isodata(struct timeval *tv, struct ucred *cred, uint16_t index,
 
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

