Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BA333B945
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2026 16:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776701633; cv=none; b=IFUEtLtQH52tVGcVL9xNZJAQaldpuUNhblsITZGjPCQSA4F0RCsxPlwlJQBHQ0822pmTUq3t8YIOk3z5tudQ2+HO02MPCQxSGKnWmQdcjqtgq86Tse1k0klkDwjZBQAfTN0kIoe+olBkfOWgqbmbODe4rj8CgruHFv7+HIxA9dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776701633; c=relaxed/simple;
	bh=64/hxrIecjlzDqW/TYfqCIweUbLh8Ejo6chPEABK1Ys=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gKM9cvUq+Lnp0wl9gNEvZNYW1MS+0zlOxVUce+lWl4G+w4loTVLK/Yv55bfYtrVwojThWllQovjMYXwmfRhimpNOxY0n4I0IAWtSQPlAY2Xm80Y58AoabRrOy8HP4eOosK9r+aSypzOGmgXjsLvcn1yEcEuBx/lXKdqmDPjBtK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lwLz/D3E; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lwLz/D3E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1776701630;
	bh=64/hxrIecjlzDqW/TYfqCIweUbLh8Ejo6chPEABK1Ys=;
	h=From:To:Subject:Date:From;
	b=lwLz/D3Edw2ez63V+jCHiYtNSyTH+E5Bo1CQtVOqbpRmXDAPuSEtd4nsRiIr4WodI
	 HzT059Wh1NS7xsdzI+H7Ji27r+jQnfJ9NB2CZtp8oJs99mWbVAhK8DSrv6AAaEVWg/
	 reQ0E2L3XN9cyMpvAoLVj7uMLU31SWbjNq9G5jmnYSnnjhvzUbA308eetVWO0oeicM
	 ak/WTYt1W48NndQY2hxtdgFpZ9dNa1R9U1b8bfxAbEYEvyiF43omfaDNoKQGr6ezGR
	 BhaeKo3lvaUbJwFvKAz24OidJW8ToQkL4THtN9L/QvT7Sp1dKKSasTFMBFzl6aIC7X
	 g5qUcI0QlbFBw==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3D8E617E140F
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2026 18:13:50 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/3] audio: Add ability to force CIS transport Links property
Date: Mon, 20 Apr 2026 18:13:43 +0200
Message-ID: <20260420161345.145089-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

If bluetoothd is started in testing mode the Links property for CIS
is readwrite and can be used to force transport objects Links.
This can used to unlink transport objects by sending an empty array.

For unlinked transport objects, each transports needs to be acquired
separately.

This allows to pass PTS tests BAP/UCL/STR/BV-543-C and BV-546-C.
---
 profiles/audio/bap.c       | 44 +++++++++++++++++++++++++++++
 profiles/audio/transport.c | 57 +++++++++++++++++++++++++++++++-------
 2 files changed, 91 insertions(+), 10 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 375026440..8f1f75240 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -2651,13 +2651,57 @@ static void bap_connect_bcast_io_cb(GIOChannel *chan, GError *err,
 	iso_connect_bcast_cb(chan, err, setup->stream);
 }
 
