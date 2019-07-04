Return-Path: <SRS0=WywE=VB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D89C0651C
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Jul 2019 12:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB4342082E
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Jul 2019 12:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="EpPo7/eV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbfGDMdv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Jul 2019 08:33:51 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46268 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727723AbfGDMdv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Jul 2019 08:33:51 -0400
Received: by mail-lf1-f67.google.com with SMTP id z15so4114529lfh.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Jul 2019 05:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4IblZ27iWp+sP4PfHxEl9boVMP0lUZ8fZ2iZGFKJCCM=;
        b=EpPo7/eVuKurJ0XqYfdX0e1VaZ/n8JhNcrPrd+O5rbQI5jlHKX/oKMIvmvRWCv3G7z
         kblaKRZR2CCD/cAIjwx4RRN1wKJYf6iQXQIXbnI/TcjI5FE+R8jGoxL928L3Quf5JpPN
         fs9pKLJb/T7dyUukJUlxHswIQ3V+JOlZikAKVE+SrRTHIa1XLyHIfubKmhXWVujn8RC1
         a84pliQFwAfa73yfCT+cS0PWBWXTTnYEXflhyhT9Jr6cGwwLyads5uapKE1HbFpmBeUm
         9h/s5NasB+Xy0iMx+9S5l01aDUjdLk6ZG9msQbhNyJIJEfGoQV2Ofc6EHPZqraEb3ZpB
         I/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4IblZ27iWp+sP4PfHxEl9boVMP0lUZ8fZ2iZGFKJCCM=;
        b=ZXCjGuQbCvisS1/EgdLicOEYr4NLuEPjVnW7r1K5/3aEKB1UW08xN6ELYNkORWp3a2
         8+cIr2i7NBEb6VJWVbNU2eqO0Egm+uCHsneaFYao3iNYPBlq3280jQ0xgKapsW8hQY/a
         f9JINcRJiy0nb/K1ZoTmHYHz3pAy0UyJ6+Qh7fpjj5Bmr9mUjcUq/lY+D0vSVs3oU6uG
         qzEC+7Po5F6tBYCoXhdiEnSak1p0e4NqZqentB5fXJrblISeWpx56/bECxL0YCgjxmBZ
         KKfQsOfSkjvL2/zI+oKQoIiw5gArj/SSAYtzncORQKegaLZdcnIFjDfIPHAKnVll8hlu
         7yzA==
X-Gm-Message-State: APjAAAWgCd6Er9Davu8zcry8+iDy0jkX8bdavb/KL/YZNFP+mbn6zlfG
        G1twVV9f9U7pHhm9LK7AXUhYh4j58ms=
X-Google-Smtp-Source: APXvYqxH6N+PAJA7ruvrndxlDlZyPlS45RU1hN1xip14/WHw02imMuHh+7359kIGheWkPb3LckcRvA==
X-Received: by 2002:a19:cbd3:: with SMTP id b202mr4852073lfg.185.1562243628445;
        Thu, 04 Jul 2019 05:33:48 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id g68sm1126151ljg.47.2019.07.04.05.33.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 04 Jul 2019 05:33:47 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v5 4/5] mesh: Implement DevKeySend() method on Node interface
Date:   Thu,  4 Jul 2019 14:33:37 +0200
Message-Id: <20190704123338.5988-5-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190704123338.5988-1-michal.lowas-rzechonek@silvair.com>
References: <20190704123338.5988-1-michal.lowas-rzechonek@silvair.com>
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
 mesh/model.c |  9 ++++++++-
 mesh/node.c  | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 61 insertions(+), 3 deletions(-)

diff --git a/mesh/model.c b/mesh/model.c
index ee26a8105..edb820cc9 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -39,6 +39,7 @@
 #include "mesh/dbus.h"
 #include "mesh/util.h"
 #include "mesh/model.h"
+#include "mesh/keyring.h"
 
 /* Divide and round to ceiling (up) to calculate segment count */
 #define CEILDIV(val, div) (((val) + (div) - 1) / (div))
@@ -931,6 +932,7 @@ bool mesh_model_send(struct mesh_node *node, uint16_t src, uint16_t target,
 					const void *msg, uint16_t msg_len)
 {
 	uint8_t key_id;
+	uint8_t dev_key[16];
 	const uint8_t *key;
 
 	/* print_packet("Mod Tx", msg, msg_len); */
@@ -949,7 +951,12 @@ bool mesh_model_send(struct mesh_node *node, uint16_t src, uint16_t target,
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
index 53876ef5a..803bd2f30 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -1973,13 +1973,60 @@ static struct l_dbus_message *send_call(struct l_dbus *dbus,
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
 
 	return l_dbus_message_new_method_return(msg);
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
+	return l_dbus_message_new_method_return(msg);
+}
+
 static struct l_dbus_message *publish_call(struct l_dbus *dbus,
 						struct l_dbus_message *msg,
 						void *user_data)
@@ -2077,7 +2124,11 @@ static void setup_node_interface(struct l_dbus_interface *iface)
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

