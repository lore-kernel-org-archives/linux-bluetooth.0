Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72559C61DA4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Feb 2023 00:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjBOA4d (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Feb 2023 19:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjBOA4c (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Feb 2023 19:56:32 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56282BEE3
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Feb 2023 16:56:31 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id nh19-20020a17090b365300b00233ceae8407so452692pjb.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Feb 2023 16:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1F5zWEdQpyxdLBj3DjvY9B+OM9H52JOC2eflECfHLyE=;
        b=gDZE9q8ZyZyVMELucw7jtV1whyv3/k2EQzMwoen2x26DGo8aRVyrZPE/vI2YiuXP7x
         dK4Op+y6ufsgcfDGcLRF4V6ai5+ySnAQjMuJS9Ex3whmHq+6YMW/jk8QjKYpm4qa9/yv
         xEt9XLJWyEeFAKyA0pdG5vnkfCuAAuWDl90001+ORUc1udT5KRnfWPnuFS4J2ddyttlN
         tv4zht7byJ1FPbeATUdxHARrFYMMmPy7LkPtKf1qEtF0hTwSL/jPs/qTiuIjYnK0xWSd
         l/B1ihnLTH0DLM4sgsXQTiXrxJDE81DmY1848nPx1OoDUu0OBt4TqWEX3jLXlFaKul6a
         uNKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1F5zWEdQpyxdLBj3DjvY9B+OM9H52JOC2eflECfHLyE=;
        b=ITZkKRcd13McZU/BE5RZTVpwiSVfh9xeqBP5zDyFRkT53C04OlUReelF8OemcRCJx0
         DAY/eZUqKawjvr4L8rfeLmiosLb0nzEafS1Ua97Qyh+M2s5ezl4fFXmbYzjqY0KNnfcS
         17cJYUHw1zZirMIm6UDHr0pDWtwwRUcHdn9xUvOP0y8bIBPed4Qt1CroePR4FODA2J9Z
         kGX8EGIKI/aMeyiHmoX51fWF2HNYF3kErUR1Zg+sK1Xo7HkY/qcx4hIInyR4xEVAMrvn
         QF58Ol5U+ET3mDi2A//NDblXcWTa0QnvpOuKDwOQ4AAxvjHxRkYIjwIwyPeU966+utCN
         elGw==
X-Gm-Message-State: AO0yUKWUVoLlHrMoJLkxUI9+bdmIE3YlFk1TQj34nvOoGgi3zpz+WZGN
        wlWqS4WN4igSx7spGjj5YgfItRIPY3w=
X-Google-Smtp-Source: AK7set/gl7kV2bhCNt89f1emKFSDk6qTeVrg69ZcnjRYWNNvkz/+E5Djucus8i+ha6YTiULvobw3lg==
X-Received: by 2002:a05:6a21:7883:b0:b8:bc13:c838 with SMTP id bf3-20020a056a21788300b000b8bc13c838mr4994733pzc.53.1676422590976;
        Tue, 14 Feb 2023 16:56:30 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id y21-20020a634b15000000b004eca54eab50sm8525203pga.28.2023.02.14.16.56.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 16:56:30 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] monitor/att: Fix ASE frequency values
Date:   Tue, 14 Feb 2023 16:56:29 -0800
Message-Id: <20230215005629.990585-1-luiz.dentz@gmail.com>
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

