Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6BEC00E86
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Sep 2023 15:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235419AbjITPbu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Sep 2023 11:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235157AbjITPbu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Sep 2023 11:31:50 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925C58F
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Sep 2023 08:31:39 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4018af103bcso7674745e9.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Sep 2023 08:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695223893; x=1695828693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h0ZtUkIzL6VM4Pr2bbpmuE9HP/S5mY9CGF7+uDlu3M4=;
        b=mgdO/AIppPt40ybQggd0gSRywiNE0EcLpQqs40iGc9bQ5sZ1H5nmH4qRDvefvuyC7o
         S6IF/HZ18PVpF1IISDpH71LBtA+Jcd2FQ7zUdGvf6/byUBSOEHQk1jwMQz6UXOZzMNm1
         Ln0GveIq9WQc/xWeULHK1s5WZDZem6YVLW3LZ6awXCcYxO9LO2JBXWy7BZ+4zqt0l13L
         clYeOFeLkQOzbKAVeQUfCpCo5IvS1yGbpxwGJnWaoBspT5sI4jBG2uEEWPMUg15p8xx+
         huvtTLBqvy8FiLhG02xo1DvviBAiumIPmGVfvTv6yB/KClueahwW+C7UHiPbyCOeUA0U
         2Ktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695223893; x=1695828693;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h0ZtUkIzL6VM4Pr2bbpmuE9HP/S5mY9CGF7+uDlu3M4=;
        b=A+UUVPTo91W2j/Hz6Lu37uu4/CqzpzPL3wi2YRL/roO7U7OzQcEhiIDFgSXrJX1Ajg
         +VZ0CKh8JskzUKpGL2vwQ3LDhcF6Lnw8m+gEBa9uJLsIEqthZ1b6c5WOkw8W0JAM37o/
         JxGxtgPyjOrtOtS+yUi1QEeDYzzs2LFWkz6lQ4vXC72Dtr2nYrKOaOTzw0moT7k1bx1q
         r1Ukrv1wTwsiXI8x80eADAotcxHqqHEL2ZJFYYUp6l1UxLB3oninV4hAAvJQ25MlVtQN
         uSGtr8jWWAX6OenmxFKMCEyPz/hHCT0QOPLqlLrCatusXwl/9OFE3kC51ZfNIgeWS2wU
         irUQ==
X-Gm-Message-State: AOJu0YzpBRpVBej52nc0HPgCx1Xd7YZA/lj9Avypfy9kwZtPohAUR7B6
        T/sHf1iU9086cMAD7wXF8+DMQzZOfiE=
X-Google-Smtp-Source: AGHT+IHiCX1kItLjXSYZAGs7is6mEaJHLnCmng1SWKFvAXyzU3MzKObMxFHRBd0obPUJf7YSf7Yaaw==
X-Received: by 2002:a05:600c:328a:b0:402:b8:d022 with SMTP id t10-20020a05600c328a00b0040200b8d022mr4636450wmp.16.1695223892620;
        Wed, 20 Sep 2023 08:31:32 -0700 (PDT)
Received: from localhost.localdomain (46.205.192.105.nat.ftth.dynamic.t-mobile.pl. [46.205.192.105])
        by smtp.gmail.com with ESMTPSA id k22-20020a05600c0b5600b003fe601a7d46sm2268133wmr.45.2023.09.20.08.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 08:31:07 -0700 (PDT)
From:   Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Subject: [PATCH] Bluetooth: vhci: Fix race when opening vhci device
Date:   Wed, 20 Sep 2023 17:30:07 +0200
Message-Id: <20230920153008.967330-1-arkadiusz.bokowy@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When the vhci device is opened in the two-step way, i.e.: open device
then write a vendor packet with requested controller type, the device
shall respond with a vendor packet which includes HCI index of created
interface.

When the virtual HCI is created, the host sends a reset request to the
controller. This request is processed by the vhci_send_frame() function.
However, this request is send by a different thread, so it might happen
that this HCI request will be received before the vendor response is
queued in the read queue. This results in the HCI vendor response and
HCI reset request inversion in the read queue which leads to improper
behavior of btvirt:

> dmesg
[1754256.640122] Bluetooth: MGMT ver 1.22
[1754263.023806] Bluetooth: MGMT ver 1.22
[1754265.043775] Bluetooth: hci1: Opcode 0x c03 failed: -110

In order to synchronize vhci two-step open/setup process with virtual
HCI initialization, this patch adds internal lock when queuing data in
the vhci_send_frame() function.

Signed-off-by: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
---
 drivers/bluetooth/hci_vhci.c | 3 +++
 net/bluetooth/hci_sync.c     | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index 40e2b9fa11a2..f3892e9ce800 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -74,7 +74,10 @@ static int vhci_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 	struct vhci_data *data = hci_get_drvdata(hdev);
 
 	memcpy(skb_push(skb, 1), &hci_skb_pkt_type(skb), 1);
+
+	mutex_lock(&data->open_mutex);
 	skb_queue_tail(&data->readq, skb);
+	mutex_unlock(&data->open_mutex);
 
 	wake_up_interruptible(&data->read_wait);
 	return 0;
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 3640d73f9595..2a7d432436a2 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -152,7 +152,7 @@ struct sk_buff *__hci_cmd_sync_sk(struct hci_dev *hdev, u16 opcode, u32 plen,
 	struct sk_buff *skb;
 	int err = 0;
 
-	bt_dev_dbg(hdev, "Opcode 0x%4x", opcode);
+	bt_dev_dbg(hdev, "Opcode 0x%4.4x", opcode);
 
 	hci_req_init(&req, hdev);
 
@@ -248,7 +248,7 @@ int __hci_cmd_sync_status_sk(struct hci_dev *hdev, u16 opcode, u32 plen,
 	skb = __hci_cmd_sync_sk(hdev, opcode, plen, param, event, timeout, sk);
 	if (IS_ERR(skb)) {
 		if (!event)
-			bt_dev_err(hdev, "Opcode 0x%4x failed: %ld", opcode,
+			bt_dev_err(hdev, "Opcode 0x%4.4x failed: %ld", opcode,
 				   PTR_ERR(skb));
 		return PTR_ERR(skb);
 	}
-- 
2.34.1

