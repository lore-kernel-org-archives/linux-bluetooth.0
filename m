Return-Path: <SRS0=m/C2=4G=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A494C34026
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Feb 2020 18:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FC382070B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Feb 2020 18:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgBRSgM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Feb 2020 13:36:12 -0500
Received: from mga18.intel.com ([134.134.136.126]:59449 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbgBRSgL (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Feb 2020 13:36:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2020 10:36:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,456,1574150400"; 
   d="scan'208";a="408166678"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.254.52.69])
  by orsmga005.jf.intel.com with ESMTP; 18 Feb 2020 10:36:10 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com
Subject: [PATCH BlueZ] unit: Add Mesh test 8.3.22 - Virtual Addressing
Date:   Tue, 18 Feb 2020 10:36:02 -0800
Message-Id: <20200218183602.9892-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 unit/test-mesh-crypto.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/unit/test-mesh-crypto.c b/unit/test-mesh-crypto.c
index 6c2d36736..32c46a54e 100644
--- a/unit/test-mesh-crypto.c
+++ b/unit/test-mesh-crypto.c
@@ -588,6 +588,45 @@ static const struct mesh_crypto_test s8_3_11 = {
 	.packet		= {"5e6ebfc021edf5d5e748a20ecfd98ddfd32de80befb400213d113813b5"},
 };
 
+static const struct mesh_crypto_test s8_3_22 = {
+	.name		= "8.3.22 Message #22",
+
+	.app_key	= "63964771734fbd76e3b40519d1d94a48",
+	.net_key	= "7dd7364cd842ad18c17c2b820c84c3d6",
+	.dev_key	= "9d6dd0e96eb25dc19a40ed9914f8f03f",
+	.iv_index	= 0x12345677,
+
+	.net_nid	= 0x68,
+	.net_ttl	= 0x03,
+	.app_seq	= 0x07080b,
+	.net_seq	= {0x07080b},
+	.net_src	= 0x1234,
+	.net_dst	= 0xb529,
+	.uuid		= "0073e7e4d8b9440faf8415df4c56c0e1",
+	.akf		= true,
+	.key_aid	= 0x26,
+	.app_msg	= "d50a0048656c6c6f",
+	.enc_msg	= "3871b904d4315263",
+	.app_mic32	= 0x16ca48a0,
+
+	.enc_key	= "0953fa93e7caac9638f58820220a398e",
+	.app_nonce	= "010007080b1234b52912345677",
+
+	.priv_key	= "8b84eedec100067d670971dd2aa700cf",
+
+	.net_nonce	= {"000307080b1234000012345677"},
+
+	.priv_rand	= {"000000000012345677ed31f3fdcf88a4"},
+
+	.trans_pkt	= {"663871b904d431526316ca48a0"},
+
+	.net_msg	= {"ed31f3fdcf88a411135fea55df730b"},
+
+	.net_mic32	= {0x6b28e255},
+
+	.packet		= {"e8d85caecef1e3ed31f3fdcf88a411135fea55df730b6b28e255" },
+};
+
 static const struct mesh_crypto_test s8_4_3 = {
 	.name		= "8.4.3 Secure Network Beacon",
 
@@ -2013,6 +2052,8 @@ int main(int argc, char *argv[])
 	check_decrypt(&s8_3_10);
 	check_encrypt(&s8_3_11); /* Single segment tester unavailable */
 	check_decrypt(&s8_3_11); /* Single segment tester unavailable */
+	check_encrypt(&s8_3_22);
+	check_decrypt(&s8_3_22);
 
 	/* Section 8.4 Beacon Sample Data */
 	check_beacon(&s8_4_3);
-- 
2.21.1

