Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] Bluetooth: Remove l2cap_conn->src and l2cap_conn->dst pointers
Date: Sun, 13 Oct 2013 02:23:41 -0700
Message-Id: <1381656221-9821-4-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The l2cap_conn->src and l2cap_conn->dst pointers are no longer in use
and so just remove them.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/l2cap.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 56f540e..1a929af 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -559,9 +559,6 @@ struct l2cap_conn {
 	struct hci_conn		*hcon;
 	struct hci_chan		*hchan;
 
-	bdaddr_t		*dst;
-	bdaddr_t		*src;
-
 	unsigned int		mtu;
 
 	__u32			feat_mask;
-- 
1.8.3.1

