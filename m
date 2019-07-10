Return-Path: <SRS0=sCKx=VH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A69FC73C6F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jul 2019 05:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02A6220844
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jul 2019 05:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbfGJFKI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Jul 2019 01:10:08 -0400
Received: from mga18.intel.com ([134.134.136.126]:28143 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbfGJFKI (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Jul 2019 01:10:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jul 2019 22:10:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,473,1557212400"; 
   d="scan'208";a="189050343"
Received: from ingas-nuc1.sea.intel.com ([10.254.182.100])
  by fmsmga004.fm.intel.com with ESMTP; 09 Jul 2019 22:10:07 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, michal.lowas-rzechonek@silvair.com,
        jakub.witowski@silvair.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 6/9] mesh: Define storage format specific read/write routines
Date:   Tue,  9 Jul 2019 22:09:56 -0700
Message-Id: <20190710050959.7321-7-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190710050959.7321-1-inga.stotland@intel.com>
References: <20190710050959.7321-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds the following generic APIs to mesh-config.h
    void *mesh_config_create_config(void);
    void mesh_config_release_config(void *config);
    void *mesh_config_get_config(const char *dir);
    void *mesh_config_get_config_backup(const char *dir);
    bool mesh_config_restore_backup(const char *dir);
    bool mesh_config_save_config(const char *dir, void *cfg);

The implementation of these API routines depends on the
underlying storage directory structure and can be specific to
a chosen configuration file format.
---
 mesh/mesh-config.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mesh/mesh-config.h b/mesh/mesh-config.h
index ab101a331..077c59bbb 100644
--- a/mesh/mesh-config.h
+++ b/mesh/mesh-config.h
@@ -100,6 +100,13 @@ typedef bool (*mesh_config_app_key_cb)(uint16_t idx, uint16_t net_idx,
 typedef bool (*mesh_config_node_cb)(struct mesh_config_node *node,
 							void *user_data);
 
+void *mesh_config_create_config(void);
+void mesh_config_release_config(void *config);
+void *mesh_config_get_config(const char *dir);
+void *mesh_config_get_config_backup(const char *dir);
+bool mesh_config_restore_backup(const char *dir);
+bool mesh_config_save_config(const char *dir, void *cfg);
+
 bool mesh_config_read_node(void *cfg, mesh_config_node_cb cb, void *user_data);
 bool mesh_config_add_node(void *cfg, struct mesh_config_node *node);
 bool mesh_config_read_iv_index(void *cfg, uint32_t *idx, bool *update);
-- 
2.21.0

