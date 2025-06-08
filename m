Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB39255F4C
	for <linux-bluetooth@vger.kernel.org>; Sun,  8 Jun 2025 21:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749418384; cv=pass; b=QI6VaXFEnMPg3xNFz2U3YOxFKCl9TjZodHLFxVmeZxZnRfIgoIpCIpIcZ1P4xMVElbtw+GbmYKtTMWv3KvLbZFmqOPsePjFgMTgWc2WfZyY6sVk/WGgNMDYrM4+NEvnd+gQEqS6ukCXK1q1mAUxcOl2NAkbZrTECGfZFkkJcw9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749418384; c=relaxed/simple;
	bh=wi/JpJbBea3L4nU4q49WIOBXuCu3LiHSBeMNq55q/5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZOaRhdt1tqY+cx2tQPBsDsIYBUnTYB2g63bSnWylcdxhsplrK6rj5YnGdDEwC3LOguzLEx3W2UUEJGXr4tK3okBlbY89aeFzKByBPl3f50QjUiAAu+p9lC+E88+6B+GN3Vr7+htBt0c13MpZCAcZREFRTsiBiM6cTXy0+7jg340=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=II4VFuot; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="II4VFuot"
Received: from monolith.lan (unknown [185.77.218.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4bFpF40dltz49Q4L;
	Mon,  9 Jun 2025 00:32:56 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1749418376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JnNES2FxKHjbskhYz+3NO/E/h4hqTG1jni8WGZXPTDA=;
	b=II4VFuotCAJGdGiCAE6pHSoQ4MzuGSQL7dBtKQguqchMFmEEHA8LIvoy1kOksRX/n9z62d
	oAMPGj2gO0CD5Si8PkMY3578BO+SEEc7EN/BQflqL7NAuC7d0TksAplLDQL1ocmrBL4nSj
	ra3h13rfcWB7JWvQT8XoQx64SpZhzTx9lLpWc3PW0ewy0IaEyEsFO5ni7HAeFR5vcqrIzl
	YfsScnNu/9VABNp23GN1btEvem+0lxwAB0KoPcbMNKq3vDT3Q+J7T+AZhaTrGR2rxDu3qB
	ExJfhmhjfi9XhRrIr0//nWUv1/iVn54hNq77jxNl61bYKwCbGSjdoGFCF0NApg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1749418376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JnNES2FxKHjbskhYz+3NO/E/h4hqTG1jni8WGZXPTDA=;
	b=ZM4QbK2lxuToAnVF47gsfJ4ra4fcH/3B5eGyWm1bD0fNyG13BOxZ6YrpsZdyD0uo3j/VMr
	vbkFRZQsa0EJ2dhjUdWmMOWN3Xe6WvIE2tbOqM67Or1XCyO3cCjz0dfiF2SQtBIJTAWR3c
	H4k3cT+hsRx7+NuNPboEY1QB4hv3EzP16O/k+pmBS+LO1iQBHdFEmVJjB6bgyDVJbFT+iy
	MLFM9JjXs7ssfdbCd3X8YyMV3dE69Ep35mnyfteaxtrOylrhPodBAutbK0CwAPXE/0GcxQ
	/XlyegEDPtW2EgV9eux5rvyeog28yT94FRfKw3v28yC1l4PDiGBm+9SLi2irrg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1749418376; a=rsa-sha256;
	cv=none;
	b=cw5Z24nuwp+gfZgl6QfUQFefxQt1X9W1wI1ftnb3KsanVk4Chw2QW2aJp9EC5sOzlACYRY
	bF7xTqPfjSfApH1Rk0TWIcq1XTWhPE5JRU2Tcj4hHr7Q1vdRvBUdaQ2V0NI58pvqPn591R
	au26XGqJ37q/FSIxgC8B1v3Imc6OUc1+2L2nlmWe0BiqjN/ammzk9dyxqIgFvkcbZ4zqzE
	frQWAMZFoOP3EXqFSTBGL+BPbG89rjN2Dye3HVb55GDtvM4datQq9+CjoFrW4G8GI/F/ss
	H48djrdE0rTB7RcVC6C/GI3lHRS5bnffpzKOiIUkXANA3mD506XewDqn9pslBw==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v3 10/10] bap: delay QoS & IO creation if CIG is busy or setups configuring
Date: Mon,  9 Jun 2025 00:32:22 +0300
Message-ID: <43bee87674a14733f30f6a0a3433786d6937570c.1749418319.git.pav@iki.fi>
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

Unicast Client IO creation / activation should be done synchronously for
whole adapter, as active CIG has to be removed before it can be
reconfigured (Core v6.0 Sec 4.5.14.3).  Some adapters support only one
active CIG.

Move related logic to bap_update_cig*() which does QoS and IO creation
as needed by current state.

If CIG is active or setups are being configured or closed, delay
transitions to QoS and IO recreation until that completes.  Also delay
activating CIG (= enabling CIS) until setups have finished readying or
closing.

Operations are delayed within the same CIG, with the exception that
streams with unassigned CIG delay every CIG. This is because such
streams are likely meant to go to some existing CIG, so we must wait
them to be configurable before asking kernel to assign IDs.

Fixes race conditions:

* setup starts readying while CIG is active
* CIG is activated while a setup is readying
* new stream creates IO before old stream IO is recreated

These result to kernel assigning new streams to a different CIG
(problematic on controllers that can do only one) or CIS ID conflicts.
---
 profiles/audio/bap.c | 394 +++++++++++++++++++++++++++++++------------
 1 file changed, 285 insertions(+), 109 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 2d8b7aa91..ffed0ae19 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -81,8 +81,10 @@ struct bap_setup {
 							DBusMessageIter *iter);
 	GIOChannel *io;
 	unsigned int io_id;
-	bool recreate;
-	bool cig_active;
+	bool want_qos;
+	bool want_io;
+	bool want_cis;
+	bool cis_active;
 	uint8_t sid;
 	bool config_pending;
 	bool readying;
@@ -136,6 +138,7 @@ struct bap_data {
 	struct queue *server_streams;
 	GIOChannel *listen_io;
 	unsigned int io_id;
+	unsigned int cig_update_id;
 	void *user_data;
 };
 
@@ -145,6 +148,9 @@ static int setup_config(struct bap_setup *setup, bap_setup_ready_func_t cb,
 							void *user_data);
 static int bap_select_all(struct bap_data *data, bool reconfigure,
 					bap_select_done_t cb, void *user_data);
+static void setup_create_io(struct bap_data *data, struct bap_setup *setup,
+				struct bt_bap_stream *stream, int defer);
+static void bap_update_cigs(struct bap_data *data);
 
 static bool bap_data_set_user_data(struct bap_data *data, void *user_data)
 {
@@ -183,6 +189,9 @@ static void bap_data_free(struct bap_data *data)
 	if (data->io_id)
 		g_source_remove(data->io_id);
 
+	if (data->cig_update_id)
+		g_source_remove(data->cig_update_id);
+
 	if (data->service && btd_service_get_user_data(data->service) == data)
 		btd_service_set_user_data(data->service, NULL);
 
@@ -740,6 +749,8 @@ static void setup_ready(struct bap_setup *setup, int code,
 		setup->ready_cb = NULL;
 		setup->ready_cb_data = NULL;
 	}
+
+	bap_update_cigs(setup->ep->data);
 }
 
 static void qos_cb(struct bt_bap_stream *stream, uint8_t code, uint8_t reason,
@@ -753,10 +764,9 @@ static void qos_cb(struct bt_bap_stream *stream, uint8_t code, uint8_t reason,
 
 	if (code)
 		setup_ready(setup, code, reason);
-}
 
-static void setup_create_io(struct bap_data *data, struct bap_setup *setup,
-				struct bt_bap_stream *stream, int defer);
+	bap_update_cigs(setup->ep->data);
+}
 
 static int setup_qos(struct bap_setup *setup)
 {
@@ -802,19 +812,15 @@ static void config_cb(struct bt_bap_stream *stream,
 					void *user_data)
 {
 	struct bap_setup *setup = user_data;
-	int err = 0;
 
 	DBG("stream %p code 0x%02x reason 0x%02x", stream, code, reason);
 
 	setup->id = 0;
 
 	if (code)
-		err = code;
-	else if (!setup->config_pending)
-		err = setup_qos(setup);
+		setup_ready(setup, code, reason);
 
-	if (err)
-		setup_ready(setup, err, reason);
+	bap_update_cigs(setup->ep->data);
 }
 
 static void setup_io_close(void *data, void *user_data)
@@ -838,7 +844,7 @@ static void setup_io_close(void *data, void *user_data)
 
 	g_io_channel_unref(setup->io);
 	setup->io = NULL;
-	setup->cig_active = false;
+	setup->cis_active = false;
 
 	bt_bap_stream_io_connecting(setup->stream, -1);
 }
@@ -987,6 +993,8 @@ static void setup_free(void *data)
 
 	DBG("%p", setup);
 
+	setup->closing = true;
+
 	setup_ready(setup, -ECANCELED, 0);
 
 	if (setup->closing && setup->close_cb)
@@ -1013,6 +1021,8 @@ static void setup_free(void *data)
 
 	release_stream(setup->stream);
 
+	bap_update_cigs(setup->ep->data);
+
 	free(setup);
 }
 
