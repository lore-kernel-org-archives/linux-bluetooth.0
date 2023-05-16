Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7AFAC7EE23
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 May 2023 20:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjEPU7x (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 May 2023 16:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjEPU7t (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 May 2023 16:59:49 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCD57DA2
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 May 2023 13:59:42 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1ab032d9266so1497535ad.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 May 2023 13:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684270781; x=1686862781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=snsIh1JCug494E4XD1/7+IMFy8d87x2K49j41pEQYIY=;
        b=SgLRtvhqZJxlZm/3ped8yBKURi1qJit0oUal9gcCbG2fKnSWZBeJmXzKweAxTegRrd
         kXfkAyFpx3qHkzzioUyuPYvbp7u8eRduyTo+nEMgymT8OfnB9kaWmCbZEHV0yn2RxcyN
         dkCv2II2ScQMokzmeWNIeuku5rKjXreESJUUtSTt/zLw5yPRxJMzSzus0OappVjyDuYP
         qDbwevhqPquMS9LO8+vEfSaynIYjeJlEDHe5+STVSSkdcoUUMzLHYma1dT4zbLsflcVp
         gCXHJpGfNuayNn+jdmnWRVlZHNarBkx7DuQUDED4bRD9B1pdQfyct0xeI7fRH8ednXKE
         NFtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684270781; x=1686862781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=snsIh1JCug494E4XD1/7+IMFy8d87x2K49j41pEQYIY=;
        b=SfGwYH/KDVOgSylfTAUA33H0mw/GsoYRHlJft5y8C44958NWR+HPTMAxBbWC9d0hjM
         I1P8zUIkcIqQCYtDbhx3cKIDkPfyasy3GVX4W4oyWlHUjfJBEd+JpnXXJlU1qlhx0Pie
         CpjGFKh4mXGW5KseQNsqH7iqJUnvc4xSdd1OT7/NWf0dctiny/M2zY2CfTzIBetlHdyk
         3/+yuIFXqu2/jrEYjP4ozGWhIICt+YhHxlq/ZGCb7iCuG0Kt/HiQzPg5EHWoSb5+Ok2A
         H+YaSaqtY2zIJHaQkBtaMVkIzV8LXBA1bZwkXrsxaLt0/4HHZeTjwHN1z2F/pbQck8a5
         +E5w==
X-Gm-Message-State: AC+VfDw5xF1sK8fnn31D7JprP0QlYcYglvsHxCfC77QRi8vp7fIrq69o
        99Grp2NCX0zq9FifqCPNkzEkmnyblJ4=
X-Google-Smtp-Source: ACHHUZ7+nWbBeQvMVTIpsoT90AgD4mcEMWy5c2r4mQsTmj3ZxBTzKAWAbsneioeDU5Bgik4MqwUYQg==
X-Received: by 2002:a17:903:32cc:b0:1ad:cba5:5505 with SMTP id i12-20020a17090332cc00b001adcba55505mr27122774plr.14.1684270781100;
        Tue, 16 May 2023 13:59:41 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id t16-20020a1709028c9000b001acad024c8asm14272237plo.40.2023.05.16.13.59.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 13:59:39 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 09/10] admin: Mark driver as experimental
Date:   Tue, 16 May 2023 13:59:23 -0700
Message-Id: <20230516205924.1040506-9-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230516205924.1040506-1-luiz.dentz@gmail.com>
References: <20230516205924.1040506-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This uses the btd_profile.experimental to mark the driver as
experimental.
---
 plugins/admin.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/plugins/admin.c b/plugins/admin.c
index 0787e8381ed7..68e9237d3fbd 100644
--- a/plugins/admin.c
+++ b/plugins/admin.c
@@ -618,13 +618,12 @@ static struct btd_adapter_driver admin_policy_driver = {
 	.resume = NULL,
 	.remove = admin_policy_remove,
 	.device_resolved = admin_policy_device_added,
-	.device_removed = admin_policy_device_removed
+	.device_removed = admin_policy_device_removed,
+	.experimental = true,
 };
 
 static int admin_init(void)
 {
-	DBG("");
-
 	dbus_conn = btd_get_dbus_connection();
 
 	return btd_register_adapter_driver(&admin_policy_driver);
@@ -632,8 +631,6 @@ static int admin_init(void)
 
 static void admin_exit(void)
 {
-	DBG("");
-
 	btd_unregister_adapter_driver(&admin_policy_driver);
 }
 
-- 
2.40.1

