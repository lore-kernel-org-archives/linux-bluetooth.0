Return-Path: <SRS0=zRH5=6U=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201C3C4724C
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 May 2020 07:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0341C20714
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 May 2020 07:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbgEFH6B (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 May 2020 03:58:01 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:42513 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728417AbgEFH6A (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 May 2020 03:58:00 -0400
Received: from localhost.localdomain (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id A2383CED05
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2020 10:07:40 +0200 (CEST)
From:   Marcel Holtmann <marcel@holtmann.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 4/7] Bluetooth: Introduce HCI_MGMT_HDEV_OPTIONAL option
Date:   Wed,  6 May 2020 09:57:49 +0200
Message-Id: <32fc749671997c463575394666b2e003917355f5.1588751831.git.marcel@holtmann.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <c1c28c073acf0c37cb7804d33a43c42486c9e796.1588751831.git.marcel@holtmann.org>
References: <cover.1588751831.git.marcel@holtmann.org> <4470adb873fbc0f5874038e1d99a63df3a7b59b8.1588751831.git.marcel@holtmann.org> <15b523289abcb258505f094dc2c26f317bd9caa5.1588751831.git.marcel@holtmann.org> <c1c28c073acf0c37cb7804d33a43c42486c9e796.1588751831.git.marcel@holtmann.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When setting HCI_MGMT_HDEV_OPTIONAL it is possible to target a specific
conntroller or a global interface.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_sock.c         | 12 +++++++-----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 239ab72f16c6..0c7f3ad76665 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1554,6 +1554,7 @@ void hci_sock_dev_event(struct hci_dev *hdev, int event);
 #define HCI_MGMT_NO_HDEV	BIT(1)
 #define HCI_MGMT_UNTRUSTED	BIT(2)
 #define HCI_MGMT_UNCONFIGURED	BIT(3)
+#define HCI_MGMT_HDEV_OPTIONAL	BIT(4)
 
 struct hci_mgmt_handler {
 	int (*func) (struct sock *sk, struct hci_dev *hdev, void *data,
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 9c4a093f8960..caf38a8ea6a8 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -1579,11 +1579,13 @@ static int hci_mgmt_cmd(struct hci_mgmt_chan *chan, struct sock *sk,
 		}
 	}
 
-	no_hdev = (handler->flags & HCI_MGMT_NO_HDEV);
-	if (no_hdev != !hdev) {
-		err = mgmt_cmd_status(sk, index, opcode,
-				      MGMT_STATUS_INVALID_INDEX);
-		goto done;
+	if (!(handler->flags & HCI_MGMT_HDEV_OPTIONAL)) {
+		no_hdev = (handler->flags & HCI_MGMT_NO_HDEV);
+		if (no_hdev != !hdev) {
+			err = mgmt_cmd_status(sk, index, opcode,
+					      MGMT_STATUS_INVALID_INDEX);
+			goto done;
+		}
 	}
 
 	var_len = (handler->flags & HCI_MGMT_VAR_LEN);
-- 
2.26.2

