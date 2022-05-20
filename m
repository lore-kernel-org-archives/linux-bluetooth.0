Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7EF8C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 May 2022 04:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234128AbiETERJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 May 2022 00:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234070AbiETERG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 May 2022 00:17:06 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578C86B671
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 May 2022 21:17:05 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id h186so6749737pgc.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 May 2022 21:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=H846IO+fjJ5R46JqSkbj1tpySM3tu5H6t+OYD86b50Q=;
        b=HMJFGHxi7/CSmtHb+ntD0dJK5IZCryBRflgf2uqBVWox65ZsqOYsyHBAluHx6pVRtK
         ZqSyVNXtZEGHakkR0LxRTgkXdSIheWGW2AHmxrwecd8WVFuc8BpgFtPUUDvHitz/KCg1
         dd20QFLBvqsmcY+Y9qTiJonX4wDBPxHzpOAsha43s5lzeWG0oNoCt1vVgrAVwOOUWITv
         4P6Zf5a0oFawG45baTSgG8pcBHKuZJ8iB3Yp4wqkzXn+o/M3gDBCf2TfBWLka6ETlG06
         eikHxNXsMVdRDbbn7SO/8BfqFPE9gwvb5rYbAmtH/vtZhi3t1vkFf4vCWTyhFT64fmqZ
         rWHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H846IO+fjJ5R46JqSkbj1tpySM3tu5H6t+OYD86b50Q=;
        b=Owc+bTCgdnDW1cL4T4quskqzEM0erPYhWJskWhfUOnt7+0g3THWOG7iwI2iHlcKUwO
         tljDz+gzDu8jE//LHkywLXV3Gp3ED3yIXd+lwVSCn/AWl/rZwFHVc9+piw/cylb4f5Zt
         P4at4cTb6X04HCpfcsThOvorWZiA/aVgTN5J6mSceGVa9orecq1SyXVmmXTtHCbXPkHM
         aVbxXhVw1ZM2MtRtYMV4b65qzpb4jQ5hGrBLyAVDHAo5yb2vRp/9N9+7rRAQdwWsjwmq
         SLKLyab1eytFAcf87ZcDO+EW4G/MhMRqtp/iE8tIsdPgSu9tzryU7Iwq2d1r2Njqoahx
         BwTw==
X-Gm-Message-State: AOAM530bCgz8j7ThmrbMBNUe1WJK8KP4L4/3sSjEgOzgsVN9tW6Tfeor
        8mdnvSWAKkqLBApbv8wCVZnzedOxeCc=
X-Google-Smtp-Source: ABdhPJyVmZ5y9DBIUgOEj1ZoZHxUhGyc+w9Y6lSmYRnwjifEvLzsgVAyeMYo8E7kJDEcVBcr57yRfQ==
X-Received: by 2002:a65:6e88:0:b0:382:3851:50c8 with SMTP id bm8-20020a656e88000000b00382385150c8mr6948098pgb.270.1653020224528;
        Thu, 19 May 2022 21:17:04 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id u13-20020a17090a450d00b001df955c28f6sm381405pjg.37.2022.05.19.21.17.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 21:17:03 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/7] monitor: Move print_hex_field to display.h
Date:   Thu, 19 May 2022 21:16:57 -0700
Message-Id: <20220520041701.2572197-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220520041701.2572197-1-luiz.dentz@gmail.com>
References: <20220520041701.2572197-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This moves print_hex_field to display.h and removes the duplicated code
from packet.c and l2cap.c.
---
 monitor/display.h | 14 ++++++++++++++
 monitor/l2cap.c   | 14 --------------
 monitor/packet.c  | 14 --------------
 3 files changed, 14 insertions(+), 28 deletions(-)

diff --git a/monitor/display.h b/monitor/display.h
index be5739833..5a82f8e6f 100644
--- a/monitor/display.h
+++ b/monitor/display.h
@@ -76,6 +76,20 @@ static inline uint64_t print_bitfield(int indent, uint64_t val,
 	return mask;
 }
 
+static inline void print_hex_field(const char *label, const uint8_t *data,
+								uint8_t len)
+{
+	char str[len * 2 + 1];
+	uint8_t i;
+
+	str[0] = '\0';
+
+	for (i = 0; i < len; i++)
+		sprintf(str + (i * 2), "%2.2x", data[i]);
+
+	print_field("%s: %s", label, str);
+}
+
 void set_default_pager_num_columns(int num_columns);
 int num_columns(void);
 
diff --git a/monitor/l2cap.c b/monitor/l2cap.c
index 01825ce0a..192b6c920 100644
--- a/monitor/l2cap.c
+++ b/monitor/l2cap.c
@@ -2123,20 +2123,6 @@ static void amp_packet(uint16_t index, bool in, uint16_t handle,
 	opcode_data->func(&frame);
 }
 
-static void print_hex_field(const char *label, const uint8_t *data,
-								uint8_t len)
-{
-	char str[len * 2 + 1];
-	uint8_t i;
-
-	str[0] = '\0';
-
-	for (i = 0; i < len; i++)
-		sprintf(str + (i * 2), "%2.2x", data[i]);
-
-	print_field("%s: %s", label, str);
-}
-
 static void print_uuid(const char *label, const void *data, uint16_t size)
 {
 	const char *str;
diff --git a/monitor/packet.c b/monitor/packet.c
index d80735a06..2e02b3923 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -1755,20 +1755,6 @@ static void print_key_size(uint8_t key_size)
 	print_field("Key size: %d", key_size);
 }
 
-static void print_hex_field(const char *label, const uint8_t *data,
-								uint8_t len)
-{
-	char str[len * 2 + 1];
-	uint8_t i;
-
-	str[0] = '\0';
-
-	for (i = 0; i < len; i++)
-		sprintf(str + (i * 2), "%2.2x", data[i]);
-
-	print_field("%s: %s", label, str);
-}
-
 static void print_key(const char *label, const uint8_t *link_key)
 {
 	print_hex_field(label, link_key, 16);
-- 
2.35.1

