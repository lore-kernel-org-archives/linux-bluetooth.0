Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75506C4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jul 2021 11:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5588160E8E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jul 2021 11:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234519AbhGWKvj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Jul 2021 06:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234488AbhGWKvi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Jul 2021 06:51:38 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E484DC061757
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jul 2021 04:32:10 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id a15-20020a170902eccfb029012b5663a1f7so1870854plh.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jul 2021 04:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1UqlY0KgIV9lGcr3KCNCk5kXAgTT0B278rOriYat9o8=;
        b=gQRtLTwI8nohOXOq3a88IKRKxe14x6kRa0CvzJCRTdKMX160cJAjg05T6KBrAzn/KR
         2190O5AjA1BdfzyVwI+UbVGHIKZpV71M9tmI1JGNx3KuJ0CK1PMJcsuVJoOjn+c+fqX0
         yG8r9ACcuFePnyT/J2FY2tK8taUdZsnNPEZw+oxoy4T1vgVSp1krNoI5nXPBF+5ifxF6
         5e7FIgj7jxWAaZbm0VruvahJ21yJexsOgdzbyY6LBobcXpBSa36MAZ/lKkoA3m2pa26A
         mdMzBredelyJtOgWeTZkj+RRfkLCiOoHhT91uDrLEMmvp5+zOY3CvPPSY0NnzH+Hi3Vw
         6lEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1UqlY0KgIV9lGcr3KCNCk5kXAgTT0B278rOriYat9o8=;
        b=j0C0H8xXZZkN7A/vwdS/jPedoR8YhALQ5z3Kua861+YUrgKdRx2gCPijl/7aIBxQCj
         zNKODKiFI3/mFeMhbtxoCjna89DbeXbgqBiUME4RHmEUq8z0rAgG56bVtoO4fSFGg3eU
         y19n1OUEkRf6eDw2FR0jVjWuIameRT8TxPQKwnxz3sbobj10eytDbIR+h7qFETF2EJxH
         0JBfQMpgSPdXLpan9Qos66uFN/S+/i1oKGeJVPds9ri144oebLC7i0d/tyFoirOvZOBl
         BIg9fPbLArn6iCsNzHSIB9CeKAJJromqMfJv8rjDBbYdSP12YxCll6ErbyOxbYP28OGK
         g4BA==
X-Gm-Message-State: AOAM530KLUb7YFsE1h0ouAxTgj+64QKBCYZ6rfDSC2rTfJQQ5nDFrY6w
        bkypTbqZYvirh0WnjkrEgXm1zGXR/WnB0DoTUZ9T8XWi/PHHrrDM/1zwMypNA3UZNDqak5cqqor
        /+qBD49msI//rNWRaa+VXNnxsz0ksx2oDOdnyR3jMC8sU3P7MaJQmxVJ+jSpuN9EhQtUQyFnfGE
        /4
X-Google-Smtp-Source: ABdhPJxOEDnc3AcVmn7792LuVNovHdsnYWk9IKZHI7i/4BPsFo6Fa2oYrS3WRJDK1X9sTL4l9ylgS1iz1j5s
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:ddde:33b:f989:cd76])
 (user=apusaka job=sendgmr) by 2002:a05:6a00:84d:b029:329:a067:b1bf with SMTP
 id q13-20020a056a00084db0290329a067b1bfmr4189827pfk.47.1627039930218; Fri, 23
 Jul 2021 04:32:10 -0700 (PDT)
Date:   Fri, 23 Jul 2021 19:31:56 +0800
In-Reply-To: <20210723193137.v3.1.I68649745bd11a83265f1e816bf34ecc82775e95a@changeid>
Message-Id: <20210723193137.v3.2.I404c6df9cdab270223c13e867396f440dd4b499d@changeid>
Mime-Version: 1.0
References: <20210723193137.v3.1.I68649745bd11a83265f1e816bf34ecc82775e95a@changeid>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH v3 2/3] Bluetooth: hci_h5: btrtl: Maintain flow control if
 wakeup is enabled
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Hilda Wu <hildawu@realtek.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

For chips that doesn't reset on suspend, we need to provide the correct
value of flow_control when it resumes. Therefore, store the flow
control value when reading from the config file to be reused upon
suspend.

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Hilda Wu <hildawu@realtek.com>

---

(no changes since v1)

 drivers/bluetooth/hci_h5.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index fd672111a048..cbc63b057f33 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -54,6 +54,7 @@ enum {
 	H5_RX_ESC,		/* SLIP escape mode */
 	H5_TX_ACK_REQ,		/* Pending ack to send */
 	H5_WAKEUP_DISABLE,	/* Device cannot wake host */
+	H5_HW_FLOW_CONTROL,	/* Use HW flow control */
 };
 
 struct h5 {
@@ -920,6 +921,9 @@ static int h5_btrtl_setup(struct h5 *h5)
 	serdev_device_set_baudrate(h5->hu->serdev, controller_baudrate);
 	serdev_device_set_flow_control(h5->hu->serdev, flow_control);
 
+	if (flow_control)
+		set_bit(H5_HW_FLOW_CONTROL, &h5->flags);
+
 	err = btrtl_download_firmware(h5->hu->hdev, btrtl_dev);
 	/* Give the device some time before the hci-core sends it a reset */
 	usleep_range(10000, 20000);
@@ -1012,7 +1016,11 @@ static int h5_btrtl_resume(struct h5 *h5)
 		queue_work(system_long_wq, &reprobe->work);
 	} else {
 		gpiod_set_value_cansleep(h5->device_wake_gpio, 1);
+
+		if (test_bit(H5_HW_FLOW_CONTROL, &h5->flags))
+			serdev_device_set_flow_control(h5->hu->serdev, true);
 	}
+
 	return 0;
 }
 
-- 
2.32.0.432.gabb21c7263-goog

