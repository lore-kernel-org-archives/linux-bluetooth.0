Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF86FC433DB
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Feb 2021 15:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98CA664F51
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Feb 2021 15:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237569AbhBDPsz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Feb 2021 10:48:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:34376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237516AbhBDPsF (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Feb 2021 10:48:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3ABC464F45;
        Thu,  4 Feb 2021 15:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612453642;
        bh=bNTrM8aWtufVI7iPcQTsXQghRKvyHRISmKItSiQtqR4=;
        h=From:To:Cc:Subject:Date:From;
        b=tdipZSETEVhKcd4sLIG9VlK9G/cahXZ/CPQZdx9ldR/1hPRp5B/XihZonqakev8zn
         MllWQsvppx/2dhisCT3w13qVx68QyU+1Q5iLAIGaOWzR8HG79QNzJJmnwlfOaYxId3
         n4MC4lnygGIA8+32taJQQOpNx6DPYdsNFmP4mzneFXqV+N4bieJ7YgqBBhfCYjUScR
         E18w+T79v/vLEg9dRhJFtBU/rgQCk1ofl4Dpj7L4iIbZYkLkj1iNCrrlxReFISFkpd
         nHXTdp3SEf/NkLMJf3KZlENm/v/WYPK0UHl9AuOV7T4YIDxXM7prw3CKy1JZiDPqbN
         Q5YOrgXrpcnYg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Mark Chen <Mark-YW.Chen@mediatek.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kiran K <kiran.k@intel.com>,
        Alain Michaud <alainm@chromium.org>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Sathish Narasimman <nsathish41@gmail.com>,
        Rocky Liao <rjliao@codeaurora.org>,
        Ismael Ferreras Morezuelas <swyterzone@gmail.com>,
        Hilda Wu <hildawu@realtek.com>,
        Trent Piepho <tpiepho@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: fix excessive stack usage
Date:   Thu,  4 Feb 2021 16:47:07 +0100
Message-Id: <20210204154716.1823454-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Enlarging the size of 'struct btmtk_hci_wmt_cmd' makes it no longer
fit on the kernel stack, as seen from this compiler warning:

drivers/bluetooth/btusb.c:3365:12: error: stack frame size of 1036 bytes in function 'btusb_mtk_hci_wmt_sync' [-Werror,-Wframe-larger-than=]

Change the function to dynamically allocate the buffer instead.
As there are other sleeping functions called from the same location,
using GFP_KERNEL should be fine here, and the runtime overhead should
not matter as this is rarely called.

Unfortunately, I could not figure out why the message size is
increased in the previous patch. Using dynamic allocation means
any size is possible now, but there is still a range check that
limits the total size (including the five-byte header) to 255
bytes, so whatever was intended there is now undone.

Fixes: 48c13301e6ba ("Bluetooth: btusb: Fine-tune mt7663 mechanism.")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/bluetooth/btusb.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index eeafb8432c0f..838e6682301e 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3161,7 +3161,7 @@ struct btmtk_wmt_hdr {
 
 struct btmtk_hci_wmt_cmd {
 	struct btmtk_wmt_hdr hdr;
-	u8 data[1000];
+	u8 data[];
 } __packed;
 
 struct btmtk_hci_wmt_evt {
@@ -3369,7 +3369,7 @@ static int btusb_mtk_hci_wmt_sync(struct hci_dev *hdev,
 	struct btmtk_hci_wmt_evt_funcc *wmt_evt_funcc;
 	u32 hlen, status = BTMTK_WMT_INVALID;
 	struct btmtk_hci_wmt_evt *wmt_evt;
-	struct btmtk_hci_wmt_cmd wc;
+	struct btmtk_hci_wmt_cmd *wc;
 	struct btmtk_wmt_hdr *hdr;
 	int err;
 
@@ -3383,20 +3383,24 @@ static int btusb_mtk_hci_wmt_sync(struct hci_dev *hdev,
 	if (hlen > 255)
 		return -EINVAL;
 
-	hdr = (struct btmtk_wmt_hdr *)&wc;
+	wc = kzalloc(hlen, GFP_KERNEL);
+	if (!wc)
+		return -ENOMEM;
+
+	hdr = &wc->hdr;
 	hdr->dir = 1;
 	hdr->op = wmt_params->op;
 	hdr->dlen = cpu_to_le16(wmt_params->dlen + 1);
 	hdr->flag = wmt_params->flag;
-	memcpy(wc.data, wmt_params->data, wmt_params->dlen);
+	memcpy(wc->data, wmt_params->data, wmt_params->dlen);
 
 	set_bit(BTUSB_TX_WAIT_VND_EVT, &data->flags);
 
-	err = __hci_cmd_send(hdev, 0xfc6f, hlen, &wc);
+	err = __hci_cmd_send(hdev, 0xfc6f, hlen, wc);
 
 	if (err < 0) {
 		clear_bit(BTUSB_TX_WAIT_VND_EVT, &data->flags);
-		return err;
+		goto err_free_wc;
 	}
 
 	/* The vendor specific WMT commands are all answered by a vendor
@@ -3413,13 +3417,14 @@ static int btusb_mtk_hci_wmt_sync(struct hci_dev *hdev,
 	if (err == -EINTR) {
 		bt_dev_err(hdev, "Execution of wmt command interrupted");
 		clear_bit(BTUSB_TX_WAIT_VND_EVT, &data->flags);
-		return err;
+		goto err_free_wc;
 	}
 
 	if (err) {
 		bt_dev_err(hdev, "Execution of wmt command timed out");
 		clear_bit(BTUSB_TX_WAIT_VND_EVT, &data->flags);
-		return -ETIMEDOUT;
+		err = -ETIMEDOUT;
+		goto err_free_wc;
 	}
 
 	/* Parse and handle the return WMT event */
@@ -3463,7 +3468,8 @@ static int btusb_mtk_hci_wmt_sync(struct hci_dev *hdev,
 err_free_skb:
 	kfree_skb(data->evt_skb);
 	data->evt_skb = NULL;
-
+err_free_wc:
+	kfree(wc);
 	return err;
 }
 
-- 
2.29.2

