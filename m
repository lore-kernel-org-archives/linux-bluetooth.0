Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD60BC4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Oct 2021 09:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6EBA6103C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Oct 2021 09:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237410AbhJ0JRB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Oct 2021 05:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237307AbhJ0JRA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Oct 2021 05:17:00 -0400
Received: from mx.msync.work (mx.msync.work [IPv6:2a01:4f9:2b:2dc2::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE95C061745;
        Wed, 27 Oct 2021 02:14:35 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0E88517A1C3;
        Wed, 27 Oct 2021 09:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1635326074; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=gFg+ke/Z2j4+lG2ytr+NSYtNJTydB+tssZm2cUg4qAk=;
        b=TgccEWLE9/alXy9g4clER9pgC5I9gvpSJSoqAFb8XqVaHs1RKDKS0lJCx2tNlDKAKWUc7F
        LgV4xqaMhC/z/FKCL5ou8wNyIdQJfeJ4q/IBOCcD/YI5UfmiEvCqY7DDCDX6hUKOQ8Tgvu
        xzcM9crxcce4gJiTf9pDmkG3JnMUFOQH6lwOWKubZSQYP28NPV+zRt3phgL3s8vxHjdh4u
        gOtY0aXFwO4MbPZwrmHb6WFHWwFbXUzyd9VdmUC19OEsMOp/TuClcIuDPVZLr01uVrGsj+
        p02UXv+pE8o0F0JdGFx4Doj9qSp9deW9ddssam88QEDSVAknekPrzOfF5UOyCA==
From:   Vyacheslav Bocharov <adeep@lexina.in>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] Bluetooth: hci_h5: Add power reset via gpio in h5_btrtl_open
Date:   Wed, 27 Oct 2021 12:14:16 +0300
Message-Id: <20211027091416.1577668-3-adeep@lexina.in>
In-Reply-To: <20211027091416.1577668-1-adeep@lexina.in>
References: <20211027091416.1577668-1-adeep@lexina.in>
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

