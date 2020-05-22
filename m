Return-Path: <SRS0=Rzh7=7E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7547EC433E1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 May 2020 00:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54CE720825
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 May 2020 00:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgEVAfG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 May 2020 20:35:06 -0400
Received: from mga14.intel.com ([192.55.52.115]:55687 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726966AbgEVAfG (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 May 2020 20:35:06 -0400
IronPort-SDR: GxiEKg4ijquzSC6U1OIbc37JrHQJukVQkFGpiPPYeWKcO5KLZlpO6YkHexT2zdjFSEv9HiBr/u
 oy7EIK62TjuA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2020 17:35:05 -0700
IronPort-SDR: vORi1FVuDSEANsXk90qM+BLfdumgFm0bZIFj0JAcaMIW46bq5M+cq7/do9r2YFEb1uNBf1kJvf
 CW6s8YisxE3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,419,1583222400"; 
   d="scan'208";a="300961681"
Received: from nsalivat-mobl.amr.corp.intel.com (HELO ingas-nuc1.sea.intel.com) ([10.254.98.52])
  by orsmga008.jf.intel.com with ESMTP; 21 May 2020 17:35:05 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 06/10] mesh: Create a queue of pending requests in mesh_init()
Date:   Thu, 21 May 2020 17:34:57 -0700
Message-Id: <20200522003501.106165-7-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200522003501.106165-1-inga.stotland@intel.com>
References: <20200522003501.106165-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This removes unnnecessary checking for queue existence every time
either Attach(), Create() or Import() methods are called.
---
 mesh/mesh.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/mesh/mesh.c b/mesh/mesh.c
index 8bd7b3978..4a3ba171d 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -297,6 +297,8 @@ bool mesh_init(const char *config_dir, const char *mesh_conf_fname,
 	mesh_io_get_caps(mesh.io, &caps);
 	mesh.max_filters = caps.max_num_filters;
 
+	pending_queue = l_queue_new();
+
 	return true;
 }
 
@@ -652,9 +654,6 @@ static struct l_dbus_message *attach_call(struct l_dbus *dbus,
 	sender = l_dbus_message_get_sender(msg);
 
 	pending_msg = l_dbus_message_ref(msg);
-	if (!pending_queue)
-		pending_queue = l_queue_new();
-
 	l_queue_push_tail(pending_queue, pending_msg);
 
 	status = node_attach(app_path, sender, token, attach_ready_cb,
@@ -760,10 +759,8 @@ static struct l_dbus_message *create_network_call(struct l_dbus *dbus,
 							"Bad device UUID");
 
 	sender = l_dbus_message_get_sender(msg);
-	pending_msg = l_dbus_message_ref(msg);
-	if (!pending_queue)
-		pending_queue = l_queue_new();
 
+	pending_msg = l_dbus_message_ref(msg);
 	l_queue_push_tail(pending_queue, pending_msg);
 
 	node_create(app_path, sender, uuid, create_node_ready_cb,
@@ -851,11 +848,8 @@ static struct l_dbus_message *import_call(struct l_dbus *dbus,
 							"Bad address");
 
 	sender = l_dbus_message_get_sender(msg);
-	pending_msg = l_dbus_message_ref(msg);
-
-	if (!pending_queue)
-		pending_queue = l_queue_new();
 
+	pending_msg = l_dbus_message_ref(msg);
 	l_queue_push_tail(pending_queue, pending_msg);
 
 	if (!node_import(app_path, sender, uuid, dev_key, net_key, net_idx,
-- 
2.26.2

