Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC1BC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Sep 2021 10:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE1EB610A2
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Sep 2021 10:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240104AbhI1KL7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Sep 2021 06:11:59 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:60843 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240094AbhI1KL6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Sep 2021 06:11:58 -0400
Received: from fedora.. (p5b3d2185.dip0.t-ipconnect.de [91.61.33.133])
        by mail.holtmann.org (Postfix) with ESMTPSA id 961C7CECD9
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Sep 2021 12:10:18 +0200 (CEST)
From:   Marcel Holtmann <marcel@holtmann.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Fix handling of experimental feature for codec offload
Date:   Tue, 28 Sep 2021 12:10:15 +0200
Message-Id: <20210928101015.27026-2-marcel@holtmann.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The existence of the experimental feature identifiy is the indication
that it is supported or not. No extra flag needed and the initial flag
should define if a feature is enabled or not. This is actually defined
in the management API definition.

Fixes: ad93315183285 ("Bluetooth: Add offload feature under experimental flag")
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 84336be4d00d..3e5283607b97 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3874,21 +3874,12 @@ static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
 		idx++;
 	}
 
-	if (hdev) {
-		if (hdev->get_data_path_id) {
-			/* BIT(0): indicating if offload codecs are
-			 * supported by controller.
-			 */
+	if (hdev && hdev->get_data_path_id) {
+		if (hci_dev_test_flag(hdev, HCI_OFFLOAD_CODECS_ENABLED))
 			flags = BIT(0);
-
-			/* BIT(1): indicating if codec offload feature
-			 * is enabled.
-			 */
-			if (hci_dev_test_flag(hdev, HCI_OFFLOAD_CODECS_ENABLED))
-				flags |= BIT(1);
-		} else {
+		else
 			flags = 0;
-		}
+
 		memcpy(rp->features[idx].uuid, offload_codecs_uuid, 16);
 		rp->features[idx].flags = cpu_to_le32(flags);
 		idx++;
-- 
2.31.1

