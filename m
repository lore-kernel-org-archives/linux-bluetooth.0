Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC2BC54EE9
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Sep 2022 23:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiIGXWh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Sep 2022 19:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiIGXWg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Sep 2022 19:22:36 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116509E0C2
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Sep 2022 16:22:36 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id o4so16003266pjp.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Sep 2022 16:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=d8U/VV7RRovR5QMCCvm1x+9RE6wclRLKh32bB1MTpKA=;
        b=OMQXAZf111JzDZvvZ85YK5aKw1PXJ5/+bYNLI7W3s4wc55dFy6zvRFmK2b8ti/yQg+
         i0qv1iU8rnCIo4P9hYpyvLeaGDyM7/DNhQjetdvSk9doOzi9V3zdn0HEboInYZQOYm38
         Iyq8GMgurj8nMWSKcURD4GtdPU/3PMBNfGcjGvY8ngiCYf7Aec7TTmg9AGoNz4OXRzEp
         jDk1JOUfzwUe/OEx1xPdTBp/O2U2JlxyqI4K7QsTHQQ+qcuOvB6I1EyneZ2vcYPAVGkN
         PVCMD0Sj6hoJRG7H2AQ2Dzd8DsFfbEjSPIRv9cypm3JxlQqTZGpMvOc2a+j7xYtfWKZY
         RFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=d8U/VV7RRovR5QMCCvm1x+9RE6wclRLKh32bB1MTpKA=;
        b=p1T5iQV1UrR/S9O69tzjXExkg1H1Pl6VV221lxb6Gmlovid60xq9lgQv5rtWO0XcHQ
         YsL1/YM6YBvfuvtkLueJCrPCfolaL6ltDaNrfPAk0EdomKiC6SV6Qevs+C+eorE3HkW2
         kHpyNw2ABfhaufCQq1k37qF8DKeJIslr1/2QYORQ/H0zgXp1potWBVtNtIj9Wc28OEu/
         fbvcrxk0ABiVv4t+9XWVzQZeYyNoRh3YbVvOO1z2L87QGPDxGLsWUcNvtC+JQVgYw23b
         VSeiIr+8DuUUksfCdXURT0AiVFlyOAbVkoIgSCfJ263TpEgXfnqnDAN93MVO6+r4UVVk
         dpxw==
X-Gm-Message-State: ACgBeo2Nh4GTeUVkDH5o2BTmBYkRGqD6j4F36FY7y0/YQ3vttZoTVicV
        XVswonu4faJvbpmJbeOI4Lk0qPoj2/esLQ==
X-Google-Smtp-Source: AA6agR408HiuX/H7qhza9B6XMVngBc2YzqLu88us+8BKt1W3d1Nvq7s0dP7sIbZEUr3xJBPxzIZFKw==
X-Received: by 2002:a17:90b:1c04:b0:202:5a5d:b43f with SMTP id oc4-20020a17090b1c0400b002025a5db43fmr934013pjb.124.1662592955019;
        Wed, 07 Sep 2022 16:22:35 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id x11-20020a170902ec8b00b00176b63535adsm7241789plg.260.2022.09.07.16.22.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 16:22:34 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] Bluetooth: Enable all supported LE PHY by default
Date:   Wed,  7 Sep 2022 16:22:32 -0700
Message-Id: <20220907232232.3248525-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220907232232.3248525-1-luiz.dentz@gmail.com>
References: <20220907232232.3248525-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables 2M and Coded PHY by default if they are marked as supported
in the LE features bits.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h |  4 ++++
 net/bluetooth/hci_sync.c         | 28 ++++++++++++++++++++++++----
 net/bluetooth/mgmt.c             |  4 ++--
 3 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index c54bc71254af..b55551134baa 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1665,9 +1665,13 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 #define scan_1m(dev) (((dev)->le_tx_def_phys & HCI_LE_SET_PHY_1M) || \
 		      ((dev)->le_rx_def_phys & HCI_LE_SET_PHY_1M))
 
+#define le_2m_capable(dev) (((dev)->le_features[1] & HCI_LE_PHY_2M))
+
 #define scan_2m(dev) (((dev)->le_tx_def_phys & HCI_LE_SET_PHY_2M) || \
 		      ((dev)->le_rx_def_phys & HCI_LE_SET_PHY_2M))
 
+#define le_coded_capable(dev) (((dev)->le_features[1] & HCI_LE_PHY_CODED))
+
 #define scan_coded(dev) (((dev)->le_tx_def_phys & HCI_LE_SET_PHY_CODED) || \
 			 ((dev)->le_rx_def_phys & HCI_LE_SET_PHY_CODED))
 
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 41b6d19c70b0..5798b2c6134d 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4348,18 +4348,38 @@ static int hci_le_set_write_def_data_len_sync(struct hci_dev *hdev)
 				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
 }
 
-/* Set Default PHY parameters if command is supported */
+/* Set Default PHY parameters if command is supported, enables all supported
+ * PHYs according to the LE Features bits.
+ */
 static int hci_le_set_default_phy_sync(struct hci_dev *hdev)
 {
 	struct hci_cp_le_set_default_phy cp;
 
-	if (!(hdev->commands[35] & 0x20))
+	if (!(hdev->commands[35] & 0x20)) {
+		/* If the command is not supported it means only 1M PHY is
+		 * supported.
+		 */
+		hdev->le_tx_def_phys = HCI_LE_SET_PHY_1M;
+		hdev->le_rx_def_phys = HCI_LE_SET_PHY_1M;
 		return 0;
+	}
 
 	memset(&cp, 0, sizeof(cp));
 	cp.all_phys = 0x00;
-	cp.tx_phys = hdev->le_tx_def_phys;
-	cp.rx_phys = hdev->le_rx_def_phys;
+	cp.tx_phys = HCI_LE_SET_PHY_1M;
+	cp.rx_phys = HCI_LE_SET_PHY_1M;
+
+	/* Enables 2M PHY if supported */
+	if (le_2m_capable(hdev)) {
+		cp.tx_phys |= HCI_LE_SET_PHY_2M;
+		cp.rx_phys |= HCI_LE_SET_PHY_2M;
+	}
+
+	/* Enables Coded PHY if supported */
+	if (le_coded_capable(hdev)) {
+		cp.tx_phys |= HCI_LE_SET_PHY_CODED;
+		cp.rx_phys |= HCI_LE_SET_PHY_CODED;
+	}
 
 	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_DEFAULT_PHY,
 				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 34443db21e44..a090d5ff81f6 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -8380,10 +8380,10 @@ static u32 get_supported_adv_flags(struct hci_dev *hdev)
 		flags |= MGMT_ADV_FLAG_HW_OFFLOAD;
 		flags |= MGMT_ADV_FLAG_CAN_SET_TX_POWER;
 
-		if (hdev->le_features[1] & HCI_LE_PHY_2M)
+		if (le_2m_capable(hdev))
 			flags |= MGMT_ADV_FLAG_SEC_2M;
 
-		if (hdev->le_features[1] & HCI_LE_PHY_CODED)
+		if (le_coded_capable(hdev))
 			flags |= MGMT_ADV_FLAG_SEC_CODED;
 	}
 
-- 
2.37.2

