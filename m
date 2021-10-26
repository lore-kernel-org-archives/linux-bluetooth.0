Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A2DC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Oct 2021 23:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0B54610A0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Oct 2021 23:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240178AbhJZXGH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Oct 2021 19:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240159AbhJZXGF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Oct 2021 19:06:05 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF31C061570
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Oct 2021 16:03:40 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id c4so982296pgv.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Oct 2021 16:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=SR97X65z6qOjGu0rfqwlaIbvmTLthgUCqeIXFdLOjKc=;
        b=lcL+viDnDYTeIfxnRb+24Mcce/rAkFWvBac3U9zp49KmKf5mfsXpiylMnMDmMuPckt
         Hnf1KCt9NgJ71UvtH0pXU3bq1zBXbFy3AbGbxLIZ1ba4TLekWzRwjdzthhldaPSGTZQ/
         0LPcjmxZlVlzNH4wG1gg/HDJpsyapWuqnKh18ZfJ2fhKLe+xxyVbkSxe7b9Pq2LNqtgu
         eF20xL4wP7Qo2ixcj5HVIYHls4KZ36axLDfOCmYeubQg4ucsT2aT4cW+CBou3OSSkuzv
         ZvhxqCAem4Ub/gRiqNYaZ3Ngr8aQvbMozND9RINcmhzbvslC4lz8rzO44LUjyAd6aHsH
         rSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SR97X65z6qOjGu0rfqwlaIbvmTLthgUCqeIXFdLOjKc=;
        b=4gvd1tjj84kCnSjr1NyWO0YBx1bN8VYgWm+OasCoO9nHDiCErDTEqx+97c6BL5aoZ+
         G6EDrAT//70+qnGGJlI3kYLaXgVSxPYEUzE8d4XJlIJKtr4j0GVKSHKUrlRUGO5HubRq
         5HTQk0FEJ0eKUQBz/6p6Yerakui69H3MC/0SKqNaWkges9W3CVvXUYPzMnHc3tsAc6lD
         1KV7uYkGOOT2Lp7saAJyBIvIdGmyd9phPp7koAAIPaWHGUvWV5FcN5lzS4WzLbVoduFo
         SK6V8JsDuu/S3heEgY4w+BaSqAKcLNoVnWUCO+WeYKvvuy8NZV4Xcm/8M2hPNye96dWT
         fzHg==
X-Gm-Message-State: AOAM531xdhnHlw1pcuAko5kN3FXzp1j77Ze0hPAzYDP61qVi2nJJUPFr
        Ruj8TgDTFDP9FXKIUWXmXtQr+5jSr6M=
X-Google-Smtp-Source: ABdhPJwXEe6OwLbwQix9h8iVBqAuOHZ9TWZqje00qYQUmldvYteX8B1ojEPpPGk9rsH55omtne90rw==
X-Received: by 2002:a63:9b0a:: with SMTP id r10mr20940984pgd.389.1635289419931;
        Tue, 26 Oct 2021 16:03:39 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id a2sm20697558pgn.20.2021.10.26.16.03.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 16:03:39 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v6 18/23] Bluetooth: hci_sync: Convert MGMT_OP_SET_PHY_CONFIGURATION
Date:   Tue, 26 Oct 2021 16:03:19 -0700
Message-Id: <20211026230324.1533907-19-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211026230324.1533907-1-luiz.dentz@gmail.com>
References: <20211026230324.1533907-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Brian Gix <brian.gix@intel.com>

mgmt-test paths:
Set PHY 2m Success
Set PHY coded Succcess
Set PHY 1m 2m coded Succcess
Set PHY 2m tx success
Set PHY 2m rx success
Set PHY Invalid Param
Start Discovery - (2m, Scan Param)
Start Discovery - (coded, Scan Param)
Start Discovery - (1m, 2m, coded, Scan Param)

Signed-off-by: Brian Gix <brian.gix@intel.com>
---
 net/bluetooth/mgmt.c | 116 ++++++++++++++++++++++++-------------------
 1 file changed, 66 insertions(+), 50 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index dcdd3f4dab34..5b1aaf74b93b 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3415,23 +3415,26 @@ int mgmt_phy_configuration_changed(struct hci_dev *hdev, struct sock *skip)
 			  sizeof(ev), skip);
 }
 
