Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5DBC4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Oct 2021 23:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C6F9610CB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Oct 2021 23:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbhJ1ABo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Oct 2021 20:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbhJ1ABl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Oct 2021 20:01:41 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24F0C0613B9
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Oct 2021 16:59:15 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id s24so3201725plp.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Oct 2021 16:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KqCSnk9X7JexBPsKor61tfqCadTRKqAKFlEiy7ZXZ+0=;
        b=HM/61oLUdgRDTYclUAXSFM8J4V4vIkjPoRLBE8Tu0Qxp4KHDmk3k+9Z06Rj6GNuhZ/
         BgDu04CWqldOITRbKJJEOnELv20uHpOiaDVa4IgvEAfFPRHTTwrFji1B8UQmLj6UjZ5t
         aaGbRiFOh6SIt+2t+CL8t6aKxXLFTgBrDQVTk4JREm5GgAsY8e3GteeAQY1q4iJ567YY
         +fAl6wp3z88QKxUZecBEj7chTfHDZ7Rqp0Mg0laEz4hw6C8FZUu4VJdOAZ7UvFhkuKL9
         ZEVREAKWWzug4NThEIDU164jyKGcJI3JiZVGXMTmbSHXGXyg88KGoGQ9z1z0zaCWqyfe
         C3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KqCSnk9X7JexBPsKor61tfqCadTRKqAKFlEiy7ZXZ+0=;
        b=Yy/9rOQZIUdejo54tEkES4oE2I1NBcFUoIzxpWHIrHPRYOzwlEH2I2O9mK9nvV+zRH
         5DdJ155sN/sPU56SKHboz1EcNEYGNv+iJJ9s2X0KIUqrvwSzR6HlaGKKY43pH7EWmCpE
         UmNOZLZZY7flgiRN/lkzoc0x3Dw45TQP/+2N3DTLSSlCuisRz4LPSjDW6MPYuz1l+NJw
         pF6k9OfNDmHLcyB+FKMAYJ43PgLiTTpGV6eid5qIFFyteylwq/F3GCev9Lyl36mftkCO
         gj78fjlNEZIkFizEL4IbUKdLMkP2HTSzn1+UZs95t+d8rXRIsmblbBw6+iqoepW8qrVj
         JJNg==
X-Gm-Message-State: AOAM530bJ9xMbMfvVzMQK0IiQqZABY/TEfCTcZwMK8DYaRWm8kLoT4qS
        JkjjBU1+4ZNFP6FuDnhzsxxrq0b+VAM=
X-Google-Smtp-Source: ABdhPJxb/5Mt0SajDIsqMStrXVHYtW7uoC0E5cXeldMbTWkiljp0dqw3lCMBBtMQTsEPkZIlqnA+BA==
X-Received: by 2002:a17:902:900c:b0:13f:974c:19b0 with SMTP id a12-20020a170902900c00b0013f974c19b0mr673769plp.12.1635379155223;
        Wed, 27 Oct 2021 16:59:15 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 142sm807908pgh.22.2021.10.27.16.59.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 16:59:14 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v8 18/23] Bluetooth: hci_sync: Convert MGMT_OP_SET_PHY_CONFIGURATION
Date:   Wed, 27 Oct 2021 16:58:55 -0700
Message-Id: <20211027235900.1882863-19-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211027235900.1882863-1-luiz.dentz@gmail.com>
References: <20211027235900.1882863-1-luiz.dentz@gmail.com>
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
index 2585eab1fe21..b8b3176e05b6 100644
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

