Return-Path: <SRS0=gL6M=UJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DC5C31E43
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 Jun 2019 17:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B6AF20859
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 Jun 2019 17:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387864AbfFJRa4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 10 Jun 2019 13:30:56 -0400
Received: from mga14.intel.com ([192.55.52.115]:42820 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727674AbfFJRa4 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 10 Jun 2019 13:30:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jun 2019 10:30:54 -0700
X-ExtLoop1: 1
Received: from bgix-dell-lap.sea.intel.com ([10.251.159.204])
  by orsmga006.jf.intel.com with ESMTP; 10 Jun 2019 10:30:54 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com, marcel@holtmann.org
Subject: [PATCH BlueZ] build: Add missing mesh & btpclient dependancies
Date:   Mon, 10 Jun 2019 10:30:50 -0700
Message-Id: <20190610173050.22817-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

btpclient and bluetooth mesh fail to build on their own until
certain ELL and generated header files have been built, which
can cause a build to fail if derived objects are generated in
wrong order.
---
 Makefile.mesh  | 3 +++
 Makefile.tools | 1 +
 2 files changed, 4 insertions(+)

diff --git a/Makefile.mesh b/Makefile.mesh
index 85b88eba4..b1f14e477 100644
--- a/Makefile.mesh
+++ b/Makefile.mesh
@@ -35,6 +35,9 @@ mesh_sources = mesh/mesh.h mesh/mesh.c \
 				mesh/mesh-defs.h
 pkglibexec_PROGRAMS += mesh/bluetooth-meshd
 
+mesh/mesh.$(OBJEXT): ell/internal
+mesh/main.$(OBJEXT): src/builtin.h lib/bluetooth/bluetooth.h
+
 mesh_bluetooth_meshd_SOURCES = $(mesh_sources) mesh/main.c
 mesh_bluetooth_meshd_LDADD = src/libshared-ell.la $(ell_ldadd) -ljson-c
 mesh_bluetooth_meshd_DEPENDENCIES = $(ell_dependencies) src/libshared-ell.la \
diff --git a/Makefile.tools b/Makefile.tools
index 7d5361bcd..b6b99d216 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -472,4 +472,5 @@ tools_btpclient_SOURCES = tools/btpclient.c src/shared/btp.c src/shared/btp.h
 tools_btpclient_LDADD = lib/libbluetooth-internal.la \
 				src/libshared-ell.la $(ell_ldadd)
 tools_btpclient_DEPENDENCIES = lib/libbluetooth-internal.la $(ell_dependencies)
+tools/btpclient.$(OBJEXT): src/libshared-ell.la ell/internal
 endif
-- 
2.14.5

