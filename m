Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378232F9D85
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Oct 2025 20:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761338469; cv=none; b=bSe/QoxPQ2t3Hr6DMNZ/CCqA6TTrTkFFgrYpgA6QqcOFLPuQNbq12sP3p4+1guZxczkvIUSnKdHddbawgeZTSuSiG0uGoIMEF+2pjPnxPmOGzb2VQfh4ESjIbotzeBjUiMutJQDoj0jb7lcYlQaM5BKFY/WgGFHah016v+Kagkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761338469; c=relaxed/simple;
	bh=URuHOiQU7QQ46M2TkSBzw51gZ9a0Tmims7gbT3aDb1A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n21QjuNkeFTljJCjTjjbQX8hvjjL6pF8L98IJmD0TswgTnV2jAx8LWXve2Kd13yM3UZUC6yzcQVZViIZ0KP8cyb5wzQze5THxAb5t6oSE280TSHTWZ2X8gR8Oz1P0/EVQi29rGkIWiZlZEBTyLNBOw73v35hwC3ZxpUFG69wke8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aoi3P2/x; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aoi3P2/x"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-557c75fe551so1593158e0c.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Oct 2025 13:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761338463; x=1761943263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qvtd1DBfb/UtwRwKKkY88K+YPOvyAQ4v2MVGqQOq2lc=;
        b=Aoi3P2/xnCtDsG4qb9cFKrK2ZY+lnetOJSwXqLPQEMAQ/741r0/YZ8omGhBijnjxdj
         lL1VOTNPtf0ddJgCyXZozI2leKr6UStN6Etf4eaCFvdlfSuQksH/nx0oH0dAkFU7k2Mm
         uu8GrJr4dgpNpn6f91ZFPsOeTvknWqc2+ZVdnQmTtdYbc4LXcntxbRwMVCgZRBXhKfyz
         1M4jITmEpn0ipNor9wmpK8wtVQ6dyFgyBpRHvWwaJCewZR4XzDp3Ki++t1eHPAuwAcaY
         TrTdGb/GlaUwLOPFPHGWkpxbSnD8j90V2PzauAW1fVpuWZn4ksoSlBzYxdMls0CJL5uY
         kAMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761338463; x=1761943263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qvtd1DBfb/UtwRwKKkY88K+YPOvyAQ4v2MVGqQOq2lc=;
        b=ES2YxU3A4QFkAZmiLiKjs4EAzSzhyQAfk8EJroCOpXqMvCUHfzYqg4T15+uFS/Z5Ch
         ZyLcjkYc6WLGNZq7EWfTLr1KECvn8hqhoPtEkNwOmWzUcIzEDAye/rEnTujZJcVwsE8y
         scf7poefztY2Jz0c30HIGmU7JnCVC/2X7HoNrj19h+8WGgz7aG9qrwqvG8mJnemG77Zk
         0BWjMrGfBeCoOHjBn3sNeiqi32XGZh6X+ZkhpdXDVqV4ErEThLbYiUoTyEjUi329kqYE
         Ft9YqkB/IUpr7TgbKUvTlPvSHmXS6If9PR1Jty4Dt2ejsw0xxwvflT1Xa70Qkd6hnlRE
         l34Q==
X-Gm-Message-State: AOJu0YxPr0o4fMksW6LVbCzq0uaQLbLTMVRabEOLzeQgVBCcswBVPzih
	5ocYDKb//kcjKu3pRC5DvlLSeEdtYVP4mBx7WqZdOJfHCjMOUdjaMhpy5Fcm0A==
X-Gm-Gg: ASbGnctONw5EIgNo+Tp4yIZqpkcub7Of5d1F4KScOb4T9VR3mrZy611Jb9l4y+JTste
	qSZnBBg9nXELDazftCsepR/IgqUeGM5tjzy5hJHMfm9QPmZYvS3qANLzikyMasKlozbT96PjWYE
	ViMD0JGJZL2y5SwfBOMrAOq6qvPhZ/r6A9GZ0uLXQ7X127KfNR/Osjb8jsfH2nfbuMB77s/LRXS
	knjmIPzK/dZLy8fXEn87t1yQ/pZBRd0Zlp8ls9weTmdIifpROEOepRnRihIIV5kMx7PDJjkkcmU
	ZYUDp7ilFWpiX5zdq5bzo6WJSmvUVB44/oJqyJVdxq7IxE3bX+fe8UHUSzSLE/kly47FSjADSt2
	asm4jtU2+/zjKmdKHfwzLn+UieXUM6wXVJiHDS0sOq5kzP/7uljfGtWhtFD2VG6EZfCQDJSV4kc
	+juqi3HGmxMLRx8wgwz/MnmNRR
X-Google-Smtp-Source: AGHT+IEb88HAiUUy/ioJsqKnOtdkB6GuJDonM64nLL2wGSGlYyttjP5eJ0awMWetTrUmRBNqMw+mCQ==
X-Received: by 2002:a05:6122:3c87:b0:557:ca69:bb81 with SMTP id 71dfb90a1353d-557ca69c00fmr1870712e0c.1.1761338462589;
        Fri, 24 Oct 2025 13:41:02 -0700 (PDT)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-557ddb2f98asm73501e0c.10.2025.10.24.13.41.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 13:41:01 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 08/12] bass: Implement Device option for Push
Date: Fri, 24 Oct 2025 16:40:35 -0400
Message-ID: <20251024204039.693918-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024204039.693918-1-luiz.dentz@gmail.com>
References: <20251024204039.693918-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This implements support for MediaAssistant.Push with local broadcast
sources.
---
 profiles/audio/bap.c  |  25 +-
 profiles/audio/bass.c | 851 +++++++++++++++++++++++++++++-------------
 src/shared/bass.c     |   7 +-
 src/shared/bass.h     |   4 +-
 4 files changed, 605 insertions(+), 282 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index b776511c57ce..c10f019edfea 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -139,7 +139,6 @@ struct bap_data {
 	GIOChannel *listen_io;
 	unsigned int io_id;
 	unsigned int cig_update_id;
-	void *user_data;
 };
 
 static struct queue *sessions;
@@ -152,16 +151,6 @@ static void setup_create_io(struct bap_data *data, struct bap_setup *setup,
 				struct bt_bap_stream *stream, int defer);
 static void bap_update_cigs(struct bap_data *data);
 
