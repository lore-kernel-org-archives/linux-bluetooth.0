Return-Path: <SRS0=mBsK=AM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD913C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Jul 2020 13:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B01A220772
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Jul 2020 13:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M6pBiCWr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbgGANNe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Jul 2020 09:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729033AbgGANNd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Jul 2020 09:13:33 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC84AC03E979
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Jul 2020 06:13:33 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id k7so11905953vso.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Jul 2020 06:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YbCm4jyQ5Z7fswEhmWxi6mUhfjhFp3mrFc9hYHxgovw=;
        b=M6pBiCWrvV2QBMs3+8N/FzDlXAqLjhywAUpZIWBrkTzkJZw0UinfcgnTUQhP2zdOn7
         B8o6/qbIB+3iw96obrSBOhTUQiTarMPAr/iLC3IxJi/Z1gZMKgyNt8gGWMHVOyej23cR
         2YWvYmi/W0APuQOZN1+2iZVSLg3H9KzxWOOco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YbCm4jyQ5Z7fswEhmWxi6mUhfjhFp3mrFc9hYHxgovw=;
        b=jQXgD26NV8rLgc9op9W7eIg9hQWvcKE2MDnWMh9bqVpKaHuWNjjsP6H8BfD5VLzYyM
         NTROrXhPqQsD2JRwXMxKuHqf4ZOqfVdCFvyuWuIeIWAba9/lgDvvyNujxG1LzII94YWI
         eGVPDyKqPvfWNoXwsZx4KTUvAFpL9oVvBWBfu0JoRA3+u2pj4fdNA4iTdV1Y4/70ZWwd
         U+Z0xqI1c7xrQcGcisBUVPLAluyt8l/7INxoAnJiHBedOcju/y5SeS7N9lvGhdsS8jTN
         jLqtJqdwRnK9lo9Y3hHY5DP7TZv86w1ZBAenNLW8KN7j15LzPGenzErLLOVceyX8QKbs
         no3g==
X-Gm-Message-State: AOAM53137d5SrZ2xAicPvg5XIRPaTgRH1zR3pMEVTfeac3kVnstqM2QU
        Pp33AdwRuwRBwf3yIDEvHM08bGK5ca0=
X-Google-Smtp-Source: ABdhPJySK84ybZGx4Gl6iAD5MZKPTQVkFMOWTZX4RIL6lMtK+SDlXd7V66qAYiB1Jd7UfwVVuNLyDg==
X-Received: by 2002:a67:e007:: with SMTP id c7mr18399151vsl.209.1593609212482;
        Wed, 01 Jul 2020 06:13:32 -0700 (PDT)
Received: from alain.c.googlers.com.com (252.177.243.35.bc.googleusercontent.com. [35.243.177.252])
        by smtp.gmail.com with ESMTPSA id y135sm949458vky.15.2020.07.01.06.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 06:13:31 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>,
        Miao-Chen Chou <mcchou@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Manish Mandlik <mmandlik@chromium.org>
Subject: [BlueZ PATCH v3] profiles/scanparam: use configured scanparams when available
Date:   Wed,  1 Jul 2020 13:13:28 +0000
Message-Id: <20200701131328.3835273-1-alainm@chromium.org>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch updates the scan parameter service to use the configured scan
parameters when available rather than the hardcoded kernel defaults.

Reviewed-by: Miao-Chen Chou <mcchou@chromium.org>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Manish Mandlik <mmandlik@chromium.org>

---

Changes in v3:
 - Addin Chromium/Gerrit reviewers

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

