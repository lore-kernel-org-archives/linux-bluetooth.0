Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052CEC4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Dec 2022 21:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbiLSVhP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Dec 2022 16:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbiLSVhL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Dec 2022 16:37:11 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7F5F580
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Dec 2022 13:37:07 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id t11-20020a17090a024b00b0021932afece4so14467089pje.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Dec 2022 13:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aZWkJDxWk2tuT267UaOBtSBOXHIMzexEiUVFKl+weHk=;
        b=HfPyBNRQBevlyL85oKH3nQt9+Ell1AcdIn7X4IqE4RG6GuabEhlVRcCup1ytjVtV+d
         3GIOVpWqsdblohX/5hBQCQ2sjFcVQd/HNZDa4cLSuOgjLgxRiTmdQucW2Zn8sH5xqjPA
         5+kGSWRxiaYi5Vg3k3wXLuTf9cqtpx7haFogQMiT3UPXfbgILdG4raU6ESAyl4L6WcG4
         UdQNY1jEvozrgvIDhKD4HJ7i7y6+wLWs11KB7SKfDqNQ2GYrm4yOWcDbgr0XQgRD9RAl
         flcoI1eqErmXoOX+s39htcmIGsnu1F0lyJvdjxPSYf21OWQQT4vXSmd3/T4w2tIZw0a2
         7BZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aZWkJDxWk2tuT267UaOBtSBOXHIMzexEiUVFKl+weHk=;
        b=u+RjaJ5O/J87vOWwrB1Ml7903vv8dBpT9wV7l3wZgH9Nc65wsmnBkIQ77gmonv9JDz
         fbK3ujrC8znQKr/X7jm7u6VLUXm2DwgJ0+KH+FXfYASwKlQTsSsN8Hyt2zT8xWAFKm2o
         bWpFEbsjMenNuDjLMBfiNOfAVwkAk0ORatgvTBSOFA2uQwuUyrPnkM/gBEgVmKZ6iRuK
         n4NA0WkxbVKBaFnassapn8vr0z6zTar980Bhcp51mELWfqQjltO+8Jk2xkpqDzed45KA
         E2D9pMA6gHFi2KL2aKBZfb2hHuvq0UF+t5KXPNwtEsg4miHU5swu9VUuQuxTlIHtVV94
         M24Q==
X-Gm-Message-State: ANoB5pm/hQx2k7u2UURItDkU2qv6Xgg69V9Std16lnnemKYwJTtYuuKm
        +ZP2NobWmoaVPnmG6dv6i6S66dXZEHpoOA==
X-Google-Smtp-Source: AA0mqf4L3EysxUolqMMmxRwF8I1ULvOc92f+7wnitXYusTZX2nOLGCjlRhp075dKk+OHXMoh4w0Lfw==
X-Received: by 2002:a17:903:26c1:b0:189:5ae5:5b41 with SMTP id jg1-20020a17090326c100b001895ae55b41mr41686844plb.53.1671485826265;
        Mon, 19 Dec 2022 13:37:06 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id ij24-20020a170902ab5800b00177efb56475sm7668116plb.85.2022.12.19.13.37.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 13:37:05 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RESEND 2/2] Bluetooth: Enable all supported LE PHY by default
Date:   Mon, 19 Dec 2022 13:37:02 -0800
Message-Id: <20221219213702.3659417-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221219213702.3659417-1-luiz.dentz@gmail.com>
References: <20221219213702.3659417-1-luiz.dentz@gmail.com>
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
index 7254edfba4c9..675ce50a0247 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1666,9 +1666,13 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
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
index 9e2d7e4b850c..5220bfd75b00 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4370,18 +4370,38 @@ static int hci_le_set_write_def_data_len_sync(struct hci_dev *hdev)
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
index dad6fd9abe95..9e86bd979a53 100644
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
2.37.3

