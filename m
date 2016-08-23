Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
        <frederic.dalleau@collabora.co.uk>
To: linux-bluetooth@vger.kernel.org
Cc: Frederic Dalleau <frederic.dalleau@collabora.co.uk>
Subject: [PATCH v2] Bluetooth: Fix memory leak at end of hci requests
Date: Tue, 23 Aug 2016 07:59:19 +0200
Message-Id: <1471931959-1027-1-git-send-email-frederic.dalleau@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Frederic Dalleau <frederic.dalleau@collabora.co.uk>

In hci_req_sync_complete the event skb is referenced in hdev->req_skb.
It is used (via hci_req_run_skb) from either __hci_cmd_sync_ev which will
pass the skb to the caller, or __hci_req_sync which leaks.

unreferenced object 0xffff880005339a00 (size 256):
  comm "kworker/u3:1", pid 1011, jiffies 4294671976 (age 107.389s)
  backtrace:
    [<ffffffff818d89d9>] kmemleak_alloc+0x49/0xa0
    [<ffffffff8116bba8>] kmem_cache_alloc+0x128/0x180
    [<ffffffff8167c1df>] skb_clone+0x4f/0xa0
    [<ffffffff817aa351>] hci_event_packet+0xc1/0x3290
    [<ffffffff8179a57b>] hci_rx_work+0x18b/0x360
    [<ffffffff810692ea>] process_one_work+0x14a/0x440
    [<ffffffff81069623>] worker_thread+0x43/0x4d0
    [<ffffffff8106ead4>] kthread+0xc4/0xe0
    [<ffffffff818dd38f>] ret_from_fork+0x1f/0x40
    [<ffffffffffffffff>] 0xffffffffffffffff

Signed-off-by: Frédéric Dalleau <frederic.dalleau@collabora.co.uk>
---
 net/bluetooth/hci_request.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index c045b3c..b0e23df 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -262,6 +262,8 @@ int __hci_req_sync(struct hci_dev *hdev, int (*func)(struct hci_request *req,
 		break;
 	}
 
+	kfree_skb(hdev->req_skb);
+	hdev->req_skb = NULL;
 	hdev->req_status = hdev->req_result = 0;
 
 	BT_DBG("%s end: err %d", hdev->name, err);
-- 
2.7.4

