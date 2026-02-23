Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74654365A05
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Feb 2026 12:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771848117; cv=none; b=Yd8joTSlNVolYYKKNd1OnhnmWIiRNb/+PQVhxcPD+uDdr7uP7ZsjcMNSq+4/1TufYTKrxPFD1ytUTclveNcaaoALNym8V6pCrnpYEGs4ttynNVJjgYTpKK2DW71hbY5sQ4qOi8Q4gEf2ZnHAnPdPhyazmL2gcAWt0KDi7Wz2288=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771848117; c=relaxed/simple;
	bh=iiB7pchE4S04Cg8Opj5Xsod10fWNtMiWOs0glLPcnuk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ReYb4iUY7fg+P2R63CMuS7/Kb2J2RjAhzYBAJZHGOELDcr9wxniu8+7ffK+/EbMLtsLp0yQYLdxWx5txiWbdhIP/IWPMEsTexxdp0fHUhvRWBzwraUKM+x1m2zJrie3RhGRRPI5eqL9vfQcckOfqvALdUs4Ur5MhLY9d3tgdZwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=UDJaisQB; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="UDJaisQB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1771848107;
	bh=iiB7pchE4S04Cg8Opj5Xsod10fWNtMiWOs0glLPcnuk=;
	h=From:To:Subject:Date:From;
	b=UDJaisQBZAjgL2ytTQgK18bha+S3Kk5Bhwst+TMdz1dty9lqd//tySgq4UB2Cq0IW
	 GqaKtm5QF6wX0vhyi7ONTfeOYY+qiwVU+rm8khIJzHc/CcF6xrZwPsSfbm3mawqYr2
	 xA+ete3ovRzL43/dnGHUVSIU39YCnHIil2lPd9QxMbRehWfNKm+XF7p5fFzuybYkDC
	 u7RJqye9MqLjjQs4wLT+cIch369SE12XX+goo3brIQbf3On5xmKvltQcusyOz6mk6T
	 /3TbwyaAiTyBwSVUX5Roe/Brj75jpb60pyUGZHvLObPxLe6zurFv+c3ebYMTsZxugF
	 c6QQBsLugcG+A==
