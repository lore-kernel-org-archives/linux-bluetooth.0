Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F6F8C74A5B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Mar 2023 17:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbjCORyI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Mar 2023 13:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbjCORyC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Mar 2023 13:54:02 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D55420040
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Mar 2023 10:53:57 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 532A2240710
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Mar 2023 18:53:55 +0100 (CET)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4PcJ0y4HY3z6tnF;
        Wed, 15 Mar 2023 18:53:54 +0100 (CET)
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 1/2] transport: add CIG/CIS/PHY properties, don't show unset QoS properties
Date:   Wed, 15 Mar 2023 17:53:51 +0000
Message-Id: <e856ad3174024bb61113217cb889005a0bf0ad1c.1678902782.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add CIG, CIS, and PHY properties to BAP transport.  The other QoS
properties are there, and these may also be useful to clients, e.g.  to
manage CIG/CIS allocation as client.

Hide transport QoS properties when they are not configured.
---
 profiles/audio/transport.c | 67 ++++++++++++++++++++++++++++++++++----
 1 file changed, 61 insertions(+), 6 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 457590746..53bf13175 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -811,6 +811,38 @@ static const GDBusPropertyTable a2dp_properties[] = {
 	{ }
 };
 
+static gboolean qos_exists(const GDBusPropertyTable *property, void *data)
+{
+	struct media_transport *transport = data;
+	struct bap_transport *bap = transport->data;
+
+	return bap->qos.phy != 0x00;
+}
+
+static gboolean get_cig(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_transport *transport = data;
+	struct bap_transport *bap = transport->data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
+							&bap->qos.cig_id);
+
+	return TRUE;
+}
+
+static gboolean get_cis(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_transport *transport = data;
+	struct bap_transport *bap = transport->data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
+							&bap->qos.cis_id);
+
+	return TRUE;
+}
+
 static gboolean get_interval(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
@@ -835,6 +867,17 @@ static gboolean get_framing(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean get_phy(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_transport *transport = data;
+	struct bap_transport *bap = transport->data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE, &bap->qos.phy);
+
+	return TRUE;
+}
+
 static gboolean get_sdu(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
@@ -962,12 +1005,15 @@ static const GDBusPropertyTable bap_properties[] = {
 	{ "Codec", "y", get_codec },
 	{ "Configuration", "ay", get_configuration },
 	{ "State", "s", get_state },
-	{ "Interval", "u", get_interval },
-	{ "Framing", "b", get_framing },
-	{ "SDU", "q", get_sdu },
-	{ "Retransmissions", "y", get_retransmissions },
-	{ "Latency", "q", get_latency },
-	{ "Delay", "u", get_delay },
+	{ "CIG", "y", get_cig, NULL, qos_exists },
+	{ "CIS", "y", get_cis, NULL, qos_exists },
+	{ "Interval", "u", get_interval, NULL, qos_exists },
+	{ "Framing", "b", get_framing, NULL, qos_exists },
+	{ "PHY", "y", get_phy, NULL, qos_exists },
+	{ "SDU", "q", get_sdu, NULL, qos_exists },
+	{ "Retransmissions", "y", get_retransmissions, NULL, qos_exists },
+	{ "Latency", "q", get_latency, NULL, qos_exists },
+	{ "Delay", "u", get_delay, NULL, qos_exists },
 	{ "Endpoint", "o", get_endpoint, NULL, endpoint_exists },
 	{ "Location", "u", get_location },
 	{ "Metadata", "ay", get_metadata },
@@ -1191,12 +1237,21 @@ static void bap_update_qos(const struct media_transport *transport)
 
 	bap->qos = *qos;
 
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			transport->path, MEDIA_TRANSPORT_INTERFACE,
+			"CIG");
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			transport->path, MEDIA_TRANSPORT_INTERFACE,
+			"CIS");
 	g_dbus_emit_property_changed(btd_get_dbus_connection(),
 			transport->path, MEDIA_TRANSPORT_INTERFACE,
 			"Interval");
 	g_dbus_emit_property_changed(btd_get_dbus_connection(),
 			transport->path, MEDIA_TRANSPORT_INTERFACE,
 			"Framing");
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			transport->path, MEDIA_TRANSPORT_INTERFACE,
+			"PHY");
 	g_dbus_emit_property_changed(btd_get_dbus_connection(),
 			transport->path, MEDIA_TRANSPORT_INTERFACE,
 			"SDU");
-- 
2.39.2

