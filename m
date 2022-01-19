Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2492BC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Jan 2022 06:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351773AbiASG1r (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Jan 2022 01:27:47 -0500
Received: from mx.msync.work ([95.217.65.204]:58688 "EHLO mx.msync.work"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351729AbiASG1q (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Jan 2022 01:27:46 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 99AE3268595;
        Wed, 19 Jan 2022 06:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1642573122; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=gFg+ke/Z2j4+lG2ytr+NSYtNJTydB+tssZm2cUg4qAk=;
        b=eyy9Zo10uYBCvqpyWw428uIUjui8bLIdDcMoOHtm1SXszrQ8aeH21jAg/qPfkE5oyIh1Tg
        olW8WnO1FJ6QTW9vH7EddIsNk0ubmryEPp65ObSO8Keh6bZVDndXxif5txAoNHY0+awRPJ
        1hiN+CcJgSRtH9mw/sJd+6iw4Yo6IVzo4zggMJsmqrKquMtj24yEZhzFMS84oYWh0RuQ4l
        x9PRH3Rp8dNv7qZBQEo6tTs53KLt3r3wvO6YPUarLzolCYxmcdgyWbwuVa2HG7n73dGtcD
        7Y9GdRR1Hqs2NIwPCm70D1moiDPlbBewg52qFRJO84/FvQd5BM5ldu+FFYrcnA==
From:   Vyacheslav Bocharov <adeep@lexina.in>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] Bluetooth: hci_h5: Add power reset via gpio in h5_btrtl_open
Date:   Wed, 19 Jan 2022 09:17:25 +0300
Message-Id: <20220119061723.2862683-3-adeep@lexina.in>
In-Reply-To: <20220119061723.2862683-1-adeep@lexina.in>
References: <20220119061723.2862683-1-adeep@lexina.in>
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
index 34286ffe0568..fdf504b0d265 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -966,6 +966,11 @@ static void h5_btrtl_open(struct h5 *h5)
 		pm_runtime_enable(&h5->hu->serdev->dev);
 	}
 
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

