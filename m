Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF4AC433DB
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Mar 2021 23:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E812464F96
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Mar 2021 23:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbhCHXhQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Mar 2021 18:37:16 -0500
Received: from mga03.intel.com ([134.134.136.65]:37274 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230460AbhCHXhQ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Mar 2021 18:37:16 -0500
IronPort-SDR: ZAf1uAosfqEtzI8dQGKWcmOGlA7+ywLBPzroLPW1LtsjpwTd1kcfy8gxGEYvztzxVgsWrCkubh
 gYqMqyi5yCBQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="188174056"
X-IronPort-AV: E=Sophos;i="5.81,233,1610438400"; 
   d="scan'208";a="188174056"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 15:37:15 -0800
IronPort-SDR: IWgoyCzpMnSBXSjOT0n/4JqRMWy040Qc9bwc6lsd2E8tOTQdl/pkWjQg8/xTdc5ni2UuixCB/P
 7alAB2KTP7vw==
X-IronPort-AV: E=Sophos;i="5.81,233,1610438400"; 
   d="scan'208";a="437664818"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.212.191.212])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 15:37:15 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, luiz.dentz@gmail.com,
        Brian Gix <brian.gix@intel.com>
Subject: [PATCH BlueZ] mesh: Validate OTA provision security material
Date:   Mon,  8 Mar 2021 15:36:53 -0800
Message-Id: <20210308233653.187406-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When validating incoming security material, ensure that the data is
unique to the provisioning session.
---
 mesh/prov-acceptor.c  | 11 +++++++++++
 mesh/prov-initiator.c | 10 ++++++++++
 2 files changed, 21 insertions(+)

diff --git a/mesh/prov-acceptor.c b/mesh/prov-acceptor.c
index a03ee1ce5..4ec6ea34a 100644
--- a/mesh/prov-acceptor.c
+++ b/mesh/prov-acceptor.c
@@ -203,6 +203,10 @@ static bool prov_calc_secret(const uint8_t *pub, const uint8_t *priv,
 
 static bool acp_credentials(struct mesh_prov_acceptor *prov)
 {
+	if (!memcmp(prov->conf_inputs.prv_pub_key,
+					prov->conf_inputs.dev_pub_key, 64))
+		return false;
+
 	if (!prov_calc_secret(prov->conf_inputs.prv_pub_key,
 			prov->private_key, prov->secret))
 		return false;
@@ -529,6 +533,13 @@ static void acp_prov_rx(void *user_data, const uint8_t *data, uint16_t len)
 		break;
 
 	case PROV_RANDOM: /* Random Value */
+
+		/* Disallow matching random values */
+		if (!memcmp(prov->rand_auth_workspace, data, 16)) {
+			fail.reason = PROV_ERR_INVALID_PDU;
+			goto failure;
+		}
+
 		/* Calculate Session key (needed later) while data is fresh */
 		mesh_crypto_prov_prov_salt(prov->salt, data,
 						prov->rand_auth_workspace,
diff --git a/mesh/prov-initiator.c b/mesh/prov-initiator.c
index 8399282ee..4f492a49c 100644
--- a/mesh/prov-initiator.c
+++ b/mesh/prov-initiator.c
@@ -202,6 +202,10 @@ static bool prov_calc_secret(const uint8_t *pub, const uint8_t *priv,
 
 static bool int_credentials(struct mesh_prov_initiator *prov)
 {
+	if (!memcmp(prov->conf_inputs.prv_pub_key,
+					prov->conf_inputs.dev_pub_key, 64))
+		return false;
+
 	if (!prov_calc_secret(prov->conf_inputs.dev_pub_key,
 				prov->private_key, prov->secret))
 		return false;
@@ -736,6 +740,12 @@ static void int_prov_rx(void *user_data, const uint8_t *data, uint16_t len)
 	case PROV_RANDOM: /* Random */
 		prov->state = INT_PROV_RAND_ACKED;
 
+		/* Disallow matching random values */
+		if (!memcmp(prov->rand_auth_workspace, data, 16)) {
+			fail_code[1] = PROV_ERR_INVALID_PDU;
+			goto failure;
+		}
+
 		/* RXed Device Confirmation */
 		calc_local_material(data);
 		memcpy(prov->rand_auth_workspace + 16, data, 16);
-- 
2.25.4

