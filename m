Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16525C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Sep 2021 10:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F09B761882
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Sep 2021 10:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349855AbhI3Kii (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Sep 2021 06:38:38 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:33360 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241052AbhI3Kih (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Sep 2021 06:38:37 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 18UAae5tB001743, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36503.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 18UAae5tB001743
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 30 Sep 2021 18:36:40 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36503.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 30 Sep 2021 18:36:40 +0800
Received: from localhost.localdomain (172.21.132.99) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 30 Sep 2021 18:36:39 +0800
From:   <hildawu@realtek.com>
To:     <marcel@holtmann.org>
CC:     <johan.hedberg@gmail.com>, <luiz.dentz@gmail.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kai.heng.feng@canonical.com>, <apusaka@chromium.org>,
        <max.chou@realtek.com>, <alex_lu@realsil.com.cn>,
        <kidman@realtek.com>
Subject: [PATCH] Bluetooth: btrtl: Ask ic_info to drop firmware
Date:   Thu, 30 Sep 2021 18:36:34 +0800
Message-ID: <20210930103634.1710-1-hildawu@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.132.99]
X-ClientProxiedBy: RTEXH36504.realtek.com.tw (172.21.6.27) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 09/30/2021 01:34:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzkvMjkgpFWkyCAxMToyNzowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36503.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Hilda Wu <hildawu@realtek.com>

Some un-support wakeup platforms keep USB power and suspend signal
is coming late, this makes Realtek some chip keep its firmware,
and make it never load new firmware.

So use vendor specific HCI command to ask them drop its firmware after
system shutdown or resume.

Signed-off-by: Hilda Wu <hildawu@realtek.com>
---
 drivers/bluetooth/btrtl.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 1f8afa0244d8..60ddba8962ff 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -594,8 +594,10 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 	hci_rev = le16_to_cpu(resp->hci_rev);
 	lmp_subver = le16_to_cpu(resp->lmp_subver);
 
-	if (resp->hci_ver == 0x8 && le16_to_cpu(resp->hci_rev) == 0x826c &&
-	    resp->lmp_ver == 0x8 && le16_to_cpu(resp->lmp_subver) == 0xa99e)
+	btrtl_dev->ic_info = btrtl_match_ic(lmp_subver, hci_rev, hci_ver,
+					    hdev->bus);
+
+	if (!btrtl_dev->ic_info)
 		btrtl_dev->drop_fw = true;
 
 	if (btrtl_dev->drop_fw) {
@@ -634,13 +636,13 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 		hci_ver = resp->hci_ver;
 		hci_rev = le16_to_cpu(resp->hci_rev);
 		lmp_subver = le16_to_cpu(resp->lmp_subver);
+
+		btrtl_dev->ic_info = btrtl_match_ic(lmp_subver, hci_rev, hci_ver,
+						    hdev->bus);
 	}
 out_free:
 	kfree_skb(skb);
 
-	btrtl_dev->ic_info = btrtl_match_ic(lmp_subver, hci_rev, hci_ver,
-					    hdev->bus);
-
 	if (!btrtl_dev->ic_info) {
 		rtl_dev_info(hdev, "unknown IC info, lmp subver %04x, hci rev %04x, hci ver %04x",
 			    lmp_subver, hci_rev, hci_ver);
-- 
2.17.1

