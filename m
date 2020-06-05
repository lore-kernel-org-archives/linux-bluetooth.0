Return-Path: <SRS0=pjei=7S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D10C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jun 2020 21:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE841206DB
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jun 2020 21:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbgFEVbw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Jun 2020 17:31:52 -0400
Received: from mga07.intel.com ([134.134.136.100]:35351 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728227AbgFEVbw (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Jun 2020 17:31:52 -0400
IronPort-SDR: 7T3Lp9fRaAjlOZzdmuDeZM0RkWCPkdm3AMEO3F/6o1BEjYdvsA7Wo+8a5BG1RPXFLqORqi2lXg
 KsQ5Qwn295NA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2020 14:31:51 -0700
IronPort-SDR: B7vRDmpMx3e94EcAcavclW9lr/W75g+/erSTfC7+Vg6Hvvl84NtiFjzD9KyT/9I/kAAYGmLQhy
 8XBQynRpjhdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,477,1583222400"; 
   d="scan'208";a="305193637"
Received: from ahakman-mobl.amr.corp.intel.com (HELO ingas-nuc1.sea.intel.com) ([10.254.103.116])
  by fmsmga002.fm.intel.com with ESMTP; 05 Jun 2020 14:31:50 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] mesh: Remove unused/redundant functions
Date:   Fri,  5 Jun 2020 14:31:43 -0700
Message-Id: <20200605213143.194808-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This removes mesh_net_provisioner_mode_set (unused) and
mesh_net_provisioner_mode_get (duplicates node_is_provisioner)
---
 mesh/model.c |  2 +-
 mesh/net.c   | 10 ----------
 mesh/net.h   |  2 --
 3 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/mesh/model.c b/mesh/model.c
index ec79a69b8..f2dfb2644 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -907,7 +907,7 @@ bool mesh_model_rx(struct mesh_node *node, bool szmict, uint32_t seq0,
 	 * The packet needs to be decoded by the correct key which
 	 * is hinted by key_aid, but is not necessarily definitive
 	 */
-	if (key_aid == APP_AID_DEV || mesh_net_provisioner_mode_get(net))
+	if (key_aid == APP_AID_DEV || node_is_provisioner(node))
 		decrypt_idx = dev_packet_decrypt(node, data, size, szmict, src,
 						dst, key_aid, seq0, iv_index,
 						clear_text);
diff --git a/mesh/net.c b/mesh/net.c
index 07813eec4..c12dd6541 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -3362,16 +3362,6 @@ void mesh_net_set_iv_index(struct mesh_net *net, uint32_t index, bool update)
 	net->iv_update = update;
 }
 
-void mesh_net_provisioner_mode_set(struct mesh_net *net, bool mode)
-{
-	net->provisioner = mode;
-}
-
-bool mesh_net_provisioner_mode_get(struct mesh_net *net)
-{
-	return net->provisioner;
-}
-
 uint16_t mesh_net_get_primary_idx(struct mesh_net *net)
 {
 	struct mesh_subnet *subnet;
diff --git a/mesh/net.h b/mesh/net.h
index 84e7c1545..f7fe3f150 100644
--- a/mesh/net.h
+++ b/mesh/net.h
@@ -335,8 +335,6 @@ void mesh_net_send_seg(struct mesh_net *net, uint32_t key_id,
 struct mesh_net_heartbeat *mesh_net_heartbeat_get(struct mesh_net *net);
 void mesh_net_heartbeat_init(struct mesh_net *net);
 void mesh_net_heartbeat_send(struct mesh_net *net);
-void mesh_net_provisioner_mode_set(struct mesh_net *net, bool mode);
-bool mesh_net_provisioner_mode_get(struct mesh_net *net);
 bool mesh_net_key_list_get(struct mesh_net *net, uint8_t *buf, uint16_t *count);
 uint16_t mesh_net_get_primary_idx(struct mesh_net *net);
 uint32_t mesh_net_friend_timeout(struct mesh_net *net, uint16_t addr);
-- 
2.26.2

