Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0260C433E6
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jan 2021 17:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69D4B64DA6
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jan 2021 17:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235156AbhA0RTk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Jan 2021 12:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235711AbhA0RRy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Jan 2021 12:17:54 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61EFC061797
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Jan 2021 09:17:14 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id g15so2013325pgu.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Jan 2021 09:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9fC6ts20yKV4bzlJx7IpwEHMXNBp8xI9QfFWOht0bGc=;
        b=NM4AHvu1x7e38zoonn+GYjYHhJxMxvVXmC3YRcpAjhdXTlLJJxJnSV9NE+3OlAe3+j
         ykUeOmgxtAKCPPmMHlTJBN3TjeLZxMvld5THx6nRI3WjyOSNfV02vxNag12YSSg90Q3a
         pjd8y7ISKXpmk+b5jcTDC1RhHrj6sOcQQR0Ls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9fC6ts20yKV4bzlJx7IpwEHMXNBp8xI9QfFWOht0bGc=;
        b=n+oFPAPrurJMf9WfB2TFKxGpuXaA9XjJ0GWn++Mq4UQte4qmm/kJ/DympT1jPEJYsd
         MECiPZHlW15gtxF/W4qr6x+WwEv3544XfMnpzD88070a5F85j0Y/nn4DjpWc2irakVYE
         Hd9DGc1mns3xCG8XOAo0hKU6aEnqHikAHq6qT8lTf3VvukiT7lfW01fekAKOD4oHw+KA
         9yfgEbr1g6C6v7HU+gSimbUJzvE0vzGs0j40Pq3MNp/utqqYfe1nhUeQ3ELZJNwt7YCo
         DETtLJHqH3UsO2tjk9/1QlF524t1qojCCFMFKg1MWzuNctDyg+7UQ/9bH6tTemgFL8t4
         cMfA==
X-Gm-Message-State: AOAM532D6lr7G5XqTq47emSQnYySMAnxC7AeQgKpJfaCFOfFToD4mU9P
        loqCW8JSSaOI62Yc+uJH7omvWycBKuhccw==
X-Google-Smtp-Source: ABdhPJx4/PC0sya58MSmJSowX/6IYjoSLQS8WfvtMtUmiCJPrJruY7D1XAiNpmHWp0mGtdxxUOnxEQ==
X-Received: by 2002:a63:ca45:: with SMTP id o5mr12194630pgi.48.1611767833941;
        Wed, 27 Jan 2021 09:17:13 -0800 (PST)
Received: from localhost ([2620:15c:202:201:58a2:e0e6:6d20:24bd])
        by smtp.gmail.com with ESMTPSA id t25sm3154709pgv.30.2021.01.27.09.17.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 09:17:13 -0800 (PST)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v4] Bluetooth: Keep MSFT ext info throughout a hci_dev's life cycle
Date:   Wed, 27 Jan 2021 09:17:07 -0800
Message-Id: <20210127091600.v4.1.Id9bc5434114de07512661f002cdc0ada8b3d6d02@changeid>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This moves msft_do_close() from hci_dev_do_close() to
hci_unregister_dev() to avoid clearing MSFT extension info. This also
re-reads MSFT info upon every msft_do_open() even if MSFT extension has
been initialized.

The following test steps were performed.
(1) boot the test device and verify the MSFT support debug log in syslog
(2) restart bluetoothd and verify msft_do_close() doesn't get invoked
    and msft_do_open re-reads the MSFT support.

Signed-off-by: Miao-chen Chou <mcchou@chromium.org>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Archie Pusaka <apusaka@chromium.org>
Reviewed-by: Alain Michaud <alainm@chromium.org>
---

Changes in v4:
- Re-read the MSFT data instead of skipping if it's initiated already

Changes in v3:
- Remove the accepted commits from the series

 net/bluetooth/hci_core.c |  4 ++--
 net/bluetooth/msft.c     | 21 ++++++++++++++++++---
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index eeafed2efc0da..8056f0d4ae172 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1764,8 +1764,6 @@ int hci_dev_do_close(struct hci_dev *hdev)
 
 	hci_sock_dev_event(hdev, HCI_DEV_DOWN);
 
-	msft_do_close(hdev);
-
 	if (hdev->flush)
 		hdev->flush(hdev);
 
@@ -3844,6 +3842,8 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	unregister_pm_notifier(&hdev->suspend_notifier);
 	cancel_work_sync(&hdev->suspend_prepare);
 
+	msft_do_close(hdev);
+
 	hci_dev_do_close(hdev);
 
 	if (!test_bit(HCI_INIT, &hdev->flags) &&
diff --git a/net/bluetooth/msft.c b/net/bluetooth/msft.c
index 8579bfeb28364..4465d018280eb 100644
--- a/net/bluetooth/msft.c
+++ b/net/bluetooth/msft.c
@@ -73,16 +73,31 @@ static bool read_supported_features(struct hci_dev *hdev,
 
 void msft_do_open(struct hci_dev *hdev)
 {
-	struct msft_data *msft;
+	struct msft_data *msft = NULL;
 
 	if (hdev->msft_opcode == HCI_OP_NOP)
 		return;
 
 	bt_dev_dbg(hdev, "Initialize MSFT extension");
 
-	msft = kzalloc(sizeof(*msft), GFP_KERNEL);
-	if (!msft)
+	/* If MSFT data exists, reset its members */
+	if (hdev->msft_data) {
+		msft = hdev->msft_data;
+		hdev->msft_data = NULL;
+
+		msft->features = 0;
+		kfree(msft->evt_prefix);
+		msft->evt_prefix = NULL;
+		msft->evt_prefix_len = 0;
+
+	} else {
+		msft = kzalloc(sizeof(*msft), GFP_KERNEL);
+	}
+
+	if (!msft) {
+		bt_dev_err(hdev, "Failed to init MSFT extension");
 		return;
+	}
 
 	if (!read_supported_features(hdev, msft)) {
 		kfree(msft);
-- 
2.30.0.280.ga3ce27912f-goog

