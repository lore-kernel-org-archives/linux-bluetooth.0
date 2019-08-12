Return-Path: <SRS0=fB+o=WI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF299C433FF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Aug 2019 06:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E3C12085A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Aug 2019 06:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfHLG0B (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 12 Aug 2019 02:26:01 -0400
Received: from mga05.intel.com ([192.55.52.43]:34963 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726466AbfHLG0A (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 12 Aug 2019 02:26:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Aug 2019 23:26:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,376,1559545200"; 
   d="scan'208";a="375129751"
Received: from ingas-nuc1.sea.intel.com ([10.252.204.28])
  by fmsmga005.fm.intel.com with ESMTP; 11 Aug 2019 23:25:59 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v2] mesh: Move commonly used constants into mesh-defs.h
Date:   Sun, 11 Aug 2019 23:25:58 -0700
Message-Id: <20190812062558.17419-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This consolidates definitions of commonly used constant values
into a single header file. The constant values are based on mesh
specification, plus a few internal utility constants (masks, etc.)

Also, removes redundant redefinition maximum message length.
---
 mesh/crypto.c    |  9 ++++-----
 mesh/mesh-defs.h | 34 +++++++++++++++++++++++++++++++---
 mesh/model.h     | 21 ---------------------
 mesh/net.h       |  8 --------
 mesh/node.c      | 10 ++++------
 5 files changed, 39 insertions(+), 43 deletions(-)

diff --git a/mesh/crypto.c b/mesh/crypto.c
index b1b1fa9a8..a6dc7ffe2 100644
--- a/mesh/crypto.c
+++ b/mesh/crypto.c
@@ -28,6 +28,10 @@
 
 #include <linux/if_alg.h>
 
+#include "mesh/mesh-defs.h"
+#include "mesh/net.h"
+#include "mesh/crypto.h"
+
 #ifndef SOL_ALG
 #define SOL_ALG		279
 #endif
@@ -36,11 +40,6 @@
 #define ALG_SET_AEAD_AUTHSIZE	5
 #endif
 
-#include "mesh/mesh.h"
-#include "mesh/node.h"
-#include "mesh/net.h"
-#include "mesh/crypto.h"
-
 /* Multiply used Zero array */
 static const uint8_t zero[16] = { 0, };
 
diff --git a/mesh/mesh-defs.h b/mesh/mesh-defs.h
index d14aa5af3..1219e4939 100644
--- a/mesh/mesh-defs.h
+++ b/mesh/mesh-defs.h
@@ -37,6 +37,7 @@
 #define KEY_REFRESH_PHASE_THREE	0x03
 
 #define DEFAULT_TTL		0xff
+#define TTL_MASK		0x7f
 
 /* Supported algorithms for provisioning */
 #define ALG_FIPS_256_ECC	0x0001
@@ -54,6 +55,26 @@
 #define OOB_OUT_NUMBER	0x0008
 #define OOB_OUT_ALPHA	0x0010
 
+/* Status codes */
+#define MESH_STATUS_SUCCESS		0x00
+#define MESH_STATUS_INVALID_ADDRESS	0x01
+#define MESH_STATUS_INVALID_MODEL	0x02
+#define MESH_STATUS_INVALID_APPKEY	0x03
+#define MESH_STATUS_INVALID_NETKEY	0x04
+#define MESH_STATUS_INSUFF_RESOURCES	0x05
+#define MESH_STATUS_IDX_ALREADY_STORED	0x06
+#define MESH_STATUS_INVALID_PUB_PARAM	0x07
+#define MESH_STATUS_NOT_SUB_MOD		0x08
+#define MESH_STATUS_STORAGE_FAIL	0x09
+#define MESH_STATUS_FEATURE_NO_SUPPORT	0x0a
+#define MESH_STATUS_CANNOT_UPDATE	0x0b
+#define MESH_STATUS_CANNOT_REMOVE	0x0c
+#define MESH_STATUS_CANNOT_BIND		0x0d
+#define MESH_STATUS_UNABLE_CHANGE_STATE	0x0e
+#define MESH_STATUS_CANNOT_SET		0x0f
+#define MESH_STATUS_UNSPECIFIED_ERROR	0x10
+#define MESH_STATUS_INVALID_BINDING	0x11
+
 #define UNASSIGNED_ADDRESS	0x0000
 #define PROXIES_ADDRESS	0xfffc
 #define FRIENDS_ADDRESS	0xfffd
@@ -72,14 +93,21 @@
 
 #define PRIMARY_ELE_IDX		0x00
 
-#define VENDOR_ID_MASK		0xffff0000
-
 #define PRIMARY_NET_IDX		0x0000
 #define MAX_KEY_IDX		0x0fff
 #define MAX_MODEL_COUNT		0xff
 #define MAX_ELE_COUNT		0xff
 
-#define MAX_MSG_LEN 380
+#define MAX_MSG_LEN		380
+
+#define VENDOR_ID_MASK		0xffff0000
+
+#define NET_IDX_INVALID	0xffff
+#define NET_NID_INVALID	0xff
+
+#define APP_IDX_MASK		0x0fff
+#define APP_IDX_DEV_REMOTE	0x6fff
+#define APP_IDX_DEV_LOCAL	0x7fff
 
 #define IS_UNASSIGNED(x)	((x) == UNASSIGNED_ADDRESS)
 #define IS_UNICAST(x)		(((x) > UNASSIGNED_ADDRESS) && \
diff --git a/mesh/model.h b/mesh/model.h
index fa031f598..f30ca2e38 100644
--- a/mesh/model.h
+++ b/mesh/model.h
@@ -26,27 +26,6 @@ struct mesh_model;
 
 #define VIRTUAL_BASE			0x10000
 
-#define MESH_MAX_ACCESS_PAYLOAD		380
-
-#define MESH_STATUS_SUCCESS		0x00
-#define MESH_STATUS_INVALID_ADDRESS	0x01
-#define MESH_STATUS_INVALID_MODEL	0x02
-#define MESH_STATUS_INVALID_APPKEY	0x03
-#define MESH_STATUS_INVALID_NETKEY	0x04
-#define MESH_STATUS_INSUFF_RESOURCES	0x05
-#define MESH_STATUS_IDX_ALREADY_STORED	0x06
-#define MESH_STATUS_INVALID_PUB_PARAM	0x07
-#define MESH_STATUS_NOT_SUB_MOD		0x08
-#define MESH_STATUS_STORAGE_FAIL	0x09
-#define MESH_STATUS_FEATURE_NO_SUPPORT	0x0a
-#define MESH_STATUS_CANNOT_UPDATE	0x0b
-#define MESH_STATUS_CANNOT_REMOVE	0x0c
-#define MESH_STATUS_CANNOT_BIND		0x0d
-#define MESH_STATUS_UNABLE_CHANGE_STATE	0x0e
-#define MESH_STATUS_CANNOT_SET		0x0f
-#define MESH_STATUS_UNSPECIFIED_ERROR	0x10
-#define MESH_STATUS_INVALID_BINDING	0x11
-
 #define OP_MODEL_TEST			0x8000fffe
 #define OP_MODEL_INVALID		0x8000ffff
 
diff --git a/mesh/net.h b/mesh/net.h
index b7aa37748..55e89ca72 100644
--- a/mesh/net.h
+++ b/mesh/net.h
@@ -31,18 +31,10 @@ struct mesh_node;
 #define APP_AID_DEV	0x00
 
 #define CTL		0x80
-#define TTL_MASK	0x7f
 #define SEQ_MASK	0xffffff
 
 #define CREDFLAG_MASK	0x1000
 
-#define APP_IDX_MASK		0x0fff
-#define APP_IDX_DEV_REMOTE	0x6fff
-#define APP_IDX_DEV_LOCAL	0x7fff
-
-#define NET_IDX_INVALID	0xffff
-#define NET_NID_INVALID	0xff
-
 #define KEY_CACHE_SIZE	64
 #define FRND_CACHE_MAX	32
 
diff --git a/mesh/node.c b/mesh/node.c
index e7e58d9a7..e0903efb0 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -84,7 +84,6 @@ struct mesh_node {
 	char *owner;
 	char *obj_path;
 	struct mesh_agent *agent;
-	char *path;
 	struct mesh_config *cfg;
 	char *storage_dir;
 	uint32_t disc_watch;
@@ -110,7 +109,6 @@ struct mesh_node {
 
 struct node_import {
 	uint8_t dev_key[16];
-
 	uint8_t net_key[16];
 	uint16_t net_idx;
 	struct {
@@ -1955,7 +1953,7 @@ static struct l_dbus_message *send_call(struct l_dbus *dbus,
 	src = node_get_primary(node) + ele->idx;
 
 	if (!l_dbus_message_iter_get_fixed_array(&iter_data, &data, &len) ||
-					!len || len > MESH_MAX_ACCESS_PAYLOAD)
+					!len || len > MAX_MSG_LEN)
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
 							"Incorrect data");
 
@@ -2001,7 +1999,7 @@ static struct l_dbus_message *dev_key_send_call(struct l_dbus *dbus,
 	src = node_get_primary(node) + ele->idx;
 
 	if (!l_dbus_message_iter_get_fixed_array(&iter_data, &data, &len) ||
-					!len || len > MESH_MAX_ACCESS_PAYLOAD)
+					!len || len > MAX_MSG_LEN)
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
 							"Incorrect data");
 
@@ -2045,7 +2043,7 @@ static struct l_dbus_message *publish_call(struct l_dbus *dbus,
 	src = node_get_primary(node) + ele->idx;
 
 	if (!l_dbus_message_iter_get_fixed_array(&iter_data, &data, &len) ||
-					!len || len > MESH_MAX_ACCESS_PAYLOAD)
+					!len || len > MAX_MSG_LEN)
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
 							"Incorrect data");
 
@@ -2092,7 +2090,7 @@ static struct l_dbus_message *vendor_publish_call(struct l_dbus *dbus,
 	src = node_get_primary(node) + ele->idx;
 
 	if (!l_dbus_message_iter_get_fixed_array(&iter_data, &data, &len) ||
-					!len || len > MESH_MAX_ACCESS_PAYLOAD)
+					!len || len > MAX_MSG_LEN)
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
 							"Incorrect data");
 
-- 
2.21.0

