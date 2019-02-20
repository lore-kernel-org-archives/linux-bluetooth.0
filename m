Return-Path: <SRS0=cy5f=Q3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FEE8C43381
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Feb 2019 05:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42B8120C01
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Feb 2019 05:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbfBTFx1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Feb 2019 00:53:27 -0500
Received: from mga17.intel.com ([192.55.52.151]:18898 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbfBTFx1 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Feb 2019 00:53:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2019 21:53:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,388,1544515200"; 
   d="scan'208";a="144929342"
Received: from ingas-nuc1.sea.intel.com ([10.251.128.60])
  by fmsmga002.fm.intel.com with ESMTP; 19 Feb 2019 21:53:26 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 3/3] mesh: Implement Leave() method on Network interface
Date:   Tue, 19 Feb 2019 21:53:20 -0800
Message-Id: <20190220055320.2333-4-inga.stotland@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190220055320.2333-1-inga.stotland@intel.com>
References: <20190220055320.2333-1-inga.stotland@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This implements D-Bus Leave() method that results in complete removal
of node information from the system, including configuration files
from storage directory.
---
 mesh/mesh.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/mesh/mesh.c b/mesh/mesh.c
index 0f3c3c9fd..8db83b7c3 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -698,6 +698,22 @@ static struct l_dbus_message *attach_call(struct l_dbus *dbus,
 	return NULL;
 }
 
+static struct l_dbus_message *leave_call(struct l_dbus *dbus,
+						struct l_dbus_message *msg,
+						void *user_data)
+{
+	uint64_t token;
+
+	l_debug("Leave");
+
+	if (!l_dbus_message_get_arguments(msg, "t", &token))
+		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
+
+	node_remove(node_find_by_token(token));
+
+	return l_dbus_message_new_method_return(msg);
+}
+
 static void setup_network_interface(struct l_dbus_interface *iface)
 {
 	l_dbus_interface_method(iface, "Join", 0, join_network_call, "",
@@ -709,7 +725,8 @@ static void setup_network_interface(struct l_dbus_interface *iface)
 					"oa(ya(qa{sv}))", "ot", "node",
 					"configuration", "app", "token");
 
-	/* TODO: Implement Leave method */
+	l_dbus_interface_method(iface, "Leave", 0, leave_call, "", "t",
+								"token");
 }
 
 bool mesh_dbus_init(struct l_dbus *dbus)
-- 
2.17.2

