Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811DA211A00
	for <linux-bluetooth@vger.kernel.org>; Sun,  8 Jun 2025 21:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749418373; cv=pass; b=mhf52pC1Vx3Gh/Hwe/IaDD1Sk7kfxXxTHYtUzwABjLWL0VdQV6Oo0GCo+BpSsm4W2zWxrRuKJxgPbLJNEYoabN1SqafMumFloY1VEjgc0zF/HNiyT92R0HWNYq3K5oOw6/jcQ997iFfNvoy9EFFaKqM9Qglzv6pySQ6R07MLvkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749418373; c=relaxed/simple;
	bh=51EMIrfUn94N+Jo0OX0Ye+Mn7qIAD3wd85U2ky6F5QQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TqcNV9LTO5/2RZT5ZIuwv0TopguqTA6J6d1D2bEyXRfJj7BOQvlVmtR/Jv8oY/U2bSSL/6sxF+znmFDgrhTokNaGlZnkP8S4VMRddqmUVzotc84unoMbh8IfCx7q4kex9h5w4mK1MNxRBAbAD4dYSl+st0drxdJhEa+CNMCfKdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=hZjImpIu; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="hZjImpIu"
Received: from monolith.lan (unknown [185.77.218.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4bFpDr4cTfz49Q4L;
	Mon,  9 Jun 2025 00:32:44 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1749418364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z7pY43i1Ld2Pbs6x0tJ3ZvdyX6YIK7PovpeYrCUqAEw=;
	b=hZjImpIup/973Mv04HRkHkSomBnFPV91fP52dVfNKFU++ar7lnbMUd1HrO79l9ZpiS5DcO
	27wMTqvHRJidsqoC5UdgBdULI8Gp0mKGbqx5ZtV3JzQIxOC/4Qm+3DiPenizfuBf665NqN
	XgNrTKJfO+dUEAp3A8PtMbkk2UQy5hAn0j8iqwbUtTX6qw0z519CJshTAsNIIFPKc8sEEA
	WODwLESKJXv/8D+ZYAfmkwNQPyq5KBbLlYlNKBj5hfLUtDgthcYD3xZiXv1yd9dNy01kOZ
	krxg0by3N6OusIFaTC8bT1gtvdK6A7V+oG428Ty3rnNy4gZiElSl9COAbJU+uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1749418364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z7pY43i1Ld2Pbs6x0tJ3ZvdyX6YIK7PovpeYrCUqAEw=;
	b=e2D0R9zGF7apQMES+UTaGlH6oscEtl2orEs78uN6M6Yel6yH40yVpywiYZm52xKDeKrySA
	lhMxp/9AXvz2jBmYOs3FOruadWkgJy8ZWnXl4KCINrLR5emiYxQCxTTCrogTdtqyCdgryC
	Xv4w1lLlWYDbY0OHfdsWvw+sfBmUVWuBWXflBLuEjYpaK7NCYONh4nB8W5SlcDXSzdX/QM
	bjzYXcyJo1WPO96eUEMNE5Si4HZ+f3F8c0SUQwSRBFDJWhDcCKENvMAn8K8xmFGYe8KL+3
	KfbTeLGwCzLvsrJS41iRZ+/Jjron4RUsxtfTT4Y0g9rTXYnyFjyXFXYDNmBLsA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1749418364; a=rsa-sha256;
	cv=none;
	b=gLPjUfW1LR68/DhgGuebmNQM6NboQebGE0D3khXzJ/ZXSO3Cs7IoVa2DB7QIA9mTVInPN5
	lVEOxj8kgJt9NENxo2wwRrTncA66X/NipmxK8ZGKQcfWDJBXH7wEZTw2EuQC5yJJQ2dF8q
	xLubxb0UemQTPehuFaCYjxagrrW+EBUJIuz/uBJNDN+V82+0yv3aYBNLqT3MnKkj/GAx6F
	osahjndhEB0lC8Xd03neOlXjn8G6tAi8a2J+KeXCjNhsREYJE2zjGMk4iJtExMU1ZHDkkf
	TwCQuEyb1bbUt2QDQZXfZrGl3K6YT3i8L/vxY14WMWQ2A+8D8ThWo27FDPO1/A==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v3 07/10] bap: add callback at the end of ucast client select/config
Date: Mon,  9 Jun 2025 00:32:19 +0300
Message-ID: <387785e3c6111858e48e786d09b0f7895e4bb8b8.1749418319.git.pav@iki.fi>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749418319.git.pav@iki.fi>
References: <cover.1749418319.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Restructure pac_select() and add a callback that is called when all
setups reach QoS.
---
 profiles/audio/bap.c | 172 +++++++++++++++++++++++++++++++++----------
 1 file changed, 133 insertions(+), 39 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 648acbf30..c08a0a645 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -70,6 +70,7 @@ struct bap_setup;
 typedef void (*bap_setup_ready_func_t)(struct bap_setup *setup, int code,
 						uint8_t reason, void *data);
 typedef void (*bap_setup_close_func_t)(struct bap_setup *setup, void *data);
+typedef void (*bap_select_done_t)(int err, void *data);
 
 struct bap_setup {
 	struct bap_ep *ep;
@@ -97,6 +98,15 @@ struct bap_setup {
 	void (*destroy)(struct bap_setup *setup);
 };
 
+struct bap_select {
+	struct bap_data *data;
+	struct queue *eps;
+	int remaining;
+	int err;
+	bap_select_done_t done_cb;
+	void *done_cb_data;
+};
+
 struct bap_ep {
 	char *path;
 	struct bap_data *data;
@@ -106,6 +116,7 @@ struct bap_ep {
 	uint16_t supported_context;
 	uint16_t context;
 	struct queue *setups;
+	struct bap_select *select;
 };
 
 struct bap_data {
@@ -123,7 +134,6 @@ struct bap_data {
 	struct queue *server_streams;
 	GIOChannel *listen_io;
 	unsigned int io_id;
-	int selecting;
 	void *user_data;
 };
 
@@ -1637,14 +1647,37 @@ static int setup_config(struct bap_setup *setup, bap_setup_ready_func_t cb,
 	return 0;
 }
 
-static void bap_config_setup(void *data, void *user_data)
+static void bap_config_setup_cb(struct bap_setup *setup, int code,
+						uint8_t reason, void *user_data)
 {
-	struct bap_setup *setup = data;
+	struct bap_select *select = user_data;
 
-	if (setup_config(setup, NULL, NULL)) {
+	select->remaining--;
+
+	DBG("setup %p code %d remain %d", setup, code, select->remaining);
+
+	if (code)
+		select->err = code;
+
+	if (select->remaining)
+		return;
+
+	if (select->done_cb)
+		select->done_cb(select->err, select->done_cb_data);
+
+	free(select);
+}
+
+static void bap_config_setup(void *item, void *user_data)
+{
+	struct bap_setup *setup = item;
+	struct bap_select *select = user_data;
+
+	select->remaining++;
+	if (setup_config(setup, bap_config_setup_cb, select)) {
 		DBG("Unable to config stream");
 		setup_free(setup);
-		return;
+		select->remaining--;
 	}
 }
 
@@ -1652,7 +1685,37 @@ static void bap_config(void *data, void *user_data)
 {
 	struct bap_ep *ep = data;
 
-	queue_foreach(ep->setups, bap_config_setup, NULL);
+	queue_foreach(ep->setups, bap_config_setup, user_data);
+}
+
+static void pac_select_clear_ep(void *data)
+{
+	struct bap_ep *ep = data;
+
+	ep->select = NULL;
+}
+
+static void bap_select_complete_select(struct bap_select *select)
+{
+	select->remaining--;
+
+	DBG("selecting %d", select->remaining);
+
+	if (select->remaining)
+		return;
+
+	DBG("configure (err %d)", select->err);
+
+	queue_destroy(select->eps, pac_select_clear_ep);
+
+	select->remaining++;
+
+	if (!select->err) {
+		queue_foreach(select->data->srcs, bap_config, select);
+		queue_foreach(select->data->snks, bap_config, select);
+	}
+
+	bap_config_setup_cb(NULL, 0, 0, select);
 }
 
 static void select_cb(struct bt_bap_pac *pac, int err, struct iovec *caps,
@@ -1660,11 +1723,11 @@ static void select_cb(struct bt_bap_pac *pac, int err, struct iovec *caps,
 				void *user_data)
 {
 	struct bap_ep *ep = user_data;
+	struct bap_select *select = ep->select;
 	struct bap_setup *setup;
 
 	if (err) {
 		error("err %d", err);
-		ep->data->selecting--;
 		goto done;
 	}
 
@@ -1673,38 +1736,15 @@ static void select_cb(struct bt_bap_pac *pac, int err, struct iovec *caps,
 	setup->metadata = util_iov_dup(metadata, 1);
 	setup->qos = *qos;
 
-	DBG("selecting %d", ep->data->selecting);
-	ep->data->selecting--;
-
 done:
-	if (ep->data->selecting)
-		return;
-
-	queue_foreach(ep->data->srcs, bap_config, NULL);
-	queue_foreach(ep->data->snks, bap_config, NULL);
-	queue_foreach(ep->data->bcast, bap_config, NULL);
-}
-
-static bool pac_register(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
-							void *user_data)
-{
-	struct btd_service *service = user_data;
-	struct bap_ep *ep;
-
-	DBG("lpac %p rpac %p", lpac, rpac);
-
-	ep = ep_register(service, lpac, rpac);
-	if (!ep)
-		error("Unable to register endpoint for pac %p", rpac);
-
-	return true;
+	bap_select_complete_select(select);
 }
 
 static bool pac_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 							void *user_data)
 {
-	struct btd_service *service = user_data;
-	struct bap_data *data = btd_service_get_user_data(service);
+	struct bap_select *select = user_data;
+	struct bap_data *data = select->data;
 	struct match_ep match = { lpac, rpac };
 	struct queue *queue;
 	struct bap_ep *ep;
@@ -1726,9 +1766,57 @@ static bool pac_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 		return true;
 	}
 
+	if (ep->select && ep->select != select) {
+		select->err = -EBUSY;
+		return true;
+	}
+
 	/* TODO: Cache LRU? */
-	if (btd_service_is_initiator(service))
-		bt_bap_select(lpac, rpac, &ep->data->selecting, select_cb, ep);
+
+	if (!ep->select) {
+		ep->select = select;
+		queue_push_tail(select->eps, ep);
+	}
+
+	bt_bap_select(lpac, rpac, &select->remaining, select_cb, ep);
+
+	return true;
+}
+
+static int bap_select_all(struct bap_data *data, bap_select_done_t cb,
+								void *user_data)
+{
+	struct bap_select *select;
+
+	if (!btd_service_is_initiator(data->service))
+		return -EINVAL;
+
+	select = new0(struct bap_select, 1);
+	select->remaining = 1;
+	select->data = data;
+	select->eps = queue_new();
+	select->done_cb = cb;
+	select->done_cb_data = user_data;
+
+	bt_bap_foreach_pac(data->bap, BT_BAP_SOURCE, pac_select, select);
+	bt_bap_foreach_pac(data->bap, BT_BAP_SINK, pac_select, select);
+
+	bap_select_complete_select(select);
+
+	return 0;
+}
+
+static bool pac_register(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
+							void *user_data)
+{
+	struct btd_service *service = user_data;
+	struct bap_ep *ep;
+
+	DBG("lpac %p rpac %p", lpac, rpac);
+
+	ep = ep_register(service, lpac, rpac);
+	if (!ep)
+		error("Unable to register endpoint for pac %p", rpac);
 
 	return true;
 }
@@ -1746,9 +1834,16 @@ static bool pac_cancel_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 static void ep_cancel_select(struct bap_ep *ep)
 {
 	struct bt_bap *bap = ep->data->bap;
+	struct bap_select *select;
 
 	bt_bap_foreach_pac(bap, BT_BAP_SOURCE, pac_cancel_select, ep);
 	bt_bap_foreach_pac(bap, BT_BAP_SINK, pac_cancel_select, ep);
+
+	select = ep->select;
+	if (select) {
+		queue_remove(select->eps, ep);
+		ep->select = NULL;
+	}
 }
 
 static bool pac_found_bcast(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
@@ -1775,6 +1870,7 @@ static bool pac_found_bcast(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 static void bap_ready(struct bt_bap *bap, void *user_data)
 {
 	struct btd_service *service = user_data;
+	struct bap_data *data = btd_service_get_user_data(service);
 
 	DBG("bap %p", bap);
 
@@ -1784,8 +1880,7 @@ static void bap_ready(struct bt_bap *bap, void *user_data)
 	bt_bap_foreach_pac(bap, BT_BAP_SOURCE, pac_register, service);
 	bt_bap_foreach_pac(bap, BT_BAP_SINK, pac_register, service);
 
-	bt_bap_foreach_pac(bap, BT_BAP_SOURCE, pac_select, service);
-	bt_bap_foreach_pac(bap, BT_BAP_SINK, pac_select, service);
+	bap_select_all(data, NULL, NULL);
 }
 
 static bool match_setup_stream(const void *data, const void *user_data)
@@ -2742,8 +2837,7 @@ static void pac_added(struct bt_bap_pac *pac, void *user_data)
 	bt_bap_foreach_pac(data->bap, BT_BAP_SOURCE, pac_register, service);
 	bt_bap_foreach_pac(data->bap, BT_BAP_SINK, pac_register, service);
 
-	bt_bap_foreach_pac(data->bap, BT_BAP_SOURCE, pac_select, service);
-	bt_bap_foreach_pac(data->bap, BT_BAP_SINK, pac_select, service);
+	bap_select_all(data, NULL, NULL);
 }
 
 static void pac_added_broadcast(struct bt_bap_pac *pac, void *user_data)
-- 
2.49.0

