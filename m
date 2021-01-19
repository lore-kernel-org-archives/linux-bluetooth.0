Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C49D6C433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Jan 2021 21:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 711F822DD3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Jan 2021 21:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730072AbhASVGU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Jan 2021 16:06:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730322AbhASUoE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Jan 2021 15:44:04 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE59BC061575
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Jan 2021 12:43:23 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id g15so13701244pgu.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Jan 2021 12:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eYstqhli6N+sahNXc/wERW/CDhvU6FkfRRkqcnghmTo=;
        b=C7Ns0cVwdNZmTCktOQ2rts/vUB6NcyHIqMIjNhWQQs1NCQ0luZ9mFeymqFF/mhg2r1
         X/2meBmitakCbfg7ofTMmpjyF/voX4nlb2+St8IsynKna7jBLIVLLlJysjIyqF/wXF+3
         /1tIZtXLH7xI8JFiOJG9TL769JwSwgyzo/Moc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eYstqhli6N+sahNXc/wERW/CDhvU6FkfRRkqcnghmTo=;
        b=teG+EEstSqs9RWEQZCR5qWarKCew2l9sQIYS7BshZO22+CmzeO/DnqdgHhSk8xmRLh
         WTTekczp2rj6/a8ziFvPC3NIvTWfBtOw+zpk8ELIC7ISUUBkP9b454MNuO1SWl+abhOi
         9MRSMEblKjTGoPE2ITV7O1w27s1qzex4kp0FaSL8m8nuXBLXoVMWJysKXNXKD5ACn3rU
         S1hDVrD6vHdMjNowurDe3fH8tPspKwk6JBMkSJvFMA6qevvpNwoTyz5mSssSG34xXm7H
         lY7QjyUEMYpe7RJqEx8BvIA1KmgAuwIXgQXLUhSkS4/oJ3A4v+3e3PXaQriLRRElWHsi
         7aog==
X-Gm-Message-State: AOAM531Ns5Yo4G69Z7UU78c8h4igE+otA09R9iKy1ZCA93wBQ4ly62vt
        UihsfDmvZ1qRAfAhxeS2lspmAw==
X-Google-Smtp-Source: ABdhPJz1DWhBscYgSOIMB518dmodW2S/xbcATN+vkDFFsTkqPLBpOHrpuJk747ZwwhUvmAOcZKEDyQ==
X-Received: by 2002:a62:ae18:0:b029:1a9:ac67:3b1c with SMTP id q24-20020a62ae180000b02901a9ac673b1cmr5704029pff.29.1611089003419;
        Tue, 19 Jan 2021 12:43:23 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id x15sm13835pfa.80.2021.01.19.12.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 12:43:22 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org, mcchou@chromium.org,
        michaelfsun@google.com, linux-bluetooth@vger.kernel.org,
        apusaka@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: btusb: Refactor gpio reset
