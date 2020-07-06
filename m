Return-Path: <SRS0=7cy9=AR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D54C433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Jul 2020 20:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FCD120674
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Jul 2020 20:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HwaG98fe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgGFUZi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Jul 2020 16:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbgGFUZg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Jul 2020 16:25:36 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A47FC061755
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Jul 2020 13:25:36 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d10so3743910pll.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Jul 2020 13:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QJK/v7CS6qpK7d2NGsWDNwIq2Zg5Zj/Jc/lazqa5Mqo=;
        b=HwaG98fe6K1/6kIWNzabVqHxk6u50+S0dVD5BXK6ptaw+INBnM0gGzLaAEKadOYfnK
         JaGhylFLHaJIVyqzZRaIngjbUjdMCgOXTVxNUoM0Z1jIEstmHZTmByVn8PwIZ1CXUsZL
         jxBY3YoiUW3xScK9B/SxKXMNQmbMxMZoL6vn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QJK/v7CS6qpK7d2NGsWDNwIq2Zg5Zj/Jc/lazqa5Mqo=;
        b=uQiIzfNtooWcGdudDijiVus9bL9BlwbckPceY3FP5TZDrDN/xCBm/bRNZTjVVaQnEq
         OvWu1cdRz9izHNbGLbBDzrDRifcTImFE4mkfqd3Yx8yHy7QEHb+vqvxoe0eYhHFWICDR
         BDrZq7XIE+/AYcSfD1WfhO0nxF//rbkQ6TTFKi/L2ey3xPKSO2cfDUCCIvBTNHPj5eXq
         zqrd9s61bbb9vVYSvsNtp304zKo0AxHvTD6k+4U8HDlTYYPhJjy5wtaKRNgD5uTx5c2j
         GbLh9uuIQXqGDSdqc9G7NEiJMn925oJmJgCdD8V2ozX+5lQRL23Xsdc2lf9cbdrGq59K
         A/Fw==
X-Gm-Message-State: AOAM532NpkEBjGxvrT+VFxoT0ecQdD0zM0OMsPP+EgL2hJ2UryGhBXm0
        t69wX/MckSA7jJLLhcq3NIcscA==
X-Google-Smtp-Source: ABdhPJxFVkbpydRsaYoZNDNe7dTasihd5IQ0YgRzpeJb/dmbK9n8z7KJwU0NI7iyY8PqKpzU7C30nw==
X-Received: by 2002:a17:902:7d8f:: with SMTP id a15mr2742106plm.37.1594067135735;
        Mon, 06 Jul 2020 13:25:35 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id n25sm3320226pff.51.2020.07.06.13.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 13:25:35 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org
Cc:     alainm@chromium.org, marcel@holtmann.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [BlueZ PATCH v7 5/6] doc/device-api: Add WakeAllowed
Date:   Mon,  6 Jul 2020 13:25:17 -0700
Message-Id: <20200706132503.BlueZ.v7.5.If391d18ed934a1d9c24d3f54e4fee3fded0b17ab@changeid>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
In-Reply-To: <20200706202518.1153647-1-abhishekpandit@chromium.org>
References: <20200706202518.1153647-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add documentation for WakeAllowed, which allows a device to wake the
system from suspend.

---

Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4:
* Renamed WakeCapable to WakeAllowed

Changes in v3:
* Added documentation for WakeCapable

Changes in v2: None

 doc/device-api.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/device-api.txt b/doc/device-api.txt
index 65d8fee37..4e824d2de 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -189,6 +189,11 @@ Properties	string Address [readonly]
 			drivers will also be removed and no new ones will
 			be probed as long as the device is blocked.
 
+		boolean WakeAllowed [readwrite]
+
+			If set to true this device will be allowed to wake the
+			host from system suspend.
+
 		string Alias [readwrite]
 
 			The name alias for the remote device. The alias can
-- 
2.27.0.212.ge8ba1cc988-goog

