Return-Path: <SRS0=JVds=Q5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DD6C43381
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Feb 2019 06:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 660EA20818
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Feb 2019 06:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbfBVGcn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Feb 2019 01:32:43 -0500
Received: from mga02.intel.com ([134.134.136.20]:27829 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbfBVGcn (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Feb 2019 01:32:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2019 22:32:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,398,1544515200"; 
   d="scan'208";a="301674892"
Received: from ingas-nuc1.sea.intel.com ([10.251.136.115])
  by orsmga005.jf.intel.com with ESMTP; 21 Feb 2019 22:32:41 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 3/3 v2] mesh: Implement Leave() method on Network interface
Date:   Thu, 21 Feb 2019 22:31:48 -0800
Message-Id: <20190222063148.4995-4-inga.stotland@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190222063148.4995-1-inga.stotland@intel.com>
References: <20190222063148.4995-1-inga.stotland@intel.com>
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

