Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874B2C25B50
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Jan 2023 23:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbjAWX5P (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 23 Jan 2023 18:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjAWX5O (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 23 Jan 2023 18:57:14 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B4633451
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Jan 2023 15:56:56 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id g23so13069198plq.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Jan 2023 15:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kyRzQcZPxdyeDqeK4B+byIMEyu9YD7hxZfGEHEzdfTM=;
        b=hQUcr6U4sSlvUOZlBg+MQiJJNqz8pgQaoVX/Nx9zHG66xQL+ytfHvS4t+NXVFv+yRV
         NLpQyEbd87oYqw89nu5TPq+AhOw99e/7qctyXqYCrGerAK/hBYC2Jv00GNEzOJFAjn2r
         kug5zbXseu2hLj2FcvGVACdmLSo+aEwtpWUb0hAB4dI2bca4+PJexDwUzaBHLWtcGLog
         G8MIVmKgJLkBIOIZ0iyvooWVlT84ffGPdSErCtAqugs6MHit6r6pGfBCUWsELXNYJAgR
         +Ec4YmxiiDK4+gaE36loMRWoHirlZqI6blImI+lNmCDSMBhOLDHVkMh1Vysb4NMyLDHJ
         uHYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kyRzQcZPxdyeDqeK4B+byIMEyu9YD7hxZfGEHEzdfTM=;
        b=HYhzmV5Mq8eF4ReoiRQhBXJ8EvXm7EXX6QJ0rCiofpZ7ds5qUndYJ/1NA4sqyH7ZCn
         xfFs4/6FXCuw0ouVHFO/F+I9/SbKMbZwgw7HEHc7OAMvbUAcypZ3rDduCj9doVN8CuWs
         QEj6kExyU6tMAe22ZH87eY08BY3+8zSFMR9iuKaKSWOdBM8JK9L3HgABiN5YK3OC6Pmq
         6CLK8wAKrl9RHR3nQd+kSn/5fNVOtXFd/+y2r6Ds6UYRrMf37J7Kv95exRdgi6SxntCG
         1Rvjzq0R50IT+nVSDAvg2CtUvQmjSdxk5sbabE30KTfthbr3J8WuvH0gSm5LlXpnBgpe
         yXQw==
X-Gm-Message-State: AFqh2koSsLA0qGi6293Y5OmXVN013RzQuxtQag/9t15Que//9sKQ3lzV
        XTmDcMAZVjsWdcpF8rib9zFf8HIM2pM=
X-Google-Smtp-Source: AMrXdXv2WJ0E5md+sx6xQYQUCD2+qD6ZQIO5qWNfbR3EklLW2X4dujofIRiZe1RuFc2wuwjcW3S8ag==
X-Received: by 2002:a17:902:d58a:b0:192:dfdb:9ebe with SMTP id k10-20020a170902d58a00b00192dfdb9ebemr28626845plh.10.1674518215272;
        Mon, 23 Jan 2023 15:56:55 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id w14-20020a170902d70e00b001960706141fsm268130ply.149.2023.01.23.15.56.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 15:56:54 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/5] media-api: Make Vendor a uint32_t
Date:   Mon, 23 Jan 2023 15:56:48 -0800
Message-Id: <20230123235649.3231488-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230123235649.3231488-1-luiz.dentz@gmail.com>
References: <20230123235649.3231488-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Using two uint16_t requires the use of a container which makes things a
lot more complicated so this switch to use a single uint32_t.
---
 doc/media-api.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/media-api.txt b/doc/media-api.txt
index 26527622cfe9..281f72c1e4ce 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -34,7 +34,7 @@ Methods		void RegisterEndpoint(object endpoint, dict properties)
 					match the profile specification which
 					is indicated by the UUID.
 
-				uint16_t, uint16_t Vendor [Optional]:
+				uint32_t Vendor [Optional]:
 
 					Vendor-specific Company ID, Codec ID
 					tuple that the endpoint implements.
@@ -649,7 +649,7 @@ Properties	string UUID [readonly, optional]:
 			The values should match the profile specification which
 			is indicated by the UUID.
 
-		uint16_t, uint16_t Vendor [readonly, Optional]:
+		uint32_t Vendor [readonly, Optional]:
 
 			Vendor-specific Company ID, Codec ID tuple that the
 			endpoint implements.
-- 
2.37.3

