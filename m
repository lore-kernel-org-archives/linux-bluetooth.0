Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80764C4332D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Mar 2021 17:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 527AC64E41
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Mar 2021 17:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbhCORk1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Mar 2021 13:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbhCORkK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Mar 2021 13:40:10 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CD9C06174A
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Mar 2021 10:40:10 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id lr10-20020a17090b4b8ab02900dd61b95c5eso12547457pjb.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Mar 2021 10:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=1QRTYL/qfHiJl9D96KntKuYluhYdC3omopKQYWCwxTQ=;
        b=uEKj4duB8DS3IFSBSyQw0db2cT7CvpBKewMHq7ZbAGIHiQbzKHpFGPDobKYWvJIbfC
         GjzOnfPleUO23QygJLwxIYyclJ2DdHiRzEsm4NL0fGLtV/wNyyQiColveEz+7ht9q6Bk
         xxPAgxnlUeVjERrFpzAE/BdB9qfTT2fznpbDOypxb0nd5h7Jj8P7JX3NyjovhqpK1KsB
         xFwrSZnF3sd3kVnV6apeQSOEXQg69d7NUc2lUMW/20kUoEddNVgBIME4vfbUjQBEd5sV
         JVF6pTSRHCCOA3YllGfdZfneuTlTk42FTBc0mgQpNQlaf6EJcWKFFyKFRpCi0q6i1AZ0
         sZrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1QRTYL/qfHiJl9D96KntKuYluhYdC3omopKQYWCwxTQ=;
        b=VYw8+YIhmXbssidXCWBuLSEwF997vwuSN0ylJPWOGIBoZJKPt98vIETwiEUAoPEEDF
         RWLxUE0Y2V9mB7vIv38HvtJq5xcGi5UlbwAsKKoqXWgPycyZEhaztT7cJvkyP4jiCV+D
         HUhyGSPbFfanx5B0KI0NPB+A1dW7seu6/a5HCT0cNu7uJqgY5dPBjTq0X9uzEBSs1j2u
         7qB5LyRzlU+uGYwcQ6RWTen1L/WydqK4yFWTB6pGqjFwyz7jmbKgaEH3LBH5BSUadUrW
         a1lES2g9GmsW4NHrAeIbyIZQGwmtpWS/X1c0lcBFt4NbfkXItfzVELYiNeKnDJczBkgF
         Zavw==
X-Gm-Message-State: AOAM532QhEAqYhq49nURvignKONGBYc2Kb4JiPGtdFGvjAYe5pLMLGPx
        jRV2TuZXrj2o3Req7chbst0ruHf6C5jbrA==
X-Google-Smtp-Source: ABdhPJy6qCdhck3MspMkWU/bPzn7XsViYf2cHTZ9HUQwNd9AiQ5d3ol/SQ6ytRQAzXwTXoLmj6fw8Q==
X-Received: by 2002:a17:902:fe0d:b029:e5:ffb8:1c28 with SMTP id g13-20020a170902fe0db02900e5ffb81c28mr12488731plj.62.1615830009276;
        Mon, 15 Mar 2021 10:40:09 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id fa21sm246914pjb.25.2021.03.15.10.40.08
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 10:40:08 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v9 6/9] Bluetooth: btusb: Consolidate code for waiting firmware to boot
Date:   Mon, 15 Mar 2021 10:39:59 -0700
Message-Id: <20210315174002.1778447-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210315174002.1778447-1-luiz.dentz@gmail.com>
References: <20210315174002.1778447-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This moves duplicated code for waiting firmware download completion to
a function that can be reused.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/btusb.c | 148 +++++++++++++++++---------------------
 1 file changed, 66 insertions(+), 82 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 49bfa964ae8d..c6e84320e8b7 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2797,6 +2797,68 @@ static int btusb_intel_download_firmware(struct hci_dev *hdev,
 	return err;
 }
 
+static int btusb_boot_wait(struct hci_dev *hdev, ktime_t calltime, int msec)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+	ktime_t delta, rettime;
+	unsigned long long duration;
+	int err;
+
+	bt_dev_info(hdev, "Waiting for device to boot");
+
+	err = wait_on_bit_timeout(&data->flags, BTUSB_BOOTING,
+				  TASK_INTERRUPTIBLE,
+				  msecs_to_jiffies(msec));
+	if (err == -EINTR) {
+		bt_dev_err(hdev, "Device boot interrupted");
+		return -EINTR;
+	}
+
+	if (err) {
+		bt_dev_err(hdev, "Device boot timeout");
+		return -ETIMEDOUT;
+	}
+
+	rettime = ktime_get();
+	delta = ktime_sub(rettime, calltime);
+	duration = (unsigned long long) ktime_to_ns(delta) >> 10;
+
+	bt_dev_info(hdev, "Device booted in %llu usecs", duration);
+
+	return 0;
+}
+
+static int btusb_intel_boot(struct hci_dev *hdev, u32 boot_addr)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+	ktime_t calltime;
+	int err;
+
+	calltime = ktime_get();
+
+	set_bit(BTUSB_BOOTING, &data->flags);
+
+	err = btintel_send_intel_reset(hdev, boot_addr);
+	if (err) {
+		bt_dev_err(hdev, "Intel Soft Reset failed (%d)", err);
+		btintel_reset_to_bootloader(hdev);
+		return err;
+	}
+
+	/* The bootloader will not indicate when the device is ready. This
+	 * is done by the operational firmware sending bootup notification.
+	 *
+	 * Booting into operational firmware should not take longer than
+	 * 1 second. However if that happens, then just fail the setup
+	 * since something went wrong.
+	 */
+	err = btusb_boot_wait(hdev, calltime, 1000);
+	if (err == -ETIMEDOUT)
+		btintel_reset_to_bootloader(hdev);
+
+	return err;
+}
+
 static int btusb_setup_intel_new(struct hci_dev *hdev)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
