Received: from mail-vs2-f40.google.com (mail-vs2-f40.google.com [74.125.227.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDCE282F10
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 21:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789506941; cv=none; b=oG8qWUwoVBDhfaABOmEGlYJIq2ZqR7OMnxvU5SFw7eVO8j6vllfq+L7WQgYiH56G3yZ/K1aBResN7qeP+f3qRYjDsl+yzIB0wzlKhVAl9FUsjtaAa55hdwMAc/0gESH+wqUqxaDTKXw3gUcf93FqojqMMaPt4Eo9Ahj9geQ1jIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789506941; c=relaxed/simple;
	bh=wAQ3jLKMszogP9pvRqlI0/O1bEvAmVxpuyZTfX0zdpE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FtebBnOLpnzuN96ak4KFPbfkLTv2XqMcILu/hDgsxD7AQDweNZmLBicTaKcg1R6bJFvXWO68F7lCHb9/phwWf7cf3eebSaT8FEPS2MoaKY9qQFgH2C7gxPM7E5M+yiP+Iztjj0Z9S+tWcBwd5zYJ7EXgUsHRNR+TOZ68XdL8fH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kG70ZMNy; arc=none smtp.client-ip=74.125.227.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kG70ZMNy"
Received: by mail-vs2-f40.google.com with SMTP id ada2fe7eead31-7a03fe69236so12564137.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 14:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789506939; x=1790111739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2ZIxU+CV63aqjWTSkUXWFGraC0QcultJ+SvCh9tb+0w=;
        b=kG70ZMNyRNluuSCsGqs8hVc+uPUlIMoRMKKJEoxRJxaey+DymhyheLWwOUENVylhze
         54EAIhY89/JYyCzRumRpuWpAg4qbrfXVsJGYbf0ZQ1MZ05WIWZsmuVZQ38RDt2BalvLj
         tTDxOWwuHNscEMo/MhQRpFQu9ZkLKEvoCOiVF+E2bn9oa2N3hLMirdf23Vu3Z6YPn3Ez
         rPU7b1Lp9LJjSahQtU0i5gw0lG9OzfTw8c3ukeAFDXt4eTA8gwPfJ3XtkJKcfhSBcYvd
         kq4rOhhhYJa/ulYcrjZuXDc+Qm9F5UH7+0WJDFvb8bSRDpSXZgJqzko7GaDt4EIhEqPv
         t3IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789506939; x=1790111739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=2ZIxU+CV63aqjWTSkUXWFGraC0QcultJ+SvCh9tb+0w=;
        b=EvuRwqjK+otVxdi2w2Z9t6p64Dp0YyR8fth6jz5P8VpEWjyDJGsMT0/uM8v575nLPJ
         47stddoV62J6IVSzUpwOz28RpN4LK3TrXixfbeH4w3Dufy+vtIeWQAoc8pxiXQSTzRxb
         0jGJg1R8SQWJxBMsqkJYKcUzhf2mR53ZWzzjsHngMXuw2VcqrYAzIBVP0hboLZWJZbAz
         XhcoTjPJ1Nsn21TI6BxuTXY0qoyC5V8Q3QDzJVrKVgnloaLk1aNLjPMmVx8gDedc2/b7
         mhmuVN9hPcLxCXK6xlftm5iZz6G3Ej1dcXaLGBIQpXXqtzJWiXlRFlNidtwH6SUlMEwj
         gOCg==
X-Gm-Message-State: AFuF++lTv+us2iysWwoYw62o7NeLmBpw/rnD0OKac5KLqLmCfhy6asWi
	9exCa3NaKm4B3JNzfj6qyXGZ4Nwnv+RNOOygcFcNlrd8gcd3oYk4nVeJ0Bk3H1+T
X-Gm-Gg: AYBFou2ytZ962/VCMuLUlgP5mFwW76zhrpIESq7vA9+d3vx8PryvE+tnE0q/jzE0Da5
	bDC528Xomo/1Kat+Lanqf4z6WSTKeMb2vEk8D9XyUUhy2RvjKpOHvx6tXmFDOMntr54u32qkP/W
	XObaDqDjvehT9vmWUBRyhwXykg54St+m1dBSdh4PI1y20jK+1T1SyyRPSQImKbmrKn6jMLRgC1p
	2wpK34fuc45NfP1uZAFM+p2Tpyip0SW0Hli8Sde7llykLzLZ2tXt6DTOPyP8X2WJu83nAhSiLRE
	x3v2tPzcNNthkr79K4k4SPfz+ReB/a7elPsFmAn3NqPq16xgM9sdWRf4p41t5j5J2FVebwDUAUO
	q2+/O/3mzIqe1QRJHr3dPWTcUA9xHqqkP/Ujk4+hqpR+nxtoDsTKP4Cty0vOpafd+tPCR//qtd3
	vu9DeMv3AMJxnvwO0HeP/545fBdEehNT/JNSTf9WB1TxqkoSGIaUvZ8JTjGWWG5OIIT2WkPSa9h
	elUYqgzqBqjUae3hyYjdtzuc9z+tjJH4LWl//uCEH1VfgK2Qm1fAr5JttPY9LG5zQ==
X-Received: by 2002:a05:6102:3f06:b0:79d:e3a3:4ec7 with SMTP id ada2fe7eead31-7a028d64e77mr460067137.8.1789506938806;
        Tue, 15 Sep 2026 14:15:38 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-98314dd7ceasm746860241.1.2026.09.15.14.15.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 14:15:38 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 01/11] shared/bass: add a ready callback
Date: Tue, 15 Sep 2026 17:15:18 -0400
Message-ID: <20260915211528.1223784-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260915211528.1223784-1-luiz.dentz@gmail.com>
References: <20260915211528.1223784-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

A BASS client has no way to tell when the session is usable, i.e. when
the service discovery, the reads and the subscriptions triggered by
bt_bass_attach() are complete.

Without it an upper layer may write to the Broadcast Audio Scan Control
Point before the Broadcast Receive State notifications are enabled, and
miss the state changes the write causes, as the notifications are only
sent to clients that have enabled them.

Register for the GATT client idle event and notify the registered
callbacks once it is reached, as done for BAP.

Assisted-by: opencode:claude-opus-5
---
 src/shared/bass.c | 107 ++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/bass.h |   6 +++
 2 files changed, 113 insertions(+)

diff --git a/src/shared/bass.c b/src/shared/bass.c
index 6566b89ae368..aad1edad48d8 100644
--- a/src/shared/bass.c
+++ b/src/shared/bass.c
@@ -30,6 +30,13 @@
 
 struct bt_bass_db;
 
+struct bt_bass_ready {
+	unsigned int id;
+	bt_bass_ready_func_t func;
+	bt_bass_destroy_func_t destroy;
+	void *data;
+};
+
 struct bt_bass_cb {
 	unsigned int id;
 	bt_bass_func_t attached;
@@ -67,8 +74,10 @@ struct bt_bass {
 
 	struct queue *src_cbs;
 	struct queue *cp_handlers;
+	struct queue *ready_cbs;
 
 	unsigned int disconn_id;
+	unsigned int idle_id;
 
 	void *user_data;
 };
@@ -1520,6 +1529,8 @@ static void bass_attach_att(struct bt_bass *bass, struct bt_att *att)
 							bass, NULL);
 }
 
