Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E09BC433B4
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Apr 2021 19:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42B9E610FB
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Apr 2021 19:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbhDHTKC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 8 Apr 2021 15:10:02 -0400
Received: from mga11.intel.com ([192.55.52.93]:47870 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232804AbhDHTKC (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 8 Apr 2021 15:10:02 -0400
IronPort-SDR: G9qlvWBLHNqe0ctE+oeyWJY6oRWPvJQbgJ8o/BjYQCB/09z3/e7cKnDQSTn6ZI9m7JN/E5qbeN
 OlXzZSEVczUw==
X-IronPort-AV: E=McAfee;i="6000,8403,9948"; a="190414460"
X-IronPort-AV: E=Sophos;i="5.82,207,1613462400"; 
   d="scan'208";a="190414460"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 12:09:50 -0700
IronPort-SDR: kp4/LWq3XYx+2T8q5+q/Lcb1XYfUIZRDNZyaNBwKBTsYlc7suKxsSxxRIb+yOwGXSuK9GUFQ4/
 k/gUDeti9PFw==
X-IronPort-AV: E=Sophos;i="5.82,207,1613462400"; 
   d="scan'208";a="449814061"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.252.132.187])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 12:09:50 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com
Subject: [PATCH BlueZ] mesh: Add Provisioning Confirmation validity check
Date:   Thu,  8 Apr 2021 12:09:28 -0700
Message-Id: <20210408190928.1645427-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Validate generated and received confirmation data is unique during
provisioning.
---
 mesh/prov-acceptor.c  | 13 +++++++++++--
 mesh/prov-initiator.c |  8 ++++++++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/mesh/prov-acceptor.c b/mesh/prov-acceptor.c
index 4ec6ea34a..e806b12ef 100644
--- a/mesh/prov-acceptor.c
+++ b/mesh/prov-acceptor.c
@@ -347,14 +347,20 @@ static void send_pub_key(struct mesh_prov_acceptor *prov)
 	prov->trans_tx(prov->trans_data, &msg, sizeof(msg));
 }
 
-static void send_conf(struct mesh_prov_acceptor *prov)
+static bool send_conf(struct mesh_prov_acceptor *prov)
 {
 	struct prov_conf_msg msg;
 
 	msg.opcode = PROV_CONFIRM;
 	mesh_crypto_aes_cmac(prov->calc_key, prov->rand_auth_workspace, 32,
 								msg.conf);
+
+	/* Fail if confirmations match */
+	if (!memcmp(msg.conf, prov->confirm, sizeof(msg.conf)))
+		return false;
+
 	prov->trans_tx(prov->trans_data, &msg, sizeof(msg));
+	return true;
 }
 
 static void send_rand(struct mesh_prov_acceptor *prov)
@@ -529,7 +535,10 @@ static void acp_prov_rx(void *user_data, const uint8_t *data, uint16_t len)
 		memcpy(prov->confirm, data, 16);
 		prov->expected = PROV_RANDOM;
 
-		send_conf(prov);
+		if (!send_conf(prov)) {
+			fail.reason = PROV_ERR_INVALID_PDU;
+			goto failure;
+		}
 		break;
 
 	case PROV_RANDOM: /* Random Value */
diff --git a/mesh/prov-initiator.c b/mesh/prov-initiator.c
index 4f492a49c..ae9c646de 100644
--- a/mesh/prov-initiator.c
+++ b/mesh/prov-initiator.c
@@ -279,6 +279,7 @@ static void send_confirm(struct mesh_prov_initiator *prov)
 	msg.opcode = PROV_CONFIRM;
 	mesh_crypto_aes_cmac(prov->calc_key, prov->rand_auth_workspace,
 			32, msg.conf);
+	memcpy(prov->confirm, msg.conf, sizeof(prov->confirm));
 	prov->trans_tx(prov->trans_data, &msg, sizeof(msg));
 	prov->state = INT_PROV_CONF_SENT;
 	prov->expected = PROV_CONFIRM;
@@ -732,6 +733,13 @@ static void int_prov_rx(void *user_data, const uint8_t *data, uint16_t len)
 	case PROV_CONFIRM: /* Confirmation */
 		prov->state = INT_PROV_CONF_ACKED;
 		/* RXed Device Confirmation */
+
+		/* Disallow echoed values */
+		if (!memcmp(prov->confirm, data, 16)) {
+			fail_code[1] = PROV_ERR_INVALID_PDU;
+			goto failure;
+		}
+
 		memcpy(prov->confirm, data, 16);
 		print_packet("ConfirmationDevice", prov->confirm, 16);
 		send_random(prov);
-- 
2.25.4

