Return-Path: <SRS0=8Xmo=2A=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F743C43603
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Dec 2019 23:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A2BD205C9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Dec 2019 23:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfLJXGD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Dec 2019 18:06:03 -0500
Received: from mga07.intel.com ([134.134.136.100]:13898 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726631AbfLJXGD (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Dec 2019 18:06:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2019 15:06:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,301,1571727600"; 
   d="scan'208";a="264677968"
Received: from ingas-nuc1.sea.intel.com ([10.254.187.166])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Dec 2019 15:06:01 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] mesh: Remove redundant code in mesh IO mgmt
Date:   Tue, 10 Dec 2019 15:06:00 -0800
Message-Id: <20191210230600.23035-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This removes unnecessary housekeeping for hci controllers
---
 mesh/mesh-mgmt.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/mesh/mesh-mgmt.c b/mesh/mesh-mgmt.c
index 27272d4d2..2cf2ebac2 100644
--- a/mesh/mesh-mgmt.c
+++ b/mesh/mesh-mgmt.c
@@ -42,14 +42,8 @@ struct read_info_req {
 };
 
 static struct mgmt *mgmt_mesh;
-static struct l_queue *controllers;
 static struct l_queue *read_info_regs;
 
-static bool simple_match(const void *a, const void *b)
-{
-	return a == b;
-}
-
 static void process_read_info_req(void *data, void *user_data)
 {
 	struct read_info_reg *reg = data;
@@ -101,23 +95,14 @@ static void read_info_cb(uint8_t status, uint16_t length,
 static void index_added(uint16_t index, uint16_t length, const void *param,
 							void *user_data)
 {
-	if (l_queue_find(controllers, simple_match, L_UINT_TO_PTR(index)))
-		return;
-
-	l_queue_push_tail(controllers, L_UINT_TO_PTR(index));
-
-	if (mgmt_send(mgmt_mesh, MGMT_OP_READ_INFO, index, 0, NULL,
-			read_info_cb, L_UINT_TO_PTR(index), NULL) != 0)
-		return;
-
-	l_queue_remove(controllers, L_UINT_TO_PTR(index));
+	mgmt_send(mgmt_mesh, MGMT_OP_READ_INFO, index, 0, NULL,
+				read_info_cb, L_UINT_TO_PTR(index), NULL);
 }
 
 static void index_removed(uint16_t index, uint16_t length, const void *param,
 							void *user_data)
 {
 	l_warn("Hci dev %4.4x removed", index);
-	l_queue_remove(controllers, L_UINT_TO_PTR(index));
 }
 
 static void read_index_list_cb(uint8_t status, uint16_t length,
@@ -157,9 +142,6 @@ static void read_index_list_cb(uint8_t status, uint16_t length,
 
 static bool mesh_mgmt_init(void)
 {
-	if (!controllers)
-		controllers = l_queue_new();
-
 	if (!read_info_regs)
 		read_info_regs = l_queue_new();
 
-- 
2.21.0

