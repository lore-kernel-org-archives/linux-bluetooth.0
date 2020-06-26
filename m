Return-Path: <SRS0=vuCz=AH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B80C433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Jun 2020 21:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1A4620B80
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Jun 2020 21:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h/ravMbm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgFZVVK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Jun 2020 17:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgFZVVK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Jun 2020 17:21:10 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EBEC03E979
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2020 14:21:10 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id r5so6197748vso.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2020 14:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i2yR8hiOCqKBPRxQxN2j/vbMjOfgU5dGXPC5Q5uhEQ4=;
        b=h/ravMbm/n0/Bl9WqP84JtmoDEz+V6xrN56aIxNkkB8dP3n2zJDzG2VeQGsv0cZzMN
         A5kmQAVrK8ghlAOLaJd1PvZN3Bk8ipaNOJW9xcH92BcQx4XHWleg5KkXkk+KSIg0Tq6Z
         aA8okoyVU/zpDsf2PGfQydu5W8fvLRJoFQbwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i2yR8hiOCqKBPRxQxN2j/vbMjOfgU5dGXPC5Q5uhEQ4=;
        b=eGP5DLs1qrHFI6F/eK7b5ERdgY65GybgrirsSRV+6iWhqeI0y7lrYf/x4O0kKMv2MI
         yzYDmTNW65j3JHjIYZuCNybDFjM9mFRpriT82095sOvNOQDtyxE8eYuDJfQo8u4NReKh
         hE0eZ9NKsM9FmRwpjtyOIv1FkrKxk/aDy6wsZwhEaFEVekTWjKW/TKIAIna1sv1CUGYw
         nJzCW0G0CE2QEsyRcNomZSXjvSn+F+GvVpHwxQXQOvnmR7bHndG/SdXBghrPlSZmR+8F
         E+TrM6K8R8BMR19LCVb8+q3jKfYSU2DenPZ+PmnAUM/OXKtPHV7yvSoHuly7iyU0j7fS
         q/BQ==
X-Gm-Message-State: AOAM531fVewKEKWgMJs9MOQJP0P64WCxbpJEqrW6dpJHTxDuqfkt6oCV
        In5AQJSwGbdhC6VLNrKcXHVFHRSoY9o=
X-Google-Smtp-Source: ABdhPJyBqgtlZJbjCPSnsPJmi6iBuP+0A4cSOSxCpth834L/FTjXayp4W1lmO+derbGQJnfNyJKA2Q==
X-Received: by 2002:a67:2c07:: with SMTP id s7mr4331551vss.206.1593206468946;
        Fri, 26 Jun 2020 14:21:08 -0700 (PDT)
Received: from alain.c.googlers.com.com (252.177.243.35.bc.googleusercontent.com. [35.243.177.252])
        by smtp.gmail.com with ESMTPSA id h77sm305320vke.21.2020.06.26.14.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 14:21:08 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [BlueZ PATCH v2] profiles/scanparam: use configured scanparams when available
Date:   Fri, 26 Jun 2020 21:21:06 +0000
Message-Id: <20200626212106.807415-1-alainm@chromium.org>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch updates the scan parameter service to use the configured scan
parameters when available rather than the hardcoded kernel defaults.

---

Changes in v2:
 - Fixing checkpatch comment warning.

 profiles/scanparam/scan.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/profiles/scanparam/scan.c b/profiles/scanparam/scan.c
index 9e8f57747..d72be3dff 100644
--- a/profiles/scanparam/scan.c
+++ b/profiles/scanparam/scan.c
@@ -45,12 +45,11 @@
 #include "src/shared/gatt-db.h"
 #include "src/shared/gatt-client.h"
 #include "attrib/att.h"
+#include "src/hcid.h"
 
 #define SCAN_INTERVAL_WIN_UUID		0x2A4F
 #define SCAN_REFRESH_UUID		0x2A31
 
-#define SCAN_INTERVAL		0x0060
-#define SCAN_WINDOW		0x0030
 #define SERVER_REQUIRES_REFRESH	0x00
 
 struct scan {
@@ -75,8 +74,16 @@ static void write_scan_params(struct scan *scan)
 {
 	uint8_t value[4];
 
-	put_le16(SCAN_INTERVAL, &value[0]);
-	put_le16(SCAN_WINDOW, &value[2]);
+	/* Unless scan parameters are configured, use the known kernel default
+	 * parameters
+	 */
+	put_le16(main_opts.default_params.le_scan_interval_autoconnect ?
+			main_opts.default_params.le_scan_interval_autoconnect :
+			0x60, &value[0]);
+
+	put_le16(main_opts.default_params.le_scan_win_autoconnect ?
+			main_opts.default_params.le_scan_win_autoconnect :
+			0x30, &value[2]);
 
 	bt_gatt_client_write_without_response(scan->client, scan->iwhandle,
 						false, value, sizeof(value));
-- 
2.27.0.212.ge8ba1cc988-goog

