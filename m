Return-Path: <SRS0=p1bJ=U7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598D4C06510
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Jul 2019 09:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32D352146F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Jul 2019 09:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="mxPQfyVt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfGBJHl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Jul 2019 05:07:41 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40736 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbfGBJHl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Jul 2019 05:07:41 -0400
Received: by mail-lf1-f68.google.com with SMTP id a9so10854050lff.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jul 2019 02:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X2yvGcNd3VFkpWPJB4E+orVbnbAcNpqbk/LQhJJLXyk=;
        b=mxPQfyVt+BmxlNUF4chdaifkkPI0tndCSKtVBiwTCI7ih7LsH+8w613MjN/ihQhGaZ
         KxkoJYgFeUVfKjKn0d28ZnMrWAwGyZDoFySvw3ZF38uC6365z0Ed7QK6v8Svh8gj0suL
         DYW5Of1QRglRKQs3oSCmixL4ACWKfsxXzI9Y2kDv4HvOiDDfNRZ1wIj9JrlBgVFQHr2E
         /ENiBE4CigrHnNe3jHta+hHMw990xWixT8nFiI6S04lZORXO8OspZgTgdO9/RNFk0lFE
         M4qgxrd4plIzVzS23QM4ypZAGuJxHyJquNZUkZ139TNmBOMHSxzwwR0WbUfB5+5Vvyyg
         DIuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X2yvGcNd3VFkpWPJB4E+orVbnbAcNpqbk/LQhJJLXyk=;
        b=ATXL5Nl+To6JkRkycHN6S+AfM+GaG8dYwBq28w74ippixaHdjo+2YLnlZPGwNwWr3l
         GEXQxA9mpGuN4gY9ro//RhuN7dcHa+pB+oyu2o+MorqGuMazR6b9xm377Y75qdwpi27M
         JBUR9aTf7afxP+1/nbqDOXz+1lhGexGFsjS/ssJ6O8F+Z9cERyQDtfdax0qS95zZlNnT
         tg3AL6h+L0aSVUI6lJDNMetHvT9ok/zA1YmpBVEyKt7nLbgGiiijXNJrDl+C5emEkqni
         7aWMrCkzjvemkG4ESW56Aq/HTCXxvkS7jFdbf/d5zkxPPRy2ZcrIrjU1YVDvsVQ4DLQe
         E8Lg==
X-Gm-Message-State: APjAAAUMeZuP2kNXxTNOJmrPvNJp5JbExDApve1F/qf7srSmmfY3+csn
        8AAgcg3pV/F0Yt/WmwQ6eEEmneWdfCw=
X-Google-Smtp-Source: APXvYqzGuwX6WEUe4dcxBWLomkZXBOVftefKHDMafh/S8zBoNGVGT4PeZs1LQxVEpqslREI9Lmg/Hw==
X-Received: by 2002:a19:9156:: with SMTP id y22mr13639592lfj.43.1562058458523;
        Tue, 02 Jul 2019 02:07:38 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id 2sm3684904lji.94.2019.07.02.02.07.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 02:07:38 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v2 2/3] mesh: Implement DevKeySend() method on Node interface
Date:   Tue,  2 Jul 2019 11:07:30 +0200
Message-Id: <20190702090731.30852-3-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190702090731.30852-1-michal.lowas-rzechonek@silvair.com>
References: <20190702090731.30852-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch implements D-Bus DevKeySend() method of org.bluez.mesh.Node1
interface, allowing the application to send messages encrypted using
a known remote device key.

At the moment the call ignores net_index argument and sends messages
using the primary subnet.

Also, it's no longer possible to use 'magic' key_index value 0x7fff
(denoting local device key) when calling regular Send(). Applications
should use DevKeySend() instead.
---
 mesh/model.c |  8 ++++++-
 mesh/node.c  | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/mesh/model.c b/mesh/model.c
