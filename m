Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED87F254AF2
	for <linux-bluetooth@vger.kernel.org>; Sun,  8 Jun 2025 21:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749418373; cv=pass; b=ozPQ1Pr8aA168/t+ZzMKw3gRDaweVPc9SUB0MR5g/QmQ6101KsqTAslGAZ7ttBz6UBJUA3YeRCV8JheqMUYkZBIBUvnUb8ufRYNIHv6UP1gNs9x41PWv9A4vo2182EKWNfa3qoDNucAdrIDuKO/temmRQtKOnBIo5avDbWkEDXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749418373; c=relaxed/simple;
	bh=HTM9M2q3CJGUyGC1bEZ5nSgybpP2oPEcPoqAqOGValk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tzyABMtOKd365TAG/mE8ZtpTrv7VFJus65m5DxX0w00B36gBIqdimT9++c55CGZosFIzFml32oIk+QqTO+dYyvPIiZekiHJqlaCaSzzJEVATl8kGooOnupycjdN37IyoXkjReUHI0HHmgiecdD3XBi4F67Jvz1lTC5Lp0zY7LbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=SrB/B+cS; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="SrB/B+cS"
Received: from monolith.lan (unknown [185.77.218.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4bFpDx6ypSz49Q4w;
	Mon,  9 Jun 2025 00:32:49 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1749418370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fl7YqeCE9fz2VmTYEZ94uccGrNXQAYOlyZkZhJEKq5w=;
	b=SrB/B+cSFbvdJXlpqWN4TMAH2QdW7pmJXVcGHHoHP8SskphE/G8z74SRGFO8OmRN9N5uaw
	CaYmqXSS1uUqtovsZ+uGlbzbNlUtyQGn17EFzhrhWJxy3vftyMFfUr+2fOLMexUbz5LBqZ
	0Aa/LKEC+LgSSW6P24P/ml/vD8RpyHJ5cLPr9JJZyBBf6hgJnSdHYk9auZhWFivY/pNEha
	ugimVBpR3m+omJUW12Nb12ruBR4S+gEe/hYvEFP7R25uEk/wlXo+H2dJxH3/zLKz9ApWYt
	GLfsnGXn2/kQV8HhVvITxkzruEzPCx+OwmGYbolqOs74K+pAyuXhB10F0+dBUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1749418370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fl7YqeCE9fz2VmTYEZ94uccGrNXQAYOlyZkZhJEKq5w=;
	b=Jd91d3wtBPoN0ldqzreMiRJzv7bdWcxovTi902IaF2FKwLVM3t1lfpnfD6Sxly8/Gm2yD/
	d7iMyRn/h8ICjvbSGtWcwm6/dhTcppTMT9J2IIIng9WjbXR3tk1rvWvid4pqujXM/muz7j
	TQwHjRVFLCcgUbJtjzB/e+D/rl2BomY02r+pB+TIYXKMqP2/x0/SoE6mtTvV/fpuJD29r4
	mPhLK4StkCAPdwWknCcGChV1LqXsjeTBkFMpbOICB+Z4NNz7H9OhXsN+WO81ADG7s4lhcN
	ZLaLCcTwyprHi2tIJ56LWc2JSGNH7zFQuaT/sJP5acy1XG1LN+/Mm8w8LsYlxQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1749418370; a=rsa-sha256;
	cv=none;
	b=vGHrzltn10CMZo35kdUh829EJGzHv1/ceBsa9HRedGPMEfTuMAHC9qcAq6yDcS3iTsVx6A
	vRBhVSWZzixuM4keTxN/kLqhXZuG7wyKzmY0iBBqb+4jOwXTi+caxoHIqA7OKriqJzn0B7
	IvuSq2swzu4L8D0w1HEqF1Dtp6v4Rau5ZiWWiMgxwjutbyKvS0HPFnTRlBYZ7zZyE7Zn8H
	JXozeOBJfa3KfTmPxubF3Ttij8F8sTBioq0KAiZ9KA0/dMn+GkjAIaWWUyC8u5vrpwCYrH
	etZv6bAla9EmefBy6P4HHRkqEZtwmBZXI/YbQ2gzgLBwiseMaxcUgfgGzQ+Vig==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v3 08/10] bap: implement Reconfigure()
Date: Mon,  9 Jun 2025 00:32:20 +0300
Message-ID: <ce95c29f2034992414dbb1a84cdfc2558df171b0.1749418319.git.pav@iki.fi>
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

Add Reconfigure() on a BAP unicast endpoint, which triggers its
reconfiguration or marks it for reconfiguration.

First, all associated streams are closed. After that, endpoints marked
for reconfiguration are reconfigured using the same flow as in the
initial configuration.
---
 profiles/audio/bap.c | 151 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 146 insertions(+), 5 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index c08a0a645..2d8b7aa91 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -101,6 +101,7 @@ struct bap_setup {
 struct bap_select {
 	struct bap_data *data;
 	struct queue *eps;
+	bool reconfigure;
 	int remaining;
 	int err;
 	bap_select_done_t done_cb;
@@ -117,6 +118,7 @@ struct bap_ep {
 	uint16_t context;
 	struct queue *setups;
 	struct bap_select *select;
+	bool reconfigure;
 };
 
 struct bap_data {
@@ -141,7 +143,8 @@ static struct queue *sessions;
 
 static int setup_config(struct bap_setup *setup, bap_setup_ready_func_t cb,
 							void *user_data);
-
+static int bap_select_all(struct bap_data *data, bool reconfigure,
+					bap_select_done_t cb, void *user_data);
 
 static bool bap_data_set_user_data(struct bap_data *data, void *user_data)
 {
@@ -1222,6 +1225,132 @@ static DBusMessage *clear_configuration(DBusConnection *conn, DBusMessage *msg,
 	return NULL;
 }
 
+static int reconfigure_parse(DBusMessageIter *props, bool *defer)
+{
+	const char *key;
+
+	if (dbus_message_iter_get_arg_type(props) != DBUS_TYPE_DICT_ENTRY)
+		return -EINVAL;
+
+	while (dbus_message_iter_get_arg_type(props) == DBUS_TYPE_DICT_ENTRY) {
+		DBusMessageIter value, entry;
+		int var;
+
+		dbus_message_iter_recurse(props, &entry);
+		dbus_message_iter_get_basic(&entry, &key);
+
+		dbus_message_iter_next(&entry);
+		dbus_message_iter_recurse(&entry, &value);
+
+		var = dbus_message_iter_get_arg_type(&value);
+
+		if (!strcasecmp(key, "Defer")) {
+			dbus_bool_t flag;
+
+			if (var != DBUS_TYPE_BOOLEAN)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value, &flag);
+			*defer = flag;
+		}
+
+		dbus_message_iter_next(props);
+	}
+
+	return 0;
+
+fail:
+	DBG("Failed parsing %s", key);
+
+	return -EINVAL;
+}
+
+struct reconfigure_data {
+	int remaining;
+	struct bap_data *data;
+	DBusMessage *msg;
+};
+
+static void reconfigure_select_cb(int err, void *user_data)
+{
+	struct reconfigure_data *data = user_data;
+	DBusMessage *reply;
+
+	if (!err)
+		reply = dbus_message_new_method_return(data->msg);
+	else
+		reply = btd_error_failed(data->msg, "Failed to configure");
+
+	g_dbus_send_message(btd_get_dbus_connection(), reply);
+	dbus_message_unref(data->msg);
+	free(data);
+}
+
+static void reconfigure_close_cb(int count, void *user_data)
+{
+	struct reconfigure_data *data = user_data;
+
+	data->remaining--;
+
+	DBG("remain %d", data->remaining);
+
+	if (data->remaining)
+		return;
+
+	bap_select_all(data->data, true, reconfigure_select_cb, data);
+}
+
+static void ep_close_if_reconfigure(void *obj, void *user_data)
+{
+	struct bap_ep *ep = obj;
+	struct reconfigure_data *data = user_data;
+
+	if (ep->reconfigure) {
+		data->remaining++;
+		ep_close(ep, NULL, reconfigure_close_cb, data);
+	}
+}
+
+static DBusMessage *reconfigure(DBusConnection *conn, DBusMessage *msg,
+								void *user_data)
+{
+	struct bap_ep *ep = user_data;
+	struct bap_data *data = ep->data;
+	struct reconfigure_data *cbdata;
+	bool defer = false;
+	DBusMessageIter args, props;
+
+	switch (bt_bap_pac_get_type(ep->lpac)) {
+	case BT_BAP_SOURCE:
+	case BT_BAP_SINK:
+		break;
+	default:
+		return btd_error_invalid_args(msg);
+	}
+
+	dbus_message_iter_init(msg, &args);
+	dbus_message_iter_recurse(&args, &props);
+	if (reconfigure_parse(&props, &defer))
+		return btd_error_invalid_args(msg);
+
+	DBG("%s defer %d", ep->path, (int)defer);
+
+	ep->reconfigure = true;
+	if (defer)
+		return dbus_message_new_method_return(msg);
+
+	cbdata = new0(struct reconfigure_data, 1);
+	cbdata->data = ep->data;
+	cbdata->msg = dbus_message_ref(msg);
+	cbdata->remaining = 1;
+
+	queue_foreach(data->snks, ep_close_if_reconfigure, cbdata);
+	queue_foreach(data->srcs, ep_close_if_reconfigure, cbdata);
+
+	reconfigure_close_cb(0, cbdata);
+	return NULL;
+}
+
 static bool stream_io_unset(const void *data, const void *user_data)
 {
 	struct bt_bap_stream *stream = (struct bt_bap_stream *)data;
@@ -1398,6 +1527,10 @@ static const GDBusMethodTable ep_methods[] = {
 	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("ClearConfiguration",
 					GDBUS_ARGS({ "transport", "o" }),
 					NULL, clear_configuration) },
+	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("Reconfigure",
+					GDBUS_ARGS(
+						{ "properties", "a{sv}" }),
+					NULL, reconfigure) },
 	{ },
 };
 
@@ -1771,6 +1904,11 @@ static bool pac_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 		return true;
 	}
 
+	if (select->reconfigure && !ep->reconfigure)
+		return true;
+
+	ep->reconfigure = false;
+
 	/* TODO: Cache LRU? */
 
 	if (!ep->select) {
@@ -1783,15 +1921,18 @@ static bool pac_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 	return true;
 }
 
-static int bap_select_all(struct bap_data *data, bap_select_done_t cb,
-								void *user_data)
+static int bap_select_all(struct bap_data *data, bool reconfigure,
+					bap_select_done_t cb, void *user_data)
 {
 	struct bap_select *select;
 
 	if (!btd_service_is_initiator(data->service))
 		return -EINVAL;
 
+	DBG("data %p reconfig %d", data, (int)reconfigure);
+
 	select = new0(struct bap_select, 1);
+	select->reconfigure = reconfigure;
 	select->remaining = 1;
 	select->data = data;
 	select->eps = queue_new();
@@ -1880,7 +2021,7 @@ static void bap_ready(struct bt_bap *bap, void *user_data)
 	bt_bap_foreach_pac(bap, BT_BAP_SOURCE, pac_register, service);
 	bt_bap_foreach_pac(bap, BT_BAP_SINK, pac_register, service);
 
-	bap_select_all(data, NULL, NULL);
+	bap_select_all(data, false, NULL, NULL);
 }
 
 static bool match_setup_stream(const void *data, const void *user_data)
@@ -2837,7 +2978,7 @@ static void pac_added(struct bt_bap_pac *pac, void *user_data)
 	bt_bap_foreach_pac(data->bap, BT_BAP_SOURCE, pac_register, service);
 	bt_bap_foreach_pac(data->bap, BT_BAP_SINK, pac_register, service);
 
-	bap_select_all(data, NULL, NULL);
+	bap_select_all(data, false, NULL, NULL);
 }
 
 static void pac_added_broadcast(struct bt_bap_pac *pac, void *user_data)
-- 
2.49.0

