Return-Path: <SRS0=/JiD=VA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB543C0650E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jul 2019 11:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A3BE218A3
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jul 2019 11:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="BI9EaAw/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfGCLmY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Jul 2019 07:42:24 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:52217 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfGCLmY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Jul 2019 07:42:24 -0400
Received: by mail-wm1-f43.google.com with SMTP id 207so1876968wma.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jul 2019 04:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N0ay6lEmz80bgBS5M0Cl7dsbcfh1Ka3ATckSuGo3SzM=;
        b=BI9EaAw/IdW1tTsjrOKcINbzwNZyjOgoMC9XuHipdnoJKx8cJypymd9tv9x11HoxTR
         rOGHNe7vKbj6U8WXEY5w7BgDSqm4089Y4gmfWno5M7P2Kt/KJCfpZrvSkyxVG8Z7Ypr+
         m9SlQa2TSkdLU+wQXA0ma6chIaUFs8tDYE2o4RMDQIPivmL8iHKvRKbZE9KKKYgxRM99
         UoK4n2A7k4Ig6c1eeVUSKTKyAVORNM9Yvk7edK1kokRzWuS0f5b7Th8yhUXc0VlMiEJT
         uq8qrnDeYiFpl1uArOGJoUM7Q2nS07vkGNDrqNya2Nn6qaB6fWR+KhHeVYujOYPNDE5z
         TlSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N0ay6lEmz80bgBS5M0Cl7dsbcfh1Ka3ATckSuGo3SzM=;
        b=Z0+hnxuPc2aiAdIXkszc7fO8K9ymJXSGIPSrmQdUiKg5sY7MUMzm6760DeAPgtyBBK
         Gbbx+hHbS73whpfn6kPERgBKAFWR6QQzNEhrhHN1bwJKW7V2kb48jw+sBxkudAmp7c58
         AJubpXythdTZk3sCsDOUpWt1XnNjoADiFLa/jRi3s6xucGov0NpNwsFkDEzBRn/i3B18
         8854WWO9zzdsBS6Wyk3D45f5Ql7DaeXlr018/nP9xM+MnqW6nPnjCUoeqpFX9PRvuaI4
         83SNFyxJmFifPVQOCSO+JULl2bUoeAI4gbUEYb9tCi2xjGD1U/vS2f7CtFJ8LgQJdIiC
         ZCbg==
X-Gm-Message-State: APjAAAWeq/q0Ym4AYSHRFAMLaqYPcfh0Vh939rEfE9falf4yJ+hSF+U4
        m3AQwVS3Sm2iDwtIj8JNTtROpZwGJoM=
X-Google-Smtp-Source: APXvYqwlqqX1pjOfHjxzF2eUD1NVDe6bW9dPAisNDC3k4ltu/dGQ8S90V+6QWsiWbenTGzm5Yx3Avg==
X-Received: by 2002:a1c:9dc5:: with SMTP id g188mr8076998wme.93.1562154141107;
        Wed, 03 Jul 2019 04:42:21 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id x6sm2556816wru.0.2019.07.03.04.42.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 04:42:20 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Inga Stotland <inga.stotland@intel.com>,
        Brian Gix <brian.gix@intel.com>
Subject: [PATCH BlueZ v4 1/3] mesh: Split APP_IDX_DEV into APP_IDX_DEV_LOCAL and APP_IDX_DEV_REMOTE
Date:   Wed,  3 Jul 2019 13:42:12 +0200
Message-Id: <20190703114214.22320-2-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190703114214.22320-1-michal.lowas-rzechonek@silvair.com>
References: <20190703114214.22320-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This is needed to distinguish incoming messages encrypted using a device
key: if the key is local, the message can be forwarded to internal
models. If the key is a known remote one, it will be forwarded to the
application via DevKeyMessageReceived() API.
---
 mesh/cfgmod-server.c | 15 ++++++++-------
 mesh/model.c         | 22 +++++++++++++---------
 mesh/net.h           |  8 ++++----
 3 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index 634ac006b..a849b5e99 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -69,7 +69,8 @@ static void send_pub_status(struct mesh_node *node, uint16_t src, uint16_t dst,
 		n += 2;
 	}
 
