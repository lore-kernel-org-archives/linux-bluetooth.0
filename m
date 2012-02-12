Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon@janc.net.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon@janc.net.pl>
Subject: [PATCH] Bluetooth: Use NULL instead of integer for mgmt_device_connected param
Date: Sun, 12 Feb 2012 13:55:35 +0100
Message-Id: <1329051335-14246-1-git-send-email-szymon@janc.net.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Last param of mgmt_device_connected is of pointer type, so use NULL
instead of 0 for it. This fix following sparse warning:

CHECK   net/bluetooth/hci_event.c
net/bluetooth/hci_event.c:3262:74: warning: Using plain integer as NULL pointer

Signed-off-by: Szymon Janc <szymon@janc.net.pl>
---
 net/bluetooth/hci_event.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index b0784ee..79cd70f 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3259,7 +3259,7 @@ static inline void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff
 
 	if (!test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags))
 		mgmt_device_connected(hdev, &ev->bdaddr, conn->type,
-						conn->dst_type, NULL, 0, 0);
+						conn->dst_type, NULL, 0, NULL);
 
 	conn->sec_level = BT_SECURITY_LOW;
 	conn->handle = __le16_to_cpu(ev->handle);
-- 
1.7.9


