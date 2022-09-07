Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459E4ECAAD3
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Sep 2022 23:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiIGXWg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Sep 2022 19:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiIGXWf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Sep 2022 19:22:35 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E346F9E0C2
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Sep 2022 16:22:34 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id r17so2578692pgr.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Sep 2022 16:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date;
        bh=k8Xtps4ZdAE3VhEKw8jsuRmLjTJAgNC/3l4zoVX7kLw=;
        b=g9mipdVlqj89UoMbKU4H2ODk8uD9ogDrwWpQ3aqRu2/jlf5OopRsIaaPtmqkS7gVUd
         bRMZoC6kcKJg62iWqP5z1eK+zsNhrw4X/nOilCHtcVq1grkCohdoJ/DBzZGB3GiS//kv
         XuDqSeovlVIVXhmRta5Ul3czl98iRgb12AXjuwS01BzXgJneUOwRGUTQsfL9hvm8pC6X
         kYfWTw/oAZGwzxORD3a5072axBsmlNJgjcrM7HuE+uiQIAiwPfeM2illZIlccBQvJaKB
         TeGH3oT5sImCVPz1v3y8oQxCqRiQJGRykC0AS9YCUL2fk7KZWYgKd6UoNFOeSOtGEPQ6
         T/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=k8Xtps4ZdAE3VhEKw8jsuRmLjTJAgNC/3l4zoVX7kLw=;
        b=hG8+iBbw/27R4kCowyUYUCM9vH+Dzmo+dQH625VvLPvc5Duj1hirmD4Aqz3bj4xQff
         HHz9gDkVOdKFe3aC4vYqW3GQG11XfjZfZtvk4EpGmwnxzPIOdKETmZUCCMSdb6t2NhyB
         bTdquwo3OwRKjOjVVvYtIDOLIGblq2ylBLL2YXGsZyUR2XbYto6OtWI1GHMDuKjKDmoM
         fMPevFZET4EW6C3AvIXv26RLhEJRJMCbDRmZKhT+JU1zDjsM1zgDfs0k6vAGoeAnifSc
         J8f2jNZVO1UBHgDDjbwP+AEqjzhyHdIHweqYWovCYgXqtfB+NgyWOXB2TlSOsRCWVegE
         O1dw==
X-Gm-Message-State: ACgBeo2Il6JEmW3mDzjFMeTI2CVabI65DrL8TrZuz7NMt/UHOtitl43e
        QiMtFeApOjLBoK79ecNBqIAB/OWyzus15Q==
X-Google-Smtp-Source: AA6agR4VTou7Bq6ScNmu+3xJNGQoQLb2itBou2+jlwUgYxR2LNGOvGcaD+RbT6qdjfBCfwAlYs9FmQ==
X-Received: by 2002:a63:5522:0:b0:42b:976d:dcd4 with SMTP id j34-20020a635522000000b0042b976ddcd4mr5152573pgb.421.1662592953824;
        Wed, 07 Sep 2022 16:22:33 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id x11-20020a170902ec8b00b00176b63535adsm7241789plg.260.2022.09.07.16.22.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 16:22:33 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] Bluetooth: MGMT: Fix Set PHY Configuration command
Date:   Wed,  7 Sep 2022 16:22:31 -0700
Message-Id: <20220907232232.3248525-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.2
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
index 4c421ebac669..34443db21e44 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4020,8 +4020,8 @@ static int set_default_phy_sync(struct hci_dev *hdev, void *data)
 	if (!(selected_phys & MGMT_PHY_LE_RX_MASK))
 		cp_phy.all_phys |= 0x02;
 
-	if (selected_phys & MGMT_PHY_LE_1M_TX)
-		cp_phy.tx_phys |= HCI_LE_SET_PHY_1M;
+	/* 1M PHY shall always be supported */
+	cp_phy.tx_phys |= HCI_LE_SET_PHY_1M;
 
 	if (selected_phys & MGMT_PHY_LE_2M_TX)
 		cp_phy.tx_phys |= HCI_LE_SET_PHY_2M;
@@ -4029,8 +4029,8 @@ static int set_default_phy_sync(struct hci_dev *hdev, void *data)
 	if (selected_phys & MGMT_PHY_LE_CODED_TX)
 		cp_phy.tx_phys |= HCI_LE_SET_PHY_CODED;
 
-	if (selected_phys & MGMT_PHY_LE_1M_RX)
-		cp_phy.rx_phys |= HCI_LE_SET_PHY_1M;
+	/* 1M PHY shall always be supported */
+	cp_phy.rx_phys |= HCI_LE_SET_PHY_1M;
 
 	if (selected_phys & MGMT_PHY_LE_2M_RX)
 		cp_phy.rx_phys |= HCI_LE_SET_PHY_2M;
@@ -4049,14 +4049,13 @@ static int set_phy_configuration(struct sock *sk, struct hci_dev *hdev,
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
 
@@ -4065,13 +4064,6 @@ static int set_phy_configuration(struct sock *sk, struct hci_dev *hdev,
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
2.37.2

