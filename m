Return-Path: <SRS0=aRPM=EN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383CBC5517A
	for <linux-bluetooth@archiver.kernel.org>; Sat,  7 Nov 2020 07:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF03620872
	for <linux-bluetooth@archiver.kernel.org>; Sat,  7 Nov 2020 07:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgKGHDc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 7 Nov 2020 02:03:32 -0500
Received: from mga17.intel.com ([192.55.52.151]:45628 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727824AbgKGHDb (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 7 Nov 2020 02:03:31 -0500
IronPort-SDR: BqVMcGsCafbJSSAEoXkIj9+P8yAr6ihIOlrBHuIgFGjzZ2lxZGVnI2L977TE/06iZaA2y3CQuH
 qZVms5Bn58Ag==
X-IronPort-AV: E=McAfee;i="6000,8403,9797"; a="149485518"
X-IronPort-AV: E=Sophos;i="5.77,458,1596524400"; 
   d="scan'208";a="149485518"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 23:03:31 -0800
IronPort-SDR: upLVFUf7HTEO/HlFMAD/MZFS72CX9FM4iRjIQmF5GECpAe/1P94yZWE1uWP8XKvMbXuiNLQE84
 ehSilGM+hFzQ==
X-IronPort-AV: E=Sophos;i="5.77,458,1596524400"; 
   d="scan'208";a="359032035"
Received: from ralassax-mobl.amr.corp.intel.com (HELO ingas-nuc1.intel.com) ([10.209.101.141])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 23:03:31 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.von.dentz@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [RFC PATCH BlueZ 07/10] tools/bnep-tester: Convert to use ELL library
Date:   Fri,  6 Nov 2020 23:03:09 -0800
Message-Id: <20201107070312.8561-8-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201107070312.8561-1-inga.stotland@intel.com>
References: <20201107070312.8561-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This reworks the source code to use ELL primitives and removes
dependecies on GLib.
---
 Makefile.tools      | 4 ++--
 tools/bnep-tester.c | 9 +--------
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index 83c30252d..8c79a528d 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -130,12 +130,12 @@ tools_rfcomm_tester_LDADD = lib/libbluetooth-internal.la \
 				src/libshared-glib.la $(GLIB_LIBS)
 
 tools_bnep_tester_SOURCES = tools/bnep-tester.c monitor/bt.h \
-				emulator/hciemu.h emulator/hciemu.c \
+				emulator/hciemu.h emulator/hciemu-ell.c \
 				emulator/btdev.h emulator/btdev.c \
 				emulator/bthost.h emulator/bthost.c \
 				emulator/smp.c
 tools_bnep_tester_LDADD = lib/libbluetooth-internal.la \
-				src/libshared-glib.la $(GLIB_LIBS)
+				src/libshared-ell.la $(ell_ldadd)
 
 tools_smp_tester_SOURCES = tools/smp-tester.c monitor/bt.h \
 				emulator/hciemu.h emulator/hciemu-ell.c \
diff --git a/tools/bnep-tester.c b/tools/bnep-tester.c
index 5e4d7fb6d..dab913862 100644
--- a/tools/bnep-tester.c
+++ b/tools/bnep-tester.c
@@ -18,7 +18,7 @@
 #include <errno.h>
 #include <stdbool.h>
 
-#include <glib.h>
+#include <ell/ell.h>
 
 #include "lib/bluetooth.h"
 #include "lib/bnep.h"
@@ -37,7 +37,6 @@ struct test_data {
 	struct hciemu *hciemu;
 	enum hciemu_type hciemu_type;
 	const void *test_data;
-	unsigned int io_id;
 	uint16_t conn_handle;
 };
 
@@ -192,11 +191,6 @@ static void test_post_teardown(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 
-	if (data->io_id > 0) {
-		g_source_remove(data->io_id);
-		data->io_id = 0;
-	}
-
 	hciemu_unref(data->hciemu);
 	data->hciemu = NULL;
 }
@@ -282,7 +276,6 @@ static void test_basic(const void *test_data)
 			break; \
 		user->hciemu_type = HCIEMU_TYPE_BREDR; \
 		user->test_data = data; \
-		user->io_id = 0; \
 		tester_add_full(name, data, \
 				test_pre_setup, setup, func, NULL, \
 				test_post_teardown, 2, user, test_data_free); \
-- 
2.26.2

