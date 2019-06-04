Return-Path: <SRS0=Orb+=UD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0F3C282CE
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Jun 2019 20:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C211720862
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Jun 2019 20:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbfFDU3S (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Jun 2019 16:29:18 -0400
Received: from mga06.intel.com ([134.134.136.31]:21051 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbfFDU3S (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Jun 2019 16:29:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jun 2019 13:29:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,550,1549958400"; 
   d="scan'208";a="181680764"
Received: from bgix-dell-lap.sea.intel.com ([10.254.84.39])
  by fmsmga002.fm.intel.com with ESMTP; 04 Jun 2019 13:29:17 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com,
        ludwig.nussel@suse.de, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com
Subject: [PATCH BlueZ v4 1/3] install: Fix installations to pkglibexecdir
Date:   Tue,  4 Jun 2019 13:28:50 -0700
Message-Id: <20190604202852.12656-2-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190604202852.12656-1-brian.gix@intel.com>
References: <20190604202852.12656-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Ludwig Nussel <ludwig.nussel@suse.de>

In 78bce4800 libexecdir was switched to pkglibexecdir. To use the
matching installation script, use pkglibexec_Programs instead of
libexec_Programs.
---
 Makefile.am    | 4 ++--
 Makefile.mesh  | 2 +-
 Makefile.obexd | 2 +-
 Makefile.tools | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 2583fbdd9..9d25a815b 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -22,7 +22,7 @@ EXTRA_DIST =
 
 pkglibexecdir = $(libexecdir)/bluetooth
 
-libexec_PROGRAMS =
+pkglibexec_PROGRAMS =
 
 pkgincludedir = $(includedir)/bluetooth
 
@@ -242,7 +242,7 @@ plugins_external_dummy_la_LDFLAGS = $(AM_LDFLAGS) -module -avoid-version \
 plugins_external_dummy_la_CFLAGS = $(AM_CFLAGS) -fvisibility=hidden
 endif
 
-libexec_PROGRAMS += src/bluetoothd
+pkglibexec_PROGRAMS += src/bluetoothd
 
 src_bluetoothd_SOURCES = $(builtin_sources) \
 			$(attrib_sources) $(btio_sources) \
diff --git a/Makefile.mesh b/Makefile.mesh
index d494287ab..8dacc104c 100644
--- a/Makefile.mesh
+++ b/Makefile.mesh
@@ -28,7 +28,7 @@ mesh_sources = mesh/mesh.h mesh/mesh.c \
 				mesh/pb-adv.h mesh/pb-adv.c \
 				mesh/keyring.h mesh/keyring.c \
 				mesh/mesh-defs.h
-libexec_PROGRAMS += mesh/bluetooth-meshd
+pkglibexec_PROGRAMS += mesh/bluetooth-meshd
 
 mesh_bluetooth_meshd_SOURCES = $(mesh_sources) mesh/main.c
 mesh_bluetooth_meshd_LDADD = src/libshared-ell.la $(ell_ldadd) -ljson-c
diff --git a/Makefile.obexd b/Makefile.obexd
index 1c1e500fe..d36874770 100644
--- a/Makefile.obexd
+++ b/Makefile.obexd
@@ -51,7 +51,7 @@ obexd_builtin_modules += mns
 obexd_builtin_sources += obexd/client/mns.c obexd/src/map_ap.h \
 				obexd/client/map-event.h
 
-libexec_PROGRAMS += obexd/src/obexd
+pkglibexec_PROGRAMS += obexd/src/obexd
 
 obexd_src_obexd_SOURCES = $(btio_sources) $(gobex_sources) \
 			$(obexd_builtin_sources) \
diff --git a/Makefile.tools b/Makefile.tools
index 379e127b6..7d5361bcd 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -43,7 +43,7 @@ monitor_btmon_LDADD = lib/libbluetooth-internal.la \
 endif
 
 if LOGGER
-libexec_PROGRAMS += tools/btmon-logger
+pkglibexec_PROGRAMS += tools/btmon-logger
 
 tools_btmon_logger_SOURCES = tools/btmon-logger.c
 tools_btmon_logger_LDADD = src/libshared-mainloop.la
-- 
2.14.5

