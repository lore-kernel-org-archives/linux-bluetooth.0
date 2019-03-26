Return-Path: <SRS0=6DA+=R5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FE4C43381
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Mar 2019 17:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 654FF20693
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Mar 2019 17:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729440AbfCZRIH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:08:07 -0400
Received: from mga03.intel.com ([134.134.136.65]:22678 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbfCZRIH (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Mar 2019 13:08:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2019 10:08:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,273,1549958400"; 
   d="scan'208";a="137587407"
Received: from bgix-dell-lap.sea.intel.com ([10.252.18.76])
  by fmsmga007.fm.intel.com with ESMTP; 26 Mar 2019 10:08:05 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com, luiz.dentz@gmail.com,
        johan.hedberg@gmail.com
Subject: [PATCH BlueZ] mesh: Add dependancies required for mesh daemon
Date:   Tue, 26 Mar 2019 10:07:58 -0700
Message-Id: <20190326170758.30354-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Building bluetooth-meshd only, requires some generated files which
are only otherwise automatically generated on full builds.
---
 Makefile.mesh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile.mesh b/Makefile.mesh
index 76e424b92..d3dce7d25 100644
--- a/Makefile.mesh
+++ b/Makefile.mesh
@@ -28,6 +28,7 @@ mesh_sources = mesh/mesh.h mesh/mesh.c \
 				mesh/mesh-defs.h
 libexec_PROGRAMS += mesh/bluetooth-meshd
 
+mesh/main.$(OBJEXT): $(@EXTERNAL_ELL_FALSE@ell_built_sources) lib/bluetooth/bluetooth.h
 mesh_bluetooth_meshd_SOURCES = $(mesh_sources) mesh/main.c
 mesh_bluetooth_meshd_LDADD = src/libshared-ell.la $(ell_ldadd) -ljson-c
 mesh_bluetooth_meshd_DEPENDENCIES = $(ell_dependencies) src/libshared-ell.la
-- 
2.14.5

