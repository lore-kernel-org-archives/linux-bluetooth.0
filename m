Return-Path: <SRS0=nALV=6T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F29C47247
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 May 2020 17:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 807852083B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 May 2020 17:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730282AbgEERnF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 May 2020 13:43:05 -0400
Received: from mga11.intel.com ([192.55.52.93]:33194 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729315AbgEERnF (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 May 2020 13:43:05 -0400
IronPort-SDR: QbHZGIIVmW3tFPFmsKex587tj3Xaf3ig112c5eAMxoYebGosS7MeiOmxsiNvRdJ44EixZ69kVh
 gyuVM6i8DTEQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2020 10:43:04 -0700
IronPort-SDR: XHYYBun/6l7Eyi9aB6WQA/0cBFqY1pukw41RCQcXkBLGo/qdcW9PRqHiivU5zbeKdbHuR0E4S7
 YuJcmpDplVag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,356,1583222400"; 
   d="scan'208";a="284331538"
Received: from ingas-nuc1.sea.intel.com ([10.254.75.233])
  by fmsmga004.fm.intel.com with ESMTP; 05 May 2020 10:43:04 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] tools/mesh-cfgclient: Fix saving KR phase to config file
Date:   Tue,  5 May 2020 10:43:03 -0700
Message-Id: <20200505174303.6224-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This eliminates extra write of KR phase when loading keys
from the configuration file on initialization.
---
 tools/mesh-cfgclient.c | 4 ++--
 tools/mesh/keys.c      | 4 ++--
 tools/mesh/keys.h      | 2 +-
 tools/mesh/mesh-db.c   | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/mesh-cfgclient.c b/tools/mesh-cfgclient.c
index 6db65cd49..d7318ffb7 100644
--- a/tools/mesh-cfgclient.c
+++ b/tools/mesh-cfgclient.c
@@ -944,7 +944,7 @@ static void subnet_set_phase_reply(struct l_dbus_proxy *proxy,
 	if (phase == KEY_REFRESH_PHASE_THREE)
 		phase = KEY_REFRESH_PHASE_NONE;
 
-	keys_set_net_key_phase(net_idx, phase);
+	keys_set_net_key_phase(net_idx, phase, true);
 }
 
 static void subnet_set_phase_setup(struct l_dbus_message *msg, void *user_data)
@@ -1014,7 +1014,7 @@ static void mgr_key_reply(struct l_dbus_proxy *proxy,
 		keys_del_net_key(idx);
 		mesh_db_net_key_del(idx);
 	} else if (!strcmp("UpdateSubnet", method)) {
-		keys_set_net_key_phase(idx, KEY_REFRESH_PHASE_ONE);
+		keys_set_net_key_phase(idx, KEY_REFRESH_PHASE_ONE, true);
 	} else if (!strcmp("DeleteAppKey", method)) {
 		keys_del_app_key(idx);
 		mesh_db_app_key_del(idx);
diff --git a/tools/mesh/keys.c b/tools/mesh/keys.c
index b7d36599a..ff3b23f61 100644
--- a/tools/mesh/keys.c
+++ b/tools/mesh/keys.c
@@ -99,7 +99,7 @@ void keys_del_net_key(uint16_t idx)
 	l_free(key);
 }
 
-void keys_set_net_key_phase(uint16_t net_idx, uint8_t phase)
+void keys_set_net_key_phase(uint16_t net_idx, uint8_t phase, bool save)
 {
 	struct net_key *key;
 
@@ -112,7 +112,7 @@ void keys_set_net_key_phase(uint16_t net_idx, uint8_t phase)
 
 	key->phase = phase;
 
-	if (!mesh_db_net_key_phase_set(net_idx, phase))
+	if (save && !mesh_db_net_key_phase_set(net_idx, phase))
 		bt_shell_printf("Failed to save updated KR phase\n");
 }
 
diff --git a/tools/mesh/keys.h b/tools/mesh/keys.h
index 3a90fa14b..fa51044ef 100644
--- a/tools/mesh/keys.h
+++ b/tools/mesh/keys.h
@@ -20,7 +20,7 @@
 
 void keys_add_net_key(uint16_t net_idx);
 void keys_del_net_key(uint16_t net_idx);
-void keys_set_net_key_phase(uint16_t net_idx, uint8_t phase);
+void keys_set_net_key_phase(uint16_t net_idx, uint8_t phase, bool save);
 bool keys_get_net_key_phase(uint16_t net_idx, uint8_t *phase);
 void keys_add_app_key(uint16_t net_idx, uint16_t app_idx);
 void keys_del_app_key(uint16_t app_idx);
diff --git a/tools/mesh/mesh-db.c b/tools/mesh/mesh-db.c
index 3bd6b0d06..d39435ca0 100644
--- a/tools/mesh/mesh-db.c
+++ b/tools/mesh/mesh-db.c
@@ -607,7 +607,7 @@ static bool load_keys(json_object *jobj)
 		if (!get_int(jentry, "phase", &phase))
 			return false;
 
-		keys_set_net_key_phase(net_idx, (uint8_t) phase);
+		keys_set_net_key_phase(net_idx, (uint8_t) phase, false);
 	}
 
 	json_object_object_get_ex(jobj, "appKeys", &jarray);
-- 
2.21.1

