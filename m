Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6E61DEFE4
	for <linux-bluetooth@vger.kernel.org>; Sun,  4 May 2025 16:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746374544; cv=pass; b=MFtlL+H1Yvxbv3SpCsB/xtOvW2mBjP6XZzIJgmcQTrKBxGioRt2SsJAcijB+WSL0UocFxhdF8URVG9wR7jwlUiBfgm9x1eFOGfo6mh8eDu7/dbk621F/29w6Awqst4aE2bA6DL1UvKwRFyPqvFcnvyMWUdcwXn+BJlRH97mtWoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746374544; c=relaxed/simple;
	bh=Z9XUNkrNdZxYdwX5JjhdtlLBvrYW9KzxIiTiXUO36yk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JkKODI9MZAbEs7AqS5tCL1nU+OzDTtNJtaaZTFP7TQ3zFqrDWCz4EuyKiw9L7c+GIJANwlsLdKtdPjH04IFrUo3s7GdwjzORlCPycvawnKo/3ZNLj29wbEQWZV9msSIt2QnecU841H4HMKbajO3zgULm6Kui03CbQQgpuOWohLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=hemBsBFA; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="hemBsBFA"
Received: from monolith.lan (unknown [185.77.218.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4Zr8Yg46zZzyVF;
	Sun,  4 May 2025 19:02:15 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1746374535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tB7woLWWJlDYT6FjDYIsVt2IIHAW//8aLBaypFnlWMU=;
	b=hemBsBFA5A5vC2zmvl5w5reUgZs61sQ5pqYAjC78JCd99/oJErcOoUv1POS3oZyrRFeq7y
	hruhaZ9Eq5GV2ZuLeW7oJtnlPBgg2YINsatIBFT4ZyuHOQNIhhkCNscz/44r8s7zZkBawq
	rL9RU9B+ymJ9GbABi7pIpKGr5+q9kFo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1746374535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tB7woLWWJlDYT6FjDYIsVt2IIHAW//8aLBaypFnlWMU=;
	b=QCXwstemK/mLY9ObRXkCL/01NhKW9V/ZH9jVDvg9P7wwDR9V74c4JlH8VCnGwoRHA00f3f
	OC/e1+1WgVpa7syhSpGd5PwOF/1dDfm4mOq9cL/KMfsP165PfNVhY1yzN4+YcFmCx89gDg
	Lp/9Vw9xxSt51+c/PUQwSRbZA7o7X9M=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1746374535; a=rsa-sha256; cv=none;
	b=uQhFKXsSRYmiSQJUFIk2MhZ34r8IjxfFv7ZAwIw/pZ522TtlR1hZU8oDHDwvJDMplod5Nx
	Q++gJwsn/qioneSqJNaWIDUS4wOff7Vs4nkvf3Dm7qYTrvaztnW4cC8Wu39EqKYHSXfGyM
	OG0fp3besMjsRJZmjOwrkany9+UFDyw=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH BlueZ v2 09/11] bap: add callback at the end of ucast client select/config
Date: Sun,  4 May 2025 19:02:01 +0300
Message-ID: <f2fde5226a21de8ed9ee8aff1d256fe9fb34ffe4.1746374514.git.pav@iki.fi>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <3c9eb72cf7b16ea0b710d62221436e2777f7360b.1746374514.git.pav@iki.fi>
References: <3c9eb72cf7b16ea0b710d62221436e2777f7360b.1746374514.git.pav@iki.fi>
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
 profiles/audio/bap.c | 173 +++++++++++++++++++++++++++++++++----------
 1 file changed, 134 insertions(+), 39 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index c9755ad96..89900602f 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -66,10 +66,12 @@
 #define MEDIA_INTERFACE "org.bluez.Media1"
 
 struct bap_setup;
+struct bap_select;
 
 typedef void (*bap_setup_ready_func_t)(struct bap_setup *setup, int code,
 						uint8_t reason, void *data);
 typedef void (*bap_setup_close_func_t)(struct bap_setup *setup, void *data);
+typedef void (*bap_select_done_t)(int err, void *data);
 
 struct bap_setup {
 	struct bap_ep *ep;
@@ -96,6 +98,15 @@ struct bap_setup {
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
@@ -105,6 +116,7 @@ struct bap_ep {
 	uint16_t supported_context;
 	uint16_t context;
 	struct queue *setups;
+	struct bap_select *select;
 };
 
 struct bap_data {
@@ -122,7 +134,6 @@ struct bap_data {
 	struct queue *server_streams;
 	GIOChannel *listen_io;
 	unsigned int io_id;
-	int selecting;
 	void *user_data;
 };
 
@@ -1614,14 +1625,37 @@ static int setup_config(struct bap_setup *setup, bap_setup_ready_func_t cb,
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
 
@@ -1629,7 +1663,37 @@ static void bap_config(void *data, void *user_data)
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
@@ -1637,11 +1701,11 @@ static void select_cb(struct bt_bap_pac *pac, int err, struct iovec *caps,
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
 
@@ -1650,38 +1714,15 @@ static void select_cb(struct bt_bap_pac *pac, int err, struct iovec *caps,
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
@@ -1703,9 +1744,57 @@ static bool pac_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
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
@@ -1723,9 +1812,16 @@ static bool pac_cancel_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
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
@@ -1752,6 +1848,7 @@ static bool pac_found_bcast(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 static void bap_ready(struct bt_bap *bap, void *user_data)
 {
 	struct btd_service *service = user_data;
+	struct bap_data *data = btd_service_get_user_data(service);
 
 	DBG("bap %p", bap);
 
@@ -1761,8 +1858,7 @@ static void bap_ready(struct bt_bap *bap, void *user_data)
 	bt_bap_foreach_pac(bap, BT_BAP_SOURCE, pac_register, service);
 	bt_bap_foreach_pac(bap, BT_BAP_SINK, pac_register, service);
 
-	bt_bap_foreach_pac(bap, BT_BAP_SOURCE, pac_select, service);
-	bt_bap_foreach_pac(bap, BT_BAP_SINK, pac_select, service);
+	bap_select_all(data, NULL, NULL);
 }
 
 static bool match_setup_stream(const void *data, const void *user_data)
@@ -2716,8 +2812,7 @@ static void pac_added(struct bt_bap_pac *pac, void *user_data)
 	bt_bap_foreach_pac(data->bap, BT_BAP_SOURCE, pac_register, service);
 	bt_bap_foreach_pac(data->bap, BT_BAP_SINK, pac_register, service);
 
-	bt_bap_foreach_pac(data->bap, BT_BAP_SOURCE, pac_select, service);
-	bt_bap_foreach_pac(data->bap, BT_BAP_SINK, pac_select, service);
+	bap_select_all(data, NULL, NULL);
 }
 
 static void pac_added_broadcast(struct bt_bap_pac *pac, void *user_data)
-- 
2.49.0

