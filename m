Return-Path: <SRS0=pKZ6=Z5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8270C43603
	for <linux-bluetooth@archiver.kernel.org>; Sat,  7 Dec 2019 06:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79E2A21835
	for <linux-bluetooth@archiver.kernel.org>; Sat,  7 Dec 2019 06:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbfLGGMw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 7 Dec 2019 01:12:52 -0500
Received: from mga03.intel.com ([134.134.136.65]:58465 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbfLGGMw (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 7 Dec 2019 01:12:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Dec 2019 22:12:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,286,1571727600"; 
   d="scan'208";a="386714185"
Received: from aishii-mobl1.gar.corp.intel.com (HELO ingas-nuc1.sea.intel.com) ([10.252.128.120])
  by orsmga005.jf.intel.com with ESMTP; 06 Dec 2019 22:12:52 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] tools/mesh-cfgclient: Disallow sending a non-existing key
Date:   Fri,  6 Dec 2019 22:12:45 -0800
Message-Id: <20191207061245.6845-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Prior to sending either NetKeyAdd or AppKeyAdd message to a
remote node, check if the key exists locally.
---
 tools/mesh-cfgclient.c | 14 +++++++++++++-
 tools/mesh/keys.c      |  8 ++++++++
 tools/mesh/keys.h      |  1 +
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/tools/mesh-cfgclient.c b/tools/mesh-cfgclient.c
index 200eb5b84..b4d76de93 100644
--- a/tools/mesh-cfgclient.c
+++ b/tools/mesh-cfgclient.c
@@ -316,8 +316,20 @@ static bool send_key(void *user_data, uint16_t dst, uint16_t key_idx,
 	const char *method_name = (!is_appkey) ? "AddNetKey" : "AddAppKey";
 
 	net_idx = remote_get_subnet_idx(dst);
-	if (net_idx == NET_IDX_INVALID)
+	if (net_idx == NET_IDX_INVALID) {
+		bt_shell_printf("Node %4.4x not found\n", dst);
 		return false;
+	}
+
+	if (!is_appkey && !keys_subnet_exists(key_idx)) {
+		bt_shell_printf("Local NetKey %u not found\n", key_idx);
+		return false;
+	}
+
+	if (is_appkey && (keys_get_bound_key(key_idx) == NET_IDX_INVALID)) {
+		bt_shell_printf("Local AppKey %u not found\n", key_idx);
+		return false;
+	}
 
 	req = l_new(struct key_data, 1);
 	req->ele_path = user_data;
diff --git a/tools/mesh/keys.c b/tools/mesh/keys.c
index 7d2058294..0ce8ce811 100644
--- a/tools/mesh/keys.c
+++ b/tools/mesh/keys.c
@@ -173,3 +173,11 @@ void keys_print_keys(void)
 {
 	l_queue_foreach(net_keys, print_netkey, NULL);
 }
+
+bool keys_subnet_exists(uint16_t idx)
+{
+	if (!l_queue_find(net_keys, net_idx_match, L_UINT_TO_PTR(idx)))
+		return false;
+
+	return true;
+}
diff --git a/tools/mesh/keys.h b/tools/mesh/keys.h
index 2a9faede6..71c3bb390 100644
--- a/tools/mesh/keys.h
+++ b/tools/mesh/keys.h
@@ -23,4 +23,5 @@ void keys_del_net_key(uint16_t net_idx);
 void keys_add_app_key(uint16_t net_idx, uint16_t app_idx);
 void keys_del_app_key(uint16_t app_idx);
 uint16_t keys_get_bound_key(uint16_t app_idx);
+bool keys_subnet_exists(uint16_t idx);
 void keys_print_keys(void);
-- 
2.21.0

