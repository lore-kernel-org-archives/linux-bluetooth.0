Return-Path: <SRS0=OoMZ=VO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC16C76186
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jul 2019 08:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BADD20818
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jul 2019 08:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="lfE6QzF8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbfGQIhI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Jul 2019 04:37:08 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39517 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfGQIhH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Jul 2019 04:37:07 -0400
Received: by mail-lj1-f196.google.com with SMTP id v18so22734147ljh.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jul 2019 01:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7nt5FCuTioQMnGTM+ZkGuNvK8GaT3Oco+7F13k42yVw=;
        b=lfE6QzF8Xnsx9nsNxEeojs3iUF8COm33B8ipTlNb52cssbqVAXQGDOjb07A5+GwLxJ
         J/PfJmbZ3MEhM0b4QBVUqPjyXWs2wWqOJ++NVe/nkRPazn5k1k9gG3B6TLPaUHOIANgl
         GEj0U7d3zEwVIkRhs19h1iIJhb+p0B3RozqSMyiZbUtzPQazjSwlECyIs6ew8Q2+Lcvq
         gqD5Sfz0e5zIrP0mcUtPdIGfspzlXDenz45hrtBhyGaBh/wspjXYUHCeoAauFTbdVSsc
         SkrQv6D9KB0/MvP0rv3XCFAtYViZjkv7JvkZjznXEYE25DU6IgkFYisWt4ivv0FWj+SJ
         26iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7nt5FCuTioQMnGTM+ZkGuNvK8GaT3Oco+7F13k42yVw=;
        b=bdVBjqlkjKM06nycnAT1UiIBIkARfXAfRRd1jX/y943ZacjtJf1GyVj9apwCLIiQF4
         uG/HT+boc02mVd7QRasMvlMvFTPfqNlvT98EGbOz0yUv7Pu0gVjG0cuQ00nLzxhe1p/A
         Z7aNpjbu23JVuISwPTS5OZjMgfhO3VWzQUEJ+NfiaCkD8E6kJLzwY0c7MXrywsDIdwww
         tPy8dC6HfyJ6veM15vqmkj7+uqlznDDnlta7PpC5ghcdnae6m0BWP+G/XjCuN5dUGkN6
         36iQXGlAkf2qIn75TY2qfO+qaYB12/8M/i55vHoyqxTSEPv0rnpOY72rS/4eNScyUpZ2
         uAQQ==
X-Gm-Message-State: APjAAAUjkc622vp5dvtxHIkyTLVOTFBzt+5pmt4qH0x9RdE3puEiIEwP
        7TAorDMuSWLsHx/tsjeMKe8flsMRpzA=
X-Google-Smtp-Source: APXvYqwDgQnNgTWtjCbHQ3zWNe66BkNLQVZ24FHb1AxCGXvZA55y2LIP4MVeO5BZJGuRh+y2AfPPZw==
X-Received: by 2002:a2e:9cd4:: with SMTP id g20mr19124098ljj.205.1563352625310;
        Wed, 17 Jul 2019 01:37:05 -0700 (PDT)
Received: from localhost.localdomain ([31.0.84.191])
        by smtp.gmail.com with ESMTPSA id v202sm3338708lfa.28.2019.07.17.01.37.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 01:37:04 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Jakub Witowski <jakub.witowski@silvair.com>
Subject: [PATCH BlueZ v5 2/4] mesh: Extract read_* functions in mesh-config-json
Date:   Wed, 17 Jul 2019 10:36:48 +0200
Message-Id: <20190717083650.26346-3-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190717083650.26346-1-michal.lowas-rzechonek@silvair.com>
References: <20190717083650.26346-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Jakub Witowski <jakub.witowski@silvair.com>

This enables more code to be reused in ImportLocalNode implementation,
when using 'json' import data format.
---
 mesh/mesh-config-json.c | 76 +++++++++++++++++++++++++++++++----------
 1 file changed, 58 insertions(+), 18 deletions(-)

diff --git a/mesh/mesh-config-json.c b/mesh/mesh-config-json.c
index 75015e607..6df7f7b3f 100644
--- a/mesh/mesh-config-json.c
+++ b/mesh/mesh-config-json.c
@@ -52,6 +52,8 @@ struct write_info {
 	mesh_config_status_func_t cb;
 };
 
+typedef bool (*read_net_key_cb)(struct mesh_config_netkey *, void*);
+
 static const char *cfg_name = "/node.json";
 static const char *bak_ext = ".bak";
 static const char *tmp_ext = ".tmp";
@@ -297,6 +299,33 @@ static json_object *jarray_key_del(json_object *jarray, int16_t idx)
 	return jarray_new;
 }
 
