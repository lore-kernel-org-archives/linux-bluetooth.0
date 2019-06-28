Return-Path: <SRS0=h1rX=U3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA94C4321A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jun 2019 12:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29A07208C4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jun 2019 12:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="gJ4zlde+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfF1MwQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Jun 2019 08:52:16 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:35733 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbfF1MwQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Jun 2019 08:52:16 -0400
Received: by mail-wm1-f42.google.com with SMTP id c6so8901270wml.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2019 05:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IILz2bp5wMVgJADd1B0SkSw0nCMJ4CJY5F+hKcTNovo=;
        b=gJ4zlde+AcrM1/fJvFX0vo9lwTpgTS1Hx8FsQIBYKLanS45JCmmcQ0Bk+0dWHV8omB
         9SQfpLU/Nc88JPskvk1Skm5qbduwAWcJFYtZFjconDPUA0d5XuldYn0iCO0+WQ7RbTT4
         ADffFMVJ5Zg00rMYequyk8yJ/Qt4jcPNL7lGF0DBkR3yGZyWDWrjXff4xU26lnyWcRO/
         bsHHvRw1Fyzmkx0XQO0GpZ8A8O8hHxJPhzcsiID7BQfXN4X9gG7meZSTDNnDVeFO613u
         qW0QLE1JPb8cqvl+udc2WuFCZNPMpVmq9fxmAccuESxnm0NfMwkEc21mq3HW1TvOaYP4
         Oo1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IILz2bp5wMVgJADd1B0SkSw0nCMJ4CJY5F+hKcTNovo=;
        b=BDEsyNL8iqDGUDHoQGOERThR53samT2a1N9AI7NfJCryY7ETXnN0xZelkeFEwmBSU0
         tFf04I9ZUixcbG70ZgKryeBLovkKK6O9RXUa+A+AhG1lAT3S11/0l8+uapCpiMkJTviN
         V6KF4cAMs2P1WLJaU/GwkyEwZMNEGHLnrmwjHS78jN5/N/Sa86DVh7N+UgWS4uljUY74
         DNjHLtLT1qQGsoNE7df1lOjLEzFq1PHE2XPuz+2chzX3GhKHgUQmdW7SgF5RD6itKBO8
         QwFI0pSFVYH5v7go4o7uBRfFpq/uEuTP4neDoMYDKT2edo7LzZw1QJZ5Uwq6Vcu5l7xU
         cQ1Q==
X-Gm-Message-State: APjAAAWMgZacRPJDSKAZ6w7S1QvqnEYq8QxTfqupcU4/pjhJQwd5mpNe
        l65dTvnxrMwfk4hP5fg2+h+JynfYwp8=
X-Google-Smtp-Source: APXvYqzUrcg/Dj3KxVS/NMZNKwDEXs77aXDhdLyhtS3mxHGueLxJmZ0m1ew6mDfZWXXaeOcgjORBjw==
X-Received: by 2002:a1c:2907:: with SMTP id p7mr7075445wmp.100.1561726333092;
        Fri, 28 Jun 2019 05:52:13 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id y6sm2226484wmd.16.2019.06.28.05.52.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 28 Jun 2019 05:52:12 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Inga Stotland <inga.stotland@intel.com>,
        Brian Gix <brian.gix@intel.com>
