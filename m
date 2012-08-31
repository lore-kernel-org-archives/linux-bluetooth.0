Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] Bluetooth: Use GFP_KERNEL in read_index_list
Date: Fri, 31 Aug 2012 09:05:46 +0200
Message-ID: <1346396746-3479-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

read_index_list is executed by user thread running in kernel-mode
thus is allowed to sleep.

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 net/bluetooth/mgmt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index a3329cb..7b1a5c8 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -340,7 +340,7 @@ static int read_index_list(struct sock *sk, struct hci_dev *hdev, void *data,
 	}
 
 	rp_len = sizeof(*rp) + (2 * count);
-	rp = kmalloc(rp_len, GFP_ATOMIC);
+	rp = kmalloc(rp_len, GFP_KERNEL);
 	if (!rp) {
 		read_unlock(&hci_dev_list_lock);
 		return -ENOMEM;
-- 
1.7.9.5