+static void bass_idle(void *data);
+
 bool bt_bass_attach(struct bt_bass *bass, struct bt_gatt_client *client)
 {
 	bt_uuid_t uuid;
@@ -1546,6 +1557,14 @@ bool bt_bass_attach(struct bt_bass *bass, struct bt_gatt_client *client)
 
 	bass_attach_att(bass, bt_gatt_client_get_att(client));
 
+	/* Notify the upper layer once the discovery, reads and
+	 * subscriptions are complete, so it does not attempt any
+	 * operation before it is able to receive the notifications it
+	 * would generate.
+	 */
+	bass->idle_id = bt_gatt_client_idle_register(bass->client, bass_idle,
+								bass, NULL);
+
 	bt_uuid16_create(&uuid, BASS_UUID);
 	gatt_db_foreach_service(bass->rdb->db, &uuid, foreach_bass_service,
 				bass);
@@ -1584,6 +1603,11 @@ void bt_bass_detach(struct bt_bass *bass)
 
 	bt_att_unregister_disconnect(att, bass->disconn_id);
 
+	if (bass->idle_id) {
+		bt_gatt_client_idle_unregister(bass->client, bass->idle_id);
+		bass->idle_id = 0;
+	}
+
 	bt_gatt_client_unref(bass->client);
 	bass->client = NULL;
 
@@ -1605,6 +1629,87 @@ static void bass_db_free(void *data)
 	free(bdb);
 }
 
