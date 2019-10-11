Return-Path: <SRS0=4il6=YE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC8EC47404
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Oct 2019 17:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0AD1214E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Oct 2019 17:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbfJKRbj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Oct 2019 13:31:39 -0400
Received: from mga03.intel.com ([134.134.136.65]:55492 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728400AbfJKRbj (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Oct 2019 13:31:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2019 10:31:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,284,1566889200"; 
   d="scan'208";a="194392309"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.255.229.50])
  by fmsmga007.fm.intel.com with ESMTP; 11 Oct 2019 10:31:38 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, luiz.dentz@gmail.com
Subject: [PATCH BlueZ] unit: Fix valgrind errors in test-mesh-crypto
Date:   Fri, 11 Oct 2019 10:31:29 -0700
Message-Id: <20191011173129.14941-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Two HEAP errors, and one error caused by missing checksum data.
---
 unit/test-mesh-crypto.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/unit/test-mesh-crypto.c b/unit/test-mesh-crypto.c
index 6acb9c0b6..6c2d36736 100644
--- a/unit/test-mesh-crypto.c
+++ b/unit/test-mesh-crypto.c
@@ -217,7 +217,9 @@ static const struct mesh_crypto_test s8_2_6 = {
 static const struct mesh_crypto_test s8_3_1 = {
 	.name		= "8.3.1 Message #1",
 
+	.app_key	= "63964771734fbd76e3b40519d1d94a48",
 	.net_key	= "7dd7364cd842ad18c17c2b820c84c3d6",
+	.dev_key	= "9d6dd0e96eb25dc19a40ed9914f8f03f",
 	.iv_index	= 0x12345678,
 
 	.net_ttl	= 0x00,
@@ -244,8 +246,10 @@ static const struct mesh_crypto_test s8_3_1 = {
 static const struct mesh_crypto_test s8_3_2 = {
 	.name		= "8.3.2 Message #2",
 
-	.iv_index	= 0x12345678,
+	.app_key	= "63964771734fbd76e3b40519d1d94a48",
 	.net_key	= "7dd7364cd842ad18c17c2b820c84c3d6",
+	.dev_key	= "9d6dd0e96eb25dc19a40ed9914f8f03f",
+	.iv_index	= 0x12345678,
 
 	.ctl		= true,
 	.net_ttl	= 0x00,
@@ -271,7 +275,9 @@ static const struct mesh_crypto_test s8_3_2 = {
 static const struct mesh_crypto_test s8_3_3 = {
 	.name		= "8.3.3 Message #3",
 
+	.app_key	= "63964771734fbd76e3b40519d1d94a48",
 	.net_key	= "7dd7364cd842ad18c17c2b820c84c3d6",
+	.dev_key	= "9d6dd0e96eb25dc19a40ed9914f8f03f",
 	.iv_index	= 0x12345678,
 
 	.ctl		= true,
@@ -298,7 +304,9 @@ static const struct mesh_crypto_test s8_3_3 = {
 static const struct mesh_crypto_test s8_3_4 = {
 	.name		= "8.3.4 Message #4",
 
+	.app_key	= "63964771734fbd76e3b40519d1d94a48",
 	.net_key	= "7dd7364cd842ad18c17c2b820c84c3d6",
+	.dev_key	= "9d6dd0e96eb25dc19a40ed9914f8f03f",
 	.iv_index	= 0x12345678,
 
 	.net_nid	= 0x5e,
@@ -331,7 +339,9 @@ static const struct mesh_crypto_test s8_3_4 = {
 static const struct mesh_crypto_test s8_3_5 = {
 	.name		= "8.3.5 Message #5",
 
+	.app_key	= "63964771734fbd76e3b40519d1d94a48",
 	.net_key	= "7dd7364cd842ad18c17c2b820c84c3d6",
+	.dev_key	= "9d6dd0e96eb25dc19a40ed9914f8f03f",
 	.iv_index	= 0x12345678,
 
 	.net_nid	= 0x5e,
@@ -364,6 +374,7 @@ static const struct mesh_crypto_test s8_3_5 = {
 static const struct mesh_crypto_test s8_3_6 = {
 	.name		= "8.3.6 Message #6",
 
+	.app_key	= "63964771734fbd76e3b40519d1d94a48",
 	.net_key	= "7dd7364cd842ad18c17c2b820c84c3d6",
 	.dev_key	= "9d6dd0e96eb25dc19a40ed9914f8f03f",
 	.iv_index	= 0x12345678,
@@ -407,7 +418,9 @@ static const struct mesh_crypto_test s8_3_6 = {
 static const struct mesh_crypto_test s8_3_7 = {
 	.name		= "8.3.7 Message #7",
 
+	.app_key	= "63964771734fbd76e3b40519d1d94a48",
 	.net_key	= "7dd7364cd842ad18c17c2b820c84c3d6",
+	.dev_key	= "9d6dd0e96eb25dc19a40ed9914f8f03f",
 	.iv_index	= 0x12345678,
 
 	.net_nid	= 0x68,
@@ -439,7 +452,9 @@ static const struct mesh_crypto_test s8_3_8 = {
 	.seg_max	= 1,
 	.seg_num	= 0,
 
+	.app_key	= "63964771734fbd76e3b40519d1d94a48",
 	.net_key	= "7dd7364cd842ad18c17c2b820c84c3d6",
+	.dev_key	= "9d6dd0e96eb25dc19a40ed9914f8f03f",
 	.iv_index	= 0x12345678,
 
 	.net_nid	= 0x68,
@@ -468,7 +483,9 @@ static const struct mesh_crypto_test s8_3_8 = {
 static const struct mesh_crypto_test s8_3_9 = {
 	.name		= "8.3.9 Message #9",
 
+	.app_key	= "63964771734fbd76e3b40519d1d94a48",
 	.net_key	= "7dd7364cd842ad18c17c2b820c84c3d6",
+	.dev_key	= "9d6dd0e96eb25dc19a40ed9914f8f03f",
 	.iv_index	= 0x12345678,
 
 	.net_nid	= 0x68,
@@ -497,8 +514,10 @@ static const struct mesh_crypto_test s8_3_9 = {
 static const struct mesh_crypto_test s8_3_10 = {
 	.name		= "8.3.10 Message #10",
 
-	.iv_index	= 0x12345678,
+	.app_key	= "63964771734fbd76e3b40519d1d94a48",
 	.net_key	= "7dd7364cd842ad18c17c2b820c84c3d6",
+	.dev_key	= "9d6dd0e96eb25dc19a40ed9914f8f03f",
+	.iv_index	= 0x12345678,
 
 	.net_nid	= 0x5e,
 	.net_ttl	= 0x00,
@@ -542,8 +561,10 @@ static const struct mesh_crypto_test s8_3_11 = {
 	.fn_cntr	= "072f",
 	.p		= "01120123450000072f",
 
-	.iv_index	= 0x12345678,
+	.app_key	= "63964771734fbd76e3b40519d1d94a48",
 	.net_key	= "7dd7364cd842ad18c17c2b820c84c3d6",
+	.dev_key	= "9d6dd0e96eb25dc19a40ed9914f8f03f",
+	.iv_index	= 0x12345678,
 
 	.net_nid	= 0x5e,
 	.net_ttl	= 0x03,
@@ -1333,7 +1354,7 @@ static void check_decrypt(const struct mesh_crypto_test *keys)
 	uint8_t priv_rand[16];
 	uint8_t p[9];
 	size_t p_len;
-	uint8_t *packet;
+	uint8_t *packet = NULL;
 	size_t packet_len;
 	const uint8_t *net_hdr;
 	uint8_t *net_msg;
@@ -1426,6 +1447,7 @@ static void check_decrypt(const struct mesh_crypto_test *keys)
 		mesh_crypto_network_nonce(keys->frnd, keys->net_ttl,
 				keys->net_seq[i], keys->net_src, keys->iv_index,
 				net_nonce);
+		l_free(packet);
 		packet = l_util_from_hexstring(keys->packet[i], &packet_len);
 
 		net_hdr = packet + 1;
@@ -1731,6 +1753,7 @@ static void check_id_beacon(const struct mesh_crypto_test *keys)
 
 	l_info("");
 
+	l_free(rand);
 	l_free(net_key);
 }
 
@@ -1784,6 +1807,7 @@ static void check_k128(const struct mesh_crypto_test *keys)
 
 	verify_data("k1(N, salt, info)", 0, keys->enc_key, enc_key, 16);
 
+	l_free(net_key);
 	l_info("");
 }
 
-- 
2.21.0

