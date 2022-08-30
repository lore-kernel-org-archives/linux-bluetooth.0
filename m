Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE3BCECAAA1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Aug 2022 23:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbiH3X7C (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Aug 2022 19:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbiH3X6j (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Aug 2022 19:58:39 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896266CD3B
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Aug 2022 16:57:44 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id c2so12625264plo.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Aug 2022 16:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc;
        bh=4tfn7m3NqS7ut1+w6wIWfVXV4ohjJ9x928SO6YWfCfU=;
        b=U37qLcZDKvlAqU6yBmIOxJ8/pRRw7BJT6LWnaSjbpg6B+dxxd9NRDIId3zGna1A44s
         GM0U7ZjIG+2Sv1ibQ+Gj4qXYQJpDfR/riVaR91njz1uQo4NG3mTaZUFFLR+05Mbr/zR8
         6PJs6KDVoXdVPqKjQrUA3OC+1zlW/t6XQL02wOjmFhp0LADVnkEEZMFHSOFzsAIy+k++
         mHRA8DpzP7DcZqZVhlvTxKp/43NGNaFJdn5XX/BRTLPE57DOJ4Xs5jFIEs9eEuJeqSI2
         /11DW5HNln/m733nj8X21nPwEqQxpp5hE30kBGf6vp0xUPk7HkjpMeFYOVxrLYvoqtxt
         x8Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc;
        bh=4tfn7m3NqS7ut1+w6wIWfVXV4ohjJ9x928SO6YWfCfU=;
        b=E9oKyCjjd8Dl1Ij3j5s5gA9yhTqqKAjvyilG2PBuZ8e+skWgLiTBShUf5A5oWzIlxU
         ikO7V55of5Vd/2DlcPe5KdOqf+EzpNo3zKfykT7FVOeZ9HAsa6p59zn/x+J1trFjLIPS
         49UTG9uRu5e1QpFGozSwp68/4q82nmeAfz0tWL9hxu4pOLQZfgJf9KcsADrRZcNHvX3D
         KrnPEdqm8eQfBXhQ87XV6XwLI45ztde4vG13hbhpgjlyEuEDlYPQj8SodmX5HwNJEiT7
         f/VSpDmg3CimFQQ4wj/bADRRoDqnVzv/o0TmF4d3WGTl/R2WXOVQWb82YDLkia3Mzpjl
         E0+Q==
X-Gm-Message-State: ACgBeo1FejpN5wiIyE7MC5QZEmKLMJobCC9j+ZhY0GYOaMBHkGC80CAB
        zMxdUDAfKZ5EINxYbDTxO2YGFCgqdpo=
X-Google-Smtp-Source: AA6agR7yPI6O/S5AlQf7CVlQaIrOH5aJ8xVbPOfh7jnfKSBTfd/Us/NwURhfedvDEvBPY0gFCDn/SQ==
X-Received: by 2002:a17:90a:fb43:b0:1fd:95e6:9e57 with SMTP id iq3-20020a17090afb4300b001fd95e69e57mr488017pjb.234.1661903863497;
        Tue, 30 Aug 2022 16:57:43 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id u11-20020a170902e80b00b001744171a60esm8592936plg.194.2022.08.30.16.57.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 16:57:42 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] media: Fix scan-build warnings
Date:   Tue, 30 Aug 2022 16:57:41 -0700
Message-Id: <20220830235741.1187699-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following warnings:

profiles/audio/media.c:1465:6: warning: 8th function call argument
is an uninitialized value
        if (media_endpoint_create(adapter, sender, path, uuid, delay_reporting,
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
profiles/audio/media.c:3012:3: warning: Use of memory after it is freed
                release_endpoint(adapter->endpoints->data);
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
profiles/audio/media.c:3015:3: warning: Use of memory after it is freed
                media_player_destroy(adapter->players->data);
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
---
 profiles/audio/media.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 85278a6d9be4..1d0fcec48fb6 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -1434,7 +1434,7 @@ static DBusMessage *register_endpoint(DBusConnection *conn, DBusMessage *msg,
 	gboolean delay_reporting = FALSE;
 	uint8_t codec = 0;
 	struct bt_bap_pac_qos qos = {};
-	uint8_t *capabilities;
+	uint8_t *capabilities = NULL;
 	int size = 0;
 	int err;
 
@@ -2998,13 +2998,14 @@ static const GDBusPropertyTable media_properties[] = {
 static void path_free(void *data)
 {
 	struct media_adapter *adapter = data;
+	GSList *l;
 
 	queue_destroy(adapter->apps, app_free);
 
-	while (adapter->endpoints)
-		release_endpoint(adapter->endpoints->data);
+	for (l = adapter->endpoints; l; l = g_slist_next(l))
+		release_endpoint(l->data);
 
-	while (adapter->players)
+	for (l = adapter->players; l; l = g_slist_next(l))
 		media_player_destroy(adapter->players->data);
 
 	adapters = g_slist_remove(adapters, adapter);
-- 
2.37.2

