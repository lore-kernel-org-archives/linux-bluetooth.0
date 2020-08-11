Return-Path: <SRS0=5Aiy=BV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D41C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Aug 2020 16:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72C4120781
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Aug 2020 16:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729323AbgHKQbi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 Aug 2020 12:31:38 -0400
Received: from mga17.intel.com ([192.55.52.151]:55308 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728862AbgHKQbh (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 Aug 2020 12:31:37 -0400
IronPort-SDR: UsA247tjODg3NCIJh7xgjKivTr9MqDQ20/ipqtreUiiJlwn6gvskyPmyl7TS3bjSk4YrEPuh1p
 bZaGm71gcOfQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9710"; a="133815955"
X-IronPort-AV: E=Sophos;i="5.76,301,1592895600"; 
   d="scan'208";a="133815955"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2020 09:31:36 -0700
IronPort-SDR: E1rAa5ZhJVqw8TldjmV/5rE7uKjqNyKr3m920gcghLRXUNmd7W5u5ph5xaDSH5DZlddOcmmVLx
 P4UvM9Zreq/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,301,1592895600"; 
   d="scan'208";a="294767768"
Received: from rajkumar-mobl.amr.corp.intel.com (HELO ingas-nuc1.intel.com) ([10.254.82.230])
  by orsmga006.jf.intel.com with ESMTP; 11 Aug 2020 09:31:35 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] mesh: Fix element index look up for config model subs
Date:   Tue, 11 Aug 2020 09:31:34 -0700
Message-Id: <20200811163134.8561-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Use element address for looking up element index (subscription
address was erroneously used to perform the lookup).
---
 mesh/model.c | 15 ++++++++-------
 mesh/model.h |  3 ++-
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/mesh/model.c b/mesh/model.c
index 690be29d5..23afb93a8 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -1402,13 +1402,13 @@ done:
 	return MESH_STATUS_SUCCESS;
 }
 
-int mesh_model_sub_get(struct mesh_node *node, uint16_t addr, uint32_t id,
+int mesh_model_sub_get(struct mesh_node *node, uint16_t ele_addr, uint32_t id,
 			uint8_t *buf, uint16_t buf_size, uint16_t *size)
 {
 	int16_t n;
 	struct mesh_model *mod;
 	const struct l_queue_entry *entry;
-	int ele_idx = node_get_element_idx(node, addr);
+	int ele_idx = node_get_element_idx(node, ele_addr);
 
 	if (ele_idx < 0)
 		return MESH_STATUS_INVALID_ADDRESS;
@@ -1454,7 +1454,7 @@ int mesh_model_sub_add(struct mesh_node *node, uint16_t ele_addr, uint32_t id,
 								uint16_t addr)
 {
 	struct mesh_model *mod;
-	int status, ele_idx = node_get_element_idx(node, addr);
+	int status, ele_idx = node_get_element_idx(node, ele_addr);
 
 	if (ele_idx < 0)
 		return MESH_STATUS_INVALID_ADDRESS;
@@ -1510,7 +1510,7 @@ int mesh_model_sub_ovrt(struct mesh_node *node, uint16_t ele_addr, uint32_t id,
 								uint16_t addr)
 {
 	struct mesh_model *mod;
-	int ele_idx = node_get_element_idx(node, addr);
+	int ele_idx = node_get_element_idx(node, ele_addr);
 
 	if (ele_idx < 0)
 		return MESH_STATUS_INVALID_ADDRESS;
@@ -1567,7 +1567,7 @@ int mesh_model_sub_del(struct mesh_node *node, uint16_t ele_addr, uint32_t id,
 								uint16_t addr)
 {
 	struct mesh_model *mod;
-	int ele_idx = node_get_element_idx(node, addr);
+	int ele_idx = node_get_element_idx(node, ele_addr);
 
 	if (ele_idx < 0)
 		return MESH_STATUS_INVALID_ADDRESS;
@@ -1629,10 +1629,11 @@ int mesh_model_virt_sub_del(struct mesh_node *node, uint16_t ele_addr,
 	return MESH_STATUS_SUCCESS;
 }
 
-int mesh_model_sub_del_all(struct mesh_node *node, uint16_t addr, uint32_t id)
+int mesh_model_sub_del_all(struct mesh_node *node, uint16_t ele_addr,
+								uint32_t id)
 {
 	struct mesh_model *mod;
-	int ele_idx = node_get_element_idx(node, addr);
+	int ele_idx = node_get_element_idx(node, ele_addr);
 
 	if (ele_idx < 0)
 		return MESH_STATUS_INVALID_ADDRESS;
diff --git a/mesh/model.h b/mesh/model.h
index a88d25d77..147a02279 100644
--- a/mesh/model.h
+++ b/mesh/model.h
@@ -98,7 +98,8 @@ int mesh_model_sub_del(struct mesh_node *node, uint16_t ele_addr, uint32_t id,
 int mesh_model_virt_sub_del(struct mesh_node *node, uint16_t ele_addr,
 					uint32_t id, const uint8_t *label,
 					uint16_t *addr);
-int mesh_model_sub_del_all(struct mesh_node *node, uint16_t addr, uint32_t id);
+int mesh_model_sub_del_all(struct mesh_node *node, uint16_t ele_addr,
+								uint32_t id);
 int mesh_model_sub_ovrt(struct mesh_node *node, uint16_t ele_addr, uint32_t id,
 								uint16_t addr);
 int mesh_model_virt_sub_ovrt(struct mesh_node *node, uint16_t ele_addr,
-- 
2.26.2

