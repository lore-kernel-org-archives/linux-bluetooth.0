Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A672FC4167B
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Dec 2022 01:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiLIBDY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 8 Dec 2022 20:03:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiLIBDV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 8 Dec 2022 20:03:21 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB3694192
        for <linux-bluetooth@vger.kernel.org>; Thu,  8 Dec 2022 17:03:20 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id q1so2513754pgl.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Dec 2022 17:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uIG1fSR1LOk0TcUreHrxo/p2PRAMeYSvgKLfpsnCyGw=;
        b=cuPTOIf3lqLXGwy0TSP7hKgJ4s+exdm/BzVrX/Z7s89t4YfWCUuypg/W1SWGAXZenu
         gvLtuLc9chBdj1vwkfHwPH1jYRsptvzcolLQzLv8ljdjwsB2ALIdkshr5cbQ/3DMFNMn
         IR0FOSh3pOkS1BCdoHEaosfTxAXMUVSzqRoy8a2rKEFEqtJklHgvBgF5UjSx+fNZjXRU
         jiWq1oOpfFzmhu9RK6rJ/MnwXqCXJb2ES+LfU1eGz5lvcLCpa91a7RLAGWZ76Is/DMAq
         RZio6JlIn/DzPRb8+MW+cktrZX5RelulFs/+R1Lh6iCQ04FzG4vjTRoYNvDqbYoS+jsh
         HBvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uIG1fSR1LOk0TcUreHrxo/p2PRAMeYSvgKLfpsnCyGw=;
        b=yKp2hqgb2UXqaO8YDH/4Zm1NtfpRO35p4y6j+eNdTP6Qyu53gsxE0ZAGF6RyGIJGM4
         5aSqVHaQmBYeYf23kovXzQLGKHc5u2WsoJODJiKvddum3L1yjniYUPTCdSjx6CfcJTh0
         Kf2KTbZO+FYCdgEsonpBGGooX/SVOY1h8U2CTW/DQOERewcpL/reyqZF100beS7lOiNw
         B0eBa8+13uAnljo09t9Fbyf0a/3Ok1w6kdeyppPulPj7M7qtJ80uXTrepPbOSwOJ2wyq
         gQXVB5n4cZnQ3jSj/9KD74qnxCO1qRzp2Xm8WI8EUfYPstbTogiA/TSrMCzj4lbbEBOO
         9DXQ==
X-Gm-Message-State: ANoB5plPdDqNRSxQ0EPlTmDVBOTpsHmOChxf+6Z7f/QJuXgJpLcZ/Tgr
        R3N3s3KU4ovzfXIOhHDTgoB1j0pE+gwTtw==
X-Google-Smtp-Source: AA0mqf50ocySCxNQNi1ttwXmewu6G5J3ObgmTqSj2G/euGuUBxExEEnos+rV53BN+jXqgG3otAOUBg==
X-Received: by 2002:aa7:8b4d:0:b0:56c:962:fe7e with SMTP id i13-20020aa78b4d000000b0056c0962fe7emr3763292pfd.32.1670547799784;
        Thu, 08 Dec 2022 17:03:19 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id z21-20020aa79495000000b005746c3b2445sm100253pfk.151.2022.12.08.17.03.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 17:03:19 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/5] shared/gatt-db: Allow passing NULL to gatt_db_attribute_write
Date:   Thu,  8 Dec 2022 17:03:13 -0800
Message-Id: <20221209010314.707606-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221209010314.707606-1-luiz.dentz@gmail.com>
References: <20221209010314.707606-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes gatt_db_attribute_write to accept NULL as a func when
storing directly on the db itself.
---
 src/shared/gatt-db.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index ba47c75ff70c..9a92090ec493 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -2095,7 +2095,7 @@ bool gatt_db_attribute_write(struct gatt_db_attribute *attrib, uint16_t offset,
 {
 	uint8_t err = 0;
 
-	if (!attrib || !func)
+	if (!attrib || (!func && attrib->write_func))
 		return false;
 
 	if (attrib->write_func) {
@@ -2158,7 +2158,8 @@ bool gatt_db_attribute_write(struct gatt_db_attribute *attrib, uint16_t offset,
 	memcpy(&attrib->value[offset], value, len);
 
 done:
-	func(attrib, err, user_data);
+	if (func)
+		func(attrib, err, user_data);
 
 	return true;
 }
-- 
2.37.3

