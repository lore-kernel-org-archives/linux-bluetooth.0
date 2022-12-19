Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E574C4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Dec 2022 21:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbiLSVhN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Dec 2022 16:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbiLSVhH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Dec 2022 16:37:07 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060CF13E23
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Dec 2022 13:37:06 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id b13-20020a17090a5a0d00b0021906102d05so10146401pjd.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Dec 2022 13:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=cr6/l6xNH/9Pi+33Q0P1XjTiBGSRTzK0/VL1DLYjTIE=;
        b=FYQJMyu47ZcfDAdWhgH3aLHAlOIJYdAu6bMyPCeblz/lMnTjtCx5vuxcV3KLHN8WEh
         8jgwNBzbpQcs8Wq/9lJC52V9p3IR89Ul1of2nLTnOg9LIy+F5JcsqgmBIpGl8+uJVvsE
         azhgOXgeDhaNTwr7dLQHFC2oJxZJbxs1oMbANzsgIHxfVk/3dwHCvJ2TTUE91sby++UE
         jSA2juWIcosK2PakDCHkKhiblQec2hJCwYGCt1kvCRwyX2VmdT7w/kZy6/sXEcOxmGzJ
         gdTUF9DcIGbOgl6PHbaUdiHd751ROXynEBvyBpYcE4NyEhuEmpQl9b5t8/DzBJpXdJJN
         kbnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cr6/l6xNH/9Pi+33Q0P1XjTiBGSRTzK0/VL1DLYjTIE=;
        b=A9BUbYe4fKcIqqJv7MIUiytttd0uKJKLBnAYKzKm952ZILonyC2J5EOfQwNzglvRL1
         +52ugHpOVpVVl8NqdkAYg5lBzAClDAIIY5QqG/v2rAZqC1KDbj/IeqZ87rnCzXtAyUbM
         oZOMyndWMx+9O7IngFlZ3vBui4R7u+ddExNLvOy/q/DSjc1MHH68YtrEtTOheeYR7++0
         NsBFFy7/t+QH29LugdfiyWp5chb3N3hWY3WZDZaLZ3krCgSUeLgQnZVi7IgQDl2HW0vM
         e6KUhUrj9SjAblbkcnp3kRed9osfda2ygaBxRL2dpMEvHhDGvFNTznkffRLZiV4C7D1O
         oOTQ==
X-Gm-Message-State: ANoB5plL5xPxldAUAX95g1R4ZL6DJ+2LRdCbMSt5cb6SwYWex4+vY/0M
        CxceQuh77yu9kECtlHQZkUr1dJuaCqt7sg==
X-Google-Smtp-Source: AA0mqf6crRHzTBz9W8EjrrlChKzVm32Exzr99cg2fucJlY9VbHjpYDEMK9jncqDUGPpHb9qjSn6uYQ==
X-Received: by 2002:a17:903:2345:b0:189:ba1f:b178 with SMTP id c5-20020a170903234500b00189ba1fb178mr64139773plh.9.1671485824891;
        Mon, 19 Dec 2022 13:37:04 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id ij24-20020a170902ab5800b00177efb56475sm7668116plb.85.2022.12.19.13.37.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 13:37:04 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RESEND 1/2] Bluetooth: MGMT: Fix Set PHY Configuration command
Date:   Mon, 19 Dec 2022 13:37:01 -0800
Message-Id: <20221219213702.3659417-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The command shall accept any subset that is considered configurable but
instead it was only accepting the exact match causing errors such as:

