Return-Path: <SRS0=/JiD=VA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FACC0650E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jul 2019 16:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5E3B218A0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jul 2019 16:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfGCQeR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Jul 2019 12:34:17 -0400
Received: from mga02.intel.com ([134.134.136.20]:49908 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbfGCQeQ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Jul 2019 12:34:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2019 09:34:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,446,1557212400"; 
   d="scan'208";a="158031234"
Received: from bgix-dell-lap.sea.intel.com ([10.254.20.71])
  by orsmga008.jf.intel.com with ESMTP; 03 Jul 2019 09:34:14 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com,
        michal.lowas-rzechonek@silvair.com
Subject: [PATCH BlueZ] mesh: Fix memory leak on dbus message creation
Date:   Wed,  3 Jul 2019 09:34:03 -0700
Message-Id: <20190703163403.15814-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 mesh/model.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mesh/model.c b/mesh/model.c
index 7401dcecb..a2b3e5c18 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -729,10 +729,13 @@ static void send_msg_rcvd(struct mesh_node *node, uint8_t ele_idx, bool is_sub,
 	if (!l_dbus_message_builder_finalize(builder))
 		goto error;
 
+	l_dbus_message_builder_destroy(builder);
 	l_dbus_send(dbus, msg);
+	return;
 
 error:
 	l_dbus_message_builder_destroy(builder);
+	l_dbus_message_unref(msg);
 }
 
 bool mesh_model_rx(struct mesh_node *node, bool szmict, uint32_t seq0,
-- 
2.14.5

