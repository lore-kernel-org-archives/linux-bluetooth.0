Return-Path: <SRS0=jOg2=5D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C08C4332B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Mar 2020 21:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6DF92076C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Mar 2020 21:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2py525b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbgCRVvc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Mar 2020 17:51:32 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37067 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbgCRVvc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Mar 2020 17:51:32 -0400
Received: by mail-pl1-f193.google.com with SMTP id f16so94130plj.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Mar 2020 14:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Lg7nkN4mkSlGzt343AERUU8DxSDQ1y02ISUsPdPcwHY=;
        b=j2py525b4u7qXtRQcjGH8PvWFOuhkN+Hl3qf1SXXsNkQUK4hbJ2R8ZvFb1Dv2wNElO
         qvTZsBnOKCoQaGhsP15ewYhn/2GUKOy2hjpouDXA66UcmlGX5w5Ue05CMB1lN3OWiahf
         oqy21uXtJ07sefy4vgVqdXwn5xdmfcWXW2uy30EkviEhT4BPqDQGkhoJ4lohNzOJn0OI
         oj/5v8fOSiP7zOW4+wDwJVwSzOhyBrrFiRGYjjvRKtZKaldQKlPyVKAtujblw3SLVgIo
         pbEBOIBuNP1eUS+kkHI+zCnA8yigJZtsp6QDlAPxnStbqLyskjISQPC8xVowohsqUleW
         l5CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lg7nkN4mkSlGzt343AERUU8DxSDQ1y02ISUsPdPcwHY=;
        b=iunVRrUiUxYslQaTEbEUggwDCLdAKVHIK8pXqnPEi22iuybDMwNKi7HKAosGTNUYiZ
         5s4iPCtlY8JRkvzo+FBfO+NJqvjYCQ5mF0WE/4w+HafYDpgdDcif9YEOKUI70YF24Wjd
         Tj1gOo4Gn/ikmjfGgu8MTKhCJ+QNzeoQd3W5BhY8jInA58Psg6g0XwzxBmm7d65njNma
         g8qK499fWZvv3GIrP2sPpyaEANi2G19bTAKmXssHSflAhVEmuxbG0D9QNORcqbY9Q4lj
         Oa+MG6pT4saqsWuDFORU/ThwiPMVDehZi/1bU3847e2+H7YbEg6+LN22RqNi3a5U05Wg
         UUzg==
X-Gm-Message-State: ANhLgQ1tycqW+aP95CerUrryim6nIOYWQmvxsXM5fGiHVBF0l+55gihL
        jwS25777baCHaJySMrPQqnOlcM4F
X-Google-Smtp-Source: ADFU+vsKmUfJuGdbVN+B8ZoIfX0ODLQtOylzl6B4/rJiRIXJThJV26W3PUO5+2izMTOiX4aDc4dbdg==
X-Received: by 2002:a17:90a:a891:: with SMTP id h17mr274498pjq.182.1584568291096;
        Wed, 18 Mar 2020 14:51:31 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id r13sm83709pgf.1.2020.03.18.14.51.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 14:51:30 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 6/6] gatt: Enable connecting to EATT channel using Ext-Flowctl mode
Date:   Wed, 18 Mar 2020 14:51:24 -0700
Message-Id: <20200318215124.21880-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200318215124.21880-1-luiz.dentz@gmail.com>
References: <20200318215124.21880-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes use of BT_IO_MODE_EXT_FLOWCTL to connect to EATT channels.
---
 src/gatt-client.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index 20efb7ae9..a9bfc2802 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -2182,9 +2182,13 @@ static void eatt_connect(struct btd_gatt_client *client)
 
 	ba2str(device_get_address(dev), addr);
 
-	DBG("Connection attempt to: %s", addr);
-
 	for (i = bt_att_get_channels(att); i < main_opts.gatt_channels; i++) {
+		int defer_timeout = i + 1 < main_opts.gatt_channels ? 1 : 0;
+
+		DBG("Connection attempt to: %s defer %s", addr,
+					defer_timeout ? "true" : "false");
+
+		/* Attempt to connect using the Ext-Flowctl */
 		io = bt_io_connect(eatt_connect_cb, client, NULL, &gerr,
 					BT_IO_OPT_SOURCE_BDADDR,
 					btd_adapter_get_address(adapter),
@@ -2194,15 +2198,35 @@ static void eatt_connect(struct btd_gatt_client *client)
 					device_get_address(dev),
 					BT_IO_OPT_DEST_TYPE,
 					device_get_le_address_type(dev),
+					BT_IO_OPT_MODE, BT_IO_MODE_EXT_FLOWCTL,
 					BT_IO_OPT_PSM, BT_ATT_EATT_PSM,
 					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
 					BT_IO_OPT_MTU, main_opts.gatt_mtu,
+					BT_IO_OPT_DEFER_TIMEOUT, defer_timeout,
 					BT_IO_OPT_INVALID);
 		if (!io) {
-			error("EATT bt_io_connect(%s): %s", addr,
-							gerr->message);
 			g_error_free(gerr);
-			return;
+			gerr = NULL;
+			/* Fallback to legacy LE Mode */
+			io = bt_io_connect(eatt_connect_cb, client, NULL, &gerr,
+					BT_IO_OPT_SOURCE_BDADDR,
+					btd_adapter_get_address(adapter),
+					BT_IO_OPT_SOURCE_TYPE,
+					btd_adapter_get_address_type(adapter),
+					BT_IO_OPT_DEST_BDADDR,
+					device_get_address(dev),
+					BT_IO_OPT_DEST_TYPE,
+					device_get_le_address_type(dev),
+					BT_IO_OPT_PSM, BT_ATT_EATT_PSM,
+					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
+					BT_IO_OPT_MTU, main_opts.gatt_mtu,
+					BT_IO_OPT_INVALID);
+			if (!io) {
+				error("EATT bt_io_connect(%s): %s", addr,
+							gerr->message);
+				g_error_free(gerr);
+				return;
+			}
 		}
 
 		g_io_channel_unref(io);
-- 
2.21.1

