Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BF5C4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  5 Dec 2022 17:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbiLERwO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 5 Dec 2022 12:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbiLERvh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 5 Dec 2022 12:51:37 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC6B102F
        for <linux-bluetooth@vger.kernel.org>; Mon,  5 Dec 2022 09:50:18 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id jl24so11518090plb.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Dec 2022 09:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JLvIBMr40K8Qq9iAS6tWF3dVA/qeXf80EpHj/RZX7tA=;
        b=JMfHQEam9TBA4cCC5CrZbr/91x9B6aTF1pqU+SwD4ssqMqEQobUVO6cnm951RXMvAs
         tkwFEwIkKMLrfsb6YRVA7VdEhPA9nPIZFJPRLOcCkKsHK7Y+leKbTHijEspww0G74Hcb
         b4oyZNbZgzvlVIlpXnfYOYKOsNOBEO4EfgRT42Tm1FGmLfCnNlrROyg8+YBxvt5WctjN
         M3gte7nirBNs59z4kFLo57QZEObOZSNe1nSRqUaAGMA5Gxs3mMkySATNzga779VjB8nt
         Vcz5zHPSoNHppfn4Rn2NXqfz18ZXqKCDEwZgC8Z6aovNp0KwWPAmSEIYzq1ONelLv+cE
         yzjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JLvIBMr40K8Qq9iAS6tWF3dVA/qeXf80EpHj/RZX7tA=;
        b=mRFfURBRdvVMzSqKdRAle7TuQ0v6TNvHfmgO1IKUshSiW6qgdrnuChXcHE4T7Z/1Th
         5aB6dUb8KA4owFU5bwhLoeD4zAix0iuoix8pm5m2+7CN4LwKqpxIB4Tfs6Dl8DMKc3zS
         Av1Z3l8+C2mMuHREnoPGOcqMDX6719i2pHMt7x3G1PcmuAvx1RVp6rea8o7+wk2f+TAb
         ocucHbcmHRY6W2INexdQVdakRJd4EppXpa9jBp91qF8KwgYN1vcKXRAwaR1RNlfWDarJ
         bdVP9q8TP80IoKXNb4/u+kJMsS2u/P3ydM9JOGhOrfPRxSfy4dXcTEBcirCYt0EalhPk
         +6MA==
X-Gm-Message-State: ANoB5pmNn1KzLr6j0AkDugWZhL+1TXZFxcn3bO1li9heVFPIeFk99Yc9
        UuNu59N1QWolOHqHvKGNAkq55ntsmIU4nSit
X-Google-Smtp-Source: AA0mqf5EcQvedZr30J+1//Dmj1+2oqmg9IqsJUFNXFOZmExg4HQMYPy2OSzAAo/PGYT6ueNE0m7O6A==
X-Received: by 2002:a17:902:f601:b0:186:8431:ece3 with SMTP id n1-20020a170902f60100b001868431ece3mr67802750plg.8.1670262617702;
        Mon, 05 Dec 2022 09:50:17 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id y7-20020a17090a2b4700b0021806f631ccsm9416842pjc.30.2022.12.05.09.50.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 09:50:16 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Fix new sparce warnings
Date:   Mon,  5 Dec 2022 09:50:16 -0800
Message-Id: <20221205175016.3340062-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fix the following warnings detect with make W=1:

drivers/bluetooth/btusb.c:2212:9: warning: cast to restricted __le16
drivers/bluetooth/btusb.c:2212:9: warning: cast to restricted __le16
drivers/bluetooth/btusb.c:2245:18: warning: cast to restricted __le16
drivers/bluetooth/btusb.c:2249:18: warning: cast to restricted __le16
drivers/bluetooth/btusb.c:2253:18: warning: cast to restricted __le16
drivers/bluetooth/btusb.c:2257:18: warning: cast to restricted __le16
drivers/bluetooth/btusb.c:2261:18: warning: cast to restricted __le16
drivers/bluetooth/btusb.c:2267:18: warning: cast to restricted __le16

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/btusb.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index d57571cc82d4..422c878a9500 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2201,18 +2201,19 @@ static int btusb_setup_csr(struct hci_dev *hdev)
 		return err;
 	}
 
-	if (skb->len != sizeof(struct hci_rp_read_local_version)) {
+	rp = skb_pull_data(skb, sizeof(*rp));
+	if (!rp) {
 		bt_dev_err(hdev, "CSR: Local version length mismatch");
 		kfree_skb(skb);
 		return -EIO;
 	}
 
-	rp = (struct hci_rp_read_local_version *)skb->data;
+	bt_dev_info(hdev, "CSR: Setting up dongle with HCI ver=%u rev=%04x",
+		    rp->hci_ver, le16_to_cpu(rp->hci_rev));
 
-	bt_dev_info(hdev, "CSR: Setting up dongle with HCI ver=%u rev=%04x; LMP ver=%u subver=%04x; manufacturer=%u",
-		le16_to_cpu(rp->hci_ver), le16_to_cpu(rp->hci_rev),
-		le16_to_cpu(rp->lmp_ver), le16_to_cpu(rp->lmp_subver),
-		le16_to_cpu(rp->manufacturer));
+	bt_dev_info(hdev, "LMP ver=%u subver=%04x; manufacturer=%u",
+		    rp->lmp_ver, le16_to_cpu(rp->lmp_subver),
+		    le16_to_cpu(rp->manufacturer));
 
 	/* Detect a wide host of Chinese controllers that aren't CSR.
 	 *
@@ -2242,29 +2243,29 @@ static int btusb_setup_csr(struct hci_dev *hdev)
 	 *      third-party BT 4.0 dongle reuses it.
 	 */
 	else if (le16_to_cpu(rp->lmp_subver) <= 0x034e &&
-		 le16_to_cpu(rp->hci_ver) > BLUETOOTH_VER_1_1)
+		 rp->hci_ver > BLUETOOTH_VER_1_1)
 		is_fake = true;
 
 	else if (le16_to_cpu(rp->lmp_subver) <= 0x0529 &&
-		 le16_to_cpu(rp->hci_ver) > BLUETOOTH_VER_1_2)
+		 rp->hci_ver > BLUETOOTH_VER_1_2)
 		is_fake = true;
 
 	else if (le16_to_cpu(rp->lmp_subver) <= 0x0c5c &&
-		 le16_to_cpu(rp->hci_ver) > BLUETOOTH_VER_2_0)
+		 rp->hci_ver > BLUETOOTH_VER_2_0)
 		is_fake = true;
 
 	else if (le16_to_cpu(rp->lmp_subver) <= 0x1899 &&
-		 le16_to_cpu(rp->hci_ver) > BLUETOOTH_VER_2_1)
+		 rp->hci_ver > BLUETOOTH_VER_2_1)
 		is_fake = true;
 
 	else if (le16_to_cpu(rp->lmp_subver) <= 0x22bb &&
-		 le16_to_cpu(rp->hci_ver) > BLUETOOTH_VER_4_0)
+		 rp->hci_ver > BLUETOOTH_VER_4_0)
 		is_fake = true;
 
 	/* Other clones which beat all the above checks */
 	else if (bcdDevice == 0x0134 &&
 		 le16_to_cpu(rp->lmp_subver) == 0x0c5c &&
-		 le16_to_cpu(rp->hci_ver) == BLUETOOTH_VER_2_0)
+		 rp->hci_ver == BLUETOOTH_VER_2_0)
 		is_fake = true;
 
 	if (is_fake) {
-- 
2.37.3

