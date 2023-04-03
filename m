Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B59C76188
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Apr 2023 20:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbjDCUc5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 Apr 2023 16:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbjDCUc5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 Apr 2023 16:32:57 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF249210C
        for <linux-bluetooth@vger.kernel.org>; Mon,  3 Apr 2023 13:32:46 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id cn12so26305895qtb.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Apr 2023 13:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680553965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jTRAeRWaa/WU59xEBFWRGeQrSpj8glfPo7tnjjCjgLM=;
        b=HyfaWIjlfvWOQRVLj/gtzOkA496LDdt3pW1AewMkhW8pVF5UDb7eGgDWUrEIw6svuf
         JUxNdDx2txdNjJ4z0VXWUhKxBKV0kBCdHHDMhVikrJsvFyB/6CXqtxJee6tLudsN1E4W
         DXmR+hfUw55zp7gzk/16mQC4+LBRzHHbRqG43ktblYYVZOrkD6AY5q6cYtJJ2r57wFTi
         sbFTJkaOXs6v4gB/28dhRS3aNkoRC7ooIROLUS0HeUQLRbcCh6UkkZQoJ+t2qS0Vkhbt
         naTL01J9QJ7azJEIVqon5ArTpxWMrne1WNzygytzKwrT5374CbMWtunJIyPnRIyRwpkv
         A4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680553965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jTRAeRWaa/WU59xEBFWRGeQrSpj8glfPo7tnjjCjgLM=;
        b=WwouTq+IxGd6quEE1GDS9+U4jsAGq9FHsCzouzL+IUv01Jf7ZcW5n83NHJH//RID6U
         bZr4PLqh+RsgZUBNCU7fTzQWemKRxPjqNO5FYVeZhgUJFQisG8WMTIyjQMTO6R/7k4Q2
         xpKTktPqYT/37IUhREJBQEidweGWY3ngAJZB/1dz0PKlt57PTXdpntDyBkiFw7Db2beQ
         zJAIvjTnzhReM7SotJjbAlq3TVBoRR7pgYDSGtptdwMZ2uyLAKTC4LVq0jT4a+aMarqL
         6/q6qEwQz7K19Y7wMkec9b0Kp9CTgzoH9rRpuic5V5trruuTPx2RvqBoz0g+ueoFPbUw
         80NQ==
X-Gm-Message-State: AO0yUKVsxaO3pS35TYGeWLEcU0/aOO4+xs1FIucftp64pTQCd0SZVk7i
        p1K+uQidSwUdgLMjgKfAWVTwJ56qUdE=
X-Google-Smtp-Source: AKy350aFFja2gnDKr1FH8o6vt9SI9BOjF5RfSKDyFswWxVTG7s9zGIkeIwY6n0wRESvH+e1X1PA/4Q==
X-Received: by 2002:ac8:5713:0:b0:3e3:86cb:1b9b with SMTP id 19-20020ac85713000000b003e386cb1b9bmr64172373qtw.13.1680553965405;
        Mon, 03 Apr 2023 13:32:45 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id r5-20020ac87945000000b003e6410b4bfbsm2469345qtt.28.2023.04.03.13.32.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 13:32:44 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] set: Fix not attempt to connect devices with RSI
Date:   Mon,  3 Apr 2023 13:32:43 -0700
Message-Id: <20230403203243.1960045-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If a device advertising with RSI is only found later after the set was
already create we shall still attempt to connect to it.
---
 src/set.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/set.c b/src/set.c
index f1008a057f90..ad64fb163b25 100644
--- a/src/set.c
+++ b/src/set.c
@@ -317,7 +317,8 @@ struct btd_device_set *btd_set_add_device(struct btd_device *device,
 	set = set_find(device, sirk);
 	if (set) {
 		set_add(set, device);
-		return set;
+		/* Check if there are new devices with RSI found */
+		goto done;
 	}
 
 	set = set_new(device, sirk, size);
@@ -329,6 +330,7 @@ struct btd_device_set *btd_set_add_device(struct btd_device *device,
 
 	queue_push_tail(set_list, set);
 
+done:
 	/* Attempt to add devices which have matching RSI */
 	btd_adapter_for_each_device(device_get_adapter(device), foreach_device,
 									set);
-- 
2.39.2

