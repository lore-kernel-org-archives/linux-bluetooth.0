Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9B5C433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Oct 2022 15:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbiJFPAA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Oct 2022 11:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbiJFO76 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Oct 2022 10:59:58 -0400
Received: from voyager.loytec.com (voyager.loytec.com [88.198.4.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73411D339
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Oct 2022 07:59:54 -0700 (PDT)
Received: from 212-17-98-152.static.upcbusiness.at ([212.17.98.152] helo=lexx.office.loytec.com)
        by voyager.loytec.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <isak.westin@loytec.com>)
        id 1ogSLo-0006rY-1e
        for linux-bluetooth@vger.kernel.org; Thu, 06 Oct 2022 16:59:52 +0200
Received: from loytec-dev-vm.delta.corp ([10.101.25.21])
        by lexx.office.loytec.com (8.15.2/8.15.2/Some OS 1.2.3-4.5) with ESMTP id 296ExnRF4163430;
        Thu, 6 Oct 2022 16:59:49 +0200
From:   Isak Westin <isak.westin@loytec.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Isak Westin <isak.westin@loytec.com>
Subject: [PATCH BlueZ 3/6] mesh: provisionee: Handle failed provisioning
Date:   Thu,  6 Oct 2022 16:59:24 +0200
Message-Id: <20221006145927.32731-4-isak.westin@loytec.com>
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

When a provisioning fails, all additionally received PDU should be
unexpected until link is closed by provisioner. See MshPRFv1.0.1 section
5.4.4.
---
 mesh/prov-acceptor.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mesh/prov-acceptor.c b/mesh/prov-acceptor.c
index ac257b170..0cefb2fa9 100644
--- a/mesh/prov-acceptor.c
+++ b/mesh/prov-acceptor.c
@@ -70,6 +70,7 @@ struct mesh_prov_acceptor {
 	uint8_t material;
 	uint8_t expected;
 	int8_t previous;
+	bool failed;
 	struct conf_input conf_inputs;
 	uint8_t calc_key[16];
 	uint8_t salt[16];
@@ -408,7 +409,8 @@ static void acp_prov_rx(void *user_data, const uint8_t *data, uint16_t len)
 	if (type == prov->previous) {
 		l_error("Ignore repeated %2.2x packet", type);
 		return;
-	} else if (type > prov->expected || type < prov->previous) {
+	} else if (prov->failed || type > prov->expected ||
+							type < prov->previous) {
 		l_error("Expected %2.2x, Got:%2.2x", prov->expected, type);
 		fail.reason = PROV_ERR_UNEXPECTED_PDU;
 		goto failure;
@@ -648,6 +650,8 @@ static void acp_prov_rx(void *user_data, const uint8_t *data, uint16_t len)
 failure:
 	fail.opcode = PROV_FAILED;
 	prov_send(prov, &fail, sizeof(fail));
+	prov->failed = true;
+	prov->previous = -1;
 	if (prov->cmplt)
 		prov->cmplt(prov->caller_data, fail.reason, NULL);
 	prov->cmplt = NULL;
@@ -707,6 +711,7 @@ bool acceptor_start(uint8_t num_ele, uint8_t uuid[16],
 	prov->cmplt = complete_cb;
 	prov->ob = l_queue_new();
 	prov->previous = -1;
+	prov->failed = false;
 	prov->out_opcode = PROV_NONE;
 	prov->caller_data = caller_data;
 
-- 
2.20.1





