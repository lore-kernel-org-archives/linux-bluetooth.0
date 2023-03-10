Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE5AC6FA99
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Mar 2023 21:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbjCJVkI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Mar 2023 16:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbjCJVkF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Mar 2023 16:40:05 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F14912E14B
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Mar 2023 13:40:04 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id z11so4510925pfh.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Mar 2023 13:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678484403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=MzPUuCP0cVivF9x1mxiMcqZ/hYb0lUD1sHj31dffAyg=;
        b=FzPbIWx0z2JeDCuD8cyaOBU5ItEkUr4KSAHVXx7ct83KKrmXrLlN/5rHi6N6AEBN3L
         Q6QUpMS2MUfQYdK402r5Ap7tLnBYxxMy/WGbYbm0BlMTV0Dy/f0ohGHJ3hIo+gf6i5w2
         HUQ097MIVotymP0yruKfRFXszKvV74xYpWFXIeATE5plpUuxa5icDYx/DXJTiZx9tfgT
         g3oaGLWq2RnVoMHQYgX7LDjk2klGOL7LyikSNotaU0MzDlwC4Hr7x/d7LksI99nMTSIj
         KjfvxI9p0MFp4hnd2W0JaCb5NkL2LoRxv1CrvL9YwCnSZaExUxwg9NPUIBbYTgjJrs5U
         42Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678484403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MzPUuCP0cVivF9x1mxiMcqZ/hYb0lUD1sHj31dffAyg=;
        b=OfXC1lbbVdSxYn6LHF7igGI1hjXaEKAc27ytNDG8XSlHZnheNndEfcgZJHlT7owh/f
         79ZrCRHRPNfz0dOrmiCuCodSC3T3hAchfApbxo372+P5XW9zT2VboWtxCWkzogVNP6de
         Gw/2vOk9ndOeBTXHWhkTuoniyb5Xk7GX5Pqt6cDFAYlYHF/CxirLefk54k1bprMjqyf4
         k6mGEJ+ifIPYuzQMce5VtyQu+rcvoN3RJMAq5mH8me7AvvNM6up13Qa+kdcp7dmlYLY6
         kGnml1J3gP+Q5pFowsQiN5RqiqMlqjMGd210zlFMj1BEsWQkiVUi3deZdrQAdlhVwm+R
         /tWA==
X-Gm-Message-State: AO0yUKW9uK3yqB6IFey+xyX5we8DkpAwbCcF+4S654vPtqaVn0HV+Fs1
        1veFUPhqdLsQmDuf4njGOBDo+qPS+Fs=
X-Google-Smtp-Source: AK7set9qOsFVJlOXxOV74OhpZdckCneqsKy+6DqjbyZYhxLyFj4VxoeW3OpFY4dZhhYaLoalEOg2kw==
X-Received: by 2002:aa7:96d8:0:b0:5ef:b4e1:db0e with SMTP id h24-20020aa796d8000000b005efb4e1db0emr22605394pfq.16.1678484403486;
        Fri, 10 Mar 2023 13:40:03 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id b18-20020a6567d2000000b004d4547cc0f7sm348854pgs.18.2023.03.10.13.40.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 13:40:02 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] iso-tester: Update High Reliability presets
Date:   Fri, 10 Mar 2023 13:40:00 -0800
Message-Id: <20230310214001.3891437-1-luiz.dentz@gmail.com>
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
index 7bcb1b3ca463..e4582573ac88 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -102,22 +102,22 @@
 #define QOS_48_5_1 QOS_OUT(7500, 15, 117, 0x02, 5)
 #define QOS_48_6_1 QOS_OUT(10000, 20, 155, 0x02, 5)
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

