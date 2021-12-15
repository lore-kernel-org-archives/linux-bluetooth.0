Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B4AC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Dec 2021 18:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238624AbhLOSFf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Dec 2021 13:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238548AbhLOSFf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Dec 2021 13:05:35 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A24C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Dec 2021 10:05:34 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id p4so20869201qkm.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Dec 2021 10:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WzxZL4l5R6ts/fPpupWhyxWlsIqZXsvO0znib5BYagY=;
        b=cixRL60axijsWU7DIzBwT97S4/c+yjmUIsFnZ6yoviOv/waRDAyCSV4sWXgDiRjAf1
         O7svbxL5x3F/o4iho2+7lBYItvgmKjliS7UjIr0G83jcy8RTzdAqsZ3c5rdZKto0Lytk
         +2vtMZivs0c+e71mxWc6hMkh2B9qZ3htg70AzGRjyNPTa6q7c9Heea+CyNGOiNflgzhf
         rojtSfT+g12Ulvkd3FyowAovnY9QVz31AJrtwUwvbg9AfN9vKOzA0558slTXVzwjoeTg
         hNsZWUVo2UzePxrA1Vzm4tVNEg56/GbaFP5LFAmQRG52+iyg+Goh6whtb8N6BYvp3mwy
         Ujng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WzxZL4l5R6ts/fPpupWhyxWlsIqZXsvO0znib5BYagY=;
        b=b75RjE9lDoa8IicTWcmKGzBlUsTBTySmVAHbnMCtC/EgfvMWeKO/K/Z+vR91DGF8tw
         YdvDggRno9S2P1HpvZ7+64/LJ+2OmartC/robdTJlauGRFhLCVWJdTAH+128rUe8EF0/
         KVPHRO7wUIq0+gExuVQ50OwoIdojoRaQfXeW4Re+SrQ6HAOLcl+K4ocoOq6DIR4uxLHl
         2ciOcVndQYBSuONuQY/RivKAkg/1XjcTkP8E9lSrH+bgfN7Hory0iDX+2p3P79dc9IVF
         SUPwMrw9C5NTnm8h5P+bjhaKX/bdf/0fjb/nhG03E+by7N61ZA8MCvkns7/K5FNQQzUB
         ZLbw==
X-Gm-Message-State: AOAM533siNclujKt5SQVOMGi7aZ3h+pVrRdQUGjFGoKvdnsd3GhsPjon
        t5vUVR65rVGNDyshI4X7tlrHkJmIIbaAtw==
X-Google-Smtp-Source: ABdhPJyqJ/etDdZv6J8bYLMzuysR0R7IHnJmVPYVpIEohYV2E/A1nB6onpXBSep8K/+rq547JBb3LQ==
X-Received: by 2002:a05:620a:2494:: with SMTP id i20mr9676259qkn.624.1639591533091;
        Wed, 15 Dec 2021 10:05:33 -0800 (PST)
Received: from muritiba.. ([2001:1284:f034:8983:27b8:3d96:8ad9:6154])
        by smtp.googlemail.com with ESMTPSA id y12sm1438755qko.36.2021.12.15.10.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 10:05:32 -0800 (PST)
From:   Claudio Takahasi <claudio.takahasi@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Claudio Takahasi <claudio.takahasi@gmail.com>
Subject: [PATCH BlueZ] advertising: Fix reporting advertising properties
Date:   Wed, 15 Dec 2021 15:05:27 -0300
Message-Id: <20211215180527.886481-1-claudio.takahasi@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

InterfacesAdded signal for LEAdvertisingManager1 might be emitted
containing initial/default properties values and property changed is
not emitted after reading advertising features. This patch registers
the interface (LEAdvertisingManager1) after reading advertising features
from kernel.
---
 src/advertising.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/src/advertising.c b/src/advertising.c
index 41b818650..2110f17c9 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -1786,6 +1786,13 @@ static void read_adv_features_callback(uint8_t status, uint16_t length,
 	manager->max_ads = feat->max_instances;
 	manager->supported_flags |= feat->supported_flags;
 
+	/* Registering interface after querying properties */
+	if (!g_dbus_register_interface(btd_get_dbus_connection(),
+				       adapter_get_path(manager->adapter),
+				       LE_ADVERTISING_MGR_IFACE, methods,
+				       NULL, properties, manager, NULL))
+		error("Failed to register " LE_ADVERTISING_MGR_IFACE);
+
 	if (manager->max_ads == 0)
 		return;
 
@@ -1861,14 +1868,6 @@ static struct btd_adv_manager *manager_create(struct btd_adapter *adapter,
 	manager->min_tx_power = ADV_TX_POWER_NO_PREFERENCE;
 	manager->max_tx_power = ADV_TX_POWER_NO_PREFERENCE;
 
-	if (!g_dbus_register_interface(btd_get_dbus_connection(),
-					adapter_get_path(manager->adapter),
-					LE_ADVERTISING_MGR_IFACE, methods,
-					NULL, properties, manager, NULL)) {
-		error("Failed to register " LE_ADVERTISING_MGR_IFACE);
-		goto fail;
-	}
-
 	if (!mgmt_send(manager->mgmt, MGMT_OP_READ_ADV_FEATURES,
 				manager->mgmt_index, 0, NULL,
 				read_adv_features_callback, manager, NULL)) {
-- 
2.30.2

