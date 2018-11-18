Return-Path: <SRS0=E1HW=N5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46202C04EBC
	for <linux-bluetooth@archiver.kernel.org>; Sun, 18 Nov 2018 16:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BDAD20869
	for <linux-bluetooth@archiver.kernel.org>; Sun, 18 Nov 2018 16:14:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BDAD20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inai.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbeKSCfA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 18 Nov 2018 21:35:00 -0500
Received: from a3.inai.de ([88.198.85.195]:54156 "EHLO a3.inai.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726746AbeKSCfA (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 18 Nov 2018 21:35:00 -0500
X-Greylist: delayed 371 seconds by postgrey-1.27 at vger.kernel.org; Sun, 18 Nov 2018 21:34:59 EST
Received: by a3.inai.de (Postfix, from userid 65534)
        id 0EF6C130158A; Sun, 18 Nov 2018 17:08:12 +0100 (CET)
Received: from a4.inai.de (a4.inai.de [IPv6:2a01:4f8:222:6c9::f8])
        by a3.inai.de (Postfix) with ESMTP id DA7141337BCE;
        Sun, 18 Nov 2018 17:08:07 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     linux-bluetooth@vger.kernel.org
Cc:     jengelh@inai.de
Subject: [PATCH 5/8] build: add missing ELL_CFLAGS
Date:   Sun, 18 Nov 2018 17:07:59 +0100
Message-Id: <20181118160802.11087-6-jengelh@inai.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181118160802.11087-1-jengelh@inai.de>
References: <20181118160802.11087-1-jengelh@inai.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Some targets link ELL_LIBS, which means they also need ELL_CFLAGS
in their (or the global) CPPFLAGS.
---
 Makefile.am   | 1 +
 Makefile.mesh | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/Makefile.am b/Makefile.am
index 4e320602c..e5d19682b 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -139,6 +139,7 @@ src_libshared_mainloop_la_SOURCES = $(shared_sources) \
 if ELL
 src_libshared_ell_la_SOURCES = $(shared_sources) \
 				src/shared/io-ell.c
+src_libshared_ell_la_CPPFLAGS = $(AM_CPPFLAGS) $(ELL_CFLAGS)
 noinst_LTLIBRARIES += src/libshared-ell.la
 endif
 
diff --git a/Makefile.mesh b/Makefile.mesh
index 50bcc19ad..4de22ba8c 100644
--- a/Makefile.mesh
+++ b/Makefile.mesh
@@ -21,6 +21,8 @@ mesh_sources = mesh/mesh.h mesh/mesh.c \
 				mesh/mesh-defs.h
 libexec_PROGRAMS += mesh/meshd
 
+mesh_meshd_CPPFLAGS = $(AM_CPPFLAGS) $(ELL_CFLAGS)
+
 mesh_meshd_SOURCES = $(mesh_sources) mesh/main.c
 
 mesh_meshd_LDADD = src/shared/ecc.lo src/shared/queue.lo src/shared/io-ell.lo \
@@ -34,6 +36,8 @@ mesh_btmesh_SOURCES = $(mesh_sources) \
 						mesh/agent.c \
 						mesh/btmesh.c
 
+mesh_btmesh_CPPFLAGS = $(AM_CPPFLAGS) $(ELL_CFLAGS)
+
 mesh_btmesh_LDADD = src/shared/ecc.lo src/shared/queue.lo src/shared/io-ell.lo \
 				src/shared/util.lo src/shared/hci.lo src/shared/mgmt.lo \
 				src/libshared-mainloop.la \
-- 
2.19.1