@@ -2804,8 +2866,6 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	struct intel_boot_params params;
 	u32 boot_param;
 	char ddcname[64];
-	ktime_t calltime, delta, rettime;
-	unsigned long long duration;
 	int err;
 	struct intel_debug_features features;
 
@@ -2840,46 +2900,9 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	if (ver.fw_variant == 0x23)
 		goto finish;
 
-	calltime = ktime_get();
-
-	set_bit(BTUSB_BOOTING, &data->flags);
-
-	err = btintel_send_intel_reset(hdev, boot_param);
-	if (err) {
-		bt_dev_err(hdev, "Intel Soft Reset failed (%d)", err);
-		btintel_reset_to_bootloader(hdev);
+	err = btusb_intel_boot(hdev, boot_param);
+	if (err)
 		return err;
-	}
-
-	/* The bootloader will not indicate when the device is ready. This
-	 * is done by the operational firmware sending bootup notification.
-	 *
-	 * Booting into operational firmware should not take longer than
-	 * 1 second. However if that happens, then just fail the setup
-	 * since something went wrong.
-	 */
-	bt_dev_info(hdev, "Waiting for device to boot");
-
-	err = wait_on_bit_timeout(&data->flags, BTUSB_BOOTING,
-				  TASK_INTERRUPTIBLE,
-				  msecs_to_jiffies(1000));
-
-	if (err == -EINTR) {
-		bt_dev_err(hdev, "Device boot interrupted");
-		return -EINTR;
-	}
-
-	if (err) {
-		bt_dev_err(hdev, "Device boot timeout");
-		btintel_reset_to_bootloader(hdev);
-		return -ETIMEDOUT;
-	}
-
-	rettime = ktime_get();
-	delta = ktime_sub(rettime, calltime);
-	duration = (unsigned long long) ktime_to_ns(delta) >> 10;
-
-	bt_dev_info(hdev, "Device booted in %llu usecs", duration);
 
 	clear_bit(BTUSB_BOOTLOADER, &data->flags);
 
@@ -2943,8 +2966,6 @@ static int btusb_setup_intel_newgen(struct hci_dev *hdev)
 	struct btusb_data *data = hci_get_drvdata(hdev);
 	u32 boot_param;
 	char ddcname[64];
-	ktime_t calltime, delta, rettime;
-	unsigned long long duration;
 	int err;
 	struct intel_debug_features features;
 	struct intel_version_tlv version;
@@ -2980,46 +3001,9 @@ static int btusb_setup_intel_newgen(struct hci_dev *hdev)
 	if (version.img_type == 0x03)
 		goto finish;
 
-	calltime = ktime_get();
-
-	set_bit(BTUSB_BOOTING, &data->flags);
-
-	err = btintel_send_intel_reset(hdev, boot_param);
-	if (err) {
-		bt_dev_err(hdev, "Intel Soft Reset failed (%d)", err);
-		btintel_reset_to_bootloader(hdev);
+	err = btusb_intel_boot(hdev, boot_param);
+	if (err)
 		return err;
-	}
-
-	/* The bootloader will not indicate when the device is ready. This
-	 * is done by the operational firmware sending bootup notification.
-	 *
-	 * Booting into operational firmware should not take longer than
-	 * 1 second. However if that happens, then just fail the setup
-	 * since something went wrong.
-	 */
-	bt_dev_info(hdev, "Waiting for device to boot");
-
-	err = wait_on_bit_timeout(&data->flags, BTUSB_BOOTING,
-				  TASK_INTERRUPTIBLE,
-				  msecs_to_jiffies(1000));
-
-	if (err == -EINTR) {
-		bt_dev_err(hdev, "Device boot interrupted");
-		return -EINTR;
-	}
-
-	if (err) {
-		bt_dev_err(hdev, "Device boot timeout");
-		btintel_reset_to_bootloader(hdev);
-		return -ETIMEDOUT;
-	}
-
-	rettime = ktime_get();
-	delta = ktime_sub(rettime, calltime);
-	duration = (unsigned long long)ktime_to_ns(delta) >> 10;
-
-	bt_dev_info(hdev, "Device booted in %llu usecs", duration);
 
 	clear_bit(BTUSB_BOOTLOADER, &data->flags);
 
-- 
2.30.2

