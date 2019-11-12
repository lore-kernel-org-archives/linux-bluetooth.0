Return-Path: <SRS0=2Kq+=ZE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E60DC43331
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Nov 2019 06:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6948206BA
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Nov 2019 06:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725783AbfKLGWO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Nov 2019 01:22:14 -0500
Received: from mga03.intel.com ([134.134.136.65]:19566 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725298AbfKLGWO (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Nov 2019 01:22:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Nov 2019 22:22:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,295,1569308400"; 
   d="scan'208";a="378760169"
Received: from ingas-nuc1.sea.intel.com ([10.254.99.162])
  by orsmga005.jf.intel.com with ESMTP; 11 Nov 2019 22:22:13 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] mesh: Cancel unprovisioned scan on exit or app disconnect
Date:   Mon, 11 Nov 2019 22:22:05 -0800
Message-Id: <20191112062205.27876-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

If a provisioner app quits or the daemon is stopped while there's
an active scan for unprovisioned devices in progress, the scan needs
to be explicitly canceled.
---
 mesh/manager.c |  8 ++++++++
 mesh/manager.h |  1 +
 mesh/node.c    | 10 ++++++++++
 3 files changed, 19 insertions(+)

diff --git a/mesh/manager.c b/mesh/manager.c
index 0b11b4541..adbb01280 100644
--- a/mesh/manager.c
+++ b/mesh/manager.c
@@ -794,3 +794,11 @@ bool manager_dbus_init(struct l_dbus *bus)
 
 	return true;
 }
+
+void manager_scan_cancel(struct mesh_node *node)
+{
+	if (scan_node != node)
+		return;
+
+	scan_cancel(NULL, node);
+}
diff --git a/mesh/manager.h b/mesh/manager.h
index f27ca4181..5a4c7d94a 100644
--- a/mesh/manager.h
+++ b/mesh/manager.h
@@ -18,3 +18,4 @@
  */
 
 bool manager_dbus_init(struct l_dbus *dbus);
+void manager_scan_cancel(struct mesh_node *node);
diff --git a/mesh/node.c b/mesh/node.c
index e23f32dd1..d6dd819eb 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -42,6 +42,7 @@
 #include "mesh/error.h"
 #include "mesh/dbus.h"
 #include "mesh/agent.h"
+#include "mesh/manager.h"
 #include "mesh/node.h"
 
 #define MIN_COMP_SIZE 14
@@ -310,6 +311,10 @@ static void free_node_resources(void *data)
 	l_queue_destroy(node->elements, element_free);
 	node->elements = NULL;
 
+	/* In case of a provisioner, stop active scanning */
+	if (node->provisioner)
+		manager_scan_cancel(node);
+
 	free_node_dbus_resources(node);
 
 	mesh_net_free(node->net);
@@ -1166,6 +1171,11 @@ static void app_disc_cb(struct l_dbus *bus, void *user_data)
 	l_info("App %s disconnected (%u)", node->owner, node->disc_watch);
 
 	node->disc_watch = 0;
+
+	/* In case of a provisioner, stop active scanning */
+	if (node->provisioner)
+		manager_scan_cancel(node);
+
 	free_node_dbus_resources(node);
 }
 
-- 
2.21.0

