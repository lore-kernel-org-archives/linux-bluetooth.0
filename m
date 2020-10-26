Return-Path: <SRS0=rjyd=EB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC926C388F9
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Oct 2020 08:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E7E2223B0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Oct 2020 08:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1771722AbgJZI2z (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Oct 2020 04:28:55 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44716 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1771719AbgJZI2z (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Oct 2020 04:28:55 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kWxrz-0005Rg-Ks; Mon, 26 Oct 2020 08:28:48 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     max.chou@realtek.com, alex_lu@realsil.com.cn,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-bluetooth@vger.kernel.org (open list:BLUETOOTH DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] Bluetooth: btrtl: Ask 8821C to drop old firmware
Date:   Mon, 26 Oct 2020 16:28:38 +0800
Message-Id: <20201026082838.26532-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Some platforms keep USB power even when they are powered off and in S5,
this makes Realtek 8821C keep its firmware even after a cold boot, and
make 8821C never load new firmware.

So use vendor specific HCI command to ask 8821C drop its firmware after
system shutdown.

Newer firmware doesn't have this issue so we only use this trick for old
8821C firmware version.

Suggested-by: Max Chou <max.chou@realtek.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v2:
 - Fix incorrect parAnthesis on le16_to_cpu.
 - Ensure firmware gets re-uploaded in initialization.

 drivers/bluetooth/btrtl.c | 46 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 3a9afc905f24..37e24bbb2eb4 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -55,6 +55,7 @@ struct btrtl_device_info {
 	int fw_len;
 	u8 *cfg_data;
 	int cfg_len;
+	bool drop_fw;
 };
 
 static const struct id_table ic_id_table[] = {
@@ -563,6 +564,8 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 	u16 hci_rev, lmp_subver;
 	u8 hci_ver;
 	int ret;
+	u16 opcode;
+	u8 cmd[2];
 
 	btrtl_dev = kzalloc(sizeof(*btrtl_dev), GFP_KERNEL);
 	if (!btrtl_dev) {
@@ -584,6 +587,49 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 	hci_ver = resp->hci_ver;
 	hci_rev = le16_to_cpu(resp->hci_rev);
 	lmp_subver = le16_to_cpu(resp->lmp_subver);
+
+	if (resp->hci_ver == 0x8 && le16_to_cpu(resp->hci_rev) == 0x826c &&
+	    resp->lmp_ver == 0x8 && le16_to_cpu(resp->lmp_subver) == 0xa99e)
+		btrtl_dev->drop_fw = true;
+
+	if (btrtl_dev->drop_fw) {
+		opcode = hci_opcode_pack(0x3f, 0x66);
+		cmd[0] = opcode & 0xff;
+		cmd[1] = opcode >> 8;
+
+		skb = bt_skb_alloc(sizeof(cmd), GFP_KERNEL);
+		if (IS_ERR(skb))
+			goto out_free;
+
+		skb_put_data(skb, cmd, sizeof(cmd));
+		hci_skb_pkt_type(skb) = HCI_COMMAND_PKT;
+
+		hdev->send(hdev, skb);
+
+		/* Ensure the above vendor command is sent to controller and
+		 * process has done.
+		 */
+		msleep(200);
+
+		/* Read the local version again. Expect to have the vanilla
+		 * version as cold boot.
+		 */
+		skb = btrtl_read_local_version(hdev);
+		if (IS_ERR(skb)) {
+			ret = PTR_ERR(skb);
+			goto err_free;
+		}
+
+		resp = (struct hci_rp_read_local_version *)skb->data;
+		rtl_dev_info(hdev, "examining hci_ver=%02x hci_rev=%04x lmp_ver=%02x lmp_subver=%04x",
+			     resp->hci_ver, resp->hci_rev,
+			     resp->lmp_ver, resp->lmp_subver);
+
+		hci_ver = resp->hci_ver;
+		hci_rev = le16_to_cpu(resp->hci_rev);
+		lmp_subver = le16_to_cpu(resp->lmp_subver);
+	}
+out_free:
 	kfree_skb(skb);
 
 	btrtl_dev->ic_info = btrtl_match_ic(lmp_subver, hci_rev, hci_ver,
-- 
2.17.1

