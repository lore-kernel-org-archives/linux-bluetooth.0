Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9831B226D18
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 16:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771518169; cv=none; b=bxZYfapMdmLFHMhscgRxDFN4AtujOsprHZ/AuiN5u2VkyD5AvBnzHMtzKFKTtZx6VNNIyzKOBElobKSlsFusCIPfWTcXGcdXs38ltzJp3lMnuQD4Zx7VP/jpEtf+e8GSL4tW4h4Mk9UPILQxS4G0b+NGDW6TnDjkHkI6EH5ozBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771518169; c=relaxed/simple;
	bh=kYYPuy0oj2bdt1xworBcrOGUsY13bnyhISUp4nGfU3w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SZiJFMuSETVSPc+KBUKt+0AyobFbXbwJB//uCGFmNBsp+gqKLzNaZ4T1CrhK+RXP7sZvYfCOqfUt1E7xq+ia7QZqKsiMrxBCtb5a5eVJnUGlFwG4q+ejP3jeuUl06HB7VEJsPM/f/vAWbrs1U7lfut74IRqYIrxonsOBg+UJED4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amStFa/k; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amStFa/k"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5664393d409so447561e0c.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 08:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771518166; x=1772122966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QdGwVY+9ZZnAICRrPX+ORuNrgTFjNHf9CW+8SwGsam8=;
        b=amStFa/kFW16rUbYK9nDUl4Zy5QEQh+M6pWYEWVnIqSZySYIdRf5PrfON8ovevTKtC
         zdt2SVd40LKUEP1NSTeej4KgZcy6yDe5LVwVJ8uyPsmcGj4BmbwuBr/Xu+nQ9VJrNCl/
         fEIY1ktbusR5JB/GkqceQT8TpROXB5tzY+W3ElZ2RZsI05VQmQeTs7g5g3SQzurxFkSA
         863B6fdYVvz70CINXvdgajAMKb0uch8fMizUgEjAwFOB1JBHGoihSzxNdWrx8/zQh8oz
         fX6HYubi2MAMwZeDoC3NfC0fOtuA5HOQ5/T8bNdjn+6mgHtvpNNLEuky3/VzvRx55uIb
         XRNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771518166; x=1772122966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QdGwVY+9ZZnAICRrPX+ORuNrgTFjNHf9CW+8SwGsam8=;
        b=Wb+B/ibpSkI7KLypbg88vKVqzI+wjCCI1XSQ2z8a6GkvTlYJXF/sUU+BQz2r+KISzc
         9fywvY3qVbJk9YAYHTGsE7+YoWrp9Nf+WoqTYcsYr5NwkvV4st8FYAagm0AFh6hLK8eK
         l50BQYRmFgZ5AWrmEbUiKp0fmF6Sw2CYsCrCsGuOnm6sPWy0jp6C8mwfu+u9KbQbzLRC
         FTc7jJRlatM5HHxZnk2Dw1SZIJb7pJmt3sfprLvtTGuYUj3aFFCBswnT9065KXNfmMog
         7bJmfU5yCCZTjeM/rV3gg+fKbDYN11+l8cuWC48qZCqfDfEINVzOsWkmQgi+IsnoabIe
         AR+A==
X-Gm-Message-State: AOJu0YzdswZuJvyn2cH6U1kGde6XszorClGp7+hA2PmblXnfhvvuSXUm
	Bt3VL6gESNLQZFwCF6/ch+grDD2d/yxl+LQCsu2qFxq9lGkW6uy21Yj5jE/yhQ==
X-Gm-Gg: AZuq6aL/rUlB0/F88sz9BdUL/8WF98hxIeKBAgsR5TPX3wrbJlpzIWS5srH9HnbgFWw
	TmB7H3zrwQM8qR62ZMp6F+L89mokDO14MjoViC1s0KseZpy3AxoAZetnqgWR/VPGpKwpzZ2XI0i
	3Mz9qbGGkSFE3sL3pTm5fZEHsBNkYk3N3kljgRVEZRWl4242ukuhIPb3AzwnGhf/mHWx01Oxeoj
	glvcArRrIBljGkwTVxfoahh8qb7YM5z8Q/C4jAn9XvD/mGXqMTZXZuAjsuqXILiehJp6k7OBqpX
	w3XNKqVRUyrbZTIfdtKftLNCHEEASfwwdIOc9tDYdLsFO7bTAhpi7InY8+o2WyrG4HplOJIGORn
	erBRfQNGHpG0w+izd3lQg0m4mIRBXOR95yjZ5+BFWr6Gu00NwhdPa4ixkwbpweicLgach087LBQ
	YZOiYYKjVtj+H1HpyaZBy+BbkK8FsES4XqRC6g5UN/5WlX8HeCj4cCgC2f5YN0x+9ftOGx5BYSS
	+oJsDkGUj99352eAg==