+struct connect_io_data {
+	GIOChannel *chan;
+	GError *err;
+	uint8_t cig_id;
+};
+
+static bool find_enabling_stream(const void *data, const void *match_data)
+{
+	const struct bap_setup *setup = data;
+	const struct connect_io_data *d = match_data;
+	uint8_t state;
+
+	state = bt_bap_stream_get_state(setup->stream);
+	if (state == BT_BAP_STREAM_STATE_ENABLING &&
+			setup->qos.ucast.cig_id == d->cig_id)
+		iso_connect_cb(d->chan, d->err, setup->stream);
+
+	return false;
+}
+
+static bool find_enabling_ep(const void *data, const void *match_data)
+{
+	const struct bap_ep *ep = data;
+
+	if (ep->setups)
+		queue_find(ep->setups, find_enabling_stream, match_data);
+
+	return false;
+}
+
 static void bap_connect_io_cb(GIOChannel *chan, GError *err, gpointer user_data)
 {
 	struct bap_setup *setup = user_data;
+	struct connect_io_data data;
 
 	if (!setup->stream)
 		return;
 
+	if (bt_bap_stream_get_state(setup->stream) !=
+			 BT_BAP_STREAM_STATE_ENABLING) {
+		/* The stream may have manually been unliked for tests and the
+		 * connect event refers to another stream of the CIG.
+		 */
+		data.chan = chan;
+		data.err = err;
+		data.cig_id = setup->qos.ucast.cig_id;
+		queue_find(setup->ep->data->snks, find_enabling_ep, &data);
+		queue_find(setup->ep->data->srcs, find_enabling_ep, &data);
+		return;
+	}
+
 	iso_connect_cb(chan, err, setup->stream);
 }
 
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index d9feef768..794c492af 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -37,6 +37,7 @@
 #include "src/shared/bap.h"
 #include "src/shared/bass.h"
 #include "src/shared/io.h"
+#include "src/btd.h"
 
 #ifdef HAVE_A2DP
 #include "avdtp.h"
