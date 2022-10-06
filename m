Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58FDBC4332F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Oct 2022 15:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbiJFPAG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Oct 2022 11:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbiJFO76 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Oct 2022 10:59:58 -0400
Received: from voyager.loytec.com (voyager.loytec.com [88.198.4.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CFD1F9EF
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Oct 2022 07:59:54 -0700 (PDT)
Received: from 212-17-98-152.static.upcbusiness.at ([212.17.98.152] helo=lexx.office.loytec.com)
        by voyager.loytec.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <isak.westin@loytec.com>)
        id 1ogSLo-0006ra-1b
        for linux-bluetooth@vger.kernel.org; Thu, 06 Oct 2022 16:59:52 +0200
Received: from loytec-dev-vm.delta.corp ([10.101.25.21])
        by lexx.office.loytec.com (8.15.2/8.15.2/Some OS 1.2.3-4.5) with ESMTP id 296ExnRE4163430;
        Thu, 6 Oct 2022 16:59:49 +0200
From:   Isak Westin <isak.westin@loytec.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Isak Westin <isak.westin@loytec.com>
Subject: [PATCH BlueZ 2/6] mesh: provisionee: Handle unknown PDUs
Date:   Thu,  6 Oct 2022 16:59:23 +0200
Message-Id: <20221006145927.32731-3-isak.westin@loytec.com>
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

If an unknown PDU is received during provisioning, the provisioning
should fail with "Invalid PDU".
---
 mesh/prov-acceptor.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mesh/prov-acceptor.c b/mesh/prov-acceptor.c
index f579a143b..ac257b170 100644
--- a/mesh/prov-acceptor.c
+++ b/mesh/prov-acceptor.c
@@ -399,6 +399,12 @@ static void acp_prov_rx(void *user_data, const uint8_t *data, uint16_t len)
 	l_debug("Provisioning packet received type: %2.2x (%u octets)",
 								type, len);
 
+	if (type >= L_ARRAY_SIZE(expected_pdu_size)) {
+		l_error("Unknown PDU type: %2.2x", type);
+		fail.reason = PROV_ERR_INVALID_PDU;
+		goto failure;
+	}
+
 	if (type == prov->previous) {
 		l_error("Ignore repeated %2.2x packet", type);
 		return;
@@ -408,8 +414,7 @@ static void acp_prov_rx(void *user_data, const uint8_t *data, uint16_t len)
 		goto failure;
 	}
 
-	if (type >= L_ARRAY_SIZE(expected_pdu_size) ||
-					len != expected_pdu_size[type]) {
+	if (len != expected_pdu_size[type]) {
 		l_error("Expected PDU size %d, Got %d (type: %2.2x)",
 			len, expected_pdu_size[type], type);
 		fail.reason = PROV_ERR_INVALID_FORMAT;
-- 
2.20.1





