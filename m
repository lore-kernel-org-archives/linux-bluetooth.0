Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812A7C6FD19
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Mar 2023 21:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbjCJVkK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Mar 2023 16:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbjCJVkH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Mar 2023 16:40:07 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF8012E15D
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Mar 2023 13:40:05 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id y15-20020a17090aa40f00b00237ad8ee3a0so6407234pjp.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Mar 2023 13:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678484405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rd6Na/0YClOVXtx/4N0R2gktGtAGpUyavXZSnO/1u2M=;
        b=LXAv2bqO/Pt5fz3cMPoFZB7NhYhnzUjuLRBActBK7Tg9MY0akT+dbd5cpaukw5FGAY
         32Uk45w4UszZKPUsoA/UuXhPbpOrhpi2XGJamX/2JPggT687a6QaKjkCYdOhknUc4KuJ
         Wj72yZBK1WXtaAE0Yrp2GDegRo8hKiBzpU5wRcckhtyGeE10cbafJz2no9a+TAlbXq1G
         luXI5PbhANkDVSRIhSd3AmV791nVpOPMsN3p/xsB51Q/n2+QixLGyDKHkjHFjxe5YNwJ
         QllBio9AQhsU3fD2h/igGD25wKSsQTleMBAE8G9DbS+LosRnEXEaDJ12+C90wL/l5bf2
         cXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678484405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rd6Na/0YClOVXtx/4N0R2gktGtAGpUyavXZSnO/1u2M=;
        b=lHOSI4AZryG+KqOZ2wCud3MY8Y6BS/ttA+2swXLMF1UVz0ErcmwlBahD6WqHmg71Xp
         3kM8djK8v6PCZ1QTOZZVaDWdd/KLymnBtpxPFOPghPnk+M3CIJgpp7fw7NB5Xn3+9V3S
         OYlPoqXuTIqabwkft10iUqekUiPsevIHFz8BoLvQ2f/E/cQbCYLuzhR5Ehh/pxIbEUQl
         Lb2Yi9DJpe6/qy8db6Za6WNvTCRdhaQr9b1z7r29WlEdiV9EH9zo4+KztsbVYScxj6iw
         NBDPHF/4K/IUkv7M9hzfakeOZLxEf+s+mo/+pv1G3p596p14GcnGm0qslcYlCo0saLRK
         825Q==
X-Gm-Message-State: AO0yUKVcpaImQlmRpGajWWF8Jl4yo3VSNe4Cy7DTMIoR1N+Vnq9zE52i
        6SqYz4oARb0Jn0U5mlCTXBqufX7WKuI=
X-Google-Smtp-Source: AK7set9gJziGLRxb8lddFW3sF244BqwbWJlWm/a3h0OxAiBajSGJrFaWwI681HiIUJnwnGcFs12GFw==
X-Received: by 2002:a05:6a20:8f1d:b0:bf:58d1:ce91 with SMTP id b29-20020a056a208f1d00b000bf58d1ce91mr3112251pzk.16.1678484404629;
        Fri, 10 Mar 2023 13:40:04 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id b18-20020a6567d2000000b004d4547cc0f7sm348854pgs.18.2023.03.10.13.40.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 13:40:03 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] client/player: Update High Reliability presets
Date:   Fri, 10 Mar 2023 13:40:01 -0800
Message-Id: <20230310214001.3891437-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230310214001.3891437-1-luiz.dentz@gmail.com>
References: <20230310214001.3891437-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This updates High Reliability presets as published in BAP 1.0.1:

https://www.bluetooth.com/specifications/bap-1-0-1/
---
 client/player.c | 40 ++++++++++++++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/client/player.c b/client/player.c
index 767304b567b6..63e11db09ba9 100644
--- a/client/player.c
+++ b/client/player.c
@@ -1347,30 +1347,54 @@ static struct codec_preset lc3_presets[] = {
 			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_10, 155u),
 			LC3_10_UNFRAMED(155u, 5u, 20u, 40000u)),
 	/* QoS Configuration settings for high reliability audio data */