@@ -114,6 +115,7 @@ struct bap_transport {
 struct media_transport_ops {
 	const char *uuid;
 	const GDBusPropertyTable *properties;
+	const GDBusPropertyTable *test_properties;
 	void (*set_owner)(struct media_transport *transport,
 				struct media_owner *owner);
 	void (*remove_owner)(struct media_transport *transport,
@@ -1417,6 +1419,9 @@ static struct media_transport *find_transport_by_path(const char *path)
 	return NULL;
 }
 
+static void bap_update_links(const struct media_transport *transport);
+static void transport_unlink(void *data, void *user_data);
+
 static void set_links(const GDBusPropertyTable *property,
 				DBusMessageIter *iter,
 				GDBusPendingPropertySet id, void *user_data)
@@ -1434,6 +1439,16 @@ static void set_links(const GDBusPropertyTable *property,
 
 	dbus_message_iter_recurse(iter, &array);
 
+	if (dbus_message_iter_get_arg_type(&array) == DBUS_TYPE_INVALID) {
+		struct queue *links = bt_bap_stream_io_get_links(bap->stream);
+
+		/* Unlink stream from all its links */
+		queue_foreach(links, transport_unlink, bap->stream);
+
+		bt_bap_stream_io_unlink(bap->stream, NULL);
+		bap_update_links(transport);
+	}
+
 	while (dbus_message_iter_get_arg_type(&array) ==
 						DBUS_TYPE_OBJECT_PATH) {
 		struct media_transport *link;
@@ -1484,6 +1499,21 @@ static const GDBusPropertyTable transport_bap_uc_properties[] = {
 	{ }
 };
 
+static const GDBusPropertyTable transport_bap_uc_test_properties[] = {
+	{ "Device", "o", get_device },
+	{ "UUID", "s", get_uuid },
+	{ "Codec", "y", get_codec },
+	{ "Configuration", "ay", get_configuration },
+	{ "State", "s", get_state },
+	{ "QoS", "a{sv}", get_ucast_qos, NULL, qos_ucast_exists },
+	{ "Endpoint", "o", get_endpoint, NULL, endpoint_exists },
+	{ "Location", "u", get_location },
+	{ "Metadata", "ay", get_metadata, set_metadata },
+	{ "Links", "ao", get_links, set_links, links_exists },
+	{ "Volume", "q", get_volume, set_volume, volume_exists },
+	{ }
+};
+
 static gboolean get_bcast_qos(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
@@ -1879,8 +1909,6 @@ static void bap_resume_complete(struct media_transport *transport)
 	transport_set_state(transport, TRANSPORT_STATE_ACTIVE);
 }
 
-static void bap_update_links(const struct media_transport *transport);
-
 static bool match_link_transport(const void *data, const void *user_data)
 {
 	const struct bt_bap_stream *stream = data;
@@ -2535,10 +2563,11 @@ static void *transport_asha_init(struct media_transport *transport, void *data)
 #define TRANSPORT_OPS(_uuid, _props, _set_owner, _remove_owner, _init, \
 		      _resume, _suspend, _cancel, _set_state, _get_stream, \
 		      _get_volume, _set_volume, _set_delay, _update_links, \
-		      _destroy) \
+		      _destroy, _test_props) \
 { \
 	.uuid = _uuid, \
 	.properties = _props, \
+	.test_properties = _test_props, \
 	.set_owner = _set_owner, \
 	.remove_owner = _remove_owner, \
 	.init = _init, \
@@ -2560,26 +2589,28 @@ static void *transport_asha_init(struct media_transport *transport, void *data)
 			transport_a2dp_resume, transport_a2dp_suspend, \
 			transport_a2dp_cancel, NULL, \
 			transport_a2dp_get_stream, transport_a2dp_get_volume, \
-			_set_volume, _set_delay, NULL, _destroy)
+			_set_volume, _set_delay, NULL, _destroy, NULL)
 
 #define BAP_OPS(_uuid, _props, _set_owner, _remove_owner, _update_links, \
-		_set_state) \
+		_set_state, _test_props) \
 	TRANSPORT_OPS(_uuid, _props, _set_owner, _remove_owner,\
 			transport_bap_init, \
 			transport_bap_resume, transport_bap_suspend, \
 			transport_bap_cancel, _set_state, \
 			transport_bap_get_stream, transport_bap_get_volume, \
 			transport_bap_set_volume, NULL, \
-			_update_links, transport_bap_destroy)
+			_update_links, transport_bap_destroy, _test_props)
 
 #define BAP_UC_OPS(_uuid) \
 	BAP_OPS(_uuid, transport_bap_uc_properties, \
 			transport_bap_set_owner, transport_bap_remove_owner, \
-			transport_bap_update_links_uc, transport_bap_set_state)
+			transport_bap_update_links_uc, \
+			transport_bap_set_state, \
+			transport_bap_uc_test_properties)
 
 #define BAP_BC_OPS(_uuid) \
 	BAP_OPS(_uuid, transport_bap_bc_properties, NULL, NULL, \
-			transport_bap_update_links_bc, NULL)
+			transport_bap_update_links_bc, NULL, NULL)
 
 #define ASHA_OPS(_uuid) \
 	TRANSPORT_OPS(_uuid, transport_asha_properties, NULL, NULL, \
@@ -2587,7 +2618,7 @@ static void *transport_asha_init(struct media_transport *transport, void *data)
 			transport_asha_resume, transport_asha_suspend, \
 			transport_asha_cancel, NULL, NULL, \
 			transport_asha_get_volume, transport_asha_set_volume, \
-			NULL, NULL, NULL)
+			NULL, NULL, NULL, NULL)
 
 static const struct media_transport_ops transport_ops[] = {
 #ifdef HAVE_A2DP
@@ -2642,6 +2673,7 @@ struct media_transport *media_transport_create(struct btd_device *device,
 	struct media_transport *transport;
 	const struct media_transport_ops *ops;
 	int fd;
+	const GDBusPropertyTable *properties;
 
 	transport = g_new0(struct media_transport, 1);
 	if (device)
@@ -2696,9 +2728,14 @@ struct media_transport *media_transport_create(struct btd_device *device,
 			goto fail;
 	}
 
+	if (btd_opts.testing && ops->test_properties)
+		properties = ops->test_properties;
+	else
+		properties = ops->properties;
+
 	if (g_dbus_register_interface(btd_get_dbus_connection(),
 				transport->path, MEDIA_TRANSPORT_INTERFACE,
-				transport_methods, NULL, ops->properties,
+				transport_methods, NULL, properties,
 				transport, media_transport_free) == FALSE) {
 		error("Could not register transport %s", transport->path);
 		goto fail;
-- 
2.43.0

