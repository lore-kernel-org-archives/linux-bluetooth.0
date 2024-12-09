Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32571E515
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Dec 2024 20:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733777932; cv=none; b=VIekeTVFcOci7oQIQvH8n11nfYKQFRGLwsudzI5KorM7W4Ihrpg3GnUmYkhT6qi5EBLKTBZ4vo2abRs6TR6Ozd8ZI9oJmdxd72iZlGPtR6llsfh8Ah0GlTrHaVeIYVakqCY5ClQ4C8m9xM0X3wqbJWrDOPPTglugd+JS5bqce1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733777932; c=relaxed/simple;
	bh=RxEIPpdPTDSlD5uhcmRfAorHwAU5J7cSXd45B0gLdFY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VfO6Bn3mVuTYUh31MtGNHxrIM06SWa2Tynpl7u3XlP/2ISQUesL4oSxw50KP+2AjpZIvyb4cz7lEqUnxG9G6MCYZSFnmFlrvLwoV5RqnsCYCs10ZPXicctX47fs648gwEkQLrOApaXYpIZbLK6WqqJ3Wb10mm/oVYymUETAVi4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d3MFkoH6; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3MFkoH6"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e3983fe3aadso4615688276.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Dec 2024 12:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733777929; x=1734382729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6CbYWb1jlIhdlhwCdhvt+Vz2pjKRNVPktxwN0AQdrEo=;
        b=d3MFkoH6jEo+kvUg2Z+2W/Lpxr7nmTl93YltWFP4C9WaQhtXzVBGhVhEtkNWQX1imu
         JFG4sfaKNIbpycOlUnlXuzECg91u+6/s+5GI6qZTkG43Nit7sXRUaT2lLZRfmxScHfSo
         8H9/3+6apCwBtS2HACGP9eoZ3AESreEBOn96UEyqZbCihSX+4RtvBzZ24ddc/FPynrbQ
         jybaA1wMuZO2PyKpg8llQJdCBd1/Ow99+UTE3P1hb/L2vM0K5Xlwe9VSjYrIcysSfgNQ
         hKzjv9Hu7arWK5fD5iUSDma4bk7BgNqKaHLKq/Obd5Yo2r6W6U3mNCEIcU8XZXlYzS+r
         BdRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733777929; x=1734382729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6CbYWb1jlIhdlhwCdhvt+Vz2pjKRNVPktxwN0AQdrEo=;
        b=XQZnejU0BLj0zxzEZ1ifQ1TEXRG0xo9m0SplkAxGQ/D13NUZinQwQVs6m4xRS84vfI
         In3p4Iq1x5+NayCePiovswcXV5foKnStmMIAx4IuS8NGkBf2u02Pq7vQRXf3hN4kM3lx
         jHdNtAE1SMTUcZEtVdr3sI6xOrIZh0oYoU++P70InyKfOqOL61OoRClX4vG87DVnfvzu
         LQlusXzb4VSgeHUympQQ66K9vyw1Ljf1Tz2J03MBpc1GRwKxr1N/48BNKMgH4g309BHO
         niS9ZL5+roEEe9QRPHW0CLBRL76OGgmLxIO7ZR3BxY/+ZJSS4dRAwp0co/Ko/hVoDNOv
         7YyQ==
X-Gm-Message-State: AOJu0Yz3GDFCy/nTqk/cApBDcZJ1ePaj7qb1UGO8scGNBsVN18vcMCOc
	0hAmlTVqmeYunPBDR15efQburQ8BP74KGw0SsOk7O4ElMb68nxB+z65Iew==
X-Gm-Gg: ASbGncs+wofbWXTSXurKGxiJSy5Nmcy8clL8i/JCs+7eINYc2T0pAN2pfRT3I5kQVgj
	RacF7870RsNWbCTr2wwU1TzAx9lVJXDuFrKqfnTvQ1k86z5zbKshI0R9iJGuz661fHRl+io7UX0
	D8du9aHM6JEyYEcKpWXpsudXu6847CASmHyr7F1nM+gUvvc3nIIVYg48MWCF0cI+L6XPdIClxtq
	nRLuRoFvtNBQilK/sIHUS5SOuzpcLC0cWn0BvoljCqmp89v1EPoQgy5o3oYaLW5/g/V2kAjJDPc
	5EZmdaC7r971zX4lwPWfnpjfgA==
X-Google-Smtp-Source: AGHT+IFwbt+TPVAS6qNVupP5AMmkjemvyCFlgyp7/uqURloUcImBbK95sEPBFY/5TsXf+UlQWM8RkA==
X-Received: by 2002:a05:6902:1149:b0:e39:83a4:dce6 with SMTP id 3f1490d57ef6-e3a0b1345f8mr11872925276.25.1733777929121;
        Mon, 09 Dec 2024 12:58:49 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e39f6a42f31sm2556098276.4.2024.12.09.12.58.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 12:58:48 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 3/3] monitor: Allow caching of temporary gatt_db
