Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EC1C6FD19
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Mar 2023 21:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbjCJV1G (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Mar 2023 16:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjCJV1F (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Mar 2023 16:27:05 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB236AD25
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Mar 2023 13:27:03 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id u3-20020a17090a450300b00239db6d7d47so6358497pjg.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Mar 2023 13:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678483623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=nm+yAeti/T6dgIN/DJnSxJY7OY7ks8esKVqfBJHGwaw=;
        b=gTylIuiImi6Ys3ZfEILsWv7+dB0GYB8cuk+Bc+TMM8XgcBf7UJVrjnfY3hQTloSj6Y
         VI9SQywcysLrkQQ3F/d71jPn4r9kETWjTD2P3WvfpyAsvOp2uP96CzCJGRQwXU1iN+ZX
         uEjMYP+BtaDREmK0umFsM1LFe5gD/36C9qVSJWSIh1Szuo03mMU51wInY4ar9mnG9U5c
         17m9ur/Cci2+rRtzqWf4DL/dp5ZarXvBI0Xeau292MzYE/5Z0SaB2BRguLMFbjMyYcKS
         k23AxDchrZu2bF2Xx51EyRj8qP/I6awUaeAxxMuY7mbJbLb2ML17gLlY+PBPZCzYk+Oe
         EOEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678483623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nm+yAeti/T6dgIN/DJnSxJY7OY7ks8esKVqfBJHGwaw=;
        b=0ice6RDtk8Wzw96MYoc1T76SUpE6g705+2cCsRRHTLgYDjnexqdzjTsKl3rVOSsGAy
         Whvb+yTh+21BKFUNlqgmjWg0CoDnIH17Hs2kRgsG042CfXKd8cD4JgzmZhjsiVSe89Xi
         iKOMqI5yrZo+/MjHrH0i/66BDl1iW4SYxrxw33Wh8SWkEGtVYB7pNxcZGvnxVJMf7HgU
         tN1FvBAr2H8YFiX1haQvaRluFa/+4CbVCWhF+nhM9uwQJEuQ9OyTb526MBOyckp7KRCo
         E2LP4dQAh3zh7bKqNiq2Tc//VneTwvivDT8ggkdDit2Fww8Cge7lTPZ/VXTcRzSu+Nkv
         mQYA==
X-Gm-Message-State: AO0yUKVBZ6SlacJRl1pb4El5awn/ia5o/0EBX6Etvo9xP6Y4aQ1BeWy9
        p0sj+QblsdaH8Yn9ygfKzMQ6E26qOY4=
X-Google-Smtp-Source: AK7set9q9Gie2bf4HqfHAGJ7X7gAENvU7VIoV8VG8tq2oXBkkus7+GeOU5B6+P4B33Z7rAi0GRQBTg==
X-Received: by 2002:a17:902:f693:b0:19d:5fd:11fb with SMTP id l19-20020a170902f69300b0019d05fd11fbmr31903750plg.23.1678483622701;
        Fri, 10 Mar 2023 13:27:02 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id p16-20020a170902ebd000b001994e74c094sm377781plg.275.2023.03.10.13.27.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 13:27:01 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] iso-tester: Update High Reliability presets
Date:   Fri, 10 Mar 2023 13:26:59 -0800
Message-Id: <20230310212700.3873714-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This updates High Reliability presets as published in BAP 1.0.1:

https://www.bluetooth.com/specifications/bap-1-0-1/
---
 tools/iso-tester.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index f3515f450503..3b115976a44d 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -108,22 +108,22 @@
 #define QOS_48_3_gr QOS(7500, 15, 90, 0x02, 2)
 #define QOS_48_4_gr QOS(10000, 20, 120, 0x02, 2)
 /* QoS Configuration settings for high reliability audio data */
-#define QOS_8_1_2 QOS(7500, 45, 26, 0x02, 41)
-#define QOS_8_2_2 QOS(10000, 60, 30, 0x02, 53)
-#define QOS_16_1_2 QOS(7500, 45, 30, 0x02, 41)
-#define QOS_16_2_2 QOS(10000, 60, 40, 0x02, 47)
-#define QOS_24_1_2 QOS(7500, 45, 45, 0x02, 35)
-#define QOS_24_2_2 QOS(10000, 60, 60, 0x02, 41)
-#define QOS_32_1_2 QOS(7500, 45, 60, 0x02, 29)
-#define QOS_32_2_2 QOS(10000, 60, 80, 0x02, 35)
-#define QOS_44_1_2 QOS_OUT(8163, 54, 98, 0x02, 23)
-#define QOS_44_2_2 QOS_OUT(10884, 71, 130, 0x02, 23)
-#define QOS_48_1_2 QOS_OUT(7500, 45, 75, 0x02, 23)
-#define QOS_48_2_2 QOS_OUT(10000, 60, 100, 0x02, 23)
-#define QOS_48_3_2 QOS_OUT(7500, 45, 90, 0x02, 23)
-#define QOS_48_4_2 QOS_OUT(10000, 60, 120, 0x02, 23)
-#define QOS_48_5_2 QOS_OUT(7500, 45, 117, 0x02, 23)
-#define QOS_48_6_2 QOS_OUT(10000, 60, 155, 0x02, 23)
+#define QOS_8_1_2 QOS(7500, 75, 26, 0x02, 13)
+#define QOS_8_2_2 QOS(10000, 95, 30, 0x02, 13)
+#define QOS_16_1_2 QOS(7500, 75, 30, 0x02, 13)
+#define QOS_16_2_2 QOS(10000, 95, 40, 0x02, 13)
+#define QOS_24_1_2 QOS(7500, 75, 45, 0x02, 13)
+#define QOS_24_2_2 QOS(10000, 95, 60, 0x02, 13)
+#define QOS_32_1_2 QOS(7500, 65, 60, 0x02, 13)
+#define QOS_32_2_2 QOS(10000, 95, 80, 0x02, 13)
+#define QOS_44_1_2 QOS_OUT(8163, 80, 98, 0x02, 13)
+#define QOS_44_2_2 QOS_OUT(10884, 85, 130, 0x02, 13)
+#define QOS_48_1_2 QOS_OUT(7500, 75, 75, 0x02, 13)
+#define QOS_48_2_2 QOS_OUT(10000, 95, 100, 0x02, 13)
+#define QOS_48_3_2 QOS_OUT(7500, 75, 90, 0x02, 13)
+#define QOS_48_4_2 QOS_OUT(10000, 100, 120, 0x02, 13)
+#define QOS_48_5_2 QOS_OUT(7500, 75, 117, 0x02, 13)
+#define QOS_48_6_2 QOS_OUT(10000, 100, 155, 0x02, 13)
 
 #define QOS_OUT_16_2_1 QOS_OUT(10000, 10, 40, 0x02, 2)
 #define QOS_OUT_1_16_2_1 QOS_OUT_1(10000, 10, 40, 0x02, 2)
-- 
2.39.2

