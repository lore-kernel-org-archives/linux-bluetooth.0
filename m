Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4E9C43217
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Oct 2022 15:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbiJFPAC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Oct 2022 11:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbiJFO76 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Oct 2022 10:59:58 -0400
Received: from voyager.loytec.com (voyager.loytec.com [88.198.4.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76651EEE8
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Oct 2022 07:59:54 -0700 (PDT)
Received: from 212-17-98-152.static.upcbusiness.at ([212.17.98.152] helo=lexx.office.loytec.com)
        by voyager.loytec.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <isak.westin@loytec.com>)
        id 1ogSLo-0006rZ-00
        for linux-bluetooth@vger.kernel.org; Thu, 06 Oct 2022 16:59:52 +0200
Received: from loytec-dev-vm.delta.corp ([10.101.25.21])
        by lexx.office.loytec.com (8.15.2/8.15.2/Some OS 1.2.3-4.5) with ESMTP id 296ExnRH4163430;
        Thu, 6 Oct 2022 16:59:49 +0200
From:   Isak Westin <isak.westin@loytec.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Isak Westin <isak.westin@loytec.com>
Subject: [PATCH BlueZ 5/6] mesh: Keep canceled SAR data for at least 10 sec
Date:   Thu,  6 Oct 2022 16:59:26 +0200
Message-Id: <20221006145927.32731-6-isak.westin@loytec.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221006145927.32731-1-isak.westin@loytec.com>
References: <20221006145927.32731-1-isak.westin@loytec.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 212.17.98.152
X-SA-Exim-Mail-From: isak.westin@loytec.com
X-SA-Exim-Scanned: No (on voyager.loytec.com); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When a SAR transmission has been completed or canceled, the recipent
should store the block authentication values for at least 10 seconds
and ignore new segments with the same values during this period. See
MshPRFv1.0.1 section 3.5.3.4.
---
 mesh/net.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/mesh/net.c b/mesh/net.c
index 379a6e250..e95ae5114 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -46,6 +46,7 @@
 
 #define SEG_TO	2
 #define MSG_TO	60
+#define SAR_DEL	10
 
 #define DEFAULT_TRANSMIT_COUNT		1
 #define DEFAULT_TRANSMIT_INTERVAL	100
@@ -166,6 +167,7 @@ struct mesh_sar {
 	bool segmented;
 	bool frnd;
 	bool frnd_cred;
+	bool delete;
 	uint8_t ttl;
 	uint8_t last_seg;
 	uint8_t key_aid;
@@ -1493,13 +1495,27 @@ static void inseg_to(struct l_timeout *seg_timeout, void *user_data)
 static void inmsg_to(struct l_timeout *msg_timeout, void *user_data)
 {
 	struct mesh_net *net = user_data;
-	struct mesh_sar *sar = l_queue_remove_if(net->sar_in,
+	struct mesh_sar *sar = l_queue_find(net->sar_in,
 			match_msg_timeout, msg_timeout);
 
 	l_timeout_remove(msg_timeout);
 	if (!sar)
 		return;
 
+	if (!sar->delete) {
+		/*
+		 * Incomplete timer expired, cancel SAR and start
+		 * delete timer
+		 */
+		sar->delete = true;
+		l_timeout_remove(sar->seg_timeout);
+		sar->seg_timeout = NULL;
+		sar->msg_timeout = l_timeout_create(SAR_DEL,
+					inmsg_to, net, NULL);
+		return;
+	}
+
+	l_queue_remove(net->sar_in, sar);
 	sar->msg_timeout = NULL;
 	mesh_sar_free(sar);
 }
@@ -1956,7 +1972,9 @@ static bool seg_rxed(struct mesh_net *net, bool frnd, uint32_t iv_index,
 			/* Re-Send ACK for full msg */
 			send_net_ack(net, sar_in, expected);
 			return true;
-		}
+		} else if (sar_in->delete)
+			/* Ignore canceled */
+			return false;
 	} else {
 		uint16_t len = MAX_SEG_TO_LEN(segN);
 
@@ -1996,6 +2014,9 @@ static bool seg_rxed(struct mesh_net *net, bool frnd, uint32_t iv_index,
 		sar_in->len = segN * MAX_SEG_LEN + size;
 
 	if (sar_in->flags == expected) {
+		/* Remove message incomplete timer */
+		l_timeout_remove(sar_in->msg_timeout);
+
 		/* Got it all */
 		send_net_ack(net, sar_in, expected);
 
@@ -2006,6 +2027,11 @@ static bool seg_rxed(struct mesh_net *net, bool frnd, uint32_t iv_index,
 		/* Kill Inter-Seg timeout */
 		l_timeout_remove(sar_in->seg_timeout);
 		sar_in->seg_timeout = NULL;
+
+		/* Start delete timer */
+		sar_in->delete = true;
+		sar_in->msg_timeout = l_timeout_create(SAR_DEL,
+				inmsg_to, net, NULL);
 		return true;
 	}
 
-- 
2.20.1





