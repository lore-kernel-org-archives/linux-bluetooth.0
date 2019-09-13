Return-Path: <SRS0=G9Zr=XI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7ADDC4CEC8
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Sep 2019 19:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 924D42081B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Sep 2019 19:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tB0nQCDs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387956AbfIMTAw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Sep 2019 15:00:52 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35565 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfIMTAv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Sep 2019 15:00:51 -0400
Received: by mail-pf1-f195.google.com with SMTP id 205so18648210pfw.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Sep 2019 12:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=whggwDw7tdsjWRQZn4mRXcpXyvGWPoDbChK+ch75XKc=;
        b=tB0nQCDsecMzL5RJlVs15nvOb5AWbuUwYn9bS7KiM1o12lVgWjzZZ8xo9fM+8wsM4O
         HLa6HQNAZIbL1Pqb+XfiDqwX/YBrycdWrP+hl0KyC50ZX38NMqoLqMs4sg948K4E/1Mc
         DgP7mQ58RvwpoZFTnjxalryIwCupQsGDjXlnG5nxi5Kar7uwsOYU5NltgG9aABz9XJ8S
         xqTTFr7kFFQw2NQF6m3K7VbdPm9BML1fNAt/2Dlnwm8xa4Sx2m55j93ps9CJRJTuY2Kq
         d7sFHSQbiPx7BbATcuKMbomb+DD9iB1gWxHje4HCcboFuucddHwpz3QMyYmc5F6wUo/l
         0eWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=whggwDw7tdsjWRQZn4mRXcpXyvGWPoDbChK+ch75XKc=;
        b=BzCPnqpVOs1Yb8kaNcJC/W+v2eQ1SyQj35jQDLzX1qnaOmSQOHFTmTUP7eOzq8L2xz
         l/zywbi8wnKjOD+Dxn7bNoxp0i1VE0dqlgPfS2mlFpKeky6fhu9b/orMhnAjHrsS+0xq
         Lt+XdFDPrNgpvYYKe5RFaQkrb2hVtL86uycMoK5rhdwXJvUHq+grRDGzjpjw3TYx+Wdh
         mx6Y6ESyrNXTrwz/xItb3vMDiaX3gf/DxLfro7NdUZ/dzm8TgIolT6jqGf4H91dXPvfP
         g2vbXjcleUaQ4TLPzwn2hBiGYuh5VwRWX5hT/Wt6MDK6Rg+G2UcSUz1Fl1p+0vclIsw5
         Yraw==
X-Gm-Message-State: APjAAAVYK2sTM8XT/fKoWYEJ4xChdFtfUtW5IOJqksZX2ItCOplDWCTs
        OWd+zfdNB/2oz8myA4+JOxCkktwGNkE=
X-Google-Smtp-Source: APXvYqxUZ/YsEU9E/Yb11Bu0QG/uUuN7pNd4yYXsk3yzERxl4BpLiW6gI4BaqpohyhcIm/LmRWvROg==
X-Received: by 2002:a17:90a:310:: with SMTP id 16mr7068468pje.100.1568401250287;
        Fri, 13 Sep 2019 12:00:50 -0700 (PDT)
Received: from inwotep.hsd1.or.comcast.net (c-98-232-219-225.hsd1.or.comcast.net. [98.232.219.225])
        by smtp.gmail.com with ESMTPSA id c15sm31874678pfi.172.2019.09.13.12.00.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Sep 2019 12:00:49 -0700 (PDT)
From:   Scott Mertz <scottmertz2@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Scott Mertz <scottmertz2@gmail.com>
Subject: [PATCH] device: cancel connection request if browsing is cancelled
Date:   Fri, 13 Sep 2019 12:00:41 -0700
Message-Id: <1568401241-24619-1-git-send-email-scottmertz2@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

If a dbus client calls Connect before service discovery is complete,
then attempts to cancel that by calling Disconnect, the original
Connect request would never be completed.

This fixes the bug by cancelling the Connect call upon cancelling
the browse request, which is done when Disconnect is called.
---
 src/device.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/device.c b/src/device.c
index 263f60a..b8247cf 100644
--- a/src/device.c
+++ b/src/device.c
@@ -626,6 +626,12 @@ static void browse_request_cancel(struct browse_req *req)
 
 	attio_cleanup(device);
 
+	if (req->msg && dbus_message_is_method_call(req->msg, DEVICE_INTERFACE,
+								"Connect")) {
+		DBusMessage *reply = btd_error_failed(req->msg, "Cancelled");
+		g_dbus_send_message(dbus_conn, reply);
+	}
+
 	browse_request_free(req);
 }
 
-- 
2.7.4

