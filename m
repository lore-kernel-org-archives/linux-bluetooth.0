Return-Path: <SRS0=VvJN=D3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57AAC433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Oct 2020 10:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6469A222E8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Oct 2020 10:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VcRETzA+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405900AbgJTKDD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Oct 2020 06:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731657AbgJTKDD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Oct 2020 06:03:03 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF3BC061755
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Oct 2020 03:03:03 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id h64so1581395ybc.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Oct 2020 03:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=nA02zPDhqXkvEjhUAo1BE0ODEkXCr7IzalSy2WKifDw=;
        b=VcRETzA+Fp/20YfOBnpTbPbjcvNbtz7yFvLOUidu/+L+obb35q3axeXXFCfBUgIcJY
         sswMm4pOA+iVAnybkQSG5wHabP3W0fEp3QZUmzOBhCmBBD1QtoGJOgEXD+AgOsZtFIV7
         5NslKTBfD2xppezebntbmbc31gfcbhUUzMa+HZSnk5v1Udyyyr7udOkkdl5OSNv36sDQ
         2J48AQZUPvwA86ONzHsr6Tt7szRRNp5GgzmxDflX3zW/ch+UAvWwg42sExcRSocCzE9v
         KZ5y868/UB4HQ1I36QBuqSOxUK7rCc5/3k6nX0ZNsVUy0fIDvR/33qVlaurWYu+0ZugN
         cwWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=nA02zPDhqXkvEjhUAo1BE0ODEkXCr7IzalSy2WKifDw=;
        b=np+4DtnGJF2Gz1VJmBvemixCMz5O0G2WE39QzzYKhbMiY0DLVZk06W6iAju4MIlJZr
         7YIKC4M9BDvd/hfsCaELgDYOvT1g38TcFhH4cQ9WuNpf768tIPt8rHYGt4GicSGD6RbK
         kEDnlHUY8XndG4xDx2rLmR5zRNWcZUlGZ6p+rLGVYKiv48DKBHBFU2HCn8lEKEmqGWNL
         eap76FQZ+Yf8TIDmfMmxV1HdeszBcrnKulINZdDjv3dTlPn3Vh2i5UYo/7maJFmLgeTn
         FuZ6f0CBe2VVr3QRCrU1Noy0/lYqnw0F/vH5HcuczXUO2gP6DyyKnjiQeafVDC5K7UkJ
         jmPg==
X-Gm-Message-State: AOAM530YJlubyGQiyd2bG/+2T3lqhEhSGLrZ2oM57ED3+h0pZ2ImC73q
        /Rx0tKebKKTP7m2eLD0vIECOPfZpq69MAtXmhU/IrGwGYgS6CfyXY5ie+aWZynTQWjXNuamaouh
        1WfipvBmuZbjOEap/foJxEklJCfYfHC/Vu0FdJkQPHlZUpyeDn9/+sWGfvld+fPZ9iaUVMi9dBl
        a1
X-Google-Smtp-Source: ABdhPJw71JzD7U+K4KhZN7vj6PmcEh1+DUju7czW2ZTawULAd+F6uukH/PHFv6yISfKa08BBmryfBYQDEJLz
Sender: "apusaka via sendgmr" <apusaka@apusaka-p920.tpe.corp.google.com>
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:f693:9fff:fef4:2347])
 (user=apusaka job=sendgmr) by 2002:a25:a48a:: with SMTP id
 g10mr2875420ybi.197.1603188182541; Tue, 20 Oct 2020 03:03:02 -0700 (PDT)
Date:   Tue, 20 Oct 2020 18:02:45 +0800
Message-Id: <20201020180230.Bluez.1.I67bbd887ee5c0b214a77cb0ed8f9e1d3812ffe73@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [Bluez PATCH] device: fix temporary_timer double free
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Yun-Hao Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

One instance of freeing temporary_timer is not followed by setting
the variable to 0, causing potential double free.

Reviewed-by: Yun-Hao Chung <howardchung@google.com>
---

 src/device.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index a5ef467301..2800b276a2 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4477,8 +4477,10 @@ void device_remove(struct btd_device *device, gboolean remove_stored)
 		disconnect_all(device);
 	}
 
-	if (device->temporary_timer > 0)
+	if (device->temporary_timer > 0) {
 		g_source_remove(device->temporary_timer);
+		device->temporary_timer = 0;
+	}
 
 	if (device->store_id > 0) {
 		g_source_remove(device->store_id);
-- 
2.29.0.rc1.297.gfa9743e501-goog

