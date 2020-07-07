Return-Path: <SRS0=I8IU=AS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF10DC433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jul 2020 15:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 957E920663
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jul 2020 15:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgGGPqN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:46:13 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:43377 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbgGGPqM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jul 2020 11:46:12 -0400
Received: from localhost.localdomain (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id 20F71CECED
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2020 17:56:07 +0200 (CEST)
From:   Marcel Holtmann <marcel@holtmann.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v5] Bluetooth: le_simult_central_peripheral experimental feature
Date:   Tue,  7 Jul 2020 17:46:06 +0200
Message-Id: <20200707154606.52947-1-marcel@holtmann.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Alain Michaud <alainm@chromium.org>

This patch adds an le_simult_central_peripheral features which allows a
clients to determine if the controller is able to support peripheral and
central connections separately and at the same time.

Signed-off-by: Alain Michaud <alainm@chromium.org>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 5e9b9728eeac..d29da80e38fe 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3753,12 +3753,19 @@ static const u8 debug_uuid[16] = {
 };
 #endif
 
+/* 671b10b5-42c0-4696-9227-eb28d1b049d6 */
+static const u8 simult_central_periph_uuid[16] = {
+	0xd6, 0x49, 0xb0, 0xd1, 0x28, 0xeb, 0x27, 0x92,
+	0x96, 0x46, 0xc0, 0x42, 0xb5, 0x10, 0x1b, 0x67,
+};
+
 static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
 				  void *data, u16 data_len)
 {
-	char buf[42];
+	char buf[44];
 	struct mgmt_rp_read_exp_features_info *rp = (void *)buf;
 	u16 idx = 0;
+	u32 flags;
 
 	bt_dev_dbg(hdev, "sock %p", sk);
 
@@ -3766,7 +3773,7 @@ static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
 
 #ifdef CONFIG_BT_FEATURE_DEBUG
 	if (!hdev) {
-		u32 flags = bt_dbg_get() ? BIT(0) : 0;
+		flags = bt_dbg_get() ? BIT(0) : 0;
 
 		memcpy(rp->features[idx].uuid, debug_uuid, 16);
 		rp->features[idx].flags = cpu_to_le32(flags);
@@ -3774,6 +3781,20 @@ static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
 	}
 #endif
 
+	if (hdev) {
+		if (test_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks) &&
+		    (hdev->le_states[4] & 0x08) &&	/* Central */
+		    (hdev->le_states[4] & 0x40) &&	/* Peripheral */
+		    (hdev->le_states[3] & 0x10))	/* Simultaneous */
+			flags = BIT(0);
+		else
+			flags = 0;
+
+		memcpy(rp->features[idx].uuid, simult_central_periph_uuid, 16);
+		rp->features[idx].flags = cpu_to_le32(flags);
+		idx++;
+	}
+
 	rp->feature_count = cpu_to_le16(idx);
 
 	/* After reading the experimental features information, enable
-- 
2.26.2