@@ -2219,7 +2229,7 @@ static void setup_accept_io(struct bap_setup *setup,
 		}
 	}
 
-	setup->cig_active = true;
+	setup->cis_active = true;
 
 	return;
 
@@ -2227,129 +2237,299 @@ fail:
 	close(fd);
 }
 
-struct cig_busy_data {
-	struct btd_adapter *adapter;
+struct find_cig_data {
+	const struct btd_adapter *adapter;
+	bool (*func)(const void *data, const void *match_data);
+	struct bap_setup *found;
+	struct queue *cigs;
 	uint8_t cig;
 };
 
-static bool match_cig_active(const void *data, const void *match_data)
+static bool find_cig_readying_setup(const void *data, const void *match_data)
+{
+	struct bap_setup *setup = (void *)data;
+	struct find_cig_data *info = (void *)match_data;
+	struct bt_bap_stream *stream = setup->stream;
+	struct bt_bap_qos *qos = bt_bap_stream_get_qos(stream);
+
+	/* Streams with automatically assigned CIG are considered to potentially
+	 * belong to any CIG.
+	 */
+	if (qos && qos->ucast.cig_id != info->cig &&
+				info->cig != BT_ISO_QOS_CIG_UNSET &&
+				qos->ucast.cig_id != BT_ISO_QOS_CIG_UNSET)
+		return false;
+
+	return setup->readying || setup->closing ||
+		setup->config_pending || setup->id;
+}
+
+static bool find_cig_busy_setup(const void *data, const void *match_data)
 {
 	const struct bap_setup *setup = data;
-	const struct cig_busy_data *info = match_data;
+	struct find_cig_data *info = (void *)match_data;
+	struct bt_bap_stream *stream = setup->stream;
+	struct bt_bap_qos *qos = bt_bap_stream_get_qos(stream);
 
-	return (setup->qos.ucast.cig_id == info->cig) && setup->cig_active;
+	if (qos && qos->ucast.cig_id != info->cig &&
+				info->cig != BT_ISO_QOS_CIG_UNSET &&
+				qos->ucast.cig_id != BT_ISO_QOS_CIG_UNSET)
+		return false;
+
+	return setup->cis_active || setup->closing ||
+		setup->config_pending || setup->id;
 }
 
-static bool cig_busy_ep(const void *data, const void *match_data)
+static bool find_cig_enumerate_setup(const void *data, const void *match_data)
+{
+	const struct bap_setup *setup = data;
+	struct find_cig_data *info = (void *)match_data;
+	struct bt_bap_stream *stream = setup->stream;
+	struct bt_bap_qos *qos = bt_bap_stream_get_qos(stream);
+
+	if (qos && info->cigs) {
+		queue_remove(info->cigs, UINT_TO_PTR(qos->ucast.cig_id));
+		queue_push_tail(info->cigs, UINT_TO_PTR(qos->ucast.cig_id));
+	}
+
+	return false;
+}
+
+static bool find_cig_ep(const void *data, const void *match_data)
 {
 	const struct bap_ep *ep = data;
-	const struct cig_busy_data *info = match_data;
+	struct find_cig_data *info = (void *)match_data;
 
-	return queue_find(ep->setups, match_cig_active, info);
+	info->found = queue_find(ep->setups, info->func, match_data);
+	return info->found;
 }
 
-static bool cig_busy_session(const void *data, const void *match_data)
+static bool find_cig_session(const void *data, const void *match_data)
 {
 	const struct bap_data *session = data;
-	const struct cig_busy_data *info = match_data;
+	const struct find_cig_data *info = match_data;
 
 	if (device_get_adapter(session->device) != info->adapter)
 		return false;
 
-	return queue_find(session->snks, cig_busy_ep, match_data) ||
-			queue_find(session->srcs, cig_busy_ep, match_data);
+	return queue_find(session->snks, find_cig_ep, match_data) ||
+			queue_find(session->srcs, find_cig_ep, match_data);
 }
 
-static bool is_cig_busy(struct bap_data *data, uint8_t cig)
+static struct bap_setup *find_cig_busy(struct bap_data *data, uint8_t cig)
 {
-	struct cig_busy_data info;
+	struct find_cig_data info = {
+		.adapter = device_get_adapter(data->device),
+		.cig = cig,
+		.func = find_cig_busy_setup,
+	};
 
-	if (cig == BT_ISO_QOS_CIG_UNSET)
-		return false;
-
-	info.adapter = device_get_adapter(data->device);
-	info.cig = cig;
-
-	return queue_find(sessions, cig_busy_session, &info);
+	queue_find(sessions, find_cig_session, &info);
+	return info.found;
 }
 
-static gboolean setup_io_recreate(void *user_data)
+static struct bap_setup *find_cig_readying(struct bap_data *data, uint8_t cig)
 {
-	struct bap_setup *setup = user_data;
+	struct find_cig_data info = {
+		.adapter = device_get_adapter(data->device),
+		.cig = cig,
+		.func = find_cig_readying_setup,
+	};
+
+	queue_find(sessions, find_cig_session, &info);
+	return info.found;
+}
+
+static struct queue *find_cig_enumerate(struct bap_data *data)
+{
+	struct find_cig_data info = {
+		.adapter = device_get_adapter(data->device),
+		.func = find_cig_enumerate_setup,
+		.cigs = queue_new(),
+	};
+
+	queue_find(sessions, find_cig_session, &info);
+	return info.cigs;
+}
+
+struct update_cig_data {
+	struct btd_adapter *adapter;
+	void (*func)(void *data, void *match_data);
+	uint8_t cig;
+	unsigned int count;
+};
+
+static void update_cig_setup_enable(void *data, void *match_data)
+{
+	struct bap_setup *setup = data;
+	struct update_cig_data *info = match_data;
+	struct bt_bap_stream *stream = setup->stream;
+	struct bt_bap_qos *qos = bt_bap_stream_get_qos(stream);
+
+	if (qos && qos->ucast.cig_id != info->cig)
+		return;
+	if (!stream || !setup->io || setup->closing || setup->cis_active)
+		return;
+	if (!setup->want_cis)
+		return;
+	if (bt_bap_stream_get_state(stream) != BT_BAP_STREAM_STATE_ENABLING)
+		return;
 
 	DBG("%p", setup);
 
-	setup->io_id = 0;
+	setup->want_cis = false;
+	setup_create_io(setup->ep->data, setup, setup->stream, false);
+	info->count++;
+}
 
+static void update_cig_setup_io(void *data, void *match_data)
+{
+	struct bap_setup *setup = data;
+	struct update_cig_data *info = match_data;
+	struct bt_bap_stream *stream = setup->stream;
+	struct bt_bap_qos *qos = bt_bap_stream_get_qos(stream);
+
+	if (qos && qos->ucast.cig_id != info->cig)
+		return;
+	if (!setup->want_io || !stream || setup->io || setup->closing)
+		return;
+	if (bt_bap_stream_get_state(stream) != BT_BAP_STREAM_STATE_QOS)
+		return;
+
+	DBG("%p", setup);
+
+	setup->want_io = false;
 	setup_create_io(setup->ep->data, setup, setup->stream, true);
+	info->count++;
+}
+
+static void update_cig_setup_qos(void *data, void *match_data)
+{
+	struct bap_setup *setup = data;
+	struct update_cig_data *info = match_data;
+	struct bt_bap_stream *stream = setup->stream;
+	int err;
+	struct bt_bap_qos *qos = bt_bap_stream_get_qos(stream);
+
+	if (qos && qos->ucast.cig_id != info->cig)
+		return;
+	if (!setup->want_qos || !stream || setup->closing)
+		return;
+	if (bt_bap_stream_get_state(stream) != BT_BAP_STREAM_STATE_CONFIG)
+		return;
+
+	DBG("%p", setup);
+
+	setup->want_qos = false;
+	err = setup_qos(setup);
+	if (err)
+		setup_ready(setup, err, 0);
+	else
+		info->count++;
+}
+
+static void update_cig_check_ep(void *data, void *match_data)
+{
+	struct bap_ep *ep = data;
+	struct update_cig_data *info = match_data;
+
+	queue_foreach(ep->setups, info->func, match_data);
+}
+
+static void update_cig_check_session(void *data, void *match_data)
+{
+	struct bap_data *session = data;
+	struct update_cig_data *info = match_data;
+
+	if (device_get_adapter(session->device) != info->adapter)
+		return;
+
+	queue_foreach(session->snks, update_cig_check_ep, match_data);
+	queue_foreach(session->srcs, update_cig_check_ep, match_data);
+}
+
+static void bap_update_cig(void *item, void *user_data)
+{
+	unsigned int cig = PTR_TO_UINT(item);
+	struct bap_data *data = user_data;
+	struct update_cig_data info;
+	struct bap_setup *setup;
+
+	info.adapter = device_get_adapter(data->device);
+	info.count = 0;
+	info.cig = cig;
+
+	DBG("adapter %p CIG 0x%x", info.adapter, info.cig);
+
+	/* Do stream QoS & IO re-creation only when CIG is no longer
+	 * busy and all pending Config/QoS requests have completed.
+	 */
+	setup = find_cig_busy(data, cig);
+	if (!setup) {
+		/* Recreate IO before QoS of new streams, so that we reserve
+		 * their CIS IDs in kernel before allocating new streams.
+		 */
+		info.func = update_cig_setup_io;
+		queue_foreach(sessions, update_cig_check_session, &info);
+
+		info.func = update_cig_setup_qos;
+		queue_foreach(sessions, update_cig_check_session, &info);
+	} else {
+		DBG("setup %p stream %p busy", setup, setup->stream);
+	}
+
+	/* Do CIS creation only after all setups have finished readying.
+	 */
+	setup = find_cig_readying(data, cig);
+	if (!setup) {
+		info.func = update_cig_setup_enable;
+		queue_foreach(sessions, update_cig_check_session, &info);
+	} else {
+		DBG("setup %p stream %p readying", setup, setup->stream);
+	}
+}
+
+static gboolean bap_update_cigs_cb(void *user_data)
+{
+	struct bap_data *data = user_data;
+	struct queue *cigs;
+	bool unset;
+
+	data->cig_update_id = 0;
+
+	cigs = find_cig_enumerate(data);
+	unset = queue_remove(cigs, UINT_TO_PTR(BT_ISO_QOS_CIG_UNSET));
+	queue_foreach(cigs, bap_update_cig, data);
+	queue_destroy(cigs, NULL);
+
+	/* Handle streams with unset CIG last, so that kernel CIG allocation
+	 * knows which IDs are reserved.
+	 */
+	if (unset)
+		bap_update_cig(UINT_TO_PTR(BT_ISO_QOS_CIG_UNSET), data);
 
 	return FALSE;
 }
 
-static void setup_recreate(void *data, void *match_data)
+static void bap_update_cigs(struct bap_data *data)
 {
-	struct bap_setup *setup = data;
-	struct cig_busy_data *info = match_data;
-
-	if (setup->qos.ucast.cig_id != info->cig || !setup->recreate ||
-						setup->io_id)
+	if (data->cig_update_id)
 		return;
 
-	setup->recreate = false;
-	setup->io_id = g_idle_add(setup_io_recreate, setup);
-}
-
-static void recreate_cig_ep(void *data, void *match_data)
-{
-	struct bap_ep *ep = data;
-
-	queue_foreach(ep->setups, setup_recreate, match_data);
-}
-
-static void recreate_cig_session(void *data, void *match_data)
-{
-	struct bap_data *session = data;
-	struct cig_busy_data *info = match_data;
-
-	if (device_get_adapter(session->device) != info->adapter)
-		return;
-
-	queue_foreach(session->snks, recreate_cig_ep, match_data);
-	queue_foreach(session->srcs, recreate_cig_ep, match_data);
-}
-
-static void recreate_cig(struct bap_setup *setup)
-{
-	struct bap_data *data = setup->ep->data;
-	struct cig_busy_data info;
-
-	info.adapter = device_get_adapter(data->device);
-	info.cig = setup->qos.ucast.cig_id;
-
-	DBG("adapter %p setup %p recreate CIG %d", info.adapter, setup,
-							info.cig);
-
-	if (setup->qos.ucast.cig_id == BT_ISO_QOS_CIG_UNSET) {
-		recreate_cig_ep(setup->ep, &info);
-		return;
-	}
-
-	queue_foreach(sessions, recreate_cig_session, &info);
+	data->cig_update_id = g_idle_add(bap_update_cigs_cb, data);
 }
 
 static void setup_io_disconnected(int cond, void *user_data)
 {
 	struct bap_setup *setup = user_data;
 
-	DBG("%p recreate %s", setup, setup->recreate ? "true" : "false");
-
 	setup->io_id = 0;
 
+	DBG("%p", setup);
+
 	setup_io_close(setup, NULL);
 
-	/* Check if connecting recreate IO */
-	if (!is_cig_busy(setup->ep->data, setup->qos.ucast.cig_id))
-		recreate_cig(setup);
+	bap_update_cigs(setup->ep->data);
 }
 
 static void bap_connect_bcast_io_cb(GIOChannel *chan, GError *err,
@@ -2393,13 +2573,9 @@ static void setup_connect_io(struct bap_data *data, struct bap_setup *setup,
 		return;
 	}
 
-	/* If IO channel still up or CIG is busy, wait for it to be
-	 * disconnected and then recreate.
-	 */
-	if (setup->io || is_cig_busy(data, setup->qos.ucast.cig_id)) {
-		DBG("setup %p stream %p defer %s wait recreate", setup, stream,
-						defer ? "true" : "false");
-		setup->recreate = true;
+	/* If IO channel still up */
+	if (setup->io) {
+		DBG("setup %p stream %p io already up", setup, stream);
 		return;
 	}
 
@@ -2433,7 +2609,7 @@ static void setup_connect_io(struct bap_data *data, struct bap_setup *setup,
 	setup->io_id = io_glib_add_err_watch(io, setup_io_disconnected, setup);
 
 	setup->io = io;
-	setup->cig_active = !defer;
+	setup->cis_active = !defer;
 
 	bt_bap_stream_io_connecting(stream, g_io_channel_unix_get_fd(io));
 }
@@ -2664,22 +2840,25 @@ static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
 	case BT_BAP_STREAM_STATE_CONFIG:
 		if (setup) {
 			setup->config_pending = false;
-			if (!setup->id) {
-				int err = setup_qos(setup);
-
-				if (err)
-					setup_ready(setup, err, 0);
-			}
+			setup->want_qos = true;
+			bap_update_cigs(setup->ep->data);
 		}
 		break;
 	case BT_BAP_STREAM_STATE_QOS:
-		setup_create_io(data, setup, stream, true);
-		if (setup)
+		if (setup) {
+			setup->want_qos = false;
+			setup->want_io = true;
 			setup_ready(setup, 0, 0);
+			bap_update_cigs(setup->ep->data);
+		} else {
+			setup_create_io(data, setup, stream, true);
+		}
 		break;
 	case BT_BAP_STREAM_STATE_ENABLING:
-		if (setup)
-			setup_create_io(data, setup, stream, false);
+		if (setup) {
+			setup->want_cis = true;
+			bap_update_cigs(setup->ep->data);
+		}
 		break;
 	case BT_BAP_STREAM_STATE_STREAMING:
 		break;
@@ -3146,7 +3325,6 @@ static void bap_connecting(struct bt_bap_stream *stream, bool state, int fd,
 	if (!setup)
 		return;
 
-	setup->recreate = false;
 	qos = &setup->qos;
 
 	if (!setup->io) {
@@ -3191,8 +3369,6 @@ static void bap_connecting_bcast(struct bt_bap_stream *stream, bool state,
 	if (!setup)
 		return;
 
-	setup->recreate = false;
-
 	if (!setup->io) {
 		io = g_io_channel_unix_new(fd);
 		setup->io_id = io_glib_add_err_watch(io, setup_io_disconnected,
-- 
2.49.0

