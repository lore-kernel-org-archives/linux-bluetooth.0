Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC51C433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Jan 2021 21:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0349722DD3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Jan 2021 21:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730238AbhASVFH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Jan 2021 16:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729145AbhASUo6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Jan 2021 15:44:58 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35F3C0613D3
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Jan 2021 12:43:26 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id g3so11233906plp.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Jan 2021 12:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wsfZjzlNzJXVW++ya1lrDyULLQkDWoVC/E0GTcKu51k=;
        b=ee5dAIFBSCWqkpeMwwe2Q5AQnVcdwExjk+0JJ3ZY+5vKlD4PfmYwhdrvPq/3nzGkjR
         LWEEGlR9t/jobNVnioo1lLPJU0fh4gTUoxxhwIfxlkvGErJrLnnpcNQjkagpKDQ+A9m8
         HMxNfCi+2xn+EHNLyh2/v80Q0KfGHp1adQqA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wsfZjzlNzJXVW++ya1lrDyULLQkDWoVC/E0GTcKu51k=;
        b=m34EMf74FDWtv4kepT1tQuvIdDDf57cmrG1EHT8EsGGnium+D0m/+O8lghP8zhDz4d
         s0+GRwiZpYCfUPqLcZRfDwHy3DKfrslJgjeDBIo20/6zNFFqJbwnbgrLnvcRPsqy810K
         9wBlJ258xpipyqRd5rdsXi+aPB9NANyRT7NUZ/W+p7RhwTsH9Rufyj2wrzXdVgS1/fOm
         BI4L8sFB7DwXA4Q+u4+Isl+szYhHtq9aKz3hJWKDLkH4t5dZPuI5sjOIkAC/eW1FFRtt
         ZuuwkTHmTtC8i9SwbtqoLvpA0zzmBTmsHk6hi1Wec7hcggJFZIQFcv2qT3y9ARI9AGrt
         YXyQ==
X-Gm-Message-State: AOAM532gWRJgi3valKj580PNNkO9GAKejxHNl+/2K7fb7rKp0kz8w5ys
        Lnq1toMqOfvc6h3LjrGerGgspQ==
X-Google-Smtp-Source: ABdhPJydbVhkgkAOI+VFO4e2Os6eSIgJINtaIF/pQjNKUmVP045sHTczGR+2I740dosNO1DABMG8qw==
X-Received: by 2002:a17:902:ec06:b029:de:67a0:989d with SMTP id l6-20020a170902ec06b02900de67a0989dmr6506516pld.53.1611089006265;
        Tue, 19 Jan 2021 12:43:26 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id x15sm13835pfa.80.2021.01.19.12.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 12:43:25 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org, mcchou@chromium.org,
        michaelfsun@google.com, linux-bluetooth@vger.kernel.org,
        apusaka@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: btusb: Expose reset gpio to debugfs
Date:   Tue, 19 Jan 2021 12:43:14 -0800
Message-Id: <20210119124258.3.I7c6ae9b637f9a77f6e6f2e4256c6a0232476be43@changeid>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
In-Reply-To: <20210119204315.2611811-1-abhishekpandit@chromium.org>
References: <20210119204315.2611811-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

If btusb has a reset gpio, expose it to userspace so we can toggle the
reset gpio directly. This is useful for testing and error recovery.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

 drivers/bluetooth/btusb.c | 46 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 880e9cd4ee713..702be1871ed88 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -6,6 +6,7 @@
  *  Copyright (C) 2005-2008  Marcel Holtmann <marcel@holtmann.org>
  */
 
+#include <linux/debugfs.h>
 #include <linux/dmi.h>
 #include <linux/module.h>
 #include <linux/usb.h>
@@ -574,6 +575,46 @@ static void btusb_toggle_gpio(struct gpio_desc *desc, unsigned int duration)
 	gpiod_set_value_cansleep(desc, 0);
 }
 
+#ifdef CONFIG_DEBUG_FS
+static ssize_t btusb_debugfs_has_reset_gpio(struct file *file,
+					    char __user *user_buf,
+					    size_t count, loff_t *ppos)
+{
+	struct hci_dev *hdev = file->private_data;
+	struct btusb_data *data = hci_get_drvdata(hdev);
+	char buf[3];
+
+	buf[0] = data->reset_gpio ? 'Y' : 'N';
+	buf[1] = '\n';
+	buf[2] = '\0';
+
+	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
+}
+
+static ssize_t btusb_debugfs_reset_gpio(struct file *file,
+					const char __user *user_buf,
+					size_t count, loff_t *ppos)
+{
+	struct hci_dev *hdev = file->private_data;
+	struct btusb_data *data = hci_get_drvdata(hdev);
+
+	if (!data->reset_gpio)
+		return -EOPNOTSUPP;
+
+	bt_dev_warn(hdev, "Debugfs triggering HW reset via gpio");
+	btusb_toggle_gpio(data->reset_gpio, data->reset_duration_ms);
+
+	return count;
+}
+
+static const struct file_operations reset_gpio_fops = {
+	.open		= simple_open,
+	.read		= btusb_debugfs_has_reset_gpio,
+	.write		= btusb_debugfs_reset_gpio,
+	.llseek		= default_llseek,
+};
+#endif
+
 static void btusb_gpio_cmd_timeout(struct hci_dev *hdev)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
@@ -4625,6 +4666,11 @@ static int btusb_probe(struct usb_interface *intf,
 	if (err < 0)
 		goto out_free_dev;
 
+#ifdef CONFIG_DEBUG_FS
+	debugfs_create_file("toggle_hw_reset", 0644, hdev->debugfs, hdev,
+			    &reset_gpio_fops);
+#endif
+
 	usb_set_intfdata(intf, data);
 
 	return 0;
-- 
2.30.0.284.gd98b1dd5eaa7-goog