Date: Mon,  9 Dec 2024 15:58:43 -0500
Message-ID: <20241209205843.1394081-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209205843.1394081-1-luiz.dentz@gmail.com>
References: <20241209205843.1394081-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the problem of not being able to decode GATT traffic when
reading the traces from a file/offline, the gatt_db would be discarded
upon the first disconnection so it didn't work if the trace contains
multiple connections.

To fix this btmon would remember gatt_db discovered at runtime so even
when there multiple connections the same db would be used.
---
 monitor/att.c    | 61 ++++++++++++++++++++++++++++++++++++++++++++----
 monitor/packet.c |  2 +-
 monitor/packet.h |  2 +-
 3 files changed, 58 insertions(+), 7 deletions(-)

diff --git a/monitor/att.c b/monitor/att.c
index 3f41c2bd096f..4358cd7348f7 100644
--- a/monitor/att.c
+++ b/monitor/att.c
@@ -63,6 +63,13 @@ struct att_conn_data {
 	uint16_t mtu;
 };
 
+struct gatt_cache {
+	bdaddr_t id;
+	struct gatt_db *db;
+};
+
+static struct queue *cache_list;
+
 static void print_uuid(const char *label, const void *data, uint16_t size)
 {
 	const char *str;
@@ -397,10 +404,42 @@ static const struct bitfield_data chrc_prop_table[] = {
 	{ }
 };
 
-static void att_conn_data_free(void *data)
+static bool match_cache_id(const void *data, const void *match_data)
+{
+	const struct gatt_cache *cache = data;
+	const bdaddr_t *id = match_data;
+
+	return !bacmp(&cache->id, id);
+}
+
+static void gatt_cache_add(struct packet_conn_data *conn, struct gatt_db *db)
+{
+	struct gatt_cache *cache;
+	bdaddr_t id;
+	uint8_t id_type;
+
+	if (!keys_resolve_identity(conn->dst, id.b, &id_type))
+		bacpy(&id, (bdaddr_t *)conn->dst);
+
+	if (queue_find(cache_list, match_cache_id, &id))
+		return;
+
+	if (!cache_list)
+		cache_list = queue_new();
+
+	cache = new0(struct gatt_cache, 1);
+	bacpy(&cache->id, &id);
+	cache->db = gatt_db_ref(db);
+	queue_push_tail(cache_list, cache);
+}
+
+static void att_conn_data_free(struct packet_conn_data *conn, void *data)
 {
 	struct att_conn_data *att_data = data;
 
+	if (!gatt_db_isempty(att_data->rdb))
+		gatt_cache_add(conn, att_data->rdb);
+
 	gatt_db_unref(att_data->rdb);
 	gatt_db_unref(att_data->ldb);
 	queue_destroy(att_data->reads, free);
@@ -456,20 +495,32 @@ static void load_gatt_db(struct packet_conn_data *conn)
 	char filename[PATH_MAX];
 	char local[18];
 	char peer[18];
-	uint8_t id[6], id_type;
+	bdaddr_t id;
+	uint8_t id_type;
 
 	ba2str((bdaddr_t *)conn->src, local);
 
-	if (keys_resolve_identity(conn->dst, id, &id_type))
-		ba2str((bdaddr_t *)id, peer);
-	else
+	if (keys_resolve_identity(conn->dst, id.b, &id_type)) {
+		ba2str(&id, peer);
+	} else {
+		bacpy(&id, (bdaddr_t *)conn->dst);
 		ba2str((bdaddr_t *)conn->dst, peer);
+	}
 
 	create_filename(filename, PATH_MAX, "/%s/attributes", local);
 	gatt_load_db(data->ldb, filename, &data->ldb_mtim);
 
 	create_filename(filename, PATH_MAX, "/%s/cache/%s", local, peer);
 	gatt_load_db(data->rdb, filename, &data->rdb_mtim);
+
+	/* If rdb cannot be loaded from file try local cache */
+	if (gatt_db_isempty(data->rdb)) {
+		struct gatt_cache *cache;
+
+		cache = queue_find(cache_list, match_cache_id, &id);
+		if (cache)
+			data->rdb = cache->db;
+	}
 }
 
 static struct gatt_db *get_db(const struct l2cap_frame *frame, bool rsp)
diff --git a/monitor/packet.c b/monitor/packet.c
index f1a42925a8fc..6a2767ae39b3 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -199,7 +199,7 @@ static struct packet_conn_data *release_handle(uint16_t handle)
 
 		if (conn->handle == handle) {
 			if (conn->destroy)
-				conn->destroy(conn->data);
+				conn->destroy(conn, conn->data);
 
 			queue_destroy(conn->tx_q, free);
 			queue_destroy(conn->chan_q, free);
diff --git a/monitor/packet.h b/monitor/packet.h
index 856f74f4db16..964b9a7219fa 100644
--- a/monitor/packet.h
+++ b/monitor/packet.h
@@ -50,7 +50,7 @@ struct packet_conn_data {
 	struct queue *chan_q;
 	struct packet_latency tx_l;
 	void     *data;
-	void     (*destroy)(void *data);
+	void     (*destroy)(struct packet_conn_data *conn, void *data);
 };
 
 struct packet_conn_data *packet_get_conn_data(uint16_t handle);
-- 
2.47.1

