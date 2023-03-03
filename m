Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC58C7EE33
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Mar 2023 01:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjCCB14 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Mar 2023 20:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjCCB1z (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Mar 2023 20:27:55 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013BC1BDA
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Mar 2023 17:27:53 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id n6so1179601plf.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Mar 2023 17:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IQZKy3IHJaNGPM4dHl2hvvgbBOAHVYSI4LpSoo6O9E0=;
        b=lkM1u6Nie4xAUTvNaxfXlN2HZ/KjhAXxavqonZYnNh65RHY5SQCrnlrGOE77UJlvGh
         tK04D/ODyXjex5IeT7mW2GHnLFCG8+ofLOo/vYX2XbNU3kuNFv56EPK75owUZ4xKfPoz
         nsLPdKXTHXpkp1DSMvbfxvrWidwr8GBP3PvGCV1sS9s4WEJ6FyXxbuZTA9TjXFtSOXYC
         6Pc9aBiWzQqMnY2V3R0A+isH4LDKiPcXFLvdUAo3j0FOsN5cBcoc7EX+IVzZzFvSZDix
         HWvHDsIBek5UXOuwd5uRdJZ5v7+YC4r04UCiJDDEZrmXOtpq88qFOte5869nGSPDhn4z
         ZIjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IQZKy3IHJaNGPM4dHl2hvvgbBOAHVYSI4LpSoo6O9E0=;
        b=pB2SrT9YaFfIfFMs3pUh0LKOxEL8uHvPGsircYCivIoh1tOykzSgv3qMRch6Do3w3n
         OR9+UeqQPyS4BAuWp2+eWfOEzJ0b3Q9UfOb6v37lN1jJbGy9fK5JFLRv8uxWX8yjrthh
         TVF+yOyRHKAiNDRjIbl7DcmaJywZkHwwb8++fSqmBV1f0xZ12zHzcOSIRmENp4OnfTLV
         nrOosnmmfAQrayDIfomcZELiiKDstgMBvnh8Orr4N2dKvrLelwejJemVXudjb0xDx17c
         DG6HQfQMb8xOUuu3zlRdoAwImQLq087boEpQilsqB2YEwI6glnmnHi9Kxl2SawJisfDy
         +0Ag==
X-Gm-Message-State: AO0yUKWi7ej0NBBS8Y2aV/Nk6xxO2MVUtnzuiSZDCUNeCToKXS6M53DK
        bUlGR4tbz86jQMmkg+l/FRbd/KBeKWQ=
X-Google-Smtp-Source: AK7set/CwLcmMAgMWTyqbk2wwNP7vV4BLb7uR9RlKcGj0MGhXDoHtvddgDEdWki/Zx1kZvP8BM5OSQ==
X-Received: by 2002:a17:903:230e:b0:19e:2d25:897e with SMTP id d14-20020a170903230e00b0019e2d25897emr347378plh.13.1677806873115;
        Thu, 02 Mar 2023 17:27:53 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id kd3-20020a17090313c300b0019a6d3851afsm284622plb.141.2023.03.02.17.27.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 17:27:52 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC 9/9] tools: Add support to generate RSI using SIRK
Date:   Thu,  2 Mar 2023 17:27:42 -0800
Message-Id: <20230303012742.1386291-9-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230303012742.1386291-1-luiz.dentz@gmail.com>
References: <20230303012742.1386291-1-luiz.dentz@gmail.com>
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