Subject: [PATCH BlueZ 1/3] mesh: Rename APP_IDX_DEV to APP_IDX_DEV_LOCAL, add APP_IDX_DEV_REMOTE
Date:   Fri, 28 Jun 2019 14:52:03 +0200
Message-Id: <20190628125205.21411-2-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190628125205.21411-1-michal.lowas-rzechonek@silvair.com>
References: <20190628125205.21411-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 mesh/cfgmod-server.c | 14 +++++++-------
 mesh/model.c         | 20 +++++++++++---------
 mesh/net.h           | 10 ++++++----
 3 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index 060d7f4e4..39710fc72 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -69,7 +69,7 @@ static void send_pub_status(struct mesh_node *node, uint16_t src, uint16_t dst,
 	}
 
 	mesh_model_send(node, dst, src,
-			APP_IDX_DEV, DEFAULT_TTL, msg, n);
+			APP_IDX_DEV_LOCAL, DEFAULT_TTL, msg, n);
 }
 
 static bool config_pub_get(struct mesh_node *node, uint16_t src, uint16_t dst,
@@ -261,7 +261,7 @@ static void send_sub_status(struct mesh_node *node, uint16_t src, uint16_t dst,
 		n += 2;
 	}
 
-	mesh_model_send(node, dst, src, APP_IDX_DEV, DEFAULT_TTL, msg, n);
+	mesh_model_send(node, dst, src, APP_IDX_DEV_LOCAL, DEFAULT_TTL, msg, n);
 }
 
 static bool config_sub_get(struct mesh_node *node, uint16_t src, uint16_t dst,
@@ -319,7 +319,7 @@ static bool config_sub_get(struct mesh_node *node, uint16_t src, uint16_t dst,
 	else if (ret > 0)
 		*status = ret;
 
-	mesh_model_send(node, dst, src, APP_IDX_DEV, DEFAULT_TTL, msg, n);
+	mesh_model_send(node, dst, src, APP_IDX_DEV_LOCAL, DEFAULT_TTL, msg, n);
 	return true;
 }
 
@@ -494,7 +494,7 @@ static void send_model_app_status(struct mesh_node *node, uint16_t src,
 	l_put_le16(id, msg + n);
 	n += 2;
 
-	mesh_model_send(node, dst, src, APP_IDX_DEV, DEFAULT_TTL, msg, n);
+	mesh_model_send(node, dst, src, APP_IDX_DEV_LOCAL, DEFAULT_TTL, msg, n);
 }
 
 static void model_app_list(struct mesh_node *node, uint16_t src, uint16_t dst,
@@ -547,7 +547,7 @@ static void model_app_list(struct mesh_node *node, uint16_t src, uint16_t dst,
 
 	if (result >= 0) {
 		*status = result;
-		mesh_model_send(node, dst, src, APP_IDX_DEV, DEFAULT_TTL,
+		mesh_model_send(node, dst, src, APP_IDX_DEV_LOCAL, DEFAULT_TTL,
 								msg, n);
 	}
 
@@ -765,7 +765,7 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst,
 	uint16_t interval;
 	uint16_t n;
 
-	if (idx != APP_IDX_DEV)
+	if (idx != APP_IDX_DEV_LOCAL)
 		return false;
 
 	if (mesh_model_opcode_get(pkt, size, &opcode, &n)) {
@@ -1266,7 +1266,7 @@ static bool cfg_srv_pkt(uint16_t src, uint32_t dst,
 	if (n) {
 		/* print_packet("App Tx", long_msg ? long_msg : msg, n); */
 		mesh_model_send(node, unicast, src,
-				APP_IDX_DEV, DEFAULT_TTL,
+				APP_IDX_DEV_LOCAL, DEFAULT_TTL,
 				long_msg ? long_msg : msg, n);
 	}
 	l_free(long_msg);
diff --git a/mesh/model.c b/mesh/model.c
index f29ad9af2..6cd630aa9 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -307,7 +307,8 @@ static void forward_model(void *a, void *b)
 	bool result;
 
 	l_debug("model %8.8x with idx %3.3x", mod->id, fwd->idx);
-	if (fwd->idx != APP_IDX_DEV && !has_binding(mod->bindings, fwd->idx))
+
+	if (fwd->idx != APP_IDX_DEV_LOCAL && !has_binding(mod->bindings, fwd->idx))
 		return;
 
 	dst = fwd->dst;
@@ -357,15 +358,16 @@ static int dev_packet_decrypt(struct mesh_node *node, const uint8_t *data,
 				uint16_t dst, uint8_t key_id, uint32_t seq,
 				uint32_t iv_idx, uint8_t *out)
 {
-	const uint8_t *dev_key;
+	uint8_t dev_key[16];
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
@@ -967,7 +969,7 @@ bool mesh_model_send(struct mesh_node *node, uint16_t src, uint16_t target,
 	if (IS_UNASSIGNED(target))
 		return false;
 
-	if (app_idx == APP_IDX_DEV) {
+	if (app_idx == APP_IDX_DEV_LOCAL) {
 		key = node_get_device_key(node);
 		if (!key)
 			return false;
@@ -1412,12 +1414,12 @@ struct mesh_model *mesh_model_setup(struct mesh_node *node, uint8_t ele_idx,
 		if (ele_idx != PRIMARY_ELE_IDX)
 			return NULL;
 
-		l_queue_push_head(mod->bindings, L_UINT_TO_PTR(APP_IDX_DEV));
+		l_queue_push_head(mod->bindings, L_UINT_TO_PTR(APP_IDX_DEV_LOCAL));
 		return mod;
 	}
 
 	if (db_mod->id == CONFIG_CLI_MODEL) {
-		l_queue_push_head(mod->bindings, L_UINT_TO_PTR(APP_IDX_DEV));
+		l_queue_push_head(mod->bindings, L_UINT_TO_PTR(APP_IDX_DEV_LOCAL));
 		return mod;
 	}
 
diff --git a/mesh/net.h b/mesh/net.h
index f19024766..a9586a99d 100644
--- a/mesh/net.h
+++ b/mesh/net.h
@@ -37,10 +37,12 @@ struct mesh_node;
 #define SEQ_MASK	0xffffff
 
 #define CREDFLAG_MASK	0x1000
-#define APP_IDX_MASK	0x0fff
-#define APP_IDX_DEV	0x7fff
-#define APP_IDX_ANY	0x8000
-#define APP_IDX_NET	0xffff
+
+#define APP_IDX_MASK		0x0fff
+#define APP_IDX_DEV_REMOTE	0x7ffe
+#define APP_IDX_DEV_LOCAL	0x7fff
+#define APP_IDX_ANY		0x8000
+#define APP_IDX_NET		0xffff
 
 #define NET_IDX_INVALID	0xffff
 #define NET_NID_INVALID	0xff
-- 
2.19.1

