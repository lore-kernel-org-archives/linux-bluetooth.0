Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Disable upper layer connections when user channel is active
Date: Tue,  3 Sep 2013 18:08:37 -0700
Message-Id: <1378256918-50836-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the device has the user channel flag set, it means it is driven by
an user application. In that case do not allow any connections from
L2CAP or SCO sockets.

This is the same situation as when the device has the raw flag set and
it will then return EHOSTUNREACH.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_conn.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index f081712..d2380e0 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -518,6 +518,7 @@ struct hci_dev *hci_get_route(bdaddr_t *dst, bdaddr_t *src)
 	list_for_each_entry(d, &hci_dev_list, list) {
 		if (!test_bit(HCI_UP, &d->flags) ||
 		    test_bit(HCI_RAW, &d->flags) ||
+		    test_bit(HCI_USER_CHANNEL, &d->dev_flags) ||
 		    d->dev_type != HCI_BREDR)
 			continue;
 
-- 
1.8.3.1

