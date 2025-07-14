Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6767265293
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 15:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752507397; cv=none; b=BHZ5bIqAT4uXvIpeFAwIE89Fh68L8GVTyWVhCtE+8hge1W6EDdC8dVgZFeO8bInbC3yZh3ftCjHezn7RrXRZs+FwQXPkYVW9FLkXYYI+9y9EtZJT+F4QdRO6phlIWcObqJ6RLSQ4N80ZP+i4RpISrn9j2eaPRK8A2r7R1/kVb8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752507397; c=relaxed/simple;
	bh=LSDMnEQ+CXCsDUQU7j0bN8mvwohi4i3JOuJVJ3ydQT4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=HRyXaB3EmMu6ir84VmbjyMhlCoAUQjmPYTGAa8XK2BBwP+6m0BKEoM9CKv3zhgp/P5k/IdwPWVTZsJP09qbGkyxmAUCxGziom+cL1b8EXseZKQQMj4MpWs+0GDcng+MV64PfMv+rpFqUn3Yf4gh/mMNfKltejC/giMmBMYcbs5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cj30tT9q; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cj30tT9q"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-532de49b7e2so1960978e0c.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 08:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752507394; x=1753112194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0eHqJqHR8/jEmFnqR4sH3dS3AuLUeA9F9ZPhZKPROqY=;
        b=cj30tT9qocmnHXwZ9RuX3Ea04J+3nnwLV+c7YrZCRJxSUwgMV2tlvZ6wH3VwzYvuwF
         Xxy2R/kztXqUhDxrtolLMRNiVJumhnXLIeZc9qqx8Fqs1Wpf1AW/cJ55SoOi8BTWifee
         nUSMwwkycN9L4zJ+l9iqrnHDS3P8T3ahJNm/0HXlH2TPx/XLVKVytYzTestNpxRAzuGG
         uSdnnDEA41KQFpLoYolEKqVsQWstFFHHza2eqOgvg1BAI8aGy+vikQENdEGWNtLofYGM
         d0GhmOLtf6NALGU86rZXpJ/IyvW5I/Oangx6DBaeZMeE+JSSmw2QujA0nkFZVu6JTEHS
         MGcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752507394; x=1753112194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0eHqJqHR8/jEmFnqR4sH3dS3AuLUeA9F9ZPhZKPROqY=;
        b=TsbvtPyHkNiHYySvpWYotFKLMHPzaxs52cegx3sjcbqJBNoR/cSMTPYS8sPtVT6gsx
         ythR0bP3fnse8HQDEhRNJlgk1Rh/NydscyLudhqBRDaGQTisUxrAeTIZ7r94VC/HsXB+
         IVPo7UUO7nb2fEB6z/eoBICQK6cm7+++kFaZJjSsHOAW63j6XQo54ocbbrOxkz3/Fv7P
         waVUdIylgrzhpuunfXt0B6g2EiXjs5+s2gyjSge3+XwUr/8hBPdbp//DW4t7Ae8+t3EY
         l8WyfBtN/8LesVAL2bthinb1rAMvOHBdKMREg85qFj0ysgc2Faimr3mZOU7A/rSVY+to
         sKQQ==
X-Gm-Message-State: AOJu0Yx1slxo8l5r8CqaLvVjnYWkB5rQW06PhmcFc/GBnJXD5KG0JmEO
	hmlcpOIBBliaXt2DysPOBMIATMcsz06QQ/07DZLkjzvMb99hDwcSaRu1T4EPyMRxTQg=
X-Gm-Gg: ASbGncukozlzvyBBzcIBffa8+iRuqrTX/Bru3qYdnHYiF5MQTRb4SN75hfN9SSf603J
	js2HcHm4IpfKrziJZqTT7XmlM8UAyaqOy3e6m+rPOEjupxtWG15isagfrDU2hj+t25mwfjZ12F9
	CQSkh0D3V4NwWaw/47UgfoimV7Ljw3wf3vOA2Y2Zv3+irm+e/hi9WqnkVJ4R7gDfg8KYypVCchf
	lsu9SJQ2R8BYadYv364pLmJHrRwYHHoQECMdNRb1G0gftwK5YKs8sSwq+PW+J3q6xVJRQ0k3oYY
	2IixyCO+j25ikVYQ7v8u4Vi94BIzWtPpUrO9O/+X+tT8q8ENF8NWmZJlUo8dFljWTyRgYUZ4PSo
	Hc28FiiMn598X/ubzDrTZXQw89Orjw0QKN1mx4Yp3o/gxvpadvP30CP/NDj1Imjqa
X-Google-Smtp-Source: AGHT+IHf/Nsaj6jS28fueQztYWZNzJ5rbLgb9uK7w55knDDW9pgzL84I6ls6zXfR2aMUY4WXl0/TgA==
X-Received: by 2002:a05:6122:32d0:b0:534:7a8d:dcd4 with SMTP id 71dfb90a1353d-535f4557f49mr7107503e0c.0.1752507393779;
        Mon, 14 Jul 2025 08:36:33 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-535e7248b75sm1812208e0c.19.2025.07.14.08.36.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 08:36:33 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] monitor: Add sequence number and SDU length to ISO packets
