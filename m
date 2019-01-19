Return-Path: <SRS0=MOIW=P3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC677C0031C
	for <linux-bluetooth@archiver.kernel.org>; Sat, 19 Jan 2019 03:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8651E2084F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 19 Jan 2019 03:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbfASD6z (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Jan 2019 22:58:55 -0500
Received: from mga01.intel.com ([192.55.52.88]:20216 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727414AbfASD6z (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Jan 2019 22:58:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jan 2019 19:58:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,493,1539673200"; 
   d="scan'208";a="127004064"
Received: from ingas-nuc1.sea.intel.com ([10.254.106.117])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Jan 2019 19:58:54 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.von.dentz@intel.com, marcel@holtmann.org, brian.gix@intel.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v2 1/2] mesh: Rename mesh daemon executable to bluetooth-meshd
Date:   Fri, 18 Jan 2019 19:58:36 -0800
Message-Id: <20190119035837.6053-2-inga.stotland@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190119035837.6053-1-inga.stotland@intel.com>
References: <20190119035837.6053-1-inga.stotland@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 Makefile.mesh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Makefile.mesh b/Makefile.mesh
index ea6c5e939..66854e0bf 100644
--- a/Makefile.mesh
+++ b/Makefile.mesh
@@ -22,9 +22,9 @@ mesh_sources = mesh/mesh.h mesh/mesh.c \
 				mesh/prov-acceptor.c mesh/prov-initiator.c \
 				mesh/pb-adv.h mesh/pb-adv.c \
 				mesh/mesh-defs.h
-libexec_PROGRAMS += mesh/meshd
+libexec_PROGRAMS += mesh/bluetooth-meshd
 
-mesh_meshd_SOURCES = $(mesh_sources) mesh/main.c
-mesh_meshd_LDADD = src/libshared-ell.la $(ell_ldadd) -ljson-c
-mesh_meshd_DEPENDENCIES = $(ell_dependencies) src/libshared-ell.la
+mesh_bluetooth_meshd_SOURCES = $(mesh_sources) mesh/main.c
+mesh_bluetooth_meshd_LDADD = src/libshared-ell.la $(ell_ldadd) -ljson-c
+mesh_bluetooth_meshd_DEPENDENCIES = $(ell_dependencies) src/libshared-ell.la
 endif
-- 
2.17.2

