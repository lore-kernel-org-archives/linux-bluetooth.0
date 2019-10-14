Return-Path: <SRS0=NoyY=YH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD42C4CECE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Oct 2019 21:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D3872089C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Oct 2019 21:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730613AbfJNVsA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Oct 2019 17:48:00 -0400
Received: from mga12.intel.com ([192.55.52.136]:14950 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730586AbfJNVsA (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Oct 2019 17:48:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Oct 2019 14:48:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,296,1566889200"; 
   d="scan'208";a="225211295"
Received: from ingas-nuc1.sea.intel.com ([10.251.131.249])
  by fmsmga002.fm.intel.com with ESMTP; 14 Oct 2019 14:47:59 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] mesh: Add provisioner confirmation
Date:   Mon, 14 Oct 2019 14:47:58 -0700
Message-Id: <20191014214758.13829-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds codes to send a confirmationfrom provisioner's side
after receiving a callback from a provisioning agent.

---
 mesh/prov-initiator.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/mesh/prov-initiator.c b/mesh/prov-initiator.c
index eb59f53f1..5e45d6813 100644
--- a/mesh/prov-initiator.c
+++ b/mesh/prov-initiator.c
@@ -265,6 +265,18 @@ static void calc_local_material(const uint8_t *random)
 	print_packet("Nonce", prov->s_nonce, sizeof(prov->s_nonce));
 }
 
+static void send_confirm(struct mesh_prov_initiator *prov)
+{
+	struct prov_conf_msg msg;
+
+	msg.opcode = PROV_CONFIRM;
+	mesh_crypto_aes_cmac(prov->calc_key, prov->rand_auth_workspace,
+			32, msg.conf);
+	prov->trans_tx(prov->trans_data, &msg, sizeof(msg));
+	prov->state = INT_PROV_CONF_SENT;
+	prov->expected = PROV_CONFIRM;
+}
+
 static void number_cb(void *user_data, int err, uint32_t number)
 {
 	struct mesh_prov_initiator *rx_prov = user_data;
@@ -284,6 +296,7 @@ static void number_cb(void *user_data, int err, uint32_t number)
 	l_put_be32(number, prov->rand_auth_workspace + 28);
 	l_put_be32(number, prov->rand_auth_workspace + 44);
 	prov->material |= MAT_RAND_AUTH;
+	send_confirm(prov);
 }
 
 static void static_cb(void *user_data, int err, uint8_t *key, uint32_t len)
@@ -304,6 +317,7 @@ static void static_cb(void *user_data, int err, uint8_t *key, uint32_t len)
 	memcpy(prov->rand_auth_workspace + 16, key, 16);
 	memcpy(prov->rand_auth_workspace + 32, key, 16);
 	prov->material |= MAT_RAND_AUTH;
+	send_confirm(prov);
 }
 
 static void pub_key_cb(void *user_data, int err, uint8_t *key, uint32_t len)
@@ -321,11 +335,13 @@ static void pub_key_cb(void *user_data, int err, uint8_t *key, uint32_t len)
 		return;
 	}
 
-		memcpy(prov->conf_inputs.dev_pub_key, key, 64);
-		prov->material |= MAT_REMOTE_PUBLIC;
+	memcpy(prov->conf_inputs.dev_pub_key, key, 64);
+	prov->material |= MAT_REMOTE_PUBLIC;
 
-		if ((prov->material & MAT_SECRET) == MAT_SECRET)
-			int_credentials(prov);
+	if ((prov->material & MAT_SECRET) == MAT_SECRET)
+		int_credentials(prov);
+
+	send_confirm(prov);
 }
 
 static void send_pub_key(struct mesh_prov_initiator *prov)
@@ -338,18 +354,6 @@ static void send_pub_key(struct mesh_prov_initiator *prov)
 	prov->state = INT_PROV_KEY_SENT;
 }
 
-static void send_confirm(struct mesh_prov_initiator *prov)
-{
-	struct prov_conf_msg msg;
-
-	msg.opcode = PROV_CONFIRM;
-	mesh_crypto_aes_cmac(prov->calc_key, prov->rand_auth_workspace,
-			32, msg.conf);
-	prov->trans_tx(prov->trans_data, &msg, sizeof(msg));
-	prov->state = INT_PROV_CONF_SENT;
-	prov->expected = PROV_CONFIRM;
-}
-
 static void send_random(struct mesh_prov_initiator *prov)
 {
 	struct prov_rand_msg msg;
-- 
2.21.0

