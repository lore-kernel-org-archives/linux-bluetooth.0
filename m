Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7232853EF
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 21:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760045411; cv=none; b=usYJ/muQudYHzWf7oVVdH/MNgh7B6KP2HGtkRdoxXBBoKq5+H/pCDaqK6UzruW6WPAOoMVWga2o7dA+COK+uL8Zp7xR+FAZRAA1RHkCk9mFf27ePsdR2PzUN6sOItabIVC2i8nnQFixxlh3pJuylZPtreOiPea3AKJidXxjXp40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760045411; c=relaxed/simple;
	bh=IEdA6cWv1cdmGFLAYW/kPXJ3szP/JEbs8kaFtnJsdoo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tVR4Q3sXHsEQMBBdPuJUbCVayIltvSQEQfIXzfTmwEVH2cGfYm/7QFFm0N/RMwbkmg7Tojf8u2IZDvch6XcZqpKn4UrFV4xEmcbaqumSZyihnZbaKmlz5CoBvLlc6btx/VFK3HsI8MvHonJY/V5P4HTNEPEb8WEDA3j42Qt8PKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nMPkmLSY; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMPkmLSY"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-54a880e2858so663948e0c.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Oct 2025 14:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760045407; x=1760650207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YyJRaZU85E9Dr//dT6LWi1h92FaoORHsiI9Q6bKQt3A=;
        b=nMPkmLSYaSlA7O5NQAAsr3l8kFwugQoSYRzqFeM7cfLCmtvL4AKaiDciXUC++3bCyD
         eSS5KDy7KSXTy3ZIYwwymMcKKlaUx5JRiK3pU6DhwCK3QPBfTgjTjWaCcHaMFAAx4qFI
         NuPeO+UjzJ1M6uGd/hQHDVb3+M5uPVQLOcTHoZj2LB2kemA4hNixg+wGfqHObnNVok+E
         uxCnIG202t9nOoqu3sy1P9V4KeahuoxdN9jnYp4kUm0iX01ksTuP71tgW18wbxb5lZ4j
         oWedj7XLgC9BdnRIfJ/IXQBjWUet/2hlrYxlGlpoF335wI+oIkVObsVFz9TmqQFgQr+k
         obxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760045407; x=1760650207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YyJRaZU85E9Dr//dT6LWi1h92FaoORHsiI9Q6bKQt3A=;
        b=HAUmUsgWPukI6642zdu1+6kkoc10y6JAuCbHupIU5GSZJd7Ga9Nu+nXKf/pzpOCSgr
         d1EDQo4HA4q0131+HuZd8JHVSSQcRfB+TNoKXBYmw5Xrb/ZzWf8RHptevhlDa/W+NdYd
         FZkHVVqb5s4TMtd5mdhEu/iV/AVzS63aCaiv9C+LXaISVu5bP7A0QLJz2D3OAeqQ+Iqz
         KXAVJ73VlSmhs3Zeybrci+uDbc7ag6A49LOG9hTPgrEQufM6SK+GajlQulSjOkyEwL6g
         W6EASqKzPBuXgm4PTL0zMAKsxjqoDBjwbxmjeO9z8L+rJeeTRpwUWGExVHfHrIpHWqE1
         npiA==
X-Gm-Message-State: AOJu0YwmhgwjW1fm6jp04Vz2FH5pliXZTc/BDPTULLV393SWdgeylsKF
	z6687pxcyw8mnGC2T3vrNsA1yV+16xp17ka7AWfbbctOOOUdyWUyLca+lMMWBaaD