-static void set_default_phy_complete(struct hci_dev *hdev, u8 status,
-				     u16 opcode, struct sk_buff *skb)
+static void set_default_phy_complete(struct hci_dev *hdev, void *data, int err)
 {
-	struct mgmt_pending_cmd *cmd;
-
-	bt_dev_dbg(hdev, "status 0x%02x", status);
+	struct mgmt_pending_cmd *cmd = data;
+	struct sk_buff *skb = cmd->skb;
+	u8 status = mgmt_status(err);
 
-	hci_dev_lock(hdev);
+	if (!status) {
+		if (!skb)
+			status = MGMT_STATUS_FAILED;
+		else if (IS_ERR(skb))
+			status = mgmt_status(PTR_ERR(skb));
+		else
+			status = mgmt_status(skb->data[0]);
+	}
 
-	cmd = pending_find(MGMT_OP_SET_PHY_CONFIGURATION, hdev);
-	if (!cmd)
-		goto unlock;
+	bt_dev_dbg(hdev, "status %d", status);
 
 	if (status) {
 		mgmt_cmd_status(cmd->sk, hdev->id,
-				MGMT_OP_SET_PHY_CONFIGURATION,
-				mgmt_status(status));
+				MGMT_OP_SET_PHY_CONFIGURATION, status);
 	} else {
 		mgmt_cmd_complete(cmd->sk, hdev->id,
 				  MGMT_OP_SET_PHY_CONFIGURATION, 0,
@@ -3440,19 +3443,56 @@ static void set_default_phy_complete(struct hci_dev *hdev, u8 status,
 		mgmt_phy_configuration_changed(hdev, cmd->sk);
 	}
 
+	if (skb && !IS_ERR(skb))
+		kfree_skb(skb);
+
 	mgmt_pending_remove(cmd);
+}
 
-unlock:
-	hci_dev_unlock(hdev);
+static int set_default_phy_sync(struct hci_dev *hdev, void *data)
+{
+	struct mgmt_pending_cmd *cmd = data;
+	struct mgmt_cp_set_phy_configuration *cp = cmd->param;
+	struct hci_cp_le_set_default_phy cp_phy;
+	u32 selected_phys = __le32_to_cpu(cp->selected_phys);
+
+	memset(&cp_phy, 0, sizeof(cp_phy));
+
+	if (!(selected_phys & MGMT_PHY_LE_TX_MASK))
+		cp_phy.all_phys |= 0x01;
+
+	if (!(selected_phys & MGMT_PHY_LE_RX_MASK))
+		cp_phy.all_phys |= 0x02;
+
+	if (selected_phys & MGMT_PHY_LE_1M_TX)
+		cp_phy.tx_phys |= HCI_LE_SET_PHY_1M;
+
+	if (selected_phys & MGMT_PHY_LE_2M_TX)
+		cp_phy.tx_phys |= HCI_LE_SET_PHY_2M;
+
+	if (selected_phys & MGMT_PHY_LE_CODED_TX)
+		cp_phy.tx_phys |= HCI_LE_SET_PHY_CODED;
+
+	if (selected_phys & MGMT_PHY_LE_1M_RX)
+		cp_phy.rx_phys |= HCI_LE_SET_PHY_1M;
+
+	if (selected_phys & MGMT_PHY_LE_2M_RX)
+		cp_phy.rx_phys |= HCI_LE_SET_PHY_2M;
+
+	if (selected_phys & MGMT_PHY_LE_CODED_RX)
+		cp_phy.rx_phys |= HCI_LE_SET_PHY_CODED;
+
+	cmd->skb =  __hci_cmd_sync(hdev, HCI_OP_LE_SET_DEFAULT_PHY,
+				   sizeof(cp_phy), &cp_phy, HCI_CMD_TIMEOUT);
+
+	return 0;
 }
 
 static int set_phy_configuration(struct sock *sk, struct hci_dev *hdev,
 				 void *data, u16 len)
 {
 	struct mgmt_cp_set_phy_configuration *cp = data;
-	struct hci_cp_le_set_default_phy cp_phy;
 	struct mgmt_pending_cmd *cmd;
-	struct hci_request req;
 	u32 selected_phys, configurable_phys, supported_phys, unconfigure_phys;
 	u16 pkt_type = (HCI_DH1 | HCI_DM1);
 	bool changed = false;
@@ -3556,44 +3596,20 @@ static int set_phy_configuration(struct sock *sk, struct hci_dev *hdev,
 
 	cmd = mgmt_pending_add(sk, MGMT_OP_SET_PHY_CONFIGURATION, hdev, data,
 			       len);
-	if (!cmd) {
+	if (!cmd)
 		err = -ENOMEM;
-		goto unlock;
-	}
-
-	hci_req_init(&req, hdev);
-
-	memset(&cp_phy, 0, sizeof(cp_phy));
-
-	if (!(selected_phys & MGMT_PHY_LE_TX_MASK))
-		cp_phy.all_phys |= 0x01;
-
-	if (!(selected_phys & MGMT_PHY_LE_RX_MASK))
-		cp_phy.all_phys |= 0x02;
-
-	if (selected_phys & MGMT_PHY_LE_1M_TX)
-		cp_phy.tx_phys |= HCI_LE_SET_PHY_1M;
-
-	if (selected_phys & MGMT_PHY_LE_2M_TX)
-		cp_phy.tx_phys |= HCI_LE_SET_PHY_2M;
-
-	if (selected_phys & MGMT_PHY_LE_CODED_TX)
-		cp_phy.tx_phys |= HCI_LE_SET_PHY_CODED;
-
-	if (selected_phys & MGMT_PHY_LE_1M_RX)
-		cp_phy.rx_phys |= HCI_LE_SET_PHY_1M;
-
-	if (selected_phys & MGMT_PHY_LE_2M_RX)
-		cp_phy.rx_phys |= HCI_LE_SET_PHY_2M;
-
-	if (selected_phys & MGMT_PHY_LE_CODED_RX)
-		cp_phy.rx_phys |= HCI_LE_SET_PHY_CODED;
+	else
+		err = hci_cmd_sync_queue(hdev, set_default_phy_sync, cmd,
+					 set_default_phy_complete);
 
-	hci_req_add(&req, HCI_OP_LE_SET_DEFAULT_PHY, sizeof(cp_phy), &cp_phy);
+	if (err < 0) {
+		err = mgmt_cmd_status(sk, hdev->id,
+				      MGMT_OP_SET_PHY_CONFIGURATION,
+				      MGMT_STATUS_FAILED);
 
-	err = hci_req_run_skb(&req, set_default_phy_complete);
-	if (err < 0)
-		mgmt_pending_remove(cmd);
+		if (cmd)
+			mgmt_pending_remove(cmd);
+	}
 
 unlock:
 	hci_dev_unlock(hdev);
-- 
2.31.1

