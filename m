Return-Path: <SRS0=NtgA=26=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BC8C282DD
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Jan 2020 21:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BAA72080D
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Jan 2020 21:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbgAIVyd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Jan 2020 16:54:33 -0500
Received: from mga07.intel.com ([134.134.136.100]:33920 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbgAIVyd (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Jan 2020 16:54:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2020 13:54:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,414,1571727600"; 
   d="scan'208";a="236221031"
Received: from ingas-nuc1.sea.intel.com ([10.254.104.252])
  by orsmga002.jf.intel.com with ESMTP; 09 Jan 2020 13:54:32 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, michal.lowas-rzechonek@silvair.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v2] mesh: Correctly generate NetKey list
Date:   Thu,  9 Jan 2020 13:54:32 -0800
Message-Id: <20200109215432.28295-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When responding with NetKey List Status, packed NetKey indices into
3 octets per pair. If number of NetKeys is odd, append the last key
index as a 2-octet value.
---
 mesh/net.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/mesh/net.c b/mesh/net.c
index 0a4d2e72c..dfaf7ccef 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -1065,26 +1065,46 @@ bool mesh_net_get_key(struct mesh_net *net, bool new_key, uint16_t idx,
 bool mesh_net_key_list_get(struct mesh_net *net, uint8_t *buf, uint16_t *size)
 {
 	const struct l_queue_entry *entry;
-	uint16_t n, buf_size;
+	uint16_t num_keys, req_size, buf_size;
+	struct mesh_subnet *subnet;
 
 	if (!net || !buf || !size)
 		return false;
 
 	buf_size = *size;
-	if (buf_size < l_queue_length(net->subnets) * 2)
+
+	num_keys = l_queue_length(net->subnets);
+	req_size = (num_keys / 2) * 3 + (num_keys % 2) * 2;
+
+	if (buf_size < req_size)
 		return false;
 
-	n = 0;
-	entry = l_queue_get_entries(net->subnets);
+	*size = req_size;
+
+	/* Pack NetKey indices in 3 octets */
+	for (entry = l_queue_get_entries(net->subnets); num_keys > 1;) {
+		uint32_t idx_pair;
 
-	for (; entry; entry = entry->next) {
-		struct mesh_subnet *subnet = entry->data;
+		subnet = entry->data;
+		idx_pair = subnet->idx;
+		idx_pair <<= 12;
+
+		subnet = entry->next->data;
+		idx_pair += subnet->idx;
+
+		l_put_le32(idx_pair, buf);
+		buf += 3;
+
+		num_keys -= 2;
+		entry = entry->next->next;
+	}
 
+	/* If odd number of NetKeys, fill in the end of the buffer */
+	if (num_keys % 2) {
+		subnet = entry->data;
 		l_put_le16(subnet->idx, buf);
-		n += 2;
 	}
 
-	*size = n;
 	return true;
 }
 
-- 
2.21.1

