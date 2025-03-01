Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CF31E285A
	for <linux-bluetooth@vger.kernel.org>; Sat,  1 Mar 2025 15:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740844678; cv=pass; b=Rcmuxl9EiGGnBuu2PVuUywkONt0+wkzu/93fl8AYq9lIAe3LmvGS5aO4WM1m9x5aUFE3xpgr92FoqeMNByNJ+hWiogLwsIC45zcFHsNmnmZJjkx3ZMyEgzjPfXAHucQylOhJk4loAjoyR+J1nEXkFO6Il6jpkbootzR1x2rooGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740844678; c=relaxed/simple;
	bh=4Fnm2JP/45UAwEEJfuUAjSAvc6A9AiXOIz6y3NQKTVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VuxciEv0vwtTIE5rbu3lhtaAU/WeS5v/brgCaj+3PiR9odH/dHI0/8QC8CbF+0BpyAAcJIdod1kiwOZk5cdgD4RKOPwZn2Oodum5Fi4aAw06oWP8775znhDSSQhIXTUslzUahWmJH8JY2G1yAPfzMCm01UlO3pk4TBNBe9ZkrM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=tFoFtToa; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="tFoFtToa"
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Z4qV45rQwz4BKHn;
	Sat,  1 Mar 2025 17:57:48 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1740844669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NrLVNcNBbcKQ1SxqJACUSBtWsdC70xec3EeqVspDAR8=;
	b=tFoFtToaADkNzSBq3pUhXv/itBWrN1fx+Df5nVSN9aj65vv7Zgo6cu/UYfbtodiWKq+XYc
	/0dwQm080dSM0iOYu2KkB8yAxge70B1RmNOcW37tJlWNdHsXWJL4wDt6rGocM+IBZmeAxw
	ouA82KDbALVN91O4rhFbk57GWpvR3KsKzauHdUswt9P7KeaDPVSH0ztTBzDPBoIFYNzz7e
	x0CRp/GF68sEmFH1Rgb8BZwAo2EVPKqnsHW/rsO2nH9TIchzKxQpXkSNPaftRUvF0cXQBv
	Is2V+pjkpdzX+NPMDISxMhLhVGoTFSHKm38ITRRQxf7rbTPCyEb3uzJ9kVFhmA==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1740844669; a=rsa-sha256;
	cv=none;
	b=oG+ElgA5DYJOrSXLHGK0sofn7Bj8/9UbfAoY4O4mvlczt0yYauKUR+TZTi8N+ajnx2WtUP
	EpWLFUdpGMspx4P6qrIhJo9C3rSiWcOSYJo3lbUSpUXrMBaOCLmYfZV54XoKU6x11Z93jA
	zqQGqF1yK0B04oK5rwqG2PUbiYWWYcedXN/nwBJ9f0zV7wRvU8RwwQExfsK4c9wFBM5w2D
	hoG4UH2GAd4XSnhSoOidhFa+3wzb2DKkClxDQXLOZ0JXOnlTSuLB41K/ktWRRt0/T2OOPC
	iu6cIUbrcftmD1OAdhyf+uZkh+JJfYQcQuQYM6LhMoBgBcaX0XxIAwrv6TDhjw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1740844669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NrLVNcNBbcKQ1SxqJACUSBtWsdC70xec3EeqVspDAR8=;
	b=Qs5Io/FENcg4WDD+WhQlM2XllyRCIcjy72LCrhJPVL244fEC6A0iMmvWucco0GyLzP8Wxs
	S0/ObWaXQlyc/oqFaZTLda8g8NLjNXrWbTYLkfwhmwAxKP56wfWsKZWjNpCANSZR2y5b7F
	DXiR1uF2HXyTQGnYm9C6DbA883wN9nzd3bSth4kDjGLV7b2AbAtdnH2Xpuj+tzpmq+16pl
	M7bFyKz889X/Q+vEmZakqgznHTNvPMs/gwUcU/RzzjGd1n8emhL8bpYVaewcxjjxF9lsez
	iQtBrjHViY+SNllbmYUKKOzQl5SgEFcCmiyYnqeTS7H2JcmSORMVdiagH6+iFg==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH BlueZ 4/9] bap: use futures for select operation
Date: Sat,  1 Mar 2025 17:57:35 +0200
Message-ID: <53008159e52e92871039f94677f3b469eea83cfe.1740844616.git.pav@iki.fi>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740844616.git.pav@iki.fi>
References: <cover.1740844616.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change select operation to use futures.

Remove spurious bap_config for bcast streams, it does not even run if
there are only bcast PACs, and bcast streams are created differently.
---
 profiles/audio/bap.c | 74 ++++++++++++++++++++++++++++++++------------
 1 file changed, 55 insertions(+), 19 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 8b9b89c70..39484c74a 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -93,6 +93,8 @@ struct bap_ep {
 	uint16_t supported_context;
 	uint16_t context;
 	struct queue *setups;
+	struct future *select_done;
+	int selecting;
 };
 
 struct bap_data {
@@ -110,7 +112,6 @@ struct bap_data {
 	struct queue *streams;
 	GIOChannel *listen_io;
 	unsigned int io_id;
-	int selecting;
 	void *user_data;
 };
 
@@ -166,6 +167,8 @@ struct bt_iso_qos bap_sink_pa_qos = {
 	}
 };
 
