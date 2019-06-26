Return-Path: <SRS0=cKDh=UZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8000C48BD6
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Jun 2019 15:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B241721738
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Jun 2019 15:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="jU+O0mkA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfFZPtM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Jun 2019 11:49:12 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35194 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfFZPtM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Jun 2019 11:49:12 -0400
Received: by mail-lj1-f194.google.com with SMTP id x25so2753057ljh.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jun 2019 08:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5CaAXIO7GXVzTvg3R8ybpwDqOvousH8Bi86lmEZWwdc=;
        b=jU+O0mkAfj/jWmvDelrA/Hsoy1e+m+o3UawgPZtqzizgVfMf8xevPeVaTJhRwBGQpQ
         dRlIloFr6I944RvrE5ibyPfDOzXCeCQzFw7itaLP41Z2lbmkrL265fU8XNE4f80mOHqA
         iWjeWLTzmTJGouyTtxOpgeNXnWrVKnQYeuPpnBBlH3ZcB23CfdnM764p0V1XjC23PERE
         DDrMe2uiRAPg3OZSSUQWeXBu6AbCU+tlbihpMFhmgY6ZLiUsT/lcY7bwiJv0w/143bjo
         xWrEDq1EuZZMB8l5J2gh3M12/GffWvcpRhBKZZn4BRtZQOlR5TcF7TmS5FN7O4pPobQ0
         Moug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5CaAXIO7GXVzTvg3R8ybpwDqOvousH8Bi86lmEZWwdc=;
        b=qy44Hwvg+DOAxeBTOKCY8dZmTmpZK4n+V/PfOUtIe9wvLJX+LFuuQtqo2t2X4I3yYI
         QjGBhznMsb0y7bgYrS7ITBrbHbDuOFKFRToQOnqVCty8tCvnEQXL7i6N8aLDHyNlwNV/
         AaCvhNi03uED3cAlY2uVxjnFmTp4ofjpvDIr0Ku9a+QmNF/DAiy3/lsbmorefO2KD3jO
         GpTkIcrVdnQ4skMW9JkIPCTgrUE0y6FSZ4acAbT/22lnJ9LSswIOgE4yjTEpE9c1FShB
         STuPhuweyHbRCuRRonSCN/gmVYehx6fXYlg/FMNg/6tXimYvq0I9DPY7XEu5lvE2Q/u4
         7cVg==
X-Gm-Message-State: APjAAAUnBChPq77kJ5uOe/4Zd/1P07YhU4mR+zyk/hR7HPLJp62gAe/z
        FPMhCUDQ1UsuvpQg+tbe5OTNG0MVrms=
X-Google-Smtp-Source: APXvYqw5GAWSJlJRUjmw4R334poA/3F0cKP51tb1fASaa90PszDaeX3QsfBUcJZwybxg3a/r8b9yjQ==
X-Received: by 2002:a2e:7614:: with SMTP id r20mr3540783ljc.42.1561564149839;
        Wed, 26 Jun 2019 08:49:09 -0700 (PDT)
Received: from localhost.localdomain ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id h22sm2893031ljj.105.2019.06.26.08.49.08
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 08:49:09 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Gajda?= <rafal.gajda@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] mesh: Fix to duplicated model Ids saved to storage
Date:   Wed, 26 Jun 2019 17:49:02 +0200
Message-Id: <20190626154902.18904-1-rafal.gajda@silvair.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

BlueZ internally implements a SIG model for Config Server.

When generating node, if the Mesh Element in mesh application returns modelId 0
among its supported models, it should be skipped, otherwise it will be
duplicated and saved in the storage file.

This patch fixes correctly skipping Config Server model during node creation.
---
 mesh/node.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mesh/node.c b/mesh/node.c
index e99858623..4e35bb3ff 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -1061,10 +1061,9 @@ static bool validate_model_property(struct node_element *ele,
 		/* Bluetooth SIG defined models */
 		while (l_dbus_message_iter_next_entry(&ids, &mod_id)) {
 			struct mesh_model *mod;
-			uint32_t m = mod_id;
 
 			/* Skip internally implemented models */
-			if (m == CONFIG_SRV_MODEL)
+			if ((VENDOR_ID_MASK | mod_id) == CONFIG_SRV_MODEL)
 				continue;
 
 			mod = l_queue_find(ele->models, match_model_id,
@@ -1078,6 +1077,7 @@ static bool validate_model_property(struct node_element *ele,
 		while (l_dbus_message_iter_next_entry(&ids, &vendor_id,
 								&mod_id)) {
 			struct mesh_model *mod;
+
 			mod = l_queue_find(ele->models, match_model_id,
 				L_UINT_TO_PTR((vendor_id << 16) | mod_id));
 			if (!mod)
@@ -1108,10 +1108,9 @@ static void get_models_from_properties(struct node_element *ele,
 	if (!vendor) {
 		while (l_dbus_message_iter_next_entry(&ids, &mod_id)) {
 			struct mesh_model *mod;
-			uint32_t m = mod_id;
 
 			/* Skip internally implemented models */
-			if (m == CONFIG_SRV_MODEL)
+			if ((VENDOR_ID_MASK | mod_id) == CONFIG_SRV_MODEL)
 				continue;
 
 			mod = mesh_model_new(ele->idx, mod_id);
-- 
2.22.0