-static bool bap_data_set_user_data(struct bap_data *data, void *user_data)
-{
-	if (!data)
-		return false;
-
-	data->user_data = user_data;
-
-	return true;
-}
-
 static void bap_debug(const char *str, void *user_data)
 {
 	DBG_IDX(0xffff, "%s", str);
@@ -1527,12 +1516,12 @@ static void iso_pa_sync_confirm_cb(GIOChannel *io, void *user_data)
 								user_data);
 }
 
-static bool match_data_bap_data(const void *data, const void *match_data)
+static bool match_adapter(const void *data, const void *match_data)
 {
 	const struct bap_data *bdata = data;
 	const struct btd_adapter *adapter = match_data;
 
-	return bdata->user_data == adapter;
+	return bdata->adapter == adapter;
 }
 
 static const GDBusMethodTable ep_methods[] = {
@@ -2630,7 +2619,7 @@ static void setup_connect_io_broadcast(struct bap_data *data,
 					struct bt_bap_stream *stream,
 					struct bt_iso_qos *qos, int defer)
 {
-	struct btd_adapter *adapter = data->user_data;
+	struct btd_adapter *adapter = data->adapter;
 	GIOChannel *io = NULL;
 	GError *err = NULL;
 	bdaddr_t dst_addr = {0};
@@ -3849,23 +3838,19 @@ static int bap_adapter_probe(struct btd_profile *p, struct btd_adapter *adapter)
 		return -EINVAL;
 	}
 
+	data->adapter = adapter;
 	data->state_id = bt_bap_state_register(data->bap, bap_state_bcast_src,
 					bap_connecting_bcast, data, NULL);
 	data->pac_id = bt_bap_pac_register(data->bap, pac_added_broadcast,
 					pac_removed_broadcast, data, NULL);
 
-	bap_data_set_user_data(data, adapter);
-
-	data->adapter = adapter;
-
 	return 0;
 }
 
 static void bap_adapter_remove(struct btd_profile *p,
 					struct btd_adapter *adapter)
 {
-	struct bap_data *data = queue_find(sessions, match_data_bap_data,
-						adapter);
+	struct bap_data *data = queue_find(sessions, match_adapter, adapter);
 	char addr[18];
 
 	ba2str(btd_adapter_get_address(adapter), addr);
diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index b231d1f7787b..ee01effa3235 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -43,6 +43,7 @@
 #include "src/shared/bass.h"
 #include "src/shared/bap.h"
 #include "src/shared/ad.h"
+#include "src/shared/io.h"
 
 #include "btio/btio.h"
 #include "src/plugin.h"
@@ -69,6 +70,9 @@ enum assistant_state {
 	ASSISTANT_STATE_ACTIVE,		/* Remote device started receiving
 					 * stream
 					 */
+	ASSISTANT_STATE_LOCAL,		/* Assistant object was created for
+					 * local stream
+					 */
 };
 
 static const char *const str_state[] = {
@@ -76,18 +80,24 @@ static const char *const str_state[] = {
 	"ASSISTANT_STATE_PENDING",
 	"ASSISTANT_STATE_REQUESTING",
 	"ASSISTANT_STATE_ACTIVE",
+	"ASSISTANT_STATE_LOCAL",
 };
 
 struct bass_data {
+	struct btd_adapter *adapter;
 	struct btd_device *device;
 	struct btd_service *service;
+	struct bt_bap *bap;
 	struct bt_bass *bass;
+	struct bt_bap_stream *stream;
 	unsigned int src_id;
 	unsigned int cp_id;
 	unsigned int bis_id;
+	unsigned int state_id;
 };
 
 struct bass_assistant {
+	struct btd_adapter *adapter;	/* Broadcast source device */
 	struct btd_device *device;	/* Broadcast source device */
 	struct bass_data *data;		/* BASS session with peer device */
 	uint8_t sgrp;
@@ -140,7 +150,8 @@ static struct queue *delegators;
 
 static const char *state2str(enum assistant_state state);
 
-static struct bass_data *bass_data_new(struct btd_device *device);
+static struct bass_data *bass_data_new(struct btd_adapter *adapter,
+					struct btd_device *device);
 static void bass_data_add(struct bass_data *data);
 static void bass_data_remove(struct bass_data *data);
 
@@ -647,157 +658,71 @@ static void confirm_cb(GIOChannel *io, void *user_data)
 	dg->io_id = g_io_add_watch(io, G_IO_OUT, big_info_cb, dg);
 }
 
-static void bap_attached(struct bt_bap *bap, void *user_data)
+static void src_ad_search_bid(void *data, void *user_data)
 {
-	struct btd_service *service;
-	struct btd_profile *p;
-	struct btd_device *device;
-	struct btd_adapter *adapter;
-	struct bass_delegator *dg;
-	struct bass_data *data;
-	GError *err = NULL;
+	struct bt_ad_service_data *sd = data;
+	struct bass_assistant *assistant = user_data;
+	struct iovec iov;
 
-	DBG("%p", bap);
-
-	service = bt_bap_get_user_data(bap);
-	if (!service)
+	if (sd->uuid.type != BT_UUID16 || sd->uuid.value.u16 != BCAA_SERVICE)
 		return;
 
-	p = btd_service_get_profile(service);
-	if (!p)
-		return;
+	iov.iov_base = sd->data;
+	iov.iov_len = sd->len;
 
-	/* Only handle sessions with Broadcast Sources */
-	if (!g_str_equal(p->remote_uuid, BCAAS_UUID_STR))
-		return;
-
-	device = btd_service_get_device(service);
-	adapter = device_get_adapter(device);
-
-	/* Create BASS session with the Broadcast Source */
-	data = bass_data_new(device);
-	data->bis_id = bt_bap_bis_cb_register(bap, bis_probe,
-					bis_remove, device, NULL);
-
-	bass_data_add(data);
-
-	dg = queue_find(delegators, delegator_match_device, device);
-	if (!dg)
-		/* Only probe devices added via Broadcast Assistants */
-		return;
-
-	if (dg->service)
-		/* Service has already been probed */
-		return;
-
-	dg->service = service;
-	dg->bap = bap;
-
-	dg->io = bt_io_listen(NULL, confirm_cb, dg,
-		NULL, &err,
-		BT_IO_OPT_SOURCE_BDADDR,
-		btd_adapter_get_address(adapter),
-		BT_IO_OPT_SOURCE_TYPE,
-		btd_adapter_get_address_type(adapter),
-		BT_IO_OPT_DEST_BDADDR,
-		device_get_address(device),
-		BT_IO_OPT_DEST_TYPE,
-		btd_device_get_bdaddr_type(device),
-		BT_IO_OPT_MODE, BT_IO_MODE_ISO,
-		BT_IO_OPT_QOS, &bap_sink_pa_qos,
-		BT_IO_OPT_ISO_BC_SID, dg->sid,
-		BT_IO_OPT_INVALID);
-	if (!dg->io) {
-		error("%s", err->message);
-		g_error_free(err);
-		return;
-	}
-
-	/* Take ownership for the service by setting the user data. */
-	btd_service_set_user_data(service, dg);
+	util_iov_pull_le24(&iov, &assistant->bid);
 }
 
-static bool match_device(const void *data, const void *match_data)
+static struct bass_assistant *
+assistant_new(struct btd_adapter *adapter,
+		struct btd_device *device, struct bass_data *data,
+		uint8_t sgrp, uint8_t sid, uint8_t bis, struct bt_bap_qos *qos,
+		struct iovec *meta, struct iovec *caps)
 {
-	const struct bass_data *bdata = data;
-	const struct btd_device *device = match_data;
+	struct bass_assistant *assistant;
+	char src_addr[18];
 
-	return bdata->device == device;
-}
+	assistant = new0(struct bass_assistant, 1);
+	if (!assistant)
+		return NULL;
 
-static void delegator_free(struct bass_delegator *dg)
-{
-	DBG("%p", dg);
+	DBG("assistant %p", assistant);
 
-	if (dg->io_id)
-		g_source_remove(dg->io_id);
+	assistant->adapter = adapter;
+	assistant->device = device;
+	assistant->data = data;
+	assistant->sgrp = sgrp;
+	assistant->sid = sid;
+	assistant->bis = bis;
+	assistant->qos = *qos;
 
-	if (dg->io) {
-		g_io_channel_shutdown(dg->io, TRUE, NULL);
-		g_io_channel_unref(dg->io);
+	/* Create an internal copy for bcode */
+	assistant->qos.bcast.bcode = util_iov_dup(qos->bcast.bcode, 1);
+	assistant->meta = util_iov_dup(meta, 1);
+	assistant->caps = util_iov_dup(caps, 1);
+
+	if (device) {
+		btd_device_foreach_service_data(device, src_ad_search_bid,
+							assistant);
+		ba2str(device_get_address(device), src_addr);
+		assistant->path = g_strdup_printf("%s/src_%s/sid%d/bis%d",
+						device_get_path(data->device),
+						src_addr, sid, bis);
+	} else {
+		assistant->path = g_strdup_printf("%s/sid%d/bis%d",
+						adapter_get_path(data->adapter),
+						sid, bis);
+		assistant->state = ASSISTANT_STATE_LOCAL;
 	}
 
-	queue_destroy(dg->setups, setup_free);
+	g_strdelimit(assistant->path, ":", '_');
 
-	/* Update Broadcast Receive State characteristic value and notify
-	 * peers.
-	 */
-	if (bt_bass_set_pa_sync(dg->src, BT_BASS_NOT_SYNCHRONIZED_TO_PA))
-		DBG("Failed to update Broadcast Receive State characteristic");
+	if (!assistants)
+		assistants = queue_new();
 
-	/* Unregister BAP stream state changed callback. */
-	bt_bap_state_unregister(dg->bap, dg->state_id);
+	queue_push_tail(assistants, assistant);
 
-	bt_bap_bcode_cb_unregister(dg->bap, dg->bcode_id);
-
-	if (dg->timeout)
-		g_source_remove(dg->timeout);
-
-	queue_destroy(dg->bcode_reqs, free);
-
-	free(dg->bcode);
-
-	free(dg);
-}
-
-static void bap_detached(struct bt_bap *bap, void *user_data)
-{
-	struct btd_service *service;
-	struct btd_profile *p;
-	struct btd_device *device;
-	struct bass_delegator *dg;
-	struct bass_data *data;
-
-	DBG("%p", bap);
-
-	service = bt_bap_get_user_data(bap);
-	if (!service)
-		return;
-
-	p = btd_service_get_profile(service);
-	if (!p)
-		return;
-
-	/* Only handle sessions with Broadcast Sources */
-	if (!g_str_equal(p->remote_uuid, BCAAS_UUID_STR))
-		return;
-
-	device = btd_service_get_device(service);
-
-	/* Remove BASS session with the Broadcast Source device */
-	data = queue_find(sessions, match_device, device);
-	if (data) {
-		bt_bap_bis_cb_unregister(bap, data->bis_id);
-		bass_data_remove(data);
-	}
-
-	dg = queue_remove_if(delegators, delegator_match_device, device);
-	if (!dg)
-		return;
-
-	delegator_free(dg);
-
-	btd_service_set_user_data(service, NULL);
+	return assistant;
 }
 
 static void assistant_set_state(struct bass_assistant *assistant,
@@ -806,7 +731,7 @@ static void assistant_set_state(struct bass_assistant *assistant,
 	enum assistant_state old_state = assistant->state;
 	const char *str;
 
-	if (old_state == state)
+	if (old_state == state || old_state == ASSISTANT_STATE_LOCAL)
 		return;
 
 	assistant->state = state;
@@ -873,11 +798,21 @@ static int assistant_parse_qos(struct bass_assistant *assistant,
 	return 0;
 }
 
+static bool match_device(const void *data, const void *match_data)
+{
+	const struct bass_data *bdata = data;
+	const struct btd_device *device = match_data;
+
+	return bdata->device == device;
+}
+
 static int assistant_parse_props(struct bass_assistant *assistant,
 					DBusMessageIter *props)
 {
 	DBusMessageIter value, entry, array;
-	const char *key;
+	const char *key, *path;
+	struct btd_device *device;
+	struct bass_data *data;
 
 	while (dbus_message_iter_get_arg_type(props) == DBUS_TYPE_DICT_ENTRY) {
 		dbus_message_iter_recurse(props, &entry);
@@ -910,6 +845,44 @@ static int assistant_parse_props(struct bass_assistant *assistant,
 				goto fail;
 
 			DBG("Parsed QoS");
+		} else if (!strcasecmp(key, "Device")) {
+			if (assistant->state != ASSISTANT_STATE_LOCAL) {
+				error("Device property is for local assistant "
+				      "only");
+				goto fail;
+			}
+
+			if (dbus_message_iter_get_arg_type(&value) !=
+							DBUS_TYPE_OBJECT_PATH)
+				goto fail;
+
+			dbus_message_iter_get_basic(&value, &path);
+
+			device = btd_adapter_find_device_by_path(
+							assistant->adapter,
+							path);
+			if (!device) {
+				error("Unable to find device %s", path);
+				goto fail;
+			}
+
+			data = queue_find(sessions, match_device, device);
+			if (!data) {
+				error("Unable to find data for device %s",
+					path);
+				goto fail;
+			}
+
+			if (!data->bass) {
+				error("Unable to find bass for device %s",
+					path);
+				goto fail;
+			}
+
+			if (assistant->data->bass)
+				bt_bass_unref(assistant->data->bass);
+
+			assistant->data->bass = bt_bass_ref(data->bass);
 		}
 
 		dbus_message_iter_next(props);
@@ -923,6 +896,69 @@ fail:
 	return -EINVAL;
 }
 
+static bool match_bass(const void *data, const void *match_data)
+{
+	const struct bass_data *bdata = data;
+	const struct bt_bass *bass = match_data;
+
+	/* Ignore data from own broadcast source */
+	if (!bdata->device)
+		return false;
+
+	return bdata->bass == bass;
+}
+
+static void assistant_past(struct bass_assistant *assistant)
+{
+	struct io *io = bt_bap_stream_get_io(assistant->data->stream);
+	struct btd_device *device = assistant->device;
+	int sk;
+	struct sockaddr_iso *addr;
+	int err;
+
+	DBG("");
+
+	if (!io) {
+		error("stream io not set");
+		return;
+	}
+
+	sk = io_get_fd(io);
+	if (sk < 0)
+		return;
+
+	if (!device) {
+		struct bt_bass *bass = assistant->data->bass;
+		struct bass_data *data;
+
+		data = queue_find(sessions, match_bass, bass);
+		if (!data) {
+			error("Unable to find data for bass %p", bass);
+			return;
+		}
+
+		device = data->device;
+		if (!device) {
+			error("Unable to find device for bass %p", bass);
+			return;
+		}
+	}
+
+	addr = malloc(sizeof(*addr) + sizeof(*addr->iso_bc));
+	memset(addr, 0, sizeof(*addr) + sizeof(*addr->iso_bc));
+	addr->iso_family = AF_BLUETOOTH;
+
+	bacpy(&addr->iso_bc->bc_bdaddr, (void *) device_get_address(device));
+	addr->iso_bc->bc_bdaddr_type = device_get_le_address_type(device);
+
+	err = bind(sk, (struct sockaddr *) addr, sizeof(*addr) +
+						sizeof(*addr->iso_bc));
+	if (err)
+		error("bind: %s", strerror(errno));
+
+	free(addr);
+}
+
 static DBusMessage *push(DBusConnection *conn, DBusMessage *msg,
 							  void *user_data)
 {
@@ -934,6 +970,7 @@ static DBusMessage *push(DBusConnection *conn, DBusMessage *msg,
 	uint8_t meta_len = 0;
 	int err;
 	DBusMessageIter props, dict;
+	struct io *io;
 
 	DBG("");
 
@@ -953,17 +990,64 @@ static DBusMessage *push(DBusConnection *conn, DBusMessage *msg,
 
 	hdr.op = BT_BASS_ADD_SRC;
 
-	if (device_get_le_address_type(assistant->device) == BDADDR_LE_PUBLIC)
-		params.addr_type = BT_BASS_ADDR_PUBLIC;
-	else
-		params.addr_type = BT_BASS_ADDR_RANDOM;
+	if (assistant->device) {
+		if (device_get_le_address_type(assistant->device) ==
+						BDADDR_LE_PUBLIC)
+			params.addr_type = BT_BASS_ADDR_PUBLIC;
+		else
+			params.addr_type = BT_BASS_ADDR_RANDOM;
 
-	bacpy(&params.addr, device_get_address(assistant->device));
-	params.sid = assistant->sid;
-	put_le24(assistant->bid, params.bid);
-	params.pa_sync = PA_SYNC_NO_PAST;
-	params.pa_interval = PA_INTERVAL_UNKNOWN;
-	params.num_subgroups = assistant->sgrp + 1;
+		bacpy(&params.addr, device_get_address(assistant->device));
+		params.sid = assistant->sid;
+		put_le24(assistant->bid, params.bid);
+		params.pa_sync = PA_SYNC_NO_PAST;
+		params.pa_interval = PA_INTERVAL_UNKNOWN;
+		params.num_subgroups = assistant->sgrp + 1;
+	} else {
+		io = bt_bap_stream_get_io(assistant->data->stream);
+		if (io) {
+			int fd = io_get_fd(io);
+			struct sockaddr_iso addr;
+			socklen_t olen = sizeof(addr);
+
+			memset(&addr, 0, sizeof(addr));
+			if (getsockname(fd, (struct sockaddr *) &addr,
+					&olen) < 0) {
+				error("getsockname: %s", strerror(errno));
+				return btd_error_invalid_args(msg);
+			}
+
+			if (addr.iso_bdaddr_type == BDADDR_LE_PUBLIC)
+				params.addr_type = BT_BASS_ADDR_PUBLIC;
+			else
+				params.addr_type = BT_BASS_ADDR_RANDOM;
+
+			bacpy(&params.addr, &addr.iso_bdaddr);
+		} else {
+			if (btd_adapter_get_address_type(assistant->adapter) ==
+							BDADDR_LE_PUBLIC)
+				params.addr_type = BT_BASS_ADDR_PUBLIC;
+			else
+				params.addr_type = BT_BASS_ADDR_RANDOM;
+
+			bacpy(&params.addr,
+				btd_adapter_get_address(assistant->adapter));
+		}
+
+		params.sid = assistant->sid;
+		/* TODO: Add a way to recover BID */
+		put_le24(assistant->bid, params.bid);
+
+		if (assistant->data->stream &&
+				btd_adapter_has_settings(assistant->adapter,
+						MGMT_SETTING_PAST_SENDER))
+			params.pa_sync = PA_SYNC_PAST;
+		else
+			params.pa_sync = PA_SYNC_NO_PAST;
+
+		params.pa_interval = PA_INTERVAL_UNKNOWN;
+		params.num_subgroups = assistant->sgrp + 1;
+	}
 
 	util_iov_append(&iov, &params, sizeof(params));
 
@@ -1018,6 +1102,8 @@ static const char *state2str(enum assistant_state state)
 		return "requesting";
 	case ASSISTANT_STATE_ACTIVE:
 		return "active";
+	case ASSISTANT_STATE_LOCAL:
+		return "local";
 	}
 
 	return NULL;
@@ -1102,65 +1188,278 @@ static void assistant_free(void *data)
 	free(assistant);
 }
 
-static void src_ad_search_bid(void *data, void *user_data)
+static void bis_src_handler(uint8_t sid, uint8_t bis, uint8_t sgrp,
+				struct iovec *caps, struct iovec *meta,
+				struct bt_bap_qos *qos, void *user_data)
 {
-	struct bt_ad_service_data *sd = data;
-	struct bass_assistant *assistant = user_data;
-	struct iovec iov;
+	struct bass_data *data = user_data;
+	struct bass_assistant *assistant;
+	char addr[18];
 
-	if (sd->uuid.type != BT_UUID16 || sd->uuid.value.u16 != BCAA_SERVICE)
-		return;
+	ba2str(btd_adapter_get_address(data->adapter), addr);
 
-	iov.iov_base = sd->data;
-	iov.iov_len = sd->len;
+	DBG("%s data %p BIS %d", addr, data, bis);
 
-	util_iov_pull_le24(&iov, &assistant->bid);
+	assistant = assistant_new(data->adapter, NULL, data, sgrp, sid, bis,
+					qos, meta, caps);
+	if (!g_dbus_register_interface(btd_get_dbus_connection(),
+					assistant->path,
+					MEDIA_ASSISTANT_INTERFACE,
+					assistant_methods, NULL,
+					assistant_properties,
+					assistant,
+					assistant_free))
+		DBG("Could not register path %s", assistant->path);
 }
 
-static struct bass_assistant *assistant_new(struct btd_adapter *adapter,
-		struct btd_device *device, struct bass_data *data,
-		uint8_t sgrp, uint8_t sid, uint8_t bis, struct bt_bap_qos *qos,
-		struct iovec *meta, struct iovec *caps)
+static bool assistant_match_data(const void *data, const void *match_data)
 {
-	struct bass_assistant *assistant;
-	char src_addr[18];
+	const struct bass_assistant *assistant = data;
+	const struct bass_data *bdata = match_data;
 
-	assistant = new0(struct bass_assistant, 1);
-	if (!assistant)
-		return NULL;
+	return (assistant->data == bdata);
+}
 
-	DBG("assistant %p", assistant);
+static void unregister_assistant(void *data)
+{
+	struct bass_assistant *assistant = data;
 
-	assistant->device = device;
-	assistant->data = data;
-	assistant->sgrp = sgrp;
-	assistant->sid = sid;
-	assistant->bis = bis;
-	assistant->qos = *qos;
+	DBG("%p", assistant);
 
-	/* Create an internal copy for bcode */
-	assistant->qos.bcast.bcode = util_iov_dup(qos->bcast.bcode, 1);
+	g_dbus_unregister_interface(btd_get_dbus_connection(),
+				assistant->path, MEDIA_ASSISTANT_INTERFACE);
+}
 
-	assistant->meta = util_iov_dup(meta, 1);
-	assistant->caps = util_iov_dup(caps, 1);
+static void bap_state_src_changed(struct bt_bap_stream *stream,
+				uint8_t old_state, uint8_t new_state,
+				void *user_data)
+{
+	struct bass_data *data = user_data;
+	struct assistant *assistant;
+	struct bt_bap_qos *qos = NULL;
+	struct iovec *base;
 
-	btd_device_foreach_service_data(assistant->device, src_ad_search_bid,
-							assistant);
+	DBG("stream %p: %s(%u) -> %s(%u)", stream,
+			bt_bap_stream_statestr(old_state), old_state,
+			bt_bap_stream_statestr(new_state), new_state);
 
-	ba2str(device_get_address(device), src_addr);
+	switch (new_state) {
+	case BT_BAP_STREAM_STATE_IDLE:
+		/* Unregister assistant object if one exists */
+		assistant = queue_remove_if(assistants, assistant_match_data,
+						data);
+		if (assistant)
+			unregister_assistant(assistant);
+		data->stream = NULL;
+		break;
+	case BT_BAP_STREAM_STATE_STREAMING:
+		base = bt_bap_stream_get_base(stream);
+		if (!base) {
+			error("Unable to read BASE of stream %p", stream);
+			break;
+		}
 
-	assistant->path = g_strdup_printf("%s/src_%s/sid%d/bis%d",
-					device_get_path(data->device), src_addr,
-					sid, bis);
+		if (!bt_bap_stream_io_get_qos(stream, NULL, &qos)) {
+			error("Unable to read QoS of stream %p", stream);
+			break;
+		}
 
-	g_strdelimit(assistant->path, ":", '_');
+		bt_bap_parse_base(0x00, base, qos, bass_debug, bis_src_handler,
+					data);
+		data->stream = stream;
+		break;
+	}
+}
 
-	if (!assistants)
-		assistants = queue_new();
+static void bap_bc_attached(struct bt_bap *bap, void *user_data)
+{
+	struct btd_gatt_database *db;
+	struct btd_adapter *adapter;
+	struct bass_data *data;
 
-	queue_push_tail(assistants, assistant);
+	DBG("%p", bap);
 
-	return assistant;
+	db = btd_gatt_database_get(bt_bap_get_db(bap, false));
+	if (!db)
+		return;
+
+	adapter = btd_gatt_database_get_adapter(db);
+	if (!adapter)
+		return;
+
+	/* Create BASS session with the local Broadcast Source */
+	data = bass_data_new(adapter, NULL);
+	data->bap = bap;
+	data->state_id = bt_bap_state_register(bap, bap_state_src_changed,
+						NULL, data, NULL);
+
+	bass_data_add(data);
+}
+
+static void bap_attached(struct bt_bap *bap, void *user_data)
+{
+	struct btd_service *service;
+	struct btd_profile *p;
+	struct btd_device *device;
+	struct btd_adapter *adapter;
+	struct bass_delegator *dg;
+	struct bass_data *data;
+	GError *err = NULL;
+
+	service = bt_bap_get_user_data(bap);
+	if (!service)
+		return bap_bc_attached(bap, user_data);
+
+	DBG("%p", bap);
+
+	p = btd_service_get_profile(service);
+	if (!p)
+		return;
+
+	/* Only handle sessions with Broadcast Sources */
+	if (!g_str_equal(p->remote_uuid, BCAAS_UUID_STR))
+		return;
+
+	device = btd_service_get_device(service);
+	adapter = device_get_adapter(device);
+
+	/* Create BASS session with the Broadcast Source */
+	data = bass_data_new(adapter, device);
+	data->bis_id = bt_bap_bis_cb_register(bap, bis_probe,
+					bis_remove, device, NULL);
+
+	bass_data_add(data);
+
+	dg = queue_find(delegators, delegator_match_device, device);
+	if (!dg)
+		/* Only probe devices added via Broadcast Assistants */
+		return;
+
+	if (dg->service)
+		/* Service has already been probed */
+		return;
+
+	dg->service = service;
+	dg->bap = bap;
+
+	dg->io = bt_io_listen(NULL, confirm_cb, dg,
+		NULL, &err,
+		BT_IO_OPT_SOURCE_BDADDR,
+		btd_adapter_get_address(adapter),
+		BT_IO_OPT_SOURCE_TYPE,
+		btd_adapter_get_address_type(adapter),
+		BT_IO_OPT_DEST_BDADDR,
+		device_get_address(device),
+		BT_IO_OPT_DEST_TYPE,
+		btd_device_get_bdaddr_type(device),
+		BT_IO_OPT_MODE, BT_IO_MODE_ISO,
+		BT_IO_OPT_QOS, &bap_sink_pa_qos,
+		BT_IO_OPT_ISO_BC_SID, dg->sid,
+		BT_IO_OPT_INVALID);
+	if (!dg->io) {
+		error("%s", err->message);
+		g_error_free(err);
+		return;
+	}
+
+	/* Take ownership for the service by setting the user data. */
+	btd_service_set_user_data(service, dg);
+}
+
+static bool match_bap(const void *data, const void *match_data)
+{
+	const struct bass_data *d = data;
+	const struct bt_bap *bap = match_data;
+
+	return (d->bap == bap);
+}
+
+static void bap_bc_detached(struct bt_bap *bap, struct bass_data *data)
+{
+	DBG("%p", bap);
+
+	bt_bap_state_unregister(bap, data->state_id);
+	bass_data_remove(data);
+}
+
+static void delegator_free(struct bass_delegator *dg)
+{
+	DBG("%p", dg);
+
+	if (dg->io_id)
+		g_source_remove(dg->io_id);
+
+	if (dg->io) {
+		g_io_channel_shutdown(dg->io, TRUE, NULL);
+		g_io_channel_unref(dg->io);
+	}
+
+	queue_destroy(dg->setups, setup_free);
+
+	/* Update Broadcast Receive State characteristic value and notify
+	 * peers.
+	 */
+	if (bt_bass_set_pa_sync(dg->src, BT_BASS_NOT_SYNCHRONIZED_TO_PA))
+		DBG("Failed to update Broadcast Receive State characteristic");
+
+	/* Unregister BAP stream state changed callback. */
+	bt_bap_state_unregister(dg->bap, dg->state_id);
+
+	bt_bap_bcode_cb_unregister(dg->bap, dg->bcode_id);
+
+	if (dg->timeout)
+		g_source_remove(dg->timeout);
+
+	queue_destroy(dg->bcode_reqs, free);
+
+	free(dg->bcode);
+
+	free(dg);
+}
+
+static void bap_detached(struct bt_bap *bap, void *user_data)
+{
+	struct btd_service *service;
+	struct btd_profile *p;
+	struct btd_device *device;
+	struct bass_delegator *dg;
+	struct bass_data *data;
+
+	data = queue_find(sessions, match_bap, bap);
+	if (data)
+		return bap_bc_detached(bap, data);
+
+	DBG("%p", bap);
+
+	service = bt_bap_get_user_data(bap);
+	if (!service)
+		return;
+
+	p = btd_service_get_profile(service);
+	if (!p)
+		return;
+
+	/* Only handle sessions with Broadcast Sources */
+	if (!g_str_equal(p->remote_uuid, BCAAS_UUID_STR))
+		return;
+
+	device = btd_service_get_device(service);
+
+	/* Remove BASS session with the Broadcast Source device */
+	data = queue_find(sessions, match_device, device);
+	if (data) {
+		bt_bap_bis_cb_unregister(bap, data->bis_id);
+		bt_bap_state_unregister(bap, data->state_id);
+		bass_data_remove(data);
+	}
+
+	dg = queue_remove_if(delegators, delegator_match_device, device);
+	if (!dg)
+		return;
+
+	delegator_free(dg);
+
+	btd_service_set_user_data(service, NULL);
 }
 
 static void bis_probe(uint8_t sid, uint8_t bis, uint8_t sgrp,
@@ -1219,16 +1518,6 @@ static bool assistant_match_device(const void *data, const void *match_data)
 	return (assistant->device == device);
 }
 
-static void unregister_assistant(void *data)
-{
-	struct bass_assistant *assistant = data;
-
-	DBG("%p", assistant);
-
-	g_dbus_unregister_interface(btd_get_dbus_connection(),
-				assistant->path, MEDIA_ASSISTANT_INTERFACE);
-}
-
 static void bis_remove(struct bt_bap *bap, void *user_data)
 {
 	struct btd_device *device = user_data;
@@ -1237,11 +1526,13 @@ static void bis_remove(struct bt_bap *bap, void *user_data)
 		device, unregister_assistant);
 }
 
-static struct bass_data *bass_data_new(struct btd_device *device)
+static struct bass_data *bass_data_new(struct btd_adapter *adapter,
+					struct btd_device *device)
 {
 	struct bass_data *data;
 
 	data = new0(struct bass_data, 1);
+	data->adapter = adapter;
 	data->device = device;
 
 	return data;
@@ -1249,6 +1540,8 @@ static struct bass_data *bass_data_new(struct btd_device *device)
 
 static void bass_data_add(struct bass_data *data)
 {
+	bool initiator = false;
+
 	DBG("data %p", data);
 
 	if (queue_find(sessions, NULL, data)) {
@@ -1264,32 +1557,15 @@ static void bass_data_add(struct bass_data *data)
 	queue_push_tail(sessions, data);
 
 	if (data->service) {
-		struct btd_adapter *adapter = device_get_adapter(data->device);
-		bool initiator = btd_service_is_initiator(data->service);
-
 		btd_service_set_user_data(data->service, data);
-		if ((!initiator && btd_adapter_has_settings(adapter,
-				MGMT_SETTING_PAST_RECEIVER)) || (initiator &&
-				btd_adapter_has_settings(adapter,
-				MGMT_SETTING_PAST_SENDER)))
-			device_set_past_support(data->device, true);
+		initiator = btd_service_is_initiator(data->service);
 	}
-}
 
-static bool match_data(const void *data, const void *match_data)
-{
-	const struct bass_data *bdata = data;
-	const struct bt_bass *bass = match_data;
-
-	return bdata->bass == bass;
-}
-
-static bool assistant_match_data(const void *data, const void *match_data)
-{
-	const struct bass_assistant *assistant = data;
-	const struct bass_data *bdata = match_data;
-
-	return (assistant->data == bdata);
+	if ((!initiator && btd_adapter_has_settings(data->adapter,
+				MGMT_SETTING_PAST_RECEIVER)) || (initiator &&
+				btd_adapter_has_settings(data->adapter,
+				MGMT_SETTING_PAST_SENDER)))
+		device_set_past_support(data->device, true);
 }
 
 static void bass_data_free(struct bass_data *data)
@@ -1331,7 +1607,7 @@ static void bass_detached(struct bt_bass *bass, void *user_data)
 
 	DBG("%p", bass);
 
-	data = queue_find(sessions, match_data, bass);
+	data = queue_find(sessions, match_bass, bass);
 	if (!data) {
 		error("Unable to find bass session");
 		return;
@@ -1346,42 +1622,19 @@ static void bass_detached(struct bt_bass *bass, void *user_data)
 	bass_data_remove(data);
 }
 
-static int handle_add_src_req(struct bt_bcast_src *bcast_src,
-			struct bt_bass_add_src_params *params,
-			struct bass_data *data)
+static struct bass_delegator *
+bass_delegator_new(struct btd_device *device, struct bt_bcast_src *src,
+			uint8_t sid)
 {
-	struct btd_adapter *adapter = device_get_adapter(data->device);
-	struct btd_device *device;
 	struct bass_delegator *dg;
 
-	/* Create device for Broadcast Source using the parameters
-	 * provided by Broadcast Assistant.
-	 */
-	device = btd_adapter_get_device(adapter, &params->addr,
-						params->addr_type);
-	if (!device) {
-		DBG("Unable to get device");
-		return -EINVAL;
-	}
-
-	DBG("device %p", device);
-
-	/* Probe Broadcast Source, if it has not already been
-	 * autonomously probed inside BAP.
-	 */
-	if (!btd_device_get_service(device, BCAAS_UUID_STR))
-		goto probe;
-
-	return 0;
-
-probe:
 	dg = new0(struct bass_delegator, 1);
 	if (!dg)
-		return -ENOMEM;
+		return NULL;
 
 	dg->device = device;
-	dg->src = bcast_src;
-	dg->sid = params->sid;
+	dg->src = src;
+	dg->sid = sid;
 	dg->bcode_reqs = queue_new();
 	dg->setups = queue_new();
 
@@ -1397,6 +1650,72 @@ probe:
 	 */
 	btd_device_add_uuid(device, BCAAS_UUID_STR);
 
+	if (!dg->service)
+		error("Unable to probe service for %s", BCAAS_UUID_STR);
+
+	return dg;
+}
+
+static int handle_add_src_req(struct bt_bcast_src *bcast_src,
+			struct bt_bass_add_src_params *params,
+			struct bass_data *data)
+{
+	struct btd_adapter *adapter = device_get_adapter(data->device);
+	struct btd_device *device;
+	struct bass_delegator *dg;
+
+	/* Detect if PAST can be used then it can be used as destination since
+	 * PAST Receiver uses the ACL connection itself.
+	 */
+	if (params->pa_sync == PA_SYNC_PAST) {
+		/* Check if MGMT_SETTING_PAST_RECEIVER is supported then set
+		 * DEVICE_FLAG_PAST since the device is requesting PAST to be
+		 * used.
+		 */
+		if (btd_adapter_has_settings(data->adapter,
+						MGMT_SETTING_PAST_RECEIVER)) {
+			device_set_past_support(data->device, true);
+			device = data->device;
+			goto done;
+		}
+	}
+
+	/* Create device for Broadcast Source using the parameters
+	 * provided by Broadcast Assistant.
+	 */
+	device = btd_adapter_get_device(adapter, &params->addr,
+						params->addr_type);
+
+	if (!device) {
+		DBG("Unable to get device");
+		return -EINVAL;
+	}
+
+done:
+	DBG("device %p", device);
+
+	/* Probe Broadcast Source, if it has not already been
+	 * autonomously probed inside BAP.
+	 */
+	if (!btd_device_get_service(device, BCAAS_UUID_STR)) {
+		dg = bass_delegator_new(device, bcast_src, params->sid);
+		if (!dg)
+			return -ENOMEM;
+	}
+
+	/* Set PA sync state, this has to be done after probing otherwise there
+	 * is a race where the remote may receive BT_BASS_SYNC_INFO_RE and start
+	 * PAST before the kernel has sent PAST Parameter command that enables
+	 * receiving it.
+	 */
+	if (params->pa_sync == PA_SYNC_PAST) {
+		if (btd_adapter_has_settings(data->adapter,
+						MGMT_SETTING_PAST_RECEIVER))
+			bt_bass_set_pa_sync(bcast_src, BT_BASS_SYNC_INFO_RE);
+		else
+			bt_bass_set_pa_sync(bcast_src, BT_BASS_NO_PAST);
+	}
+
 	return 0;
 }
 
@@ -1580,7 +1899,7 @@ static void bass_attached(struct bt_bass *bass, void *user_data)
 
 	DBG("%p", bass);
 
-	data = queue_find(sessions, match_data, bass);
+	data = queue_find(sessions, match_bass, bass);
 	if (data)
 		return;
 
@@ -1594,7 +1913,7 @@ static void bass_attached(struct bt_bass *bass, void *user_data)
 		return;
 	}
 
-	data = bass_data_new(device);
+	data = bass_data_new(device_get_adapter(device), device);
 	data->bass = bass;
 
 	data->cp_id = bt_bass_cp_handler_register(data->bass,
@@ -1636,8 +1955,8 @@ static void bass_handle_bcode_req(struct bass_assistant *assistant, int id)
 	free(iov.iov_base);
 }
 
-static void bass_src_changed(uint8_t id, uint32_t bid, uint8_t enc,
-					uint32_t bis_sync, void *user_data)
+static void bass_src_changed(uint8_t id, uint32_t bid, uint8_t state,
+				uint8_t enc, uint32_t bis_sync, void *user_data)
 {
 	const struct queue_entry *entry;
 
@@ -1646,15 +1965,27 @@ static void bass_src_changed(uint8_t id, uint32_t bid, uint8_t enc,
 		struct bass_assistant *assistant = entry->data;
 		uint32_t bis = 1 << (assistant->bis - 1);
 
-		if (assistant->bid != bid)
+		if (bid && assistant->bid != bid)
 			/* Only handle assistant objects
 			 * that match the source
 			 */
 			continue;
 
+		/* If BID is not set it may happen to be local stream so ignore
+		 * non-local assistants.
+		 */
+		if (!bid && assistant->state != ASSISTANT_STATE_LOCAL)
+			continue;
+
+		if (state == BT_BASS_SYNC_INFO_RE) {
+			assistant_past(assistant);
+			return;
+		}
+
 		switch (enc) {
 		case BT_BASS_BIG_ENC_STATE_BCODE_REQ:
-			if (assistant->state != ASSISTANT_STATE_PENDING)
+			if (assistant->state != ASSISTANT_STATE_PENDING &&
+				assistant->state != ASSISTANT_STATE_LOCAL)
 				/* Only handle assistant objects that
 				 * have been pushed by the user
 				 */
@@ -1662,6 +1993,10 @@ static void bass_src_changed(uint8_t id, uint32_t bid, uint8_t enc,
 
 			/* Provide Broadcast Code to peer */
 			bass_handle_bcode_req(assistant, id);
+
+			if (assistant->state == ASSISTANT_STATE_LOCAL)
+				return;
+
 			break;
 		case BT_BASS_BIG_ENC_STATE_NO_ENC:
 			if (assistant->state != ASSISTANT_STATE_PENDING)
@@ -1710,7 +2045,7 @@ static int bass_probe(struct btd_service *service)
 		return -EINVAL;
 	}
 
-	data = bass_data_new(device);
+	data = bass_data_new(adapter, device);
 	data->service = service;
 
 	data->bass = bt_bass_new(btd_gatt_database_get_db(database),
diff --git a/src/shared/bass.c b/src/shared/bass.c
index 36bb9ea66523..19cc9531d617 100644
--- a/src/shared/bass.c
+++ b/src/shared/bass.c
@@ -1319,8 +1319,9 @@ static void notify_src_changed(void *data, void *user_data)
 	}
 
 	if (changed->cb)
-		changed->cb(bcast_src->id, bcast_src->bid, bcast_src->enc,
-					bis_sync, changed->data);
+		changed->cb(bcast_src->id, bcast_src->bid,
+			    bcast_src->sync_state, bcast_src->enc,
+			    bis_sync, changed->data);
 }
 
 static void bcast_recv_state_notify(struct bt_bass *bass, uint16_t value_handle,
@@ -1681,7 +1682,7 @@ static struct bt_bass_db *bass_get_db(struct gatt_db *db,
 	return bass_db_new(db, adapter_bdaddr);
 }
 
-static struct bt_bass *bt_bass_ref(struct bt_bass *bass)
+struct bt_bass *bt_bass_ref(struct bt_bass *bass)
 {
 	if (!bass)
 		return NULL;
diff --git a/src/shared/bass.h b/src/shared/bass.h
index f39ed7dad41d..a7b7741db3b7 100644
--- a/src/shared/bass.h
+++ b/src/shared/bass.h
@@ -97,7 +97,8 @@ typedef void (*bt_bass_func_t)(struct bt_bass *bass, void *user_data);
 typedef void (*bt_bass_destroy_func_t)(void *user_data);
 typedef void (*bt_bass_debug_func_t)(const char *str, void *user_data);
 typedef void (*bt_bass_src_func_t)(uint8_t id, uint32_t bid, uint8_t enc,
-					uint32_t bis_sync, void *user_data);
+				   uint8_t state, uint32_t bis_sync,
+				   void *user_data);
 
 typedef int (*bt_bass_cp_handler_func_t)(struct bt_bcast_src *bcast_src,
 		uint8_t op, void *params, void *user_data);
@@ -112,6 +113,7 @@ bool bt_bass_set_debug(struct bt_bass *bass, bt_bass_debug_func_t func,
 struct bt_bass *bt_bass_new(struct gatt_db *ldb, struct gatt_db *rdb,
 			const bdaddr_t *adapter_bdaddr);
 bool bt_bass_set_user_data(struct bt_bass *bass, void *user_data);
+struct bt_bass *bt_bass_ref(struct bt_bass *bass);
 void bt_bass_unref(struct bt_bass *bass);
 bool bt_bass_attach(struct bt_bass *bass, struct bt_gatt_client *client);
 bool bt_bass_set_att(struct bt_bass *bass, struct bt_att *att);
-- 
2.51.0

