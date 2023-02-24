Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C9FC64ED6
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Feb 2023 01:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjBXBvo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Feb 2023 20:51:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjBXBvn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Feb 2023 20:51:43 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4436E5DCE4
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Feb 2023 17:51:40 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id i3so4740219plg.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Feb 2023 17:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1F5zWEdQpyxdLBj3DjvY9B+OM9H52JOC2eflECfHLyE=;
        b=FVkhX698T56ryupjEeIh04DJoTNiPyjGY9/T3MAsH+911/zFEnjxY8DdvtBCq77wXw
         ptrIZ16DOgUgDMq99+Yr3pzqycLki4T37A5m5BVvXVcBlhm5uhwHc+pAaVIF0pcT4xno
         670/bgLUbrnK+6E5pGH8M9VMpYRyieXzZQUx7yPnZ0nq/oqVCc/5YXwKXyXQTW/m1l8Z
         7k/o0/dXhExhYq8rJGqXU4PBhfnvcselGvWLmEh0eQi53eE76LS/TibGtbeeuq2rVscx
         zfUW/BqcH7u8xAP1vJQipRkP49Bo33vDYBY0m8oNinnLIcOmVSFt3DEyLc2wKd6qeTY6
         zvLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1F5zWEdQpyxdLBj3DjvY9B+OM9H52JOC2eflECfHLyE=;
        b=Rmwgnk900w68oUTF4s6Rsldzs2LgqtR+K917vtvCDYlJu8CwTfpEhFwnpGrhH+0Xsw
         ts1yTR5vVXRuRDDWh9pEwe37sZXfAgblWZMNCPqsLzNo/fC0jQphmg59JB9I2XZmg9/c
         dPSMrGAWEZPHWLBVmiVIt00/d5OFeg54zoRbr+FJDMOsU+v8ie6P+6HzSYBMIP+pp1PB
         L67IWQCSqbYgzz4eq0oSacKiEhSI2jz+gpre2DdmdxQXlxDTwudXnMEw7p5MoCyivF0s
         f2hHC73xewiA6d/hT7F8Vp1ddc+ouhAlR6uJnebtFhri7lvE88JklimEfYuyOmZYt4Yk
         PlzQ==
X-Gm-Message-State: AO0yUKUcKaEFZ6CvY2yFVIckBJcap/wexeceKe/JD0MkkoFtoMmpOrrD
        xQ0oqabrbjbT0JaXQr+eJM2n/xeNRTw=
X-Google-Smtp-Source: AK7set88JMOSwX69hHtGmaPPexRle84V07A/2hg0KDXDh0ogDCQyi+ChIf/GS76U0FE95drgVLPIBQ==
X-Received: by 2002:a17:903:1211:b0:19c:bcb4:cacb with SMTP id l17-20020a170903121100b0019cbcb4cacbmr4702924plh.56.1677203499142;
        Thu, 23 Feb 2023 17:51:39 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id k4-20020a170902694400b001963a178dfcsm2706047plt.244.2023.02.23.17.51.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 17:51:37 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] monitor/att: Fix ASE frequency values
Date:   Thu, 23 Feb 2023 17:51:36 -0800
Message-Id: <20230224015136.3445113-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the printed hex value of some of the frequencies.
---
 monitor/att.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/monitor/att.c b/monitor/att.c
index 05784e9f46c4..f9643b333b32 100644
--- a/monitor/att.c
+++ b/monitor/att.c
@@ -890,31 +890,31 @@ static void ase_decode_freq(const uint8_t *data, uint8_t len)
 		print_field("      Sampling Frequency: 22.05 Khz (0x04)");
 		break;
 	case 0x05:
-		print_field("      Sampling Frequency: 24 Khz (0x04)");
+		print_field("      Sampling Frequency: 24 Khz (0x05)");
 		break;
 	case 0x06:
-		print_field("      Sampling Frequency: 32 Khz (0x04)");
+		print_field("      Sampling Frequency: 32 Khz (0x06)");
 		break;
 	case 0x07:
-		print_field("      Sampling Frequency: 44.1 Khz (0x04)");
+		print_field("      Sampling Frequency: 44.1 Khz (0x07)");
 		break;
 	case 0x08:
-		print_field("      Sampling Frequency: 48 Khz (0x04)");
+		print_field("      Sampling Frequency: 48 Khz (0x08)");
 		break;
 	case 0x09:
-		print_field("      Sampling Frequency: 88.2 Khz (0x04)");
+		print_field("      Sampling Frequency: 88.2 Khz (0x09)");
 		break;
 	case 0x0a:
-		print_field("      Sampling Frequency: 96 Khz (0x04)");
+		print_field("      Sampling Frequency: 96 Khz (0x0a)");
 		break;
 	case 0x0b:
-		print_field("      Sampling Frequency: 176.4 Khz (0x04)");
+		print_field("      Sampling Frequency: 176.4 Khz (0x0b)");
 		break;
 	case 0x0c:
-		print_field("      Sampling Frequency: 192 Khz (0x04)");
+		print_field("      Sampling Frequency: 192 Khz (0x0c)");
 		break;
 	case 0x0d:
-		print_field("      Sampling Frequency: 384 Khz (0x04)");
+		print_field("      Sampling Frequency: 384 Khz (0x0d)");
 		break;
 	default:
 		print_field("      Sampling Frequency: RFU (0x%2.2x)", value);
-- 
2.37.3

