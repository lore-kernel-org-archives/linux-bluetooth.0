Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09953C43217
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Mar 2022 20:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344564AbiCWUPZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Mar 2022 16:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344556AbiCWUPV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Mar 2022 16:15:21 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1ED38A31B
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 13:13:50 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id o8so2058467pgf.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 13:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=JQd7+rMFUQKBJW1Dugx9ash6Vc9jS9PWkT5mnwXt32w=;
        b=QtLFqSb3zcPnDFnpKUpG2vzQHW7T+AWIGWavqAJ1TGl1WPBLxelDhbmaO89T0eS7LR
         AXhjQyHsQceU/Q8QHluUUH3oUVwTw3OjJHptCKLWZ/L5aGsyAhJpBIbbFEC1RTYwuc3+
         lloRgBMcVvM2r+2SIBOYsnZMpxcVIUMe92fRU2vhrsbCZr+N5jkEvW4FjE6LdMlD21UT
         +salQU/wD5OVh0BpwXLQ38NZAU6VRrCuYh0l3kjjCA4OnNeSUwlJ+oZH+BQQleuZagSo
         vxZSP36wBpPCOOGQNHiUE3pHRqNG/UEpHMMnKt+eqYRJ2B+4g0aEutlC4I1rRm8YQk6g
         WuGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JQd7+rMFUQKBJW1Dugx9ash6Vc9jS9PWkT5mnwXt32w=;
        b=6gujcIfKxiSG2Payn86rWYzc4/Tt8sBhwIf6XRDQQ/RmZ8FdBdzN3CX9vJ7zPpJEzL
         nOnaP/Q1XgOPXkwd0hmS6c3sSwtZ/8UIndlwbhKUtMRUwHfdamwd8ZuEEwuQDy2lQEXZ
         4wcjUnaVa6lNUUGWumXk4BQyQn3r8OeYlDKGBwVc9DPd78vtjFlCnsd0/afhbKYvHmGe
         OuCBegS4LauiHk0cdcMApj2xH+clC+9QfqKXm9ATpe1HsH35kDuCWqg6uDahPmjdUaBe
         QiULwEdO074jqlWTL6ObiLLfl4wJLSMFF7RbQz7l/OGgLcYIe6j5eC1ZqCiwDFTrpTx+
         IPPQ==
X-Gm-Message-State: AOAM530UAA9larNAeqZpoz6fma2uvhID1B0qIuRwDQEigIBwbfEUjnEE
        hPf7j5riKo6ngwGT42UhQ/zbuzhNTOI=
X-Google-Smtp-Source: ABdhPJyaa4sK27w5t1aCNBfVH1SnMGrkSaEuxD/BXrzk7O9TLSscqLu7xW4nD9WcJAvtFgHO+7YDVA==
X-Received: by 2002:a63:4721:0:b0:382:70fa:479d with SMTP id u33-20020a634721000000b0038270fa479dmr1240455pga.259.1648066430230;
        Wed, 23 Mar 2022 13:13:50 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id m4-20020a17090a7f8400b001bef3fc3938sm478361pjl.49.2022.03.23.13.13.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 13:13:49 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 9/9] device: Don't use DBG in gatt_debug
Date:   Wed, 23 Mar 2022 13:13:41 -0700
Message-Id: <20220323201341.3596128-10-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220323201341.3596128-1-luiz.dentz@gmail.com>
References: <20220323201341.3596128-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

gatt_debug callback is used to print debug strings from bt_att which
includes the file and function names so using DBG would add yet another
set of file and function prefixes which makes the logs confusing.
---
 src/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index 3992f9a0c..381faf91c 100644
--- a/src/device.c
+++ b/src/device.c
@@ -5545,7 +5545,7 @@ static void gatt_client_service_changed(uint16_t start_handle,
 
 static void gatt_debug(const char *str, void *user_data)
 {
-	DBG("%s", str);
+	DBG_IDX(0xffff, "%s", str);
 }
 
 static void gatt_client_init(struct btd_device *device)
-- 
2.35.1

