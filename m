Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5768FC07E9C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Jul 2021 07:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41F2C613B2
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Jul 2021 07:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238267AbhGNHQo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Jul 2021 03:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238264AbhGNHQo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Jul 2021 03:16:44 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A99C06175F
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jul 2021 00:13:52 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id 100-20020aed206d0000b029024ea3acef5bso1361041qta.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jul 2021 00:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XTdrZ0dJFn1DaDa3LqHGHs3jtPZhxu1jdfiB7BtKgFo=;
        b=o7gIoRrnyXaH5I79tSNE/yWeSaLTBnVkThvhwXgKspB0bcJbBqSf7lmAqvuzVZHlK5
         GLv4babRtNAlx+IBFYehVNkprisSBvFPg27fuKeFqWiuHg/S0uyWcQVnFcv6rqSZ3VY8
         XyzGP1li9RxJwYX+X6aGYnnJRr/NthmMAFvPjdbyukGCIY78UP61luOLBbtxALhGW5Ob
         6Dpw3yRc/YL4zSfqedHQ3b74fwy8C+u1Gjqys4AhsE9SXJ51qDrVJBeWHn4iRvQXEMx8
         A5J8XxZkSkhFSxYumsZvuS2u4lNEwbSH6lql0Ma0jCHYAJiXZTS4U2K3DINovGizcOPJ
         Bl+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XTdrZ0dJFn1DaDa3LqHGHs3jtPZhxu1jdfiB7BtKgFo=;
        b=fdM12Y3BNKq617nAiZ+S/KX3Bx6Do2NLAV7dPr2qBLC3zJOokqChrouaPCsESqLBYs
         ENd3y78qW7M2dXs1OwAXp759b/PzbGe0k7eOVLstOvKCOjQw2henRvIiBXEMIoeVguZF
         ZJS4NmES60uarP9GxQeS5NYtT6goeYrMtcKJBWw1MVhlzyPmv6dqzc7n9zh0IGyORgH4
         fq4ubXSudxVsIyy4cQuX81yepWBC2iCH/yzK+qjzYtcrhKdRfbC4xnWrOBp5zL+n8C92
         Koc9RTqY9LO6YlhhTwgUiADbzPA+6hdSMVhI3/RQfAC+HN2s26mWsqv6qBtmgX0UN+GC
         kh8A==
X-Gm-Message-State: AOAM531Lf1nEzmsXKEgQtLJLLVMU+UV55tqOh4FlZH0xoC4/G7amIHZW
        eLuBvyU4JjigLWczbZRLfC0TxgtHJRT3NQzI3HSbzrv7VqNI5tIiD1AQFsJZP8lZA+aMscd0YS3
        I/Dfid123aF6dIPwoxxJSC5syyxfhFcFKrBtTHU9r6uRvUOznuxnJXx3l9693SEoFOuG4/e3a2q
        KI
X-Google-Smtp-Source: ABdhPJy8p7BkWUFja6u2+iuoz5FX+Add8fSQBRbgL/BXdoPiti4032Scw6UwbWF2CwpEaJWyZ07HJyMAkJr+
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:ecf5:ef03:eb15:e989])
 (user=apusaka job=sendgmr) by 2002:a05:6214:e6e:: with SMTP id
 jz14mr9102781qvb.55.1626246831175; Wed, 14 Jul 2021 00:13:51 -0700 (PDT)
Date:   Wed, 14 Jul 2021 15:13:39 +0800
In-Reply-To: <20210714151332.1.I68649745bd11a83265f1e816bf34ecc82775e95a@changeid>
Message-Id: <20210714151332.2.I404c6df9cdab270223c13e867396f440dd4b499d@changeid>
Mime-Version: 1.0
References: <20210714151332.1.I68649745bd11a83265f1e816bf34ecc82775e95a@changeid>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH 2/3] Bluetooth: hci_h5: btrtl: Maintain flow control if wakeup
 is enabled
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

 drivers/bluetooth/hci_h5.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 947246569434..67fcf192d5c5 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -54,6 +54,7 @@ enum {
 	H5_RX_ESC,		/* SLIP escape mode */
 	H5_TX_ACK_REQ,		/* Pending ack to send */
 	H5_WAKEUP_DISABLE,	/* Device cannot wake host */
+	H5_HW_FLOW_CONTROL,	/* Use HW flow control */
 };
 
 struct h5 {
@@ -923,6 +924,9 @@ static int h5_btrtl_setup(struct h5 *h5)
 	serdev_device_set_baudrate(h5->hu->serdev, controller_baudrate);
 	serdev_device_set_flow_control(h5->hu->serdev, flow_control);
 
+	if (flow_control)
+		set_bit(H5_HW_FLOW_CONTROL, &h5->flags);
+
 	err = btrtl_download_firmware(h5->hu->hdev, btrtl_dev);
 	/* Give the device some time before the hci-core sends it a reset */
 	usleep_range(10000, 20000);
@@ -1015,7 +1019,11 @@ static int h5_btrtl_resume(struct h5 *h5)
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
2.32.0.93.g670b81a890-goog

