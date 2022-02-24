Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C679BC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Feb 2022 02:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbiBXCHI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Feb 2022 21:07:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiBXCHH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Feb 2022 21:07:07 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E1DB853
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Feb 2022 18:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645668397; x=1677204397;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=81ea5c0d54wLGPgGbtraKs9AyWMBNQkSxgLGbaTQ3bQ=;
  b=OL4hSSq9wDzpyX9v5xNwW2XeVsp0iRIh+Mnx+WWWES+MZt0O6s9n/Qdg
   znpWlSSNqE5hEFHaYHgZtWsLRSwZqZ7hKovjfeEw9kDP+9Q+XgNNXMqVV
   +Db2r7Jr6TVo6XXQBM+cusrgH/s47NoujM8efwrf1tagSNGXtJOnHj7gW
   PaCuuI1fSIuz6et3RfdCUdmXGyXhSj7n0oGKy9LUmaw2tpByQz9jQA7Vg
   XEtZxw+xwRftnjILX+J49oWPiXx324alB+NRIMJfMpr4Sg+JqlMUZPwi4
   R0n6A5GXDRYM1mk2d7i/ytGhTmKT/md7x49Hw4Z9Qjv2Up6DePdmP70Ya
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="239525000"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="239525000"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 18:06:33 -0800
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="607268568"
Received: from tjsmith-mobl1.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.209.34.213])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 18:06:33 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com
Subject: [PATCH 3/7] mesh: Add common MGMT command accessors
Date:   Wed, 23 Feb 2022 18:06:20 -0800
Message-Id: <20220224020624.159247-4-brian.gix@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220224020624.159247-1-brian.gix@intel.com>
References: <20220224020624.159247-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

While mesh-io-mgmt is the main consumer of MGMT services, we also use
MGMT to identify controllers and their capabilities, when determining
the appropriate Mesh IO carrier. This centralizes all MGMT access to
a single socket, shared accross all consumers.

Also fixes the Controller added/removed handling so that a controller
disappearing or reappearing gets handled rationally.
---
 mesh/mesh-mgmt.c | 149 ++++++++++++++++++++++++++++++++++++-----------
 mesh/mesh-mgmt.h |  12 +++-
 2 files changed, 125 insertions(+), 36 deletions(-)

diff --git a/mesh/mesh-mgmt.c b/mesh/mesh-mgmt.c
index 754093dbc..e878a4f11 100644
--- a/mesh/mesh-mgmt.c
+++ b/mesh/mesh-mgmt.c
@@ -12,35 +12,63 @@
 #include <config.h>
 #endif
 
+#include <ell/ell.h>
+
 #include "lib/bluetooth.h"
 #include "lib/mgmt.h"
 #include "src/shared/mgmt.h"
 
-#include "ell/queue.h"
-#include "ell/log.h"
-#include "ell/util.h"
-
 #include "mesh/mesh-mgmt.h"
 
