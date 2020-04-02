Return-Path: <SRS0=u1pM=5S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F91C2D0F3
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Apr 2020 00:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24C3C20721
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Apr 2020 00:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733222AbgDBAEj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Apr 2020 20:04:39 -0400
Received: from mga12.intel.com ([192.55.52.136]:41450 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732872AbgDBAEj (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Apr 2020 20:04:39 -0400
IronPort-SDR: 2Cf/TIpmtZ/V3AzqCgWFqex+vQaUnSBZFyosy9aDXyGFtIzerNG+XXIppoHMmmoZsp+ukLkYOQ
 StxcQuYxhYXw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2020 17:04:39 -0700
IronPort-SDR: KqWFm0igQnaTp00jZJ6eUlQX0lQK/5HB3PuuGG3QOlUUo8qpLdXcPqVdr27Gm7MSseLXPQMppq
 cpd/1jegIdvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,333,1580803200"; 
   d="scan'208";a="396168653"
Received: from ingas-nuc1.sea.intel.com ([10.252.140.81])
  by orsmga004.jf.intel.com with ESMTP; 01 Apr 2020 17:04:39 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 2/2] mesh: Fix segfault related to idle config write
Date:   Wed,  1 Apr 2020 17:04:36 -0700
Message-Id: <20200402000436.23209-2-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200402000436.23209-1-inga.stotland@intel.com>
References: <20200402000436.23209-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

If node configuration is completely removed from the system,
remove all pending writes to the configuration file.

Fixes the segfault below:

mesh/cfgmod-server.c:node_reset() Node Reset
mesh/mesh-config-json.c:mesh_config_destroy() Delete node config /var/lib/bluetooth/mesh/02040d0a060e0a08090b0103070f050c
mesh/util.c:del_fobject() RM /var/lib/bluetooth/mesh/02040d0a060e0a08090b0103070f050c/rpl/00000000/0001
mesh/util.c:del_fobject() RMDIR /var/lib/bluetooth/mesh/02040d0a060e0a08090b0103070f050c/rpl/00000000
mesh/util.c:del_fobject() RMDIR /var/lib/bluetooth/mesh/02040d0a060e0a08090b0103070f050c/rpl
mesh/util.c:del_fobject() RM /var/lib/bluetooth/mesh/02040d0a060e0a08090b0103070f050c/node.json.bak
mesh/util.c:del_fobject() RM /var/lib/bluetooth/mesh/02040d0a060e0a08090b0103070f050c/node.json
mesh/util.c:del_fobject() RMDIR /var/lib/bluetooth/mesh/02040d0a060e0a08090b0103070f050c
Segmentation fault

Program terminated with signal SIGSEGV, Segmentation fault.

  0x0000563a35df2ed0 in ?? ()
  0x00007fd6b131689f in json_object_to_json_string_length (jso=jso@entry=0x563a35dd8d30, flags=flags@entry=2,
---
 mesh/mesh-config-json.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/mesh/mesh-config-json.c b/mesh/mesh-config-json.c
index 172e0e355..97267b6c3 100644
--- a/mesh/mesh-config-json.c
+++ b/mesh/mesh-config-json.c
@@ -54,6 +54,7 @@ struct mesh_config {
 	uint8_t uuid[16];
 	uint32_t write_seq;
 	struct timeval write_time;
+	struct l_queue *idles;
 };
 
 struct write_info {
@@ -1677,6 +1678,7 @@ static struct mesh_config *create_config(const char *cfg_path,
 	memcpy(cfg->uuid, uuid, 16);
 	cfg->node_dir_path = l_strdup(cfg_path);
 	cfg->write_seq = node->seq_number;
+	cfg->idles = l_queue_new();
 	gettimeofday(&cfg->write_time, NULL);
 
 	return cfg;
@@ -2104,6 +2106,7 @@ static bool load_node(const char *fname, const uint8_t uuid[16],
 		memcpy(cfg->uuid, uuid, 16);
 		cfg->node_dir_path = l_strdup(fname);
 		cfg->write_seq = node.seq_number;
+		cfg->idles = l_queue_new();
 		gettimeofday(&cfg->write_time, NULL);
 
 		result = cb(&node, uuid, cfg, user_data);
@@ -2130,17 +2133,26 @@ done:
 	return result;
 }
 
+static void release_idle(void *data)
+{
+	struct l_idle *idle = data;
+
+	l_idle_remove(idle);
+}
+
 void mesh_config_release(struct mesh_config *cfg)
 {
 	if (!cfg)
 		return;
 
+	l_queue_destroy(cfg->idles, release_idle);
+
 	l_free(cfg->node_dir_path);
 	json_object_put(cfg->jnode);
 	l_free(cfg);
 }
 
-static void idle_save_config(void *user_data)
+static void idle_save_config(struct l_idle *idle, void *user_data)
 {
 	struct write_info *info = user_data;
 	char *fname_tmp, *fname_bak, *fname_cfg;
@@ -2169,6 +2181,11 @@ static void idle_save_config(void *user_data)
 	if (info->cb)
 		info->cb(info->user_data, result);
 
+	if (idle) {
+		l_queue_remove(info->cfg->idles, idle);
+		l_idle_remove(idle);
+	}
+
 	l_free(info);
 
 }
@@ -2186,10 +2203,14 @@ bool mesh_config_save(struct mesh_config *cfg, bool no_wait,
 	info->cb = cb;
 	info->user_data = user_data;
 
-	if (no_wait)
-		idle_save_config(info);
-	else
-		l_idle_oneshot(idle_save_config, info, NULL);
+	if (no_wait) {
+		idle_save_config(NULL, info);
+	} else {
+		struct l_idle *idle;
+
+		idle = l_idle_create(idle_save_config, info, NULL);
+		l_queue_push_tail(cfg->idles, idle);
+	}
 
 	return true;
 }
-- 
2.21.1

