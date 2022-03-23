Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A9AC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Mar 2022 20:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344566AbiCWUPW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Mar 2022 16:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344550AbiCWUPR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Mar 2022 16:15:17 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2677655
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 13:13:47 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id mj15-20020a17090b368f00b001c637aa358eso7511961pjb.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 13:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=FMwbFQa5JHQe75eN4X8D/2kRfU5RTU2M/iRq1EKBwjk=;
        b=Ff4+xdsSUU5j5e9I6KpRT+CncE4oZDHADK+noSSQHXVPakCeGeHVpMIqpk4h3+KwJ5
         1vPyvxeSKMeJYtQlPzbaRqruXIaMAos3aVzefotcoCGTLPWVXvRZm9E4oJ5ma7rF3WgB
         Bq3BQ4RoTe2+rpnN9If310ZagaoR5oHqk7fJgo/V/2JsUdFqHSwKdfK7vCsxFZdpIMkY
         pzmlxvSXX9/2UQrxoUrE7sVsWYn5ulDbMJ/OdbhBGN4cWbzdhCs6s0USsPtMxWBjyWxi
         iDMYlLT/JfgCxor8/uBO6O2ZEXpoCFS/sYJJcM8s7pjQ90NUJkQV0ioy+lnQ/mY+123l
         3UIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FMwbFQa5JHQe75eN4X8D/2kRfU5RTU2M/iRq1EKBwjk=;
        b=MUdtfNWT52pTVz0WZHYDkMIYQK6hv9hSwkPz3xooWL+a0tzyb+WMf1+sF5QOyIcCrA
         a8KSGhIKoz9VLGh6iEONCwLUI5JafhtJEbhTUtFk9jR/jZ7vOjcBjCdmJOJqpfqCU5do
         PtbSFA1QQsiFfjLzpJhgGOI5A1vp4TcPhvDdud3ltIIbqISnE2prqpkLO9FjSysZi9Ey
         p+BPEEqFKFOCurOpCLdrc5XbYCeVs1dUrll+27v4m5p8WN6K4vq5RC/7v3DPU6zYCs88
         Mtq48fF8sjfrpkdcsvEDZ5gqYWvWi5/JW+rUGU1QGr4LN6dcQbFv+OY8s1DnpzJg7kie
         0XUQ==
X-Gm-Message-State: AOAM5303JFrr+236932gCqO4h7ww4NwyF0ynQIgpMD8NpZbr6ttMa6XI
        vArxw+4FMUP4TR9xY0ZwEcsi8vZ8Q4w=
X-Google-Smtp-Source: ABdhPJzQDSG9HrLsjhjtBEBZElLqJSS9mfDBCqrWIxoWHcjnbO3wXQZu2KwjGdQnjHZI8qQMoeuVdQ==
X-Received: by 2002:a17:903:2288:b0:153:bfbe:7354 with SMTP id b8-20020a170903228800b00153bfbe7354mr1836904plh.112.1648066426354;
        Wed, 23 Mar 2022 13:13:46 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id m4-20020a17090a7f8400b001bef3fc3938sm478361pjl.49.2022.03.23.13.13.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 13:13:46 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 4/9] adapter: Don't use DBG in mgmt_debug
Date:   Wed, 23 Mar 2022 13:13:36 -0700
Message-Id: <20220323201341.3596128-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220323201341.3596128-1-luiz.dentz@gmail.com>
References: <20220323201341.3596128-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

mgmt_debug callback is used to print debug strings from mgmt instances
which includes the file and function names so using DBG would add yet
another set of file and function prefixes which makes the logs
confusing.
---
 src/adapter.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 97ce26f8e..9f003346d 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -10327,9 +10327,7 @@ static void read_version_complete(uint8_t status, uint16_t length,
 
 static void mgmt_debug(const char *str, void *user_data)
 {
-	const char *prefix = user_data;
-
-	info("%s%s", prefix, str);
+	DBG_IDX(0xffff, "%s", str);
 }
 
 int adapter_init(void)
@@ -10342,8 +10340,7 @@ int adapter_init(void)
 		return -EIO;
 	}
 
-	if (getenv("MGMT_DEBUG"))
-		mgmt_set_debug(mgmt_primary, mgmt_debug, "mgmt: ", NULL);
+	mgmt_set_debug(mgmt_primary, mgmt_debug, NULL, NULL);
 
 	DBG("sending read version command");
 
-- 
2.35.1

