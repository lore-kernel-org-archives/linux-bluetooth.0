Return-Path: <SRS0=m/C2=4G=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4507C34026
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Feb 2020 19:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88C0321D56
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Feb 2020 19:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgBRTaU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:30:20 -0500
Received: from mga18.intel.com ([134.134.136.126]:63223 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbgBRTaU (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Feb 2020 14:30:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2020 11:30:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,457,1574150400"; 
   d="scan'208";a="268881413"
Received: from ingas-nuc1.sea.intel.com ([10.254.190.110])
  by fmsmga002.fm.intel.com with ESMTP; 18 Feb 2020 11:30:18 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] mesh: Fix app payload decryption for virtual labels
Date:   Tue, 18 Feb 2020 11:30:10 -0800
Message-Id: <20200218193010.12725-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This fixes a bug when a virtual label and its size hasn't been passed
to a decryption function: instead of always using NULL pointer for
label and 0 for lable size, use actual virtual label info if decrypting
a payload addressed to a virtual destination.
---
 mesh/model.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mesh/model.c b/mesh/model.c
index 072972fda..4e5856292 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -444,8 +444,8 @@ static int app_packet_decrypt(struct mesh_net *net, const uint8_t *data,
 			continue;
 
 		if (old_key && old_key_aid == key_aid) {
-			decrypted = mesh_crypto_payload_decrypt(NULL, 0, data,
-						size, szmict, src, dst, key_aid,
+			decrypted = mesh_crypto_payload_decrypt(virt, virt_size,
+					data, size, szmict, src, dst, key_aid,
 						seq, iv_idx, out, old_key);
 
 			if (decrypted) {
@@ -457,8 +457,8 @@ static int app_packet_decrypt(struct mesh_net *net, const uint8_t *data,
 		}
 
 		if (new_key && new_key_aid == key_aid) {
-			decrypted = mesh_crypto_payload_decrypt(NULL, 0, data,
-						size, szmict, src, dst, key_aid,
+			decrypted = mesh_crypto_payload_decrypt(virt, virt_size,
+					data, size, szmict, src, dst, key_aid,
 						seq, iv_idx, out, new_key);
 
 			if (decrypted) {
-- 
2.21.1

