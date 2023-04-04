Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91676C76188
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Apr 2023 21:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236029AbjDDVGK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Apr 2023 17:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236500AbjDDVGB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Apr 2023 17:06:01 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11594C31
        for <linux-bluetooth@vger.kernel.org>; Tue,  4 Apr 2023 14:05:39 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id c18so32515320ple.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Apr 2023 14:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680642338;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ueat7pcRE7iu3Qae8onTfdDFR9ZMM0KAVsgaM0Im+Mg=;
        b=hTkDxcDvEMbSuJmsuPVgYM8GZLuwwmKXUnDlJ3G6DwSpNvPXI8vKAu3+03DVS36Jcn
         kBjBVchpEFkzwqKbJu32uNx72X5tLyKSgIhU96Mnn1FSdAGKsHv5297Pab1DtI7eYJmi
         gJfErnlugC9RHH4iTj13QnVeFjKJkuiuun3286s43gU5FIZTpKYyVTireCH/TjRqGdZG
         9H9C3E4gdropER6YQ6WFqpHwzaWRWc0ZlpTtSTNdvHSR7Fex0ChrlXlXpSusD9ux02U+
         T4bbbF0SoY3oDUFIe5RxWCwGlciXyUR0MV4Prq8enUO286Z0vKtq6yr61WyFUiFaoDh6
         x8HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680642338;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ueat7pcRE7iu3Qae8onTfdDFR9ZMM0KAVsgaM0Im+Mg=;
        b=1L5/2gKurpseyvd8tG3UlYLIwaGV+H2BCg07CBhgtlV7vs82hevOUwJaGMZKbK9KvL
         uCQ75ggYVUauKG6KF1C510rF6kBL7a2bZYIGFlmYlMVxublvmxy7mniEw3btKkeAfvO8
         Jvp56ZeoFYppy7jF2o4mMIkwfzP/GkWOL4nlD88Ep7CNOQiHhd6mNykCXd/uzCG91bRF
         LHH4EI65s2FiEXc8l9Ep0RQqWCPKOMgpGN6rUv3on53H2hPz+mH84D71O0Wj+RaNYG4i
         LVb28Q9c4LwXTnnZ+A/o3kpF1fnt2e3NQ32sGHGFE2hNvwtqmAdRvV4DFA8eYCyI/m/R
         vhrQ==
X-Gm-Message-State: AAQBX9dJeREI/mOKeO4bXNy3/wmGUbylQkRpE57KHupnQ+2H0NTkbv/j
        zG/sLJbOOUU3SgU65EuACdCvP08axFU=
X-Google-Smtp-Source: AKy350ZY1eI/VZutiaVMW6Ul2fsMTDcg/FGIIzf61eVl8f0o4xs9sxsZyeTlb9y2HIClAZIGp3yD6w==
X-Received: by 2002:a17:90a:e7c1:b0:23a:340d:fa49 with SMTP id kb1-20020a17090ae7c100b0023a340dfa49mr4325927pjb.32.1680642338490;
        Tue, 04 Apr 2023 14:05:38 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id v4-20020a17090a520400b0023670dbb82fsm15814pjh.25.2023.04.04.14.05.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 14:05:38 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RESEND] Bluetooth: Enable all supported LE PHY by default
Date:   Tue,  4 Apr 2023 14:05:37 -0700
Message-Id: <20230404210537.2329660-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
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
index f11689284112..827e67159523 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1683,9 +1683,13 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
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
index f21497ebc814..00017f75cd41 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4414,18 +4414,38 @@ static int hci_le_set_write_def_data_len_sync(struct hci_dev *hdev)
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
index 249dc6777fb4..5f8c144c84b8 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -8393,10 +8393,10 @@ static u32 get_supported_adv_flags(struct hci_dev *hdev)
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
2.39.2