Received: from fdanis-ThinkPad-X1.. (2a02-8428-af44-1001-0F6F-a0F8-dAdF-0a2c.rev.sfr.net [IPv6:2a02:8428:af44:1001:f6f:a0f8:dadf:a2c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8BC7817E04C4
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Feb 2026 13:01:47 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2] shared/bap: Fix endpoint configuration
Date: Mon, 23 Feb 2026 13:01:42 +0100
Message-ID: <20260223120142.205159-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

When a first local endpoint is created after connection to a remote
device this doesn't trigger the SelectProperties request because
bt_bap_bac ops are not yet set when bt_bap_select() is called.
Creating a second local endpoint allows to trigger SelectProperties
request for the first endpoint.

This commit fixes this behavior by setting the ops during bt_bap_pac
creation.
---
v1->v2: Add bt_bap_add_vendor_pac_full() instead of changing
        bt_bap_add_vendor_pac()

 profiles/audio/media.c |  9 ++++-----
 src/shared/bap.c       | 20 ++++++++++++++++++--
 src/shared/bap.h       | 33 +++++++++++++++++++++------------
 3 files changed, 43 insertions(+), 19 deletions(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 772af1014..cdaafb04e 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -1361,9 +1361,10 @@ static bool endpoint_init_pac(struct media_endpoint *endpoint, uint8_t type,
 		metadata->iov_len = endpoint->metadata_size;
 	}
 
-	endpoint->pac = bt_bap_add_vendor_pac(db, name, type, endpoint->codec,
-				endpoint->cid, endpoint->vid, &endpoint->qos,
-				&data, metadata);
+	endpoint->pac = bt_bap_add_vendor_pac_full(db, name, type,
+				endpoint->codec, endpoint->cid, endpoint->vid,
+				&endpoint->qos, &data, metadata,
+				&pac_ops, endpoint);
 	if (!endpoint->pac) {
 		error("Unable to create PAC");
 		free(name);
@@ -1371,8 +1372,6 @@ static bool endpoint_init_pac(struct media_endpoint *endpoint, uint8_t type,
 		return false;
 	}
 
-	bt_bap_pac_set_ops(endpoint->pac, &pac_ops, endpoint);
-
 	DBG("PAC %s registered", name);
 
 	free(name);
diff --git a/src/shared/bap.c b/src/shared/bap.c
index 37b04c5c1..8da626fe3 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -4124,12 +4124,14 @@ static void notify_session_pac_added(void *data, void *user_data)
 	queue_foreach(bap->pac_cbs, notify_pac_added, user_data);
 }
 
-struct bt_bap_pac *bt_bap_add_vendor_pac(struct gatt_db *db,
+struct bt_bap_pac *bt_bap_add_vendor_pac_full(struct gatt_db *db,
 					const char *name, uint8_t type,
 					uint8_t id, uint16_t cid, uint16_t vid,
 					struct bt_bap_pac_qos *qos,
 					struct iovec *data,
-					struct iovec *metadata)
+					struct iovec *metadata,
+					struct bt_bap_pac_ops *ops,
+					void *ops_user_data)
 {
 	struct bt_bap_db *bdb;
 	struct bt_bap_pac *pac;
@@ -4150,6 +4152,8 @@ struct bt_bap_pac *bt_bap_add_vendor_pac(struct gatt_db *db,
 	codec.vid = vid;
 
 	pac = bap_pac_new(bdb, name, type, &codec, qos, data, metadata);
+	if (ops)
+		bt_bap_pac_set_ops(pac, ops, ops_user_data);
 
 	switch (type) {
 	case BT_BAP_SINK:
@@ -4174,6 +4178,18 @@ struct bt_bap_pac *bt_bap_add_vendor_pac(struct gatt_db *db,
 	return pac;
 }
 
+struct bt_bap_pac *bt_bap_add_vendor_pac(struct gatt_db *db,
+					const char *name, uint8_t type,
+					uint8_t id, uint16_t cid, uint16_t vid,
+					struct bt_bap_pac_qos *qos,
+					struct iovec *data,
+					struct iovec *metadata)
+{
+	return bt_bap_add_vendor_pac_full(db, name, type, id, cid, vid, qos,
+							data, metadata,
+							NULL, NULL);
+}
+
 struct bt_bap_pac *bt_bap_add_pac(struct gatt_db *db, const char *name,
 					uint8_t type, uint8_t id,
 					struct bt_bap_pac_qos *qos,
diff --git a/src/shared/bap.h b/src/shared/bap.h
index c1b75949f..5bdc5f8db 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -67,6 +67,27 @@ struct bt_bap_pac_qos {
 	uint16_t context;
 };
 
+struct bt_bap_pac_ops {
+	int (*select)(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
+			uint32_t chan_alloc, struct bt_bap_pac_qos *qos,
+			bt_bap_pac_select_t cb, void *cb_data, void *user_data);
+	void (*cancel_select)(struct bt_bap_pac *lpac,
+			bt_bap_pac_select_t cb, void *cb_data, void *user_data);
+	int (*config)(struct bt_bap_stream *stream, struct iovec *cfg,
+			struct bt_bap_qos *qos, bt_bap_pac_config_t cb,
+			void *user_data);
+	void (*clear)(struct bt_bap_stream *stream, void *user_data);
+};
+
+struct bt_bap_pac *bt_bap_add_vendor_pac_full(struct gatt_db *db,
+					const char *name, uint8_t type,
+					uint8_t id, uint16_t cid, uint16_t vid,
+					struct bt_bap_pac_qos *qos,
+					struct iovec *data,
+					struct iovec *metadata,
+					struct bt_bap_pac_ops *ops,
+					void *ops_user_data);
+
 struct bt_bap_pac *bt_bap_add_vendor_pac(struct gatt_db *db,
 					const char *name, uint8_t type,
 					uint8_t id, uint16_t cid, uint16_t vid,
@@ -80,18 +101,6 @@ struct bt_bap_pac *bt_bap_add_pac(struct gatt_db *db, const char *name,
 					struct iovec *data,
 					struct iovec *metadata);
 
-struct bt_bap_pac_ops {
-	int (*select)(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
-			uint32_t chan_alloc, struct bt_bap_pac_qos *qos,
-			bt_bap_pac_select_t cb, void *cb_data, void *user_data);
-	void (*cancel_select)(struct bt_bap_pac *lpac,
-			bt_bap_pac_select_t cb, void *cb_data, void *user_data);
-	int (*config)(struct bt_bap_stream *stream, struct iovec *cfg,
-			struct bt_bap_qos *qos, bt_bap_pac_config_t cb,
-			void *user_data);
-	void (*clear)(struct bt_bap_stream *stream, void *user_data);
-};
-
 bool bt_bap_pac_set_ops(struct bt_bap_pac *pac, struct bt_bap_pac_ops *ops,
 					void *user_data);
 
-- 
2.43.0

