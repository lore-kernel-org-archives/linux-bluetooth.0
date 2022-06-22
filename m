Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2309BC43334
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jun 2022 22:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358340AbiFVW2N (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Jun 2022 18:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358301AbiFVW2L (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Jun 2022 18:28:11 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E47FC69
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jun 2022 15:28:05 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 23so11205802pgc.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jun 2022 15:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=BY74aJKawL8ZJHJdZMpTNWRQDCAFbo7G5NU4C+yjJ6Y=;
        b=jfstvvb869LNps0K8YXch6lAZuaU3gYFNvdBUD1afQTPhpG9MitdoTb3CYxO8IhILY
         yaJD4uaypCSyyq4Iw7EIUonEfLEAW09u67vDcNP1gCFFjWCjCNRXy/SouFJrITsp3cYi
         C3ncB7Ie1h3yWJavt4UsZvRBz73c2aJMh78iJS8nyHyXcjMbw7YC5urvDNbiYXCz4V3W
         8JkClWaJTwuV8qMy+uL3T1eWmu5kC33IhcMRRlsqAO+s7oBTv5PLXIh/U2AF5Qlt27mJ
         fu2BHDqwOcdfPYOSOoY6qi43VBz6H5rAEI2DziYMIYbkc6FGDJlsrCr2BCNB7gi6PsK1
         gUtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BY74aJKawL8ZJHJdZMpTNWRQDCAFbo7G5NU4C+yjJ6Y=;
        b=6D+xOOzc4Ae6OjBj++Pk1KS0IU7o4nBj2N6ZE7jqv+e46Rd7NnTTXe3PHmy7JIafHQ
         azKwnCcx0epe4NlsblVSwVbDUNYluO0JGYCBhCas2/dgLjj04Tk/XWbXYC1R8JWSDfu5
         3TX6StVwvAEN0kmFSo6AHDD2oCDIRZOOCN3Kiwj7JrddhEx/ur8FgMqBrKrfTOJngcGK
         49yNIL6CLQBDcJ1R2Ou6BOpMNoMDCFue2jMgyegHeGl9c04SWmBGp7gdNXE9E0sM7aFQ
         GBBrwcsoy++Gx/fDaCryH8gZUl6wZ55uZDllxQpd6VXZyJeKRHs4FjFBsfeic7V8FlgH
         ujGw==
X-Gm-Message-State: AJIora8gJngRJCXkPIIWST/pxaQfN8hhBJET0RMoMbjwGdpgJS3ewpKo
        kXv7DXgrieaZb5m0HALwzTLxsG+nMbwM0w==
X-Google-Smtp-Source: AGRyM1sWTjM0qyRwcuSqGXEdKlJcPXaP6WNL5CdyL6kI/Df/9BAtQfHNj9vEhWWwZ/ePnDA7Cph39g==
X-Received: by 2002:a62:3302:0:b0:524:e839:c3b8 with SMTP id z2-20020a623302000000b00524e839c3b8mr28127444pfz.76.1655936884446;
        Wed, 22 Jun 2022 15:28:04 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id x10-20020a1709028eca00b0016368840c41sm11710482plo.14.2022.06.22.15.28.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 15:28:03 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v7 2/8] shared/util: Decode BlueZ Experimental ISO Socket UUID
Date:   Wed, 22 Jun 2022 15:27:55 -0700
Message-Id: <20220622222801.2676431-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220622222801.2676431-1-luiz.dentz@gmail.com>
References: <20220622222801.2676431-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds BlueZ experimental ISO Socket UUID to uuid128_table so it is
decoded by the likes of btmon.
---
 src/shared/util.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/shared/util.c b/src/shared/util.c
index 33196bf8b..b74a005ce 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -1149,6 +1149,8 @@ static const struct {
 	{ "330859bc-7506-492d-9370-9a6f0614037f",
 		"BlueZ Experimental Bluetooth Quality Report" },
 	{ "a6695ace-ee7f-4fb9-881a-5fac66c629af", "BlueZ Offload Codecs"},
+	{ "6fbaf188-05e0-496a-9885-d6ddfdb4e03e",
+		"BlueZ Experimental ISO Socket"},
 	{ }
 };
 
-- 
2.35.3