Date: Mon, 14 Jul 2025 11:36:23 -0400
Message-ID: <20250714153623.251489-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This prints sequence number and SDU length of ISO packets:

> ISO Data RX: Handle 2304 SN 48 flags 0x02 dlen 64 slen 60
---
 lib/hci.h        |  5 +++++
 monitor/packet.c | 51 ++++++++++++++++++++++++++++++++----------------
 2 files changed, 39 insertions(+), 17 deletions(-)

diff --git a/lib/hci.h b/lib/hci.h
index 96733efc1e3b..8f59a535a7fa 100644
--- a/lib/hci.h
+++ b/lib/hci.h
@@ -2327,6 +2327,11 @@ typedef struct {
 #define acl_handle(h)		(h & 0x0fff)
 #define acl_flags(h)		(h >> 12)
 
+/* ISO handle and flags pack/unpack */
+#define iso_flags_pb(f)		(f & 0x0003)
+#define iso_flags_ts(f)		((f >> 2) & 0x0001)
+#define iso_flags_pack(pb, ts)	((pb & 0x03) | ((ts & 0x01) << 2))
+
 #endif /* _NO_HCI_DEFS */
 
 /* HCI Socket options */
diff --git a/monitor/packet.c b/monitor/packet.c
index 21df067b19ce..90a82b1af4ff 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -14050,9 +14050,10 @@ void packet_hci_isodata(struct timeval *tv, struct ucred *cred, uint16_t index,
 				bool in, const void *data, uint16_t size)
 {
 	const struct bt_hci_iso_hdr *hdr = data;
+	const struct bt_hci_iso_data_start *start;
 	uint16_t handle = le16_to_cpu(hdr->handle);
 	uint8_t flags = acl_flags(handle);
-	char handle_str[22], extra_str[32];
+	char handle_str[36], extra_str[33];
 	struct index_buf_pool *pool = &index_list[index].iso;
 
 	if (index >= MAX_INDEX) {
@@ -14062,27 +14063,32 @@ void packet_hci_isodata(struct timeval *tv, struct ucred *cred, uint16_t index,
 
 	index_list[index].frame++;
 
-	if (size < sizeof(*hdr)) {
-		if (in)
-			print_packet(tv, cred, '*', index, NULL, COLOR_ERROR,
-				"Malformed ISO Data RX packet", NULL, NULL);
-		else
-			print_packet(tv, cred, '*', index, NULL, COLOR_ERROR,
-				"Malformed ISO Data TX packet", NULL, NULL);
-		packet_hexdump(data, size);
-		return;
-	}
+	if (size < sizeof(*hdr))
+		goto malformed;
 
 	data += sizeof(*hdr);
 	size -= sizeof(*hdr);
 
-	if (!in && pool->total)
-		sprintf(handle_str, "Handle %d [%u/%u]", acl_handle(handle),
-			++pool->tx, pool->total);
-	else
-		sprintf(handle_str, "Handle %d", acl_handle(handle));
+	/* Detect if timestamp field is preset */
+	if (iso_flags_ts(flags)) {
+		if (size < sizeof(uint32_t))
+			goto malformed;
 
-	sprintf(extra_str, "flags 0x%2.2x dlen %d", flags, hdr->dlen);
+		data += sizeof(uint32_t);
+		size -= sizeof(uint32_t);
+	}
+
+	start = data;
+
+	if (!in && pool->total)
+		sprintf(handle_str, "Handle %d [%u/%u] SN %u",
+			acl_handle(handle), ++pool->tx, pool->total, start->sn);
+	else
+		sprintf(handle_str, "Handle %u SN %u", acl_handle(handle),
+			start->sn);
+
+	sprintf(extra_str, "flags 0x%2.2x dlen %u slen %u", flags, hdr->dlen,
+		start->slen);
 
 	print_packet(tv, cred, in ? '>' : '<', index, NULL, COLOR_HCI_ISODATA,
 				in ? "ISO Data RX" : "ISO Data TX",
@@ -14101,6 +14107,17 @@ void packet_hci_isodata(struct timeval *tv, struct ucred *cred, uint16_t index,
 
 	if (filter_mask & PACKET_FILTER_SHOW_ISO_DATA)
 		packet_hexdump(data, size);
+
+	return;
+
+malformed:
+	if (in)
+		print_packet(tv, cred, '*', index, NULL, COLOR_ERROR,
+				"Malformed ISO Data RX packet", NULL, NULL);
+	else
+		print_packet(tv, cred, '*', index, NULL, COLOR_ERROR,
+				"Malformed ISO Data TX packet", NULL, NULL);
+	packet_hexdump(data, size);
 }
 
 void packet_ctrl_open(struct timeval *tv, struct ucred *cred, uint16_t index,
-- 
2.50.0

