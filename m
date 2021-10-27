Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376ECC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Oct 2021 22:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24F5D610C8
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Oct 2021 22:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbhJ0WUt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Oct 2021 18:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbhJ0WUq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Oct 2021 18:20:46 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDABC061570
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Oct 2021 15:18:20 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id u6-20020a17090a3fc600b001a00250584aso6297069pjm.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Oct 2021 15:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=e1JpFgnYLHisQ+uAW38GttxVmZsEKCKPSToFe9VF1pE=;
        b=VNQLUsbu1/WGYlsYgGVlnTFBWta7MXI/ZExSACxM2CxJa4xjuc+OnVKXEJ91yIxJEe
         2OKuVUtJHgLpD5vGRp46XLYK4IZ3CU4eTuPA8xsjKc+AClZ5tKkPTZIEezpL1hQLiyZL
         5XfEVsxQ9ia4jiRq4yki3zPRrUxacfNsKF1FLLNh6sj40LiwZx9cHmF2Crp6iRow4qBT
         edHVu+XsCNjMnUZIZESM/JvmlVk0SlDNtTXE0AWRjfl6KnCwWWZmzuNXmKz6Bw6KR5AZ
         cvg5u0xbNIolDoUP9YjcZnXWWJ7zckksW0gi2BRTsqi03dQYkNWvmtlKClKjTZcoRfuF
         YqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e1JpFgnYLHisQ+uAW38GttxVmZsEKCKPSToFe9VF1pE=;
        b=VSlNMP5HkbetihuEDaUEtp9TUo+28eYDr4U2x4lFUzydoHKKvDTN99OJyHC26MOGaB
         U3ny2131v/Cd5eZYQvh4m6XeG4A9ePcQVppVqUh83bk/FoxS0Ym6pLPL83p92Ljdj+wW
         W0JmxRuFR18QfbEJ2sXnbciu9ClXfUJepMDgrLkwonJwl38cDrSbmOilNKPzx4mfo8Vu
         3IsKD3UCkl8js9C2qfZ7X7ookNRylQ510nQGNYWs8lHH3dEwvsp9I0KMzbhTAXrSk5IP
         MrU+PLNNE4r52LhrxOgM7PNJnWtnu1VEYpw/qoE+mY5ti4bLSf5H/90wgYe9VJZ1LbTl
         v4UA==
X-Gm-Message-State: AOAM533UYMVDqlLAliEJmNZ90cxHLOAbdjY8DQmAbow/EHCxJBPK45Nj
        rSM9qvAt79oJvVQm6xswR8aJ/q5N6ms=
X-Google-Smtp-Source: ABdhPJxZDMP1C1TsVJkorbTUChsmk4H9zxuXXQYt940duAYAO5rV1LfqNOF7h4qLFROo5hfboB+lDA==
X-Received: by 2002:a17:902:ed87:b0:141:5fe1:e794 with SMTP id e7-20020a170902ed8700b001415fe1e794mr221750plj.77.1635373099522;
        Wed, 27 Oct 2021 15:18:19 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id a25sm902760pfl.115.2021.10.27.15.18.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 15:18:19 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v7 18/23] Bluetooth: hci_sync: Convert MGMT_OP_SET_PHY_CONFIGURATION
Date:   Wed, 27 Oct 2021 15:17:57 -0700
Message-Id: <20211027221802.1851851-19-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211027221802.1851851-1-luiz.dentz@gmail.com>
References: <20211027221802.1851851-1-luiz.dentz@gmail.com>
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
index f6f3235402bd..9baa19d24475 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3414,23 +3414,26 @@ int mgmt_phy_configuration_changed(struct hci_dev *hdev, struct sock *skip)
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
@@ -3439,19 +3442,56 @@ static void set_default_phy_complete(struct hci_dev *hdev, u8 status,
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
@@ -3555,44 +3595,20 @@ static int set_phy_configuration(struct sock *sk, struct hci_dev *hdev,
 
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

