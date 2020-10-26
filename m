Return-Path: <SRS0=rjyd=EB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DC3C4363A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Oct 2020 21:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9795F20732
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Oct 2020 21:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730078AbgJZVIa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Oct 2020 17:08:30 -0400
Received: from mga02.intel.com ([134.134.136.20]:1560 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730063AbgJZVIa (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Oct 2020 17:08:30 -0400
IronPort-SDR: /kmg4pSvuORwZNpHqGXqsBJR/p5a6j/NIkGYQYHGNZwzi+ra2om/lYHb8KxaquwOOBxAEQfwRR
 m1FWhjgBpU9w==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="154955076"
X-IronPort-AV: E=Sophos;i="5.77,421,1596524400"; 
   d="scan'208";a="154955076"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 14:08:29 -0700
IronPort-SDR: HmZtGX/T01X0S+X2JjhiTI4oJ7zTWwL15IkACLltg+LM8co4F7JO6WMcxUXjl2eRNCB3XtCn/0
 kjiaaVdRFx+Q==
X-IronPort-AV: E=Sophos;i="5.77,421,1596524400"; 
   d="scan'208";a="535513164"
Received: from magarris-mobl1.amr.corp.intel.com (HELO ingas-nuc1.intel.com) ([10.212.167.33])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 14:08:28 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] tools/mesh-cfgclient: Fix errors found by static analysis
Date:   Mon, 26 Oct 2020 14:08:17 -0700
Message-Id: <20201026210817.50167-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This fixes a NULL pointer dereference error in subscription_cmd().

Also re-order calling sequence for l_free() & l_queue_remove()
in msg_recvd(): even though technically it is not a bug to pass
a value of a freed pointer to l_queue_remove(), it's a poor form
and confuses the analyzer.
---
 tools/mesh/cfgcli.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/tools/mesh/cfgcli.c b/tools/mesh/cfgcli.c
index 1c20db85a..d8eee4edc 100644
--- a/tools/mesh/cfgcli.c
+++ b/tools/mesh/cfgcli.c
@@ -410,8 +410,8 @@ static bool msg_recvd(uint16_t src, uint16_t idx, uint8_t *data,
 	req = get_req_by_rsp(src, opcode);
 	if (req) {
 		cmd = req->cmd;
-		free_request(req);
 		l_queue_remove(requests, req);
+		free_request(req);
 	} else
 		cmd = NULL;
 
@@ -1470,15 +1470,14 @@ static void subscription_cmd(int argc, char *argv[], uint32_t opcode)
 
 	grp = l_queue_find(groups, match_group_addr, L_UINT_TO_PTR(sub_addr));
 
-	if (!grp && opcode != OP_CONFIG_MODEL_SUB_DELETE) {
-		grp = add_group(sub_addr);
-
-		if (!grp && IS_VIRTUAL(sub_addr)) {
-			print_virtual_not_found(sub_addr);
-			return bt_shell_noninteractive_quit(EXIT_FAILURE);
-		}
+	if (!grp && IS_VIRTUAL(sub_addr)) {
+		print_virtual_not_found(sub_addr);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
+	if (!grp && opcode != OP_CONFIG_MODEL_SUB_DELETE)
+		grp = add_group(sub_addr);
+
 	if (IS_VIRTUAL(sub_addr)) {
 		if (opcode == OP_CONFIG_MODEL_SUB_ADD)
 			opcode = OP_CONFIG_MODEL_SUB_VIRT_ADD;
-- 
2.26.2

