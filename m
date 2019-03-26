Return-Path: <SRS0=6DA+=R5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1F7C43381
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Mar 2019 17:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06C4B20823
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Mar 2019 17:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729800AbfCZRLu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:11:50 -0400
Received: from mga05.intel.com ([192.55.52.43]:54873 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbfCZRLu (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Mar 2019 13:11:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2019 10:11:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,273,1549958400"; 
   d="scan'208";a="134984418"
Received: from bgix-dell-lap.sea.intel.com ([10.252.18.76])
  by fmsmga008.fm.intel.com with ESMTP; 26 Mar 2019 10:11:48 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com, luiz.dentz@gmail.com,
        johan.hedberg@gmail.com
Subject: [PATCH BlueZ v2] mesh: Add dependancies required for mesh daemon
Date:   Tue, 26 Mar 2019 10:11:45 -0700
Message-Id: <20190326171145.5291-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Building bluetooth-meshd only, requires some generated files which
are only otherwise automatically generated on full builds.
---
 Makefile.mesh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Makefile.mesh b/Makefile.mesh
index 76e424b92..61fb40936 100644
--- a/Makefile.mesh
+++ b/Makefile.mesh
@@ -28,6 +28,8 @@ mesh_sources = mesh/mesh.h mesh/mesh.c \
 				mesh/mesh-defs.h
 libexec_PROGRAMS += mesh/bluetooth-meshd
 
+mesh/main.$(OBJEXT): $(@EXTERNAL_ELL_FALSE@ell_built_sources)
+mesh/main.$(OBJEXT): lib/bluetooth/bluetooth.h
 mesh_bluetooth_meshd_SOURCES = $(mesh_sources) mesh/main.c
 mesh_bluetooth_meshd_LDADD = src/libshared-ell.la $(ell_ldadd) -ljson-c
 mesh_bluetooth_meshd_DEPENDENCIES = $(ell_dependencies) src/libshared-ell.la
-- 
2.14.5

