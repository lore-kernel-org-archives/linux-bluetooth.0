Return-Path: <SRS0=aRPM=EN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B95C388F7
	for <linux-bluetooth@archiver.kernel.org>; Sat,  7 Nov 2020 07:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26DBE20872
	for <linux-bluetooth@archiver.kernel.org>; Sat,  7 Nov 2020 07:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgKGHDe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 7 Nov 2020 02:03:34 -0500
Received: from mga17.intel.com ([192.55.52.151]:45630 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727830AbgKGHDd (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 7 Nov 2020 02:03:33 -0500
IronPort-SDR: zDK7wJFGdaBCNb5q9yJikTT3Ow1SJGeHVGPAKXc0w/iZ0gucdJ0FoNH2xAmW3l5uBDl5LHa+iX
 BnA5YKipIJiw==
X-IronPort-AV: E=McAfee;i="6000,8403,9797"; a="149485520"
X-IronPort-AV: E=Sophos;i="5.77,458,1596524400"; 
   d="scan'208";a="149485520"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 23:03:33 -0800
IronPort-SDR: a8ln/8/M3Nn2eqo/0e2EcVg8SymcH4SVsEFGFmkER1De5ymuOgUlZL/3Aop/+RrNAO5T4zZg/S
 3zLYywbGXuzw==
X-IronPort-AV: E=Sophos;i="5.77,458,1596524400"; 
   d="scan'208";a="359032054"
Received: from ralassax-mobl.amr.corp.intel.com (HELO ingas-nuc1.intel.com) ([10.209.101.141])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 23:03:33 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.von.dentz@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [RFC PATCH BlueZ 09/10] tools/mgmt-tester: Convert to use ELL library
Date:   Fri,  6 Nov 2020 23:03:11 -0800
Message-Id: <20201107070312.8561-10-inga.stotland@intel.com>
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
 tools/mgmt-tester.c | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index 03264cff9..e65547c3f 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -106,12 +106,12 @@ tools_3dsp_SOURCES = tools/3dsp.c monitor/bt.h
 tools_3dsp_LDADD = src/libshared-mainloop.la
 
 tools_mgmt_tester_SOURCES = tools/mgmt-tester.c monitor/bt.h \
-				emulator/hciemu.h emulator/hciemu.c \
+				emulator/hciemu.h emulator/hciemu-ell.c \
 				emulator/btdev.h emulator/btdev.c \
 				emulator/bthost.h emulator/bthost.c \
 				emulator/smp.c
 tools_mgmt_tester_LDADD = lib/libbluetooth-internal.la \
-				src/libshared-glib.la $(GLIB_LIBS)
+				src/libshared-ell.la $(ell_ldadd)
 
 tools_l2cap_tester_SOURCES = tools/l2cap-tester.c monitor/bt.h \
 				emulator/hciemu.h emulator/hciemu-ell.c \
diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index d8554411f..75f6457d2 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -18,7 +18,7 @@
 #include <errno.h>
 #include <unistd.h>
 
-#include <glib.h>
+#include <ell/ell.h>
 
 #include "lib/bluetooth.h"
 #include "lib/hci.h"
@@ -130,7 +130,8 @@ static void read_info_callback(uint8_t status, uint16_t length,
 	tester_print("  Name: %s", rp->name);
 	tester_print("  Short name: %s", rp->short_name);
 
-	if (strcmp(hciemu_get_address(data->hciemu), addr)) {
+	if (!hciemu_get_address(data->hciemu) ||
+			(strcmp(hciemu_get_address(data->hciemu), addr))) {
 		tester_pre_setup_failed();
 		return;
 	}
-- 
2.26.2