Date:   Tue, 19 Jan 2021 12:43:12 -0800
Message-Id: <20210119124258.1.Ide97dd8adadf50af66738852c3c68861734cca1c@changeid>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
In-Reply-To: <20210119204315.2611811-1-abhishekpandit@chromium.org>
References: <20210119204315.2611811-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Refactor gpio reset to use a common gpio reset function.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

 drivers/bluetooth/btusb.c | 59 +++++++++++++--------------------------
 1 file changed, 19 insertions(+), 40 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index b14102fba6018..03341e6cbf3ed 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -547,6 +547,7 @@ struct btusb_data {
 	struct usb_endpoint_descriptor *diag_rx_ep;
 
 	struct gpio_desc *reset_gpio;
+	unsigned int reset_duration_ms;
 
 	__u8 cmdreq_type;
 	__u8 cmdreq;
@@ -566,15 +567,21 @@ struct btusb_data {
 	unsigned cmd_timeout_cnt;
 };
 
-static void btusb_intel_cmd_timeout(struct hci_dev *hdev)
+static void btusb_toggle_gpio(struct gpio_desc *desc, unsigned int duration)
+{
+	gpiod_set_value_cansleep(desc, 1);
+	msleep(duration);
+	gpiod_set_value_cansleep(desc, 0);
+}
+
+static void btusb_gpio_cmd_timeout(struct hci_dev *hdev)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
-	struct gpio_desc *reset_gpio = data->reset_gpio;
 
 	if (++data->cmd_timeout_cnt < 5)
 		return;
 
-	if (!reset_gpio) {
+	if (!data->reset_gpio) {
 		bt_dev_err(hdev, "No way to reset. Ignoring and continuing");
 		return;
 	}
@@ -592,39 +599,7 @@ static void btusb_intel_cmd_timeout(struct hci_dev *hdev)
 	}
 
 	bt_dev_err(hdev, "Initiating HW reset via gpio");
-	gpiod_set_value_cansleep(reset_gpio, 1);
-	msleep(100);
-	gpiod_set_value_cansleep(reset_gpio, 0);
-}
-
-static void btusb_rtl_cmd_timeout(struct hci_dev *hdev)
-{
-	struct btusb_data *data = hci_get_drvdata(hdev);
-	struct gpio_desc *reset_gpio = data->reset_gpio;
-
-	if (++data->cmd_timeout_cnt < 5)
-		return;
-
-	if (!reset_gpio) {
-		bt_dev_err(hdev, "No gpio to reset Realtek device, ignoring");
-		return;
-	}
-
-	/* Toggle the hard reset line. The Realtek device is going to
-	 * yank itself off the USB and then replug. The cleanup is handled
-	 * correctly on the way out (standard USB disconnect), and the new
-	 * device is detected cleanly and bound to the driver again like
-	 * it should be.
-	 */
-	if (test_and_set_bit(BTUSB_HW_RESET_ACTIVE, &data->flags)) {
-		bt_dev_err(hdev, "last reset failed? Not resetting again");
-		return;
-	}
-
-	bt_dev_err(hdev, "Reset Realtek device via gpio");
-	gpiod_set_value_cansleep(reset_gpio, 1);
-	msleep(200);
-	gpiod_set_value_cansleep(reset_gpio, 0);
+	btusb_toggle_gpio(data->reset_gpio, data->reset_duration_ms);
 }
 
 static void btusb_qca_cmd_timeout(struct hci_dev *hdev)
@@ -4462,7 +4437,8 @@ static int btusb_probe(struct usb_interface *intf,
 		hdev->shutdown = btusb_shutdown_intel;
 		hdev->set_diag = btintel_set_diag_mfg;
 		hdev->set_bdaddr = btintel_set_bdaddr;
-		hdev->cmd_timeout = btusb_intel_cmd_timeout;
+		hdev->cmd_timeout = btusb_gpio_cmd_timeout;
+		data->reset_duration_ms = 100;
 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
 		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 		set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
@@ -4476,7 +4452,8 @@ static int btusb_probe(struct usb_interface *intf,
 		hdev->hw_error = btintel_hw_error;
 		hdev->set_diag = btintel_set_diag;
 		hdev->set_bdaddr = btintel_set_bdaddr;
-		hdev->cmd_timeout = btusb_intel_cmd_timeout;
+		hdev->cmd_timeout = btusb_gpio_cmd_timeout;
+		data->reset_duration_ms = 100;
 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
 		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 		set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
@@ -4490,7 +4467,8 @@ static int btusb_probe(struct usb_interface *intf,
 		hdev->hw_error = btintel_hw_error;
 		hdev->set_diag = btintel_set_diag;
 		hdev->set_bdaddr = btintel_set_bdaddr;
-		hdev->cmd_timeout = btusb_intel_cmd_timeout;
+		hdev->cmd_timeout = btusb_gpio_cmd_timeout;
+		data->reset_duration_ms = 100;
 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
 		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 		set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
@@ -4557,7 +4535,8 @@ static int btusb_probe(struct usb_interface *intf,
 	    (id->driver_info & BTUSB_REALTEK)) {
 		hdev->setup = btrtl_setup_realtek;
 		hdev->shutdown = btrtl_shutdown_realtek;
-		hdev->cmd_timeout = btusb_rtl_cmd_timeout;
+		hdev->cmd_timeout = btusb_gpio_cmd_timeout;
+		data->reset_duration_ms = 200;
 
 		/* Realtek devices lose their updated firmware over global
 		 * suspend that means host doesn't send SET_FEATURE
-- 
2.30.0.284.gd98b1dd5eaa7-goog