index e09dbd364..0d44ea72e 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -941,6 +941,7 @@ bool mesh_model_send(struct mesh_node *node, uint16_t src, uint16_t target,
 					const void *msg, uint16_t msg_len)
 {
 	uint8_t key_id;
+	uint8_t dev_key[16];
 	const uint8_t *key;
 
 	/* print_packet("Mod Tx", msg, msg_len); */
@@ -959,7 +960,12 @@ bool mesh_model_send(struct mesh_node *node, uint16_t src, uint16_t target,
 		if (!key)
 			return false;
 
-		l_debug("(%x)", app_idx);
+		key_id = APP_ID_DEV;
+	} else if (app_idx == APP_IDX_DEV_REMOTE) {
+		if (!keyring_get_remote_dev_key(node, target, dev_key))
+			return false;
+
+		key = dev_key;
 		key_id = APP_ID_DEV;
 	} else {
 		key = appkey_get_key(node_get_net(node), app_idx, &key_id);
diff --git a/mesh/node.c b/mesh/node.c
index 9acf153d9..316b889e8 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -1959,7 +1959,11 @@ static struct l_dbus_message *send_call(struct l_dbus *dbus,
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
 							"Incorrect data");
 
-	if (!mesh_model_send(node, src, dst, app_idx,
+	if ((app_idx & APP_IDX_MASK) != app_idx)
+		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
+						"Invalid key_index");
+
+	if (!mesh_model_send(node, src, dst, app_idx & APP_IDX_MASK,
 				mesh_net_get_default_ttl(node->net), data, len))
 		return dbus_error(msg, MESH_ERROR_FAILED, NULL);
 
@@ -1969,6 +1973,53 @@ static struct l_dbus_message *send_call(struct l_dbus *dbus,
 	return reply;
 }
 
+static struct l_dbus_message *dev_key_send_call(struct l_dbus *dbus,
+						struct l_dbus_message *msg,
+						void *user_data)
+{
+	struct mesh_node *node = user_data;
+	const char *sender, *ele_path;
+	struct l_dbus_message_iter iter_data;
+	struct node_element *ele;
+	uint16_t dst, net_idx, src;
+	uint8_t *data;
+	uint32_t len;
+	struct l_dbus_message *reply;
+
+	l_debug("DevKeySend");
+
+	sender = l_dbus_message_get_sender(msg);
+
+	if (strcmp(sender, node->owner))
+		return dbus_error(msg, MESH_ERROR_NOT_AUTHORIZED, NULL);
+
+	if (!l_dbus_message_get_arguments(msg, "oqqay", &ele_path, &dst,
+							&net_idx, &iter_data))
+		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
+
+	ele = l_queue_find(node->elements, match_element_path, ele_path);
+	if (!ele)
+		return dbus_error(msg, MESH_ERROR_NOT_FOUND,
+							"Element not found");
+
+	src = node_get_primary(node) + ele->idx;
+
+	if (!l_dbus_message_iter_get_fixed_array(&iter_data, &data, &len) ||
+					!len || len > MESH_MAX_ACCESS_PAYLOAD)
+		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
+							"Incorrect data");
+
+	/* TODO: use net_idx */
+	if (!mesh_model_send(node, src, dst, APP_IDX_DEV_REMOTE,
+				mesh_net_get_default_ttl(node->net), data, len))
+		return dbus_error(msg, MESH_ERROR_NOT_FOUND, NULL);
+
+	reply = l_dbus_message_new_method_return(msg);
+	l_dbus_message_set_arguments(reply, "");
+
+	return reply;
+}
+
 static struct l_dbus_message *publish_call(struct l_dbus *dbus,
 						struct l_dbus_message *msg,
 						void *user_data)
@@ -2074,7 +2125,11 @@ static void setup_node_interface(struct l_dbus_interface *iface)
 {
 	l_dbus_interface_method(iface, "Send", 0, send_call, "", "oqqay",
 						"element_path", "destination",
-						"key", "data");
+						"key_index", "data");
+	l_dbus_interface_method(iface, "DevKeySend", 0, dev_key_send_call,
+						"", "oqqay", "element_path",
+						"destination", "net_index",
+						"data");
 	l_dbus_interface_method(iface, "Publish", 0, publish_call, "", "oqay",
 					"element_path", "model_id", "data");
 	l_dbus_interface_method(iface, "VendorPublish", 0, vendor_publish_call,
-- 
2.19.1

