Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61809C433B4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 May 2021 21:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E3B861074
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 May 2021 21:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbhESVhx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 May 2021 17:37:53 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:47835 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhESVhw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 May 2021 17:37:52 -0400
Received: from fedora.. (p4fefc9d6.dip0.t-ipconnect.de [79.239.201.214])
        by mail.holtmann.org (Postfix) with ESMTPSA id 52F6FCECD6
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 May 2021 23:44:25 +0200 (CEST)
From:   Marcel Holtmann <marcel@holtmann.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC PATCH 2/2] Bluetooth: Move Set Device ID command to use hci_cmd_sync_queue
Date:   Wed, 19 May 2021 23:36:28 +0200
Message-Id: <20210519213628.44925-2-marcel@holtmann.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This is an attempt for converting Set Device ID to use
hci_cmd_sync_queue. This command is rather simple since the
mgmt_cmd_complete is always send and the update is done unconditional,
but it shows how easy the converion from hci_req_run can be.

However create_eir function and alike would have to be moved into a
better location. This be better located in hci_br.c and nicely
abstracted.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_request.c |  2 +-
 net/bluetooth/mgmt.c        | 44 ++++++++++++++++++++++++++++++++-----
 2 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index fa9125b782f8..f91c5b558169 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -631,7 +631,7 @@ static u8 *create_uuid128_list(struct hci_dev *hdev, u8 *data, ptrdiff_t len)
 	return ptr;
 }
 
-static void create_eir(struct hci_dev *hdev, u8 *data)
+void create_eir(struct hci_dev *hdev, u8 *data)
 {
 	u8 *ptr = data;
 	size_t name_len;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index b44e19c69c44..8792c94d39de 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5263,11 +5263,47 @@ static int unblock_device(struct sock *sk, struct hci_dev *hdev, void *data,
 	return err;
 }
 
+// FIXME: This really needs to moved some more common place
+void create_eir(struct hci_dev *hdev, u8 *data);
+
+static void do_update_eir(struct hci_dev *hdev)
+{
+	struct hci_cp_write_eir cp;
+	struct sk_buff *skb;
+
+	if (!hdev_is_powered(hdev))
+		return;
+
+	if (!lmp_ext_inq_capable(hdev))
+		return;
+
+	if (!hci_dev_test_flag(hdev, HCI_SSP_ENABLED))
+		return;
+
+	if (hci_dev_test_flag(hdev, HCI_SERVICE_CACHE))
+		return;
+
+	// FIXME: can these tests be done before calling the work?
+
+	memset(&cp, 0, sizeof(cp));
+
+	create_eir(hdev, cp.data);
+
+	if (memcmp(cp.data, hdev->eir, sizeof(cp.data)) == 0)
+		return;
+
+	memcpy(hdev->eir, cp.data, sizeof(cp.data));
+
+	skb = __hci_cmd_sync(hdev, HCI_OP_WRITE_EIR, sizeof(cp), &cp,
+			     HCI_INIT_TIMEOUT);
+	if (!IS_ERR_OR_NULL(skb))
+		kfree_skb(skb);
+}
+
 static int set_device_id(struct sock *sk, struct hci_dev *hdev, void *data,
 			 u16 len)
 {
 	struct mgmt_cp_set_device_id *cp = data;
-	struct hci_request req;
 	int err;
 	__u16 source;
 
@@ -5289,12 +5325,10 @@ static int set_device_id(struct sock *sk, struct hci_dev *hdev, void *data,
 	err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_SET_DEVICE_ID, 0,
 				NULL, 0);
 
-	hci_req_init(&req, hdev);
-	__hci_req_update_eir(&req);
-	hci_req_run(&req, NULL);
-
 	hci_dev_unlock(hdev);
 
+	hci_cmd_sync_queue(hdev, do_update_eir);
+
 	return err;
 }
 
-- 
2.31.1

