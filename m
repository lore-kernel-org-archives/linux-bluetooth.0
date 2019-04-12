Return-Path: <SRS0=NumT=SO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446FEC10F0E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Apr 2019 14:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20B3221872
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Apr 2019 14:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfDLOH4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 Apr 2019 10:07:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:52736 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726327AbfDLOH4 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 Apr 2019 10:07:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3CA83AD72
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Apr 2019 14:07:55 +0000 (UTC)
From:   Ludwig Nussel <ludwig.nussel@suse.de>
To:     linux-bluetooth@vger.kernel.org
Cc:     Ludwig Nussel <ludwig.nussel@suse.de>
Subject: [PATCH] Fix installations to pkglibexecdir
Date:   Fri, 12 Apr 2019 16:07:41 +0200
Message-Id: <20190412140741.28565-1-ludwig.nussel@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In 78bce4800 pkglibexecdir was used instead of libexecdir. Make sure
Makefile and service files match, so install to pkglibexecdir actually.
---
 Makefile.am    | 4 ++--
 Makefile.mesh  | 2 +-
 Makefile.obexd | 2 +-
 Makefile.tools | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index f84a1faba..33baa66ff 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -22,7 +22,7 @@ EXTRA_DIST =
 
 pkglibexecdir = $(libexecdir)/bluetooth
 
-libexec_PROGRAMS =
+pkglibexec_PROGRAMS =
 
 pkgincludedir = $(includedir)/bluetooth
 
@@ -238,7 +238,7 @@ plugins_external_dummy_la_LDFLAGS = $(AM_LDFLAGS) -module -avoid-version \
 plugins_external_dummy_la_CFLAGS = $(AM_CFLAGS) -fvisibility=hidden
 endif
 
-libexec_PROGRAMS += src/bluetoothd
+pkglibexec_PROGRAMS += src/bluetoothd
 
 src_bluetoothd_SOURCES = $(builtin_sources) \
 			$(attrib_sources) $(btio_sources) \
diff --git a/Makefile.mesh b/Makefile.mesh
index 76e424b92..12653ccb1 100644
--- a/Makefile.mesh
+++ b/Makefile.mesh
@@ -26,7 +26,7 @@ mesh_sources = mesh/mesh.h mesh/mesh.c \
 				mesh/prov-acceptor.c mesh/prov-initiator.c \
 				mesh/pb-adv.h mesh/pb-adv.c \
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
2.16.4

