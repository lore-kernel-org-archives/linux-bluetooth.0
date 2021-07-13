Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4326C07E95
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Jul 2021 08:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6877611CB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Jul 2021 08:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234615AbhGMIkA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 13 Jul 2021 04:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234525AbhGMIj7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 13 Jul 2021 04:39:59 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864A8C0613E9
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Jul 2021 01:37:10 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id a18-20020a056a000c92b02903282ac9a232so11440757pfv.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Jul 2021 01:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=GOSTPm1zw2J0V9+0BqttAvjk4eeZD9TwFHKnYj3BQV4=;
        b=LGeJYTKb9rSrUGzJOCcZE9yAfaWT2TU1shKl8EgFJp0jkgOYhBdRZbahPIBpOran/n
         ZDqxAnsZ0UOqEY+DhgjqAI+OdJhtCI9FKnti6uxqklr1hzNXFfMsZSRxIKTk3yfaNlNA
         HxhsiYMYUezFZUUOcX8qaVVMTfljHXTiWpOp0DJ6mGpHYBVi9XbkTtOJOIbYYbvQjHnl
         Upgd7OSwcV2n3s4MCVqGkqWMuhitHOHeGG1C/Pb86zi+ELD5eSvxbLqO7XQ95wTLQ7WG
         RKBQe5iTlprh0niGRnkMJhFc0Y2U+7vKimwzfrrrqhQmbjK8nV2jyKHz6mtE47m5N/l6
         PWAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=GOSTPm1zw2J0V9+0BqttAvjk4eeZD9TwFHKnYj3BQV4=;
        b=cYAXrSi95JFXF4TayJxN5wUafIJkF9OTCISDelpHTOYrAlaY9S1FQS6CpW4LIkTTfX
         jH6eiMzTfGoItApT1He4XAMQYt6UoBhkB7c5MoX2mePTV1kXEfR8TwnMDlav8RnVNRsA
         YTNoLG557R7R2mZV28Zqxd35+/yk0GaJw0N46qwTRc3EgLef6cfIRZVsfpK99q11G8Za
         v1kpGi2WpJPf0TKR386pZaRdTbzBMxfzcVS1DvcTXbPM9xJj98Jre8Kc5tygL2mBCEbr
         Zq0yRSkfxg6sE1OHcqiOkT051D6yS7tz/7eGjn/eT83dMSQSq70U96dVl/a1Cj8Flc0h
         N4ng==
X-Gm-Message-State: AOAM531ouxkBvx1SmDs0Yn4m7S7ZSttl/PaEcM6/wezkZ9CMq4FnXLte
        HJlZobzRoFTS5Mp7IpcnRy2Dni0xd7LWQK6SX90maDtsi9Q5Kax+O+732g/dZ3xsQ419Sytnfh7
        Pbg7gJ1ZE/nRVNJy1X4KMU2SjKgIhWMLS4AkbejXteHKZThIChUkjEpZZhk8kMrgqECVElFqyTh
        py
X-Google-Smtp-Source: ABdhPJyVjMC0P6XFI8tusJgqGWTxuYmxzXeiP4kX0o0Ve6mcdlskXA71zt5G6wm5Vt09KR/2ebihPysmvnj/
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:c4d1:1ac0:e4fe:3d1b])
 (user=apusaka job=sendgmr) by 2002:a17:90a:bc87:: with SMTP id
 x7mr224823pjr.0.1626165429413; Tue, 13 Jul 2021 01:37:09 -0700 (PDT)
Date:   Tue, 13 Jul 2021 16:37:03 +0800
Message-Id: <20210713163641.1.I2b8f2c16fab1ba67167461372a3bdb6817673303@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH] Bluetooth: btrtl: Set MSFT opcode for RTL8852
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Hilda Wu <hildawu@realtek.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

RTL8852 support MSFT HCI extension, therefore set the proper MSFT
opcode.

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Reviewed-by: Hilda Wu <hildawu@realtek.com>

---

 drivers/bluetooth/btrtl.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index cce0125ec4fd..1f8afa0244d8 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -681,11 +681,15 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 		}
 	}
 
-	/* RTL8822CE supports the Microsoft vendor extension and uses 0xFCF0
-	 * for VsMsftOpCode.
+	/* The following chips supports the Microsoft vendor extension,
+	 * therefore set the corresponding VsMsftOpCode.
 	 */
-	if (lmp_subver == RTL_ROM_LMP_8822B)
+	switch (lmp_subver) {
+	case RTL_ROM_LMP_8822B:
+	case RTL_ROM_LMP_8852A:
 		hci_set_msft_opcode(hdev, 0xFCF0);
+		break;
+	}
 
 	return btrtl_dev;
 
-- 
2.32.0.93.g670b81a890-goog

