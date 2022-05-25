Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94647C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 May 2022 10:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233818AbiEYKuv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 May 2022 06:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbiEYKut (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 May 2022 06:50:49 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C101C6
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 May 2022 03:50:49 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id n10so19353157pjh.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 May 2022 03:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FIvnf+ov8MINP5sCQTpSgaYLBw6/bRB93NDP8cKBAHQ=;
        b=bxcT8rV9P0szfNen8/JZzsY2GRz13YcGxDatlSkoG7nwB6QBxfKUUI0TSnPEhhI1Ms
         MCQH1OCDcxtWCQwad35ezBWwTkADsEAn8JLhf8H7TNddUpd8KiJ8oup3k06xNFAzUP5B
         Y6kZS3MDU219Hd1ztcTCM/iGtrqOEYk3qUPNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FIvnf+ov8MINP5sCQTpSgaYLBw6/bRB93NDP8cKBAHQ=;
        b=8LacLHB8RxSR4IlJb3ICyOE4IjkeG8cJ44+fhGVy6GJPrY9iu2mX/2HkpQMe6bkqsX
         I0jEeXYH0fdrDSd8GNzYmzY8Uwt2ysLjPOe7zeSeKl3e+7g8l7/r4fSwOzl9NmIhKvEL
         OQoZCfO9UwYSne3fTpIKftKzZnUqCpQFKxVRUy+YhI+2A5jdMAsOXz0x5nQL2HCNyVXw
         JczrZWHUyLN/+sRTQxUxZ8tj36HzGyUM4lEBWYgV74mlFQlsJ+Yj2yMLFM6qcGuodZ5n
         OCBtoTm+rvTmnKrkvzK8r33zjQ7g8MiAYP3U8JhVDyEwXVc0zpG67Sxp7AHQypLK0oq7
         qLBw==
X-Gm-Message-State: AOAM532YR+MPY2TfzFX50jqBtUFPmVrFud6LQFCEh10hwGvFSmWbhzVE
        rXscMKwXKS1o3SmKpHDTCwLON3yvzpTiTA==
X-Google-Smtp-Source: ABdhPJwgziPS+PgkkFC/bjmFZ+VE0a90Bb9bcb1/ggDkuzCqjJIlT4glLgLQ/lobIR1btt85+xqPqA==
X-Received: by 2002:a17:90a:1c02:b0:1e0:df7:31f2 with SMTP id s2-20020a17090a1c0200b001e00df731f2mr9964289pjs.222.1653475848502;
        Wed, 25 May 2022 03:50:48 -0700 (PDT)
Received: from localhost (174.71.80.34.bc.googleusercontent.com. [34.80.71.174])
        by smtp.gmail.com with UTF8SMTPSA id f1-20020a170902f38100b001635dc81415sm1072132ple.289.2022.05.25.03.50.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 03:50:48 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org, josephsih@google.com,
        Joseph Hwang <josephsih@chromium.org>
Subject: [BlueZ PATCH v5 8/8] monitor: packet: add missing decodings of MGMT commands to todo
Date:   Wed, 25 May 2022 18:50:15 +0800
Message-Id: <20220525105015.2315987-6-josephsih@chromium.org>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
In-Reply-To: <20220525105015.2315987-1-josephsih@chromium.org>
References: <20220525105015.2315987-1-josephsih@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds the missing decodings of MGMT commands to
btmon --todo.

---

(no changes since v4)

Changes in v4:
- This is a new patch that adds the missing decodings of MGMT commands.

 monitor/packet.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index 33b1f2fea..11f7fe87f 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -14901,4 +14901,13 @@ void packet_todo(void)
 
 		printf("\t%s\n", le_meta_event_table[i].str);
 	}
+
+	printf("MGMT commands with missing decodings:\n");
+
+	for (i = 0; mgmt_command_table[i].str; i++) {
+		if (mgmt_command_table[i].func)
+			continue;
+
+		printf("\t%s\n", mgmt_command_table[i].str);
+	}
 }
-- 
2.36.1.124.g0e6072fb45-goog