+static void bass_ready_free(void *data)
+{
+	struct bt_bass_ready *ready = data;
+
+	if (ready->destroy)
+		ready->destroy(ready->data);
+
+	free(ready);
+}
+
+static void bass_notify_ready(struct bt_bass *bass)
+{
+	const struct queue_entry *entry;
+
+	bt_bass_ref(bass);
+
+	for (entry = queue_get_entries(bass->ready_cbs); entry;
+							entry = entry->next) {
+		struct bt_bass_ready *ready = entry->data;
+
+		ready->func(bass, ready->data);
+	}
+
+	bt_bass_unref(bass);
+}
+
+static void bass_idle(void *data)
+{
+	struct bt_bass *bass = data;
+
+	bass->idle_id = 0;
+
+	bass_notify_ready(bass);
+}
+
+unsigned int bt_bass_ready_register(struct bt_bass *bass,
+				bt_bass_ready_func_t func, void *user_data,
+				bt_bass_destroy_func_t destroy)
+{
+	struct bt_bass_ready *ready;
+	static unsigned int id;
+
+	if (!bass)
+		return 0;
+
+	ready = new0(struct bt_bass_ready, 1);
+	ready->id = ++id ? id : ++id;
+	ready->func = func;
+	ready->destroy = destroy;
+	ready->data = user_data;
+
+	queue_push_tail(bass->ready_cbs, ready);
+
+	return ready->id;
+}
+
+static bool match_ready_id(const void *data, const void *match_data)
+{
+	const struct bt_bass_ready *ready = data;
+	unsigned int id = PTR_TO_UINT(match_data);
+
+	return (ready->id == id);
+}
+
+bool bt_bass_ready_unregister(struct bt_bass *bass, unsigned int id)
+{
+	struct bt_bass_ready *ready;
+
+	if (!bass)
+		return false;
+
+	ready = queue_remove_if(bass->ready_cbs, match_ready_id,
+						UINT_TO_PTR(id));
+	if (!ready)
+		return false;
+
+	bass_ready_free(ready);
+
+	return true;
+}
+
 static void bass_free(void *data)
 {
 	struct bt_bass *bass = data;
@@ -1614,6 +1719,7 @@ static void bass_free(void *data)
 	queue_destroy(bass->notify, NULL);
 	queue_destroy(bass->src_cbs, bass_src_changed_free);
 	queue_destroy(bass->cp_handlers, bass_cp_handler_free);
+	queue_destroy(bass->ready_cbs, bass_ready_free);
 
 	free(bass);
 }
@@ -1710,6 +1816,7 @@ struct bt_bass *bt_bass_new(struct gatt_db *ldb, struct gatt_db *rdb,
 	bass->notify = queue_new();
 	bass->src_cbs = queue_new();
 	bass->cp_handlers = queue_new();
+	bass->ready_cbs = queue_new();
 
 	if (!rdb)
 		goto done;
diff --git a/src/shared/bass.h b/src/shared/bass.h
index a7b7741db3b7..b617f85396c6 100644
--- a/src/shared/bass.h
+++ b/src/shared/bass.h
@@ -95,6 +95,7 @@ struct bt_bass_remove_src_params {
 
 typedef void (*bt_bass_func_t)(struct bt_bass *bass, void *user_data);
 typedef void (*bt_bass_destroy_func_t)(void *user_data);
+typedef void (*bt_bass_ready_func_t)(struct bt_bass *bass, void *user_data);
 typedef void (*bt_bass_debug_func_t)(const char *str, void *user_data);
 typedef void (*bt_bass_src_func_t)(uint8_t id, uint32_t bid, uint8_t enc,
 				   uint8_t state, uint32_t bis_sync,
@@ -116,6 +117,11 @@ bool bt_bass_set_user_data(struct bt_bass *bass, void *user_data);
 struct bt_bass *bt_bass_ref(struct bt_bass *bass);
 void bt_bass_unref(struct bt_bass *bass);
 bool bt_bass_attach(struct bt_bass *bass, struct bt_gatt_client *client);
+
+unsigned int bt_bass_ready_register(struct bt_bass *bass,
+				bt_bass_ready_func_t func, void *user_data,
+				bt_bass_destroy_func_t destroy);
+bool bt_bass_ready_unregister(struct bt_bass *bass, unsigned int id);
 bool bt_bass_set_att(struct bt_bass *bass, struct bt_att *att);
 void bt_bass_detach(struct bt_bass *bass);
 void bt_bass_add_db(struct gatt_db *db, const bdaddr_t *adapter_bdaddr);
-- 
2.55.0

