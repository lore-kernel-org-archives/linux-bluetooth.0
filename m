Return-Path: <SRS0=cy5f=Q3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B00C43381
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Feb 2019 23:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 978D32089F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Feb 2019 23:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbfBTXYk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Feb 2019 18:24:40 -0500
Received: from mga04.intel.com ([192.55.52.120]:47593 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbfBTXYj (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Feb 2019 18:24:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2019 15:24:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,392,1544515200"; 
   d="scan'208";a="135084750"
Received: from bgix-dell-lap.sea.intel.com ([10.252.203.221])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Feb 2019 15:24:39 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, Brian Gix <brian.gix@intel.com>
Subject: [PATCH BlueZ] mesh: Fix for file naming convention
Date:   Wed, 20 Feb 2019 15:24:35 -0800
Message-Id: <20190220232435.20272-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 Makefile.mesh                   | 2 +-
 mesh/friend.c                   | 2 +-
 mesh/{net_keys.c => net-keys.c} | 2 +-
 mesh/{net_keys.h => net-keys.h} | 0
 mesh/net.c                      | 2 +-
 mesh/pb-adv.c                   | 2 +-
 mesh/prov-acceptor.c            | 2 +-
 mesh/prov-initiator.c           | 2 +-
 8 files changed, 7 insertions(+), 7 deletions(-)
 rename mesh/{net_keys.c => net-keys.c} (99%)
 rename mesh/{net_keys.h => net-keys.h} (100%)

diff --git a/Makefile.mesh b/Makefile.mesh
index 28c87a061..76e424b92 100644
--- a/Makefile.mesh
+++ b/Makefile.mesh
@@ -5,7 +5,7 @@ dbus_DATA += mesh/bluetooth-mesh.conf
 endif
 
 mesh_sources = mesh/mesh.h mesh/mesh.c \
-				mesh/net_keys.h mesh/net_keys.c \
+				mesh/net-keys.h mesh/net-keys.c \
 				mesh/mesh-io.h mesh/mesh-io.c \
 				mesh/error.h mesh/mesh-io-api.h \
 				mesh/mesh-io-generic.h \
diff --git a/mesh/friend.c b/mesh/friend.c
index d17fde084..1722a2e71 100644
--- a/mesh/friend.c
+++ b/mesh/friend.c
@@ -29,7 +29,7 @@
 #include "mesh/mesh-defs.h"
 
 #include "mesh/mesh.h"
-#include "mesh/net_keys.h"
+#include "mesh/net-keys.h"
 #include "mesh/node.h"
 #include "mesh/net.h"
 #include "mesh/crypto.h"
diff --git a/mesh/net_keys.c b/mesh/net-keys.c
similarity index 99%
rename from mesh/net_keys.c
rename to mesh/net-keys.c
index 6f7b7c18a..84e3982f5 100644
--- a/mesh/net_keys.c
+++ b/mesh/net-keys.c
@@ -25,7 +25,7 @@
 #include <ell/ell.h>
 
 #include "mesh/crypto.h"
-#include "mesh/net_keys.h"
+#include "mesh/net-keys.h"
 
 #define BEACON_TYPE_SNB		0x01
 #define KEY_REFRESH		0x01
diff --git a/mesh/net_keys.h b/mesh/net-keys.h
similarity index 100%
rename from mesh/net_keys.h
rename to mesh/net-keys.h
diff --git a/mesh/net.c b/mesh/net.c
index 53010d57f..2adae70c3 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -32,7 +32,7 @@
 #include "mesh/util.h"
 
 #include "mesh/crypto.h"
-#include "mesh/net_keys.h"
+#include "mesh/net-keys.h"
 #include "mesh/mesh.h"
 #include "mesh/node.h"
 #include "mesh/net.h"
diff --git a/mesh/pb-adv.c b/mesh/pb-adv.c
index 57647e184..a6104ca89 100644
--- a/mesh/pb-adv.c
+++ b/mesh/pb-adv.c
@@ -39,7 +39,7 @@
 #include "src/shared/ecc.h"
 
 #include "mesh/util.h"
-#include "mesh/net_keys.h"
+#include "mesh/net-keys.h"
 #include "mesh/crypto.h"
 #include "mesh/net.h"
 #include "mesh/mesh-io.h"
diff --git a/mesh/prov-acceptor.c b/mesh/prov-acceptor.c
index 3d4d93ba4..a8bc2c9cf 100644
--- a/mesh/prov-acceptor.c
+++ b/mesh/prov-acceptor.c
@@ -39,7 +39,7 @@
 #include "src/shared/ecc.h"
 
 #include "mesh/util.h"
-#include "mesh/net_keys.h"
+#include "mesh/net-keys.h"
 #include "mesh/crypto.h"
 #include "mesh/net.h"
 #include "mesh/error.h"
diff --git a/mesh/prov-initiator.c b/mesh/prov-initiator.c
index d915f2aaf..df8884a81 100644
--- a/mesh/prov-initiator.c
+++ b/mesh/prov-initiator.c
@@ -39,7 +39,7 @@
 #include "src/shared/ecc.h"
 
 #include "mesh/util.h"
-#include "mesh/net_keys.h"
+#include "mesh/net-keys.h"
 #include "mesh/crypto.h"
 #include "mesh/net.h"
 #include "mesh/error.h"
-- 
2.14.5