+	LC3_PRESET_HR("8_1_2",
+			LC3_PRESET_8KHZ(LC3_CONFIG_DURATION_7_5, 26u),
+			LC3_7_5_UNFRAMED(26u, 13u, 75u, 40000u)),
+	LC3_PRESET_HR("8_2_2",
+			LC3_PRESET_8KHZ(LC3_CONFIG_DURATION_10, 30u),
+			LC3_10_UNFRAMED(30u, 13u, 95u, 40000u)),
+	LC3_PRESET_HR("16_1_2",
+			LC3_PRESET_16KHZ(LC3_CONFIG_DURATION_7_5, 30u),
+			LC3_7_5_UNFRAMED(30u, 13u, 75u, 40000u)),
+	LC3_PRESET_HR("16_2_2",
+			LC3_PRESET_16KHZ(LC3_CONFIG_DURATION_10, 40u),
+			LC3_10_UNFRAMED(40u, 13u, 95u, 40000u)),
+	LC3_PRESET_HR("24_1_2",
+			LC3_PRESET_24KHZ(LC3_CONFIG_DURATION_7_5, 45u),
+			LC3_7_5_UNFRAMED(45u, 13u, 75u, 40000u)),
+	LC3_PRESET_HR("24_2_2",
+			LC3_PRESET_24KHZ(LC3_CONFIG_DURATION_10, 60u),
+			LC3_10_UNFRAMED(60u, 13u, 95u, 40000u)),
+	LC3_PRESET_HR("32_1_2",
+			LC3_PRESET_32KHZ(LC3_CONFIG_DURATION_7_5, 60u),
+			LC3_7_5_UNFRAMED(60u, 13u, 75u, 40000u)),
+	LC3_PRESET_HR("32_2_2",
+			LC3_PRESET_32KHZ(LC3_CONFIG_DURATION_10, 80u),
+			LC3_10_UNFRAMED(80u, 13u, 95u, 40000u)),
 	LC3_PRESET_HR("44_1_2",
 			LC3_PRESET_44KHZ(LC3_CONFIG_DURATION_7_5, 98u),
-			QOS_FRAMED_2M(8163u, 98u, 23u, 54u, 40000u)),
+			QOS_FRAMED_2M(8163u, 98u, 13u, 80u, 40000u)),
 	LC3_PRESET_HR("44_2_2",
 			LC3_PRESET_44KHZ(LC3_CONFIG_DURATION_10, 130u),
-			QOS_FRAMED_2M(10884u, 130u, 23u, 71u, 40000u)),
+			QOS_FRAMED_2M(10884u, 130u, 13u, 85u, 40000u)),
 	LC3_PRESET_HR("48_1_2",
 			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_7_5, 75u),
-			LC3_7_5_UNFRAMED(75u, 23u, 45u, 40000u)),
+			LC3_7_5_UNFRAMED(75u, 13u, 75u, 40000u)),
 	LC3_PRESET_HR("48_2_2",
 			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_10, 100u),
-			LC3_10_UNFRAMED(100u, 23u, 60u, 40000u)),
+			LC3_10_UNFRAMED(100u, 13u, 95u, 40000u)),
 	LC3_PRESET_HR("48_3_2",
 			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_7_5, 90u),
-			LC3_7_5_UNFRAMED(90u, 23u, 45u, 40000u)),
+			LC3_7_5_UNFRAMED(90u, 13u, 75u, 40000u)),
 	LC3_PRESET_HR("48_4_2",
 			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_10, 120u),
-			LC3_10_UNFRAMED(120u, 23u, 60u, 40000u)),
+			LC3_10_UNFRAMED(120u, 13u, 100u, 40000u)),
 	LC3_PRESET_HR("48_5_2",
 			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_7_5, 117u),
-			LC3_7_5_UNFRAMED(117u, 23u, 45u, 40000u)),
+			LC3_7_5_UNFRAMED(117u, 13u, 75u, 40000u)),
 	LC3_PRESET_HR("48_6_2",
 			LC3_PRESET_48KHZ(LC3_CONFIG_DURATION_10, 155u),
-			LC3_10_UNFRAMED(155u, 23u, 60u, 40000u)),
+			LC3_10_UNFRAMED(155u, 13u, 100u, 40000u)),
 };
 
 #define PRESET(_uuid, _presets, _default_index) \
-- 
2.39.2

