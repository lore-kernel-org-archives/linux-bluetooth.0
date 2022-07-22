Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720B8C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Jul 2022 11:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233685AbiGVLyH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Jul 2022 07:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiGVLyG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Jul 2022 07:54:06 -0400
Received: from giacobini.uberspace.de (giacobini.uberspace.de [185.26.156.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A796EBB200
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Jul 2022 04:54:03 -0700 (PDT)
Received: (qmail 4462 invoked by uid 990); 22 Jul 2022 11:54:01 -0000
Authentication-Results: giacobini.uberspace.de;
        auth=pass (plain)
From:   Soenke Huster <soenke.huster@eknoes.de>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org,
        Soenke Huster <soenke.huster@eknoes.de>
Subject: [PATCH] Bluetooth: Fix null pointer deref on unexpected status event
Date:   Fri, 22 Jul 2022 13:53:07 +0200
Message-Id: <20220722115307.243056-1-soenke.huster@eknoes.de>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: /
X-Rspamd-Report: BAYES_HAM(-2.999999) R_MISSING_CHARSET(0.5) MIME_GOOD(-0.1) MID_CONTAINS_FROM(1) SUSPICIOUS_RECIPS(1.5)
X-Rspamd-Score: -0.099999
Received: from unknown (HELO unkown) (::1)
        by giacobini.uberspace.de (Haraka/2.8.28) with ESMTPSA; Fri, 22 Jul 2022 13:54:00 +0200
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

__hci_cmd_sync returns NULL if the controller responds with a status
event. This is unexpected for the commands sent here, but on
occurrence leads to null pointer dereferences and thus must be
handled.

Signed-off-by: Soenke Huster <soenke.huster@eknoes.de>
---
 net/bluetooth/aosp.c | 15 ++++++++++++---
 net/bluetooth/msft.c | 15 ++++++++++++---
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/aosp.c b/net/bluetooth/aosp.c
index 432ae3aac9e3..1d67836e95e1 100644
--- a/net/bluetooth/aosp.c
+++ b/net/bluetooth/aosp.c
@@ -54,7 +54,10 @@ void aosp_do_open(struct hci_dev *hdev)
 	/* LE Get Vendor Capabilities Command */
 	skb = __hci_cmd_sync(hdev, hci_opcode_pack(0x3f, 0x153), 0, NULL,
 			     HCI_CMD_TIMEOUT);
-	if (IS_ERR(skb)) {
+	if (IS_ERR_OR_NULL(skb)) {
+		if (!skb)
+			skb = ERR_PTR(-EIO);
+
 		bt_dev_err(hdev, "AOSP get vendor capabilities (%ld)",
 			   PTR_ERR(skb));
 		return;
@@ -152,7 +155,10 @@ static int enable_quality_report(struct hci_dev *hdev)
 
 	skb = __hci_cmd_sync(hdev, BQR_OPCODE, sizeof(cp), &cp,
 			     HCI_CMD_TIMEOUT);
-	if (IS_ERR(skb)) {
+	if (IS_ERR_OR_NULL(skb)) {
+		if (!skb)
+			skb = ERR_PTR(-EIO);
+
 		bt_dev_err(hdev, "Enabling Android BQR failed (%ld)",
 			   PTR_ERR(skb));
 		return PTR_ERR(skb);
@@ -171,7 +177,10 @@ static int disable_quality_report(struct hci_dev *hdev)
 
 	skb = __hci_cmd_sync(hdev, BQR_OPCODE, sizeof(cp), &cp,
 			     HCI_CMD_TIMEOUT);
-	if (IS_ERR(skb)) {
+	if (IS_ERR_OR_NULL(skb)) {
+		if (!skb)
+			skb = ERR_PTR(-EIO);
+
 		bt_dev_err(hdev, "Disabling Android BQR failed (%ld)",
 			   PTR_ERR(skb));
 		return PTR_ERR(skb);
diff --git a/net/bluetooth/msft.c b/net/bluetooth/msft.c
index 14975769f678..bee6a4c656be 100644
--- a/net/bluetooth/msft.c
+++ b/net/bluetooth/msft.c
@@ -120,7 +120,10 @@ static bool read_supported_features(struct hci_dev *hdev,
 
 	skb = __hci_cmd_sync(hdev, hdev->msft_opcode, sizeof(cp), &cp,
 			     HCI_CMD_TIMEOUT);
-	if (IS_ERR(skb)) {
+	if (IS_ERR_OR_NULL(skb)) {
+		if (!skb)
+			skb = ERR_PTR(-EIO);
+
 		bt_dev_err(hdev, "Failed to read MSFT supported features (%ld)",
 			   PTR_ERR(skb));
 		return false;
@@ -319,8 +322,11 @@ static int msft_remove_monitor_sync(struct hci_dev *hdev,
 
 	skb = __hci_cmd_sync(hdev, hdev->msft_opcode, sizeof(cp), &cp,
 			     HCI_CMD_TIMEOUT);
-	if (IS_ERR(skb))
+	if (IS_ERR_OR_NULL(skb)) {
+		if (!skb)
+			return -EIO;
 		return PTR_ERR(skb);
+	}
 
 	return msft_le_cancel_monitor_advertisement_cb(hdev, hdev->msft_opcode,
 						       monitor, skb);
@@ -432,8 +438,11 @@ static int msft_add_monitor_sync(struct hci_dev *hdev,
 			     HCI_CMD_TIMEOUT);
 	kfree(cp);
 
-	if (IS_ERR(skb))
+	if (IS_ERR_OR_NULL(skb)) {
+		if (!skb)
+			return -EIO;
 		return PTR_ERR(skb);
+	}
 
 	return msft_le_monitor_advertisement_cb(hdev, hdev->msft_opcode,
 						monitor, skb);
-- 
2.37.1