+static void pac_select_all(struct bap_data *data);
+
 static void future_clear(struct future **p, int err, const char *err_msg)
 {
 	struct future *h = *p;
@@ -239,7 +242,6 @@ static void future_init_dbus_reply(struct future **p, const char *name,
 	future_init(p, name, future_dbus_callback_func, dbus_message_ref(msg));
 }
 
-__attribute__((unused))
 static void future_init_chain(struct future **p, struct future *h)
 {
 	future_clear(p, ECANCELED, NULL);
@@ -1595,7 +1597,6 @@ static void select_cb(struct bt_bap_pac *pac, int err, struct iovec *caps,
 
 	if (err) {
 		error("err %d", err);
-		ep->data->selecting--;
 		goto done;
 	}
 
@@ -1604,16 +1605,12 @@ static void select_cb(struct bt_bap_pac *pac, int err, struct iovec *caps,
 	setup->metadata = util_iov_dup(metadata, 1);
 	setup->qos = *qos;
 
-	DBG("selecting %d", ep->data->selecting);
-	ep->data->selecting--;
-
 done:
-	if (ep->data->selecting)
-		return;
+	DBG("ep %p selecting %d", ep, ep->selecting);
 
-	queue_foreach(ep->data->srcs, bap_config, NULL);
-	queue_foreach(ep->data->snks, bap_config, NULL);
-	queue_foreach(ep->data->bcast, bap_config, NULL);
+	ep->selecting--;
+	if (!ep->selecting)
+		future_clear(&ep->select_done, 0, NULL);
 }
 
 static bool pac_register(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
@@ -1631,11 +1628,17 @@ static bool pac_register(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 	return true;
 }
 
+struct pac_select_data {
+	struct bap_data *data;
+	struct future *select_done;
+};
+
 static bool pac_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 							void *user_data)
 {
-	struct btd_service *service = user_data;
-	struct bap_data *data = btd_service_get_user_data(service);
+	struct pac_select_data *select_data = user_data;
+	struct bap_data *data = select_data->data;
+	struct btd_service *service = data->service;
 	struct match_ep match = { lpac, rpac };
 	struct queue *queue;
 	struct bap_ep *ep;
@@ -1658,8 +1661,12 @@ static bool pac_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 	}
 
 	/* TODO: Cache LRU? */
-	if (btd_service_is_initiator(service))
-		bt_bap_select(lpac, rpac, &ep->data->selecting, select_cb, ep);
+	if (btd_service_is_initiator(service)) {
+		bt_bap_select(lpac, rpac, &ep->selecting, select_cb, ep);
+		if (ep->selecting)
+			future_init_chain(&ep->select_done,
+						select_data->select_done);
+	}
 
 	return true;
 }
@@ -1678,8 +1685,12 @@ static void ep_cancel_select(struct bap_ep *ep)
 {
 	struct bt_bap *bap = ep->data->bap;
 
+	future_clear(&ep->select_done, ECANCELED, NULL);
+
 	bt_bap_foreach_pac(bap, BT_BAP_SOURCE, pac_cancel_select, ep);
 	bt_bap_foreach_pac(bap, BT_BAP_SINK, pac_cancel_select, ep);
+
+	ep->selecting = 0;
 }
 
 static bool pac_found_bcast(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
@@ -1703,9 +1714,36 @@ static bool pac_found_bcast(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 	return true;
 }
 
+static void select_complete_cb(int err, const char *err_msg, void *user_data)
+{
+	struct bap_data *data = user_data;
+
+	if (err == ECANCELED)
+		return;
+
+	queue_foreach(data->srcs, bap_config, NULL);
+	queue_foreach(data->snks, bap_config, NULL);
+}
+
+static void pac_select_all(struct bap_data *data)
+{
+	struct pac_select_data select_data = {
+		.data = data,
+	};
+
+	future_init(&select_data.select_done, "pac_select_all",
+						select_complete_cb, data);
+
+	bt_bap_foreach_pac(data->bap, BT_BAP_SOURCE, pac_select, &select_data);
+	bt_bap_foreach_pac(data->bap, BT_BAP_SINK, pac_select, &select_data);
+
+	future_clear(&select_data.select_done, 0, NULL);
+}
+
 static void bap_ready(struct bt_bap *bap, void *user_data)
 {
 	struct btd_service *service = user_data;
+	struct bap_data *data = btd_service_get_user_data(service);
 
 	DBG("bap %p", bap);
 
@@ -1715,8 +1753,7 @@ static void bap_ready(struct bt_bap *bap, void *user_data)
 	bt_bap_foreach_pac(bap, BT_BAP_SOURCE, pac_register, service);
 	bt_bap_foreach_pac(bap, BT_BAP_SINK, pac_register, service);
 
-	bt_bap_foreach_pac(bap, BT_BAP_SOURCE, pac_select, service);
-	bt_bap_foreach_pac(bap, BT_BAP_SINK, pac_select, service);
+	pac_select_all(data);
 }
 
 static bool match_setup_stream(const void *data, const void *user_data)
@@ -2684,8 +2721,7 @@ static void pac_added(struct bt_bap_pac *pac, void *user_data)
 	bt_bap_foreach_pac(data->bap, BT_BAP_SOURCE, pac_register, service);
 	bt_bap_foreach_pac(data->bap, BT_BAP_SINK, pac_register, service);
 
-	bt_bap_foreach_pac(data->bap, BT_BAP_SOURCE, pac_select, service);
-	bt_bap_foreach_pac(data->bap, BT_BAP_SINK, pac_select, service);
+	pac_select_all(data);
 }
 
 static void pac_added_broadcast(struct bt_bap_pac *pac, void *user_data)
-- 
2.48.1

