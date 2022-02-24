Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7796BC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Feb 2022 00:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiBXAbG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Feb 2022 19:31:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiBXAbC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Feb 2022 19:31:02 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD4D6D972
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Feb 2022 16:30:33 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id m11so277574pls.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Feb 2022 16:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=gkECUbgP6SwJ+vdtBxsDCIGBwm8Bgzi3GVBj8I4iC20=;
        b=lADeQW0+uazQZiVv13RVFaGooeH/NSUCHK/vGmzPBnYzFmPb1DGoxu0Am1R7rbfpwE
         Yvz81y1ujZKF5kwjmBNQkcIQUl5epwtxW20SrkaOTvh23F0/Ux4aZphdSHKvWbxQ1XT/
         E1iV80+v1s7qooAXhonWYkKGJZpTWD+j400QiXRHNLzT6yFFyTxynSdU6O5W6Mqu3K/L
         R7SaA6E68lrCMhG3XV69/ukpf2aZ1wwSUMngyKBGKNQzwdMl+NB+WNKVPDo9+FrsfbXR
         ElAdqy07SrjjDp0F8gb6GTuUmxlxifmb71sdrCVuINZt2m+7ezYc0sPhUDZOHz2g8Z56
         0Zjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gkECUbgP6SwJ+vdtBxsDCIGBwm8Bgzi3GVBj8I4iC20=;
        b=a1vQKod+DeiKjOCRew/2LZLI7vBBamQVvRfuT+sMmXnr9dGMbaepAmuX0fvpGzUWT8
         Fd/ZUKvzGhM+cnPH03JP+63vu/E9se1WjUXAMhn0vCm6udivfWCaXdOey1Yj/5I+U2T4
         B+U5gEXVCwpUV5ljtlmUs1mfzXGFSLg5JIRD0PzzAtOZeX2nwYdo79CwSLLw4jCN5mVp
         VKKtKs+ma4Kz7tf39yLufcjBz8bWuqIuPEkg2WRIdbs3+H+c0VPeXsTqHzPmQnFR6IEe
         CVbhQzNtOJPZ8sWw5OUYo2JBifwZ9YRI3ViqxMTjZhfdgFb7ZRr/KyxZo960C+BS3sTz
         1qQQ==
X-Gm-Message-State: AOAM533j4dZ9MFIy6Gyvgs0g207jskEIwTyNiKQDfkqPugP0bGRCN9TV
        DeBAxojTL6BbsYBUGB7Ft/U4rdvdojI=
X-Google-Smtp-Source: ABdhPJxNo48beDmRZ1OX9LZ4AxCTkEXOqKLZUJn8s6vmjbGVBz40XL6XmICJvsSk81LZW6kBYFmlAg==
X-Received: by 2002:a17:902:ccd2:b0:14f:8182:96c4 with SMTP id z18-20020a170902ccd200b0014f818296c4mr326120ple.67.1645662633173;
        Wed, 23 Feb 2022 16:30:33 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id t19sm574570pjs.54.2022.02.23.16.30.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 16:30:32 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 03/11] btdev: Implement BT_HCI_CMD_LE_PERIODIC_ADV_CREATE_SYNC_CANCEL
Date:   Wed, 23 Feb 2022 16:30:21 -0800
Message-Id: <20220224003029.706163-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220224003029.706163-1-luiz.dentz@gmail.com>
References: <20220224003029.706163-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds implementation of
BT_HCI_CMD_LE_PERIODIC_ADV_CREATE_SYNC_CANCEL generating
BT_HCI_EVT_LE_PER_SYNC_ESTABLISHED if necessary.
---
 emulator/btdev.c | 30 +++++++++++++++++++++++++++---
 monitor/bt.h     |  1 +
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 34469d986..09101a5df 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -48,6 +48,7 @@
 #define ISO_HANDLE 257
 #define SCO_HANDLE 257
 #define SYC_HANDLE 1
+#define INV_HANDLE 0xffff
 
 struct hook {
 	btdev_hook_func handler;
@@ -5301,7 +5302,7 @@ static int cmd_per_adv_create_sync(struct btdev *dev, const void *data,
 	if (dev->le_periodic_sync_handle)
 		status = BT_HCI_ERR_MEM_CAPACITY_EXCEEDED;
 	else
-		dev->le_periodic_sync_handle = SYC_HANDLE;
+		dev->le_periodic_sync_handle = INV_HANDLE;
 
 	cmd_status(dev, status, BT_HCI_CMD_LE_PERIODIC_ADV_CREATE_SYNC);
 
@@ -5351,11 +5352,14 @@ static void le_per_adv_sync_estabilished(struct btdev *dev,
 	ev.status = status;
 
 	if (status) {
+		dev->le_periodic_sync_handle = 0x0000;
 		le_meta_event(dev, BT_HCI_EVT_LE_PER_SYNC_ESTABLISHED, &ev,
 							sizeof(ev));
 		return;
 	}
 
+	dev->le_periodic_sync_handle = SYC_HANDLE;
+
 	ev.handle = cpu_to_le16(dev->le_periodic_sync_handle);
 	ev.addr_type = cmd->addr_type;
 	memcpy(ev.addr, cmd->addr, sizeof(ev.addr));
@@ -5394,8 +5398,28 @@ static int cmd_per_adv_create_sync_complete(struct btdev *dev, const void *data,
 static int cmd_per_adv_create_sync_cancel(struct btdev *dev, const void *data,
 							uint8_t len)
 {
-	/* TODO */
-	return -ENOTSUP;
+	uint8_t status = BT_HCI_ERR_SUCCESS;
+
+	/* If the Host issues this command while no
+	 * HCI_LE_Periodic_Advertising_Create_Sync command is pending, the
+	 * Controller shall return the error code Command Disallowed (0x0C).
+	 */
+	if (dev->le_periodic_sync_handle != INV_HANDLE)
+		status = BT_HCI_ERR_COMMAND_DISALLOWED;
+
+	cmd_complete(dev, BT_HCI_CMD_LE_PERIODIC_ADV_CREATE_SYNC_CANCEL,
+					&status, sizeof(status));
+
+	/* After the HCI_Command_Complete is sent and if the cancellation was
+	 * successful, the Controller sends an
+	 * HCI_LE_Periodic_Advertising_Sync_Established event to the Host with
+	 * the error code Operation Cancelled by Host (0x44).
+	 */
+	if (!status)
+		le_per_adv_sync_estabilished(dev, NULL, NULL,
+							BT_HCI_ERR_CANCELLED);
+
+	return 0;
 }
 
 static int cmd_per_adv_term_sync(struct btdev *dev, const void *data,
diff --git a/monitor/bt.h b/monitor/bt.h
index 51b1833dc..b6b6c49e1 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -3660,6 +3660,7 @@ struct bt_hci_evt_le_req_peer_sca_complete {
 #define BT_HCI_ERR_ADV_TIMEOUT                 0x3c
 #define BT_HCI_ERR_CONN_FAILED_TO_ESTABLISH	0x3e
 #define BT_HCI_ERR_UNKNOWN_ADVERTISING_ID	0x42
+#define BT_HCI_ERR_CANCELLED			0x44
 
 struct bt_l2cap_hdr {
 	uint16_t len;
-- 
2.35.1

