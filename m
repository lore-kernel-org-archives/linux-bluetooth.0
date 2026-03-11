Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08AA20C029
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Mar 2026 16:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773245789; cv=pass; b=Z4IDHJPg8EEu9bMpI3t6lLO4VeWWywE7jhASPynAUocubiKkiyltqt6BQWkMtqeJe7eyoZlXeVfSNpZol9qeTu000L3VvpJ5pgtMV27M52wgU7fsUC4zcz7JBGEHJVmjIZ9X1Nl2IDY4Fz+IurxQav0kJ72I97q0U+uZa6O0OLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773245789; c=relaxed/simple;
	bh=6leTHRnlbJfG3KHnyyoXghV+pPVwTBHSaP8/EjVYSIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RDQujjJVRRXZYOqJ17rhJeIpk24DQOySO13bMSbkYc4StnxY67X63JcuE8maSJr+FO5Oc0m1O9ZvhuiHoAJeYauWqtF3UhU4rJGDqKHU9zJuKidcoaK2DqW3gm4rO6Qpz0fkPYQpzE9O0Dc6uSMmXh8JEwWi8Y4IGyuaCxKeFjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=ZOHrt9K/; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="ZOHrt9K/"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fWG8R5rzNzyXV;
	Wed, 11 Mar 2026 18:16:23 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1773245784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZinvHRQO0d4jy0rclmI0cTjTnMI0cBWcGhRTQXXBvcY=;
	b=ZOHrt9K/gbTbg5UTev2p8j2ypejt4zFZFaS9tartNdY4wkRAojA3FNg/JxZIoPLB7lsz1G
	z8FMdPOueYfnijPyffJzQqW/emVQjmBuw2eSOZsT5UTwEMMzgxlUihuTjiSlFa7hnlNUmb
	73zEInZaA30JsrwhuUWzp5PAjG1MgTI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1773245784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZinvHRQO0d4jy0rclmI0cTjTnMI0cBWcGhRTQXXBvcY=;
	b=IJ1ObuNAYmN7NBqE4E7qZsFQxFpX+/7C/IzPQUaGUN2CKtP4kTZx5yEWkanIieVU7Lsp3B
	fKaPHSQVyz+TY641qoBel42IC2X3mGFLknxA0YdXilxzkfS8IACDDqQIW38UWa+9jIHYJr
	qFHFfkwdJnXkMquIyJUHxRyfmqJeo7w=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1773245784;
	b=IL3IRxZBYQ4I0LpjJxBbhpWsJNS3AjqxtmqRwe8bQVFB0wavFZmxlRHFGWwMWso/Kvn43W
	g3RDalHNWC+qjU7vZ7hG9FW5kTWAcdfDC3srR8apzImWhIF8A2JnyBGw4ygskejPkewM+v
	r7PIHy9qYQIy3xqOjPERPITP1S3da8E=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH BlueZ 1/4] bthost: fix receiving timestamped ISO packets
Date: Wed, 11 Mar 2026 18:16:17 +0200
Message-ID: <3c9b3d899d6e4b042e532abdb99048d1e04ff99b.1773245672.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773245672.git.pav@iki.fi>
References: <cover.1773245672.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Parse timestamped ISO packets correctly. Pass sequence number and
timestamp to the hook callback.
---
 emulator/bthost.c  | 83 ++++++++++++++++++++++++++++++----------------
 emulator/bthost.h  |  2 +-
 tools/iso-tester.c |  3 +-
 3 files changed, 58 insertions(+), 30 deletions(-)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index b913c8015..7056dd8d1 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -47,6 +47,8 @@
 #define iso_flags_pb(f)		(f & 0x0003)
 #define iso_flags_ts(f)		((f >> 2) & 0x0001)
 #define iso_flags_pack(pb, ts)	(((pb) & 0x03) | (((ts) & 0x01) << 2))
+#define iso_data_len(h)		((h) & 0x3fff)
+#define iso_data_flags(h)	((h) >> 14)
 #define iso_data_len_pack(h, f)	((uint16_t) ((h) | ((f) << 14)))
 
 #define L2CAP_FEAT_FIXED_CHAN	0x00000080
