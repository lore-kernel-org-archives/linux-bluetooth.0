Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D65C433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Jan 2021 06:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C37E022EBF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Jan 2021 06:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbhASGXp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Jan 2021 01:23:45 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:48296 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbhASGJg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Jan 2021 01:09:36 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 10J67oUbA032436, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs03.realtek.com.tw[172.21.6.96])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 10J67oUbA032436
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 19 Jan 2021 14:07:50 +0800
Received: from localhost.localdomain (172.21.132.186) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 19 Jan 2021 14:07:50 +0800
From:   <max.chou@realtek.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <luiz.dentz@gmail.com>, <linux-bluetooth@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <alex_lu@realsil.com.cn>, <hildawu@realtek.com>,
        <kidman@realtek.com>, <max.chou@realtek.com>,
        <abhishekpandit@chromium.org>, <josephsih@chromium.org>
Subject: [PATCH v2] Bluetooth: btrtl: Enable WBS for the specific Realtek devices
Date:   Tue, 19 Jan 2021 14:07:46 +0800
Message-ID: <20210119060746.7515-1-max.chou@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.132.186]
X-ClientProxiedBy: RTEXMBS01.realtek.com.tw (172.21.6.94) To
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
v2:
 - edit the null check
---
 drivers/bluetooth/btrtl.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 24f03a1f8d57..363e23b15faf 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -38,6 +38,19 @@
 	.hci_ver = (hciv), \
 	.hci_bus = (bus)
 
+enum  btrtl_chip_id {
+	CHIP_ID_8723A,		/* index  0 for RTL8723A*/
+	CHIP_ID_8723B,		/* index  1 for RTL8723B*/
+	CHIP_ID_8821A,		/* index  2 for RTL8821A*/
+	CHIP_ID_8761A,		/* index  3 for RTL8761A*/
+	CHIP_ID_8822B = 8,	/* index  8 for RTL8822B */
+	CHIP_ID_8723D,		/* index  9 for RTL8723D */
+	CHIP_ID_8821C,		/* index 10 for RTL8821C */
+	CHIP_ID_8822C = 13,	/* index 13 for RTL8822C */
+	CHIP_ID_8761B,		/* index 14 for RTL8761B */
+	CHIP_ID_8852A = 18,	/* index 18 for RTL8852A */
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
@@ -719,18 +735,22 @@ int btrtl_setup_realtek(struct hci_dev *hdev)
 	 */
 	set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 
-	if (!btrtl_dev->ic_info)
+	if (!btrtl_dev->project_id)
 		goto done;
 
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

