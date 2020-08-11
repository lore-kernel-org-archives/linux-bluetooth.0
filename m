Return-Path: <SRS0=5Aiy=BV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7AC6C433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Aug 2020 20:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C40F720786
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Aug 2020 20:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="NHodcNmi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbgHKUGP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 Aug 2020 16:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbgHKUGN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 Aug 2020 16:06:13 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B078DC06174A
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2020 13:06:12 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id 140so7351422lfi.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2020 13:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UDIw5818LlvGzqFPAaCDNYzmCD84cqoJl5mgh1begB4=;
        b=NHodcNmiZDOWn+ObWKGqBMNxRMC90r+5TaIFqA966ywcoZVn7PbkYmFG0YtmPyNodx
         tVCTbK7YQ6CWUEuk+2LHwJPSHqQMZqWOPrpe+LVpslQSFQBRB/3iiR8LTlocNJ0gKbyp
         S5Try9e4XH3cif4jf8l8XtyEDPE0FFX7EyM8SiifKUFb+kQH/uwcM27GaTLtpURo3MbF
         w9usw26ONyzlMoyF9M9tnxan8kL5vEb5qONkRV2KYYJ3XPfHHExUR+zoptoJG+UlfHC/
         8sr5VK2a03CMTuXAjlRRJFjeGcMzco5fY0D3Q8tWYu+Ge8TqYk1+kaul8Xz63s3/T3u+
         G/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UDIw5818LlvGzqFPAaCDNYzmCD84cqoJl5mgh1begB4=;
        b=DH92VFnaZJgsE46sxY9lB12ODOzhbZz3Xx4aB6Hh8vwP1R4yBWjhOsI6XQ6QQyl8nH
         vwxzMr4vQOc+sEW3qIXPTRiPvRxUdlVsmD92EcpcQLvpxf+7kYapnrnc+955bSsWegtB
         ffsiHdtOx6DttcO5uF2JMD1Z3rkGxOzI6O9/EdnRFJqepXQdOz7iIoI/GTLKB+33YVQt
         n3qy2Ow9/9J3y0wz1mBsvuYZUMawYZznirdaCtI9Q0aKYZGQcOZ8RcV7nBJ2zkTMXAeZ
         ToCOcgPUwgdP3dtYLqCt15a0fPbZdFso4iWQ6ubGh9qESjeSWeaZj7qUsmounFnss+Zc
         83Lw==
X-Gm-Message-State: AOAM533zgY7dfIkKKYMmMZdKaewhftn35aPd7iywOLJmdtYQBCh/v7hl
        lRxW1zck3Rmnm6HkTRCttiIgK2ehR7EAqg==
X-Google-Smtp-Source: ABdhPJxYIz6/B5heg55WcK2Y9HbB70V1JSyfK9zpDj7UI/Dm2fuONjE2JmuW4tQdP09XEG5xHKAL9Q==
X-Received: by 2002:a19:c206:: with SMTP id l6mr3909340lfc.152.1597176370819;
        Tue, 11 Aug 2020 13:06:10 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id 132sm11902805lfo.16.2020.08.11.13.06.09
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 13:06:10 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] mesh: Fix lookup of non-vendor models in node config
Date:   Tue, 11 Aug 2020 22:07:12 +0200
Message-Id: <20200811200712.21083-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In commit 81a0868b082c ("mesh: Move model functionality out of node.c
to model.c"), we changed the way we handle model ids, resulting
in vendor mask not being stripped from model id before update_bindings()
calls mesh_config_model_binding_*().

This resulted in get_element_model not finding the model.
---
 mesh/mesh-config-json.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/mesh/mesh-config-json.c b/mesh/mesh-config-json.c
index ae1099fcb..ce8dd5cde 100644
--- a/mesh/mesh-config-json.c
+++ b/mesh/mesh-config-json.c
@@ -170,11 +170,6 @@ static json_object *get_element_model(json_object *jnode, int ele_idx,
 	size_t len;
 	char buf[9];
 
-	if (!vendor)
-		snprintf(buf, 5, "%4.4x", (uint16_t)mod_id);
-	else
-		snprintf(buf, 9, "%8.8x", mod_id);
-
 	if (!json_object_object_get_ex(jnode, "elements", &jelements))
 		return NULL;
 
@@ -190,7 +185,7 @@ static json_object *get_element_model(json_object *jnode, int ele_idx,
 		return NULL;
 
 	if (!vendor) {
-		snprintf(buf, 5, "%4.4x", mod_id);
+		snprintf(buf, 5, "%4.4x", (uint16_t)mod_id);
 		len = 4;
 	} else {
 		snprintf(buf, 9, "%8.8x", mod_id);
-- 
2.20.1

