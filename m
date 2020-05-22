Return-Path: <SRS0=Rzh7=7E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1D9C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 May 2020 00:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43FF9207D8
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 May 2020 00:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgEVAfJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 May 2020 20:35:09 -0400
Received: from mga14.intel.com ([192.55.52.115]:55685 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727000AbgEVAfI (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 May 2020 20:35:08 -0400
IronPort-SDR: jpHkh++iznV5bEp74OigBIUsdPyIxahmlr5OqVAdAe+kRWrdMxR4J2ZS64IB9Y1usagUoUBV5c
 c5yZd1YXyqnA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2020 17:35:07 -0700
IronPort-SDR: joLupDWfE32RtaprLZBqREJTZrr9FbG71lRQBOm8+qPoht1CANhjedAhZu/umtxJzV4Rwsierx
 rWp0qJ1i+BmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,419,1583222400"; 
   d="scan'208";a="300961706"
Received: from nsalivat-mobl.amr.corp.intel.com (HELO ingas-nuc1.sea.intel.com) ([10.254.98.52])
  by orsmga008.jf.intel.com with ESMTP; 21 May 2020 17:35:07 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 10/10] mesh: Clean up Join() method
Date:   Thu, 21 May 2020 17:35:01 -0700
Message-Id: <20200522003501.106165-11-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200522003501.106165-1-inga.stotland@intel.com>
References: <20200522003501.106165-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This consolidates various places where a pending response
to Join() is created and makes sure that l_dus_message_unref()
is called correctly.
---
 mesh/mesh.c | 49 ++++++++++++++++++++++---------------------------
 1 file changed, 22 insertions(+), 27 deletions(-)

diff --git a/mesh/mesh.c b/mesh/mesh.c
index 6f8974745..24ea3afd6 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -341,6 +341,7 @@ void mesh_cleanup(void)
 			reply = dbus_error(join_pending->msg, MESH_ERROR_FAILED,
 							"Failed. Exiting");
 			l_dbus_send(dbus_get_bus(), reply);
+			l_dbus_message_unref(join_pending->msg);
 		}
 
 		acceptor_cancel(&mesh);
@@ -391,11 +392,6 @@ static void prov_disc_cb(struct l_dbus *bus, void *user_data)
 	if (!join_pending)
 		return;
 
-	if (join_pending->msg) {
-		l_dbus_message_unref(join_pending->msg);
-		join_pending->msg = NULL;
-	}
-
 	acceptor_cancel(&mesh);
 	join_pending->disc_watch = 0;
 
@@ -501,39 +497,40 @@ static void node_init_cb(struct mesh_node *node, struct mesh_agent *agent)
 {
 	struct l_dbus_message *reply;
 	uint8_t num_ele;
+	bool is_error = false;
+	struct l_dbus *dbus = dbus_get_bus();
 
 	if (!node) {
 		reply = dbus_error(join_pending->msg, MESH_ERROR_FAILED,
 				"Failed to create node from application");
-		goto fail;
+		is_error = true;
+		goto done;
 	}
 
 	join_pending->node = node;
 	num_ele = node_get_num_elements(node);
 
 	if (!acceptor_start(num_ele, join_pending->uuid, mesh.algorithms,
-				mesh.prov_timeout, agent, prov_complete_cb,
-				&mesh))
-	{
+						mesh.prov_timeout, agent,
+						prov_complete_cb, &mesh)) {
 		reply = dbus_error(join_pending->msg, MESH_ERROR_FAILED,
 				"Failed to start provisioning acceptor");
-		goto fail;
-	}
+		is_error = true;
+	} else
+		reply = l_dbus_message_new_method_return(join_pending->msg);
 
-	reply = l_dbus_message_new_method_return(join_pending->msg);
-	l_dbus_send(dbus_get_bus(), reply);
+done:
+	l_dbus_send(dbus, reply);
+	l_dbus_message_unref(join_pending->msg);
 	join_pending->msg = NULL;
 
-	/* Setup disconnect watch */
-	join_pending->disc_watch = l_dbus_add_disconnect_watch(dbus_get_bus(),
+	if (is_error)
+		free_pending_join_call(true);
+	else
+		/* Setup disconnect watch */
+		join_pending->disc_watch = l_dbus_add_disconnect_watch(dbus,
 						join_pending->sender,
 						prov_disc_cb, NULL, NULL);
-
-	return;
-
-fail:
-	l_dbus_send(dbus_get_bus(), reply);
-	free_pending_join_call(true);
 }
 
 static struct l_dbus_message *join_network_call(struct l_dbus *dbus,
@@ -591,25 +588,23 @@ static struct l_dbus_message *cancel_join_call(struct l_dbus *dbus,
 
 	l_debug("Cancel Join");
 
-	if (!join_pending) {
-		reply = dbus_error(msg, MESH_ERROR_DOES_NOT_EXIST,
+	if (!join_pending)
+		return dbus_error(msg, MESH_ERROR_DOES_NOT_EXIST,
 							"No join in progress");
-		goto done;
-	}
-
 	acceptor_cancel(&mesh);
 
 	/* Return error to the original Join call */
 	if (join_pending->msg) {
 		reply = dbus_error(join_pending->msg, MESH_ERROR_FAILED, NULL);
 		l_dbus_send(dbus_get_bus(), reply);
+		l_dbus_message_unref(join_pending->msg);
 	}
 
 	reply = l_dbus_message_new_method_return(msg);
 	l_dbus_message_set_arguments(reply, "");
 
 	free_pending_join_call(true);
-done:
+
 	return reply;
 }
 
-- 
2.26.2

