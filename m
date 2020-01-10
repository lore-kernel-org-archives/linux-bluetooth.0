Return-Path: <SRS0=nFDS=27=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455CDC32771
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Jan 2020 01:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1190B20678
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Jan 2020 01:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730601AbgAJBxV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Jan 2020 20:53:21 -0500
Received: from mga04.intel.com ([192.55.52.120]:13798 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730359AbgAJBxV (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Jan 2020 20:53:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2020 17:53:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,414,1571727600"; 
   d="scan'208";a="229621287"
Received: from ingas-nuc1.sea.intel.com ([10.254.104.252])
  by fmsmga001.fm.intel.com with ESMTP; 09 Jan 2020 17:53:21 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] tools/mesh: Remove node's appkeys when deleting a netkey
Date:   Thu,  9 Jan 2020 17:53:20 -0800
Message-Id: <20200110015320.2160-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When a netkey is deleted from a remote node, all the appkeys bound
to this netkey are expected to be deleted as well.
This fixes app_key queue manipulation to avoid issues caused by modifying
the queue while iterating over it: instead of iteration over all the
entries, find a first bound key, delete it, find next... and so on,
until there are no bound keys left in the app_keys queue.
---
 tools/mesh/remote.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/tools/mesh/remote.c b/tools/mesh/remote.c
index 25e8d23f8..533d59b28 100644
--- a/tools/mesh/remote.c
+++ b/tools/mesh/remote.c
@@ -2,7 +2,7 @@
  *
  *  BlueZ - Bluetooth protocol stack for Linux
  *
- *  Copyright (C) 2019  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2019-2020  Intel Corporation. All rights reserved.
  *
  *
  *  This library is free software; you can redistribute it and/or
@@ -81,6 +81,14 @@ static bool match_node_addr(const void *a, const void *b)
 	return false;
 }
 
+static bool match_bound_key(const void *a, const void *b)
+{
+	uint16_t app_idx = L_PTR_TO_UINT(a);
+	uint16_t net_idx = L_PTR_TO_UINT(b);
+
+	return (net_idx == keys_get_bound_key(app_idx));
+}
+
 bool remote_add_node(const uint8_t uuid[16], uint16_t unicast,
 					uint8_t ele_cnt, uint16_t net_idx)
 {
@@ -123,7 +131,7 @@ bool remote_add_net_key(uint16_t addr, uint16_t net_idx)
 bool remote_del_net_key(uint16_t addr, uint16_t net_idx)
 {
 	struct remote_node *rmt;
-	const struct l_queue_entry *l;
+	void *data;
 
 	rmt = l_queue_find(nodes, match_node_addr, L_UINT_TO_PTR(addr));
 	if (!rmt)
@@ -132,13 +140,14 @@ bool remote_del_net_key(uint16_t addr, uint16_t net_idx)
 	if (!l_queue_remove(rmt->net_keys, L_UINT_TO_PTR(net_idx)))
 		return false;
 
-	for (l = l_queue_get_entries(rmt->app_keys); l; l = l->next) {
-		uint16_t app_idx = (uint16_t) L_PTR_TO_UINT(l->data);
+	data = l_queue_remove_if(rmt->app_keys, match_bound_key,
+						L_UINT_TO_PTR(net_idx));
+	while (data) {
+		uint16_t app_idx = (uint16_t) L_PTR_TO_UINT(data);
 
-		if (net_idx == keys_get_bound_key(app_idx)) {
-			l_queue_remove(rmt->app_keys, L_UINT_TO_PTR(app_idx));
-			mesh_db_node_app_key_del(rmt->unicast, app_idx);
-		}
+		mesh_db_node_app_key_del(rmt->unicast, app_idx);
+		data = l_queue_remove_if(rmt->app_keys, match_bound_key,
+						L_UINT_TO_PTR(net_idx));
 	}
 
 	return true;
-- 
2.21.1

