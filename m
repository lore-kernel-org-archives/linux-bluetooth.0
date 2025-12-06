Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9DC1F30A9
	for <linux-bluetooth@vger.kernel.org>; Sat,  6 Dec 2025 14:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765030321; cv=pass; b=qtmDiz7TC/gxw9+q/goSrNrYgsRE1a3WbUZhff0UAJ3tvI2vgLuBVfdmfx95OEozgz4QhlEv+fgCeORP00zOhh89P+Su82blwAzJQOcCHez9+b0vgOd+qkt+2egNBkAK0Tuj7fQPqP1fM2VQSU2FC8m1Tt/SvLwhPqL6+XT0ypo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765030321; c=relaxed/simple;
	bh=wuGi/Um9cMdWUiW4hsDVmYPa+8WvvduhUnLCkJxXlv4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nhu8r153g0EuGqlSULDOXEZT6tfY1M4Rz6zyvJkCJZhru6erPYNTH0WXLgzZaEqx51DpsPczVfqFuFjj0t0GtegfxPPmcozLI+/W7EdRmoR8IDjvbAMvV16N6Hs3rs00l+35D+8dlAaxPNBpz1fk4cV42HlqWzjLPrl9Bmvwz6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=Z1xw8AIp; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="Z1xw8AIp"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a01d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dNqth2G5bzyW9;
	Sat,  6 Dec 2025 16:11:56 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1765030317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yS8qg3LvxCYmYNRyrC7oQXcE7uwHvA+5HwzWW/6xgOg=;
	b=Z1xw8AIpSLAViGx8lhphjBzf1rsp7/XzJbo8kGO/YI1a4f4HTaoVPXPgUgms7SCny4zW0k
	FFqd4pIXhi61LiEMF2UdVh/4iVePPtg2sLQ8TqnW0mC/pjlqfHLU/CzKfxWtaC2mdCfoUn
	LAo5MJT6l8pSa12v5nyZXGlxmP+L3cs=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1765030317;
	b=b6Z6Cfb9VMMRkzxjpHep5NXMe03ZkCSnUlSAKvaSEEREbmgpp3aUhQaJsAa1Ms40hTL3bp
	bPKIEbCoMGWhL8IWfGFShl+6BYhfm7fdIO4GkMEzLcwJSjQhvAaPYOSJ82V6E+3V4zlvjl
	yUfc8NREvx1kSrDFXAAvme5zS7g4kEU=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1765030317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yS8qg3LvxCYmYNRyrC7oQXcE7uwHvA+5HwzWW/6xgOg=;
	b=JMdw4TRlZTduIABVA68OpwjrRk7U5SFK9GfJ7UDWDRMbmuwr1L5I91pJsCwlqJy8TfF0vC
	vN39ELpmlsdrVdyms+Ldurd4J+r0OqVyerw2Fez8CD3mL0/D1d9X2OAsENjcWevoC/JGr4
	p0l8ZSpMMZCAC2GKP7RlajIhNysYaNo=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] monitor: show ISO timestamps and fix their handling
Date: Sat,  6 Dec 2025 16:11:52 +0200
Message-ID: <d86bbd8809c75dea5107ddd0f63f300d3e9c6423.1765030276.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix ISO packet size checks, taking timestamp presence into account.

Also display timestamp value if present.
---
 monitor/packet.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index 2ae4f8fff..4f90c412d 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -14205,8 +14205,9 @@ void packet_hci_isodata(struct timeval *tv, struct ucred *cred, uint16_t index,
 	const struct bt_hci_iso_data_start *start;
 	uint16_t handle = le16_to_cpu(hdr->handle);
 	uint8_t flags = acl_flags(handle);
-	char handle_str[36], extra_str[33];
+	char handle_str[36], extra_str[50], ts_str[16] = { 0 };
 	struct index_buf_pool *pool = &index_list[index].iso;
+	size_t ts_size = 0;
 
 	if (index >= MAX_INDEX) {
 		print_field("Invalid index (%d).", index);
@@ -14223,11 +14224,15 @@ void packet_hci_isodata(struct timeval *tv, struct ucred *cred, uint16_t index,
 
 	/* Detect if timestamp field is preset */
 	if (iso_flags_ts(flags)) {
-		if (size < sizeof(uint32_t))
+		ts_size = sizeof(uint32_t);
+
+		if (size < ts_size)
 			goto malformed;
 
-		data += sizeof(uint32_t);
-		size -= sizeof(uint32_t);
+		snprintf(ts_str, sizeof(ts_str), " ts %u", get_le32(data));
+
+		data += ts_size;
+		size -= ts_size;
 	}
 
 	start = data;
@@ -14239,8 +14244,8 @@ void packet_hci_isodata(struct timeval *tv, struct ucred *cred, uint16_t index,
 		sprintf(handle_str, "Handle %u SN %u", acl_handle(handle),
 			start->sn);
 
-	sprintf(extra_str, "flags 0x%2.2x dlen %u slen %u", flags, hdr->dlen,
-		start->slen);
+	sprintf(extra_str, "flags 0x%2.2x dlen %u slen %u%s", flags, hdr->dlen,
+							start->slen, ts_str);
 
 	print_packet(tv, cred, in ? '>' : '<', index, NULL, COLOR_HCI_ISODATA,
 				in ? "ISO Data RX" : "ISO Data TX",
@@ -14250,9 +14255,16 @@ void packet_hci_isodata(struct timeval *tv, struct ucred *cred, uint16_t index,
 		packet_enqueue_tx(tv, acl_handle(handle),
 					index_list[index].frame, hdr->dlen);
 
-	if (size != hdr->dlen) {
+	if (size + ts_size != hdr->dlen) {
 		print_text(COLOR_ERROR, "invalid packet size (%d != %d)",
-							size, hdr->dlen);
+						size + (int)ts_size, hdr->dlen);
+		packet_hexdump(data, size);
+		return;
+	}
+
+	if (size != start->slen + 4) {
+		print_text(COLOR_ERROR, "invalid packet slen (%d+4 != %d)",
+							start->slen, size);
 		packet_hexdump(data, size);
 		return;
 	}
-- 
2.51.1

