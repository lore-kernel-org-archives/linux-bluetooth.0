Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7CDC4332F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Feb 2022 02:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiBXCHL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Feb 2022 21:07:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiBXCHJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Feb 2022 21:07:09 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5ED2D1D0
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Feb 2022 18:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645668399; x=1677204399;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T/rOJuz5kQrr8KBYkTbp4Bw9COOu/9MaaW/oVxhBb64=;
  b=VdTIvPpugBRP6eYTgHYAWzbVeYaf8ozU3gQdreg0ESVpqzt2KfAdTLVW
   aXrUiRiM5sxU35gNrap5NsF/ozvncK8Ga+BMPSXui90sTAFGVPo1bpr5p
   zuCL9ljUjw26T10vd3rqOwvNxN+qBfXIZXaj0NnpKhZasFA3TmqIQlVDz
   zklXfB26BRVRSBT43Y47qk+3C+MeDZn2465uEQ8yImmJToVC6Pa0YwMlp
   /MfYfzkpBXELL8ZctbKXUD565UG2kJRDbzXV9UHWH/oYWpE2B3T3E5+oP
   O8ZGgQTGnarapLZX1PGdL1zA17EMqSjZRlmaCRElh5KvjPiumpgWnz5iD
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="239525005"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="239525005"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 18:06:34 -0800
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="607268578"
Received: from tjsmith-mobl1.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.209.34.213])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 18:06:34 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com
Subject: [PATCH 6/7] mesh: Add new MGMT based IO transport
Date:   Wed, 23 Feb 2022 18:06:23 -0800
Message-Id: <20220224020624.159247-7-brian.gix@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220224020624.159247-1-brian.gix@intel.com>
References: <20220224020624.159247-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Adds required new modules to support kernel based MGMT tx/rx
---
 Makefile.mesh          |  9 ++++-----
 mesh/mesh-io-generic.h |  1 -
 mesh/mesh-io-mgmt.c    |  2 +-
 mesh/mesh-io-mgmt.h    | 11 +++++++++++
 mesh/mesh-io-unit.c    |  2 +-
 mesh/mesh-io.c         |  1 +
 6 files changed, 18 insertions(+), 8 deletions(-)
 create mode 100644 mesh/mesh-io-mgmt.h

diff --git a/Makefile.mesh b/Makefile.mesh
index fc28b0557..3047f362b 100644
--- a/Makefile.mesh
+++ b/Makefile.mesh
@@ -13,12 +13,11 @@ endif
 mesh_sources = mesh/mesh.h mesh/mesh.c \
 				mesh/net-keys.h mesh/net-keys.c \
 				mesh/mesh-io.h mesh/mesh-io.c \
-				mesh/mesh-mgmt.c mesh/mesh-mgmt.h \
+				mesh/mesh-mgmt.h  mesh/mesh-mgmt.c \
 				mesh/error.h mesh/mesh-io-api.h \
-				mesh/mesh-io-generic.h \
-				mesh/mesh-io-generic.c \
-				mesh/mesh-io-unit.h \
-				mesh/mesh-io-unit.c \
+				mesh/mesh-io-unit.h mesh/mesh-io-unit.c \
+				mesh/mesh-io-mgmt.h mesh/mesh-io-mgmt.c \
+				mesh/mesh-io-generic.h mesh/mesh-io-generic.c \
 				mesh/net.h mesh/net.c \
 				mesh/crypto.h mesh/crypto.c \
 				mesh/friend.h mesh/friend.c \
diff --git a/mesh/mesh-io-generic.h b/mesh/mesh-io-generic.h
index 546e15d62..915e376bf 100644
--- a/mesh/mesh-io-generic.h
+++ b/mesh/mesh-io-generic.h
@@ -9,4 +9,3 @@
  */
 
 extern const struct mesh_io_api mesh_io_generic;
-extern const struct mesh_io_api mesh_io_mgmt;
diff --git a/mesh/mesh-io-mgmt.c b/mesh/mesh-io-mgmt.c
index 092e81e79..cf18966fb 100644
--- a/mesh/mesh-io-mgmt.c
+++ b/mesh/mesh-io-mgmt.c
@@ -29,7 +29,7 @@
 #include "mesh/mesh-mgmt.h"
 #include "mesh/mesh-io.h"
 #include "mesh/mesh-io-api.h"
-#include "mesh/mesh-io-generic.h"
+#include "mesh/mesh-io-mgmt.h"
 
 struct mesh_io_private {
 	struct mesh_io *io;
diff --git a/mesh/mesh-io-mgmt.h b/mesh/mesh-io-mgmt.h
new file mode 100644
index 000000000..455691c8f
--- /dev/null
+++ b/mesh/mesh-io-mgmt.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2018  Intel Corporation. All rights reserved.
+ *
+ *
+ */
+
+extern const struct mesh_io_api mesh_io_mgmt;
diff --git a/mesh/mesh-io-unit.c b/mesh/mesh-io-unit.c
index 81d9de837..f818140b4 100644
--- a/mesh/mesh-io-unit.c
+++ b/mesh/mesh-io-unit.c
@@ -25,7 +25,7 @@
 #include "mesh/dbus.h"
 #include "mesh/mesh-io.h"
 #include "mesh/mesh-io-api.h"
-#include "mesh/mesh-io-generic.h"
+#include "mesh/mesh-io-unit.h"
 
 struct mesh_io_private {
 	struct mesh_io *io;
diff --git a/mesh/mesh-io.c b/mesh/mesh-io.c
index 95ee9a7f2..8bae7ff7f 100644
--- a/mesh/mesh-io.c
+++ b/mesh/mesh-io.c
@@ -24,6 +24,7 @@
 #include "mesh/mesh-io-api.h"
 
 /* List of Mesh-IO Type headers */
+#include "mesh/mesh-io-mgmt.h"
 #include "mesh/mesh-io-generic.h"
 #include "mesh/mesh-io-unit.h"
 
-- 
2.35.1