+static bool read_unicast_address(json_object *jobj,
+							uint16_t *unicast)
+{
+	json_object *jvalue;
+	char *str;
+
+	if (!json_object_object_get_ex(jobj, "unicastAddress", &jvalue))
+		return false;
+
+	str = (char *)json_object_get_string(jvalue);
+	if (sscanf(str, "%04hx", unicast) != 1)
+		return false;
+
+	return true;
+}
+
+static bool read_seq_number(json_object *jobj, uint32_t *seq_number)
+{
+	json_object *jvalue;
+
+	if (!json_object_object_get_ex(jobj, "sequenceNumber", &jvalue))
+		return false;
+
+	*seq_number = json_object_get_int(jvalue);
+	return true;
+}
+
 static bool read_iv_index(json_object *jobj, uint32_t *idx, bool *update)
 {
 	int tmp;
@@ -424,12 +453,35 @@ fail:
 	return false;
 }
 
-static bool read_net_keys(json_object *jobj,  struct mesh_config_node *node)
+static bool read_net_key(struct mesh_config_netkey *net_key,
+							void *user_data)
+{
+	struct mesh_config_node *node = user_data;
+
+	if (!net_key) {
+		l_queue_destroy(node->netkeys, l_free);
+		node->netkeys = NULL;
+		return false;
+	}
+
+	if (!node->netkeys)
+		node->netkeys = l_queue_new();
+
+	l_queue_push_tail(node->netkeys, net_key);
+
+	return true;
+}
+
+static bool read_net_keys(json_object *jobj, read_net_key_cb cb,
+							void *user_data)
 {
 	json_object *jarray;
 	int len;
 	int i;
 
+	if (!cb)
+		return true;
+
 	/* At least one NetKey must be present for a provisioned node */
 	if (!json_object_object_get_ex(jobj, "netKeys", &jarray))
 		return false;
@@ -441,8 +493,6 @@ static bool read_net_keys(json_object *jobj,  struct mesh_config_node *node)
 	if (!len)
 		return false;
 
-	node->netkeys = l_queue_new();
-
 	for (i = 0; i < len; ++i) {
 		json_object *jtemp, *jvalue;
 		char *str;
@@ -480,13 +530,12 @@ static bool read_net_keys(json_object *jobj,  struct mesh_config_node *node)
 		if (!str2hex(str, strlen(str), netkey->key, 16))
 			goto fail;
 
-		l_queue_push_tail(node->netkeys, netkey);
+		cb(netkey, user_data);
 	}
 
 	return true;
 fail:
-	l_queue_destroy(node->netkeys, l_free);
-	node->netkeys = NULL;
+	cb(NULL, user_data);
 
 	return false;
 }
@@ -1294,7 +1343,6 @@ static bool read_net_transmit(json_object *jobj, struct mesh_config_node *node)
 static bool read_node(json_object *jnode, struct mesh_config_node *node)
 {
 	json_object *jvalue;
-	char *str;
 
 	if (!read_iv_index(jnode, &node->iv_index, &node->iv_update)) {
 		l_info("Failed to read IV index");
@@ -1318,14 +1366,7 @@ static bool read_node(json_object *jnode, struct mesh_config_node *node)
 
 	parse_features(jnode, node);
 
-	if (!json_object_object_get_ex(jnode, "unicastAddress", &jvalue)) {
-		l_info("Bad config: Unicast address must be present");
-		return false;
-	}
-
-	str = (char *)json_object_get_string(jvalue);
-	if (sscanf(str, "%04hx", &node->unicast) != 1)
-		return false;
+	read_unicast_address(jnode, &node->unicast);
 
 	if (json_object_object_get_ex(jnode, "defaultTTL", &jvalue)) {
 		int ttl = json_object_get_int(jvalue);
@@ -1335,8 +1376,7 @@ static bool read_node(json_object *jnode, struct mesh_config_node *node)
 		node->ttl = (uint8_t) ttl;
 	}
 
-	if (json_object_object_get_ex(jnode, "sequenceNumber", &jvalue))
-		node->seq_number = json_object_get_int(jvalue);
+	read_seq_number(jnode, &node->seq_number);
 
 	/* Check for required "elements" property */
 	if (!json_object_object_get_ex(jnode, "elements", &jvalue))
@@ -1347,7 +1387,7 @@ static bool read_node(json_object *jnode, struct mesh_config_node *node)
 		return false;
 	}
 
-	if (!read_net_keys(jnode, node)) {
+	if (!read_net_keys(jnode, read_net_key, node)) {
 		l_info("Failed to read net keys");
 		return false;
 	}
-- 
2.19.1

