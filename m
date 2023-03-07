Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A21C742A7
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Mar 2023 22:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjCGW0G (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Mar 2023 17:26:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjCGWZo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Mar 2023 17:25:44 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E4CB04A9
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Mar 2023 14:25:08 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id y2so14722017pjg.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Mar 2023 14:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678227876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IQZKy3IHJaNGPM4dHl2hvvgbBOAHVYSI4LpSoo6O9E0=;
        b=FnpjHpyyIRq3F4KyNRd/2J+m4oGYuozWR7AClty5ijloHgMJO3Qr2xKKAz1MZORlfJ
         Ho2MdN+9hRBHOtVXysD4FEvMYNWR9nsH/FOGWEAeSkPDPoCI2NCB7798RPFSVYjE30Kk
         hNx2HNH/mFmrf7qxW1ydNCITDT5Btuh/t+69UFXc/j1bY/bhQlcasyUWefuexmcjaMAf
         OSNiao1CxkLN0E118kLXzKwYhf06dEAovWbWj4vkgmA7oxrr2gUbHc5RQIog974QwfIv
         Wng/4kzQ/DkMXSjHrlNm4eAlOiv5Wv41x9mIvAJ99a3NuUM8Wgd35nnc6qQfZbKm4nYW
         8M8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678227876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IQZKy3IHJaNGPM4dHl2hvvgbBOAHVYSI4LpSoo6O9E0=;
        b=7cNFx/ew3w5wecdcltl6Oyob/TTbGmu89Tv8ysmAxRviEFc7Yl4yu/d11R7y7mKvPK
         gLaOxqkystf++a5OyyFgXpExJRUqlsskIDgwmGRsOn6xkdh/pgZw6S6eWwU3BDOHifCd
         JiX1I4YpIf0TzWJGonZlDwxCs557YzQhX9rWihyQRMP5fRVzJtgD+wQaY6oPwASplE/g
         8O3vP4LWVthPbYUlPVGwcnMyU0oMC0wIz60PBMReZt4fWey9cv3hjiEkcArw6tD+ydCh
         rXGpYO66xtimU03M5MVj8yHnTK5L4rwoS58N1fi0pcYklIN0iqid9ZOBD9ahYXMbstCW
         arMw==
X-Gm-Message-State: AO0yUKUJqoNKZl15LHX9fXFpV1t2/Cz9w3raGCUWXwe4OSuM7lbgpM6W
        t5W9nFqn3KxIdi9kc2OP25Ou3bePcOM=
X-Google-Smtp-Source: AK7set80WKNLeAac59Q/5LcJvqTEcS34ZMtaujZZTw/mCPe9/U5yAcWfQuJ+aHfEqXdYfpjgpi+TPg==
X-Received: by 2002:a17:903:2450:b0:19c:e484:b45 with SMTP id l16-20020a170903245000b0019ce4840b45mr18269930pls.27.1678227876133;
        Tue, 07 Mar 2023 14:24:36 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id d18-20020a170902729200b0019c901b35ecsm8814392pll.106.2023.03.07.14.24.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 14:24:35 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC v2 10/12] tools: Add support to generate RSI using SIRK
Date:   Tue,  7 Mar 2023 14:24:20 -0800
Message-Id: <20230307222422.2608483-10-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307222422.2608483-1-luiz.dentz@gmail.com>
References: <20230307222422.2608483-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Sathish Narasimman <sathish.narasimman@intel.com>

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
index de036e783325..9ef69ed5124a 100644
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
+	uint8_t  rsi[6] = {0};
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
2.39.2

