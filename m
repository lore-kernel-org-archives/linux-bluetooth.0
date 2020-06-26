Return-Path: <SRS0=vuCz=AH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF872C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Jun 2020 20:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F37F20720
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Jun 2020 20:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C+Q859+l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725823AbgFZUxM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Jun 2020 16:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgFZUxM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Jun 2020 16:53:12 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB19C03E979
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2020 13:53:11 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id v1so6179160vsb.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2020 13:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F28DKKzLmbR7W73UOUFS8FIZyK/mYYGjEUVIdBnpyC8=;
        b=C+Q859+lsX0buzzJl3WTARLJc6834nPZxLq4uL9mnv7kXzJsp/jEo+kjLiXxYuGg5a
         wRxn82t0r4YmP9iPQFPbwj0L3JKlkKflBxFSRqdV0QfQINizYTKQUsxtrauF4GUmFSWM
         k1LLW4UfmiMGHp1w5GiVJQa4F1CfQ659GcEpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F28DKKzLmbR7W73UOUFS8FIZyK/mYYGjEUVIdBnpyC8=;
        b=X8NK1KSwPgIp26AmwWLOavjwJJ81Xu25C49pS8MI9AWr+fGC0GAfxdHypIobI3ivT4
         PsrAmDEnl/BSd1CjJxI2Q9WMI7vmPhQbwEKQkQSGNO/t//wcvUioqqFdaDnftU04+WeW
         brheEeeWVh6BmYFAmO3f5Mkdp10w/LoihahJloFwERVslfO5G56PL/dTxPW9GOHeWhkK
         17qvr5omPuxHTAF28xF2SEEBfNl3s8Kp0laBS7Ui2f/lJSdiiLMhUseq9MTfD7/BTNvv
         4XcHVzssn2FxvXbrFN2ldNO76fw3oW9rkhW9xNQ3A2D1xePfgIQD45zNZNwHRueZWq+K
         mPxw==
X-Gm-Message-State: AOAM530dndYiHHJx0B3P92ynMcZmg4AHdZmwx0Xo6ogQQWPZ4hvGdXNP
        Kr600F9gi51RG111mZqc1Lh07DLySxM=
X-Google-Smtp-Source: ABdhPJyNOqJqdE6aKhNsM9Xvku5VKC3vR1BhBywuNwxxoixVCnjuFjTFfuIUqQS/acH0bjRiFKr9Xw==
X-Received: by 2002:a67:eaca:: with SMTP id s10mr3984018vso.58.1593204790787;
        Fri, 26 Jun 2020 13:53:10 -0700 (PDT)
Received: from alain.c.googlers.com.com (252.177.243.35.bc.googleusercontent.com. [35.243.177.252])
        by smtp.gmail.com with ESMTPSA id i203sm4299185vke.7.2020.06.26.13.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 13:53:10 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [BlueZ PATCH v1] profiles/scanparam: use configured scanparams when available
Date:   Fri, 26 Jun 2020 20:53:06 +0000
Message-Id: <20200626205306.803784-1-alainm@chromium.org>
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

 profiles/scanparam/scan.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/profiles/scanparam/scan.c b/profiles/scanparam/scan.c
index 9e8f57747..fd22b876b 100644
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
@@ -75,8 +74,15 @@ static void write_scan_params(struct scan *scan)
 {
 	uint8_t value[4];
 
-	put_le16(SCAN_INTERVAL, &value[0]);
-	put_le16(SCAN_WINDOW, &value[2]);
+	/* Unless scan parameters are configured, use the known kernel default
+	 * parameters */
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