X-Gm-Gg: ASbGncs8CLElWVtkBTa/6qOXcpVawUbbfVJYiWNX8Tbd90ZyjUV+FnwUO6GmB3ojWSG
	1hBCpM4hCWNtiofq/ggzKh42Vw7SmZl3oCcuFJuIfTHA/aaMSp7sV6kDL63bpJZVphZRtRC/B0+
	xdeyRtMJiF1prvhJYS7ASEJ7bLfiBWu7NMSOZsEhRt/cd11oUsOJluSlqaJti3pUTnbfI30CH2l
	sJOo5KTxZYY4nYaCgE+Ns/TApK2be5heOj13YtVy1t/5/chC9OZwOfKj6vdfg2EgPSUkENJ1Jfi
	/OJRRIYasFb7OpRex8bkqjxrVlXzo+d7B/EQierVx6JGnCBHJa0RMy69xnPF9Hsruk1WZYhFtrk
	G9XGT45pxxckPFirhWWOCxQJcDKDyl7ax1JUV5PvP0FU5kZjHsoBei8QCUyAKo7XqQkMB38n8Di
	A9o66FllPaN6+1of6YoLOZV42T
X-Google-Smtp-Source: AGHT+IEPnpfNYBszs+DC7WOZh1XsBHcMM0nJe0D/kwBCSS5XkCXr9lXeK8H11u7tLxWC8PgH3hQWiA==
X-Received: by 2002:a05:6122:181d:b0:544:a84d:d3ac with SMTP id 71dfb90a1353d-554b8aa92f8mr3979028e0c.5.1760045406513;
        Thu, 09 Oct 2025 14:30:06 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-554d7f01e3fsm211224e0c.7.2025.10.09.14.30.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 14:30:05 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 11/13] bass: Implement Device option for Push
Date: Thu,  9 Oct 2025 17:29:29 -0400
Message-ID: <20251009212931.445719-11-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009212931.445719-1-luiz.dentz@gmail.com>
References: <20251009212931.445719-1-luiz.dentz@gmail.com>
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
 profiles/audio/bap.c  |   1 +
 profiles/audio/bass.c | 656 ++++++++++++++++++++++++++++++------------
 src/shared/bass.c     |   7 +-
 src/shared/bass.h     |   4 +-
 4 files changed, 478 insertions(+), 190 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index b2711359952b..0de620d05fd6 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -3821,6 +3821,7 @@ static int bap_adapter_probe(struct btd_profile *p, struct btd_adapter *adapter)
 		return -EINVAL;
 	}
 
