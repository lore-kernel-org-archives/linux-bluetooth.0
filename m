Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7F5C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Mar 2022 22:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345282AbiCWWlk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Mar 2022 18:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345294AbiCWWli (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Mar 2022 18:41:38 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB4D377EE
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 15:40:08 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id mr5-20020a17090b238500b001c67366ae93so7758937pjb.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 15:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=FMwbFQa5JHQe75eN4X8D/2kRfU5RTU2M/iRq1EKBwjk=;
        b=OYMwBDqTPNO8GyuQ80dCFEskMbxUjic7bnPds+7aFQQfWABsBtMugv4fjAWh8J6eFm
         n0RDNWFbFTVhqgJX1ZVv8Rnr5tCPIfrVvxPowInb+mduXE5LZQMgIFSLIeWZOIXPNVKa
         +5T7n2X2U9H7Quoj0HRJD9lhjOIlhQWwgPP3wfyWaQBkzi3a9UDcCp2j87sq/6D+GoDV
         +VknyMI7aA12bZ/tJlcWdWe3gOeiL35KvJRrYtfT1SZlQWiEI78A6+BQX2IhdrraTlz1
         GlT0rBWZnhUFswbTmaQTsG1n8WS2JvWIGeKBAGbb38WHFEZGaCa8cQoNQ/WEU/FfcFcT
         wS1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FMwbFQa5JHQe75eN4X8D/2kRfU5RTU2M/iRq1EKBwjk=;
        b=QFOXoSaa8oDAbC1KuwWaeAdptFxFmgq+G25ajhqZJVsHTXwNNTTtiaopOOt8kUImH4
         +k9VPsBfr8m6611U4qOXUIxnR5S9SueCfaN8PM5vgQ2PCtZC/ZRP912y3S/EW57QVN1/
         NmPrUJL6EfUEKL8esx6zrPRQ2a4osvJrMMedKmlkdvGW+aX+M9n9LxkUGClsxulVU6Ws
         0OmpXfVQjXIiQztt5A8NWaF4RTubkDOdy5/kWGz+NZysmgSzR3quS/P+ihjHq+C/x+fL
         4A8VMA8FAKSyRzy9hK5dIUHeIeQSDeeSzp651gayiesAwpx+RzdX+NdJva9slfGev3dQ
         x8sw==
X-Gm-Message-State: AOAM531e+hpG7LQOEBw+IsdvKIY0HGK+Xl8FSgFel0fkps+vKVMLkn8f
        AiM8NGojrGOk5Nf+0r0PQHICluJ7c7g=
X-Google-Smtp-Source: ABdhPJxIPMz576KDA9TefTQb1t+03xiwbNYyrhWs415yGDrht0uOyiXCCrsTZ69888XntsMrywusug==
X-Received: by 2002:a17:902:ac88:b0:153:a34f:5648 with SMTP id h8-20020a170902ac8800b00153a34f5648mr2396864plr.121.1648075207739;
        Wed, 23 Mar 2022 15:40:07 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id z14-20020aa7888e000000b004f79f59827asm825109pfe.139.2022.03.23.15.40.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 15:40:07 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 4/9] adapter: Don't use DBG in mgmt_debug
Date:   Wed, 23 Mar 2022 15:39:58 -0700
Message-Id: <20220323224003.3736525-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220323224003.3736525-1-luiz.dentz@gmail.com>
References: <20220323224003.3736525-1-luiz.dentz@gmail.com>
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

