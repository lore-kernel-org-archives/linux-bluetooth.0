Return-Path: <SRS0=V72R=7W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBD5C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Jun 2020 00:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B97F20737
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Jun 2020 00:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732632AbgFIAov (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:44:51 -0400
Received: from mga07.intel.com ([134.134.136.100]:14447 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729012AbgFHXL4 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Jun 2020 19:11:56 -0400
IronPort-SDR: t3CtxWuUBkJxeTf5/UeOLB5MdhVG3vy6qrpuD5Oyv1MNL+b99WbyE8TgMjsUCx4ZSVYHyt3Z5j
 mrbuDPnfSvhg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2020 16:11:54 -0700
IronPort-SDR: ovrY0aFQoGrgf9GQ1/cdng8chJlyYt6+YbsG0kYtrtzb1u+pkhlQ5asO7PQUC1vCw6LaGLxeDC
 jRaExKMT5Q8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,489,1583222400"; 
   d="scan'208";a="259949492"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.255.228.29])
  by fmsmga008.fm.intel.com with ESMTP; 08 Jun 2020 16:11:54 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com
Subject: [PATCH BlueZ] mesh: Fix clean-up introduced check
Date:   Mon,  8 Jun 2020 16:11:51 -0700
Message-Id: <20200608231151.956258-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Before the clean-up we were making a useless check of an otherwise
unused boolean (net->provisioner). The was replaced a check where we
actually take the node type (node->provisioner).  However, it turns out
that the check was incorrect in the first place.
---
 mesh/model.c | 2 +-
 mesh/net.c   | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/mesh/model.c b/mesh/model.c
index f2dfb2644..5ed95afac 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -907,7 +907,7 @@ bool mesh_model_rx(struct mesh_node *node, bool szmict, uint32_t seq0,
 	 * The packet needs to be decoded by the correct key which
 	 * is hinted by key_aid, but is not necessarily definitive
 	 */
-	if (key_aid == APP_AID_DEV || node_is_provisioner(node))
+	if (key_aid == APP_AID_DEV)
 		decrypt_idx = dev_packet_decrypt(node, data, size, szmict, src,
 						dst, key_aid, seq0, iv_index,
 						clear_text);
diff --git a/mesh/net.c b/mesh/net.c
index c12dd6541..7dbe45f7d 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -108,7 +108,6 @@ struct mesh_net {
 	bool friend_enable;
 	bool beacon_enable;
 	bool proxy_enable;
-	bool provisioner;
 	bool friend_seq;
 	struct l_timeout *iv_update_timeout;
 	enum _iv_upd_state iv_upd_state;
-- 
2.25.4

