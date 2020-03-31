Return-Path: <SRS0=zBKN=5Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA900C43331
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Mar 2020 00:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9901020748
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Mar 2020 00:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RsTAlFgt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729468AbgCaAeP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Mar 2020 20:34:15 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40254 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729299AbgCaAeP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Mar 2020 20:34:15 -0400
Received: by mail-pf1-f193.google.com with SMTP id c20so6925059pfi.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2020 17:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=3qxZru9KFV/H4CA3I/H9rD3aYl/9PNxkMPKPgwvdbSU=;
        b=RsTAlFgtIAWcZ4zhL2iNKdHxkeaT9E7D+dL6l1OJ+6rk1NIL72eWzu/WxxKliZgVCq
         8kQu5qw1hKyC9DGfkgs1YAXSjMmnU5W5qpM81/lie/9lVlq2c9NbVSGGWlFh0RwrXlbx
         X8BAfdiEsQcIt1hYixc8RGp/aqP4/+JwRS0SY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3qxZru9KFV/H4CA3I/H9rD3aYl/9PNxkMPKPgwvdbSU=;
        b=SGFi/h3diAsbZREmbJ52nIYQ9sZL0WQzyv5My9/ZSZjQivHaGAulYnt9HuRK6D5t7m
         TCsg9jolb8Y6CRE8W/EsBKeWduCd3ocKGwU08LRi1zvv9vmkP5xr4GIUj/q4vbSYh0Cv
         Vu3VzbOuKGBSEEIo4pWbMYCMESEtsxLR9QCLabu698ENW08xINFcEd/2zZTOV9f0H77d
         CbPHLrferyfKnHoYlVhOdK4zZi8A1URb79dx8NcF1W0gAQQxvGwkgZH8zngD5kgjC+kc
         Dk2TSFgr4nX0yp2BaYEeFWn9OFoVxdWb4R23raMRt74DI/Ae/mGa/OagBXDYKtwrolaf
         EtCg==
X-Gm-Message-State: AGi0PubJxxneBXQ5uxXfwIA+crxC4WuzFHK04ahYuvyhnIM28XV4DfVY
        Rs/Ww2WItpebE3f6/2xRpuxsxvygigY=
X-Google-Smtp-Source: APiQypI3bgpsf6NyZWZAQ8r0/769JSCCX+QHgzA9bc4Qa7g+ucrx8VGnzz4yxXwGVvOLUM6um4f/Bw==
X-Received: by 2002:aa7:87c1:: with SMTP id i1mr1812154pfo.44.1585614853766;
        Mon, 30 Mar 2020 17:34:13 -0700 (PDT)
Received: from localhost.localdomain (c-73-231-41-185.hsd1.ca.comcast.net. [73.231.41.185])
        by smtp.googlemail.com with ESMTPSA id g4sm11170906pfb.169.2020.03.30.17.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 17:34:13 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     yixiang@google.com, caiz@google.com,
        Sonny Sasaka <sonnysasaka@chromium.org>
Subject: [PATCH] tools/hciattach_ath3k: Load BT board data based on country code
Date:   Mon, 30 Mar 2020 17:33:55 -0700
Message-Id: <20200331003355.14614-1-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

BT board data file PS_ASIC-<country-code>.pst is loaded based
on country code. If not exist, default BT board data file
PS_ASIC.pst would be loaded.

This patch doesn't define how to get the country code at the moment, but
future patches can supply the country code in the region parameter of
get_ps_file_name.
---
 tools/hciattach_ath3k.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/tools/hciattach_ath3k.c b/tools/hciattach_ath3k.c
index d920050f6..eb2a2aeb6 100644
--- a/tools/hciattach_ath3k.c
+++ b/tools/hciattach_ath3k.c
@@ -29,6 +29,7 @@
 #include <string.h>
 #include <ctype.h>
 #include <time.h>
+#include <sys/stat.h>
 #include <sys/time.h>
 #include <sys/types.h>
 #include <sys/param.h>
@@ -573,20 +574,33 @@ static int ps_config_download(int fd, int tag_count)
 	return 0;
 }
 
-#define PS_ASIC_FILE			"PS_ASIC.pst"
-#define PS_FPGA_FILE			"PS_FPGA.pst"
+#define PS_ASIC_FILE_PREFIX		"PS_ASIC"
+#define PS_FPGA_FILE_PREFIX		"PS_FPGA"
 
-static void get_ps_file_name(uint32_t devtype, uint32_t rom_version,
-							char *path)
+static void get_ps_file_name(uint32_t devtype, uint32_t rom_version, char *path,
+								char *region)
 {
-	char *filename;
+	char *file_prefix;
+	struct stat st;
 
 	if (devtype == 0xdeadc0de)
-		filename = PS_ASIC_FILE;
+		file_prefix = PS_ASIC_FILE_PREFIX;
 	else
-		filename = PS_FPGA_FILE;
+		file_prefix = PS_FPGA_FILE_PREFIX;
 
-	snprintf(path, MAXPATHLEN, "%s%x/%s", FW_PATH, rom_version, filename);
+	if (!region)
+		goto default_ps_file;
+
+	snprintf(path, MAXPATHLEN, "%s%x/%s-%s.pst", FW_PATH, rom_version,
+			file_prefix, region);
+	if (stat(path, &st) == 0)
+		return;
+
+	perror("PS file with region code not exist, use default PS file\n");
+
+default_ps_file:
+	snprintf(path, MAXPATHLEN, "%s%x/%s.pst", FW_PATH, rom_version,
+			file_prefix);
 }
 
 #define PATCH_FILE        "RamPatch.txt"
@@ -823,7 +837,7 @@ static int ath_ps_download(int fd)
 		goto download_cmplete;
 	}
 
-	get_ps_file_name(dev_type, rom_version, ps_file);
+	get_ps_file_name(dev_type, rom_version, ps_file, NULL);
 	get_patch_file_name(dev_type, rom_version, build_version, patch_file);
 
 	stream = fopen(ps_file, "r");
-- 
2.17.1

