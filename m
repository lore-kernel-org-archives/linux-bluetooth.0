Return-Path: <SRS0=/mwE=PU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42358C43387
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Jan 2019 02:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17B0E20851
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Jan 2019 02:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfALClL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Jan 2019 21:41:11 -0500
Received: from mga14.intel.com ([192.55.52.115]:57134 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbfALClL (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Jan 2019 21:41:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jan 2019 18:41:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,467,1539673200"; 
   d="scan'208";a="125286979"
Received: from ingas-nuc1.sea.intel.com ([10.254.189.224])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Jan 2019 18:41:10 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 2/2] mesh: Clean up when finishing the Join call
Date:   Fri, 11 Jan 2019 18:40:55 -0800
Message-Id: <20190112024055.9967-2-inga.stotland@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190112024055.9967-1-inga.stotland@intel.com>
References: <20190112024055.9967-1-inga.stotland@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Consolidate multiple instances where the pending Join data is freed
into calling one function free_pending_join_call().

Also, add checks for NULL data in cleanup functions for storage, agent
and provisioning acceptor.
---
 mesh/agent.c         |  2 +-
 mesh/mesh.c          | 59 +++++++++++++++++++-------------------------
 mesh/prov-acceptor.c |  5 ++--
 mesh/storage.c       |  3 +++
 4 files changed, 32 insertions(+), 37 deletions(-)

diff --git a/mesh/agent.c b/mesh/agent.c
index c6ff11802..88ad84d79 100644
--- a/mesh/agent.c
+++ b/mesh/agent.c
@@ -210,7 +210,7 @@ static void agent_free(void *agent_data)
 
 void mesh_agent_remove(struct mesh_agent *agent)
 {
-	if (!l_queue_find(agents, simple_match, agent))
+	if (!agent || !l_queue_find(agents, simple_match, agent))
 		return;
 
 	agent_free(agent);
diff --git a/mesh/mesh.c b/mesh/mesh.c
index 8971f7cc4..a1c26e77c 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -345,6 +345,28 @@ static void attach_exit(void *data)
 	l_free(pending);
 }
 
+static void free_pending_join_call(bool failed)
+{
+	if (!join_pending)
+		return;
+
+	if (join_pending->disc_watch)
+		l_dbus_remove_watch(dbus_get_bus(),
+						join_pending->disc_watch);
+
+	acceptor_cancel(&mesh);
+
+	mesh_agent_remove(join_pending->agent);
+
+	if (failed) {
+		storage_remove_node_config(join_pending->node);
+		node_free(join_pending->node);
+	}
+
+	l_free(join_pending);
+	join_pending = NULL;
+}
+
 void mesh_cleanup(void)
 {
 	struct l_dbus_message *reply;
@@ -353,19 +375,12 @@ void mesh_cleanup(void)
 	mgmt_unref(mgmt_mesh);
 
 	if (join_pending) {
+		/* The Join() call failed since it has not been completed */
 		reply = dbus_error(join_pending->msg, MESH_ERROR_FAILED,
 							"Failed. Exiting");
 		l_dbus_send(dbus_get_bus(), reply);
 
-		if (join_pending->disc_watch)
-			l_dbus_remove_watch(dbus_get_bus(),
-						join_pending->disc_watch);
-
-		if (join_pending->node)
-			node_free(join_pending->node);
-
-		l_free(join_pending);
-		join_pending = NULL;
+		free_pending_join_call(true);
 	}
 
 	l_queue_destroy(attach_queue, attach_exit);
@@ -404,26 +419,6 @@ const char *mesh_status_str(uint8_t err)
 	}
 }
 
-static void free_pending_join_call(bool failed)
-{
-	if (!join_pending)
-		return;
-
-	if (join_pending->disc_watch)
-		l_dbus_remove_watch(dbus_get_bus(),
-						join_pending->disc_watch);
-
-	mesh_agent_remove(join_pending->agent);
-
-	if (failed) {
-		storage_remove_node_config(join_pending->node);
-		mesh_agent_remove(join_pending->agent);
-	}
-
-	l_free(join_pending);
-	join_pending = NULL;
-}
-
 /* This is being called if the app exits unexpectedly */
 static void prov_disc_cb(struct l_dbus *bus, void *user_data)
 {
@@ -433,8 +428,6 @@ static void prov_disc_cb(struct l_dbus *bus, void *user_data)
 	if (join_pending->msg)
 		l_dbus_message_unref(join_pending->msg);
 
-	acceptor_cancel(&mesh);
-
 	join_pending->disc_watch = 0;
 
 	free_pending_join_call(true);
@@ -553,9 +546,7 @@ static void node_init_cb(struct mesh_node *node, struct mesh_agent *agent)
 
 fail:
 	l_dbus_send(dbus_get_bus(), reply);
-	mesh_agent_remove(join_pending->agent);
-	l_free(join_pending);
-	join_pending = NULL;
+	free_pending_join_call(true);
 }
 
 static struct l_dbus_message *join_network_call(struct l_dbus *dbus,
diff --git a/mesh/prov-acceptor.c b/mesh/prov-acceptor.c
index baa3c4d30..d983991d4 100644
--- a/mesh/prov-acceptor.c
+++ b/mesh/prov-acceptor.c
@@ -118,9 +118,10 @@ static struct mesh_prov_acceptor *prov = NULL;
 
 static void acceptor_free(void)
 {
+	if (!prov)
+		return;
 
-	if (prov)
-		l_timeout_remove(prov->timeout);
+	l_timeout_remove(prov->timeout);
 
 	mesh_send_cancel(bec_filter, sizeof(bec_filter));
 	mesh_send_cancel(&pkt_filter, sizeof(pkt_filter));
diff --git a/mesh/storage.c b/mesh/storage.c
index 57ae88b34..3a6614eb2 100644
--- a/mesh/storage.c
+++ b/mesh/storage.c
@@ -573,6 +573,9 @@ void storage_remove_node_config(struct mesh_node *node)
 	struct json_object *jnode;
 	const char *dir_name;
 
+	if (!node)
+		return;
+
 	jnode = node_jconfig_get(node);
 	if (jnode)
 		json_object_put(jnode);
-- 
2.17.2

