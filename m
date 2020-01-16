Return-Path: <SRS0=0CDr=3F=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1777EC33CB1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jan 2020 16:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9D102073A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jan 2020 16:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgAPQjY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:39:24 -0500
Received: from mga12.intel.com ([192.55.52.136]:63817 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbgAPQjY (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Jan 2020 11:39:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2020 08:39:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,326,1574150400"; 
   d="scan'208";a="373375258"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.255.90.67])
  by orsmga004.jf.intel.com with ESMTP; 16 Jan 2020 08:39:23 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com,
        michal.lowas-rzechonek@silvair.com, jakub.witowski@silvair.com
Subject: [PATCH BlueZ v3 1/1] mesh: Sequence number related fixes
Date:   Thu, 16 Jan 2020 08:39:08 -0800
Message-Id: <20200116163908.18041-2-brian.gix@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200116163908.18041-1-brian.gix@intel.com>
References: <20200116163908.18041-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Jakub Witowski <jakub.witowski@silvair.com>

---
 mesh/crypto.c           |  3 +++
 mesh/mesh-config-json.c | 16 ++++++++++++++--
 mesh/net.c              |  9 +++++++++
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/mesh/crypto.c b/mesh/crypto.c
index 8ea906ac9..596a289f9 100644
--- a/mesh/crypto.c
+++ b/mesh/crypto.c
@@ -637,6 +637,9 @@ bool mesh_crypto_packet_build(bool ctl, uint8_t ttl,
 	uint32_t hdr;
 	size_t n;
 
+	if (seq > SEQ_MASK)
+		return false;
+
 	l_put_be32(seq, packet + 1);
 	packet[1] = (ctl ? CTL : 0) | (ttl & TTL_MASK);
 
diff --git a/mesh/mesh-config-json.c b/mesh/mesh-config-json.c
index 755caab0e..5855149e3 100644
--- a/mesh/mesh-config-json.c
+++ b/mesh/mesh-config-json.c
@@ -40,6 +40,7 @@
 #include "mesh/mesh-defs.h"
 #include "mesh/util.h"
 #include "mesh/mesh-config.h"
+#include "mesh/net.h"
 
 /* To prevent local node JSON cache thrashing, minimum update times */
 #define MIN_SEQ_CACHE_TRIGGER	32
@@ -365,7 +366,7 @@ static bool read_seq_number(json_object *jobj, uint32_t *seq_number)
 	if (!val && errno == EINVAL)
 		return false;
 
-	if (val < 0 || val > 0xffffff)
+	if (val < 0 || val > SEQ_MASK + 1)
 		return false;
 
 	*seq_number = (uint32_t) val;
@@ -2019,10 +2020,21 @@ bool mesh_config_write_seq_number(struct mesh_config *cfg, uint32_t seq,
 		if (cached < seq + MIN_SEQ_CACHE_VALUE)
 			cached = seq + MIN_SEQ_CACHE_VALUE;
 
-		l_debug("Seq Cache: %d -> %d", seq, cached);
+		/* Cap the seq cache maximum to fixed out-of-range value.
+		 * If daemon restarts with out-of-range value, no packets
+		 * are to be sent until IV Update procedure completes.
+		 */
+		if (cached > SEQ_MASK)
+			cached = SEQ_MASK + 1;
 
 		cfg->write_seq = seq;
 
+		/* Don't rewrite NVM storage if unchanged */
+		if (value == (int) cached)
+			return true;
+
+		l_debug("Seq Cache: %d -> %d", seq, cached);
+
 		if (!write_int(cfg->jnode, "sequenceNumber", cached))
 		    return false;
 
diff --git a/mesh/net.c b/mesh/net.c
index f0f0dbdbd..35388beec 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -511,6 +511,15 @@ uint32_t mesh_net_next_seq_num(struct mesh_net *net)
 {
 	uint32_t seq = net->seq_num++;
 
+	/* Cap out-of-range seq_num max value to +1. Out of range
+	 * seq_nums will not be sent as they would violate spec.
+	 * This condition signals a runaway seq_num condition, and
+	 * the node must wait for a completed IV Index update procedure
+	 * before it can send again.
+	 */
+	if (net->seq_num > SEQ_MASK)
+		net->seq_num = SEQ_MASK + 1;
+
 	node_set_sequence_number(net->node, net->seq_num);
 	return seq;
 }
-- 
2.21.1

