Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A7AC433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Feb 2022 21:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235531AbiBPVb6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Feb 2022 16:31:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235512AbiBPVb5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Feb 2022 16:31:57 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3F112A8F
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Feb 2022 13:31:40 -0800 (PST)
Received: from localhost.localdomain (ip-213-127-118-180.ip.prioritytelecom.net [213.127.118.180])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id C55C3C5907;
        Wed, 16 Feb 2022 21:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1645046741; bh=dKnxD0aXYT0EFhbCv6B7fRldqOkZkR9yg9XBqWNSxlM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=g3A+vtkUhy3BmhXSAcQCxylFPW6giTfcx23HcfK1XjJaT7c65h8rE+qoflreJ4a1a
         zknKDidyMOMGZzNFicdfKb0cLXP6MrluF5D6ji2yLUusGEIS06w8Kuk6H5OH3PGA+R
         k1jcRjJN4GNogKiuoJHY5Kp970kzCS5cn5K+BnLk=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] Bluetooth: hci_bcm: add BCM43430A0
Date:   Wed, 16 Feb 2022 22:24:29 +0100
Message-Id: <20220216212433.1373903-3-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220216212433.1373903-1-luca@z3ntu.xyz>
References: <20220216212433.1373903-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add the compatible for BCM43430A0 bluetooth to the driver.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 drivers/bluetooth/hci_bcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index d634a27bc850..e19c7a41a4f6 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -1513,6 +1513,7 @@ static const struct of_device_id bcm_bluetooth_of_match[] = {
 	{ .compatible = "brcm,bcm4330-bt" },
 	{ .compatible = "brcm,bcm4334-bt" },
 	{ .compatible = "brcm,bcm4345c5" },
+	{ .compatible = "brcm,bcm43430a0-bt" },
 	{ .compatible = "brcm,bcm43438-bt", .data = &bcm43438_device_data },
 	{ .compatible = "brcm,bcm43540-bt", .data = &bcm4354_device_data },
 	{ .compatible = "brcm,bcm4335a0" },
-- 
2.35.1

