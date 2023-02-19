Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE3DC05027
	for <linux-bluetooth@archiver.kernel.org>; Sun, 19 Feb 2023 18:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjBSSCM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 19 Feb 2023 13:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjBSSCL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 19 Feb 2023 13:02:11 -0500
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44F713D55
        for <linux-bluetooth@vger.kernel.org>; Sun, 19 Feb 2023 10:02:08 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 5A10A24016D
        for <linux-bluetooth@vger.kernel.org>; Sun, 19 Feb 2023 19:02:07 +0100 (CET)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4PKYKV51jvz9rxF;
        Sun, 19 Feb 2023 19:02:06 +0100 (CET)
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] audio/transport: update BAP transport QOS values when changed
Date:   Sun, 19 Feb 2023 18:02:03 +0000
Message-Id: <f37329b52b85e536b8db17c0fa5e349578fff286.1676829559.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Currently, BAP transport publishes on DBus QOS values obtained at
transport creation time. For BAP server the transport creation usually
occurs before stream QOS is configured, and these values are then all
zero. bap->sdu is also never set.

Update transport QOS values in DBus when stream state changes.  Since
nearly all QOS values are exposed in the transport, use bt_bap_qos to
store them there for simplicity.
---
 profiles/audio/transport.c | 62 ++++++++++++++++++++++++++------------
 1 file changed, 43 insertions(+), 19 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 912f404e8..457590746 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -84,13 +84,7 @@ struct bap_transport {
 	struct bt_bap_stream	*stream;
 	unsigned int		state_id;
 	bool			linked;
-	uint32_t		interval;
-	uint8_t			framing;
-	uint8_t			phy;
-	uint16_t		sdu;
-	uint8_t			rtn;
-	uint16_t		latency;
-	uint32_t		delay;
+	struct bt_bap_qos	qos;
 };
 
 struct media_transport {
@@ -823,7 +817,8 @@ static gboolean get_interval(const GDBusPropertyTable *property,
 	struct media_transport *transport = data;
 	struct bap_transport *bap = transport->data;
 
-	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT32, &bap->interval);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT32,
+							&bap->qos.interval);
 
 	return TRUE;
 }
@@ -833,7 +828,7 @@ static gboolean get_framing(const GDBusPropertyTable *property,
 {
 	struct media_transport *transport = data;
 	struct bap_transport *bap = transport->data;
-	dbus_bool_t val = bap->framing;
+	dbus_bool_t val = bap->qos.framing;
 
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &val);
 
@@ -846,7 +841,7 @@ static gboolean get_sdu(const GDBusPropertyTable *property,
 	struct media_transport *transport = data;
 	struct bap_transport *bap = transport->data;
 
-	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16, &bap->sdu);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16, &bap->qos.sdu);
 
 	return TRUE;
 }
@@ -857,7 +852,7 @@ static gboolean get_retransmissions(const GDBusPropertyTable *property,
 	struct media_transport *transport = data;
 	struct bap_transport *bap = transport->data;
 
-	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE, &bap->rtn);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE, &bap->qos.rtn);
 
 	return TRUE;
 }
@@ -868,7 +863,8 @@ static gboolean get_latency(const GDBusPropertyTable *property,
 	struct media_transport *transport = data;
 	struct bap_transport *bap = transport->data;
 
-	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16, &bap->latency);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16,
+							&bap->qos.latency);
 
 	return TRUE;
 }
@@ -879,7 +875,7 @@ static gboolean get_delay(const GDBusPropertyTable *property,
 	struct media_transport *transport = data;
 	struct bap_transport *bap = transport->data;
 
-	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT32, &bap->delay);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT32, &bap->qos.delay);
 
 	return TRUE;
 }
@@ -1183,6 +1179,38 @@ static void bap_update_links(const struct media_transport *transport)
 	DBG("stream %p linked %s", bap->stream, bap->linked ? "true" : "false");
 }
 
+static void bap_update_qos(const struct media_transport *transport)
+{
+	struct bap_transport *bap = transport->data;
+	struct bt_bap_qos *qos;
+
+	qos = bt_bap_stream_get_qos(bap->stream);
+
+	if (!memcmp(qos, &bap->qos, sizeof(struct bt_bap_qos)))
+		return;
+
+	bap->qos = *qos;
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			transport->path, MEDIA_TRANSPORT_INTERFACE,
+			"Interval");
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			transport->path, MEDIA_TRANSPORT_INTERFACE,
+			"Framing");
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			transport->path, MEDIA_TRANSPORT_INTERFACE,
+			"SDU");
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			transport->path, MEDIA_TRANSPORT_INTERFACE,
+			"Retransmissions");
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			transport->path, MEDIA_TRANSPORT_INTERFACE,
+			"Latency");
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			transport->path, MEDIA_TRANSPORT_INTERFACE,
+			"Delay");
+}
+
 static guint resume_bap(struct media_transport *transport,
 				struct media_owner *owner)
 {
@@ -1327,6 +1355,7 @@ static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 		if (owner && owner->pending)
 			return;
 		bap_update_links(transport);
+		bap_update_qos(transport);
 		transport_update_playing(transport, FALSE);
 		return;
 	case BT_BAP_STREAM_STATE_DISABLING:
@@ -1408,12 +1437,7 @@ static int media_transport_init_bap(struct media_transport *transport,
 
 	bap = new0(struct bap_transport, 1);
 	bap->stream = stream;
-	bap->interval = qos->interval;
-	bap->framing = qos->framing;
-	bap->phy = qos->phy;
-	bap->rtn = qos->rtn;
-	bap->latency = qos->latency;
-	bap->delay = qos->delay;
+	bap->qos = *qos;
 	bap->state_id = bt_bap_state_register(bt_bap_stream_get_session(stream),
 						bap_state_changed,
 						bap_connecting,
-- 
2.39.2

