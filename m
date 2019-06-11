Return-Path: <SRS0=I8Nx=UK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4113DC31E44
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Jun 2019 23:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 213E120872
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Jun 2019 23:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407312AbfFKXQp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 Jun 2019 19:16:45 -0400
Received: from mga03.intel.com ([134.134.136.65]:24911 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728264AbfFKXQp (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 Jun 2019 19:16:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jun 2019 16:16:44 -0700
X-ExtLoop1: 1
Received: from drenteri-mobl1.amr.corp.intel.com (HELO ingas-nuc1.sea.intel.com) ([10.252.193.193])
  by orsmga005.jf.intel.com with ESMTP; 11 Jun 2019 16:16:44 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 1/1] mesh: Remove redundant checks when adding a net key
Date:   Tue, 11 Jun 2019 16:16:43 -0700
Message-Id: <20190611231643.25165-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch cleans up redundant checks in sdd_key() and mesh_net_set_key():
no need to check the result of l_queue_push_tail() and not need to check
if subnet is valid after it was successfully created.
---
 mesh/net.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/mesh/net.c b/mesh/net.c
index fdd38e7ce..a597b8794 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -992,12 +992,13 @@ static struct mesh_subnet *add_key(struct mesh_net *net, uint16_t idx,
 		return NULL;
 	}
 
-	if (!create_secure_beacon(net, subnet, subnet->snb.beacon + 1) ||
-				!l_queue_push_tail(net->subnets, subnet)) {
+	if (!create_secure_beacon(net, subnet, subnet->snb.beacon + 1)) {
 		subnet_free(subnet);
 		return NULL;
 	}
 
+	l_queue_push_tail(net->subnets, subnet);
+
 	return subnet;
 }
 
@@ -3018,11 +3019,6 @@ bool mesh_net_set_key(struct mesh_net *net, uint16_t idx, const uint8_t *key,
 {
 	struct mesh_subnet *subnet;
 
-	subnet = l_queue_find(net->subnets, match_key_index,
-							L_UINT_TO_PTR(idx));
-	if (subnet)
-		return false;
-
 	/* Current key must be always present */
 	if (!key)
 		return false;
@@ -3031,12 +3027,13 @@ bool mesh_net_set_key(struct mesh_net *net, uint16_t idx, const uint8_t *key,
 	if (phase != KEY_REFRESH_PHASE_NONE && !new_key)
 		return false;
 
-	subnet = add_key(net, idx, key);
-	if (!subnet)
-		return false;
-
+	/* Check if the subnet with the specified index already exists */
 	subnet = l_queue_find(net->subnets, match_key_index,
 							L_UINT_TO_PTR(idx));
+	if (subnet)
+		return false;
+
+	subnet = add_key(net, idx, key);
 	if (!subnet)
 		return false;
 
-- 
2.21.0

