Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D860C433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 23:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84CF660F46
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 23:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235773AbhJYXnp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Oct 2021 19:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235669AbhJYXnk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Oct 2021 19:43:40 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4028C061348
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Oct 2021 16:41:17 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id 187so12414005pfc.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Oct 2021 16:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Z7nWlJF3fNnnhwK5ELaeFMCy/HQXIkWlZrmjUY54bsQ=;
        b=bGvshQKlxW9qtBYb61ZHWd9NnUXH8K8YJMg/mhwEh5LwCNu5b/jwnjYmX7/Bgutofs
         zGTVyqcmMUtlmRualiRWjWEiX71Y1LwEqNBPe2ROd9+3xtGUxuGc1Uy2Ty+0xGgXBClK
         /9fp+HjhXl2abf9ZxztoWsTUJb2Tl0YuhSzHcVbmjFr5Kc7aN3iyped6ppQszCfOxpmz
         fIVmflKZz267f+Vtg3xoNErszlUWb6Fswhwgt6W+7+dVfT9k4ju09WTSbuTgznHLocz9
         2OaHBu0/vPIeMeNfBGSfFce21CoZsA4/wvRHlB0q1VnXgXv5HuiJSQ/JmvdtnXl5NwBj
         eifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z7nWlJF3fNnnhwK5ELaeFMCy/HQXIkWlZrmjUY54bsQ=;
        b=oNd4/X3qksV7lv4csZBIaWbRiQ22I0OK88OM65Sw+f3Rvtz1By2xnGR4FMPxIRDPS+
         OT+Xkm5EqX4H7QkPwdnrPNoAMrLsb0R5BQ/7Vd3EcY0UxFi2i9+RuPGNK0B9EBPXihpm
         oUa+qruMtV1+6I2GkgFvsNM6W+HR5D6aJVOKERcf1lmLngJJRCyKWftKD3uG13rqY7l3
         DunZ5ZeF3Mn7ELnII7AQEF+Uv6Ys6pg7tCpDX0of/B+WHThu+2XmAFYlD9Q2JDJ30BEj
         e0CJE/QA5xfYuEHv0lnV9k5TZMSENbgz7nbrihAkqnaLRyTrkAJh/nWoxuMQBynGJtQX
         TJPw==
X-Gm-Message-State: AOAM533vSMUThrs2BFNpuKqiYOTSnU6mi8S8X+GnAgzODZlh0m3wdhy4
        Q7NpMtuKsbeo9NDfktliK3kU5M8omxM=
X-Google-Smtp-Source: ABdhPJyqDfVGDlyJGdZKVetQos1WYPj1ukAf3TEM4/L/Oy5RCry3ceKPCHHXAsB0JLeXI9g1eFrZiA==
X-Received: by 2002:a05:6a00:c8a:b0:47b:ff6e:4cf3 with SMTP id a10-20020a056a000c8a00b0047bff6e4cf3mr5897503pfv.50.1635205277226;
        Mon, 25 Oct 2021 16:41:17 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id g7sm16607133pgp.17.2021.10.25.16.41.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 16:41:16 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 18/23] Bluetooth: hci_sync: Convert MGMT_OP_SET_PHY_CONFIGURATION
Date:   Mon, 25 Oct 2021 16:40:57 -0700
Message-Id: <20211025234102.1140719-19-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211025234102.1140719-1-luiz.dentz@gmail.com>
References: <20211025234102.1140719-1-luiz.dentz@gmail.com>
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
 net/bluetooth/mgmt.c | 115 ++++++++++++++++++++++++-------------------
 1 file changed, 65 insertions(+), 50 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 0b668ef46e23..b36c5af5bf46 100644
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
+				sizeof(cp_phy), &cp_phy, HCI_CMD_TIMEOUT);
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
@@ -3555,44 +3595,19 @@ static int set_phy_configuration(struct sock *sk, struct hci_dev *hdev,
 
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
+						set_default_phy_complete);
 
-	hci_req_add(&req, HCI_OP_LE_SET_DEFAULT_PHY, sizeof(cp_phy), &cp_phy);
+	if (err < 0) {
+		err = mgmt_cmd_status(sk, hdev->id,
+			MGMT_OP_SET_PHY_CONFIGURATION, MGMT_STATUS_FAILED);
 
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

