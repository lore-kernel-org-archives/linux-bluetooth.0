Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60C6C4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3560610FA
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240325AbhHMMUl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 08:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240299AbhHMMUj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 08:20:39 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7DBC0617AE
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:20:12 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id n20-20020a2540140000b0290593b8e64cd5so9016284yba.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QwJGZ6YFLicAPJkwwIPCz7HAsuEhJaNimEfVks76qOY=;
        b=S4RQjcNt9ukj8pLoUcaBEGDrX3ehidLEZX8maqM8AsLMmWZv72gIy5taaK+aaSBqIh
         yfcsITaE7a5/R3e3QMDTNaiM4izRXa3ymXZNh38HtYMjlPxhuDrqpnaHkRals6kM6Jxa
         ssJRuf7jgIm9Y9NKWv8EuiMhB3QMmuNyWIPuMcv4nxR7ePU+e1vpSxEc/giFvB+yiZ/y
         cmbxm2AnqGwiaitI8652oOZmE1GQh2ho25lTMgVIbPx34tFjAqbCM8CqjWBT9NQM3mDC
         j9i4uzX4SqVQDThuGVRHF8Y/L1W5T9G4Rtj0L/qL3EyN1w2nKnBn8nr3Kr1zhw54o8OE
         vtgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QwJGZ6YFLicAPJkwwIPCz7HAsuEhJaNimEfVks76qOY=;
        b=ADyDBKuihV1dO9nXZwOe9vYVSXKt2AzkQFxfD3TrlP6NZyX/MTwC+1Al7CayAvyQV7
         NmYA+V8qDSsp5crmCQTMr0g8h6fYaS5FGyrlMUrZjJOhgKdKWxYkmSQdmQzAoV8dlPOL
         902itrufdS8c/ppU20KHrgbEBt76I2ii9aF5DDjX5lWSkl7UCgYdPMxeGsJTZdiR6js7
         6NcuNs2dN508sb9SQrUPhc51cfH5k391iffpRAsp1XXB4KzGNbFUD21BQWVB0kQ0jXMS
         u8cLuHDDZRsd6N2eY62/f0y7Pa2UbNaGAhU2GiibXKYej98arLtmdMqwWRSehq/bH6Eu
         vduQ==
X-Gm-Message-State: AOAM533h8/rdqZB0osYPMtBKsPunB3lDTfef/+LEOBJHY4Cq8ArCLcEG
        Tg6IankszwvlibFCkzd6i3aeD4Se7gMIvCYL3BYm1X6yenJi8RbMxqR4jmPVDnhJ2YQLhizbzo9
        DVFYip2MnPiVsgYl5Ym1MhWJwNLHoITU1xhI//lWVOb5PdRuoHDumhl91sBOIVyOICVuKuZGvR4
        VN
X-Google-Smtp-Source: ABdhPJwnXxLUWNPgdIBcDO/mbabXTDePGcexoeJ9Ftv+xdzBK3dwDcoWZGh4eDomZV5yee1Djo0dHmvAuNin
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:b68c:ff41:db76:21e9])
 (user=apusaka job=sendgmr) by 2002:a25:cf08:: with SMTP id
 f8mr2618119ybg.188.1628857211796; Fri, 13 Aug 2021 05:20:11 -0700 (PDT)
Date:   Fri, 13 Aug 2021 20:17:55 +0800
In-Reply-To: <20210813121848.3686029-1-apusaka@google.com>
Message-Id: <20210813201256.Bluez.10.I42dbaec328499fe2c304308bd098c08535e4e93b@changeid>
Mime-Version: 1.0
References: <20210813121848.3686029-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [Bluez PATCH 10/62] shared/ad: Inclusive language changes
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

"peripheral" is preferred, as reflected in the BT core spec 5.3.
Also prefer to use "reject list", as reflected in
https://specificationrefs.bluetooth.com/language-mapping/Appropriate_Language_Mapping_Table.pdf
---

 src/shared/ad.c | 8 ++++----
 src/shared/ad.h | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/shared/ad.c b/src/shared/ad.c
index d40d153316..27b76dc817 100644
--- a/src/shared/ad.c
+++ b/src/shared/ad.c
@@ -959,7 +959,7 @@ void bt_ad_clear_flags(struct bt_ad *ad)
 							data_destroy);
 }
 
-static uint8_t type_blacklist[] = {
+static uint8_t type_reject_list[] = {
 	BT_AD_FLAGS,
 	BT_AD_UUID16_SOME,
 	BT_AD_UUID16_ALL,
@@ -976,7 +976,7 @@ static uint8_t type_blacklist[] = {
 	BT_AD_DEVICE_ID,
 	BT_AD_SMP_TK,
 	BT_AD_SMP_OOB_FLAGS,
-	BT_AD_SLAVE_CONN_INTERVAL,
+	BT_AD_PERIPHERAL_CONN_INTERVAL,
 	BT_AD_SOLICIT16,
 	BT_AD_SOLICIT128,
 	BT_AD_SERVICE_DATA16,
@@ -1012,8 +1012,8 @@ bool bt_ad_add_data(struct bt_ad *ad, uint8_t type, void *data, size_t len)
 	if (len > (BT_AD_MAX_DATA_LEN - 2))
 		return false;
 
-	for (i = 0; i < sizeof(type_blacklist); i++) {
-		if (type == type_blacklist[i])
+	for (i = 0; i < sizeof(type_reject_list); i++) {
+		if (type == type_reject_list[i])
 			return false;
 	}
 
diff --git a/src/shared/ad.h b/src/shared/ad.h
index 84ef9dee9e..feb712f508 100644
--- a/src/shared/ad.h
+++ b/src/shared/ad.h
@@ -32,7 +32,7 @@
 #define BT_AD_DEVICE_ID			0x10
 #define BT_AD_SMP_TK			0x10
 #define BT_AD_SMP_OOB_FLAGS		0x11
-#define BT_AD_SLAVE_CONN_INTERVAL	0x12
+#define BT_AD_PERIPHERAL_CONN_INTERVAL	0x12
 #define BT_AD_SOLICIT16			0x14
 #define BT_AD_SOLICIT128		0x15
 #define BT_AD_SERVICE_DATA16		0x16
-- 
2.33.0.rc1.237.g0d66db33f3-goog

