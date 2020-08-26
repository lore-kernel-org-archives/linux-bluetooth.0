Return-Path: <SRS0=or7B=CE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48209C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Aug 2020 20:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 161062078D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Aug 2020 20:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="pizbHmMf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgHZUMO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Aug 2020 16:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbgHZUMM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Aug 2020 16:12:12 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F9FC061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Aug 2020 13:12:11 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 83so4358035ybf.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Aug 2020 13:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=PiO+YY0khA5TeZgvkhFxD4wUEHIs5J/uidiQhfjjKHI=;
        b=pizbHmMfeqvihtd8t1cNQqBIsYyUogMxW5O4L9a0DPNDgBbmnhX1t7DHuW52vzhYwj
         ui6K14R4iYx5yaGn6Kr2xS8DkcsfU8lFKZ9SKmDxST93VzUbAoFoUNr+B8/echB7u/gz
         1A2CJdEApG9s+IFCRHbF0mRmDJVjR9JCdkjuESIt7BXSbAgoIhy5H3dh32quM8+z4dbB
         RBMBEQzgItGatFsOvFFNurhodMH1lYQhE68y70MaBfc/PHStVuilq28LEenoPAh9Nemo
         q+ibzdhEEFwghlLPLac8IfQuIbLvYjVFAC0MfZS8tXnLl9NwbHFPS7qjj3BNEsFHtJn6
         sbxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PiO+YY0khA5TeZgvkhFxD4wUEHIs5J/uidiQhfjjKHI=;
        b=dIVcIA7pVe6h9M+MFvjrsmCcj+m2NKPEj3HAFH/aj9g3XADXUnytEikZrXUqO+CIY2
         i65enVc72dRBUFpIdknsMYQFL7A8DHBl4JtYVsshyf3mZRuz0a+5FnIT4JV88lHvC+Hi
         oCUTOslpZ1wpOdFXLjBhl/1ZDiZCDZdcr/WzAAriZkZzqI7LfiG06Z+BqAEn49HBkrlm
         KeCbsDHLliSk2X/ddwafaGM7VvvnkyEhzYpw7wfuDiYhGONGR1J6md0MvU3wsHNpHa53
         /16liFE4RbFsV9WXSKODY5m6ac/2cTsh3tPIXpgmoJOS2BWWeVmFAUBbHPnrFe6idEPi
         GvRw==
X-Gm-Message-State: AOAM531CaTaeCQqdY5lGKh8xFRepydbRF4yMvBG8wL4hpWxnM9PHxf6r
        cC9IxyyR/HpZG2AHdhpf5MTiPx7rEO0Bz5qJJNz3Tjg1Yq8DfWWbu5t3OFx1SoObWRZ0gtsjYB6
        Htl0NmgeiQo5Cv51QS63bEa93RYFtSeA6ol6s/f5G6x4giDdvHdiJbFzatBBn2VRMmcPAcYWd75
        ManLqQmGpElQ+6e6YU
X-Google-Smtp-Source: ABdhPJxBz0J3MpDNnC5E4A00S5fyZqViiRAu4wDtvy8dGetI66sZGNqLAWXrO/eDIEHHTMw8ANSC3BgAzpqC1SldgQ6S
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a25:e791:: with SMTP id
 e139mr25054480ybh.67.1598472730984; Wed, 26 Aug 2020 13:12:10 -0700 (PDT)
Date:   Wed, 26 Aug 2020 13:11:47 -0700
In-Reply-To: <20200826201147.1908411-1-danielwinkler@google.com>
Message-Id: <20200826131103.Bluez.v1.3.Ieb6522963e3f54b0d63dd88ed3ce24a8942ed73e@changeid>
Mime-Version: 1.0
References: <20200826201147.1908411-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [Bluez PATCH v1 3/3] PRE_UPSTREAM: advertising: Add adv
 SupportedFeatures to doc
From:   Daniel Winkler <danielwinkler@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Daniel Winkler <danielwinkler@google.com>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

 doc/advertising-api.txt | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt
index b0565eab2..0c07f349e 100644
--- a/doc/advertising-api.txt
+++ b/doc/advertising-api.txt
@@ -209,3 +209,21 @@ Properties	byte ActiveInstances
 			Possible values: "1M"
 					 "2M"
 					 "Coded"
+
+		array{string} SupportedFeatures [readonly, optional]
+
+			List of supported platform features. If no features
+			are available on the platform, the SupportedFeatures
+			endpoint will not be populated.
+
+			Possible values: "CanSetTxPower"
+
+						Indicates whether platform can
+						specify tx power on each
+						advertising instance.
+
+					 "HardwareOffload"
+
+						Indicates whether multiple
+						advertising will be offloaded
+						to the controller.
-- 
2.28.0.297.g1956fa8f8d-goog

