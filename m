Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8D1C0015E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Jul 2023 13:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbjGZNa3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Jul 2023 09:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbjGZNa1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Jul 2023 09:30:27 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 81A31AC
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jul 2023 06:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=VbvvJuUsDhhMLc0Q9o
        qh53cbxVE2E2Kk8CdLOl5kv+4=; b=jnJhbaaJnGefe6mnzgehJl1dJQPMIzC1dW
        62ro8J+IrnD4jeFD1oKvxJMWrb5GBZtHtgV9kPpGJABNSQbKQq5UKjEpIbjEJAkA
        HKBq9AglkdZtwd2t6xi9JL23cEyXkVsOhNWtk1mv2etOAy5dFYTVBoIT12QfTgV+
        vJp5c4bDk=
Received: from localhost.localdomain (unknown [202.112.113.212])
        by zwqz-smtp-mta-g2-0 (Coremail) with SMTP id _____wAndqbaH8FkaLRyBQ--.6950S4;
        Wed, 26 Jul 2023 21:30:07 +0800 (CST)
From:   Yuanjun Gong <ruc_gongyuanjun@163.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Cc:     Yuanjun Gong <ruc_gongyuanjun@163.com>
Subject: [PATCH 1/1] bluetooth: nokia: fix value check in nokia_bluetooth_serdev_probe()
Date:   Wed, 26 Jul 2023 21:30:00 +0800
Message-Id: <20230726133000.20417-1-ruc_gongyuanjun@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wAndqbaH8FkaLRyBQ--.6950S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF1xAw4rXr1DJw4UZw15twb_yoWfKrgE9a
        97ZryfGF4jgrn3A3WY9F1UZrWIga4ruFnaqw1Iq3yYvr9rur9rJrsrXrsxtrW7urZ7Kr90
        yw45u3WSkr4rGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRN6pBDUUUUU==
X-Originating-IP: [202.112.113.212]
X-CM-SenderInfo: 5uxfsw5rqj53pdqm30i6rwjhhfrp/1tbiUQO45WDESbvfZAAAsi
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

in nokia_bluetooth_serdev_probe(), check the return value of
clk_prepare_enable() and return the error code if
clk_prepare_enable() returns an unexpected value.

Fixes: 7bb318680e86 ("Bluetooth: add nokia driver")
Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
---
 drivers/bluetooth/hci_nokia.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_nokia.c b/drivers/bluetooth/hci_nokia.c
index 05f7f6de6863..97da0b2bfd17 100644
--- a/drivers/bluetooth/hci_nokia.c
+++ b/drivers/bluetooth/hci_nokia.c
@@ -734,7 +734,11 @@ static int nokia_bluetooth_serdev_probe(struct serdev_device *serdev)
 		return err;
 	}
 
-	clk_prepare_enable(sysclk);
+	err = clk_prepare_enable(sysclk);
+	if (err) {
+		dev_err(dev, "could not enable sysclk: %d", err);
+		return err;
+	}
 	btdev->sysclk_speed = clk_get_rate(sysclk);
 	clk_disable_unprepare(sysclk);
 
-- 
2.17.1

