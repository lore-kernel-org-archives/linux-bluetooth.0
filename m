Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D53BC6FA82
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Sep 2022 12:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbiIWMGW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Sep 2022 08:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbiIWMER (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Sep 2022 08:04:17 -0400
X-Greylist: delayed 1625 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 23 Sep 2022 04:59:25 PDT
Received: from voyager.loytec.com (voyager.loytec.com [88.198.4.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29744138F36
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Sep 2022 04:59:25 -0700 (PDT)
Received: from 212-17-98-152.static.upcbusiness.at ([212.17.98.152] helo=lexx.office.loytec.com)
        by voyager.loytec.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <isak.westin@loytec.com>)
        id 1obgux-0000M2-Q7
        for linux-bluetooth@vger.kernel.org; Fri, 23 Sep 2022 13:32:27 +0200
Received: from loytec-dev-vm.delta.corp ([10.101.25.21])
        by lexx.office.loytec.com (8.15.2/8.15.2/Some OS 1.2.3-4.5) with ESMTP id 28NBWF7h3687927;
        Fri, 23 Sep 2022 13:32:25 +0200
From:   Isak Westin <isak.westin@loytec.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Isak Westin <isak.westin@loytec.com>
Subject: [PATCH BlueZ 1/2] mesh: Clear addr field if virt sub failed
Date:   Fri, 23 Sep 2022 13:31:48 +0200
Message-Id: <20220923113149.14209-2-isak.westin@loytec.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220923113149.14209-1-isak.westin@loytec.com>
References: <20220923113149.14209-1-isak.westin@loytec.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 212.17.98.152
X-SA-Exim-Mail-From: isak.westin@loytec.com
X-SA-Exim-Scanned: No (on voyager.loytec.com); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

If processing failed for a Config Model Subscription Virtual Address
Add/Delete/Overwrite message, the address field in the status reply
should be set to zero. See MshPRFv1.0.1 section 4.4.1.2.8.
---
 mesh/cfgmod-server.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index c1e1faa6a..9bc2f1c97 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -286,6 +286,10 @@ static uint16_t cfg_virt_sub_add_msg(struct mesh_node *node, const uint8_t *pkt,
 						label, true, addr, opcode))
 		msg[n] = MESH_STATUS_STORAGE_FAIL;
 
+	/* If processing failed, set addr field to zero in reply */
+	if (msg[n] != MESH_STATUS_SUCCESS)
+		addr = UNASSIGNED_ADDRESS;
+
 	l_put_le16(ele_addr, msg + n + 1);
 	l_put_le16(addr, msg + n + 3);
 
-- 
2.20.1





