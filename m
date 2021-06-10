Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDA8C48BDF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Jun 2021 18:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFB7E601FA
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Jun 2021 18:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhFJSUD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Jun 2021 14:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbhFJSUB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Jun 2021 14:20:01 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461C1C061760
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jun 2021 11:18:05 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id pi6-20020a17090b1e46b029015cec51d7cdso4358037pjb.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jun 2021 11:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gZVZzLDh5iZyA6/thJaaOvhV/DsBOubkxHItoDjTK4o=;
        b=HfSyWM1XHJa7MPkysmpKm1mEQ2mrGAkMXX4boU2ZeCGFLFJbiF8XtRBaX+bM/SKHiV
         zB/0XNNa9z43E3z2V8btrwfUp3Rrb2SG4yxBd+RTm+/ZPGMHTf0i7GjggFQ3KzHYm+yg
         nVcrnD4xiNu2Z7y46f/ru7NaRhHz19GURDrcI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gZVZzLDh5iZyA6/thJaaOvhV/DsBOubkxHItoDjTK4o=;
        b=aYQjKgwRVQ26mob2x3tGdBmEpG7bKREvP0lEXgpNKCPzD+j0qJR99Yj5PKcUVSdAeR
         UXBt3+7IHMW822kmufigd+jt8lmKcBAnPLfGhXIyVUdN/qaPqrykUT/2riJpOpMFfFQC
         sJGGfGkNbMNWjz6CKd9d7/Jhu0HwU5n8ABJ9oxBo9+cfVwtiwaNyWxQ/rUX1wXxD7HjB
         jCBaGfcolqzCbe5f9RqFTvWM9Sy4h7XwkVdXJg6cJFcENArzEiPeLEczJVeCBKDdkWZM
         o9qBu7f6IeSRhhEWKJ/vstC/Du7ebnHZxh9eymC6dKngMxBDSMIO9hWhFac3YqpeYslx
         +4lw==
X-Gm-Message-State: AOAM532CYheo/OuWenkBJmeOb4OI8l174qInsXRZKc7WtkTxV2gxDc9P
        V++ZfO94z2lWnrot9Ryk4kIJ/YHBD4tjAg==
X-Google-Smtp-Source: ABdhPJy++cnmiUoyRs+8rEaZKe65kVT/NfglL7cEi7OsFyT6ZXj2J6UOzV8DQHE0frh4DIE7gqw3Dg==
X-Received: by 2002:a17:902:8645:b029:fd:25ef:3df7 with SMTP id y5-20020a1709028645b02900fd25ef3df7mr19868plt.48.1623349084541;
        Thu, 10 Jun 2021 11:18:04 -0700 (PDT)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:f41d:dcc:661a:484d])
        by smtp.gmail.com with ESMTPSA id 4sm8526794pji.14.2021.06.10.11.18.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jun 2021 11:18:03 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [PATCH BlueZ] Check whether device is connected before attaching EATT
Date:   Thu, 10 Jun 2021 11:17:56 -0700
Message-Id: <20210610181756.430-1-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Due to a race condition, device_attach_att() may be reached when the
dev is actually already disconnected but dev->att is not yet cleaned up
by att_disconnect_cb(). Therefore we should check whether the dev is
connected before attaching EATT.

The race condition is discovered at rare cases when there is a very
quick reconnection after disconnection so that device_attach_att() is
called even before att_disconnect_cb(). This case is more probable to
happen when the host goes to suspend right before dev_disconnected() is
invoked and when the host is woken up by a reconnection the reconnection
is processed earlier than the cleanup in att_disconnect_cb().

Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>

---
 src/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index 65838f59f..319a929ee 100644
--- a/src/device.c
+++ b/src/device.c
@@ -5306,7 +5306,7 @@ bool device_attach_att(struct btd_device *dev, GIOChannel *io)
 		return false;
 	}
 
-	if (dev->att) {
+	if (btd_device_is_connected(dev) && dev->att) {
 		if (btd_opts.gatt_channels == bt_att_get_channels(dev->att)) {
 			DBG("EATT channel limit reached");
 			return false;
-- 
2.31.0

