Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF42C4321E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Nov 2022 23:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbiKUXq6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Nov 2022 18:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbiKUXqU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Nov 2022 18:46:20 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74A1CF9
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Nov 2022 15:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669074289; x=1700610289;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hlRyjRXk/Mf8iKNdbIXvoPgMyfu1rQ99CWmCVV5h0AE=;
  b=j8n5PcXlfAUaTH731qI8TNyvZb+Hyfs9Pz1uBAXqCG7cI2FtgC+VwCBL
   gYDjPkpHoGkEvdBGZ0IH1Pf+p6yjpTrngK8eseVHQv5bpluzAgBqzg5nI
   8l0EGhxaPa4Vr1+PZaHP47ZRG2JlJgBoqFl9whlJ3WVyPSDO016VOA8ge
   BmQy6Vb04CZMY7P5zzkwS1/0BD/RcSD3UcYy4tq70D7+g5Ce97tchYkww
   jNiE9061g22OI37ryUKqNX+fxZZkMspbJ2y+/f5mrNx/FjsGPPs+ReHJq
   jeVrEXdtYNyNZizrEdJI/VKcsaX/kvt8o1H+bDSgaBNpYK9koWnBnGM3P
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="377946614"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="377946614"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 15:44:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="783633473"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="783633473"
Received: from intel-latitude-e5450.iind.intel.com ([10.224.186.32])
  by fmsmga001.fm.intel.com with ESMTP; 21 Nov 2022 15:44:48 -0800
From:   Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH BlueZ 6/6] tools: Add support to generate RSI using SIRK
Date:   Tue, 22 Nov 2022 05:16:24 +0530
Message-Id: <20221121234624.2961-7-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221121234624.2961-1-sathish.narasimman@intel.com>
References: <20221121234624.2961-1-sathish.narasimman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The patch helps to generate Resolvable set identifier adv data.
which can be used as ADV data during advertisement.
It will be used to identify the device as part of setmember for
Coordinated set identification profile.
Example:
$<path to advtest/>advtest -i "761FAE703ED681F0C50B34155B6434FB"
SIRK: 761FAE703ED681F0C50B34155B6434FB
  RSI:  0x71 0xcb 0xbc 0x7e 0x01 0x84
    Random: bccb71
    Hash:   84017e
---
 tools/advtest.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 78 insertions(+), 2 deletions(-)

diff --git a/tools/advtest.c b/tools/advtest.c
index de036e783325..1ac9dd9e1226 100644
--- a/tools/advtest.c
+++ b/tools/advtest.c
@@ -13,6 +13,13 @@
 #include <config.h>
 #endif
 
+#include <stdlib.h>
+
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+
 #include <getopt.h>
 
 #include "lib/bluetooth.h"
@@ -32,6 +39,9 @@
 			"\xe1\x23\x99\xc1\xca\x9a\xc3\x31"
 #define SCAN_IRK	"\xfa\x73\x09\x11\x3f\x03\x37\x0f" \
 			"\xf4\xf9\x93\x1e\xf9\xa3\x63\xa6"
+#ifndef MIN
+#define MIN(x, y) ((x) < (y) ? (x) : (y))
+#endif
 
 static struct mgmt *mgmt;
 static uint16_t index1 = MGMT_INDEX_NONE;
@@ -43,13 +53,73 @@ static struct bt_hci *scan_dev;
 
 static void print_rpa(const uint8_t addr[6])
 {
-	printf("  Address:  %02x:%02x:%02x:%02x:%02x:%02x\n",
+	printf("  RSI:\t0x%02x 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x\n",
 					addr[5], addr[4], addr[3],
 					addr[2], addr[1], addr[0]);
 	printf("    Random: %02x%02x%02x\n", addr[3], addr[4], addr[5]);
 	printf("    Hash:   %02x%02x%02x\n", addr[0], addr[1], addr[2]);
 }
 
+static size_t hex2bin(const char *hexstr, uint8_t *buf, size_t buflen)
+{
+	size_t i, len;
+
+	len = MIN((strlen(hexstr) / 2), buflen);
+	memset(buf, 0, len);
+
+	for (i = 0; i < len; i++)
+		if (sscanf(hexstr + (i * 2), "%02hhX", &buf[i]) != 1)
+			continue;
+
+
+	return len;
+}
+
+static bool get_random_bytes(void *buf, size_t num_bytes)
+{
+	ssize_t len;
+	int fd;
+
+	fd = open("/dev/urandom", O_RDONLY);
+	if (fd < 0)
+		return false;
+
+	len = read(fd, buf, num_bytes);
+
+	close(fd);
+
+	if (len < 0)
+		return false;
+
+	return true;
+}
+
+static void generate_rsi(char *val)
+{
+	uint8_t sirk[16], hash[3];
+	uint8_t  rsi[6];
+
+	hex2bin(val, sirk, sizeof(sirk));
+
+	get_random_bytes(&rsi[3], 3);
+
+	rsi[5] &= 0x3f; /* Clear 2 msb */
+	rsi[5] |= 0x40; /* Set 2nd msb */
+
+	crypto = bt_crypto_new();
+	if (!crypto) {
+		fprintf(stderr, "Failed to open crypto interface\n");
+		mainloop_exit_failure();
+		return;
+	}
+
+	bt_crypto_ah(crypto, sirk, rsi + 3, hash);
+	memcpy(rsi, hash, 3);
+
+	print_rpa(rsi);
+}
+
+
 static void scan_le_adv_report(const void *data, uint8_t size,
 							void *user_data)
 {
@@ -351,9 +421,11 @@ static void usage(void)
 	printf("\tadvtest [options]\n");
 	printf("options:\n"
 		"\t-h, --help             Show help options\n");
+	printf(" \t-i  <128bit SIRK>,     Generate RSI ADV Data\n");
 }
 
 static const struct option main_options[] = {
+	{ "hash",   no_argument,       NULL, 'i' },
 	{ "version",   no_argument,       NULL, 'v' },
 	{ "help",      no_argument,       NULL, 'h' },
 	{ }
@@ -366,11 +438,15 @@ int main(int argc ,char *argv[])
 	for (;;) {
 		int opt;
 
-		opt = getopt_long(argc, argv, "vh", main_options, NULL);
+		opt = getopt_long(argc, argv, "i:vh", main_options, NULL);
 		if (opt < 0)
 			break;
 
 		switch (opt) {
+		case 'i':
+			printf("SIRK: %s\n", optarg);
+			generate_rsi(optarg);
+			return EXIT_SUCCESS;
 		case 'v':
 			printf("%s\n", VERSION);
 			return EXIT_SUCCESS;
-- 
2.25.1

