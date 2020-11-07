Return-Path: <SRS0=aRPM=EN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B89C388F7
	for <linux-bluetooth@archiver.kernel.org>; Sat,  7 Nov 2020 07:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E05B206F9
	for <linux-bluetooth@archiver.kernel.org>; Sat,  7 Nov 2020 07:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgKGHDb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 7 Nov 2020 02:03:31 -0500
Received: from mga17.intel.com ([192.55.52.151]:45622 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727822AbgKGHDb (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 7 Nov 2020 02:03:31 -0500
IronPort-SDR: kIKE7RUJKAsyIRuEbTf9T4qlp/QkuhNWOXSLXExa5K1cGUzSzhpQ9KVUMxAYGHP5qq9kQ6lZ6N
 079zL5PWO1sw==
X-IronPort-AV: E=McAfee;i="6000,8403,9797"; a="149485516"
X-IronPort-AV: E=Sophos;i="5.77,458,1596524400"; 
   d="scan'208";a="149485516"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 23:03:30 -0800
IronPort-SDR: eFNgLAtE7wsI5VVkv1xpDsW7m1WAkpfLLu8MaecQ1jUJC7cGJrDc+WNCchvs2PhqaljFxxqLzi
 9O1xhHSMRkNQ==
X-IronPort-AV: E=Sophos;i="5.77,458,1596524400"; 
   d="scan'208";a="359032027"
Received: from ralassax-mobl.amr.corp.intel.com (HELO ingas-nuc1.intel.com) ([10.209.101.141])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 23:03:30 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.von.dentz@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [RFC PATCH BlueZ 06/10] tools/smp-tester: Convert to use ELL library
Date:   Fri,  6 Nov 2020 23:03:08 -0800
Message-Id: <20201107070312.8561-7-inga.stotland@intel.com>
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
 Makefile.tools     |  4 ++--
 tools/smp-tester.c | 24 +++++++++---------------
 2 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index 7c29e115b..83c30252d 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -138,12 +138,12 @@ tools_bnep_tester_LDADD = lib/libbluetooth-internal.la \
 				src/libshared-glib.la $(GLIB_LIBS)
 
 tools_smp_tester_SOURCES = tools/smp-tester.c monitor/bt.h \
-				emulator/hciemu.h emulator/hciemu.c \
+				emulator/hciemu.h emulator/hciemu-ell.c \
 				emulator/btdev.h emulator/btdev.c \
 				emulator/bthost.h emulator/bthost.c \
 				emulator/smp.c
 tools_smp_tester_LDADD = lib/libbluetooth-internal.la \
-				src/libshared-glib.la $(GLIB_LIBS)
+				src/libshared-ell.la $(ell_ldadd)
 
 tools_gap_tester_SOURCES = tools/gap-tester.c monitor/bt.h \
 				emulator/hciemu.h emulator/hciemu-ell.c \
diff --git a/tools/smp-tester.c b/tools/smp-tester.c
index 7823b6b17..b7843c73d 100644
--- a/tools/smp-tester.c
+++ b/tools/smp-tester.c
@@ -18,7 +18,7 @@
 #include <stdbool.h>
 #include <sys/socket.h>
 
-#include <glib.h>
+#include <ell/ell.h>
 
 #include "lib/bluetooth.h"
 #include "lib/hci.h"
@@ -41,7 +41,6 @@ struct test_data {
 	uint16_t mgmt_index;
 	struct hciemu *hciemu;
 	enum hciemu_type hciemu_type;
-	unsigned int io_id;
 	uint8_t ia[6];
 	uint8_t ia_type;
 	uint8_t ra[6];
@@ -223,11 +222,6 @@ static void test_post_teardown(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 
-	if (data->io_id > 0) {
-		g_source_remove(data->io_id);
-		data->io_id = 0;
-	}
-
 	if (data->crypto) {
 		bt_crypto_unref(data->crypto);
 		data->crypto = NULL;
@@ -287,7 +281,7 @@ static const struct smp_req_rsp nval_req_1[] = {
 
 static const struct smp_data smp_server_nval_req_1_test = {
 	.req = nval_req_1,
-	.req_count = G_N_ELEMENTS(nval_req_1),
+	.req_count = L_ARRAY_SIZE(nval_req_1),
 };
 
 static const uint8_t smp_nval_req_2[7] = { 0x01 };
@@ -300,7 +294,7 @@ static const struct smp_req_rsp srv_nval_req_1[] = {
 
 static const struct smp_data smp_server_nval_req_2_test = {
 	.req = srv_nval_req_1,
-	.req_count = G_N_ELEMENTS(srv_nval_req_1),
+	.req_count = L_ARRAY_SIZE(srv_nval_req_1),
 };
 
 static const uint8_t smp_nval_req_3[] = { 0x01, 0xff };
@@ -313,7 +307,7 @@ static const struct smp_req_rsp srv_nval_req_2[] = {
 
 static const struct smp_data smp_server_nval_req_3_test = {
 	.req = srv_nval_req_2,
-	.req_count = G_N_ELEMENTS(srv_nval_req_2),
+	.req_count = L_ARRAY_SIZE(srv_nval_req_2),
 };
 
 static const uint8_t smp_basic_req_1[] = {	0x01,	/* Pairing Request */
@@ -347,7 +341,7 @@ static const struct smp_req_rsp srv_basic_req_1[] = {
 
 static const struct smp_data smp_server_basic_req_1_test = {
 	.req = srv_basic_req_1,
-	.req_count = G_N_ELEMENTS(srv_basic_req_1),
+	.req_count = L_ARRAY_SIZE(srv_basic_req_1),
 };
 
 static const struct smp_req_rsp cli_basic_req_1[] = {
@@ -361,7 +355,7 @@ static const struct smp_req_rsp cli_basic_req_1[] = {
 
 static const struct smp_data smp_client_basic_req_1_test = {
 	.req = cli_basic_req_1,
-	.req_count = G_N_ELEMENTS(cli_basic_req_1),
+	.req_count = L_ARRAY_SIZE(cli_basic_req_1),
 };
 
 static const uint8_t smp_basic_req_2[] = {	0x01,	/* Pairing Request */
@@ -384,7 +378,7 @@ static const struct smp_req_rsp cli_basic_req_2[] = {
 
 static const struct smp_data smp_client_basic_req_2_test = {
 	.req = cli_basic_req_2,
-	.req_count = G_N_ELEMENTS(cli_basic_req_1),
+	.req_count = L_ARRAY_SIZE(cli_basic_req_1),
 	.mitm = true,
 };
 
@@ -423,7 +417,7 @@ static const struct smp_req_rsp cli_sc_req_1[] = {
 
 static const struct smp_data smp_client_sc_req_1_test = {
 	.req = cli_sc_req_1,
-	.req_count = G_N_ELEMENTS(cli_sc_req_1),
+	.req_count = L_ARRAY_SIZE(cli_sc_req_1),
 	.sc = true,
 };
 
@@ -449,7 +443,7 @@ static const struct smp_req_rsp cli_sc_req_2[] = {
 
 static const struct smp_data smp_client_sc_req_2_test = {
 	.req = cli_sc_req_2,
-	.req_count = G_N_ELEMENTS(cli_sc_req_2),
+	.req_count = L_ARRAY_SIZE(cli_sc_req_2),
 	.sc = true,
 };
 
-- 
2.26.2

