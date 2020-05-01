Return-Path: <SRS0=Zhcm=6P=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0772CC4724C
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 May 2020 19:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D67562166E
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 May 2020 19:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JYnMzK9/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgEATYx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 May 2020 15:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726346AbgEATYx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 May 2020 15:24:53 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47601C061A0C
        for <linux-bluetooth@vger.kernel.org>; Fri,  1 May 2020 12:24:52 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id b14so2944150vkk.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 May 2020 12:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vEn0zZSD9I+UBw4CNybhhxcB1zw+HGnMfPHE7LkHszo=;
        b=JYnMzK9/f4kPLZN8OykIJhTmF18RJk2ptuK7pYxMYnl83Gpye7TB1vK96onuqXLVNp
         hlOXMygkxNyeOF8hVg5xlGRanpf+Jg1uNWbtUxRu/blZxUlPmuotBM/L66Eip0a4h1PZ
         9zhpNCbGJ9R9pDm1nRdm7Mznq459uss+PXpu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vEn0zZSD9I+UBw4CNybhhxcB1zw+HGnMfPHE7LkHszo=;
        b=UmcTkVlGqfvvXAF4B5B0GY0TIEnS6TdwxMVHhDGSZFdvL3vyJDA/gLRM0fG47TNete
         QUHbysII1oJSm9qPxazTFDXQEVBwq9seMVjyRC1/A3OnSbusxPVJyS0cCTcuVX7ywelS
         9buSI/RFquwLN7L1MjzoKErPd5z6WZpTLvoLr3ZvfqMxwIERbN0nujx1qmV7kA6ZUN71
         eQkF8HPxhMyG9zRj/qKM1PQZUMPdjpIiecrvQai2ygCTntMzvkAGc0y2accc14R9oHdx
         4u2BsrBIJUyfV7jVYcwGzFl+7HH1FvgqtCRxAc/xYzdp551np7d23fcL6zEAnh91+lLP
         sZvA==
X-Gm-Message-State: AGi0PuYkSH0zprMRsY3LakcIUydmGrddJM2AZP7qFNUUNM5Bqof+HT69
        icNjd5BnorlksAKiIFApkLgn3iXxz2g=
X-Google-Smtp-Source: APiQypKe9QjrJemNXHGy/zPSdalvFq88EHCSlkmJ1BFrSPJ9tiUnQhFeDAI1OXzlU3UIQy2FBnBeMQ==
X-Received: by 2002:a1f:2010:: with SMTP id g16mr4005844vkg.50.1588361090971;
        Fri, 01 May 2020 12:24:50 -0700 (PDT)
Received: from alain.c.googlers.com.com (161.138.243.35.bc.googleusercontent.com. [35.243.138.161])
        by smtp.gmail.com with ESMTPSA id r72sm1037348vkr.5.2020.05.01.12.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 12:24:50 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [BlueZ PATCH v1] shared/gatt-client:Fixing a few comment typos
Date:   Fri,  1 May 2020 19:24:47 +0000
Message-Id: <20200501192447.78757-1-alainm@chromium.org>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This change simply fixes a few comment typos.

---

 src/shared/gatt-client.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 963ad619f..c4a79eac9 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -642,7 +642,7 @@ static bool discover_descs(struct discovery_op *op, bool *discovering)
 		gatt_db_attribute_get_service_handles(svc, &start, &end);
 
 		/*
-		 * Ajust end_handle in case the next chrc is not within the
+		 * Adjust end_handle in case the next chrc is not within the
 		 * same service.
 		 */
 		if (chrc_data->end_handle > end)
@@ -651,7 +651,7 @@ static bool discover_descs(struct discovery_op *op, bool *discovering)
 		/*
 		 * check for descriptors presence, before initializing the
 		 * desc_handle and avoid integer overflow during desc_handle
-		 * intialization.
+		 * initialization.
 		 */
 		if (chrc_data->value_handle >= chrc_data->end_handle) {
 			free(chrc_data);
-- 
2.26.2.526.g744177e7f7-goog

