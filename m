Return-Path: <SRS0=ssTf=VI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF36C742A1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jul 2019 23:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 856AF208E4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jul 2019 23:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730423AbfGKXAZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Jul 2019 19:00:25 -0400
Received: from mga01.intel.com ([192.55.52.88]:39428 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbfGKXAZ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Jul 2019 19:00:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jul 2019 16:00:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,480,1557212400"; 
   d="scan'208";a="166516215"
Received: from bgix-dell-lap.sea.intel.com ([10.255.80.129])
  by fmsmga008.fm.intel.com with ESMTP; 11 Jul 2019 16:00:24 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, michal.lowas-rzechonek@silvair.com,
        brian.gix@intel.com
Subject: [PATCH BlueZ v2 3/9] mesh: Add special Beacon handler for Provisioning
Date:   Thu, 11 Jul 2019 15:59:46 -0700
Message-Id: <20190711225952.1599-4-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190711225952.1599-1-brian.gix@intel.com>
References: <20190711225952.1599-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Provisioning uses the same AD type for Provisioning that
is also used by the Secure Network Beacon, but their
usage is distinct from each other.  This change allows
us to enable/disable Unprovisioned Device Beacon capture
without disrupting SNB handling.
---
 mesh/mesh-io-generic.c | 2 +-
 mesh/mesh-io.c         | 6 ++++--
 mesh/mesh-io.h         | 7 ++++---
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/mesh/mesh-io-generic.c b/mesh/mesh-io-generic.c
index 42aaa0947..576c5df1b 100644
--- a/mesh/mesh-io-generic.c
+++ b/mesh/mesh-io-generic.c
@@ -40,7 +40,7 @@ struct mesh_io_private {
 	struct l_timeout *tx_timeout;
 	struct l_queue *rx_regs;
 	struct l_queue *tx_pkts;
-	uint8_t filters[3]; /* Simple filtering on AD type only */
+	uint8_t filters[4];
 	bool sending;
 	struct tx_pkt *tx;
 	uint16_t interval;
diff --git a/mesh/mesh-io.c b/mesh/mesh-io.c
index 62a8c0e2c..94a92e885 100644
--- a/mesh/mesh-io.c
+++ b/mesh/mesh-io.c
@@ -86,12 +86,14 @@ struct mesh_io *mesh_io_new(enum mesh_io_type type, void *opts)
 
 	if (api->set) {
 		uint8_t pkt = MESH_AD_TYPE_NETWORK;
-		uint8_t bec = MESH_AD_TYPE_BEACON;
 		uint8_t prv = MESH_AD_TYPE_PROVISION;
+		uint8_t snb[2] = {MESH_AD_TYPE_BEACON, 0x01};
+		uint8_t prvb[2] = {MESH_AD_TYPE_BEACON, 0x00};
 
-		api->set(io, 1, &bec, 1, NULL, NULL);
+		api->set(io, 1, snb, sizeof(snb), NULL, NULL);
 		api->set(io, 2, &prv, 1, NULL, NULL);
 		api->set(io, 3, &pkt, 1, NULL, NULL);
+		api->set(io, 4, prvb, sizeof(prvb), NULL, NULL);
 	}
 
 	if (l_queue_push_head(io_list, io))
diff --git a/mesh/mesh-io.h b/mesh/mesh-io.h
index 6585205c7..1c10779aa 100644
--- a/mesh/mesh-io.h
+++ b/mesh/mesh-io.h
@@ -19,9 +19,10 @@
 
 struct mesh_io;
 
-#define MESH_IO_FILTER_BEACON	1
-#define MESH_IO_FILTER_PROV	2
-#define MESH_IO_FILTER_NET	3
+#define MESH_IO_FILTER_BEACON		1
+#define MESH_IO_FILTER_PROV		2
+#define MESH_IO_FILTER_NET		3
+#define MESH_IO_FILTER_PROV_BEACON	4
 
 #define MESH_IO_TX_COUNT_UNLIMITED	0
 
-- 
2.14.5

