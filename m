Return-Path: <SRS0=1Za/=OY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46ED2C43613
	for <linux-bluetooth@archiver.kernel.org>; Sat, 15 Dec 2018 00:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 840E3208C1
	for <linux-bluetooth@archiver.kernel.org>; Sat, 15 Dec 2018 00:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730054AbeLOABs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Dec 2018 19:01:48 -0500
Received: from mga17.intel.com ([192.55.52.151]:20315 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730091AbeLOABo (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Dec 2018 19:01:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Dec 2018 16:01:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,354,1539673200"; 
   d="scan'208";a="98882893"
Received: from bgix-dell-lap.sea.intel.com ([10.251.138.67])
  by orsmga007.jf.intel.com with ESMTP; 14 Dec 2018 16:01:42 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     johan.hedberg@gmail.com, inga.stotland@intel.com,
        marcel@holtmann.org, brian.gix@intel.com
Subject: [PATCH BlueZ v2 26/30] mesh: Add structural changes to for mesh
Date:   Fri, 14 Dec 2018 16:01:24 -0800
Message-Id: <20181215000128.928-27-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181215000128.928-1-brian.gix@intel.com>
References: <20181215000128.928-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Inga Stotland <inga.stotland@intel.com>

---
 Makefile.mesh | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/Makefile.mesh b/Makefile.mesh
index a9c387e08..65310860f 100644
--- a/Makefile.mesh
+++ b/Makefile.mesh
@@ -3,35 +3,42 @@ if MESH
 mesh_sources = mesh/mesh.h mesh/mesh.c \
 				mesh/net_keys.h mesh/net_keys.c \
 				mesh/mesh-io.h mesh/mesh-io.c \
-				mesh/mesh-io-api.h \
+				mesh/error.h mesh/mesh-io-api.h \
 				mesh/mesh-io-generic.h \
 				mesh/mesh-io-generic.c \
 				mesh/storage.h mesh/storage.c \
 				mesh/net.h mesh/net.c \
-				mesh/display.h mesh/display.c \
 				mesh/crypto.h mesh/crypto.c \
 				mesh/friend.h mesh/friend.c \
 				mesh/appkey.h mesh/appkey.c \
 				mesh/node.h mesh/node.c \
-				mesh/prov.h mesh/prov.c \
-				mesh/provision.h mesh/provision.c \
+				mesh/provision.h mesh/prov.h \
 				mesh/model.h mesh/model.c \
 				mesh/cfgmod.h mesh/cfgmod-server.c \
 				mesh/mesh-db.h mesh/mesh-db.c \
 				mesh/util.h mesh/util.c \
-				mesh/mesh-defs.h
+				mesh/dbus.h mesh/dbus.c \
+				mesh/agent.h mesh/agent.c \
+				mesh/prov-acceptor.c mesh/prov-initiator.c \
+				mesh/pb-adv.c mesh/mesh-defs.h
 libexec_PROGRAMS += mesh/meshd
 
 mesh_meshd_SOURCES = $(mesh_sources) mesh/main.c
 mesh_meshd_LDADD = src/libshared-ell.la $(ell_ldadd) -ljson-c
 mesh_meshd_DEPENDENCIES = $(ell_dependencies)
 
-noinst_PROGRAMS += mesh/btmesh
-
-mesh_btmesh_SOURCES = $(mesh_sources) mesh/agent.h \
-						mesh/agent.c \
-						mesh/btmesh.c
 mesh_btmesh_LDADD = src/libshared-mainloop.la $(ell_ldadd) -lreadline -ljson-c
 mesh_btmesh_DEPENDENCIES = $(ell_dependencies)
 
+#
+# noinst_PROGRAMS += mesh/btmesh
+#
+# mesh_btmesh_SOURCES = $(mesh_sources) \
+#						mesh/btmesh.c
+#
+#mesh_btmesh_LDADD = src/shared/ecc.lo src/shared/queue.lo src/shared/io-ell.lo \
+#				src/shared/util.lo src/shared/hci.lo src/shared/mgmt.lo \
+#				src/libshared-mainloop.la \
+#				-lreadline @ELL_LIBS@ -ljson-c
+
 endif
-- 
2.14.5