X-Received: by 2002:a05:6122:134c:b0:563:c868:a32d with SMTP id 71dfb90a1353d-568ca05a2admr1415953e0c.2.1771518165903;
        Thu, 19 Feb 2026 08:22:45 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5674c20a659sm14435235e0c.11.2026.02.19.08.22.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 08:22:45 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 7/8] monitor: Print connection type in Disconnect Complete
Date: Thu, 19 Feb 2026 11:22:29 -0500
Message-ID: <20260219162230.3074355-7-luiz.dentz@gmail.com>
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

Print the connection type (BR-ACL, LE-ACL, BR-SCO, BR-ESCO, LE-CIS,
LE-BIS) alongside the handle in Disconnect Complete events so the type
of link being torn down is immediately visible without cross-referencing
earlier connection events.
---
 monitor/analyze.c | 53 +++++++++++++++++++++++-------------------
 monitor/packet.c  | 59 ++++++++++++++++++++++++++++++++++-------------
 monitor/packet.h  |  9 ++++++++
 3 files changed, 81 insertions(+), 40 deletions(-)

diff --git a/monitor/analyze.c b/monitor/analyze.c
index 268ea10e29e6..2cf42f903b61 100644
--- a/monitor/analyze.c
+++ b/monitor/analyze.c
@@ -53,12 +53,6 @@ struct hci_dev {
 	struct queue *conn_list;
 };
 
