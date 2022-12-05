Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C599C4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  5 Dec 2022 18:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233303AbiLESj1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 5 Dec 2022 13:39:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232839AbiLESjH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 5 Dec 2022 13:39:07 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E45BCA
        for <linux-bluetooth@vger.kernel.org>; Mon,  5 Dec 2022 10:32:44 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id q15so11031889pja.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Dec 2022 10:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=oiQ7kqQcZglR2eF387n2myjsQOhqcKBThxzbTBU0Vwo=;
        b=juFvt0pqMtEIIumZntfjK5LJvV1QKekoyzqEfNB7/5+UgS55rWeaC6XmMFeZFksxML
         P3zZrtcL2MZyUlNcKWf/JRIt2Ee47841bVdJbtkubZPeFy29ZXR8Xpf5XBXTznslBZyW
         3HsYCTyeyuakUo5ViPgp35ltmqaUuqX1oBDwj0DZCJfcNlrK+iqXo1SWM3WSPVwJtoHm
         qDdIMeirSWfQwAOdL6/faq+lN79eGQ7TrhHHleWzfLsSiPk9HQjuinWGEGFTl7omeGgP
         uP1Q3kJK9+WKD2P8ZJO42x7q1sTrl8cTCGqtojs5XAcPmB61UnXPXu3Vm3lTC9PVH+l7
         laEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oiQ7kqQcZglR2eF387n2myjsQOhqcKBThxzbTBU0Vwo=;
        b=lja4Hje3i5nPHmcsegKoS78OWmu7sDJMmKKnUgMuv1m4s3f/0XAveHb1P5bxdvRAGf
         9xpG6eryDidxPmKQgobJYqUpvB4RXAgG0sDiPch069E3sqgZVngie5f98reAk7NcdEC7
         fhw9SBenqtaHpe31060RnJYeSSL9NdqdkGnbmBxj9HUPqkzoFJin3A+E/8owVVi46VW4
         9cezYIWv2T2MDsz+5UXaMFs2q/0HwBuzb61pWuvKiGij93k2mEi1cGSggkUqpaUTMfoV
         3GxbEfc2xezp1l60CnRu+lqNV5TgzS4UTaLlcYDliWmjI8hdvBVxtD9C2k1rQEz+3Hk/
         cm0A==
X-Gm-Message-State: ANoB5plTrwIyS7W5OlJR8wIwJjNcBZzGKL39DfgauotHAEs75UECkwZd
        IfzrMU0Cj6t+c23mcs4nElhOE3UIinr8znFT
X-Google-Smtp-Source: AA0mqf6C3vwLGvv0rT1SmMUt8qZWpyuIyfpPwtj+E1kCJ4e7yyNBSFob2n9EIh/56r/hWaayzIgqiw==
X-Received: by 2002:a17:90b:2642:b0:219:55d5:f30a with SMTP id pa2-20020a17090b264200b0021955d5f30amr32929451pjb.23.1670265163311;
        Mon, 05 Dec 2022 10:32:43 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id l124-20020a622582000000b00573eb4a9a66sm10204079pfl.2.2022.12.05.10.32.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 10:32:42 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/3] Bluetooth: btusb: Fix new sparce warnings
Date:   Mon,  5 Dec 2022 10:32:34 -0800
Message-Id: <20221205183236.3460924-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fix the following warnings detect with make W=1 C=1:

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

