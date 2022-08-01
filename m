Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2178C00144
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Aug 2022 22:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbiHAW5H (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Aug 2022 18:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbiHAW5F (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Aug 2022 18:57:05 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D6229822
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Aug 2022 15:57:05 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id f11so10890213pgj.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Aug 2022 15:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zGTSp5JZjYvfyaVfDTaI1pBiLT+ktc1Kshk6i30iUo0=;
        b=MxsZsdoaJUBRUzyU7DUaLq1G71fU45S55506k+CJOcw2CDcSlUhzbePifqst6oas2v
         2wPSOtJy+lsNkDeN91pHeb3KoFlNRS7Jh/naXJ9HXD4Bd1d4ecrVzKUBhYCW97+byVfw
         riridxB20SEzQjMrWGvj0XHgTGdTpCn24eWXzJ+NRCkCgbqwp0bt+l2VqEUEo5PWwz5L
         8JrLnhyKulyle5c7nzhbkXH/jd0N1FXcjF7EnURVeNBcBnjN6xduGTbwBvhJgqacIliU
         Wb9IErCzOkxTcPaCzBDwBNusfQq5lz2+E10XHlEeOUHiJTedRYup0hYMSwxbvk1e7yiz
         X3uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zGTSp5JZjYvfyaVfDTaI1pBiLT+ktc1Kshk6i30iUo0=;
        b=7pLvo1IFCqnkc47uNlZOmGfr7oLmYkjVo3hQk9gwzgqDtrSv8U75AdnIN+zY6q3dE2
         FmQf6mUmOtu99LKscmh5fu+ok9WCZH7PXzoV1BkPQ4rk0tSQTEgnOxP+mhyUKTNCzJIC
         BLTN7X5zRCoRhZGhQApDE18HIEo+kwl3vMnT4BzmikWbosNCAEs3AqV33+erD5+Uw8aY
         oeEmUpu7547doUXO72n5ZHS3+y3uvoZSEyU2xNcQTxcd/cO8ukuMRjeByb3qbv2BRvWH
         mdDX+g8wYCCTDEowKSEIL8Muizvpj/WXIeoz4IFzks9MSMgZPELIJpPRquhmAYs6inXI
         EQog==
X-Gm-Message-State: ACgBeo1r0NXk+boQJUq2VmOEA09UBiMf0J8s/JIwHPRcrx2Nx8VdqvZj
        uKBskeQk8a79QyHQOTxFVa9PKGv0m34dTw==
X-Google-Smtp-Source: AA6agR7rCKnToKKEGxxTOwVXKdhyjcnbS7eQpkrWwAm4Y+/GVHNtIr3+kkLCBQzkRTpDjOLCkaS8uQ==
X-Received: by 2002:a65:6e96:0:b0:41b:d634:ea7d with SMTP id bm22-20020a656e96000000b0041bd634ea7dmr9485507pgb.130.1659394624195;
        Mon, 01 Aug 2022 15:57:04 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id u18-20020a17090ae01200b001f2fc3828e4sm9513007pjy.24.2022.08.01.15.57.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 15:57:03 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: L2CAP: Fix l2cap_global_chan_by_psm regression
Date:   Mon,  1 Aug 2022 15:57:02 -0700
Message-Id: <20220801225702.2278772-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The patch d0be8347c623: "Bluetooth: L2CAP: Fix use-after-free caused
by l2cap_chan_put" from Jul 21, 2022, leads to the following Smatch
static checker warning:

        net/bluetooth/l2cap_core.c:1977 l2cap_global_chan_by_psm()
        error: we previously assumed 'c' could be null (see line 1996)

Fixes: d0be8347c623: "Bluetooth: L2CAP: Fix use-after-free caused by l2cap_chan_put"
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
v2: Fix lkp findings.

 net/bluetooth/l2cap_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 77c0aac14539..1c39fc40591b 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1970,11 +1970,11 @@ static struct l2cap_chan *l2cap_global_chan_by_psm(int state, __le16 psm,
 						   bdaddr_t *dst,
 						   u8 link_type)
 {
-	struct l2cap_chan *c, *c1 = NULL;
+	struct l2cap_chan *c, *tmp, *c1 = NULL;
 
 	read_lock(&chan_list_lock);
 
-	list_for_each_entry(c, &chan_list, global_l) {
+	list_for_each_entry_safe(c, tmp, &chan_list, global_l) {
 		if (state && c->state != state)
 			continue;
 
-- 
2.37.1

