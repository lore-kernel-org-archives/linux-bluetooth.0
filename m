Return-Path: <SRS0=kdk/=ZN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C674C432C0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Nov 2019 08:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4968C20898
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Nov 2019 08:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfKUI1l (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Nov 2019 03:27:41 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:35756 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfKUI1l (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Nov 2019 03:27:41 -0500
Received: from localhost.localdomain (tmo-101-191.customers.d1-online.com [80.187.101.191])
        by mail.holtmann.org (Postfix) with ESMTPSA id 3534DCED0E
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Nov 2019 09:36:47 +0100 (CET)
From:   Marcel Holtmann <marcel@holtmann.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Move error check into the right if-clause
Date:   Thu, 21 Nov 2019 08:51:29 +0100
Message-Id: <20191121075130.92705-1-marcel@holtmann.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The if-clause for hdev->setup should also include the error handling
since that is where the error really comes from. The code currently
works correctly since ret=0 is assigned early on, but it is a lot
harder to read and understand.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 0cc9ce917222..c957f0611f74 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1446,11 +1446,11 @@ static int hci_dev_do_open(struct hci_dev *hdev)
 	    test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks)) {
 		hci_sock_dev_event(hdev, HCI_DEV_SETUP);
 
-		if (hdev->setup)
+		if (hdev->setup) {
 			ret = hdev->setup(hdev);
-
-		if (ret)
-			goto setup_failed;
+			if (ret)
+				goto setup_failed;
+		}
 
 		if (test_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks)) {
 			if (!bacmp(&hdev->public_addr, BDADDR_ANY))
-- 
2.23.0

