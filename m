Return-Path: <SRS0=p+wm=66=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1997FC433E1
	for <linux-bluetooth@archiver.kernel.org>; Sat, 16 May 2020 01:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 086A8207BB
	for <linux-bluetooth@archiver.kernel.org>; Sat, 16 May 2020 01:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgEPB1w (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 May 2020 21:27:52 -0400
Received: from mga14.intel.com ([192.55.52.115]:12009 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726223AbgEPB1w (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 May 2020 21:27:52 -0400
IronPort-SDR: VemDf4cVLU0VdtGZPuf11tmAvWGOArKdbMt/GuwiQP/oitEWaTP+DOrXmagS4W6xpQRNcdLJa1
 PXxFzyPliFIg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 18:27:51 -0700
IronPort-SDR: gXHx7h1QqxFOU6ss/Wut7MhoaRRDPbYAGbHGuPXiek+UA6AjLJ18xfQxWYnP9+VYKCTJwpLyey
 8afLeaY1S8ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,397,1583222400"; 
   d="scan'208";a="307568637"
Received: from bgi1-mobl2.amr.corp.intel.com ([10.252.132.104])
  by FMSMGA003.fm.intel.com with ESMTP; 15 May 2020 18:27:51 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com
Subject: [PATCH BlueZ v2 2/2] mesh: Fix valgrind memory leak warnings
Date:   Fri, 15 May 2020 18:27:42 -0700
Message-Id: <20200516012742.573151-3-brian.gix@intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200516012742.573151-1-brian.gix@intel.com>
References: <20200516012742.573151-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

These warnings are caused by not completely freeing memory allocations
at shutdown, and are not serious, but they make valgrind output cleaner.
---
 mesh/agent.c    |  1 +
 mesh/mesh.c     |  4 ++++
 mesh/net-keys.c |  6 ++++++
 mesh/net-keys.h |  1 +
 mesh/net.c      | 12 +++++++++++-
 mesh/net.h      |  3 ++-
 6 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/mesh/agent.c b/mesh/agent.c
index bb52f4146..a06cc2b99 100644
--- a/mesh/agent.c
+++ b/mesh/agent.c
@@ -245,6 +245,7 @@ void mesh_agent_cleanup(void)
 		return;
 
 	l_queue_destroy(agents, agent_free);
+	agents = NULL;
 
 }
 
diff --git a/mesh/mesh.c b/mesh/mesh.c
index 23ff9c2a8..451cefbb4 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -27,6 +27,7 @@
 #include "mesh/mesh-io.h"
 #include "mesh/node.h"
 #include "mesh/net.h"
+#include "mesh/net-keys.h"
 #include "mesh/provision.h"
 #include "mesh/model.h"
 #include "mesh/dbus.h"
@@ -340,8 +341,11 @@ void mesh_cleanup(void)
 	}
 
 	l_queue_destroy(pending_queue, pending_request_exit);
+	mesh_agent_cleanup();
 	node_cleanup_all();
 	mesh_model_cleanup();
+	mesh_net_cleanup();
+	net_key_cleanup();
 
 	l_dbus_object_remove_interface(dbus_get_bus(), BLUEZ_MESH_PATH,
 							MESH_NETWORK_INTERFACE);
diff --git a/mesh/net-keys.c b/mesh/net-keys.c
index f7eb2ca68..7dfabf922 100644
--- a/mesh/net-keys.c
+++ b/mesh/net-keys.c
@@ -523,3 +523,9 @@ void net_key_beacon_disable(uint32_t id)
 	l_timeout_remove(key->snb.timeout);
 	key->snb.timeout = NULL;
 }
+
+void net_key_cleanup(void)
+{
+	l_queue_destroy(keys, l_free);
+	keys = NULL;
+}
diff --git a/mesh/net-keys.h b/mesh/net-keys.h
index 9385e2c51..4f480fcda 100644
--- a/mesh/net-keys.h
+++ b/mesh/net-keys.h
@@ -21,6 +21,7 @@
 #define KEY_REFRESH		0x01
 #define IV_INDEX_UPDATE		0x02
 
+void net_key_cleanup(void);
 bool net_key_confirm(uint32_t id, const uint8_t master[16]);
 bool net_key_retrieve(uint32_t id, uint8_t *master);
 uint32_t net_key_add(const uint8_t master[16]);
diff --git a/mesh/net.c b/mesh/net.c
index bfb9c4435..f104be0f9 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -681,8 +681,10 @@ struct mesh_net *mesh_net_new(struct mesh_node *node)
 	return net;
 }
 
-void mesh_net_free(struct mesh_net *net)
+void mesh_net_free(void *user_data)
 {
+	struct mesh_net *net = user_data;
+
 	if (!net)
 		return;
 
@@ -701,6 +703,14 @@ void mesh_net_free(struct mesh_net *net)
 	l_free(net);
 }
 
+void mesh_net_cleanup(void)
+{
+	l_queue_destroy(fast_cache, l_free);
+	fast_cache = NULL;
+	l_queue_destroy(nets, mesh_net_free);
+	nets = NULL;
+}
+
 bool mesh_net_set_seq_num(struct mesh_net *net, uint32_t seq)
 {
 	if (!net)
diff --git a/mesh/net.h b/mesh/net.h
index bfc8064f3..8646d5aef 100644
--- a/mesh/net.h
+++ b/mesh/net.h
@@ -265,7 +265,8 @@ typedef void (*mesh_net_status_func_t)(uint16_t remote, uint8_t status,
 					void *user_data);
 
 struct mesh_net *mesh_net_new(struct mesh_node *node);
-void mesh_net_free(struct mesh_net *net);
+void mesh_net_free(void *net);
+void mesh_net_cleanup(void);
 void mesh_net_flush_msg_queues(struct mesh_net *net);
 void mesh_net_set_iv_index(struct mesh_net *net, uint32_t index, bool update);
 bool mesh_net_iv_index_update(struct mesh_net *net);
-- 
2.25.4

