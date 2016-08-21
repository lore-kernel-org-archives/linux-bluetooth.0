Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
        <frederic.dalleau@collabora.co.uk>
To: linux-bluetooth@vger.kernel.org
Cc: Frederic Dalleau <frederic.dalleau@collabora.co.uk>
Subject: [PATCH] Bluetooth: Fix memory leak at end of hci requests
Date: Sun, 21 Aug 2016 14:25:31 +0200
Message-Id: <1471782331-3755-1-git-send-email-frederic.dalleau@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Frederic Dalleau <frederic.dalleau@collabora.co.uk>

hci_req_sync_complete takes a reference on the skb in hdev->req_skb.
It is called (via hci_req_run_skb) from either __hci_cmd_sync_ev which will
pass the skb to the caller, or __hci_req_sync which leaks.

Signed-off-by: Frédéric Dalleau <frederic.dalleau@collabora.co.uk>
---
 net/bluetooth/hci_request.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index c045b3c..7a5f9ed 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -212,6 +212,10 @@ int __hci_req_sync(struct hci_dev *hdev, int (*func)(struct hci_request *req,
 	set_current_state(TASK_INTERRUPTIBLE);
 
 	err = hci_req_run_skb(&req, hci_req_sync_complete);
+
+	kfree_skb(hdev->req_skb);
+	hdev->req_skb = NULL;
+
 	if (err < 0) {
 		hdev->req_status = 0;
 
-- 
2.7.4

