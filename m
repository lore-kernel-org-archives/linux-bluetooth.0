Return-Path: <SRS0=sCKx=VH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB876C73C6D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jul 2019 05:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B80A220844
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jul 2019 05:10:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfGJFKE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Jul 2019 01:10:04 -0400
Received: from mga18.intel.com ([134.134.136.126]:28140 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbfGJFKD (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Jul 2019 01:10:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jul 2019 22:10:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,473,1557212400"; 
   d="scan'208";a="189050296"
Received: from ingas-nuc1.sea.intel.com ([10.254.182.100])
  by fmsmga004.fm.intel.com with ESMTP; 09 Jul 2019 22:10:03 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, michal.lowas-rzechonek@silvair.com,
        jakub.witowski@silvair.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 2/9] mesh: Rename mesh-db.c to mesh-config-json.c
Date:   Tue,  9 Jul 2019 22:09:52 -0700
Message-Id: <20190710050959.7321-3-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190710050959.7321-1-inga.stotland@intel.com>
References: <20190710050959.7321-1-inga.stotland@intel.com>
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

