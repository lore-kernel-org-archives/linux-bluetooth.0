Return-Path: <SRS0=8Xmo=2A=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81807C43603
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Dec 2019 17:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60D91207FF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Dec 2019 17:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbfLJRpY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Dec 2019 12:45:24 -0500
Received: from mga11.intel.com ([192.55.52.93]:34305 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727527AbfLJRpX (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Dec 2019 12:45:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2019 09:45:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,300,1571727600"; 
   d="scan'208";a="413195329"
Received: from ingas-nuc1.sea.intel.com ([10.254.187.166])
  by fmsmga005.fm.intel.com with ESMTP; 10 Dec 2019 09:45:23 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v2] tools/mesh-cfgclient: Fix appkey/netkey commands
Date:   Tue, 10 Dec 2019 09:45:22 -0800
Message-Id: <20191210174522.14155-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This fixes the checks for the presence of AppKeys and Netkeys.
---
 tools/mesh/keys.c   | 25 ++++++++++++++++---------
 tools/mesh/remote.c | 17 +++++++++++++----
 2 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/tools/mesh/keys.c b/tools/mesh/keys.c
index 0ce8ce811..77b32da63 100644
--- a/tools/mesh/keys.c
+++ b/tools/mesh/keys.c
@@ -37,9 +37,18 @@ struct net_key {
 
 static struct l_queue *net_keys;
 
-static bool simple_match(const void *a, const void *b)
+static bool app_key_present(const struct net_key *key, uint16_t app_idx)
 {
-	return a == b;
+	const struct l_queue_entry *l;
+
+	for (l = l_queue_get_entries(key->app_keys); l; l = l->next) {
+		uint16_t idx = L_PTR_TO_UINT(l->data);
+
+		if (idx == app_idx)
+			return true;
+	}
+
+	return false;
 }
 
 static bool net_idx_match(const void *a, const void *b)
@@ -102,7 +111,7 @@ void keys_add_app_key(uint16_t net_idx, uint16_t app_idx)
 	if (!key->app_keys)
 		key->app_keys = l_queue_new();
 
-	if (l_queue_find(key->app_keys, simple_match, L_UINT_TO_PTR(app_idx)))
+	if (app_key_present(key, app_idx))
 		return;
 
 	l_queue_push_tail(key->app_keys, L_UINT_TO_PTR(app_idx));
@@ -121,8 +130,7 @@ void keys_del_app_key(uint16_t app_idx)
 		if (!key->app_keys)
 			continue;
 
-		if (l_queue_remove_if(key->app_keys, simple_match,
-							L_UINT_TO_PTR(app_idx)))
+		if (l_queue_remove(key->app_keys, L_UINT_TO_PTR(app_idx)))
 			return;
 	}
 }
@@ -140,8 +148,7 @@ uint16_t keys_get_bound_key(uint16_t app_idx)
 		if (!key->app_keys)
 			continue;
 
-		if (l_queue_find(key->app_keys, simple_match,
-							L_UINT_TO_PTR(app_idx)))
+		if (app_key_present(key, app_idx))
 			return key->idx;
 	}
 
@@ -152,14 +159,14 @@ static void print_appkey(void *app_key, void *user_data)
 {
 	uint16_t app_idx = L_PTR_TO_UINT(app_key);
 
-	bt_shell_printf("%3.3x, ", app_idx);
+	bt_shell_printf("0x%3.3x, ", app_idx);
 }
 
 static void print_netkey(void *net_key, void *user_data)
 {
 	struct net_key *key = net_key;
 
-	bt_shell_printf(COLOR_YELLOW "NetKey: %3.3x\n" COLOR_OFF, key->idx);
+	bt_shell_printf(COLOR_YELLOW "NetKey: 0x%3.3x\n" COLOR_OFF, key->idx);
 
 	if (!key->app_keys || l_queue_isempty(key->app_keys))
 		return;
diff --git a/tools/mesh/remote.c b/tools/mesh/remote.c
index 673c7b0fb..25e8d23f8 100644
--- a/tools/mesh/remote.c
+++ b/tools/mesh/remote.c
@@ -41,9 +41,18 @@ struct remote_node {
 
 static struct l_queue *nodes;
 
-static bool simple_match(const void *a, const void *b)
+static bool key_present(struct l_queue *keys, uint16_t app_idx)
 {
-	return a == b;
+	const struct l_queue_entry *l;
+
+	for (l = l_queue_get_entries(keys); l; l = l->next) {
+		uint16_t idx = L_PTR_TO_UINT(l->data);
+
+		if (idx == app_idx)
+			return true;
+	}
+
+	return false;
 }
 
 static int compare_unicast(const void *a, const void *b, void *user_data)
@@ -104,7 +113,7 @@ bool remote_add_net_key(uint16_t addr, uint16_t net_idx)
 	if (!rmt)
 		return false;
 
-	if (l_queue_find(rmt->net_keys, simple_match, L_UINT_TO_PTR(net_idx)))
+	if (key_present(rmt->net_keys, net_idx))
 		return false;
 
 	l_queue_push_tail(rmt->net_keys, L_UINT_TO_PTR(net_idx));
@@ -146,7 +155,7 @@ bool remote_add_app_key(uint16_t addr, uint16_t app_idx)
 	if (!rmt->app_keys)
 		rmt->app_keys = l_queue_new();
 
-	if (l_queue_find(rmt->app_keys, simple_match, L_UINT_TO_PTR(app_idx)))
+	if (key_present(rmt->app_keys, app_idx))
 		return false;
 
 	l_queue_push_tail(rmt->app_keys, L_UINT_TO_PTR(app_idx));
-- 
2.21.0

