Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582B6C6FA83
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Sep 2022 14:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235030AbiIZOlW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Sep 2022 10:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235052AbiIZOk4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Sep 2022 10:40:56 -0400
Received: from voyager.loytec.com (voyager.loytec.com [88.198.4.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFFD106F6A
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Sep 2022 06:01:46 -0700 (PDT)
Received: from 212-17-98-152.static.upcbusiness.at ([212.17.98.152] helo=lexx.office.loytec.com)
        by voyager.loytec.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <isak.westin@loytec.com>)
        id 1ocnk0-00046q-IG
        for linux-bluetooth@vger.kernel.org; Mon, 26 Sep 2022 15:01:44 +0200
Received: from loytec-dev-vm.delta.corp ([10.101.25.21])
        by lexx.office.loytec.com (8.15.2/8.15.2/Some OS 1.2.3-4.5) with ESMTP id 28QD1bCW1107873;
        Mon, 26 Sep 2022 15:01:42 +0200
From:   Isak Westin <isak.westin@loytec.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Isak Westin <isak.westin@loytec.com>
Subject: [PATCH BlueZ 2/4] mesh: Reply to HB pub set with same fields
Date:   Mon, 26 Sep 2022 15:01:08 +0200
Message-Id: <20220926130110.2146-3-isak.westin@loytec.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220926130110.2146-1-isak.westin@loytec.com>
References: <20220926130110.2146-1-isak.westin@loytec.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 212.17.98.152
X-SA-Exim-Mail-From: isak.westin@loytec.com
X-SA-Exim-Scanned: No (on voyager.loytec.com); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

If a Config Heartbeat Publication Set message is unsuccessfully
processed, the fields in the status reply should be the same as in the
original message. See MshPRFv1.0.1 section 4.4.1.2.15.
---
 mesh/cfgmod-server.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index 33796d05a..9c5edf551 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -575,7 +575,17 @@ static uint16_t hb_publication_set(struct mesh_node *node, const uint8_t *pkt)
 	status = mesh_net_set_heartbeat_pub(net, dst, features, net_idx, ttl,
 						count_log, period_log);
 
-	return hb_publication_get(node, status);
+	if (status != MESH_STATUS_SUCCESS) {
+		uint16_t n;
+
+		n = mesh_model_opcode_set(OP_CONFIG_HEARTBEAT_PUB_STATUS, msg);
+		msg[n++] = status;
+		memcpy(msg + n, pkt, 9);
+		n += 9;
+
+		return n;
+	} else
+		return hb_publication_get(node, status);
 }
 
 static void node_reset(void *user_data)
-- 
2.20.1





