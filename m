Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 841B0C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Mar 2022 00:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240862AbiCWAI1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Mar 2022 20:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240861AbiCWAI0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Mar 2022 20:08:26 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8965DE5A
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Mar 2022 17:06:58 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id s11so109638pfu.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Mar 2022 17:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ZWwrOcoxBDXqjSVBr0WOOPq65eimqcjTTFuXG01fWSw=;
        b=FFDcxP7F/BAmV90G8UnrFkAqYaHJvGIABmomAZ82Mh4UTjrdzeryRWqcluETMrfXY6
         2PlWnLWEKghj6w3e7+whD31eZpZuOmnT+pk9qBcfQ2a4xH6WgQ5o+iYb9bAEJoeHj45X
         T4xa+XABI0FAlFXqI1GZU2gevxUpEwdU3ZfXCyoxpo/sLBTZriHHvhuMZCBTmhPAPOlH
         NtMypxQGXdSeWTJjP9ZnJ29gNk2S751x3gQAl+kTb3/YqIIXg0YUD67iojsPOvvDb+mn
         vJWopy1pBJA1RYDRiNVJMum5jl2oDx2+3LhLPf0N6BePqrASjhDOQzxe2soJHRqn5Asr
         RqJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZWwrOcoxBDXqjSVBr0WOOPq65eimqcjTTFuXG01fWSw=;
        b=MZ1aOyzmu519HP2TL9qnCZwY927vmxd+VV3isibJ1HegqzNbzgBug47PxMgCivYdiW
         PjbO1qSgm/ZUb+CxU3HJAcQ2vuX3BvXbhgfGK/PIGdkReCvOIJoYkf1lRlAEUWUUjCay
         OavK45i1QKKeswo4Axpm7A1J9dsYrk4nf8OzdekgGbq13wvKCJjndQ4JiC3vzuWzQuJI
         3CmkVVImpWpSmXiLbHzWTpuFD8+JTSzHFKzl5CelBpmpgU0CTdoeei+Zhv4QxvE/0Cur
         SxTVfyNR5kDmV5WFHG3JGqb9CQTTHXdd+/3J11OP4mvE5vfMzAXyUJACXMBP0ne7EdSp
         r/Sg==
X-Gm-Message-State: AOAM530wpyGycdOGfSgHxyxm5uawHXd3GRpAKe2iEEZSyPRmQAU6yjt7
        l2S5WAhjVz2E0yGLWT6bNngKD0uwAnM=
X-Google-Smtp-Source: ABdhPJzLSVvyK2OJBKP8uZgbMjxt+nRX0L52FZGTS7TakTwPArLextq5+L8zqqJBzA6HGCFUPqw3fQ==
X-Received: by 2002:a63:df14:0:b0:381:309f:10bc with SMTP id u20-20020a63df14000000b00381309f10bcmr23756132pgg.77.1647994017634;
        Tue, 22 Mar 2022 17:06:57 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id bx22-20020a056a00429600b004fa936a64b0sm10098423pfb.196.2022.03.22.17.06.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 17:06:57 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 4/9] adapter: Don't use DBG in mgmt_debug
Date:   Tue, 22 Mar 2022 17:06:49 -0700
Message-Id: <20220323000654.3157833-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220323000654.3157833-1-luiz.dentz@gmail.com>
References: <20220323000654.3157833-1-luiz.dentz@gmail.com>
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
 src/adapter.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 97ce26f8e..6680c5410 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -10327,9 +10327,8 @@ static void read_version_complete(uint8_t status, uint16_t length,
 
 static void mgmt_debug(const char *str, void *user_data)
 {
-	const char *prefix = user_data;
-
-	info("%s%s", prefix, str);
+	if (DBG_IS_ENABLED())
+		btd_debug(0xffff, "%s", str);
 }
 
 int adapter_init(void)
@@ -10342,8 +10341,7 @@ int adapter_init(void)
 		return -EIO;
 	}
 
-	if (getenv("MGMT_DEBUG"))
-		mgmt_set_debug(mgmt_primary, mgmt_debug, "mgmt: ", NULL);
+	mgmt_set_debug(mgmt_primary, mgmt_debug, NULL, NULL);
 
 	DBG("sending read version command");
 
-- 
2.35.1

