Return-Path: <SRS0=zRH5=6U=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193AEC47258
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 May 2020 07:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE09320714
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 May 2020 07:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbgEFH6D (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 May 2020 03:58:03 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:44847 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728345AbgEFH6B (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 May 2020 03:58:01 -0400
Received: from localhost.localdomain (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id CE5E4CED06
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2020 10:07:40 +0200 (CEST)
From:   Marcel Holtmann <marcel@holtmann.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 5/7] Bluetooth: Replace BT_DBG with bt_dev_dbg for security manager  support
Date:   Wed,  6 May 2020 09:57:50 +0200
Message-Id: <f55405684917adad79e9031df1bef804ed3245a2.1588751831.git.marcel@holtmann.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <32fc749671997c463575394666b2e003917355f5.1588751831.git.marcel@holtmann.org>
References: <cover.1588751831.git.marcel@holtmann.org> <4470adb873fbc0f5874038e1d99a63df3a7b59b8.1588751831.git.marcel@holtmann.org> <15b523289abcb258505f094dc2c26f317bd9caa5.1588751831.git.marcel@holtmann.org> <c1c28c073acf0c37cb7804d33a43c42486c9e796.1588751831.git.marcel@holtmann.org> <32fc749671997c463575394666b2e003917355f5.1588751831.git.marcel@holtmann.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The security manager operates on a specific controller and thus use
bt_dev_dbg to indetify the controller for each debug message.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/smp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index df22cbf94693..5510017cf9ff 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -508,7 +508,7 @@ bool smp_irk_matches(struct hci_dev *hdev, const u8 irk[16],
 	if (!chan || !chan->data)
 		return false;
 
-	BT_DBG("RPA %pMR IRK %*phN", bdaddr, 16, irk);
+	bt_dev_dbg(hdev, "RPA %pMR IRK %*phN", bdaddr, 16, irk);
 
 	err = smp_ah(irk, &bdaddr->b[3], hash);
 	if (err)
@@ -534,7 +534,7 @@ int smp_generate_rpa(struct hci_dev *hdev, const u8 irk[16], bdaddr_t *rpa)
 	if (err < 0)
 		return err;
 
-	BT_DBG("RPA %pMR", rpa);
+	bt_dev_dbg(hdev, "RPA %pMR", rpa);
 
 	return 0;
 }
@@ -551,7 +551,7 @@ int smp_generate_oob(struct hci_dev *hdev, u8 hash[16], u8 rand[16])
 	smp = chan->data;
 
 	if (hci_dev_test_flag(hdev, HCI_USE_DEBUG_KEYS)) {
-		BT_DBG("Using debug keys");
+		bt_dev_dbg(hdev, "Using debug keys");
 		err = set_ecdh_privkey(smp->tfm_ecdh, debug_sk);
 		if (err)
 			return err;
@@ -1867,7 +1867,7 @@ static u8 sc_send_public_key(struct smp_chan *smp)
 {
 	struct hci_dev *hdev = smp->conn->hcon->hdev;
 
-	BT_DBG("");
+	bt_dev_dbg(hdev, "");
 
 	if (test_bit(SMP_FLAG_LOCAL_OOB, &smp->flags)) {
 		struct l2cap_chan *chan = hdev->smp_data;
-- 
2.26.2

