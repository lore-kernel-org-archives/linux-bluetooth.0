Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B68B35F8BD
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Feb 2026 17:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771608703; cv=none; b=GvMFwMsmeBjFkFrCM9RYfwMYZzFZbxKUj+Is2bAGl5fPjcDInqZh1Pj11t7R1Ecb/86m/uVjyY6Rv/3SntaSp29KY2RSm5+A22azz7tYxNbWi0SarA2DN/QEVyQFggycAEUDD3zWien/aibmI58RGanvKWTWTu/BXOcKxQAtadQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771608703; c=relaxed/simple;
	bh=trZ3fIzXmQSt9s9cn0YOboZFqWem4qcl0DWEs9H8qV0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jSFevztJiA6pdTumZWdajXmVh3MNGyjHXy7VZpHZopCehWZNN0RdU7AcsFKvVnQqwKs5S6mSizmTOD9ETpDFv/9zoI+jHjN6hsIDq1cARzMrdL7YYiNxaIN/BN05cbvh24wIHIvKl2Vxw1CsMgNIsYtUoHA6FtRQRTwYOu3amz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHfnx96H; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHfnx96H"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5675d609621so1744976e0c.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Feb 2026 09:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771608700; x=1772213500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vYqp7X1B81I5r2GRvdLQi8PkCa3mYmmVIy0KGaCD0zY=;
        b=nHfnx96Hm002D/48Nz8Q2fQCiQi4KYk77HsMC6ykxCxwMrfV6YjIMRdKnCSMIzh/4m
         Xxz+AsIrOKxpeRh8cTj1ta1/Z68gV+XhVcBXg3jrUoOiNTYfLOaiNL9Bra6w6QDGJ4ow
         YBESwgL/T86mVgTXv+OHK+GDMkpQwI8p+7teCXL+x7wjQ8x9M1zWHWSCJArinIacMoCe
         oWtRA+IwbhoIWgf+VYWX2UqlGR1Rx4m0eDW8vhVB86jOuvzQfNa0Kc+vht7dN1PTYhf2
         g2U0TUC5C+WCFJBRgP3IaVVnKXPt70kTu4mun/eAOEYFoGmzIxpHnhBAPZ8T5OAjHs/T
         8gdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771608700; x=1772213500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vYqp7X1B81I5r2GRvdLQi8PkCa3mYmmVIy0KGaCD0zY=;
        b=nWVnZ9q6IcwHJK8voWMBbEoXh6BcsjcL1NWp7gYTzRhlUmbGvy1tMqUPAyf/veKJJQ
         wAB33aNPMyqmqxorfjOkoUuO3EOjVqRJDx8kqBBUreYYJcbdDfe/2qYnyJuGGvdIBTei
         iTkzxT2nzTZ/si81eRGkVehQ8xxByNk3g2O/Tjp82e7fvHeHujbuu8uxbS1WM+7m+L1l
         /FOvGdvJKwI3lSdgCIi5yCcUoRD/ssApcVWTr+u4FIjAit9tgZCxVclObDVzEjBqWP/g
         z3RRm4e/CffaHCIYykDpedxVxdJNLR3bddjgvI6ugDEJe8+FOAQXni2pbNjedEVjn11A
         0MDg==
X-Gm-Message-State: AOJu0Yxhr8ncT1z5FV59pkaHliih9aI46Bij9F3fy1JSePtGCByqKQl3
	R8X3i3lQN68UsecRPmVFETaaSedp/T1XyfasT1lphDo+Shx6KtoVFr8ve1ilvw==
X-Gm-Gg: AZuq6aJacOs2oLOHO1JXnBm/TLKKZiJVVFMmK1YY3km+j+8u6Z/3Uw/eK8PhVUTeWDG
	guFCBUXDxREjPSj0TolDDdFdU3cuuVRAXglr4EnwAGZvwForNMgFMC2MN0Qs5c4wOfS+6IE6OrA
	CV3TEKhukPrS33c8hoNIRRssCvUDDfS3/azznf/LvLoHuWczm8KbpxFMD8HFCdXjOLxLmExjFoz
	Lzs3I9RsL4pJBNnCaBp4RKrkKzNs5zOLmUDQ5r/gLi4xBr+ZlRcRS6GmUTRcJLlRf4DeeEYCReK
	tgFSOP5RmWpKzdJuVHTUhv7oJzRdXFQfXF/jIDyA6AySN4qn1M0cjRHD8Hy9ey8lvJgESeFaH7m
	zhKMeAJdnPyfntSRO3d7412z2K8wLmEi4nGwbM7OB070IzQOPtwQUnLzBr23FqEAZGvy5gNMK6h
	mfqaW7/0OsscN34VrtSko3Gf6lTy7DG3LJ8/8K9S+3+uK5+kONyw6FHMCwhI1enswMbONWUqRA6
	N4VnJbCvxUkW+LIiw==
X-Received: by 2002:a05:6122:928:b0:55b:305b:4e31 with SMTP id 71dfb90a1353d-568e48e2688mr281833e0c.17.1771608697749;
        Fri, 20 Feb 2026 09:31:37 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94da8b3eefdsm77864241.9.2026.02.20.09.31.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 09:31:37 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 09/12] monitor: Print connection type in Disconnect Complete
Date: Fri, 20 Feb 2026 12:31:13 -0500
Message-ID: <20260220173120.3418666-9-luiz.dentz@gmail.com>
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

Print the connection type (BR-ACL, LE-ACL, BR-SCO, BR-ESCO, LE-CIS,
LE-BIS) alongside the handle in Disconnect Complete events so the type
of link being torn down is immediately visible without cross-referencing
earlier connection events:

> HCI Event: Disconnect Complete (0x05) plen 4
        Status: Success (0x00)
        Handle: 2050 (LE-ACL) Address: 6A:59:B2:90:5E:AB (Resolvable)
        Reason: Remote User Terminated Connection (0x13)
> HCI Event: Disconnect Complete (0x05) plen 4
        Status: Success (0x00)
        Handle: 2304 (LE-CIS) Address: 65:0D:7B:2F:D6:E7 (Resolvable)
        Reason: Connection Terminated By Local Host (0x16)
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
index b8a48bb549af..a4930c855144 100644
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
+		return "BR-SCO";
+	case BTMON_CONN_ESCO:
+		return "BR-ESCO";
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

