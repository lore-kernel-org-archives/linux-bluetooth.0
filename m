Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96171DF24E
	for <linux-bluetooth@vger.kernel.org>; Sun,  4 May 2025 16:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746374544; cv=pass; b=vEHK9EfqtXzQl3o86S+38+nKgoQP/Oh+8qwDUv0972NihTD+jAMUo9d7DE3krqaNlSCiYUFshMaWjoCDfIPZ3JXDPJxGhGyWLYSXnOQj1Z1zLjxJGw3UqhIbQA5CVhG20L7ADxU5gggKMdIIwZ7jr5JdR9zlc6lrrnP0eoPbnUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746374544; c=relaxed/simple;
	bh=ZLoCcrMVEb9Ry5kGpEgWY2awpGFpIU22QYyUKaMMy68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R25OWTvMOlExw/oOcrQ5pw55rAUk1unRsgKGKcuPih2643oFKsN9X9KqKaAAZsys/l2XT69ww0M4Ghm9to+aW8b8ANl9xdakr+TDWSm957itZNpTojAHhaVn5U8/alc54EetqZpG+faW73DZpn3XTUJoAMfSd6eQXbX+6tjBWGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=KJgoC1Tw; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="KJgoC1Tw"
Received: from monolith.lan (unknown [185.77.218.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4Zr8Yh1XgnzyhX;
	Sun,  4 May 2025 19:02:16 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1746374536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uLb7eojkTrm3F+ZawmAtGumIKS8R8XPMJzf6wshVLY4=;
	b=KJgoC1TwZcMsBkrVGtSkzF9J0RpUpYDyVtTwTnihFZ6WdYBPaZ4rX3sKNRWFYkz6It2J3d
	1toNsjLMD2Bd103di1G7jZDIDzkZ+kTeS3ZZzmU3xAzGnFxHfVSrWZW2Bm0cTZvw4dR+e9
	2mBf1pXx/fj/p3KWSSDTW/YJ9djXiHI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1746374536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uLb7eojkTrm3F+ZawmAtGumIKS8R8XPMJzf6wshVLY4=;
	b=feVqa48dt9dPCgnpzGuAGhUVGE1Di19p3GJmk9YQvp1dsM+13kiClps+99S9sNC+YEEwEF
	M1JGTr23XJ9Z1uZR6h5ku+czRDnS0JVtIbTjOn+CiLwyYtTFMOTnq2PwONpUS0JLTG0en9
	6osEqJBVFszKcrQIMz9ICe2lwB+Kclw=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1746374536; a=rsa-sha256; cv=none;
	b=bU6behfJdeR3VIBX6sVOWVEoYyrRgk3CCrsDy7Q+7Dyc8WWmhhykTwUylUpBUyRpTmIqwp
	Ei4fe7QuVRnFZB4zbeFmsGKQtyWEi4jcakRIx0RlRhGnYZEUXKn6LYtP6398Ar9HzGnCsJ
	h1yhgynVB6dD392LHtTSJiy+W5JwTWk=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH BlueZ v2 10/11] bap: implement Reconfigure()
Date: Sun,  4 May 2025 19:02:02 +0300
Message-ID: <582d3a955636d24d20b959d83cd766fcc4af2528.1746374514.git.pav@iki.fi>
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

Add Reconfigure() on a BAP unicast endpoint, which triggers its
reconfiguration or marks it for reconfiguration.

First, all associated streams are closed. After that, endpoints marked
for reconfiguration are reconfigured using the same flow as in the
initial configuration.
---
 profiles/audio/bap.c | 151 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 146 insertions(+), 5 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 89900602f..20d610e6f 100644
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
@@ -1204,6 +1207,132 @@ static DBusMessage *clear_configuration(DBusConnection *conn, DBusMessage *msg,
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
@@ -1379,6 +1508,10 @@ static const GDBusMethodTable ep_methods[] = {
 	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("ClearConfiguration",
 					GDBUS_ARGS({ "transport", "o" }),
 					NULL, clear_configuration) },
+	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("Reconfigure",
+					GDBUS_ARGS(
+						{ "properties", "a{sv}" }),
+					NULL, reconfigure) },
 	{ },
 };
 
@@ -1749,6 +1882,11 @@ static bool pac_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 		return true;
 	}
 
+	if (select->reconfigure && !ep->reconfigure)
+		return true;
+
+	ep->reconfigure = false;
+
 	/* TODO: Cache LRU? */
 
 	if (!ep->select) {
@@ -1761,15 +1899,18 @@ static bool pac_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
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
@@ -1858,7 +1999,7 @@ static void bap_ready(struct bt_bap *bap, void *user_data)
 	bt_bap_foreach_pac(bap, BT_BAP_SOURCE, pac_register, service);
 	bt_bap_foreach_pac(bap, BT_BAP_SINK, pac_register, service);
 
-	bap_select_all(data, NULL, NULL);
+	bap_select_all(data, false, NULL, NULL);
 }
 
 static bool match_setup_stream(const void *data, const void *user_data)
@@ -2812,7 +2953,7 @@ static void pac_added(struct bt_bap_pac *pac, void *user_data)
 	bt_bap_foreach_pac(data->bap, BT_BAP_SOURCE, pac_register, service);
 	bt_bap_foreach_pac(data->bap, BT_BAP_SINK, pac_register, service);
 
-	bap_select_all(data, NULL, NULL);
+	bap_select_all(data, false, NULL, NULL);
 }
 
 static void pac_added_broadcast(struct bt_bap_pac *pac, void *user_data)
-- 
2.49.0

