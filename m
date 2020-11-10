Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5BCC388F7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Nov 2020 04:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83F9D206A1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Nov 2020 04:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731267AbgKJEVj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Nov 2020 23:21:39 -0500
Received: from mga17.intel.com ([192.55.52.151]:9942 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730921AbgKJEVj (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Nov 2020 23:21:39 -0500
IronPort-SDR: /cG/oEZ3OFSdeZLOwaTPS7LqUBsJAbsqK76PsRtcVaJTXI898qj+KsSPAdMYusuw/qgwfOxrtw
 JalYQkZzzjcA==
X-IronPort-AV: E=McAfee;i="6000,8403,9800"; a="149765233"
X-IronPort-AV: E=Sophos;i="5.77,465,1596524400"; 
   d="scan'208";a="149765233"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 20:21:37 -0800
IronPort-SDR: Z/Cz0HTudo5hAXgwvd7jJLQfswHxiD57Yx1LXgmu2c2CsN59ba2HVzINqs/21yY8rk3eJwyUOL
 q65TzO9Dugcw==
X-IronPort-AV: E=Sophos;i="5.77,465,1596524400"; 
   d="scan'208";a="541174927"
Received: from weidongc-mobl.amr.corp.intel.com (HELO ingas-nuc1.intel.com) ([10.212.33.54])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 20:21:37 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] mesh: Fix memory leak and NULL pointer dereference
Date:   Mon,  9 Nov 2020 20:21:27 -0800
Message-Id: <20201110042127.71045-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This fixes a potential NULL pointer dereferencing in mesh_model_pub_set()
when virtual address publication cannot be successfully stored.
Also, fix a minor memory leak that may occur on unsuccessful model
initialization from storage.
---
 mesh/model.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mesh/model.c b/mesh/model.c
index c8eb8c607..82078ed85 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -1091,11 +1091,11 @@ int mesh_model_pub_set(struct mesh_node *node, uint16_t addr, uint32_t id,
 		status = set_virt_pub(mod, pub_addr, idx, cred_flag, ttl,
 							period, cnt, interval);
 
-	*pub_dst = mod->pub->addr;
-
 	if (status != MESH_STATUS_SUCCESS)
 		return status;
 
+	*pub_dst = mod->pub->addr;
+
 	if (!mod->cbs)
 		/* External model */
 		config_update_model_pub_period(node, ele_idx, id,
@@ -1639,8 +1639,10 @@ static struct mesh_model *model_setup(struct mesh_net *net, uint8_t ele_idx,
 	/* Implicitly bind config server model to device key */
 	if (db_mod->id == CONFIG_SRV_MODEL) {
 
-		if (ele_idx != PRIMARY_ELE_IDX)
+		if (ele_idx != PRIMARY_ELE_IDX) {
+			l_free(mod);
 			return NULL;
+		}
 
 		l_queue_push_head(mod->bindings,
 					L_UINT_TO_PTR(APP_IDX_DEV_LOCAL));
-- 
2.26.2

