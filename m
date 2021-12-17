Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE01C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Dec 2021 15:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238164AbhLQP2c (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Dec 2021 10:28:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbhLQP2b (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Dec 2021 10:28:31 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8D1C061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Dec 2021 07:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=xFXF0rCP6ZeBg1z4cYYrIN0rFi4iFnaE2/zMkJOH9q4=; t=1639754911; x=1640964511; 
        b=UTlNNBBpaiX99xg4Bi/6DULrvLbS6tEzeCfqLVQ9jOdh4+9X8u/5+sJkTubmc3uLaF4S8aQKuuL
        KLK157fcyqFJHDcNIpatjhiU0ypeIL/jHBsZTGAJFKoqm2rB0aCuixQb2YadIuWxsL7AVDv76Jen7
        s13ri9LEB3x75G1puV7WTaIEjUkPpGFYzoZdkxZPvdzID57e0dlAUZz+pNK/YIBJY729MMnNVCuH1
        l+mNJ4WXfSphG24DGsmu8YY9a/ZXWCT5Re1SVN12PZwZ0B894QmvQsFKAgWuqcqt01H0KWEl7UapS
        dE2HG64rbQGV5IF4TK8G+GpwX07B2uoh+kDg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <benjamin@sipsolutions.net>)
        id 1myF9o-00CnTI-Ic;
        Fri, 17 Dec 2021 16:28:28 +0100
From:   Benjamin Berg <benjamin@sipsolutions.net>
To:     Oliver Neukum <oneukum@suse.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org,
        syzbot <syzbot+485cc00ea7cf41dfdbf1@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, Benjamin Berg <bberg@redhat.com>
Subject: [PATCH v2] Bluetooth: hci_sync: Push sync command cancellation to workqueue
Date:   Fri, 17 Dec 2021 16:28:09 +0100
Message-Id: <20211217152809.671966-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Benjamin Berg <bberg@redhat.com>

syzbot reported that hci_cmd_sync_cancel may sleep from the wrong
context. To avoid this, create a new work item that pushes the relevant
parts into a different context.

Note that we keep the old implementation with the name
__hci_cmd_sync_cancel as the sleeping behaviour is desired in some
cases.

Reported-and-tested-by: syzbot+485cc00ea7cf41dfdbf1@syzkaller.appspotmail.com
Fixes: c97a747efc93 ("Bluetooth: btusb: Cancel sync commands for certain URB errors")
Signed-off-by: Benjamin Berg <bberg@redhat.com>

---

v2:
 - Add Signed-off-by and changed email address
---
 include/net/bluetooth/hci_core.h |  1 +
 include/net/bluetooth/hci_sync.h |  1 +
 net/bluetooth/hci_core.c         |  2 +-
 net/bluetooth/hci_request.c      |  2 +-
 net/bluetooth/hci_sync.c         | 27 ++++++++++++++++++++++++++-
 5 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 4d69dcfebd63..6509109c2413 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -480,6 +480,7 @@ struct hci_dev {
 	struct work_struct	cmd_sync_work;
 	struct list_head	cmd_sync_work_list;
 	struct mutex		cmd_sync_work_lock;
+	struct work_struct	cmd_sync_cancel_work;
 
 	__u16			discov_timeout;
 	struct delayed_work	discov_off;
diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index f4034bf8f1ce..435674cf388e 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -38,6 +38,7 @@ int __hci_cmd_sync_status_sk(struct hci_dev *hdev, u16 opcode, u32 plen,
 void hci_cmd_sync_init(struct hci_dev *hdev);
 void hci_cmd_sync_clear(struct hci_dev *hdev);
 void hci_cmd_sync_cancel(struct hci_dev *hdev, int err);
+void __hci_cmd_sync_cancel(struct hci_dev *hdev, int err);
 
 int hci_cmd_sync_queue(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
 		       void *data, hci_cmd_sync_work_destroy_t destroy);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 38063bf1fdc5..2b7bd3655b07 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3859,7 +3859,7 @@ static void hci_cmd_work(struct work_struct *work)
 
 			res = hci_send_frame(hdev, skb);
 			if (res < 0)
-				hci_cmd_sync_cancel(hdev, -res);
+				__hci_cmd_sync_cancel(hdev, -res);
 
 			if (test_bit(HCI_RESET, &hdev->flags))
 				cancel_delayed_work(&hdev->cmd_timer);
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 329c66456cf1..ef5ced467f75 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -2692,7 +2692,7 @@ void hci_request_setup(struct hci_dev *hdev)
 
 void hci_request_cancel_all(struct hci_dev *hdev)
 {
-	hci_cmd_sync_cancel(hdev, ENODEV);
+	__hci_cmd_sync_cancel(hdev, ENODEV);
 
 	cancel_work_sync(&hdev->discov_update);
 	cancel_work_sync(&hdev->scan_update);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index fd15fb37a52a..2fb8bc496d18 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -313,11 +313,24 @@ static void hci_cmd_sync_work(struct work_struct *work)
 	}
 }
 
+static void hci_cmd_sync_cancel_work(struct work_struct *work)
+{
+	struct hci_dev *hdev = container_of(work, struct hci_dev, cmd_sync_cancel_work);
+
+	cancel_delayed_work_sync(&hdev->cmd_timer);
+	cancel_delayed_work_sync(&hdev->ncmd_timer);
+	atomic_set(&hdev->cmd_cnt, 1);
+
+	wake_up_interruptible(&hdev->req_wait_q);
+}
+
 void hci_cmd_sync_init(struct hci_dev *hdev)
 {
 	INIT_WORK(&hdev->cmd_sync_work, hci_cmd_sync_work);
 	INIT_LIST_HEAD(&hdev->cmd_sync_work_list);
 	mutex_init(&hdev->cmd_sync_work_lock);
+
+	INIT_WORK(&hdev->cmd_sync_cancel_work, hci_cmd_sync_cancel_work);
 }
 
 void hci_cmd_sync_clear(struct hci_dev *hdev)
@@ -335,7 +348,7 @@ void hci_cmd_sync_clear(struct hci_dev *hdev)
 	}
 }
 
-void hci_cmd_sync_cancel(struct hci_dev *hdev, int err)
+void __hci_cmd_sync_cancel(struct hci_dev *hdev, int err)
 {
 	bt_dev_dbg(hdev, "err 0x%2.2x", err);
 
@@ -350,6 +363,18 @@ void hci_cmd_sync_cancel(struct hci_dev *hdev, int err)
 		wake_up_interruptible(&hdev->req_wait_q);
 	}
 }
+
+void hci_cmd_sync_cancel(struct hci_dev *hdev, int err)
+{
+	bt_dev_dbg(hdev, "err 0x%2.2x", err);
+
+	if (hdev->req_status == HCI_REQ_PEND) {
+		hdev->req_result = err;
+		hdev->req_status = HCI_REQ_CANCELED;
+
+		queue_work(hdev->workqueue, &hdev->cmd_sync_cancel_work);
+	}
+}
 EXPORT_SYMBOL(hci_cmd_sync_cancel);
 
 int hci_cmd_sync_queue(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
-- 
2.33.1