[mgmt]# phy
Supported phys: BR1M1SLOT BR1M3SLOT BR1M5SLOT EDR2M1SLOT EDR2M3SLOT
EDR2M5SLOT EDR3M1SLOT EDR3M3SLOT EDR3M5SLOT LE1MTX LE1MRX LE2MTX
LE2MRX LECODEDTX LECODEDRX
Configurable phys: BR1M3SLOT BR1M5SLOT EDR2M1SLOT EDR2M3SLOT EDR2M5SLOT
EDR3M1SLOT EDR3M3SLOT EDR3M5SLOT LE2MTX LE2MRX LECODEDTX LECODEDRX
Selected phys: BR1M1SLOT BR1M3SLOT BR1M5SLOT EDR2M1SLOT EDR2M3SLOT
EDR2M5SLOT EDR3M1SLOT EDR3M3SLOT EDR3M5SLOT LE1MTX LE1MRX
[mgmt]# phy BR1M3SLOT BR1M5SLOT EDR2M1SLOT EDR2M3SLOT EDR2M5SLOT
EDR3M1SLOT EDR3M3SLOT EDR3M5SLOT LE2MTX LE2MRX
Could not set PHY Configuration with status 0x0d (Invalid Parameters)

Fixes: 0314f2867fa0 ("Bluetooth: Implement Set PHY Confguration command")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/mgmt.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 0dd30a3beb77..dad6fd9abe95 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4022,8 +4022,8 @@ static int set_default_phy_sync(struct hci_dev *hdev, void *data)
 	if (!(selected_phys & MGMT_PHY_LE_RX_MASK))
 		cp_phy.all_phys |= 0x02;
 
-	if (selected_phys & MGMT_PHY_LE_1M_TX)
-		cp_phy.tx_phys |= HCI_LE_SET_PHY_1M;
+	/* 1M PHY shall always be supported */
+	cp_phy.tx_phys |= HCI_LE_SET_PHY_1M;
 
 	if (selected_phys & MGMT_PHY_LE_2M_TX)
 		cp_phy.tx_phys |= HCI_LE_SET_PHY_2M;
@@ -4031,8 +4031,8 @@ static int set_default_phy_sync(struct hci_dev *hdev, void *data)
 	if (selected_phys & MGMT_PHY_LE_CODED_TX)
 		cp_phy.tx_phys |= HCI_LE_SET_PHY_CODED;
 
-	if (selected_phys & MGMT_PHY_LE_1M_RX)
-		cp_phy.rx_phys |= HCI_LE_SET_PHY_1M;
+	/* 1M PHY shall always be supported */
+	cp_phy.rx_phys |= HCI_LE_SET_PHY_1M;
 
 	if (selected_phys & MGMT_PHY_LE_2M_RX)
 		cp_phy.rx_phys |= HCI_LE_SET_PHY_2M;
@@ -4051,14 +4051,13 @@ static int set_phy_configuration(struct sock *sk, struct hci_dev *hdev,
 {
 	struct mgmt_cp_set_phy_configuration *cp = data;
 	struct mgmt_pending_cmd *cmd;
-	u32 selected_phys, configurable_phys, supported_phys, unconfigure_phys;
+	u32 selected_phys, supported_phys;
 	u16 pkt_type = (HCI_DH1 | HCI_DM1);
 	bool changed = false;
 	int err;
 
 	bt_dev_dbg(hdev, "sock %p", sk);
 
-	configurable_phys = get_configurable_phys(hdev);
 	supported_phys = get_supported_phys(hdev);
 	selected_phys = __le32_to_cpu(cp->selected_phys);
 
@@ -4067,13 +4066,6 @@ static int set_phy_configuration(struct sock *sk, struct hci_dev *hdev,
 				       MGMT_OP_SET_PHY_CONFIGURATION,
 				       MGMT_STATUS_INVALID_PARAMS);
 
-	unconfigure_phys = supported_phys & ~configurable_phys;
-
-	if ((selected_phys & unconfigure_phys) != unconfigure_phys)
-		return mgmt_cmd_status(sk, hdev->id,
-				       MGMT_OP_SET_PHY_CONFIGURATION,
-				       MGMT_STATUS_INVALID_PARAMS);
-
 	if (selected_phys == get_selected_phys(hdev))
 		return mgmt_cmd_complete(sk, hdev->id,
 					 MGMT_OP_SET_PHY_CONFIGURATION,
-- 
2.37.3

