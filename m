Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6DFC6FD18
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Mar 2023 21:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjC2VJy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Mar 2023 17:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjC2VJh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Mar 2023 17:09:37 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC198A2
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Mar 2023 14:09:36 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id k17so7438154iob.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Mar 2023 14:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680124176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uv/Rss/Bp/HiNBtdFao8ULnALtaK28uPE6m0zgLq7l8=;
        b=XsUffNeQGTIpqfksaXhy84s3RCJo0woQgap80A7e5t5+ZM9mNUl6PgTM747C5RPZNi
         tavfK1BVuY9k1GTYmXXeeIMGlh6NL1np2MP4p6dR5ZusjqUTMFpQGtn8J+agbQWyYMI0
         FgmqFjBTTU5bxyF5HzoU2fflzxmRaYlaqwCx0y4Oc++SjTPmD6UBB2JTppTh/Up7YJ3J
         LqePi7dVfzmrZM+m9Jz2eFdi20qdsEy6bZIuId4aEkMP4q8ipO2x3baUHARlLqtJozQ7
         TWbR7rZmrMZcAaL2EOy5vkl5Q7z7bM2zAVFMubsWY1tKOoAQK0Pvexlk+Rajs+9NWw3l
         YBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680124176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uv/Rss/Bp/HiNBtdFao8ULnALtaK28uPE6m0zgLq7l8=;
        b=No5iM0xYu9XZ/OgL3ZqtKUeVKV+YThGFa0RzekRhvdGeIO3741BYQ8L/uE5pNhCeRI
         PBeDTaNV2Gd+d1Nj+abNYD/1cpGajaILnIz6uzHUWnFH5oJcyJOKeGYF+j9smWANUQBF
         jYpeYZmJEIKPx7bSWMSORrgWKJHu1ELVzAgHKU0k2FfS6pRq9FCThV+YPuowPXbWFud1
         CsL6Fyryu+0YqeVJ/SoGg5Fdya5Wttj4RAWys0qnMglIFmp/rCwIJmtX2yrKK6xnN/oB
         BmSkx0UuKPdfcz/cZORno64/HJi7iNtahZi8/35ZkoCL/ay25x39E9yYo70+q8BiYMnV
         e6qQ==
X-Gm-Message-State: AAQBX9fDKWoQHiIaSK1yA/6i6ec49TwBfFcfq+hrYw2DY0WvMWQ9qD83
        4uvwI8NH2+AnT4DcyRfZ7K5mxSKela6NUQ==
X-Google-Smtp-Source: AKy350bD8nBlUsLeAXchklNMZFK4CsPA/1RIOJDf8CBAM3UniMNNPTh+K2GE3VMhSHrAYtqlxvEypQ==
X-Received: by 2002:a6b:5d10:0:b0:752:6f1b:63a2 with SMTP id r16-20020a6b5d10000000b007526f1b63a2mr2092143iob.3.1680124176154;
        Wed, 29 Mar 2023 14:09:36 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id 71-20020a020a4a000000b004040f9898ebsm11009631jaw.148.2023.03.29.14.09.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 14:09:35 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] device: Fix not setting initiator flag when auto-connecting
Date:   Wed, 29 Mar 2023 14:09:32 -0700
Message-Id: <20230329210932.537019-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329210932.537019-1-luiz.dentz@gmail.com>
References: <20230329210932.537019-1-luiz.dentz@gmail.com>
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
index f31f2a097e07..c538742b683f 100644
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
+	} if (dev->bredr_state.connected)
 		return dev->bredr_state.initiator;
 
 	return dev->att_io ? true : false;
-- 
2.39.2

