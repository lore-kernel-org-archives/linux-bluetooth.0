Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BCAC433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Dec 2021 14:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381638AbhLCPCk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Dec 2021 10:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381622AbhLCPCf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Dec 2021 10:02:35 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F78AC061751
        for <linux-bluetooth@vger.kernel.org>; Fri,  3 Dec 2021 06:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=IIcDy0f1QPrDBuQZeQYfUX+PfDG6D7KTDR5HCwg2u4w=;
        t=1638543551; x=1639753151; b=gJt8AZy8fgfZH+T2sVaFRsRqzz3nrDgSZc2nHghH+PE4md/
        nE8FprF4CBklTqap0zQtIB0n8fnQ7S3wGOEwNIQXIDxcj52aBDbpAFLRLDIBoeMY+x5DGjGDFxT+B
        p8TzN+MfAUNfI9hevfkHkGpPpnwR/vi7fQWIWOErfduUqg0chPeqfi/4j5/OpzweknN3QYuym1VSw
        yF2/TTub1itO5m4jrfVrXy8G602mcMYRO7z6g9PkpRGsS0+mdaa+8oNulsda0HftmHpsv6G8dKBBE
        JyuuGnTLGrwcY5T4E6U4FZJPzMK8zdF9REUPiI92WK52wBwhU6a6Xo9aDyDEepnA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <benjamin@sipsolutions.net>)
        id 1mtA1l-006QDV-4K;
        Fri, 03 Dec 2021 15:59:09 +0100
From:   Benjamin Berg <benjamin@sipsolutions.net>
To:     linux-bluetooth@vger.kernel.org
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Benjamin Berg <bberg@redhat.com>
Subject: [PATCH v2 2/4] Bluetooth: Add hci_cmd_sync_cancel to public API
Date:   Fri,  3 Dec 2021 15:59:00 +0100
Message-Id: <20211203145902.3223861-3-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211203145902.3223861-1-benjamin@sipsolutions.net>
References: <20211203145902.3223861-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Benjamin Berg <bberg@redhat.com>

After transfer errors it makes sense to cancel an ongoing synchronous
command that cannot complete anymore. To permit this, export the old
hci_req_sync_cancel function as hci_cmd_sync_cancel in the API.

Signed-off-by: Benjamin Berg <bberg@redhat.com>
---
 include/net/bluetooth/hci_sync.h |  1 +
 net/bluetooth/hci_request.c      | 18 +-----------------
 net/bluetooth/hci_request.h      |  1 -
 net/bluetooth/hci_sync.c         | 17 +++++++++++++++++
 4 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index 0336c1bc5d25..f4034bf8f1ce 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -37,6 +37,7 @@ int __hci_cmd_sync_status_sk(struct hci_dev *hdev, u16 opcode, u32 plen,
 
 void hci_cmd_sync_init(struct hci_dev *hdev);
 void hci_cmd_sync_clear(struct hci_dev *hdev);
+void hci_cmd_sync_cancel(struct hci_dev *hdev, int err);
 
 int hci_cmd_sync_queue(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
 		       void *data, hci_cmd_sync_work_destroy_t destroy);
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 58d640a31bde..a2607db44404 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -111,22 +111,6 @@ void hci_req_sync_complete(struct hci_dev *hdev, u8 result, u16 opcode,
 	}
 }
 
-void hci_req_sync_cancel(struct hci_dev *hdev, int err)
-{
-	bt_dev_dbg(hdev, "err 0x%2.2x", err);
-
-	if (hdev->req_status == HCI_REQ_PEND) {
-		hdev->req_result = err;
-		hdev->req_status = HCI_REQ_CANCELED;
-
-		cancel_delayed_work_sync(&hdev->cmd_timer);
-		cancel_delayed_work_sync(&hdev->ncmd_timer);
-		atomic_set(&hdev->cmd_cnt, 1);
-
-		wake_up_interruptible(&hdev->req_wait_q);
-	}
-}
-
 /* Execute request and wait for completion. */
 int __hci_req_sync(struct hci_dev *hdev, int (*func)(struct hci_request *req,
 						     unsigned long opt),
@@ -2708,7 +2692,7 @@ void hci_request_setup(struct hci_dev *hdev)
 
 void hci_request_cancel_all(struct hci_dev *hdev)
 {
-	hci_req_sync_cancel(hdev, ENODEV);
+	hci_cmd_sync_cancel(hdev, ENODEV);
 
 	cancel_work_sync(&hdev->discov_update);
 	cancel_work_sync(&hdev->scan_update);
diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
index 5f8e8846ec74..8d39e9416861 100644
--- a/net/bluetooth/hci_request.h
+++ b/net/bluetooth/hci_request.h
@@ -64,7 +64,6 @@ int hci_req_sync(struct hci_dev *hdev, int (*req)(struct hci_request *req,
 int __hci_req_sync(struct hci_dev *hdev, int (*func)(struct hci_request *req,
 						     unsigned long opt),
 		   unsigned long opt, u32 timeout, u8 *hci_status);
-void hci_req_sync_cancel(struct hci_dev *hdev, int err);
 
 struct sk_buff *hci_prepare_cmd(struct hci_dev *hdev, u16 opcode, u32 plen,
 				const void *param);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index ad86caf41f91..7ac6c170ec49 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -335,6 +335,23 @@ void hci_cmd_sync_clear(struct hci_dev *hdev)
 	}
 }
 
+void hci_cmd_sync_cancel(struct hci_dev *hdev, int err)
+{
+	bt_dev_dbg(hdev, "err 0x%2.2x", err);
+
+	if (hdev->req_status == HCI_REQ_PEND) {
+		hdev->req_result = err;
+		hdev->req_status = HCI_REQ_CANCELED;
+
+		cancel_delayed_work_sync(&hdev->cmd_timer);
+		cancel_delayed_work_sync(&hdev->ncmd_timer);
+		atomic_set(&hdev->cmd_cnt, 1);
+
+		wake_up_interruptible(&hdev->req_wait_q);
+	}
+}
+EXPORT_SYMBOL(hci_cmd_sync_cancel);
+
 int hci_cmd_sync_queue(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
 		       void *data, hci_cmd_sync_work_destroy_t destroy)
 {
-- 
2.33.1

