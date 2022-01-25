Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727F4C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Jan 2022 19:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiAYTPr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Jan 2022 14:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiAYTPl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Jan 2022 14:15:41 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B48EC06173B
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jan 2022 11:15:39 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id my12-20020a17090b4c8c00b001b528ba1cd7so3783011pjb.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jan 2022 11:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=90Rsd9S5sCie3fkjUwL0VkPzd5MJ2oyJVN24o7150xo=;
        b=WcwbaIObKh43pJ7Ip/TE2cxPsLTAOTLgSvsxFGzNJNXEuQOirEi/2yn9kqWUtKR3OM
         c+fQleNAA3C4giz0gTB73e08AqXPd+YZryWN7TrYwKpXtftrVn0VHc6w9lrKRk1iomLh
         oeScNBhVOupTEapogGtDrM5L9B7PG0YEuuEp2n0ym8CSXmOgNldadnXvJm/S8mVTzexf
         S8NF4UZt3yOOyM24sRwKdy50IreBiBjyb8W3RaClB6kleE5N9bRzzbuC8kOLx+VkO5/C
         xWYPmNZWQYo0wMkVAew8XlAALxBZ8l6r66Sd36Z3nDjt85LYPoKbSWUGWQVC4Uy4UHKi
         AgTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=90Rsd9S5sCie3fkjUwL0VkPzd5MJ2oyJVN24o7150xo=;
        b=1v2qN6Vlu+JqnLpoxciadZDFp+zL8vJ+GEnSkuJeB39e4QnC6F6d0/DuPmdSSkJumd
         Xt0Ds/BM8fToIosEQ0XXEcbQ84jDcGtWVVgd5XVGWz63foQDhyFUzBtrdyOxCImKQjm/
         QMZBWdnVIUD5QTmaKsi27Jbl27pzubgjQkxarmtnZ/I/F2jAW8rH/qnaFFkaU5ZwxQlx
         eDTCSlJQXF2G8cE4g4QVu0b8aur4VtWXZ+8PILZYht/S8z7eb7WKlgEpTYL+yWJQ+oYD
         Z8ylEOyuSastKOEHNRqnlaWYuwW4me+2J9QCNeABfjf9CbEdDTL2DRtHRQSCuWm7fQsl
         cu5g==
X-Gm-Message-State: AOAM533K64XSQx1t28/mMaiFUs1T8ZKIvFgEMUWGKwOmlO0meAoofNX2
        E3k2V7Hx+uWBfZ8OQb6Y6fJ0+BUis7yY8w==
X-Google-Smtp-Source: ABdhPJwAXiPqDRpj6+V5Z9dJIPRGkdkozLPkgvjneDanuejoCPTdrHTsOBEoOG7XhGiaArBlNEl9VQ==
X-Received: by 2002:a17:90b:1c10:: with SMTP id oc16mr4974669pjb.22.1643138138697;
        Tue, 25 Jan 2022 11:15:38 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id rm12sm1151862pjb.36.2022.01.25.11.15.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 11:15:38 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_core: Rate limit the logging of invalid SCO handle
Date:   Tue, 25 Jan 2022 11:15:37 -0800
Message-Id: <20220125191537.2426630-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The invalid SCO handle error is normally caused by a race in the USB
transport where the data and event happen to be 2 different endpoints
so the event carrying the SCO handle is processed after its data.

Note: This can probably be resolved with use of force_poll_sync
debugfs.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 14c2da9d33ff..5bde0ec41177 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3667,8 +3667,8 @@ static void hci_scodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 		sco_recv_scodata(conn, skb);
 		return;
 	} else {
-		bt_dev_err(hdev, "SCO packet for unknown connection handle %d",
-			   handle);
+		bt_dev_err_ratelimited(hdev, "SCO packet for unknown connection handle %d",
+				       handle);
 	}
 
 	kfree_skb(skb);
-- 
2.34.1

