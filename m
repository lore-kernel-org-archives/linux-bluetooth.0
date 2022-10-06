Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BD4C4332F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Oct 2022 15:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbiJFPAB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Oct 2022 11:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbiJFO76 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Oct 2022 10:59:58 -0400
Received: from voyager.loytec.com (voyager.loytec.com [88.198.4.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C787D1F619
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Oct 2022 07:59:54 -0700 (PDT)
Received: from 212-17-98-152.static.upcbusiness.at ([212.17.98.152] helo=lexx.office.loytec.com)
        by voyager.loytec.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <isak.westin@loytec.com>)
        id 1ogSLo-0006rc-1b
        for linux-bluetooth@vger.kernel.org; Thu, 06 Oct 2022 16:59:52 +0200
Received: from loytec-dev-vm.delta.corp ([10.101.25.21])
        by lexx.office.loytec.com (8.15.2/8.15.2/Some OS 1.2.3-4.5) with ESMTP id 296ExnRG4163430;
        Thu, 6 Oct 2022 16:59:49 +0200
From:   Isak Westin <isak.westin@loytec.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Isak Westin <isak.westin@loytec.com>
Subject: [PATCH BlueZ 4/6] mesh: provisionee: Check prov start parameters
Date:   Thu,  6 Oct 2022 16:59:25 +0200
Message-Id: <20221006145927.32731-5-isak.westin@loytec.com>
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

Verify that all parameters in a Provisioning Start PDU are valid, also
compared to the capabilities that has been sent.
---
 mesh/prov-acceptor.c | 57 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 46 insertions(+), 11 deletions(-)

diff --git a/mesh/prov-acceptor.c b/mesh/prov-acceptor.c
index 0cefb2fa9..bf8c573da 100644
--- a/mesh/prov-acceptor.c
+++ b/mesh/prov-acceptor.c
@@ -384,6 +384,47 @@ static void send_rand(struct mesh_prov_acceptor *prov)
 	prov_send(prov, &msg, sizeof(msg));
 }
 
+static bool prov_start_check(struct prov_start *start,
+						struct mesh_net_prov_caps *caps)
+{
+	if (start->algorithm || start->pub_key > 1 || start->auth_method > 3)
+		return false;
+
+	if (start->pub_key && !caps->pub_type)
+		return false;
+
+	switch (start->auth_method) {
+	case 0: /* No OOB */
+		if (start->auth_action != 0 || start->auth_size != 0)
+			return false;
+
+		break;
+
+	case 1: /* Static OOB */
+		if (!caps->static_type || start->auth_action != 0 ||
+							start->auth_size != 0)
+			return false;
+
+		break;
+
+	case 2: /* Output OOB */
+		if (!(caps->output_action & (1 << start->auth_action)) ||
+							start->auth_size == 0)
+			return false;
+
+		break;
+
+	case 3: /* Input OOB */
+		if (!(caps->input_action & (1 << start->auth_action)) ||
+							start->auth_size == 0)
+			return false;
+
+		break;
+	}
+
+	return true;
+}
+
 static void acp_prov_rx(void *user_data, const uint8_t *data, uint16_t len)
 {
 	struct mesh_prov_acceptor *rx_prov = user_data;
@@ -433,22 +474,16 @@ static void acp_prov_rx(void *user_data, const uint8_t *data, uint16_t len)
 		memcpy(&prov->conf_inputs.start, data,
 				sizeof(prov->conf_inputs.start));
 
-		if (prov->conf_inputs.start.algorithm ||
-				prov->conf_inputs.start.pub_key > 1 ||
-				prov->conf_inputs.start.auth_method > 3) {
+		if (!prov_start_check(&prov->conf_inputs.start,
+						&prov->conf_inputs.caps)) {
 			fail.reason = PROV_ERR_INVALID_FORMAT;
 			goto failure;
 		}
 
 		if (prov->conf_inputs.start.pub_key) {
-			if (prov->conf_inputs.caps.pub_type) {
-				/* Prompt Agent for Private Key of OOB */
-				mesh_agent_request_private_key(prov->agent,
-							priv_key_cb, prov);
-			} else {
-				fail.reason = PROV_ERR_INVALID_PDU;
-				goto failure;
-			}
+			/* Prompt Agent for Private Key of OOB */
+			mesh_agent_request_private_key(prov->agent,
+						priv_key_cb, prov);
 		} else {
 			/* Ephemeral Public Key requested */
 			ecc_make_key(prov->conf_inputs.dev_pub_key,
-- 
2.20.1





