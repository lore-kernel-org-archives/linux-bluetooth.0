Return-Path: <SRS0=CsNs=TW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856D4C282CE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 May 2019 19:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5687920856
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 May 2019 19:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732009AbfEVTyw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 May 2019 15:54:52 -0400
Received: from mga03.intel.com ([134.134.136.65]:64438 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730902AbfEVTyv (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 May 2019 15:54:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 May 2019 12:54:51 -0700
X-ExtLoop1: 1
Received: from bgix-dell-lap.sea.intel.com ([10.255.78.4])
  by fmsmga004.fm.intel.com with ESMTP; 22 May 2019 12:54:50 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com
Subject: [PATCH BlueZ v2 2/5] mesh: Centralize definition of PRIMARY_NET_IDX
Date:   Wed, 22 May 2019 12:54:25 -0700
Message-Id: <20190522195428.1901-3-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190522195428.1901-1-brian.gix@intel.com>
References: <20190522195428.1901-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 mesh/mesh-defs.h |  1 +
 mesh/node.c      | 12 +++++-------
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/mesh/mesh-defs.h b/mesh/mesh-defs.h
index aba0d318f..1a199f156 100644
--- a/mesh/mesh-defs.h
+++ b/mesh/mesh-defs.h
@@ -74,6 +74,7 @@
 
 #define VENDOR_ID_MASK		0xffff0000
 
+#define PRIMARY_NET_IDX		0x0000
 #define MAX_KEY_IDX		0x0fff
 #define MAX_MODEL_COUNT		0xff
 #define MAX_ELE_COUNT		0xff
diff --git a/mesh/node.c b/mesh/node.c
index 394f5bfa9..e99858623 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -51,7 +51,6 @@
 /* Default values for a new locally created node */
 #define DEFAULT_NEW_UNICAST 0x0001
 #define DEFAULT_IV_INDEX 0x0000
-#define DEFAULT_PRIMARY_NET_INDEX 0x0000
 
 /* Default element location: unknown */
 #define DEFAULT_LOCATION 0x0000
@@ -1564,21 +1563,20 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 		/* Generate device and primary network keys */
 		l_getrandom(dev_key, sizeof(dev_key));
 		l_getrandom(net_key.old_key, sizeof(net_key.old_key));
-		net_key.net_idx = DEFAULT_PRIMARY_NET_INDEX;
-		net_key.phase = 0;
+		net_key.net_idx = PRIMARY_NET_IDX;
+		net_key.phase = KEY_REFRESH_PHASE_NONE;
 
 		if (!add_local_node(node, DEFAULT_NEW_UNICAST, false, false,
 						DEFAULT_IV_INDEX, dev_key,
-						DEFAULT_PRIMARY_NET_INDEX,
-							net_key.old_key))
+						PRIMARY_NET_IDX,
+						net_key.old_key))
 			goto fail;
 
 		if (!keyring_put_remote_dev_key(node, DEFAULT_NEW_UNICAST,
 							num_ele, dev_key))
 			goto fail;
 
-		if (!keyring_put_net_key(node, DEFAULT_PRIMARY_NET_INDEX,
-								&net_key))
+		if (!keyring_put_net_key(node, PRIMARY_NET_IDX, &net_key))
 			goto fail;
 
 		cb(req->user_data, MESH_ERROR_NONE, node);
-- 
2.14.5

