Return-Path: <SRS0=Uimr=AD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D96C433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Jun 2020 18:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 105E020732
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Jun 2020 18:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730375AbgFVSV7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Jun 2020 14:21:59 -0400
Received: from mga18.intel.com ([134.134.136.126]:4146 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730139AbgFVSV7 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Jun 2020 14:21:59 -0400
IronPort-SDR: R0FPsSnxaDT1N2IX2244tQMi0CmjM376qqK9OaXkyb4d0kU8CsPyFniF+928VgNxyNsq/+Fk9W
 Zp0Fe4NJ+KbQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="131240964"
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="131240964"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 11:21:58 -0700
IronPort-SDR: EZbBRKW9r73NRKw04ekpdo0Vx3S8lm12lmHR6QvGpK0qo/D3krp9RcZ8m2ALSblVyG4utYtat+
 Tx6a8YHU5Cfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="422720229"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.251.30.61])
  by orsmga004.jf.intel.com with ESMTP; 22 Jun 2020 11:21:58 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com
Subject: [PATCH BlueZ] mesh: Fix memory leak when queuing OB pkts rapidly
Date:   Mon, 22 Jun 2020 11:21:46 -0700
Message-Id: <20200622182146.208305-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

If a new packet for outbound delivery is queued during the last
transmission of the only other packet being sent, the prior
packet got forgotten and leaked. This fix correctly deletes the prior
packet, but also makes sure it is given the proper oportunity for
transmission.
---
 mesh/mesh-io-generic.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/mesh/mesh-io-generic.c b/mesh/mesh-io-generic.c
index 7a4008bd9..86952516e 100644
--- a/mesh/mesh-io-generic.c
+++ b/mesh/mesh-io-generic.c
@@ -569,6 +569,9 @@ static void send_pkt(struct mesh_io_private *pvt, struct tx_pkt *tx,
 {
 	struct bt_hci_cmd_le_set_adv_enable cmd;
 
+	if (pvt->tx && pvt->tx->delete)
+		l_free(pvt->tx);
+
 	pvt->tx = tx;
 	pvt->interval = interval;
 
@@ -583,7 +586,7 @@ static void send_pkt(struct mesh_io_private *pvt, struct tx_pkt *tx,
 				set_send_adv_params, pvt, NULL);
 }
 
-static void tx_timeout(struct l_timeout *timeout, void *user_data)
+static void tx_to(struct l_timeout *timeout, void *user_data)
 {
 	struct mesh_io_private *pvt = user_data;
 	struct tx_pkt *tx;
@@ -616,8 +619,9 @@ static void tx_timeout(struct l_timeout *timeout, void *user_data)
 	send_pkt(pvt, tx, ms);
 
 	if (count == 1) {
-		/* send_pkt will delete when done */
+		/* Recalculate wakeup if we are responding to POLL */
 		tx = l_queue_peek_head(pvt->tx_pkts);
+
 		if (tx && tx->info.type == MESH_IO_TIMING_TYPE_POLL_RSP) {
 			ms = instant_remaining_ms(tx->info.u.poll_rsp.instant +
 						tx->info.u.poll_rsp.delay);
@@ -629,8 +633,7 @@ static void tx_timeout(struct l_timeout *timeout, void *user_data)
 		pvt->tx_timeout = timeout;
 		l_timeout_modify_ms(timeout, ms);
 	} else
-		pvt->tx_timeout = l_timeout_create_ms(ms, tx_timeout,
-								pvt, NULL);
+		pvt->tx_timeout = l_timeout_create_ms(ms, tx_to, pvt, NULL);
 }
 
 static void tx_worker(void *user_data)
@@ -679,12 +682,11 @@ static void tx_worker(void *user_data)
 	}
 
 	if (!delay)
-		tx_timeout(pvt->tx_timeout, pvt);
+		tx_to(pvt->tx_timeout, pvt);
 	else if (pvt->tx_timeout)
 		l_timeout_modify_ms(pvt->tx_timeout, delay);
 	else
-		pvt->tx_timeout = l_timeout_create_ms(delay, tx_timeout,
-								pvt, NULL);
+		pvt->tx_timeout = l_timeout_create_ms(delay, tx_to, pvt, NULL);
 }
 
 static bool send_tx(struct mesh_io *io, struct mesh_io_send_info *info,
@@ -698,8 +700,6 @@ static bool send_tx(struct mesh_io *io, struct mesh_io_send_info *info,
 		return false;
 
 	tx = l_new(struct tx_pkt, 1);
-	if (!tx)
-		return false;
 
 	memcpy(&tx->info, info, sizeof(tx->info));
 	memcpy(&tx->pkt, data, len);
@@ -708,7 +708,11 @@ static bool send_tx(struct mesh_io *io, struct mesh_io_send_info *info,
 	if (info->type == MESH_IO_TIMING_TYPE_POLL_RSP)
 		l_queue_push_head(pvt->tx_pkts, tx);
 	else {
-		sending = !l_queue_isempty(pvt->tx_pkts);
+		if (pvt->tx)
+			sending = true;
+		else
+			sending = !l_queue_isempty(pvt->tx_pkts);
+
 		l_queue_push_tail(pvt->tx_pkts, tx);
 	}
 
-- 
2.25.4

