Return-Path: <SRS0=kmT4=B7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F428C433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 05:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D6D2204EA
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 05:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbgHUFtA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Aug 2020 01:49:00 -0400
Received: from mga18.intel.com ([134.134.136.126]:50493 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbgHUFs7 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Aug 2020 01:48:59 -0400
IronPort-SDR: 91QqtAPYnpRBUcNOh8znkfKxR6R8MMBs7BiJYtG2UgwrMxzuohsXczKf0QNyCwmUl53/L881Le
 0J/q6LnIheBQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9719"; a="143101665"
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="143101665"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2020 22:48:57 -0700
IronPort-SDR: 7dBW4DEL9L/mDCU1/sgLup0lVPcE6otDVhkmqqa7o3FaLrhgBk547W7QD5dFuEL+cDnVWoJYEc
 Ut/AI7p1yIeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="278829511"
Received: from ssuhag-mobl.amr.corp.intel.com (HELO ingas-nuc1.intel.com) ([10.254.84.187])
  by fmsmga007.fm.intel.com with ESMTP; 20 Aug 2020 22:48:57 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] mesh: Use valid net key index when handling Send call
Date:   Thu, 20 Aug 2020 22:48:56 -0700
Message-Id: <20200821054856.41857-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Retrieve value of bound Net Key index based on the value of
passed AppKey index. Check if the key is present and fail early
in case of error. Also, pass the correct NetKey index to model
layer in mesh_model_send(), instead of hard coded 0.
---
 mesh/model.c |  2 --
 mesh/node.c  | 13 +++++++++----
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/mesh/model.c b/mesh/model.c
index eb5142503..7e1c4ab92 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -547,8 +547,6 @@ static bool msg_send(struct mesh_node *node, bool cred, uint16_t src,
 			l_debug("no app key for (%x)", app_idx);
 			return false;
 		}
-
-		net_idx = appkey_net_idx(node_get_net(node), app_idx);
 	}
 
 	out = l_malloc(out_len);
diff --git a/mesh/node.c b/mesh/node.c
index 1eeffeb8b..ed3d959c5 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -1761,7 +1761,7 @@ static struct l_dbus_message *send_call(struct l_dbus *dbus,
 	const char *sender, *ele_path;
 	struct l_dbus_message_iter iter_data;
 	struct node_element *ele;
-	uint16_t dst, app_idx, src;
+	uint16_t dst, app_idx, net_idx, src;
 	uint8_t *data;
 	uint32_t len;
 
@@ -1790,10 +1790,15 @@ static struct l_dbus_message *send_call(struct l_dbus *dbus,
 
 	if (app_idx & ~APP_IDX_MASK)
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
-						"Invalid key_index");
+						"Invalid key index");
+
+	net_idx = appkey_net_idx(node_get_net(node), app_idx);
+	if (net_idx == NET_IDX_INVALID)
+		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
+							"Key not found");
 
-	if (!mesh_model_send(node, src, dst, app_idx, 0, DEFAULT_TTL, false,
-								data, len))
+	if (!mesh_model_send(node, src, dst, app_idx, net_idx, DEFAULT_TTL,
+							false, data, len))
 		return dbus_error(msg, MESH_ERROR_FAILED, NULL);
 
 	return l_dbus_message_new_method_return(msg);
-- 
2.26.2

