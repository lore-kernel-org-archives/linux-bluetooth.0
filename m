Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86670C4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 08:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B71A61050
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 08:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbhJYIv3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Oct 2021 04:51:29 -0400
Received: from hh0.msync.work ([95.217.35.189]:54404 "EHLO mx.msync.work"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232300AbhJYIv1 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Oct 2021 04:51:27 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 00D41171C91;
        Mon, 25 Oct 2021 08:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1635151742; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=qw+rUZnGqbazk5VM2kTqSsujsqnEaRKekmOX893lBO4=;
        b=yJDbkNvztyUPw4LzDojvhtyLysI9TWDR3WmSB2KjfLtGlCCuLBs4k4/yhBYmjLBf6fQ1tH
        6iPpdXKY8SUx1zYo153MJFhslXF0ma37TWMM2YJhJuQSy0Yj7VWhNXzeNGCRsR7r2YBxLe
        mXFyXsNhryJMDsvQjetoj+pG+0Ypbm5jYQ7CstIiA0ozTnJsJGApEatu5hVt9EDkoaaScL
        0Ty9D1DkNMlQFzjiBxrcWTC5RI8JeGMLZc1eNGOVdO27s7p0amlYwDxtqPMDWLb0q2Unpv
        96HjXCL6DWkrmXJsL1MXpKNnoO4Kjv+OMU25iGN7HoG+Nxe7Dk2sRN2xsCtbyQ==
From:   Vyacheslav Bocharov <adeep@lexina.in>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] Bluetooth: hci_h5: Add power reset via gpio in h5_btrtl_open
Date:   Mon, 25 Oct 2021 11:47:05 +0300
Message-Id: <20211025084704.173755-3-adeep@lexina.in>
In-Reply-To: <20211025084704.173755-1-adeep@lexina.in>
References: <20211025084704.173755-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add power reset via enable-gpios in h5_btrtl_open function.

Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
---
 drivers/bluetooth/hci_h5.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 0c0dedece59c..ab7c929cc25d 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -968,6 +968,11 @@ static void h5_btrtl_open(struct h5 *h5)
 					 SUSPEND_TIMEOUT_MS);
 	pm_runtime_enable(&h5->hu->serdev->dev);
 
+	/* The controller needs reset to startup */
+	gpiod_set_value_cansleep(h5->enable_gpio, 0);
+	gpiod_set_value_cansleep(h5->device_wake_gpio, 0);
+	msleep(100);
+
 	/* The controller needs up to 500ms to wakeup */
 	gpiod_set_value_cansleep(h5->enable_gpio, 1);
 	gpiod_set_value_cansleep(h5->device_wake_gpio, 1);
-- 
2.30.2

