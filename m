Return-Path: <SRS0=dLRT=VL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F35C73C66
	for <linux-bluetooth@archiver.kernel.org>; Sun, 14 Jul 2019 06:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C415320820
	for <linux-bluetooth@archiver.kernel.org>; Sun, 14 Jul 2019 06:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfGNG2R (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 14 Jul 2019 02:28:17 -0400
Received: from mga06.intel.com ([134.134.136.31]:30353 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbfGNG2R (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 14 Jul 2019 02:28:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jul 2019 23:28:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,489,1557212400"; 
   d="scan'208";a="318387979"
Received: from ingas-nuc1.sea.intel.com ([10.251.146.93])
  by orsmga004.jf.intel.com with ESMTP; 13 Jul 2019 23:28:16 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, michal.lowas-rzechonek@silvair.com,
        jakub.witowski@silvair.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 02/10 v2] mesh: Rename mesh-db.c to mesh-config-json.c
Date:   Sat, 13 Jul 2019 23:28:04 -0700
Message-Id: <20190714062812.31041-3-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190714062812.31041-1-inga.stotland@intel.com>
References: <20190714062812.31041-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This moves mesh-db.h to mesh-config.h and mesh-db.c to mesh-config-json.c.
mesh-config.h declares common APIs for storing mesh node configuration.
mesh-config-json.c defines the APIs for JSOn specific storage.
This allows for future parallel implementation a different (not JSON-based)
mechanism of storing node configuration.
---
 Makefile.mesh                          | 2 +-
 mesh/cfgmod-server.c                   | 3 +--
 mesh/{mesh-db.c => mesh-config-json.c} | 3 +--
 mesh/{mesh-db.h => mesh-config.h}      | 0
 mesh/model.c                           | 2 +-
 mesh/node.c                            | 2 +-
 mesh/storage.c                         | 3 +--
 7 files changed, 6 insertions(+), 9 deletions(-)
 rename mesh/{mesh-db.c => mesh-config-json.c} (99%)
 rename mesh/{mesh-db.h => mesh-config.h} (100%)

diff --git a/Makefile.mesh b/Makefile.mesh
index 1ace507af..502ba2a47 100644
--- a/Makefile.mesh
+++ b/Makefile.mesh
@@ -25,7 +25,7 @@ mesh_sources = mesh/mesh.h mesh/mesh.c \
 				mesh/provision.h mesh/prov.h \
 				mesh/model.h mesh/model.c \
 				mesh/cfgmod.h mesh/cfgmod-server.c \
-				mesh/mesh-db.h mesh/mesh-db.c \
+				mesh/mesh-config.h mesh/mesh-config-json.c \
 				mesh/util.h mesh/util.c \
 				mesh/dbus.h mesh/dbus.c \
 				mesh/agent.h mesh/agent.c \
diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index a19ddc72e..486c87307 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -32,8 +32,7 @@
 #include "mesh/appkey.h"
 #include "mesh/model.h"
 #include "mesh/storage.h"
-#include "mesh/mesh-db.h"
-
+#include "mesh/mesh-config.h"
 #include "mesh/cfgmod.h"
 
 #define CFG_MAX_MSG_LEN 380
diff --git a/mesh/mesh-db.c b/mesh/mesh-config-json.c
similarity index 99%
rename from mesh/mesh-db.c
rename to mesh/mesh-config-json.c
index e0a000261..35d0bd27e 100644
--- a/mesh/mesh-db.c
+++ b/mesh/mesh-config-json.c
@@ -31,8 +31,7 @@
 
 #include "mesh/mesh-defs.h"
 #include "mesh/util.h"
-
-#include "mesh/mesh-db.h"
+#include "mesh/mesh-config.h"
 
 #define CHECK_KEY_IDX_RANGE(x) (((x) >= 0) && ((x) <= 4095))
 
diff --git a/mesh/mesh-db.h b/mesh/mesh-config.h
similarity index 100%
rename from mesh/mesh-db.h
rename to mesh/mesh-config.h
diff --git a/mesh/model.c b/mesh/model.c
index e08f95b71..0474762e0 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -30,7 +30,7 @@
 #include "mesh/mesh.h"
 #include "mesh/crypto.h"
 #include "mesh/node.h"
-#include "mesh/mesh-db.h"
+#include "mesh/mesh-config.h"
 #include "mesh/net.h"
 #include "mesh/appkey.h"
 #include "mesh/cfgmod.h"
diff --git a/mesh/node.c b/mesh/node.c
index a2d95dacf..06e809706 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -31,7 +31,7 @@
 #include "mesh/mesh-defs.h"
 #include "mesh/mesh.h"
 #include "mesh/net.h"
-#include "mesh/mesh-db.h"
+#include "mesh/mesh-config.h"
 #include "mesh/provision.h"
 #include "mesh/storage.h"
 #include "mesh/keyring.h"
diff --git a/mesh/storage.c b/mesh/storage.c
index 2b7804242..bba2ef348 100644
--- a/mesh/storage.c
+++ b/mesh/storage.c
@@ -22,7 +22,6 @@
 #endif
 
 #define _GNU_SOURCE
-//#include <errno.h>
 #include <fcntl.h>
 #include <stdio.h>
 #include <unistd.h>
@@ -37,7 +36,7 @@
 #include "mesh/node.h"
 #include "mesh/net.h"
 #include "mesh/appkey.h"
-#include "mesh/mesh-db.h"
+#include "mesh/mesh-config.h"
 #include "mesh/util.h"
 #include "mesh/storage.h"
 
-- 
2.21.0