+	bt_bap_set_user_data(data->bap, adapter);
 	bap_data_add(data);
 
 	if (!bt_bap_attach_broadcast(data->bap)) {
diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index ee1257702638..70ef6f932ec7 100644
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
@@ -76,18 +80,23 @@ static const char *const str_state[] = {
 	"ASSISTANT_STATE_PENDING",
 	"ASSISTANT_STATE_REQUESTING",
 	"ASSISTANT_STATE_ACTIVE",
+	"ASSISTANT_STATE_LOCAL",
 };
 
 struct bass_data {
+	struct btd_adapter *adapter;
 	struct btd_device *device;
 	struct btd_service *service;
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
@@ -140,7 +149,8 @@ static struct queue *delegators;
 
 static const char *state2str(enum assistant_state state);
 
-static struct bass_data *bass_data_new(struct btd_device *device);
+static struct bass_data *bass_data_new(struct btd_adapter *adapter,
+					struct btd_device *device);
 static void bass_data_add(struct bass_data *data);
 static void bass_data_remove(struct bass_data *data);
 
@@ -654,7 +664,7 @@ static void bap_attached(struct bt_bap *bap, void *user_data)
 	adapter = device_get_adapter(device);
 
 	/* Create BASS session with the Broadcast Source */
-	data = bass_data_new(device);
+	data = bass_data_new(adapter, device);
 	data->bis_id = bt_bap_bis_cb_register(bap, bis_probe,
 					bis_remove, device, NULL);
 
@@ -696,108 +706,13 @@ static void bap_attached(struct bt_bap *bap, void *user_data)
 	btd_service_set_user_data(service, dg);
 }
 
-static void setup_free(void *data)
-{
-	struct bass_setup *setup = data;
-
-	DBG("setup %p", setup);
-
-	util_iov_free(setup->qos.bcast.bcode, 1);
-	util_iov_free(setup->meta, 1);
-	util_iov_free(setup->config, 1);
-	free(setup->path);
-
-	/* Clear bis index from the bis sync bitmask, if it
-	 * has been previously set.
-	 */
-	bt_bass_clear_bis_sync(setup->dg->src, setup->bis);
-}
-
-static bool match_device(const void *data, const void *match_data)
-{
-	const struct bass_data *bdata = data;
-	const struct btd_device *device = match_data;
-
-	return bdata->device == device;
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
-	DBG("%p", dg);
-
-	if (dg->io_id)
-		g_source_remove(dg->io_id);
-
-	if (dg->io) {
-		g_io_channel_shutdown(dg->io, TRUE, NULL);
-		g_io_channel_unref(dg->io);
-	}
-
-	queue_destroy(dg->setups, setup_free);
-
-	/* Update Broadcast Receive State characteristic value and notify
-	 * peers.
-	 */
-	if (bt_bass_set_pa_sync(dg->src, BT_BASS_NOT_SYNCHRONIZED_TO_PA))
-		DBG("Failed to update Broadcast Receive State characteristic");
-
-	/* Unregister BAP stream state changed callback. */
-	bt_bap_state_unregister(dg->bap, dg->state_id);
-
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
-
-	btd_service_set_user_data(service, NULL);
-}
-
 static void assistant_set_state(struct bass_assistant *assistant,
 					enum assistant_state state)
 {
 	enum assistant_state old_state = assistant->state;
 	const char *str;
 
-	if (old_state == state)
+	if (old_state == state || old_state == ASSISTANT_STATE_LOCAL)
 		return;
 
 	assistant->state = state;
@@ -864,11 +779,21 @@ static int assistant_parse_qos(struct bass_assistant *assistant,
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
@@ -901,6 +826,44 @@ static int assistant_parse_props(struct bass_assistant *assistant,
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
@@ -914,6 +877,63 @@ fail:
 	return -EINVAL;
 }
 
+static bool match_data(const void *data, const void *match_data)
+{
+	const struct bass_data *bdata = data;
+	const struct bt_bass *bass = match_data;
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
+		data = queue_find(sessions, match_data, bass);
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
+}
+
 static DBusMessage *push(DBusConnection *conn, DBusMessage *msg,
 							  void *user_data)
 {
@@ -925,6 +945,7 @@ static DBusMessage *push(DBusConnection *conn, DBusMessage *msg,
 	uint8_t meta_len = 0;
 	int err;
 	DBusMessageIter props, dict;
+	struct io *io;
 
 	DBG("");
 
@@ -944,17 +965,63 @@ static DBusMessage *push(DBusConnection *conn, DBusMessage *msg,
 
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
+			params.pa_sync = PA_SYNC_NO_SYNC;
+
+		params.pa_interval = PA_INTERVAL_UNKNOWN;
+		params.num_subgroups = assistant->sgrp + 1;
+	}
 
 	util_iov_append(&iov, &params, sizeof(params));
 
@@ -1009,6 +1076,8 @@ static const char *state2str(enum assistant_state state)
 		return "requesting";
 	case ASSISTANT_STATE_ACTIVE:
 		return "active";
+	case ASSISTANT_STATE_LOCAL:
+		return "local";
 	}
 
 	return NULL;
@@ -1108,7 +1177,8 @@ static void src_ad_search_bid(void *data, void *user_data)
 	util_iov_pull_le24(&iov, &assistant->bid);
 }
 
-static struct bass_assistant *assistant_new(struct btd_adapter *adapter,
+static struct bass_assistant *
+assistant_new(struct btd_adapter *adapter,
 		struct btd_device *device, struct bass_data *data,
 		uint8_t sgrp, uint8_t sid, uint8_t bis, struct bt_bap_qos *qos,
 		struct iovec *meta, struct iovec *caps)
@@ -1122,6 +1192,7 @@ static struct bass_assistant *assistant_new(struct btd_adapter *adapter,
 
 	DBG("assistant %p", assistant);
 
+	assistant->adapter = adapter;
 	assistant->device = device;
 	assistant->data = data;
 	assistant->sgrp = sgrp;
@@ -1135,14 +1206,21 @@ static struct bass_assistant *assistant_new(struct btd_adapter *adapter,
 	assistant->meta = util_iov_dup(meta, 1);
 	assistant->caps = util_iov_dup(caps, 1);
 
-	btd_device_foreach_service_data(assistant->device, src_ad_search_bid,
+	if (device) {
+		btd_device_foreach_service_data(device, src_ad_search_bid,
 							assistant);
 
-	ba2str(device_get_address(device), src_addr);
+		ba2str(device_get_address(device), src_addr);
 
-	assistant->path = g_strdup_printf("%s/src_%s/sid%d/bis%d",
-					device_get_path(data->device), src_addr,
-					sid, bis);
+		assistant->path = g_strdup_printf("%s/src_%s/sid%d/bis%d",
+						device_get_path(data->device),
+						src_addr, sid, bis);
+	} else {
+		assistant->path = g_strdup_printf("%s/sid%d/bis%d",
+						adapter_get_path(data->adapter),
+						sid, bis);
+		assistant->state = ASSISTANT_STATE_LOCAL;
+	}
 
 	g_strdelimit(assistant->path, ":", '_');
 
@@ -1154,6 +1232,194 @@ static struct bass_assistant *assistant_new(struct btd_adapter *adapter,
 	return assistant;
 }
 
+static void bis_src_handler(uint8_t sid, uint8_t bis, uint8_t sgrp,
+				struct iovec *caps, struct iovec *meta,
+				struct bt_bap_qos *qos, void *user_data)
+{
+	struct bass_data *data = user_data;
+	struct bass_assistant *assistant;
+	char addr[18];
+
+	ba2str(btd_adapter_get_address(data->adapter), addr);
+
+	DBG("%s data %p BIS %d", addr, data, bis);
+
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
+}
+
+static bool assistant_match_data(const void *data, const void *match_data)
+{
+	const struct bass_assistant *assistant = data;
+	const struct bass_data *bdata = match_data;
+
+	return (assistant->data == bdata);
+}
+
+static void unregister_assistant(void *data)
+{
+	struct bass_assistant *assistant = data;
+
+	DBG("%p", assistant);
+
+	g_dbus_unregister_interface(btd_get_dbus_connection(),
+				assistant->path, MEDIA_ASSISTANT_INTERFACE);
+}
+
+static void bap_state_src_changed(struct bt_bap_stream *stream,
+				uint8_t old_state, uint8_t new_state,
+				void *user_data)
+{
+	struct bass_data *data = user_data;
+	struct assistant *assistant;
+	struct bt_bap_qos *qos = NULL;
+	struct iovec *base;
+
+	DBG("stream %p: %s(%u) -> %s(%u)", stream,
+			bt_bap_stream_statestr(old_state), old_state,
+			bt_bap_stream_statestr(new_state), new_state);
+
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
+
+		if (!bt_bap_stream_io_get_qos(stream, NULL, &qos)) {
+			error("Unable to read QoS of stream %p", stream);
+			break;
+		}
+
+		bt_bap_parse_base(0x00, base, qos, bass_debug, bis_src_handler,
+					data);
+		data->stream = stream;
+		break;
+	}
+}
+
+static void bap_bc_attached(struct bt_bap *bap, void *user_data)
+{
+	struct btd_adapter *adapter;
+	struct bass_data *data;
+
+	DBG("%p", bap);
+
+	adapter = bt_bap_get_user_data(bap);
+	if (!adapter)
+		return;
+
+	/* Create BASS session with the local Broadcast Source */
+	data = bass_data_new(adapter, NULL);
+	data->state_id = bt_bap_state_register(bap, bap_state_src_changed,
+						NULL, data, NULL);
+}
+
+static void setup_free(void *data)
+{
+	struct bass_setup *setup = data;
+
+	DBG("setup %p", setup);
+
+	util_iov_free(setup->qos.bcast.bcode, 1);
+	util_iov_free(setup->meta, 1);
+	util_iov_free(setup->config, 1);
+	free(setup->path);
+
+	/* Clear bis index from the bis sync bitmask, if it
+	 * has been previously set.
+	 */
+	bt_bass_clear_bis_sync(setup->dg->src, setup->bis);
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
+
+	btd_service_set_user_data(service, NULL);
+}
+
 static void bis_probe(uint8_t sid, uint8_t bis, uint8_t sgrp,
 			struct iovec *caps, struct iovec *meta,
 			struct bt_bap_qos *qos, void *user_data)
@@ -1210,16 +1476,6 @@ static bool assistant_match_device(const void *data, const void *match_data)
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
@@ -1228,11 +1484,13 @@ static void bis_remove(struct bt_bap *bap, void *user_data)
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
@@ -1240,6 +1498,8 @@ static struct bass_data *bass_data_new(struct btd_device *device)
 
 static void bass_data_add(struct bass_data *data)
 {
+	bool initiator = false;
+
 	DBG("data %p", data);
 
 	if (queue_find(sessions, NULL, data)) {
@@ -1254,33 +1514,14 @@ static void bass_data_add(struct bass_data *data)
 
 	queue_push_tail(sessions, data);
 
-	if (data->service) {
-		struct btd_adapter *adapter = device_get_adapter(data->device);
-		bool initiator = btd_service_is_initiator(data->service);
-
+	if (data->service)
 		btd_service_set_user_data(data->service, data);
-		if ((!initiator && btd_adapter_has_settings(adapter,
+
+	if ((!initiator && btd_adapter_has_settings(data->adapter,
 				MGMT_SETTING_PAST_RECEIVER)) || (initiator &&
-				btd_adapter_has_settings(adapter,
+				btd_adapter_has_settings(data->adapter,
 				MGMT_SETTING_PAST_SENDER)))
-			device_set_past_support(data->device, true);
-	}
-}
-
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
+		device_set_past_support(data->device, true);
 }
 
 static void bass_data_free(struct bass_data *data)
@@ -1337,42 +1578,19 @@ static void bass_detached(struct bt_bass *bass, void *user_data)
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
 
@@ -1388,6 +1606,59 @@ probe:
 	 */
 	btd_device_add_uuid(device, BCAAS_UUID_STR);
 
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
+			bt_bass_set_pa_sync(bcast_src, BT_BASS_SYNC_INFO_RE);
+			device = data->device;
+			goto done;
+		}
+
+		bt_bass_set_pa_sync(bcast_src, BT_BASS_NO_PAST);
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
 	return 0;
 }
 
@@ -1570,7 +1841,7 @@ static void bass_attached(struct bt_bass *bass, void *user_data)
 		return;
 	}
 
-	data = bass_data_new(device);
+	data = bass_data_new(device_get_adapter(device), device);
 	data->bass = bass;
 
 	data->cp_id = bt_bass_cp_handler_register(data->bass,
@@ -1612,8 +1883,8 @@ static void bass_handle_bcode_req(struct bass_assistant *assistant, int id)
 	free(iov.iov_base);
 }
 
-static void bass_src_changed(uint8_t id, uint32_t bid, uint8_t enc,
-					uint32_t bis_sync, void *user_data)
+static void bass_src_changed(uint8_t id, uint32_t bid, uint8_t state,
+				uint8_t enc, uint32_t bis_sync, void *user_data)
 {
 	const struct queue_entry *entry;
 
@@ -1622,15 +1893,27 @@ static void bass_src_changed(uint8_t id, uint32_t bid, uint8_t enc,
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
@@ -1686,7 +1969,7 @@ static int bass_probe(struct btd_service *service)
 		return -EINVAL;
 	}
 
-	data = bass_data_new(device);
+	data = bass_data_new(adapter, device);
 	data->service = service;
 
 	data->bass = bt_bass_new(btd_gatt_database_get_db(database),
@@ -1815,7 +2098,8 @@ static int bass_init(void)
 		return err;
 
 	bass_id = bt_bass_register(bass_attached, bass_detached, NULL);
-	bap_id = bt_bap_register(bap_attached, NULL, bap_detached, NULL);
+	bap_id = bt_bap_register(bap_attached, bap_bc_attached, bap_detached,
+				NULL);
 
 	return 0;
 }
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

