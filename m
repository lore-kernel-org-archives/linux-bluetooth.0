Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E828831159C
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Feb 2026 15:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771602933; cv=none; b=X+iVW4p3nvFkvHZzscWGIJ8d1aTxDRYJTxs/KvIJzvEKFimFq36mAyuyiK5MI/y7VX84pYhy7+l6E6reZbJCo/Ip+L7M/M5R3fX0jMscaMEPPWUZaOpR9Fkak2NatB2ac3uvi9sWjig8MYLvbBXZN962OHxyAOe59Fi1Bftyqbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771602933; c=relaxed/simple;
	bh=nYdFPa5bC5tpOrdtNYcv/4ngAU1XdZPx2VHh1qy0djc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ddVAkW1UNKf6OAc05scsCoTlINmRRUe97LrGxyMTfdj/CQHLbKrQz8pbZlX1kbfoxG+Zp7kGY1TQdLW7EruzvnqKO93i+nCTJLNqjdOS3Eb/Ik/ceaMXWa4SuVx1z3Rg/syIbiInZi5f16u+XxG0eC9gJJJZuubx0l5EIVo3QEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=IANmpOBR; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IANmpOBR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1771602929;
	bh=nYdFPa5bC5tpOrdtNYcv/4ngAU1XdZPx2VHh1qy0djc=;
	h=From:To:Subject:Date:From;
	b=IANmpOBRcTiQyRiXPM6RbicB1a/KPWaDALwa7vphHGX3PjS+eppahBPcBF/WczdkA
	 lIkc5FHaAeUFgf5Kl6noN5P4aYJGySjL0c5iMPm/lhuiXW87y5JJLz1xN5W4obIbps
	 KNWdY9cQa5DZftqKvlSoRnF3FtuNY5QcZqA7zuXjg/AS+DN/oVnif+1/nrkSINz7Fa
	 CrflfjuqUVwINUpdHXbIbRcngfiGNt8HlU2UJ9z04PdVoqLI90r8wBJvZE10ddiKtJ
	 qsP0SMHGweOukdXqVmKDH+4xrDkzbYovQ1fxOYX7nLlQeYE40psmheX8lwokirhcVi
	 XQ05YTeDPWtMA==
Received: from fdanis-ThinkPad-X1.. (2a02-8428-af44-1001-222F-f2CD-be6a-F13C.rev.sfr.net [IPv6:2a02:8428:af44:1001:222f:f2cd:be6a:f13c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B13A217E1274
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Feb 2026 16:55:29 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/bap: Fix endpoint configuration
Date: Fri, 20 Feb 2026 16:55:25 +0100
Message-ID: <20260220155525.860822-1-frederic.danis@collabora.com>
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
 profiles/audio/media.c |  4 +---
 src/shared/bap.c       | 11 ++++++++---
 src/shared/bap.h       | 30 +++++++++++++++++-------------
 unit/test-bap.c        | 34 ++++++++++++++++------------------
 4 files changed, 42 insertions(+), 37 deletions(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 772af1014..0b88c46f1 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -1363,7 +1363,7 @@ static bool endpoint_init_pac(struct media_endpoint *endpoint, uint8_t type,
 
 	endpoint->pac = bt_bap_add_vendor_pac(db, name, type, endpoint->codec,
 				endpoint->cid, endpoint->vid, &endpoint->qos,
-				&data, metadata);
+				&data, metadata, &pac_ops, endpoint);
 	if (!endpoint->pac) {
 		error("Unable to create PAC");
 		free(name);
@@ -1371,8 +1371,6 @@ static bool endpoint_init_pac(struct media_endpoint *endpoint, uint8_t type,
 		return false;
 	}
 
-	bt_bap_pac_set_ops(endpoint->pac, &pac_ops, endpoint);
-
 	DBG("PAC %s registered", name);
 
 	free(name);
diff --git a/src/shared/bap.c b/src/shared/bap.c
index 37b04c5c1..549c43c34 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -4129,7 +4129,9 @@ struct bt_bap_pac *bt_bap_add_vendor_pac(struct gatt_db *db,
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
@@ -4150,6 +4152,7 @@ struct bt_bap_pac *bt_bap_add_vendor_pac(struct gatt_db *db,
 	codec.vid = vid;
 
 	pac = bap_pac_new(bdb, name, type, &codec, qos, data, metadata);
+	bt_bap_pac_set_ops(pac, ops, ops_user_data);
 
 	switch (type) {
 	case BT_BAP_SINK:
@@ -4178,10 +4181,12 @@ struct bt_bap_pac *bt_bap_add_pac(struct gatt_db *db, const char *name,
 					uint8_t type, uint8_t id,
 					struct bt_bap_pac_qos *qos,
 					struct iovec *data,
-					struct iovec *metadata)
+					struct iovec *metadata,
+					struct bt_bap_pac_ops *ops,
+					void *ops_user_data)
 {
 	return bt_bap_add_vendor_pac(db, name, type, id, 0x0000, 0x0000, qos,
-							data, metadata);
+					data, metadata, ops, ops_user_data);
 }
 
 uint8_t bt_bap_pac_get_type(struct bt_bap_pac *pac)
diff --git a/src/shared/bap.h b/src/shared/bap.h
index c1b75949f..f7e25a93c 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -67,19 +67,6 @@ struct bt_bap_pac_qos {
 	uint16_t context;
 };
 
-struct bt_bap_pac *bt_bap_add_vendor_pac(struct gatt_db *db,
-					const char *name, uint8_t type,
-					uint8_t id, uint16_t cid, uint16_t vid,
-					struct bt_bap_pac_qos *qos,
-					struct iovec *data,
-					struct iovec *metadata);
-
-struct bt_bap_pac *bt_bap_add_pac(struct gatt_db *db, const char *name,
-					uint8_t type, uint8_t id,
-					struct bt_bap_pac_qos *qos,
-					struct iovec *data,
-					struct iovec *metadata);
-
 struct bt_bap_pac_ops {
 	int (*select)(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 			uint32_t chan_alloc, struct bt_bap_pac_qos *qos,
@@ -92,6 +79,23 @@ struct bt_bap_pac_ops {
 	void (*clear)(struct bt_bap_stream *stream, void *user_data);
 };
 
+struct bt_bap_pac *bt_bap_add_vendor_pac(struct gatt_db *db,
+					const char *name, uint8_t type,
+					uint8_t id, uint16_t cid, uint16_t vid,
+					struct bt_bap_pac_qos *qos,
+					struct iovec *data,
+					struct iovec *metadata,
+					struct bt_bap_pac_ops *ops,
+					void *ops_user_data);
+
+struct bt_bap_pac *bt_bap_add_pac(struct gatt_db *db, const char *name,
+					uint8_t type, uint8_t id,
+					struct bt_bap_pac_qos *qos,
+					struct iovec *data,
+					struct iovec *metadata,
+					struct bt_bap_pac_ops *ops,
+					void *ops_user_data);
+
 bool bt_bap_pac_set_ops(struct bt_bap_pac *pac, struct bt_bap_pac_ops *ops,
 					void *user_data);
 
diff --git a/unit/test-bap.c b/unit/test-bap.c
index 3a67e7016..ab3996e22 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -686,12 +686,12 @@ static void test_setup_pacs(struct test_data *data)
 							BT_BAP_SINK, 0x0ff,
 							0x0001, 0x0001,
 							data->qos, data->caps,
-							NULL);
+							NULL, NULL, NULL);
 		else
 			data->snk = bt_bap_add_pac(data->db, "test-bap-snk",
 							BT_BAP_SINK, LC3_ID,
 							data->qos, data->caps,
-							NULL);
+							NULL, NULL, NULL);
 		g_assert(data->snk);
 	}
 
@@ -702,12 +702,12 @@ static void test_setup_pacs(struct test_data *data)
 							BT_BAP_SOURCE, 0x0ff,
 							0x0001, 0x0001,
 							data->qos, data->caps,
-							NULL);
+							NULL, NULL, NULL);
 		else
 			data->src = bt_bap_add_pac(data->db, "test-bap-src",
 							BT_BAP_SOURCE, LC3_ID,
 							data->qos, data->caps,
-							NULL);
+							NULL, NULL, NULL);
 		g_assert(data->src);
 	}
 }
