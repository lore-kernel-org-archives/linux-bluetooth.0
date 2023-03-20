Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5E8C6FD1D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Mar 2023 18:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjCTSFv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Mar 2023 14:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjCTSFT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Mar 2023 14:05:19 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7246F1CAC7
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Mar 2023 10:59:25 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so13325312pjz.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Mar 2023 10:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679335129;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n/GptPbnr37dwYiCB3I0mgHFMK694iBiXXcUmUZ/jNo=;
        b=Gj3v8jcK37QgRVMHy1JVFM699OTdJxdn/zBt8iILvZuzQUbZ8fkew+E3HLog8f8EHy
         Uek5pMdOgWa8tJgZIyRIq8Ad7bjDbG7a4ed0TLAQL+lddO7MenIWiL1pjygFaV72dYW1
         0ogTYEaXbFj2kgBgfX3bNNhs7WT8IliFd94liRHdIGQexOhCH+JPr0+EWGSP6j79VRsX
         Dz/gsp5+X8RDmXHurqsMPimaS9n8C97ruk48Ub+aAILxgBMxIAy/Svtag9cr6LtowGKb
         hR8snSQoAjVbVwufWWWwFQmXmr4Ve5pkxdQS4j+g8FShc5/0oXB8Urb7BqYL3CEAY7tk
         fazQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679335129;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n/GptPbnr37dwYiCB3I0mgHFMK694iBiXXcUmUZ/jNo=;
        b=QwoJdgnMrd/5lpBG0xtysGUhQcZ4bkKW5RLvh8fYfzPqW0dA1fHz95MYAn8wMHEMG9
         N9Wk/PQV30qWHOlHEZoGkIM1U55PxL0dBmJoKzHrIQ3MIvGdo/IlDzD5h8R/rpA1tI/9
         PO1Mt1KeiWIyf4ENu4zA8kfJuYj8bi33b1teJyBTLmv0BS7q4eNsza6y4hiFCHAHoq7Q
         MdG2Pg9yAmbSrVp42B9PGL/VhUsh7pnJ/t3YTCYrh2yIFTq66IsvKvc6T874f/qMLlYu
         KIwHcw3LNHt/VO3CaYWBaL3T9S295PQnBVPhz6p4e0zWgs5nemfDB9tCBt5rhOHHSY9X
         BqVA==
X-Gm-Message-State: AO0yUKXZEZmYDYJ4Q9w/0H55AC/iA9Hi8HEZddqbWWa4lv0Odx7vl7xe
        a6joG3Ml+0C7t8cQUbRdyJhux0i4050PnmQp
X-Google-Smtp-Source: AK7set9o9c6f1JBnW08Apbrv/zose3/RT+HacSdhpBLccDywfG3bz4/Ml81TNfsRdYqkcwuGUbcXYw==
X-Received: by 2002:a17:90b:1a85:b0:23f:3f9c:7878 with SMTP id ng5-20020a17090b1a8500b0023f3f9c7878mr102080pjb.2.1679335128833;
        Mon, 20 Mar 2023 10:58:48 -0700 (PDT)
Received: from fedora.. (c-67-170-58-107.hsd1.wa.comcast.net. [67.170.58.107])
        by smtp.googlemail.com with ESMTPSA id jx21-20020a17090b46d500b0020b21019086sm20832080pjb.3.2023.03.20.10.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 10:58:48 -0700 (PDT)
From:   Inga Stotland <inga.stotland@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@gmail.com, brian.gix@intel.com,
        Inga Stotland <inga.stotland@gmail.com>
Subject: [PATCH BlueZ] tools/mesh-cfgclient: Add local address check
Date:   Mon, 20 Mar 2023 10:58:25 -0700
Message-Id: <20230320175825.321702-1-inga.stotland@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds a check if a request to start scanning for unprovisioned
devices is issued with the local address.
---
 tools/mesh-cfgclient.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/mesh-cfgclient.c b/tools/mesh-cfgclient.c
index 6d2d34409..8369b345d 100644
--- a/tools/mesh-cfgclient.c
+++ b/tools/mesh-cfgclient.c
@@ -58,6 +58,12 @@
 #define DEFAULT_CFG_FILE	"config_db.json"
 #define DEFAULT_EXPORT_FILE	"export_db.json"
 
+/*
+ *The default unicast address assigned to a node generated with
+ * Create() method
+ */
+#define OWN_PRIMARY_ADDR	0x0001
+
 struct meshcfg_el {
 	const char *path;
 	uint8_t index;
@@ -777,7 +783,7 @@ static void attach_node_reply(struct l_dbus_proxy *proxy,
 	}
 
 	/* Read own node composition */
-	if (!cfgcli_get_comp(0x0001, 128))
+	if (!cfgcli_get_comp(OWN_PRIMARY_ADDR, 128))
 		l_error("Failed to read own composition");
 
 	return;
@@ -868,7 +874,7 @@ static void scan_start(void *user_data, uint16_t dst, uint32_t model)
 {
 	struct scan_data *data;
 
-	if (model != (0xffff0000 | RPR_SVR_MODEL))
+	if (model != (0xffff0000 | RPR_SVR_MODEL) || dst != OWN_PRIMARY_ADDR)
 		return;
 
 	data = l_malloc(sizeof(struct scan_data));
@@ -2364,8 +2370,8 @@ static struct l_dbus_message *join_complete(struct l_dbus *dbus,
 	keys_add_net_key(PRIMARY_NET_IDX);
 	mesh_db_add_net_key(PRIMARY_NET_IDX);
 
-	remote_add_node(app.uuid, 0x0001, 1, PRIMARY_NET_IDX);
-	mesh_db_add_node(app.uuid, 0x0001, 1, PRIMARY_NET_IDX);
+	remote_add_node(app.uuid, OWN_PRIMARY_ADDR, 1, PRIMARY_NET_IDX);
+	mesh_db_add_node(app.uuid, OWN_PRIMARY_ADDR, 1, PRIMARY_NET_IDX);
 
 	mesh_db_add_provisioner("BlueZ mesh-cfgclient", app.uuid,
 					low_addr, high_addr,
-- 
2.39.2

