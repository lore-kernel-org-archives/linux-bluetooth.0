Return-Path: <SRS0=OoMZ=VO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADD2C76195
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jul 2019 19:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D876221849
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jul 2019 19:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="arV2WAKr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfGQTxi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Jul 2019 15:53:38 -0400
Received: from mail-lj1-f176.google.com ([209.85.208.176]:39820 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbfGQTxi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Jul 2019 15:53:38 -0400
Received: by mail-lj1-f176.google.com with SMTP id v18so24840019ljh.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jul 2019 12:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KbUKHg0WEzKxTm+GQ+XWbLKvy2pnX7pUR/Ub4MRE5rw=;
        b=arV2WAKruEKbiQlj1K/e3X93lnB+jY5TTO2kkijWsMfXqfxFkfvef+V4oBUSf97xhA
         5SgNc9URAxoLXqCo7bEkDMO+VLzTy6IbP3AlVzPjMu5G3/OjY4FQGbSKflZ0RSCDph5C
         S6PN1t1ddF+fLAncyeSMzlBrmI2PIS5+BKb5E5xyHwDAHuBrbLPIgiWdIqdbY/i5WAE/
         Xapg/IS49/GO1V1+hoS3+M8PdMVADKAx75Bm7eGUt1fre1SkduhXEXES2r/gAM9vdV0G
         8MffLttLLn49iu+u6qae4a2lSC3iWaNQLPWW/CMnNs8OjPMWiqDRGmzhIu4Ky21mA5ak
         Cjiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KbUKHg0WEzKxTm+GQ+XWbLKvy2pnX7pUR/Ub4MRE5rw=;
        b=GYPbaZeqzOwsi9QPsT9ZDo5zvOFn4ru7BQmlufh9/SMx0pFk6DVwj7binFZhXmH8Ch
         ZwSzX0u/hWXgLGSi1ZGDOQ74EwfgAnxBT2sx+RsG77WfhAOkRRsN0tR4EzyZ2pQbW//E
         FJcEM513gS+Uaq1WP06v4BEg41Vaa08de24As4q3SQCba+4Osw8ULMDWJeVy2hUN+ZIi
         FHIzn4zVy35E3FxggIpLDMlYtVd08aNlPUj/oPv73PTr3ck05O7DaYusMnquXtw6NMD7
         XJ+MjMPYpJ4IA3vi5UF8Zler8lhwBDARpYIHtkxEFVCd7Vuls2J4VmootMIopPrmu4Bl
         euPQ==
X-Gm-Message-State: APjAAAU8+1X3/7N11n3DUGbfG7exg09xus/AYfVe0hmtLRI56wgLtHSB
        HN5Ce0JkqCWhRTCDJrIres5kxj9wOrU=
X-Google-Smtp-Source: APXvYqz7YB7i+G68wqtM5xscpRFcs849T4+IMlU6jfJiO2Hv8HXUQwyuLfMMuHAhV1IeRonx+pUSrg==
X-Received: by 2002:a2e:98d7:: with SMTP id s23mr21402721ljj.179.1563393215668;
        Wed, 17 Jul 2019 12:53:35 -0700 (PDT)
Received: from kynes.internet.domowy (apn-77-112-37-101.dynamic.gprs.plus.pl. [77.112.37.101])
        by smtp.gmail.com with ESMTPSA id 2sm4643181lji.94.2019.07.17.12.53.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jul 2019 12:53:34 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ 1/2] mesh: Keep model list sorted and unique
Date:   Wed, 17 Jul 2019 21:53:27 +0200
Message-Id: <20190717195328.16322-2-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190717195328.16322-1-michal.lowas-rzechonek@silvair.com>
References: <20190717195328.16322-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This keeps composition data unchanged even if models are registered in a
different order.
---
 mesh/node.c | 53 +++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 41 insertions(+), 12 deletions(-)

diff --git a/mesh/node.c b/mesh/node.c
index d631b9324..3cf82e63c 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -180,6 +180,29 @@ static bool match_element_path(const void *a, const void *b)
 	return (!strcmp(element->path, path));
 }
 
