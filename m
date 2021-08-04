Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315C3C4320A
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Aug 2021 10:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1954E601FC
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Aug 2021 10:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237366AbhHDKFH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Aug 2021 06:05:07 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:37632 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235419AbhHDKFG (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Aug 2021 06:05:06 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1628071494; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=01PL1JCEftvWMZM72aDccUWunAyiu+MxKdhkYk1qIOw=; b=l6LgS6C4LFrcJOdZQyp+5OOT6XsEtYHFm25/Ej9OSg4VAJ2/1yblWVFdS2eG89hw72UNSi8Z
 mv3QXZ2AMkRAfK8B6to00L6wXwZhQjyVZe6tWE+PHVoLfY6+owaGz44l7zahW+V38uI/SPmd
 +/gczFicoroBoIy79BYRHE7WUYQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI2MTA3ZSIsICJsaW51eC1ibHVldG9vdGhAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 610a6634bcdc32aad357d115 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 04 Aug 2021 10:04:36
 GMT
Sender: zijuhu=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 61656C433D3; Wed,  4 Aug 2021 10:04:36 +0000 (UTC)
Received: from zijuhu-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: zijuhu)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 72776C43460;
        Wed,  4 Aug 2021 10:04:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 72776C43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=zijuhu@codeaurora.org
From:   Zijun Hu <zijuhu@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        c-hbandi@codeaurora.org, hemantg@codeaurora.org, mka@chromium.org,
        rjliao@codeaurora.org, zijuhu@codeaurora.org, tjiang@codeaurora.org
Subject: [PATCH v1] Bluetooth: btusb: Add support different nvm to distinguish different factory for WCN6855 controller
Date:   Wed,  4 Aug 2021 18:04:27 +0800
Message-Id: <1628071467-27190-1-git-send-email-zijuhu@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tim Jiang <tjiang@codeaurora.org>

we have different factory to produce wcn6855 soc chip, so we should use
different nvm file with surfix to distinguish them.

Signed-off-by: Tim Jiang <tjiang@codeaurora.org>
---
 drivers/bluetooth/btusb.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index b1a05bb9f4bf..cc9618575ab4 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4013,6 +4013,9 @@ static int btusb_set_bdaddr_wcn6855(struct hci_dev *hdev,
 #define QCA_DFU_TIMEOUT		3000
 #define QCA_FLAG_MULTI_NVM      0x80
 
+#define WCN6855_2_0_RAM_VERSION_GF 0x400c1200
+#define WCN6855_2_1_RAM_VERSION_GF 0x400c1211
+
 struct qca_version {
 	__le32	rom_version;
 	__le32	patch_version;
@@ -4044,6 +4047,7 @@ static const struct qca_device_info qca_devices_table[] = {
 	{ 0x00000302, 28, 4, 16 }, /* Rome 3.2 */
 	{ 0x00130100, 40, 4, 16 }, /* WCN6855 1.0 */
 	{ 0x00130200, 40, 4, 16 }, /* WCN6855 2.0 */
+	{ 0x00130201, 40, 4, 16 }, /* WCN6855 2.1 */
 };
 
 static int btusb_qca_send_vendor_req(struct usb_device *udev, u8 request,
@@ -4209,12 +4213,28 @@ static int btusb_setup_qca_load_nvm(struct hci_dev *hdev,
 	if (((ver->flag >> 8) & 0xff) == QCA_FLAG_MULTI_NVM) {
 		/* if boardid equal 0, use default nvm without surfix */
 		if (le16_to_cpu(ver->board_id) == 0x0) {
-			snprintf(fwname, sizeof(fwname), "qca/nvm_usb_%08x.bin",
-				 le32_to_cpu(ver->rom_version));
+			/* if ram version is for gf factory, we should add surfix gf to
+			 * distinguish with default one .
+			 */
+			if (ver->ram_version == WCN6855_2_0_RAM_VERSION_GF ||
+					ver->ram_version == WCN6855_2_1_RAM_VERSION_GF) {
+				snprintf(fwname, sizeof(fwname), "qca/nvm_usb_%08x_gf.bin",
+					 le32_to_cpu(ver->rom_version));
+			} else {
+				snprintf(fwname, sizeof(fwname), "qca/nvm_usb_%08x.bin",
+					 le32_to_cpu(ver->rom_version));
+			}
 		} else {
-			snprintf(fwname, sizeof(fwname), "qca/nvm_usb_%08x_%04x.bin",
-				le32_to_cpu(ver->rom_version),
-				le16_to_cpu(ver->board_id));
+			if (ver->ram_version == WCN6855_2_0_RAM_VERSION_GF ||
+					ver->ram_version == WCN6855_2_1_RAM_VERSION_GF) {
+				snprintf(fwname, sizeof(fwname), "qca/nvm_usb_%08x_gf_%04x.bin",
+					le32_to_cpu(ver->rom_version),
+					le16_to_cpu(ver->board_id));
+			} else {
+				snprintf(fwname, sizeof(fwname), "qca/nvm_usb_%08x_%04x.bin",
+					le32_to_cpu(ver->rom_version),
+					le16_to_cpu(ver->board_id));
+			}
 		}
 	} else {
 		snprintf(fwname, sizeof(fwname), "qca/nvm_usb_%08x.bin",
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

