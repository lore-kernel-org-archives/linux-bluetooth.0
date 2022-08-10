Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E6FC00140
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Aug 2022 16:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbiHJQBG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Aug 2022 12:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233222AbiHJQAx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Aug 2022 12:00:53 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7491F5D0C0
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Aug 2022 09:00:52 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-324966c28e5so129049087b3.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Aug 2022 09:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=l7PZD+YaratyWuraoD6FFlyszu21r1R3dL9LFvoq6k0=;
        b=jcmeIl1NpNa7TnyD+eLPi7e6zk/kVWAJSsfHmHu3w/Xm5Sr84D4AnVAbdGqmxY1/rX
         b7fNe6NOGDHsFWsaGhR9f/rlfrEXlH6M9L1u4r3/Ir1sofL6f9v33e4TigWbRQ0Wch/t
         ia+r1izURNqhbIPH5MA4Bjb1fsSu6i0/HepEKJz0enLpMCBxfExi3+iyvcl1hQx/67zs
         UqWXZfV5UpzdnxNUFFTfYfXAnafT/Mxp9Ah54+yUeMXSCiyAiipmyL5suRHsanRZk3tv
         0Zogb17vBr2mpWIeQ9/Hoc740SfWND/RDfokXgF62wbF442ne4BhrnUWl+ti044445Tu
         NKrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=l7PZD+YaratyWuraoD6FFlyszu21r1R3dL9LFvoq6k0=;
        b=CZjGaynueMqMtR8IwxbalRJ72T4xhkKMBW1acDy4TkBDm9lil1M59nE2DhX2bg1lzH
         8CPlLlasAUuSVk67/KnEFy7H+0v7vZCBy3u39PJIJFd2xmMcS9TXVK+a683AwgMT2xpd
         QyxHQhocCNyloQedqkMUxDYUErUX4v8bRtvI4H9ljNJADYQnzoAvk8Lzc954LOpVX1xl
         niL6LoVtr4GwJcZGfnwtKwAAMZdSF0Z+A5fy0SYl8tPZQBLhNQpw5k9Xl4IyrF+w8H4Y
         YXWVqDY639yJyrmTn32GsdWnjj3sMQMmlVRFNP6mrsPXU8IaCJQ11qEkYu8Eza8Kzj6i
         p/vw==
X-Gm-Message-State: ACgBeo3YXLwHyg9r7+72J269KxHR3MLJ6PEorz+oUwyJqif/SKiYiCxz
        7oPf5mYPYJwGk0IhDOWyUyxhI1hKmWeTFg==
X-Google-Smtp-Source: AA6agR68Jx/wH/w50KMdlkv4S9EednDBP6Y2dFhbVSMU+HmwN9CXWaNd2gF+iXk9NxHzidZB/6AUpV38R0k8sg==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:1e7:803:63a4:33])
 (user=mmandlik job=sendgmr) by 2002:a05:6902:15cf:b0:67c:1ee7:149 with SMTP
 id l15-20020a05690215cf00b0067c1ee70149mr8637670ybu.594.1660147251724; Wed,
 10 Aug 2022 09:00:51 -0700 (PDT)
Date:   Wed, 10 Aug 2022 09:00:37 -0700
In-Reply-To: <20220810085753.v5.1.I5622b2a92dca4d2703a0f747e24f3ef19303e6df@changeid>
Message-Id: <20220810085753.v5.4.Id0d6e772f00432d55f6bcbf68a50cb4ad89396c6@changeid>
Mime-Version: 1.0
References: <20220810085753.v5.1.I5622b2a92dca4d2703a0f747e24f3ef19303e6df@changeid>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v5 4/5] Bluetooth: btusb: Add btusb devcoredump support
From:   Manish Mandlik <mmandlik@google.com>
To:     Arend van Spriel <aspriel@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Signed-off-by : Manish Mandlik" <mmandlik@google.com>,
        linux-bluetooth@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        chromeos-bluetooth-upstreaming@chromium.org,
        Won Chung <wonchung@google.com>,
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

(no changes since v4)

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

