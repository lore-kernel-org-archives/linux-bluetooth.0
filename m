Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD68C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Nov 2021 22:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A773760C51
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Nov 2021 22:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbhKAWRT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Nov 2021 18:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbhKAWRS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Nov 2021 18:17:18 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D411C061714
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Nov 2021 15:14:43 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id f8so12868800plo.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Nov 2021 15:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h0AFW2bFI6/wwjrYbuD335gfu/P6DVc3rRtF0bPTdB8=;
        b=qI4qYGNdUoNmaaVPDFUcGDMrG8JQAlagPiEg9Pywo1N+QIih18HlAYlrYWxzGSk6of
         nn/quk884N3J+nqwQ1ZKtdLhy4ewpr0/ODAneW4wP9JL6X9UujA6KMvQJzQL1mvbuxls
         LQ94GpTS4dfm2EuIITt2dUErUUDTk8y0NG+xFscPVJzDmFRHQTse+NsrwgNH/oll8az8
         NpK2xKJVzKfy6+k+5JVVfC2Q667YZiWkV28eGl6UNUPgJ+0SUFKhdze5iiQ0tUukrP6V
         blY7zKhGRRqvs1ued7gQUKG8928T9KE6740vKhzYNQ+hdVKS/RLn1A1SdGaWcF0SiRvR
         9vLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h0AFW2bFI6/wwjrYbuD335gfu/P6DVc3rRtF0bPTdB8=;
        b=UTB0REf8zmycw/Kwh98npvOP1SIsA0P6h7EAZL0I+JzBi30pOXiJ6KKh3nkNrkhZ+j
         T/QMkKPxAQsO+tEkaIzRdWCpa0vKTmqk5XMaxzKycrOwlvhC627fGOzdfvJVRLUK4VkG
         Hpbt3yW+5cweoiEXkDWeraiXaDGdNrNq83tLNQGk9h87wlTXxWcihqACckYrjf4ujYLY
         yqLR7j/+GLX5STA5k6YQNdwkHbz9SvD8Mp8kr73FMfXuxyt9GizoWJq7UgBl0oi8SqUa
         H/tBYBZ/j4If8k7stfDWJublhKR9PrNYSwXzicTO9s5cn2zHI+qSJ7SJtgOrKiHypktj
         EXHA==
X-Gm-Message-State: AOAM53322145Tukp4yQBLueSnq3PWe0lZ8dUtZhC8r5OJKGeQhHXa9yE
        fqv7iCEnRiw1paG1gAyV6OAtRJ1Gn5U=
X-Google-Smtp-Source: ABdhPJwN8RvRKB47WPd/e+OPdHAjbaWHSEA4UQmbUmNtkYFvB5u2Ng/2Xa3rQYW0kaldzdHZQuYgFg==
X-Received: by 2002:a17:902:c20d:b0:142:21e:b1e8 with SMTP id 13-20020a170902c20d00b00142021eb1e8mr2650951pll.27.1635804882344;
        Mon, 01 Nov 2021 15:14:42 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id i11sm13901087pgp.18.2021.11.01.15.14.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 15:14:41 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_sync: Fix not setting adv set duration
Date:   Mon,  1 Nov 2021 15:14:41 -0700
Message-Id: <20211101221441.2764255-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

10bbffa3e88e attempted to fix the use of rotation duration as
advertising duration but it didn't change the if condition which still
uses the duration instead of the timeout.

Fixes: 10bbffa3e88e ("Bluetooth: Fix using advertising instance duration as timeout")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index fb7ecf24b89a..b794605dc882 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -895,7 +895,7 @@ int hci_enable_ext_advertising_sync(struct hci_dev *hdev, u8 instance)
 	/* Set duration per instance since controller is responsible for
 	 * scheduling it.
 	 */
-	if (adv && adv->duration) {
+	if (adv && adv->timeout) {
 		u16 duration = adv->timeout * MSEC_PER_SEC;
 
 		/* Time = N * 10 ms */
-- 
2.31.1

