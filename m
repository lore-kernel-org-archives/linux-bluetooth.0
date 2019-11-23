Return-Path: <SRS0=47vR=ZP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C88DC43215
	for <linux-bluetooth@archiver.kernel.org>; Sat, 23 Nov 2019 10:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E1A620714
	for <linux-bluetooth@archiver.kernel.org>; Sat, 23 Nov 2019 10:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfKWKBR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 23 Nov 2019 05:01:17 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:53791 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbfKWKBR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 23 Nov 2019 05:01:17 -0500
Received: from localhost.localdomain (p4FF9F0D1.dip0.t-ipconnect.de [79.249.240.209])
        by mail.holtmann.org (Postfix) with ESMTPSA id 403B7CECC3
        for <linux-bluetooth@vger.kernel.org>; Sat, 23 Nov 2019 11:10:23 +0100 (CET)
From:   Marcel Holtmann <marcel@holtmann.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] Bluetooth: btbcm: Support pcm configuration
Date:   Sat, 23 Nov 2019 11:01:09 +0100
Message-Id: <20191123100111.219190-2-marcel@holtmann.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>

Add BCM vendor specific command to configure PCM parameters. The new
vendor opcode allows us to set the sco routing, the pcm interface rate,
and a few other pcm specific options (frame sync, sync mode, and clock
mode). See broadcom-bluetooth.txt in Documentation for more information
about valid values for those settings.

Here is an example trace where this opcode was used to configure
a BCM4354:

        < HCI Command: Vendor (0x3f|0x001c) plen 5
                01 02 00 01 01
        > HCI Event: Command Complete (0x0e) plen 4
        Vendor (0x3f|0x001c) ncmd 1
                Status: Success (0x00)

We can read back the values as well with ocf 0x001d to confirm the
values that were set:
        $ hcitool cmd 0x3f 0x001d
        < HCI Command: ogf 0x3f, ocf 0x001d, plen 0
        > HCI Event: 0x0e plen 9
        01 1D FC 00 01 02 00 01 01

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btbcm.c | 46 +++++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btbcm.h | 16 ++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 8e05706fe5d9..0795a49edfae 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -107,6 +107,52 @@ int btbcm_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 }
 EXPORT_SYMBOL_GPL(btbcm_set_bdaddr);
 
+int btbcm_read_pcm_int_params(struct hci_dev *hdev,
+			      struct bcm_set_pcm_int_params *params)
+{
+	struct sk_buff *skb;
+	int err = 0;
+
+	skb = __hci_cmd_sync(hdev, 0xfc1d, 0, NULL, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		err = PTR_ERR(skb);
+		bt_dev_err(hdev, "BCM: Read PCM int params failed (%d)", err);
+		return err;
+	}
+
+	if (skb->len != 6 || skb->data[0]) {
+		bt_dev_err(hdev, "BCM: Read PCM int params length mismatch");
+		kfree_skb(skb);
+		return -EIO;
+	}
+
+	if (params)
+		memcpy(params, skb->data + 1, 5);
+
+	kfree_skb(skb);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btbcm_read_pcm_int_params);
+
+int btbcm_write_pcm_int_params(struct hci_dev *hdev,
+			       const struct bcm_set_pcm_int_params *params)
+{
+	struct sk_buff *skb;
+	int err;
+
+	skb = __hci_cmd_sync(hdev, 0xfc1c, 5, params, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		err = PTR_ERR(skb);
+		bt_dev_err(hdev, "BCM: Write PCM int params failed (%d)", err);
+		return err;
+	}
+	kfree_skb(skb);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btbcm_write_pcm_int_params);
+
 int btbcm_patchram(struct hci_dev *hdev, const struct firmware *fw)
 {
 	const struct hci_command_hdr *cmd;
diff --git a/drivers/bluetooth/btbcm.h b/drivers/bluetooth/btbcm.h
index d204be8a84bf..3c7dd0765837 100644
--- a/drivers/bluetooth/btbcm.h
+++ b/drivers/bluetooth/btbcm.h
@@ -54,6 +54,10 @@ struct bcm_set_pcm_format_params {
 int btbcm_check_bdaddr(struct hci_dev *hdev);
 int btbcm_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr);
 int btbcm_patchram(struct hci_dev *hdev, const struct firmware *fw);
+int btbcm_read_pcm_int_params(struct hci_dev *hdev,
+			      struct bcm_set_pcm_int_params *params);
+int btbcm_write_pcm_int_params(struct hci_dev *hdev,
+			       const struct bcm_set_pcm_int_params *params);
 
 int btbcm_setup_patchram(struct hci_dev *hdev);
 int btbcm_setup_apple(struct hci_dev *hdev);
@@ -74,6 +78,18 @@ static inline int btbcm_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 	return -EOPNOTSUPP;
 }
 
+int btbcm_read_pcm_int_params(struct hci_dev *hdev,
+			      struct bcm_set_pcm_int_params *params)
+{
+	return -EOPNOTSUPP;
+}
+
+int btbcm_write_pcm_int_params(struct hci_dev *hdev,
+			       const struct bcm_set_pcm_int_params *params)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int btbcm_patchram(struct hci_dev *hdev, const struct firmware *fw)
 {
 	return -EOPNOTSUPP;
-- 
2.23.0

