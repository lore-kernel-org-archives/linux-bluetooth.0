Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F54332638
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 08:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777363445; cv=none; b=Hzyi89/VFcs3HsYxP0pSvVPblBTXPyKWLhB0npbTK4iRJVXaD5kCmsH+T+GLBM8NRdxhTyTpwMtQz/62rDmeu8owr3i+E78Elj627RGpi2sh97LXd9E3dScgqwJ8moW/4ZhUlMWXJoZQ2WWGYssXm5IGpVXL9nxgz+R7LVXeOfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777363445; c=relaxed/simple;
	bh=3eFIboFxXFRDnkpuHJySKtHqNHdzjwkSBCF8yF5dnis=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=agXFtvXpfWlkV9pBCVLiTz46fZxj8sYARUvTSZAQqLpfeICfIN/vGXnV8nNOnbZMzTXMnDuYLhPb2gbygOyzDF6+nSqoo4fXWuN+I1sHrH44ip66Ezpz0oMpwucoOnfX6DWh9Bf6KSTvbj46LUY5aWQ24QiXkaiiAMVTBuxLTio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lsqfjM+Q; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lsqfjM+Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1777363436;
	bh=3eFIboFxXFRDnkpuHJySKtHqNHdzjwkSBCF8yF5dnis=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=lsqfjM+QJ2wRl9eYcZfGWSipooCdfXywhxN108ACis1Tlqy+t9lLGdszMbAcxzdFM
	 CLsLTNT8Dp+G8pzCuiPCGEceTIHmV4vS7c7QKvqK+N2F2cB4jLoSRM+SYT9p0eU+ge
	 reqsYnCrf3Pblj3gWp5EIcOISMS1XAC0P9iegFFGFWROjHRIx8xoMVzoGGXxkYtD6x
	 h7Z6GBj++T9V91hm0yfKzgke3qgbV83Hcfzffje93hrKjEzSbygm5qXfwZU8MzZkPf
	 aPS3/Qmlqhs+enL5lJKA1RvTg1oH0cBVlCpvNjNbsNFglkDcHvPigqPDqXmzLdGUIl
	 yckFaahuM4Qag==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E1AD417E131F
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 10:03:55 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/3] audio: Add ability to desynchronized linked transport
Date: Tue, 28 Apr 2026 10:03:12 +0200
Message-ID: <20260428080314.180777-2-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260428080314.180777-1-frederic.danis@collabora.com>
References: <20260428080314.180777-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

If bluetoothd is started in testing mode a new Desynchronized property
is added, allowing to prevent automatic acquire of linked transport
objects.

When desynchronized, each transports needs to be acquired separately.

This allows to pass PTS tests BAP/UCL/STR/BV-543-C and BV-546-C.
---
v1->v2: renamed 'desynchronized' to 'desync'

 profiles/audio/transport.c | 116 ++++++++++++++++++++++++++++++++-----
 1 file changed, 103 insertions(+), 13 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 5c2a2777e..39e49ea49 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -37,6 +37,7 @@
 #include "src/shared/bap.h"
 #include "src/shared/bass.h"
 #include "src/shared/io.h"
+#include "src/btd.h"
 
 #ifdef HAVE_A2DP
 #include "avdtp.h"
