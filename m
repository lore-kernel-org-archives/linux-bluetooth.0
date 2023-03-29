Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D95DC761A6
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Mar 2023 23:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjC2XZr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Mar 2023 19:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjC2XZo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Mar 2023 19:25:44 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF162133
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Mar 2023 16:25:42 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id bl9so7556238iob.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Mar 2023 16:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680132341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/T7sAK69cdWKGs4zQ8PO/z+ad3ZrDY/gE9JtaGJsj54=;
        b=S5yMjgzGDz7DJZqWEkg1nn5eB3nPKyp+T5n55sAHE/hKVSlDUmdFYuOYbcBVhoGC1/
         QwvbmKvhRcH+7ox2QBxpgIdriML0PMDGKQMVrK9DZcXS7aSyoz9KQvbV5PkAJk04Nhbq
         povfPgDgLppQA8HfjQ/1qcTaiPIOG/DrtCYVr1BjNw33gsJgxOtBWw1JKULOlKVnNwlu
         pOrTeit65HLb6tcb+OBa5z13nJeikxlVczOYmYfQZ8BMEPSZFK4F0aLWMAaY0yeiOYiD
         yLXqmyBOa/k1SQsD6A2cBhjgDHLS20sz/RN1uvDx2xcbwdt7275DLeR3R6dNNeMJrLpN
         0DbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680132341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/T7sAK69cdWKGs4zQ8PO/z+ad3ZrDY/gE9JtaGJsj54=;
        b=GmcsX85U99Zg0xtArVRSOnRVlS7FDbwuDYQHDXok2/MxwyRZM/o7gPaV9a0uJLLBTE
         lX7jDiaAnRClQrIzGIwNg6B14Kr4w4E2TO0GHEYZxv5a5/QVb8ehFs6PhOE8cdB2htka
         acqZ9z9cGpfQkQjrKIDLd5WJ2cuSEaWjLb9KHsDHysy2hDm2vGdW6Rqxf3yM/HuAr5Th
         qfMdGfJpSm+TZFoxzMTjH679xS4B0l0K20Bg5LCu9+BFjBuM7qaTTxK77DnThnc9PN0A
         sWY8X+RGFcQwG4QzIsonzm+noUnEXnaRiM6alPvI0PEj6SiRYb6TVMRtp2h65GFjqTpk
         eREA==
X-Gm-Message-State: AAQBX9cs0FMVlOmuc/zZ1H79te1HV6Tx3U5gKO0bvu8MTUZIOxLXP7CN
        J7jtAvELmb20odkxW6/scpJDzh/4+KgsTA==
X-Google-Smtp-Source: AKy350aoRKFbGOPE/6wHCHA/VKL23CPWZBlVU+l0/rCQIuEvq3NWeK0xrlU9BB55ko6d+fO0hbHPlw==
X-Received: by 2002:a5e:a50f:0:b0:75c:60a3:c4b8 with SMTP id 15-20020a5ea50f000000b0075c60a3c4b8mr7757655iog.13.1680132340967;
        Wed, 29 Mar 2023 16:25:40 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id a25-20020a027359000000b0039c492ae300sm10654825jae.114.2023.03.29.16.25.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 16:25:40 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] device: Fix not setting initiator flag when auto-connecting
Date:   Wed, 29 Mar 2023 16:25:37 -0700
Message-Id: <20230329232537.577958-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329232537.577958-1-luiz.dentz@gmail.com>
References: <20230329232537.577958-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If the device is marked as auto-connect the kernel may initiate the
connection spontaneously causing new connections to not have set the
state->initiator flag properly.
---
 src/device.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/src/device.c b/src/device.c
index f31f2a097e07..b43ced8b5c91 100644
--- a/src/device.c
+++ b/src/device.c
@@ -312,9 +312,16 @@ static struct bearer_state *get_state(struct btd_device *dev,
 
 bool btd_device_is_initiator(struct btd_device *dev)
 {
-	if (dev->le_state.connected)
+	if (dev->le_state.connected) {
+		/* Mark as initiator if not set yet and auto-connect flag is
+		 * set and LTK key is for a peripheral.
+		 */
+		if (!dev->le_state.initiator && dev->auto_connect &&
+					dev->ltk && !dev->ltk->central)
+			dev->le_state.initiator = true;
+
 		return dev->le_state.initiator;
-	if (dev->bredr_state.connected)
+	} else if (dev->bredr_state.connected)
 		return dev->bredr_state.initiator;
 
 	return dev->att_io ? true : false;
-- 
2.39.2

