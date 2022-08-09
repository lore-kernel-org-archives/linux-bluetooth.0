Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8612C25B0C
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Aug 2022 15:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243623AbiHIPgI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Aug 2022 11:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244518AbiHIPfu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Aug 2022 11:35:50 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFDA25F6
        for <linux-bluetooth@vger.kernel.org>; Tue,  9 Aug 2022 08:35:49 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-32851d0f8beso104471027b3.22
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Aug 2022 08:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=ufjJg4VVxq92WaQVQMCk9m8A9i0qlvuSNS+kFeik61o=;
        b=RXu3e9SK5+03ky70/ZSYqs7MjiZvc9YX8O0kcstuAXa9Vy+FUrLRu0P3u9RZbyS3GO
         uywN6ssmvzu30Orf42VVSWqugtBcqXvHbO8FJGI31043kSPsYS716n3vGr8BAJ9TASdz
         GQH5Ulz7Vt2ZkO3MryQ9PHpAw/exu8PIiXdNUmlAzpfpPM/G2vl1c1CuIDbvwMwy2N13
         MzTq+yNDPsiezUtdKXjhsA9X4v5L2Af97WhuVXu4dYIKgXSRWU5s2zt6KvVNYJKAhEVU
         Zvx+YQxCBYTmKKhb5OvQrIH+TwprGSeVeemIngULueJd6P3ixMGdgKFaE7ecH7qPaSkx
         jSKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=ufjJg4VVxq92WaQVQMCk9m8A9i0qlvuSNS+kFeik61o=;
        b=B69EOinkgQs9K0aO9HeR5EDVSAANW+TJDDnMhJZifetTr0wqFUZGeyc0XyA8K0geR6
         9D8X3/8bx1WOUkfrhEDF3mj7BlRP+r+blWh3chpBZyGErhnpTr3SqBDGmt1yoH7MItD6
         jyDx9pnTjYwi/4cMHaEwrCaonHba427GuKo0ghD764ukp0K9Hfwi+ZwI/xSDtqidEdpy
         YExmiGpaZ6bER+TZZ6QjbMn2R+FiJE2JsfaoBfokbQyVp0J3FPO3bPUEZ+n6B0rGYfsS
         apPXVtpJdqjzluOjt8lkcW048tnmuWPOStB8dPX71K1YizxQAswKv6nKilGXUZCO0o+q
         TV3Q==
X-Gm-Message-State: ACgBeo2m0UXbo2UZPxBeDqBIv2GNmBPBZoF/jU9sNAiiaHtvMLPyFHfU
        yUnQ64ZFZa6rXAmeULbkrKHB+EHrv8f9Iw==
X-Google-Smtp-Source: AA6agR50yechnFMMM/5FXSXojXIsB/DsnQjLhjvw2CWMNyh2fsc0MANYCEgYqrlhNUHXxpVmIu+tPlAXSV59cw==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:91a6:8007:96f6:3fb3])
 (user=mmandlik job=sendgmr) by 2002:a25:dc81:0:b0:67c:1421:12bc with SMTP id
 y123-20020a25dc81000000b0067c142112bcmr5401827ybe.267.1660059348675; Tue, 09
 Aug 2022 08:35:48 -0700 (PDT)
Date:   Tue,  9 Aug 2022 08:35:26 -0700
In-Reply-To: <20220809083112.v4.1.I5622b2a92dca4d2703a0f747e24f3ef19303e6df@changeid>
Message-Id: <20220809083112.v4.4.Id0d6e772f00432d55f6bcbf68a50cb4ad89396c6@changeid>
Mime-Version: 1.0
References: <20220809083112.v4.1.I5622b2a92dca4d2703a0f747e24f3ef19303e6df@changeid>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v4 4/5] Bluetooth: btusb: Add btusb devcoredump support
From:   Manish Mandlik <mmandlik@google.com>
To:     Arend van Spriel <aspriel@gmail.com>, marcel@holtmann.org,
        luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Manish Mandlik <mmandlik@google.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch implements the btusb driver side .coredump() callback to
trigger a devcoredump via sysfs and .enable_coredump() callback to
check if the devcoredump functionality is enabled for a device.

Signed-off-by: Manish Mandlik <mmandlik@google.com>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

Changes in v4:
- New patch in the series

 drivers/bluetooth/btusb.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 30dd443f395f..b00851327aa3 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1510,6 +1510,15 @@ static void btusb_isoc_tx_complete(struct urb *urb)
 	kfree_skb(skb);
 }
 
+#ifdef CONFIG_DEV_COREDUMP
+static bool btusb_coredump_enabled(struct hci_dev *hdev)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+
+	return !data->intf->dev.coredump_disabled;
+}
+#endif
+
 static int btusb_open(struct hci_dev *hdev)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
@@ -3765,6 +3774,9 @@ static int btusb_probe(struct usb_interface *intf,
 	hdev->send   = btusb_send_frame;
 	hdev->notify = btusb_notify;
 	hdev->wakeup = btusb_wakeup;
+#ifdef CONFIG_DEV_COREDUMP
+	hdev->dump.enabled = btusb_coredump_enabled;
+#endif
 
 #ifdef CONFIG_PM
 	err = btusb_config_oob_wake(hdev);
@@ -4180,6 +4192,17 @@ static int btusb_resume(struct usb_interface *intf)
 }
 #endif
 
+#ifdef CONFIG_DEV_COREDUMP
+static void btusb_coredump(struct device *dev)
+{
+	struct btusb_data *data = dev_get_drvdata(dev);
+	struct hci_dev *hdev = data->hdev;
+
+	if (!dev->coredump_disabled && hdev->dump.coredump)
+		hdev->dump.coredump(hdev);
+}
+#endif
+
 static struct usb_driver btusb_driver = {
 	.name		= "btusb",
 	.probe		= btusb_probe,
@@ -4191,6 +4214,14 @@ static struct usb_driver btusb_driver = {
 	.id_table	= btusb_table,
 	.supports_autosuspend = 1,
 	.disable_hub_initiated_lpm = 1,
+
+#ifdef CONFIG_DEV_COREDUMP
+	.drvwrap = {
+		.driver = {
+			.coredump = btusb_coredump,
+		},
+	},
+#endif
 };
 
 module_usb_driver(btusb_driver);
-- 
2.37.1.559.g78731f0fdb-goog

