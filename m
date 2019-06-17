Return-Path: <SRS0=uXJ1=UQ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C329C31E5B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Jun 2019 21:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 436A120657
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Jun 2019 21:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbfFQVjE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 17 Jun 2019 17:39:04 -0400
Received: from mga14.intel.com ([192.55.52.115]:35437 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726538AbfFQVjE (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 17 Jun 2019 17:39:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jun 2019 14:39:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,386,1557212400"; 
   d="scan'208";a="185881454"
Received: from vkalpanx-mobl.amr.corp.intel.com (HELO ingas-nuc1.sea.intel.com) ([10.251.134.56])
  by fmsmga002.fm.intel.com with ESMTP; 17 Jun 2019 14:39:03 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] mesh: Clean up includes
Date:   Mon, 17 Jun 2019 14:38:47 -0700
Message-Id: <20190617213847.21705-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds #include for json-c/json.h in mesh-db.h and removes this
include from the other files that don't need to reference json-c.
---
 mesh/cfgmod-server.c | 2 --
 mesh/mesh-db.c       | 1 -
 mesh/mesh-db.h       | 2 ++
 mesh/model.c         | 2 --
 mesh/node.c          | 1 -
 mesh/storage.c       | 1 -
 6 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index 060d7f4e4..2f61d841c 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -24,8 +24,6 @@
 #include <sys/time.h>
 #include <ell/ell.h>
 
-#include "json-c/json.h"
-
 #include "mesh/mesh-defs.h"
 #include "mesh/node.h"
 #include "mesh/net.h"
diff --git a/mesh/mesh-db.c b/mesh/mesh-db.c
index e0a000261..f3807070f 100644
--- a/mesh/mesh-db.c
+++ b/mesh/mesh-db.c
@@ -27,7 +27,6 @@
 #include <string.h>
 
 #include <ell/ell.h>
-#include <json-c/json.h>
 
 #include "mesh/mesh-defs.h"
 #include "mesh/util.h"
diff --git a/mesh/mesh-db.h b/mesh/mesh-db.h
index da5efa12a..8fb0eb291 100644
--- a/mesh/mesh-db.h
+++ b/mesh/mesh-db.h
@@ -17,6 +17,8 @@
  *
  */
 
+#include <json-c/json.h>
+
 struct mesh_db_sub {
 	bool virt;
 	union {
diff --git a/mesh/model.c b/mesh/model.c
index f29ad9af2..4b5605af6 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -23,10 +23,8 @@
 
 #include <sys/time.h>
 #include <ell/ell.h>
-#include <json-c/json.h>
 
 #include "mesh/mesh-defs.h"
-
 #include "mesh/mesh.h"
 #include "mesh/crypto.h"
 #include "mesh/node.h"
diff --git a/mesh/node.c b/mesh/node.c
index e99858623..c8d0fac2e 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -26,7 +26,6 @@
 #include <sys/time.h>
 
 #include <ell/ell.h>
-#include <json-c/json.h>
 
 #include "mesh/mesh-defs.h"
 #include "mesh/mesh.h"
diff --git a/mesh/storage.c b/mesh/storage.c
index 1a9945aa8..6cb280c39 100644
--- a/mesh/storage.c
+++ b/mesh/storage.c
@@ -30,7 +30,6 @@
 #include <libgen.h>
 #include <ftw.h>
 
-#include <json-c/json.h>
 #include <ell/ell.h>
 
 #include "mesh/mesh-defs.h"
-- 
2.21.0