@@ -109,11 +110,18 @@ struct bap_transport {
 	guint			resume_id;
 	struct iovec		*meta;
 	guint			chan_id;
+	bool			desync;
+		/* desync variable is only writable when testing is enabled;
+		 * otherwise, it defaults to false, meaning the Enable/Acquire
+		 * operations synchronize input/output directions that share
+		 * the same ISO socket CID/CIG.
+		 */
 };
 
 struct media_transport_ops {
 	const char *uuid;
 	const GDBusPropertyTable *properties;
+	const GDBusPropertyTable *test_properties;
 	void (*set_owner)(struct media_transport *transport,
 				struct media_owner *owner);
 	void (*remove_owner)(struct media_transport *transport,
@@ -351,7 +359,7 @@ static void transport_bap_remove_owner(struct media_transport *transport,
 {
 	struct bap_transport *bap = transport->data;
 
-	if (bap && bap->linked)
+	if (bap && bap->linked && !bap->desync)
 		queue_foreach(bt_bap_stream_io_get_links(bap->stream),
 				linked_transport_remove_owner, owner);
 }
@@ -729,7 +737,7 @@ static void transport_bap_set_owner(struct media_transport *transport,
 {
 	struct bap_transport *bap = transport->data;
 
-	if (bap && bap->linked)
+	if (bap && bap->linked && !bap->desync)
 		queue_foreach(bt_bap_stream_io_get_links(bap->stream),
 				linked_transport_set_owner, owner);
 }
@@ -1463,6 +1471,59 @@ static void set_links(const GDBusPropertyTable *property,
 	g_dbus_pending_property_success(id);
 }
 
+static gboolean get_desync(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_transport *transport = data;
+	struct bap_transport *bap = transport->data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &bap->desync);
+
+	return TRUE;
+}
+
+static void transport_desynchronize(void *data, void *user_data)
+{
+	struct bt_bap_stream *link = data;
+	bool desync = PTR_TO_UINT(user_data);
+	struct media_transport *transport;
+	struct bap_transport *bap;
+
+	transport = find_transport_by_bap_stream(link);
+	bap = transport->data;
+	bap->desync = desync;
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), transport->path,
+						MEDIA_TRANSPORT_INTERFACE,
+						"Desynchronized");
+}
+
+static void set_desync(const GDBusPropertyTable *property,
+			DBusMessageIter *iter, GDBusPendingPropertySet id,
+			void *data)
+{
+	struct media_transport *transport = data;
+	struct bap_transport *bap = transport->data;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_BOOLEAN) {
+		g_dbus_pending_property_error(id,
+				ERROR_INTERFACE ".InvalidArguments",
+				"Expected BOOLEAN");
+		return;
+	}
+
+	dbus_message_iter_get_basic(iter, &bap->desync);
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), transport->path,
+						MEDIA_TRANSPORT_INTERFACE,
+						"Desynchronized");
+
+	/* Set desynchronized for all the links */
+	queue_foreach(bt_bap_stream_io_get_links(bap->stream),
+					transport_desynchronize,
+					UINT_TO_PTR(bap->desync));
+
+	g_dbus_pending_property_success(id);
+}
+
 static gboolean qos_ucast_exists(const GDBusPropertyTable *property, void *data)
 {
 	struct media_transport *transport = data;
@@ -1486,6 +1547,22 @@ static const GDBusPropertyTable transport_bap_uc_properties[] = {
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
+	{ "Links", "ao", get_links, NULL, links_exists },
+	{ "Volume", "q", get_volume, set_volume, volume_exists },
+	{ "Desynchronized", "b", get_desync, set_desync, links_exists},
+	{ }
+};
+
 static gboolean get_bcast_qos(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
@@ -1920,6 +1997,9 @@ static void transport_bap_update_links_uc(
 	g_dbus_emit_property_changed(btd_get_dbus_connection(), transport->path,
 						MEDIA_TRANSPORT_INTERFACE,
 						"Links");
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), transport->path,
+						MEDIA_TRANSPORT_INTERFACE,
+						"Desynchronized");
 
 	DBG("stream %p linked %s", bap->stream, bap->linked ? "true" : "false");
 }
@@ -2037,8 +2117,9 @@ static guint transport_bap_resume(struct media_transport *transport,
 		return bap->resume_id;
 	}
 
-	id = bt_bap_stream_enable(bap->stream, bap->linked, NULL,
-					bap_enable_complete, owner);
+	id = bt_bap_stream_enable(bap->stream,
+				bap->desync ? false : bap->linked,
+				NULL, bap_enable_complete, owner);
 	if (!id)
 		return 0;
 
@@ -2161,7 +2242,7 @@ static void transport_bap_set_state(struct media_transport *transport,
 {
 	struct bap_transport *bap = transport->data;
 
-	if (!bap->linked)
+	if (!bap->linked || bap->desync)
 		return;
 
 	/* Update links */
@@ -2540,10 +2621,11 @@ static void *transport_asha_init(struct media_transport *transport, void *data)
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
@@ -2565,26 +2647,28 @@ static void *transport_asha_init(struct media_transport *transport, void *data)
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
@@ -2592,7 +2676,7 @@ static void *transport_asha_init(struct media_transport *transport, void *data)
 			transport_asha_resume, transport_asha_suspend, \
 			transport_asha_cancel, NULL, NULL, \
 			transport_asha_get_volume, transport_asha_set_volume, \
-			NULL, NULL, NULL)
+			NULL, NULL, NULL, NULL)
 
 static const struct media_transport_ops transport_ops[] = {
 #ifdef HAVE_A2DP
@@ -2647,6 +2731,7 @@ struct media_transport *media_transport_create(struct btd_device *device,
 	struct media_transport *transport;
 	const struct media_transport_ops *ops;
 	int fd;
+	const GDBusPropertyTable *properties;
 
 	transport = g_new0(struct media_transport, 1);
 	if (device)
@@ -2701,9 +2786,14 @@ struct media_transport *media_transport_create(struct btd_device *device,
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

