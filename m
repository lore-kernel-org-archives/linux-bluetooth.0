Return-Path: <SRS0=kcDe=D5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4BCC55179
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Oct 2020 14:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62C0124171
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Oct 2020 14:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900851AbgJVO1C (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Oct 2020 10:27:02 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33209 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2507932AbgJVO1C (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Oct 2020 10:27:02 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kVbYK-0002oC-UO; Thu, 22 Oct 2020 14:26:53 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     max.chou@realtek.com, alex_lu@realsil.com.cn,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-bluetooth@vger.kernel.org (open list:BLUETOOTH DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] Bluetooth: btrtl: Ask 8821C to drop old firmware after shutdown
Date:   Thu, 22 Oct 2020 22:26:48 +0800
Message-Id: <20201022142648.446-1-kai.heng.feng@canonical.com>
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

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/bluetooth/btrtl.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 3a9afc905f24..2f3843fb2b95 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -55,6 +55,7 @@ struct btrtl_device_info {
 	int fw_len;
 	u8 *cfg_data;
 	int cfg_len;
+	bool drop_fw;
 };
 
 static const struct id_table ic_id_table[] = {
@@ -584,6 +585,11 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 	hci_ver = resp->hci_ver;
 	hci_rev = le16_to_cpu(resp->hci_rev);
 	lmp_subver = le16_to_cpu(resp->lmp_subver);
+
+	if (resp->hci_ver == 0x8 && le16_to_cpu(resp->hci_rev == 0x826c) &&
+	    resp->lmp_ver == 0x8 && le16_to_cpu(resp->lmp_subver == 0xa99e))
+		btrtl_dev->drop_fw = true;
+
 	kfree_skb(skb);
 
 	btrtl_dev->ic_info = btrtl_match_ic(lmp_subver, hci_rev, hci_ver,
@@ -671,6 +677,9 @@ EXPORT_SYMBOL_GPL(btrtl_download_firmware);
 int btrtl_setup_realtek(struct hci_dev *hdev)
 {
 	struct btrtl_device_info *btrtl_dev;
+	struct sk_buff *skb;
+	u16 opcode;
+	u8 cmd[2];
 	int ret;
 
 	btrtl_dev = btrtl_initialize(hdev, NULL);
@@ -679,6 +688,22 @@ int btrtl_setup_realtek(struct hci_dev *hdev)
 
 	ret = btrtl_download_firmware(hdev, btrtl_dev);
 
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
+	}
+
+out_free:
 	btrtl_free(btrtl_dev);
 
 	/* Enable controller to do both LE scan and BR/EDR inquiry
-- 
2.17.1

