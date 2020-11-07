Return-Path: <SRS0=aRPM=EN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C61C388F9
	for <linux-bluetooth@archiver.kernel.org>; Sat,  7 Nov 2020 07:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCE5E20872
	for <linux-bluetooth@archiver.kernel.org>; Sat,  7 Nov 2020 07:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgKGHDa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 7 Nov 2020 02:03:30 -0500
Received: from mga17.intel.com ([192.55.52.151]:45622 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbgKGHDa (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 7 Nov 2020 02:03:30 -0500
IronPort-SDR: tEKwUxU8A+jU6Z5BqXPdUT7vl0QNHIok9bzta4AqLBGXp6Wg+a9JcJoy0WAge7HeQrr8H2gU09
 kkmphk9kD0Og==
X-IronPort-AV: E=McAfee;i="6000,8403,9797"; a="149485515"
X-IronPort-AV: E=Sophos;i="5.77,458,1596524400"; 
   d="scan'208";a="149485515"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 23:03:30 -0800
IronPort-SDR: t/QIq2jT4TazEDnX7BRxEpEOzn+SiZtEcJyR3PcHfPTjHANRGbvqi5gQLEaqEF/IUnR11f7a9h
 P61MazvqfpNA==
X-IronPort-AV: E=Sophos;i="5.77,458,1596524400"; 
   d="scan'208";a="359032023"
Received: from ralassax-mobl.amr.corp.intel.com (HELO ingas-nuc1.intel.com) ([10.209.101.141])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 23:03:29 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.von.dentz@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [RFC PATCH BlueZ 05/10] tools/userchan-tester: Convert to use ELL library
Date:   Fri,  6 Nov 2020 23:03:07 -0800
Message-Id: <20201107070312.8561-6-inga.stotland@intel.com>
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
 Makefile.tools          | 4 ++--
 tools/userchan-tester.c | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index 15613a5c9..7c29e115b 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -165,12 +165,12 @@ tools_hci_tester_SOURCES = tools/hci-tester.c monitor/bt.h
 tools_hci_tester_LDADD = src/libshared-glib.la $(GLIB_LIBS)
 
 tools_userchan_tester_SOURCES = tools/userchan-tester.c monitor/bt.h \
-				emulator/hciemu.h emulator/hciemu.c \
+				emulator/hciemu.h emulator/hciemu-ell.c \
 				emulator/btdev.h emulator/btdev.c \
 				emulator/bthost.h emulator/bthost.c \
 				emulator/smp.c
 tools_userchan_tester_LDADD = lib/libbluetooth-internal.la \
-				src/libshared-glib.la $(GLIB_LIBS)
+				src/libshared-ell.la $(ell_ldadd)
 endif
 
 if TOOLS
diff --git a/tools/userchan-tester.c b/tools/userchan-tester.c
index c17644fb8..21c853221 100644
--- a/tools/userchan-tester.c
+++ b/tools/userchan-tester.c
@@ -18,8 +18,6 @@
 #include <errno.h>
 #include <stdbool.h>
 
-#include <glib.h>
-
 #include "lib/bluetooth.h"
 #include "lib/hci.h"
 #include "lib/mgmt.h"
-- 
2.26.2