-#define CONN_BR_ACL	0x01
-#define CONN_BR_SCO	0x02
-#define CONN_BR_ESCO	0x03
-#define CONN_LE_ACL	0x04
-#define CONN_LE_ISO	0x05
-
 struct hci_stats {
 	size_t bytes;
 	size_t num;
@@ -223,20 +217,23 @@ static void conn_destroy(void *data)
 	const char *str;
 
 	switch (conn->type) {
-	case CONN_BR_ACL:
+	case BTMON_CONN_ACL:
 		str = "BR-ACL";
 		break;
-	case CONN_BR_SCO:
+	case BTMON_CONN_LE:
 		str = "BR-SCO";
 		break;
-	case CONN_BR_ESCO:
+	case BTMON_CONN_SCO:
 		str = "BR-ESCO";
 		break;
-	case CONN_LE_ACL:
+	case BTMON_CONN_ESCO:
 		str = "LE-ACL";
 		break;
-	case CONN_LE_ISO:
-		str = "LE-ISO";
+	case BTMON_CONN_CIS:
+		str = "LE-CIS";
+		break;
+	case BTMON_CONN_BIS:
+		str = "LE-BIS";
 		break;
 	default:
 		str = "unknown";
@@ -476,7 +473,7 @@ static void evt_conn_complete(struct hci_dev *dev, struct timeval *tv,
 	if (evt->status)
 		return;
 
-	conn = conn_lookup_type(dev, le16_to_cpu(evt->handle), CONN_BR_ACL);
+	conn = conn_lookup_type(dev, le16_to_cpu(evt->handle), BTMON_CONN_ACL);
 	if (!conn)
 		return;
 
@@ -567,7 +564,7 @@ static void evt_le_conn_complete(struct hci_dev *dev, struct timeval *tv,
 	if (!evt || evt->status)
 		return;
 
-	conn = conn_lookup_type(dev, le16_to_cpu(evt->handle), CONN_LE_ACL);
+	conn = conn_lookup_type(dev, le16_to_cpu(evt->handle), BTMON_CONN_LE);
 	if (!conn)
 		return;
 
@@ -585,7 +582,7 @@ static void evt_le_enh_conn_complete(struct hci_dev *dev, struct timeval *tv,
 	if (!evt || evt->status)
 		return;
 
-	conn = conn_lookup_type(dev, le16_to_cpu(evt->handle), CONN_LE_ACL);
+	conn = conn_lookup_type(dev, le16_to_cpu(evt->handle), BTMON_CONN_LE);
 	if (!conn)
 		return;
 
@@ -670,7 +667,7 @@ static void evt_le_cis_established(struct hci_dev *dev, struct timeval *tv,
 		return;
 
 	conn = conn_lookup_type(dev, le16_to_cpu(evt->conn_handle),
-						CONN_LE_ISO);
+						BTMON_CONN_CIS);
 	if (!conn)
 		return;
 
@@ -715,7 +712,7 @@ static void evt_le_big_complete(struct hci_dev *dev, struct timeval *tv,
 		if (!util_iov_pull_le16(iov, &handle))
 			return;
 
-		conn = conn_lookup_type(dev, handle, CONN_LE_ISO);
+		conn = conn_lookup_type(dev, handle, BTMON_CONN_BIS);
 		if (conn)
 			conn->setup_seen = true;
 	}
@@ -738,7 +735,7 @@ static void evt_le_big_sync_established(struct hci_dev *dev, struct timeval *tv,
 		if (!util_iov_pull_le16(iov, &handle))
 			return;
 
-		conn = conn_lookup_type(dev, handle, CONN_LE_ISO);
+		conn = conn_lookup_type(dev, handle, BTMON_CONN_BIS);
 		if (conn)
 			conn->setup_seen = true;
 	}
@@ -928,9 +925,13 @@ static void sco_pkt(struct timeval *tv, uint16_t index, bool out,
 	dev->num_sco++;
 
 	conn = conn_lookup_type(dev, le16_to_cpu(hdr->handle) & 0x0fff,
-								CONN_BR_SCO);
-	if (!conn)
-		return;
+							BTMON_CONN_SCO);
+	if (!conn) {
+		conn = conn_lookup_type(dev, le16_to_cpu(hdr->handle) & 0x0fff,
+							BTMON_CONN_ESCO);
+		if (!conn)
+			return;
+	}
 
 	if (out) {
 		conn_pkt_tx(conn, tv, size - sizeof(*hdr), NULL);
@@ -1015,9 +1016,13 @@ static void iso_pkt(struct timeval *tv, uint16_t index, bool out,
 	dev->num_iso++;
 
 	conn = conn_lookup_type(dev, le16_to_cpu(hdr->handle) & 0x0fff,
-								CONN_LE_ISO);
-	if (!conn)
-		return;
+							BTMON_CONN_CIS);
+	if (!conn) {
+		conn = conn_lookup_type(dev, le16_to_cpu(hdr->handle) & 0x0fff,
+							BTMON_CONN_BIS);
+		if (!conn)
+			return;
+	}
 
 	if (out) {
 		conn_pkt_tx(conn, tv, size - sizeof(*hdr), NULL);
diff --git a/monitor/packet.c b/monitor/packet.c
index b8a48bb549af..92e23bf3a54b 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -221,22 +221,24 @@ static struct index_buf_pool *get_pool(uint16_t index, uint8_t type)
 		return NULL;
 
 	switch (type) {
-	case 0x00:
+	case BTMON_CONN_ACL:
 		if (index_list[index].acl.total)
 			return &index_list[index].acl;
 		break;
-	case 0x01:
+	case BTMON_CONN_LE:
 		if (index_list[index].le.total)
 			return &index_list[index].le;
 		break;
-	case 0x05:
-		if (index_list[index].iso.total)
-			return &index_list[index].iso;
-		break;
-	default:
+	case BTMON_CONN_SCO:
+	case BTMON_CONN_ESCO:
 		if (index_list[index].sco.total)
 			return &index_list[index].sco;
 		break;
+	case BTMON_CONN_CIS:
+	case BTMON_CONN_BIS:
+		if (index_list[index].iso.total)
+			return &index_list[index].iso;
+		break;
 	}
 
 	return NULL;
@@ -922,10 +924,30 @@ static void print_lt_addr(uint8_t lt_addr)
 	print_field("LT address: %d", lt_addr);
 }
 
+static const char *conn_type_str(uint8_t type)
+{
+	switch (type) {
+	case BTMON_CONN_ACL:
+		return "BR-ACL";
+	case BTMON_CONN_LE:
+		return "LE-ACL";
+	case BTMON_CONN_SCO:
+		return "BR-ESCO";
+	case BTMON_CONN_ESCO:
+		return "LE-ESCO";
+	case BTMON_CONN_CIS:
+		return "LE-CIS";
+	case BTMON_CONN_BIS:
+		return "LE-BIS";
+	default:
+		return "unknown";
+	}
+}
+
 static void print_handle_native(uint16_t handle)
 {
 	struct packet_conn_data *conn;
-	char label[25];
+	char label[32];
 
 	conn = packet_get_conn_data(handle);
 	if (!conn) {
@@ -933,7 +955,8 @@ static void print_handle_native(uint16_t handle)
 		return;
 	}
 
-	sprintf(label, "Handle: %d Address", handle);
+	sprintf(label, "Handle: %d (%s) Address", handle,
+				conn_type_str(conn->type));
 	print_addr(label, conn->dst, conn->dst_type);
 }
 
@@ -10996,7 +11019,7 @@ static void conn_complete_evt(struct timeval *tv, uint16_t index,
 	print_enable("Encryption", evt->encr_mode);
 
 	if (evt->status == 0x00)
-		assign_handle(index, le16_to_cpu(evt->handle), 0x00,
+		assign_handle(index, le16_to_cpu(evt->handle), BTMON_CONN_ACL,
 					(void *)evt->bdaddr, BDADDR_BREDR);
 }
 
@@ -11583,7 +11606,9 @@ static void sync_conn_complete_evt(struct timeval *tv, uint16_t index,
 	print_air_mode(evt->air_mode);
 
 	if (evt->status == 0x00)
-		assign_handle(index, le16_to_cpu(evt->handle), evt->link_type,
+		assign_handle(index, le16_to_cpu(evt->handle),
+					evt->link_type ? BTMON_CONN_ESCO :
+					BTMON_CONN_SCO,
 					(void *)evt->bdaddr, BDADDR_BREDR);
 }
 
@@ -12014,7 +12039,7 @@ static void le_conn_complete_evt(struct timeval *tv, uint16_t index,
 	print_field("Central clock accuracy: 0x%2.2x", evt->clock_accuracy);
 
 	if (evt->status == 0x00)
-		assign_handle(index, le16_to_cpu(evt->handle), 0x01,
+		assign_handle(index, le16_to_cpu(evt->handle), BTMON_CONN_LE,
 				(void *)evt->peer_addr, evt->peer_addr_type);
 }
 
@@ -12145,7 +12170,7 @@ static void le_enhanced_conn_complete_evt(struct timeval *tv, uint16_t index,
 	print_field("Central clock accuracy: 0x%2.2x", evt->clock_accuracy);
 
 	if (evt->status == 0x00)
-		assign_handle(index, le16_to_cpu(evt->handle), 0x01,
+		assign_handle(index, le16_to_cpu(evt->handle), BTMON_CONN_LE,
 				(void *)evt->peer_addr, evt->peer_addr_type);
 }
 
@@ -12545,7 +12570,8 @@ static void le_cis_established_evt(struct timeval *tv, uint16_t index,
 	print_slot_125("ISO Interval", evt->interval);
 
 	if (!evt->status)
-		assign_handle(index, le16_to_cpu(evt->conn_handle), 0x05,
+		assign_handle(index, le16_to_cpu(evt->conn_handle),
+					BTMON_CONN_CIS,
 					NULL, BDADDR_LE_PUBLIC);
 }
 
@@ -12596,7 +12622,8 @@ static void le_big_complete_evt(struct timeval *tv, uint16_t index,
 
 		for (i = 0; i < evt->num_bis; i++)
 			assign_handle(index, le16_to_cpu(evt->bis_handle[i]),
-					0x05, NULL, BDADDR_LE_PUBLIC);
+					BTMON_CONN_BIS, NULL,
+					BDADDR_LE_PUBLIC);
 	}
 }
 
@@ -12631,7 +12658,7 @@ static void le_big_sync_estabilished_evt(struct timeval *tv, uint16_t index,
 
 		for (i = 0; i < evt->num_bis; i++)
 			assign_handle(index, le16_to_cpu(evt->bis[i]),
-					0x05, NULL, BDADDR_LE_PUBLIC);
+					BTMON_CONN_BIS, NULL, BDADDR_LE_PUBLIC);
 	}
 }
 
diff --git a/monitor/packet.h b/monitor/packet.h
index f6547ec9b594..38f3f5514dba 100644
--- a/monitor/packet.h
+++ b/monitor/packet.h
@@ -39,6 +39,15 @@ struct packet_frame {
 	size_t len;
 };
 
+enum {
+	BTMON_CONN_ACL = 0x00,
+	BTMON_CONN_LE,
+	BTMON_CONN_SCO,
+	BTMON_CONN_ESCO,
+	BTMON_CONN_CIS,
+	BTMON_CONN_BIS
+};
+
 struct packet_conn_data {
 	uint16_t index;
 	uint8_t  src[6];
-- 
2.52.0

