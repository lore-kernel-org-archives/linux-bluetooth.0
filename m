Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91BE3DEFF5
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2026 10:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776940784; cv=none; b=FUOaWPQhYlmfpzTSI8n5f205OD+sakHuTU78T+H19GxMhvxu5oHfsyXzyHE6fG9294UyWxdneVLopcS3VyrRX2ZS7W+hs4SgWvdWT2RwqTa3BT/2fW8r9vTx9DU12bBJ1MO4NDS1MJaqV6COPTWgwBip83AooMilx+RpkQugmdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776940784; c=relaxed/simple;
	bh=6S+kDSOAlLPy7x1vzex8ZmlhY7dQkSRq/7t2mHPwDwg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ripz3kG9PGMt5WZeDYbr5FvvmwJolLfWgmaB6H0EtAfyZ/njuKV/pU49vAq8wTDWcfr1fyPuYewbYxWlWDWIUSlTg4y5BB2o0/31oL8UDcLrs+vjsE9O4qYogxYt6HgXLwIqwU9RgKAZ6lFmZJEbHYcOQWClD6JWA5fn5uiNJhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QKW4gxXf; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QKW4gxXf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1776940780;
	bh=6S+kDSOAlLPy7x1vzex8ZmlhY7dQkSRq/7t2mHPwDwg=;
	h=From:To:Subject:Date:From;
	b=QKW4gxXfjHABnL9cP2CWboOmXdTXLnYkC8sLRKgu7c38FtOAE5zj9xI1nlKvmY4Dy
	 hMOTCCEqLdNvmBTTylmIZbc4IDkWOFlbSLv2L0nd4Enlw5eWbiTjWwKD10Ui3L7BFQ
	 o2mPKbtlBXvXNVX4LlyYi4hknFqUk2/hC8XFKfxnwEwlWzXd2H/dGK0ibzds8rYswJ
	 pEix10P5f1WGRNo6hyumTro+qGHJyF2jCjd0F1zR9BEblZLYFuiUFBNA4kSUUmOAOy
	 14C7AxVbleV6Dd6vr/7/27qMVaJhG7DysoQ6P5rqg4sxAit+zEvGf1lniqyqw8Ab5W
	 RnhlFqwaJVY/A==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D528117E131F
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2026 12:39:39 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 1/3] audio: Add ability to force CIS transport Links property
Date: Thu, 23 Apr 2026 12:39:32 +0200
Message-ID: <20260423103934.22799-1-frederic.danis@collabora.com>
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
v1 -> v2:
  - Add testing mode check in bap_connect_io_cb()
  - Replace stream state check by checking that the stream is not linked
    before passing the connect event to all streams belonging to same
    CIG/CIS.
v2 -> v3: Fix Lint errors

 profiles/audio/bap.c       | 49 ++++++++++++++++++++++++++++++++
 profiles/audio/transport.c | 57 +++++++++++++++++++++++++++++++-------
 2 files changed, 96 insertions(+), 10 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 5333267f7..8a953d80f 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -2655,13 +2655,62 @@ static void bap_connect_bcast_io_cb(GIOChannel *chan, GError *err,
 	iso_connect_bcast_cb(chan, err, setup->stream);
 }
 
+struct connect_io_data {
+	GIOChannel *chan;
+	GError *err;
+	uint8_t cig_id;
+	uint8_t cis_id;
+};
+
+static void connect_stream(void *data, void *user_data)
+{
+	struct bap_setup *setup = data;
+	struct connect_io_data *d = user_data;
+	uint8_t state;
+
+	/* Check stream state to only pass the connect event managed
+	 * by bap_stream_set_io()
+	 */
+	state = bt_bap_stream_get_state(setup->stream);
+	if ((state == BT_BAP_STREAM_STATE_ENABLING ||
+			state == BT_BAP_STREAM_STATE_DISABLING) &&
+			setup->qos.ucast.cig_id == d->cig_id &&
+			setup->qos.ucast.cis_id == d->cis_id)
+		iso_connect_cb(d->chan, d->err, setup->stream);
+}
+
+static void connect_ep(void *data, void *user_data)
+{
+	struct bap_ep *ep = data;
+
+	if (ep->setups)
+		queue_foreach(ep->setups, connect_stream, user_data);
+}
+
 static void bap_connect_io_cb(GIOChannel *chan, GError *err, gpointer user_data)
 {
 	struct bap_setup *setup = user_data;
+	struct connect_io_data data;
 
 	if (!setup->stream)
 		return;
 
+	if (queue_isempty(bt_bap_stream_io_get_links(setup->stream)) &&
+		btd_opts.testing) {
+		/* The stream may have manually been unliked for PTS tests,
+		 * e.g. BAP/UCL/STR/BV-543-C or BAP/UCL/STR/BV-546-C,
+		 * in this case send the connect event to all streams
+		 * belonging to the same CIG/CIS.
+		 */
+		data.chan = chan;
+		data.err = err;
+		data.cig_id = setup->qos.ucast.cig_id;
+		data.cis_id = setup->qos.ucast.cis_id;
+		queue_foreach(setup->ep->data->snks, connect_ep, &data);
+		queue_foreach(setup->ep->data->srcs, connect_ep, &data);
+		return;
+	}
+
 	iso_connect_cb(chan, err, setup->stream);
 }
 
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 5c2a2777e..b6a5dd1fd 100644
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
@@ -1419,6 +1421,9 @@ static struct media_transport *find_transport_by_path(const char *path)
 	return NULL;
 }
 
+static void bap_update_links(const struct media_transport *transport);
+static void transport_unlink(void *data, void *user_data);
+
 static void set_links(const GDBusPropertyTable *property,
 				DBusMessageIter *iter,
 				GDBusPendingPropertySet id, void *user_data)
@@ -1436,6 +1441,16 @@ static void set_links(const GDBusPropertyTable *property,
 
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
@@ -1486,6 +1501,21 @@ static const GDBusPropertyTable transport_bap_uc_properties[] = {
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
@@ -1884,8 +1914,6 @@ static void bap_resume_complete(struct media_transport *transport)
 	transport_set_state(transport, TRANSPORT_STATE_ACTIVE);
 }
 
-static void bap_update_links(const struct media_transport *transport);
-
 static bool match_link_transport(const void *data, const void *user_data)
 {
 	const struct bt_bap_stream *stream = data;
@@ -2540,10 +2568,11 @@ static void *transport_asha_init(struct media_transport *transport, void *data)
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
@@ -2565,26 +2594,28 @@ static void *transport_asha_init(struct media_transport *transport, void *data)
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
@@ -2592,7 +2623,7 @@ static void *transport_asha_init(struct media_transport *transport, void *data)
 			transport_asha_resume, transport_asha_suspend, \
 			transport_asha_cancel, NULL, NULL, \
 			transport_asha_get_volume, transport_asha_set_volume, \
-			NULL, NULL, NULL)
+			NULL, NULL, NULL, NULL)
 
 static const struct media_transport_ops transport_ops[] = {
 #ifdef HAVE_A2DP
@@ -2647,6 +2678,7 @@ struct media_transport *media_transport_create(struct btd_device *device,
 	struct media_transport *transport;
 	const struct media_transport_ops *ops;
 	int fd;
+	const GDBusPropertyTable *properties;
 
 	transport = g_new0(struct media_transport, 1);
 	if (device)
@@ -2701,9 +2733,14 @@ struct media_transport *media_transport_create(struct btd_device *device,
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

