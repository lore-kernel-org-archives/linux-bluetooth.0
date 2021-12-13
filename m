Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0697C4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Dec 2021 19:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242357AbhLMTXo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Dec 2021 14:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242360AbhLMTXl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Dec 2021 14:23:41 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EEEC06173F
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Dec 2021 11:23:40 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id n8so11894617plf.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Dec 2021 11:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=wFS+eUhVu1r688H6iZb+IHI07r1kNM1rXHX2GUMneJQ=;
        b=aQlnsrJ5leTp1oDHcQ0BcxHGP3dJ6xYnHpjLJsQ3Xi2xexgfD36DA0OsCyog+spE9E
         wih/Mdrm5WXW+cGWxpcdkQfWlZemBBsPTHSkIZFmTfjnhWo+3N8hDA09AgxtF6kWs7tl
         TW7OvT612xi2Zqt3AIrq50QfEnVkJFh50HCR2w9FWqh2Pkh0eNDxsLbB4NeXBxBW1ls2
         LHF6f5AxPehmN68EAbRvU4oQW3xvwuRBQqKkg82PRm0BLBD3AikMv4uwMxZPq0Ro35xo
         7Vleh5A4nYx7hzs+YkvQReIyO7b/3xYIshKNvQBLBNK5KcdoJy0LJWXU+9m2a3rQ3aNn
         lM2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wFS+eUhVu1r688H6iZb+IHI07r1kNM1rXHX2GUMneJQ=;
        b=LfgBnDlTbpYEd2kD1axrlRtXv2FHGvyOb7LB0h5jJPR4rZ+Pz86as/ZrgcJF7aP/WD
         T86B29AaE++C+osWNqCcVBUVzhdHSVsht1CfE6hHduKlntOK4loPH+vhKMiXx5NIx0Ws
         8exsEti9ts3Vo508pnI3xmDjdqKBteQsPWhQZw83b8/sCj59qvsiVpboEh2CKsXB+reZ
         35nmOQx/7iQtlpsUzKVZuQqd9LiO0a2NSAyiOP0uzjMEyLMkSu1UkzwLWNJ7S79Nevm2
         oBJCHkoQrOAWew7oWd4veWAeJJxqsYDDy1y4WcMGCyEUKD3OyqFxdUeY9XKUfhTSbK46
         AWdQ==
X-Gm-Message-State: AOAM532A+MLDgkzzGO93arSgou+s2/XHA6nZPXcgi8CoYpSt4wt1BXVm
        vJgWIc/dGe5gdb0PBcYENknnEReXC7Q=
X-Google-Smtp-Source: ABdhPJyrkdCm03yNnLuKnByBL7nMgOv1CQ8oUFPHW2wkygKKnkdcxWJM16MW8atFnidiF/AhRT3K1w==
X-Received: by 2002:a17:903:11cd:b0:143:d220:fddb with SMTP id q13-20020a17090311cd00b00143d220fddbmr97722474plh.5.1639423420160;
        Mon, 13 Dec 2021 11:23:40 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id n71sm13512938pfd.50.2021.12.13.11.23.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 11:23:39 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 4/4] Bluetooth: hci_sync: Add check simultaneous roles support
Date:   Mon, 13 Dec 2021 11:23:35 -0800
Message-Id: <20211213192335.2024621-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211213192335.2024621-1-luiz.dentz@gmail.com>
References: <20211213192335.2024621-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This attempts to check if the controller can act as both central and
peripheral simultaneously and in case it does skip suspending
advertising or in case of directed advertising don't fail if scanning.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h |  6 ++++++
 net/bluetooth/hci_sync.c         | 24 ++++++++++++------------
 net/bluetooth/mgmt.c             |  5 +----
 3 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 1e479ba25c31..cc95b6c3f839 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -782,6 +782,12 @@ extern struct mutex hci_cb_list_lock;
 		hci_dev_clear_flag(hdev, HCI_QUALITY_REPORT);	\
 	} while (0)
 
+#define hci_dev_le_state_simultaneous(hdev) \
+	(test_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks) && \
+	 (hdev->le_states[4] & 0x08) &&	/* Central */ \
+	 (hdev->le_states[4] & 0x40) &&	/* Peripheral */ \
+	 (hdev->le_states[3] & 0x10))	/* Simultaneous */
+
 /* ----- HCI interface to upper protocols ----- */
 int l2cap_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr);
 int l2cap_disconn_ind(struct hci_conn *hcon);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 28d62273d67c..6abcf966d001 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5170,30 +5170,29 @@ int hci_le_create_conn_sync(struct hci_dev *hdev, struct hci_conn *conn)
 	u8 own_addr_type;
 	int err;
 
-	/* Disable advertising if we're active. For central role
-	 * connections most controllers will refuse to connect if
-	 * advertising is enabled, and for peripheral role connections we
-	 * anyway have to disable it in order to start directed
-	 * advertising. Any registered advertisements will be
-	 * re-enabled after the connection attempt is finished.
-	 */
-	hci_pause_advertising_sync(hdev);
-
 	/* If requested to connect as peripheral use directed advertising */
 	if (conn->role == HCI_ROLE_SLAVE) {
-		/* If we're active scanning most controllers are unable
-		 * to initiate advertising. Simply reject the attempt.
+		/* If we're active scanning and the controller doesn't support
+		 * simultaneous roles simply reject the attempt.
 		 */
 		if (hci_dev_test_flag(hdev, HCI_LE_SCAN) &&
-		    hdev->le_scan_type == LE_SCAN_ACTIVE) {
+		    hdev->le_scan_type == LE_SCAN_ACTIVE &&
+		    !hci_dev_le_state_simultaneous(hdev)) {
 			hci_conn_del(conn);
 			return -EBUSY;
 		}
 
+		/* Pause advertising while doing directed advertising. */
+		hci_pause_advertising_sync(hdev);
+
 		err = hci_le_directed_advertising_sync(hdev, conn);
 		goto done;
 	}
 
+	/* Disable advertising if simultaneous roles is not supported. */
+	if (!hci_dev_le_state_simultaneous(hdev))
+		hci_pause_advertising_sync(hdev);
+
 	params = hci_conn_params_lookup(hdev, &conn->dst, conn->dst_type);
 	if (params) {
 		conn->le_conn_min_interval = params->conn_min_interval;
@@ -5251,6 +5250,7 @@ int hci_le_create_conn_sync(struct hci_dev *hdev, struct hci_conn *conn)
 				       HCI_CMD_TIMEOUT, NULL);
 
 done:
+	/* Re-enable advertising after the connection attempt is finished. */
 	hci_resume_advertising_sync(hdev);
 	return err;
 }
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index e931e417d3e1..4e1557281956 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3916,10 +3916,7 @@ static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
 #endif
 
 	if (hdev) {
-		if (test_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks) &&
-		    (hdev->le_states[4] & 0x08) &&	/* Central */
-		    (hdev->le_states[4] & 0x40) &&	/* Peripheral */
-		    (hdev->le_states[3] & 0x10))	/* Simultaneous */
+		if (hci_dev_le_state_simultaneous(hdev))
 			flags = BIT(0);
 		else
 			flags = 0;
-- 
2.33.1