-struct read_info_reg {
-	mesh_mgmt_read_info_func_t cb;
-	void *user_data;
-};
-
-struct read_info_req {
-	int index;
-	struct mesh_io *io;
+struct mesh_controler {
+	int	index;
+	bool	mesh_support;
+	bool	powered;
 };
 
+static mesh_mgmt_read_info_func_t ctl_info;
 static struct mgmt *mgmt_mesh;
-static struct l_queue *read_info_regs;
+static struct l_queue *ctl_list;
+static void *list_user_data;
+static bool mesh_detected;
+
+static bool by_index(const void *a, const void *b)
+{
+	const struct mesh_controler *ctl = a;
+	int index = L_PTR_TO_UINT(b);
 
-static void process_read_info_req(void *data, void *user_data)
+	return ctl->index == index;
+}
+
+static void index_removed(uint16_t index, uint16_t length, const void *param,
+							void *user_data);
+static void features_cb(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
 {
-	struct read_info_reg *reg = data;
 	int index = L_PTR_TO_UINT(user_data);
+	struct mesh_controler *ctl;
+
 
-	reg->cb(index, reg->user_data);
+	ctl = l_queue_find(ctl_list, by_index, L_UINT_TO_PTR(index));
+	if (!ctl)
+		return;
+
+	l_debug("Status: %d, Length: %d", status, length);
+	if (status != MGMT_STATUS_NOT_SUPPORTED &&
+					status != MGMT_STATUS_UNKNOWN_COMMAND) {
+		ctl->mesh_support = true;
+		if (!mesh_detected) {
+			mgmt_register(mgmt_mesh, MGMT_EV_INDEX_REMOVED,
+					MGMT_INDEX_NONE, index_removed,
+					NULL, NULL);
+		}
+		mesh_detected = true;
+	} else
+		l_debug("Kernel mesh not supported for hci%u", index);
+
+	if (ctl_info)
+		ctl_info(index, true, ctl->powered, ctl->mesh_support,
+							list_user_data);
 }
 
 static void read_info_cb(uint8_t status, uint16_t length,
@@ -49,12 +77,25 @@ static void read_info_cb(uint8_t status, uint16_t length,
 	int index = L_PTR_TO_UINT(user_data);
 	const struct mgmt_rp_read_info *rp = param;
 	uint32_t current_settings, supported_settings;
+	struct mesh_controler *ctl;
 
 	l_debug("hci %u status 0x%02x", index, status);
 
+	ctl = l_queue_find(ctl_list, by_index, L_UINT_TO_PTR(index));
+	if (!ctl)
+		return;
+
 	if (status != MGMT_STATUS_SUCCESS) {
+		ctl = l_queue_remove_if(ctl_list, by_index,
+						L_UINT_TO_PTR(index));
 		l_error("Failed to read info for hci index %u: %s (0x%02x)",
 				index, mgmt_errstr(status), status);
+
+		l_warn("Hci dev %d removal detected", index);
+		if (ctl && ctl_info)
+			ctl_info(index, false, false, false, list_user_data);
+
+		l_free(ctl);
 		return;
 	}
 
@@ -69,23 +110,34 @@ static void read_info_cb(uint8_t status, uint16_t length,
 	l_debug("settings: supp %8.8x curr %8.8x",
 					supported_settings, current_settings);
 
-	if (current_settings & MGMT_SETTING_POWERED) {
-		l_info("Controller hci %u is in use", index);
-		return;
-	}
-
 	if (!(supported_settings & MGMT_SETTING_LE)) {
 		l_info("Controller hci %u does not support LE", index);
+		l_queue_remove(ctl_list, ctl);
+		l_free(ctl);
 		return;
 	}
 
-	l_queue_foreach(read_info_regs, process_read_info_req,
-							L_UINT_TO_PTR(index));
+	if (current_settings & MGMT_SETTING_POWERED)
+		ctl->powered = true;
+
+	mesh_mgmt_send(MGMT_OP_MESH_READ_FEATURES, index, 0, NULL,
+				features_cb, L_UINT_TO_PTR(index), NULL);
 }
 
 static void index_added(uint16_t index, uint16_t length, const void *param,
 							void *user_data)
 {
+	struct mesh_controler *ctl = l_queue_find(ctl_list, by_index,
+							L_UINT_TO_PTR(index));
+
+	if (!ctl) {
+		ctl = l_new(struct mesh_controler, 1);
+		ctl->index = index;
+		l_queue_push_head(ctl_list, ctl);
+	} else {
+		ctl->mesh_support = ctl->powered = false;
+	}
+
 	mgmt_send(mgmt_mesh, MGMT_OP_READ_INFO, index, 0, NULL,
 				read_info_cb, L_UINT_TO_PTR(index), NULL);
 }
@@ -93,7 +145,9 @@ static void index_added(uint16_t index, uint16_t length, const void *param,
 static void index_removed(uint16_t index, uint16_t length, const void *param,
 							void *user_data)
 {
-	l_warn("Hci dev %4.4x removed", index);
+	mgmt_send(mgmt_mesh, MGMT_OP_READ_INFO, index, 0, NULL,
+				read_info_cb, L_UINT_TO_PTR(index), NULL);
+
 }
 
 static void read_index_list_cb(uint8_t status, uint16_t length,
@@ -133,8 +187,8 @@ static void read_index_list_cb(uint8_t status, uint16_t length,
 
 static bool mesh_mgmt_init(void)
 {
-	if (!read_info_regs)
-		read_info_regs = l_queue_new();
+	if (!ctl_list)
+		ctl_list = l_queue_new();
 
 	if (!mgmt_mesh) {
 		mgmt_mesh = mgmt_new_default();
@@ -146,8 +200,6 @@ static bool mesh_mgmt_init(void)
 
 		mgmt_register(mgmt_mesh, MGMT_EV_INDEX_ADDED,
 				MGMT_INDEX_NONE, index_added, NULL, NULL);
-		mgmt_register(mgmt_mesh, MGMT_EV_INDEX_REMOVED,
-				MGMT_INDEX_NONE, index_removed, NULL, NULL);
 	}
 
 	return true;
@@ -155,16 +207,11 @@ static bool mesh_mgmt_init(void)
 
 bool mesh_mgmt_list(mesh_mgmt_read_info_func_t cb, void *user_data)
 {
-	struct read_info_reg *reg;
-
 	if (!mesh_mgmt_init())
 		return false;
 
-	reg = l_new(struct read_info_reg, 1);
-	reg->cb = cb;
-	reg->user_data = user_data;
-
-	l_queue_push_tail(read_info_regs, reg);
+	ctl_info = cb;
+	list_user_data = user_data;
 
 	/* Use MGMT to find a candidate controller */
 	l_debug("send read index_list");
@@ -175,3 +222,35 @@ bool mesh_mgmt_list(mesh_mgmt_read_info_func_t cb, void *user_data)
 
 	return true;
 }
+
+void mesh_mgmt_destroy()
+{
+	mgmt_unref(mgmt_mesh);
+	mgmt_mesh = NULL;
+	ctl_info = NULL;
+	list_user_data = NULL;
+	l_queue_destroy(ctl_list, l_free);
+	ctl_list = NULL;
+}
+
+unsigned int mesh_mgmt_send(uint16_t opcode, uint16_t index,
+				uint16_t length, const void *param,
+				mgmt_request_func_t callback,
+				void *user_data, mgmt_destroy_func_t destroy)
+{
+	return mgmt_send_timeout(mgmt_mesh, opcode, index, length, param,
+					callback, user_data, destroy, 0);
+}
+
+unsigned int mesh_mgmt_register(uint16_t event, uint16_t index,
+				mgmt_notify_func_t callback,
+				void *user_data, mgmt_destroy_func_t destroy)
+{
+	return mgmt_register(mgmt_mesh, event, index, callback,
+						user_data, destroy);
+}
+
+bool mesh_mgmt_unregister(unsigned int id)
+{
+	return mgmt_unregister(mgmt_mesh, id);
+}
diff --git a/mesh/mesh-mgmt.h b/mesh/mesh-mgmt.h
index 90ac14e73..a3cd72faf 100644
--- a/mesh/mesh-mgmt.h
+++ b/mesh/mesh-mgmt.h
@@ -9,6 +9,16 @@
  */
 #include <stdbool.h>
 
-typedef void (*mesh_mgmt_read_info_func_t)(int index, void *user_data);
+typedef void (*mesh_mgmt_read_info_func_t)(int index, bool added, bool powered,
+						bool mesh, void *user_data);
 
 bool mesh_mgmt_list(mesh_mgmt_read_info_func_t cb, void *user_data);
+unsigned int mesh_mgmt_send(uint16_t opcode, uint16_t index,
+				uint16_t length, const void *param,
+				mgmt_request_func_t callback,
+				void *user_data, mgmt_destroy_func_t destroy);
+unsigned int mesh_mgmt_register(uint16_t event, uint16_t index,
+				mgmt_notify_func_t callback,
+				void *user_data, mgmt_destroy_func_t destroy);
+bool mesh_mgmt_unregister(unsigned int id);
+void mesh_mgmt_destroy(void);
-- 
2.35.1

