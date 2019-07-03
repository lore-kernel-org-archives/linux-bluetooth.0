Return-Path: <SRS0=/JiD=VA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8175C5B578
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jul 2019 07:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0A5E2187F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jul 2019 07:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="U64VA/1t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfGCHRG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Jul 2019 03:17:06 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39022 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfGCHRF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Jul 2019 03:17:05 -0400
Received: by mail-lj1-f193.google.com with SMTP id v18so1214477ljh.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jul 2019 00:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P5uW1D2kumbgQcxSyb54FRmc63KTpG79U53AITDME64=;
        b=U64VA/1t83Nfgfad7nezBerQFzbXhMJG4FFFgNjQ5fSqayPd63uwLr/arFd/BxfXVe
         va9t3bgBWAlGxiUCNK+w52/05kcPBSxu8oV8u8tVXutR7krgKhszCRlPIaeSmuM2y4yc
         ULtWecvimnKLfqy8ajebRoZtrYPzRZrhB9oV62jTweJnItj+jPlKD+4YaUQJpBHH730o
         qu7EHmCSKy2LZjyQ6tOM00qDwscO7tRHporxAxu9BzWMdhpubIrXo4r/7hVV2Xu/BrEc
         RxbO3XAtxiICNPDaUBuMo/qddcg8eoEP7ABY+WJ+rg7CZjtOA7mpEtPJTXRwp7m5cg2o
         ib8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P5uW1D2kumbgQcxSyb54FRmc63KTpG79U53AITDME64=;
        b=j7Kq/PYqenZVFN5/IS+/Kcu/IhDjb2ornstW5f+ndC9OhjF8ZOQ+YaSpuV2i+X08Rs
         2QU47eG6o99B3e3fOSyw1TMWN7ty/ZaNj3c7stj5m1MhyuEaLBcmi+Ftv/JyMerB1Ans
         kynaVx/ZVkyc2TZc6BJojjodgVZOhVedPg4Pl/Dt671Jq0joMqKqOaqRrv0r2OTPVzYJ
         VHpiEJdiTGrCi5CcT4sYlED5q5TWEvz5F/3KfrZZ3QjKmMtygb+h5LrTz0G7gzmU7nzY
         Xb5P1YRzGADP5Ye/bTFYVpvtTiQ7zagLbDqMRs2DyYPKt+3wqdltTqwVI29kDIrnMT1n
         buVg==
X-Gm-Message-State: APjAAAXFroYniCu5WhxQsArLqHrAwEepsR5NOMhtF9YIztQbzgzXiTxp
        TsV2xJaWLbD0LWy8duAdvyVIsHjQfSo=
X-Google-Smtp-Source: APXvYqy13xg1sxfFeb6Rv58IuRDErcfg+Ycdb9AAYH/bGQv2pyFaFJ5Snt/jtAOmyjcBO9cI/cZq3g==
X-Received: by 2002:a2e:9a19:: with SMTP id o25mr5671840lji.63.1562138223570;
        Wed, 03 Jul 2019 00:17:03 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id l11sm281364lfc.18.2019.07.03.00.17.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 00:17:03 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v3 2/3] mesh: Implement DevKeySend() method on Node interface
Date:   Wed,  3 Jul 2019 09:16:55 +0200
Message-Id: <20190703071656.6342-3-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190703071656.6342-1-michal.lowas-rzechonek@silvair.com>
References: <20190703071656.6342-1-michal.lowas-rzechonek@silvair.com>
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
 mesh/model.c |  9 +++++++-
 mesh/node.c  | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 65 insertions(+), 3 deletions(-)

diff --git a/mesh/model.c b/mesh/model.c
index 598615c5e..aae913d92 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -39,6 +39,7 @@
 #include "mesh/dbus.h"
 #include "mesh/util.h"
 #include "mesh/model.h"
+#include "mesh/keyring.h"
 
 /* Divide and round to ceiling (up) to calculate segment count */
 #define CEILDIV(val, div) (((val) + (div) - 1) / (div))
@@ -941,6 +942,7 @@ bool mesh_model_send(struct mesh_node *node, uint16_t src, uint16_t target,
 					const void *msg, uint16_t msg_len)
 {
 	uint8_t key_id;
+	uint8_t dev_key[16];
 	const uint8_t *key;
 
 	/* print_packet("Mod Tx", msg, msg_len); */
@@ -959,7 +961,12 @@ bool mesh_model_send(struct mesh_node *node, uint16_t src, uint16_t target,
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