@@ -173,6 +175,11 @@ struct btconn {
 	uint16_t recv_len;
 	uint16_t data_len;
 	void *recv_data;
+	struct {
+		uint16_t sn;
+		bool ts;
+		uint32_t tstamp;
+	} recv_iso;
 };
 
 enum l2cap_mode {
@@ -3356,60 +3363,67 @@ static void process_sco(struct bthost *bthost, const void *data, uint16_t len)
 }
 
 static void process_iso_data(struct bthost *bthost, struct btconn *conn,
-					const void *data, uint16_t len)
+					bool ts, uint16_t sn, uint32_t tstamp,
+					const struct iovec *iov)
 {
-	const struct bt_hci_iso_data_start *data_hdr = data;
-	uint16_t data_len;
 	struct iso_hook *hook;
 
-	data_len = le16_to_cpu(data_hdr->slen);
-	if (len != sizeof(*data_hdr) + data_len) {
-		bthost_debug(bthost, "ISO invalid length: %u != %zu",
-					len, sizeof(*data_hdr) + data_len);
-		return;
-	}
-
-	bthost_debug(bthost, "ISO data: %u bytes (%u)", data_len, data_hdr->sn);
+	bthost_debug(bthost, "ISO data: %zu bytes ts %u sn %u tstamp %u",
+						iov->iov_len, ts, sn, tstamp);
 
 	hook = conn->iso_hook;
 	if (!hook)
 		return;
 
-	hook->func(data_hdr->data, data_len, hook->user_data);
+	hook->func(iov->iov_base, iov->iov_len, ts, sn, tstamp,
+							hook->user_data);
 }
 
 static void append_iso_data(struct bthost *bthost, struct btconn *conn,
-				uint8_t flags, const void *data, uint16_t len)
+				uint8_t flags, const struct iovec *iov)
 {
-	append_recv_data(bthost, conn, "ISO", flags, data, len);
+	struct iovec data;
+
+	append_recv_data(bthost, conn, "ISO", flags, iov->iov_base,
+								iov->iov_len);
 
 	if (conn->recv_len < conn->data_len) {
-		if (flags == 0x03) {
+		if (iso_flags_pb(flags) == 0x03) {
 			bthost_debug(bthost, "Unexpected ISO end frame");
 			free_recv_data(conn);
 		}
 		return;
 	}
 
-	process_iso_data(bthost, conn, conn->recv_data, conn->recv_len);
+	data.iov_base = conn->recv_data;
+	data.iov_len = conn->recv_len;
+	process_iso_data(bthost, conn, conn->recv_iso.ts, conn->recv_iso.sn,
+						conn->recv_iso.tstamp, &data);
 
 	free_recv_data(conn);
 }
 
 static void process_iso(struct bthost *bthost, const void *data, uint16_t len)
 {
-	const struct bt_hci_iso_hdr *iso_hdr = data;
+	struct iovec in = { .iov_base = (void *)data, .iov_len = len };
+	const struct bt_hci_iso_hdr *iso_hdr;
 	const struct bt_hci_iso_data_start *data_hdr;
 	uint16_t handle, iso_len, data_len;
-	uint8_t flags;
+	uint8_t flags, pb, ts;
 	struct btconn *conn;
 
+	iso_hdr = util_iov_pull_mem(&in, sizeof(*iso_hdr));
+	if (!iso_hdr)
+		return;
+
 	iso_len = le16_to_cpu(iso_hdr->dlen);
 	if (len != sizeof(*iso_hdr) + iso_len)
 		return;
 
 	handle = acl_handle(iso_hdr->handle);
-	flags = iso_flags_pb(acl_flags(iso_hdr->handle));
+	flags = acl_flags(iso_hdr->handle);
+	pb = iso_flags_pb(flags);
+	ts = iso_flags_ts(flags);
 
 	conn = bthost_find_conn(bthost, handle);
 	if (!conn) {
@@ -3417,9 +3431,7 @@ static void process_iso(struct bthost *bthost, const void *data, uint16_t len)
 		return;
 	}
 
-	data_hdr = (void *) data + sizeof(*iso_hdr);
-
-	switch (flags) {
+	switch (pb) {
 	case 0x00:
 	case 0x02:
 		if (conn->recv_data) {
@@ -3427,13 +3439,28 @@ static void process_iso(struct bthost *bthost, const void *data, uint16_t len)
 			free_recv_data(conn);
 		}
 
-		data_len = le16_to_cpu(data_hdr->slen) + sizeof(*data_hdr);
+		conn->recv_iso.ts = ts;
+		conn->recv_iso.tstamp = 0;
+		if (ts) {
+			if (!util_iov_pull_le32(&in, &conn->recv_iso.tstamp)) {
+				bthost_debug(bthost, "Invalid ISO ts");
+				return;
+			}
+		}
 
-		bthost_debug(bthost, "iso_len %u data_len %u", iso_len,
-								data_len);
+		data_hdr = util_iov_pull_mem(&in, sizeof(*data_hdr));
+		if (!data_hdr) {
+			bthost_debug(bthost, "Invalid ISO frame header");
+			return;
+		}
 
-		if (iso_len == data_len) {
-			process_iso_data(bthost, conn, iso_hdr->data, iso_len);
+		conn->recv_iso.sn = le16_to_cpu(data_hdr->sn);
+		data_len = iso_data_len(le16_to_cpu(data_hdr->slen));
+
+		if (in.iov_len == data_len) {
+			process_iso_data(bthost, conn, conn->recv_iso.ts,
+						conn->recv_iso.sn,
+						conn->recv_iso.tstamp, &in);
 			break;
 		}
 
@@ -3441,7 +3468,7 @@ static void process_iso(struct bthost *bthost, const void *data, uint16_t len)
 		/* fall through */
 	case 0x01:
 	case 0x03:
-		append_iso_data(bthost, conn, flags, iso_hdr->data, iso_len);
+		append_iso_data(bthost, conn, flags, &in);
 		break;
 	default:
 		bthost_debug(bthost, "Invalid ISO frame flags 0x%2.2x", flags);
diff --git a/emulator/bthost.h b/emulator/bthost.h
index c88ea0329..1f8b32d64 100644
--- a/emulator/bthost.h
+++ b/emulator/bthost.h
@@ -86,7 +86,7 @@ void bthost_add_sco_hook(struct bthost *bthost, uint16_t handle,
 				bthost_destroy_func_t destroy);
 
 typedef void (*bthost_iso_hook_func_t)(const void *data, uint16_t len,
-							void *user_data);
+		bool ts, uint16_t sn, uint32_t timestamp, void *user_data);
 
 void bthost_add_iso_hook(struct bthost *bthost, uint16_t handle,
 				bthost_iso_hook_func_t func, void *user_data,
diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index b851d2cd8..2ddb29a00 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -1669,7 +1669,8 @@ static void client_connectable_complete(uint16_t opcode, uint8_t status,
 	}
 }
 
-static void bthost_recv_data(const void *buf, uint16_t len, void *user_data)
+static void bthost_recv_data(const void *buf, uint16_t len, bool ts,
+			uint16_t sn, uint32_t timestamp, void *user_data)
 {
 	struct test_data *data = user_data;
 	const struct iso_client_data *isodata = data->test_data;
-- 
2.53.0

