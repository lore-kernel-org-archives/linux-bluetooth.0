Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8187C74A5B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Mar 2023 21:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjCPVdu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Mar 2023 17:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjCPVdt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Mar 2023 17:33:49 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5868915566
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Mar 2023 14:33:47 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id q189so1777981pga.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Mar 2023 14:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679002426;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l8OzTrsEcHCwFQ2aor7oLcsMwgf1mleTA2gfRlLRbWY=;
        b=fLYCqCFWBkm0CKciYfnOJGKIza3CSvnwEv+kCkrv+ZaRT3ZXEwWsGJ6vFh/v1QqWrn
         Yb31EZ7pQCfXg+tEdoR038DfGk8PG5K8IwWp9k0zzdlUIzxCxueNbppCN71sAQPIzLkG
         dz5VvK7zzsReMTVGfWC/c5Rzx2Yd+FOyxthkJKbKU+IPai/GzZ4AipYQm5I1FMYpkvY3
         5PZK+OZWxNss6Rt+HUCOgpxDqzJA5mLU6LPeR1HHxa2SSWBzoGc91W4h9CBQztVnNpeh
         pFpfBFQIRxFJuqhkWmZlSqUGJO3pa/obAu+6zWbdW7Ot0/GgQM/5zrIon0MHwI2S++eN
         ZVcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679002426;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l8OzTrsEcHCwFQ2aor7oLcsMwgf1mleTA2gfRlLRbWY=;
        b=o35+9cvvUOvITr2t1BY61GFvnKjJTkoCZoz+ACqOo9rZAPRJ2QNvgZGcXw77OWiTN7
         Mpz+nojbXSB2gRwyWPpHPBmwudh/0u1tdedDOdYATMkoirkiUWy1clErMtjfLf+hTHLD
         a+tFUwn6K+ONofdvfermYo66mNsPCuVQwmNrky9Gtqq3MqE6SOb6qzSwR+C7PQgt1nAz
         7+dyUxeQfysvlCDwSn7//y/BplGLoREfjnjWXc9DBa55ZeiUOVCPzqDeykrSEh/IqNPG
         raeEECmt6z/wayRUvo0AuVO5KEZJH4OerXXwP5k+XqwhsKN+00XthVW74xhjgD0SiwMR
         q+mw==
X-Gm-Message-State: AO0yUKWoJC5Rbv4M7DoSGCmVHKsPzYyjO+V0IL1eZjCclttSOkabmRqA
        hLYG4desnJ4OFs8IMzwPN+17lnCuH6J0cjJE
X-Google-Smtp-Source: AK7set/lTL35oMTLdB93doe8ppjlTxKnmqM/ddtrirU+67pl6BCjTIbZ32xnVDqE7J33cmpMps4Hrg==
X-Received: by 2002:aa7:9736:0:b0:5aa:4df7:7eef with SMTP id k22-20020aa79736000000b005aa4df77eefmr4187673pfg.6.1679002426557;
        Thu, 16 Mar 2023 14:33:46 -0700 (PDT)
Received: from fedora.. (c-67-170-58-107.hsd1.wa.comcast.net. [67.170.58.107])
        by smtp.googlemail.com with ESMTPSA id k17-20020a63d111000000b004fbb4a55b64sm95195pgg.86.2023.03.16.14.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 14:33:46 -0700 (PDT)
From:   Inga Stotland <inga.stotland@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@gmail.com, brian.gix@intel.com,
        Inga Stotland <inga.stotland@gmail.com>
Subject: [PATCH BlueZ v2 1/2] tools/mesh-cfgclient: Prevent storing duplicate models
Date:   Thu, 16 Mar 2023 14:33:11 -0700
Message-Id: <20230316213312.159370-1-inga.stotland@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This fixes the situation when subsequent requests to get a node
composition result in appending element's model list with duplicate models.
This adds a check for a presence of a model on an element when attempting
to add a new model ID to a model list on this element.
---
 tools/mesh/mesh-db.c | 17 ++++++++++++-----
 tools/mesh/remote.c  |  9 +++++++++
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/tools/mesh/mesh-db.c b/tools/mesh/mesh-db.c
index c0c05a29a..1d047691d 100644
--- a/tools/mesh/mesh-db.c
+++ b/tools/mesh/mesh-db.c
@@ -1964,28 +1964,35 @@ bool mesh_db_node_set_composition(uint16_t unicast, uint8_t *data, uint16_t len)
 
 		while (len >= 2 && m--) {
 			mod_id = l_get_le16(data);
+			data += 2;
+			len -= 2;
+
+			jobj = get_model(unicast, unicast + i, mod_id, false);
+			if (jobj)
+				continue;
 
 			jobj = init_model(mod_id);
 			if (!jobj)
 				goto fail;
 
 			json_object_array_add(jmods, jobj);
-			data += 2;
-			len -= 2;
 		}
 
 		while (len >= 4 && v--) {
 			mod_id = l_get_le16(data + 2);
 			mod_id = l_get_le16(data) << 16 | mod_id;
+			data += 4;
+			len -= 4;
+
+			jobj = get_model(unicast, unicast + i, mod_id, true);
+			if (jobj)
+				continue;
 
 			jobj = init_vendor_model(mod_id);
 			if (!jobj)
 				goto fail;
 
 			json_object_array_add(jmods, jobj);
-
-			data += 4;
-			len -= 4;
 		}
 
 		i++;
diff --git a/tools/mesh/remote.c b/tools/mesh/remote.c
index cee711dec..b917ae9df 100644
--- a/tools/mesh/remote.c
+++ b/tools/mesh/remote.c
@@ -54,6 +54,11 @@ struct rejected_addr {
 static struct l_queue *nodes;
 static struct l_queue *reject_list;
 
+static bool match_mod_id(const void *a, const void *b)
+{
+	return a == b;
+}
+
 static int compare_mod_id(const void *a, const void *b, void *user_data)
 {
 	uint32_t id1 = L_PTR_TO_UINT(a);
@@ -227,6 +232,10 @@ bool remote_set_model(uint16_t unicast, uint8_t ele_idx, uint32_t mod_id,
 	if (!vendor)
 		mod_id = VENDOR_ID_MASK | mod_id;
 
+	if (l_queue_find(rmt->els[ele_idx], match_mod_id,
+							L_UINT_TO_PTR(mod_id)))
+		return true;
+
 	l_queue_insert(rmt->els[ele_idx], L_UINT_TO_PTR(mod_id),
 							compare_mod_id, NULL);
 
-- 
2.39.2

