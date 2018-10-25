Return-Path: <SRS0=5QOG=NF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D710ECDE44
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Oct 2018 00:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDB2D20824
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Oct 2018 00:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ODZMYPBz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDB2D20824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbeJYIwR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Oct 2018 04:52:17 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44463 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbeJYIwI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Oct 2018 04:52:08 -0400
Received: by mail-pg1-f194.google.com with SMTP id w3-v6so3114215pgs.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Oct 2018 17:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZQX6LKgKdC8OvywWT+VY2Ui0n/vqYgFMzYtK6VSniiA=;
        b=ODZMYPBzXNTFKe71LEzUrrmYF5qEWY+A8gut3P6z6AzqQ67WiCyLjyjxtOPbuZhLMj
         7WBelvXoHrAZ9Oa8zvXG6zg+ZEIASBltKHgTnKGlIFvLi4klYYlLIW8dTL6koaQ6O9Bk
         4uHbyFFUzlR9LpZb3mdTfgdZ+5mJyfSZfzvIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZQX6LKgKdC8OvywWT+VY2Ui0n/vqYgFMzYtK6VSniiA=;
        b=WIDrgS2Q7ctxJpEiYC7c1f5fmaVclTnUWA1VEnaPc8zblr9tCggHkaSwW6ChrNeuj8
         sPh/ZPVfMrGn4YVK9mOeNrABT6oV+XfejVXNJfcjMOCODpY+9k3gu58BXBdoIZle4X22
         Q8qDAxFtSHandCgy5vEfu+48hA2+o9dKv6roTlpnsMs3OfOs8yw9GIGqPdk3t5B0LXvR
         v4rgrZ7loKthvxFb+x1uhirKAutuzcDyVQ0/lJwvJe9c0w5V0oivTgjxYe5CfCQ8h09f
         QvxkNdQnF9ze4fo5Hj6UayOuUqTvqRa2s1xuKLGB7pKYQ1jkRie0zlMJhtxYZbxW5zg+
         Eeaw==
X-Gm-Message-State: AGRZ1gIrfsm2rrxbbW9gdOQpIQI6YsGMGlZ5LI5SGti0RKEKQBqH4Usq
        E38TQsFw8ukURHX9ImNaMv32Rg==
X-Google-Smtp-Source: AJdET5dKU/jBSt01k1Y8jgAcyFkrrw2hjVq2Z+WBXhw56uYmzzE6MyadPOpKwssm6+LU4G38jM95gQ==
X-Received: by 2002:a63:e40e:: with SMTP id a14-v6mr4553523pgi.28.1540426911952;
        Wed, 24 Oct 2018 17:21:51 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id w2-v6sm8410181pfk.140.2018.10.24.17.21.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 17:21:51 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Loic Poulain <loic.poulain@linaro.org>
Cc:     linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Brian Norris <briannorris@chromium.org>,
        Dmitry Grinberg <dmitrygr@google.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 2/2] Bluetooth: btqcomsmd: use HCI_QUIRK_USE_BDADDR_PROPERTY
Date:   Wed, 24 Oct 2018 17:21:34 -0700
Message-Id: <20181025002134.256791-3-mka@chromium.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
In-Reply-To: <20181025002134.256791-1-mka@chromium.org>
References: <20181025002134.256791-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Use the HCI_QUIRK_USE_BDADDR_PROPERTY quirk to let the HCI
core handle the reading of 'local-bd-address'. With this there
is no need to set HCI_QUIRK_INVALID_BDADDR, the case of a
non-existing or invalid fwnode property is handled by the core
code.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
I couldn't actually test the changes in this driver since I
don't have a device with this controller. Could someone
from Qualcomm help with this?
---
 drivers/bluetooth/btqcomsmd.c | 28 +++-------------------------
 1 file changed, 3 insertions(+), 25 deletions(-)

diff --git a/drivers/bluetooth/btqcomsmd.c b/drivers/bluetooth/btqcomsmd.c
index 7df3eed1ef5e..e5841602c4f1 100644
--- a/drivers/bluetooth/btqcomsmd.c
+++ b/drivers/bluetooth/btqcomsmd.c
@@ -125,23 +125,10 @@ static int btqcomsmd_setup(struct hci_dev *hdev)
 		return PTR_ERR(skb);
 	kfree_skb(skb);
 
-	/* Devices do not have persistent storage for BD address. If no
-	 * BD address has been retrieved during probe, mark the device
-	 * as having an invalid BD address.
+	/* Devices do not have persistent storage for BD address. Retrieve
+	 * it from the firmware node property.
 	 */
-	if (!bacmp(&btq->bdaddr, BDADDR_ANY)) {
-		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
-		return 0;
-	}
-
-	/* When setting a configured BD address fails, mark the device
-	 * as having an invalid BD address.
-	 */
-	err = qca_set_bdaddr_rome(hdev, &btq->bdaddr);
-	if (err) {
-		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
-		return 0;
-	}
+	set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
 
 	return 0;
 }
@@ -169,15 +156,6 @@ static int btqcomsmd_probe(struct platform_device *pdev)
 	if (IS_ERR(btq->cmd_channel))
 		return PTR_ERR(btq->cmd_channel);
 
-	/* The local-bd-address property is usually injected by the
-	 * bootloader which has access to the allocated BD address.
-	 */
-	if (!of_property_read_u8_array(pdev->dev.of_node, "local-bd-address",
-				       (u8 *)&btq->bdaddr, sizeof(bdaddr_t))) {
-		dev_info(&pdev->dev, "BD address %pMR retrieved from device-tree",
-			 &btq->bdaddr);
-	}
-
 	hdev = hci_alloc_dev();
 	if (!hdev)
 		return -ENOMEM;
-- 
2.19.1.568.g152ad8e336-goog

