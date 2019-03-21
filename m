Return-Path: <SRS0=3vvc=RY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFE2C43381
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Mar 2019 07:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C806F218A5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Mar 2019 07:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbfCUHcn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Mar 2019 03:32:43 -0400
Received: from mga07.intel.com ([134.134.136.100]:7929 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727575AbfCUHcn (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Mar 2019 03:32:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Mar 2019 00:32:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,252,1549958400"; 
   d="scan'208";a="143892947"
Received: from ingas-nuc1.sea.intel.com ([10.255.84.3])
  by orsmga002.jf.intel.com with ESMTP; 21 Mar 2019 00:32:41 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] mesh: Correctly initialize node's vendor models
Date:   Thu, 21 Mar 2019 00:32:40 -0700
Message-Id: <20190321073240.23203-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This fixes vendor model initialization based on node properties
collected during Join() method call.
---
 mesh/node.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/mesh/node.c b/mesh/node.c
index 761a67af4..999d3b8c0 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -1177,17 +1177,20 @@ static void add_model_from_properties(struct node_element *ele,
 static void add_vendor_model_from_properties(struct node_element *ele,
 					struct l_dbus_message_iter *property)
 {
-	struct {
-		uint16_t v;
-		uint16_t m;
-	} id_pair;
+	struct l_dbus_message_iter ids;
+	uint16_t v;
+	uint16_t m;
 
 	if (!ele->models)
 		ele->models = l_queue_new();
 
-	while (l_dbus_message_iter_next_entry(property, &id_pair)) {
+	if (!l_dbus_message_iter_get_variant(property, "a(qq)", &ids))
+		return;
+
+	while (l_dbus_message_iter_next_entry(&ids, &v, &m)) {
 		struct mesh_model *mod;
-		mod = mesh_model_vendor_new(ele->idx, id_pair.v, id_pair.m);
+
+		mod = mesh_model_vendor_new(ele->idx, v, m);
 		l_queue_push_tail(ele->models, mod);
 	}
 }
-- 
2.17.2

