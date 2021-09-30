Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF287C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Sep 2021 15:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 987A261881
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Sep 2021 15:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241618AbhI3PKe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Sep 2021 11:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235519AbhI3PKX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Sep 2021 11:10:23 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EA3C06176D
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Sep 2021 08:08:35 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id x12so6089771qkf.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Sep 2021 08:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starry.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Zx3qyaR37j4wXdnwlRWbmeWUYh81iDKYTvBCecmMAM=;
        b=cyuqYjAZdoCnO+z/fB5AvILx30nihYA9zEZoQYNszml+1DIGpBWd6UldJtvjsUC3nz
         tKxBl1Zk9Il5FsnsxNPcTLi0xxncFSJeCauhGGmRgn4kN9JxmuEIiw9BGZoKi1NJM+lT
         rhf4pMilUmYxwrpEQVf5qZLNJDgG0tm1Pou18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Zx3qyaR37j4wXdnwlRWbmeWUYh81iDKYTvBCecmMAM=;
        b=A5EZl/ZDPYzmQYHouGxsZWigjPadgRRZ3Hzkth4DlkDmZMSpiz3+vhmgvbbsgNsT6n
         yMAR4LbuhMzKOuIj3fQM3oEdHWatb/wDdSiT0gytG7D3vdkwZ5swqFBPS0XxFxWhGHL8
         GjSdZD59Sag0dq+EO5xjLfSbRoUiRocWMPwafa+miPq5r3QnW/7chKmeQ+diFHti4UW1
         RE5jd8oSJru/xoFtxu8J1sFfbTzYJmIYGI2eM9Pyff50/NVI+kN1KguTXk33/9U2Y5md
         y9lWJx9TU41fI7UOl3qsUDtX8MFr6FLDAb8laXUdqj7ZpLFrYpOgh/b+f72p4/zg7+WJ
         k4YQ==
X-Gm-Message-State: AOAM530uvVIJgNDyu0uHAF8u2QQA67g4P3/xFwL9JVVsJ6Nl8kCoPB7Y
        e1cIeKByXkyCTVEI6r64p4S49t6XkyN7luDZ
X-Google-Smtp-Source: ABdhPJziN6UYCHAKDauSyN/50t9j+JbaXpzAphM28PqxB9p+rlculWGBCMfRgGJiVrXaIjdxvnqW9A==
X-Received: by 2002:a37:8747:: with SMTP id j68mr5107442qkd.165.1633014514988;
        Thu, 30 Sep 2021 08:08:34 -0700 (PDT)
Received: from MrComputer.nevonetnext (205-201-16-55.starry-inc.net. [205.201.16.55])
        by smtp.gmail.com with ESMTPSA id w17sm1573741qkf.97.2021.09.30.08.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 08:08:34 -0700 (PDT)
From:   Dagan Martinez <dmartinez@starry.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Dagan Martinez <dmartinez@starry.com>
Subject: [PATCH BlueZ v3 2/2] doc/gatt-api: Add 'X-notify`/`X-indicate`
Date:   Thu, 30 Sep 2021 11:08:19 -0400
Message-Id: <20210930150819.34270-3-dmartinez@starry.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210930150819.34270-1-dmartinez@starry.com>
References: <20210930150819.34270-1-dmartinez@starry.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Update docs to reflect the addition of the `X-notify` and `X-indicate`
permissions, which allow a GATT server to restrict CCC write permissions
via permissions set on its associated characteristic.
---
 doc/gatt-api.txt | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
index 120b23d1a..af0aa761d 100644
--- a/doc/gatt-api.txt
+++ b/doc/gatt-api.txt
@@ -253,7 +253,14 @@ Properties	string UUID [read-only]
 			Defines how the characteristic value can be used. See
 			Core spec "Table 3.5: Characteristic Properties bit
 			field", and "Table 3.8: Characteristic Extended
-			Properties bit field". Allowed values:
+			Properties bit field".
+
+			The "x-notify" and "x-indicate" flags restrict access
+			to notifications and indications by imposing write
+			restrictions on a characteristic's client
+			characteristic configuration descriptor.
+
+			Allowed values:
 
 				"broadcast"
 				"read"
@@ -267,10 +274,16 @@ Properties	string UUID [read-only]
 				"writable-auxiliaries"
 				"encrypt-read"
 				"encrypt-write"
+				"encrypt-notify" (Server only)
+				"encrypt-indicate" (Server only)
 				"encrypt-authenticated-read"
 				"encrypt-authenticated-write"
+				"encrypt-authenticated-notify" (Server only)
+				"encrypt-authenticated-indicate" (Server only)
 				"secure-read" (Server only)
 				"secure-write" (Server only)
+				"secure-notify" (Server only)
+				"secure-indicate" (Server only)
 				"authorize"
 
 		uint16 Handle [read-write, optional] (Server Only)
-- 
2.31.1