@@ -753,30 +753,28 @@ static void test_setup_server(const void *user_data)
 		data->snk = bt_bap_add_vendor_pac(db, "test-bap-snk",
 							BT_BAP_SINK, 0x0ff,
 							0x0001, 0x0001,
-							data->qos, NULL,
-							NULL);
+							data->qos, NULL, NULL,
+							&ucast_pac_ops, NULL);
 	else
 		data->snk = bt_bap_add_pac(db, "test-bap-snk", BT_BAP_SINK,
 							LC3_ID, data->qos,
-							data->caps, NULL);
+							data->caps, NULL,
+							&ucast_pac_ops, NULL);
 	g_assert(data->snk);
 
-	bt_bap_pac_set_ops(data->snk, &ucast_pac_ops, NULL);
-
 	if (data->cfg && data->cfg->vs)
 		data->src = bt_bap_add_vendor_pac(db, "test-bap-snk",
 							BT_BAP_SOURCE, 0x0ff,
 							0x0001, 0x0001,
-							data->qos, NULL,
-							NULL);
+							data->qos, NULL, NULL,
+							&ucast_pac_ops, NULL);
 	else
 		data->src = bt_bap_add_pac(db, "test-bap-src", BT_BAP_SOURCE,
 							LC3_ID, data->qos,
-							data->caps, NULL);
+							data->caps, NULL,
+							&ucast_pac_ops, NULL);
 	g_assert(data->src);
 
-	bt_bap_pac_set_ops(data->src, &ucast_pac_ops, NULL);
-
 	att = bt_att_new(io_get_fd(io), false);
 	g_assert(att);
 
@@ -1052,13 +1050,13 @@ static void test_bcast_config(struct test_data *data)
 							BT_BAP_BCAST_SOURCE,
 							0x0ff, 0x0000, 0x0000,
 							NULL, data->caps,
-							NULL);
+							NULL, NULL, NULL);
 		else
 			data->bsrc = bt_bap_add_pac(data->db, "test-bap-bsrc",
 							BT_BAP_BCAST_SOURCE,
 							LC3_ID,
 							NULL, data->caps,
-							NULL);
+							NULL, NULL, NULL);
 
 		g_assert(data->bsrc);
 	}
@@ -1073,13 +1071,13 @@ static void test_bcast_config(struct test_data *data)
 							BT_BAP_BCAST_SINK,
 							0xff, 0x0000, 0x0000,
 							NULL, data->caps,
-							NULL);
+							NULL, NULL, NULL);
 		else
 			data->bsnk = bt_bap_add_pac(data->db, "test-bap-bsnk",
 							BT_BAP_BCAST_SINK,
 							LC3_ID,
 							NULL, data->caps,
-							NULL);
+							NULL, NULL, NULL);
 
 		g_assert(data->bsnk);
 	}
-- 
2.43.0

