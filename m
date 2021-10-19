Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B18FC43219
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Oct 2021 10:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB4FD61374
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Oct 2021 10:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235189AbhJSKGz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Oct 2021 06:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235225AbhJSKGv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Oct 2021 06:06:51 -0400
X-Greylist: delayed 406 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 19 Oct 2021 03:04:38 PDT
Received: from mx.msync.work (mx.msync.work [IPv6:2a01:4f9:2b:2dc2::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA9CC061769
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Oct 2021 03:04:38 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1C7D3160F41;
        Tue, 19 Oct 2021 09:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1634637477; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=qw+rUZnGqbazk5VM2kTqSsujsqnEaRKekmOX893lBO4=;
        b=s4og12gMK3fH7yjzFMFblpoOjRjqj7B2KMfAO8pJfTNxYwqDBpgXEd/7V+HMOMooYBP1OJ
        hbza7Pxy7rXPth+lP9GIcHDMHvPQlja/ml4qxy6PRuoc6RWGiRkaM4NALQQoSkkd9BQdr8
        eZ9088yKZfMTiiVnc9YmJ1+ADCW7H7BZ+FZAdE9ih8NwRBOayW6h17vm6PjEpWla/F/cz6
        rgmzdmK5BU5H3UiK+oGxBL+hsiU+hp5Ko1Ca8Ba9QHAsa/Ph5pVp3sC4dof6l7+zT1wTsn
        D32/rXwuHt0E/ZX2y2OY22HpTfMdDyDg0JyVZlj6Z1kC4wFu/zpv4tGYWBhTNg==
From:   Vyacheslav Bocharov <adeep@lexina.in>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: hci_h5: Add power reset via gpio in h5_btrtl_open
Date:   Tue, 19 Oct 2021 12:57:38 +0300
Message-Id: <20211019095738.2098486-3-adeep@lexina.in>
In-Reply-To: <20211019095738.2098486-1-adeep@lexina.in>
References: <20211019095738.2098486-1-adeep@lexina.in>
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

