Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352D2C76195
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Mar 2023 01:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbjC1BTZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Mar 2023 21:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbjC1BTL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Mar 2023 21:19:11 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8282118
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Mar 2023 18:19:05 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id q30-20020a17090a17a100b0023d376ac2c5so2753642pja.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Mar 2023 18:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679966344;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3IPXOF71xhyJEtqQ3Z98VllJlolVRDwWUwDqo2jNXHo=;
        b=XyFLtl/5xKP+J4XEIX0wfelHUuTwFHtfLQLUMR0MLPBm+IxTXAkLytPRNmH00qN7CH
         mdz9BCoC9fCDLYGDK5cwlaTJzjnBIzJVSlX88gvb41TAGW0G8pXsSXrRv7Xoehv3BBfH
         5hCvbAoGfljbkeVpDI2KuA8mWujfUE2JJCoWoRBi6zO9M05QXzuqCrpuzzQDGqXLTwui
         IbAQY74ug1vpWqD9DuoESSp+kvpKZQm4tRjcB9lRnt0D0doowOclDegh9iSgsSXciCZf
         jfE7URODKNcCcWOrI7tVPeIrEZFKaXXjkX2ApAI5nsczPfnh/qBYaRPlOsmpWTM6OplO
         jZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679966344;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3IPXOF71xhyJEtqQ3Z98VllJlolVRDwWUwDqo2jNXHo=;
        b=wOD43QUsFaLwHLefzB/o889Qcwa3a6CKP/8kVxKYKR/8suA4C/EKHVCgJBRSBPR2A+
         9vsDidsubsqwopkQVOj7v/sPfwAz9Shf1cSU65kzZQxxn/J+mBHC4mHoJZwRRge2nzze
         Kvn9ffshr8HfrF+Z8dHKSS3vE4mm83ZIv/oXUOIBbzQq3kYzMQvJajOKqWvj8wtozN0h
         F31EPb/15zr99j4/Mu9b1NoL7wUPCrHNcd/aXi1C9T/qB7XaCmesKGmr6NQixT/jjKpt
         BkS2Vx+hhdyZjfr6JfsCAnz98b1+YxTFiGTghELEKmMh0lsXLlf/zCz3ZUBpZud4+B6p
         6PaQ==
X-Gm-Message-State: AAQBX9eK3PQ92aW5HZLyYEgld8z6Wg6hf8Nt91VCCqPTnjcYTu1f0QQi
        +Juda1oia0m5CkcA5obGkTaOdetzdxHKWQ==
X-Google-Smtp-Source: AKy350aDQyXH8Z6uCN+o1t4aSklBoh4FNFzYy5pA6U0E0t0xbLqUtjmcFFEGh3nIbSf7k8AE1jLZQH9DUIoEIg==
X-Received: from mmandlik-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:2893])
 (user=mmandlik job=sendgmr) by 2002:a17:90a:3ec2:b0:23f:4b8d:2393 with SMTP
 id k60-20020a17090a3ec200b0023f4b8d2393mr4025254pjc.8.1679966344653; Mon, 27
 Mar 2023 18:19:04 -0700 (PDT)
Date:   Mon, 27 Mar 2023 18:18:56 -0700
In-Reply-To: <20230327181825.v9.1.I9b4e4818bab450657b19cda3497d363c9baa616e@changeid>
Mime-Version: 1.0
References: <20230327181825.v9.1.I9b4e4818bab450657b19cda3497d363c9baa616e@changeid>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230327181825.v9.3.I8cd97c192e8268567b6f467ccd993ec71897318e@changeid>
Subject: [PATCH v9 3/4] Bluetooth: btusb: Add btusb devcoredump support
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
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
trigger a devcoredump via sysfs.

Signed-off-by: Manish Mandlik <mmandlik@google.com>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

(no changes since v6)

Changes in v6:
- Remove dev->coredump_disabled check since the sysfs flag related
  change has been abandoned

Changes in v4:
- New patch in the series

 drivers/bluetooth/btusb.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 4ca91c033d2f..9c9f7bf1375a 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4385,6 +4385,17 @@ static int btusb_resume(struct usb_interface *intf)
 }
 #endif
 
+#ifdef CONFIG_DEV_COREDUMP
+static void btusb_coredump(struct device *dev)
+{
+	struct btusb_data *data = dev_get_drvdata(dev);
+	struct hci_dev *hdev = data->hdev;
+
+	if (hdev->dump.coredump)
+		hdev->dump.coredump(hdev);
+}
+#endif
+
 static struct usb_driver btusb_driver = {
 	.name		= "btusb",
 	.probe		= btusb_probe,
@@ -4396,6 +4407,14 @@ static struct usb_driver btusb_driver = {
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
2.40.0.348.gf938b09366-goog