-	mesh_model_send(node, dst, src, APP_IDX_DEV, DEFAULT_TTL, msg, n);
+	mesh_model_send(node, dst, src, APP_IDX_DEV_LOCAL, DEFAULT_TTL,
+								msg, n);
 }
 
 static bool config_pub_get(struct mesh_node *node, uint16_t src, uint16_t dst,
@@ -254,7 +255,7 @@ static void send_sub_status(struct mesh_node *node, uint16_t src, uint16_t dst,
 		n += 2;
 	}
 
-	mesh_model_send(node, dst, src, APP_IDX_DEV, DEFAULT_TTL, msg, n);
+	mesh_model_send(node, dst, src, APP_IDX_DEV_LOCAL, DEFAULT_TTL, msg, n);
 }
 
 static bool config_sub_get(struct mesh_node *node, uint16_t src, uint16_t dst,
@@ -312,7 +313,7 @@ static bool config_sub_get(struct mesh_node *node, uint16_t src, uint16_t dst,
 
 	*msg_status = (uint8_t) status;
 
-	mesh_model_send(node, dst, src, APP_IDX_DEV, DEFAULT_TTL, msg, n);
+	mesh_model_send(node, dst, src, APP_IDX_DEV_LOCAL, DEFAULT_TTL, msg, n);
 	return true;
 }
 
@@ -487,7 +488,7 @@ static void send_model_app_status(struct mesh_node *node, uint16_t src,
 	l_put_le16(id, msg + n);
 	n += 2;
 
-	mesh_model_send(node, dst, src, APP_IDX_DEV, DEFAULT_TTL, msg, n);
+	mesh_model_send(node, dst, src, APP_IDX_DEV_LOCAL, DEFAULT_TTL, msg, n);
 }
 
 static void model_app_list(struct mesh_node *node, uint16_t src, uint16_t dst,
@@ -540,7 +541,7 @@ static void model_app_list(struct mesh_node *node, uint16_t src, uint16_t dst,
 
 	if (result >= 0) {
 		*status = result;
-		mesh_model_send(node, dst, src, APP_IDX_DEV, DEFAULT_TTL,
+		mesh_model_send(node, dst, src, APP_IDX_DEV_LOCAL, DEFAULT_TTL,
 								msg, n);
 	}
 
@@ -758,7 +759,7 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst,
 	uint16_t interval;
 	uint16_t n;
 
-	if (idx != APP_IDX_DEV)
+	if (idx != APP_IDX_DEV_LOCAL)
 		return false;
 
 	if (mesh_model_opcode_get(pkt, size, &opcode, &n)) {
@@ -1259,7 +1260,7 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst,
 	if (n) {
 		/* print_packet("App Tx", long_msg ? long_msg : msg, n); */
 		mesh_model_send(node, unicast, src,
-				APP_IDX_DEV, DEFAULT_TTL,
+				APP_IDX_DEV_LOCAL, DEFAULT_TTL,
 				long_msg ? long_msg : msg, n);
 	}
 	l_free(long_msg);
diff --git a/mesh/model.c b/mesh/model.c
index 7401dcecb..598615c5e 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -306,7 +306,9 @@ static void forward_model(void *a, void *b)
 	bool result;
 
 	l_debug("model %8.8x with idx %3.3x", mod->id, fwd->idx);
-	if (fwd->idx != APP_IDX_DEV && !has_binding(mod->bindings, fwd->idx))
+
+	if (fwd->idx != APP_IDX_DEV_LOCAL &&
+					!has_binding(mod->bindings, fwd->idx))
 		return;
 
 	dst = fwd->dst;
@@ -356,15 +358,15 @@ static int dev_packet_decrypt(struct mesh_node *node, const uint8_t *data,
 				uint16_t dst, uint8_t key_id, uint32_t seq,
 				uint32_t iv_idx, uint8_t *out)
 {
-	const uint8_t *dev_key;
+	const uint8_t *key;
 
-	dev_key = node_get_device_key(node);
-	if (!dev_key)
+	key = node_get_device_key(node);
+	if (!key)
 		return false;
 
 	if (mesh_crypto_payload_decrypt(NULL, 0, data, size, szmict, src,
-					dst, key_id, seq, iv_idx, out, dev_key))
-		return APP_IDX_DEV;
+					dst, key_id, seq, iv_idx, out, key))
+		return APP_IDX_DEV_LOCAL;
 
 	return -1;
 }
@@ -952,7 +954,7 @@ bool mesh_model_send(struct mesh_node *node, uint16_t src, uint16_t target,
 	if (IS_UNASSIGNED(target))
 		return false;
 
-	if (app_idx == APP_IDX_DEV) {
+	if (app_idx == APP_IDX_DEV_LOCAL) {
 		key = node_get_device_key(node);
 		if (!key)
 			return false;
@@ -1381,12 +1383,14 @@ struct mesh_model *mesh_model_setup(struct mesh_node *node, uint8_t ele_idx,
 		if (ele_idx != PRIMARY_ELE_IDX)
 			return NULL;
 
-		l_queue_push_head(mod->bindings, L_UINT_TO_PTR(APP_IDX_DEV));
+		l_queue_push_head(mod->bindings,
+					L_UINT_TO_PTR(APP_IDX_DEV_LOCAL));
 		return mod;
 	}
 
 	if (db_mod->id == CONFIG_CLI_MODEL) {
-		l_queue_push_head(mod->bindings, L_UINT_TO_PTR(APP_IDX_DEV));
+		l_queue_push_head(mod->bindings,
+					L_UINT_TO_PTR(APP_IDX_DEV_LOCAL));
 		return mod;
 	}
 
diff --git a/mesh/net.h b/mesh/net.h
index f19024766..8848e6df0 100644
--- a/mesh/net.h
+++ b/mesh/net.h
@@ -37,10 +37,10 @@ struct mesh_node;
 #define SEQ_MASK	0xffffff
 
 #define CREDFLAG_MASK	0x1000
-#define APP_IDX_MASK	0x0fff
-#define APP_IDX_DEV	0x7fff
-#define APP_IDX_ANY	0x8000
-#define APP_IDX_NET	0xffff
+
+#define APP_IDX_MASK		0x0fff
+#define APP_IDX_DEV_REMOTE	0x6fff
+#define APP_IDX_DEV_LOCAL	0x7fff
 
 #define NET_IDX_INVALID	0xffff
 #define NET_NID_INVALID	0xff
-- 
2.19.1

