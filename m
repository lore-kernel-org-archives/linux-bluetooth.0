Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9197C433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Jan 2021 13:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC342206C0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Jan 2021 13:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391645AbhAZMp1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Jan 2021 07:45:27 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:47813 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730893AbhAZKBh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Jan 2021 05:01:37 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 10QA0gcE6022247, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs03.realtek.com.tw[172.21.6.96])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 10QA0gcE6022247
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 26 Jan 2021 18:00:42 +0800
Received: from localhost.localdomain (172.21.132.186) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 26 Jan 2021 18:00:42 +0800
From:   <max.chou@realtek.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <luiz.dentz@gmail.com>, <linux-bluetooth@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <alex_lu@realsil.com.cn>, <hildawu@realtek.com>,
        <kidman@realtek.com>, <max.chou@realtek.com>,
        <abhishekpandit@chromium.org>, <josephsih@chromium.org>
Subject: [PATCH v5] Bluetooth: btrtl: Enable WBS for the specific Realtek devices
Date:   Tue, 26 Jan 2021 18:00:38 +0800
Message-ID: <20210126100038.1278-1-max.chou@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.132.186]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS03.realtek.com.tw (172.21.6.96)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Max Chou <max.chou@realtek.com>

By this change, it will enable WBS supported on the specific Realtek BT
devices, such as RTL8822C and RTL8852A.
In the future, it's able to maintain what the Realtek devices support WBS
here.

Tested-by: Hilda Wu <hildawu@realtek.com>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Signed-off-by: Max Chou <max.chou@realtek.com>

---
change in v5
 -remove the extra space between "enum" and "btrtl_chip_id"
---
 drivers/bluetooth/btrtl.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 24f03a1f8d57..c80adf5f313d 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -38,6 +38,19 @@
 	.hci_ver = (hciv), \
 	.hci_bus = (bus)
 
+enum btrtl_chip_id {
+	CHIP_ID_8723A,
+	CHIP_ID_8723B,
+	CHIP_ID_8821A,
+	CHIP_ID_8761A,
+	CHIP_ID_8822B = 8,
+	CHIP_ID_8723D,
+	CHIP_ID_8821C,
+	CHIP_ID_8822C = 13,
+	CHIP_ID_8761B,
+	CHIP_ID_8852A = 18,
+};
+
 struct id_table {
 	__u16 match_flags;
 	__u16 lmp_subver;
@@ -58,6 +71,7 @@ struct btrtl_device_info {
 	u8 *cfg_data;
 	int cfg_len;
 	bool drop_fw;
+	int project_id;
 };
 
 static const struct id_table ic_id_table[] = {
@@ -307,8 +321,10 @@ static int rtlbt_parse_firmware(struct hci_dev *hdev,
 
 	/* Find project_id in table */
 	for (i = 0; i < ARRAY_SIZE(project_id_to_lmp_subver); i++) {
-		if (project_id == project_id_to_lmp_subver[i].id)
+		if (project_id == project_id_to_lmp_subver[i].id) {
+			btrtl_dev->project_id = project_id;
 			break;
+		}
 	}
 
 	if (i >= ARRAY_SIZE(project_id_to_lmp_subver)) {
@@ -719,18 +735,19 @@ int btrtl_setup_realtek(struct hci_dev *hdev)
 	 */
 	set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 
-	if (!btrtl_dev->ic_info)
-		goto done;
-
 	/* Enable central-peripheral role (able to create new connections with
 	 * an existing connection in slave role).
 	 */
-	switch (btrtl_dev->ic_info->lmp_subver) {
-	case RTL_ROM_LMP_8822B:
+	/* Enable WBS supported for the specific Realtek devices. */
+	switch (btrtl_dev->project_id) {
+	case CHIP_ID_8822C:
+	case CHIP_ID_8852A:
 		set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
+		set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks);
 		break;
 	default:
 		rtl_dev_dbg(hdev, "Central-peripheral role not enabled.");
+		rtl_dev_dbg(hdev, "WBS supported not enabled.");
 		break;
 	}
 
-- 
2.17.1