+static bool match_model(const void *a, const void *b)
+{
+	uint32_t a_id = mesh_model_get_model_id(a);
+	uint32_t b_id = mesh_model_get_model_id(b);
+
+	return a_id == b_id;
+}
+
+static int compare_model_id(const void *a, const void *b, void *user_data)
+{
+	uint32_t a_id = mesh_model_get_model_id(a);
+	uint32_t b_id = mesh_model_get_model_id(b);
+
+	if (a_id < b_id)
+		return -1;
+
+	if (a_id > b_id)
+		return 1;
+
+	return 0;
+}
+
+
 struct mesh_node *node_find_by_addr(uint16_t addr)
 {
 	if (!IS_UNICAST(addr))
@@ -301,6 +324,17 @@ void node_remove(struct mesh_node *node)
 	free_node_resources(node);
 }
 
+static bool element_add_model(struct node_element *ele, struct mesh_model *mod)
+{
+	if (l_queue_find(ele->models, match_model, mod)) {
+		mesh_model_free(mod);
+		return false;
+	}
+
+	l_queue_insert(ele->models, mod, compare_model_id, NULL);
+	return true;
+}
+
 static bool add_models(struct mesh_node *node, struct node_element *ele,
 					struct mesh_config_element *db_ele)
 {
@@ -319,7 +353,8 @@ static bool add_models(struct mesh_node *node, struct node_element *ele,
 		if (!mod)
 			return false;
 
-		l_queue_push_tail(ele->models, mod);
+		if (!element_add_model(ele, mod))
+			return false;
 	}
 
 	return true;
@@ -348,7 +383,7 @@ static void add_internal_model(struct mesh_node *node, uint32_t mod_id,
 	if (!ele->models)
 		ele->models = l_queue_new();
 
-	l_queue_push_tail(ele->models, mod);
+	element_add_model(ele, mod);
 }
 
 static bool add_element(struct mesh_node *node,
@@ -1035,12 +1070,11 @@ bool node_parse_composition(struct mesh_node *node, uint8_t *data,
 		while (len >= 2 && m--) {
 			mod_id = l_get_le16(data);
 			mod = mesh_model_new(ele->idx, mod_id);
-			if (!mod) {
+			if (!mod || !element_add_model(ele, mod)) {
 				element_free(ele);
 				goto fail;
 			}
 
-			l_queue_push_tail(ele->models, mod);
 			data += 2;
 			len -= 2;
 		}
@@ -1057,12 +1091,11 @@ bool node_parse_composition(struct mesh_node *node, uint8_t *data,
 			mod_id |= (vendor_id << 16);
 			mod = mesh_model_vendor_new(ele->idx, vendor_id,
 									mod_id);
-			if (!mod) {
+			if (!mod || !element_add_model(ele, mod)) {
 				element_free(ele);
 				goto fail;
 			}
 
-			l_queue_push_tail(ele->models, mod);
 			data += 4;
 			len -= 4;
 		}
@@ -1212,12 +1245,8 @@ static void get_models_from_properties(struct node_element *ele,
 		while (l_dbus_message_iter_next_entry(&ids, &mod_id)) {
 			struct mesh_model *mod;
 
-			/* Skip internally implemented models */
-			if ((VENDOR_ID_MASK | mod_id) == CONFIG_SRV_MODEL)
-				continue;
-
 			mod = mesh_model_new(ele->idx, mod_id);
-			l_queue_push_tail(ele->models, mod);
+			element_add_model(ele, mod);
 		}
 		return;
 	}
@@ -1227,7 +1256,7 @@ static void get_models_from_properties(struct node_element *ele,
 		struct mesh_model *mod;
 
 		mod = mesh_model_vendor_new(ele->idx, vendor_id, mod_id);
-		l_queue_push_tail(ele->models, mod);
+		element_add_model(ele, mod);
 	}
 }
 
-- 
2.22.0

