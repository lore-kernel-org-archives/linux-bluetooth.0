Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E61C43334
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jun 2022 22:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347032AbiFQWVZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Jun 2022 18:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346556AbiFQWVX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Jun 2022 18:21:23 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7D461282
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jun 2022 15:21:23 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id c196so5266944pfb.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jun 2022 15:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=BY74aJKawL8ZJHJdZMpTNWRQDCAFbo7G5NU4C+yjJ6Y=;
        b=cC7jLMSVthGVYjh7mzaE/6SJ24UmsHNrLminKbQRwLTEPnYpzs/8UwsyYnaIK0dCce
         U1SbRFcAAZS2EoY/KVxgDzCRho4BWWwapytyKSawSDhRVnic7IdMp26Lvueyg/cKC5l8
         S8LOkvJs9IDTi9evhdaA97LoVYFES0gjxsDnMcB0/FleAmXMKOrejlOvu/8Yjgdu655z
         R7GxgOk3a6AOcMplAeuI8acyJ0LQz4HPEl5/lYZjIg+mRTRMTblumVCJzokpbd58mpng
         WRIWxprs2qNS0mls1s/URSIp+Wht6uu/XwWncno91q6js5Dd6pjbmK3Y4ak3fDvmEp8Z
         WOiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BY74aJKawL8ZJHJdZMpTNWRQDCAFbo7G5NU4C+yjJ6Y=;
        b=TKbsEi+6mdDAQcbeofyptlrdiAQkKhc4FSrxfIDkYG2Ze91fD95LyjLeDo+s84Mg5n
         SVEVR0aY1NnRoCbJsThBuFOFBSppVR6BVqlDv5+Y0Ljrqu7M9xb9DQZ2NWwlQJCwDs6r
         KdvKas+8KbMORgfxDebbiL3v6gRxmLBClraj5X39rYW5ZdiHPMo2Gzc5/7ANiVbCfztA
         Oo4BPOSrdMYENG+645MsE7cP6nUcObqZTeO6IObDGNiv5Lq3tD3vtXUts/j+ClZFmRdq
         QiIksU9RA9jlMMtKbzLiJ8ZcJW5jkn8UwI/YBPlz7G6ZaBulZDSLsd58B3o+6Rz3ouv4
         VJrQ==
X-Gm-Message-State: AJIora+yAkntnh4ho5Knn7NuD57q+1D5pehBitTci0fxl+hrTIyCp/u9
        /jaLx5elQBYDSQ7hdJy5icLLtoPl1mE=
X-Google-Smtp-Source: AGRyM1sP7CxIifapM0vTRRiMvVAPXeEouYDUkKqUj4t/8HYXrZgEQ3o1NR49UVZWboNP6oflpMcDEA==
X-Received: by 2002:a63:3f05:0:b0:408:c620:fa7f with SMTP id m5-20020a633f05000000b00408c620fa7fmr10723873pga.525.1655504482365;
        Fri, 17 Jun 2022 15:21:22 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id v9-20020a056a00148900b0051829b1595dsm4165392pfu.130.2022.06.17.15.21.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 15:21:21 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v6 2/8] shared/util: Decode BlueZ Experimental ISO Socket UUID
Date:   Fri, 17 Jun 2022 15:21:13 -0700
Message-Id: <20220617222119.1413958-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220617222119.1413958-1-luiz.dentz@gmail.com>
References: <20220617222119.1413958-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds BlueZ experimental ISO Socket UUID to uuid128_table so it is
decoded by the likes of btmon.
---
 src/shared/util.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/shared/util.c b/src/shared/util.c
index 33196bf8b..b74a005ce 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -1149,6 +1149,8 @@ static const struct {
 	{ "330859bc-7506-492d-9370-9a6f0614037f",
 		"BlueZ Experimental Bluetooth Quality Report" },
 	{ "a6695ace-ee7f-4fb9-881a-5fac66c629af", "BlueZ Offload Codecs"},
+	{ "6fbaf188-05e0-496a-9885-d6ddfdb4e03e",
+		"BlueZ Experimental ISO Socket"},
 	{ }
 };
 
-- 
2.35.3

