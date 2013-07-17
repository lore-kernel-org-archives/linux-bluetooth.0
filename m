Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <syamsidhardh@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH 1/1 v2] Bluetooth: Fix ACL alive for long in case of non pariable devices
Date: Wed, 17 Jul 2013 22:00:38 +0530
Message-Id: <1374078638-3248-1-git-send-email-syamsidhardh@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Syam Sidhardhan <s.syam@samsung.com>

For certain devices (ex: HID mouse), support for authentication,
pairing and bonding is optional. For such devices, the ACL alive
for too long after the L2CAP disconnection.

To avoid the ACL alive for too long after L2CAP disconnection, reset the ACL
disconnect timeout back to HCI_DISCONN_TIMEOUT when L2CAP is connected.

While merging the commit id:a9ea3ed9b71cc3271dd59e76f65748adcaa76422
this issue might have introduced.

Signed-off-by: Sang-Ki Park <sangki79.park@samsung.com>
Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
---
v1 -> Modified the code as per the latest code.
v2 -> Add descriptive comment as per Marcel request.

 net/bluetooth/l2cap_core.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 9af3a76..e7ff7d5 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1383,6 +1383,15 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
 
 	BT_DBG("conn %p", conn);
 
+	/* For certain devices (ex: HID mouse), support for authentication,
+	 * pairing and bonding is optional. For such devices, inorder to avoid
+	 * the ACL alive for too long after L2CAP disconnection, reset the ACL
+	 * disc_timeout back to HCI_DISCONN_TIMEOUT when L2CAP is connected.
+	 */
+	hci_conn_hold(conn->hcon);
+	conn->hcon->disc_timeout = HCI_DISCONN_TIMEOUT;
+	hci_conn_drop(conn->hcon);
+
 	/* For outgoing pairing which doesn't necessarily have an
 	 * associated socket (e.g. mgmt_pair_device).
 	 */
-- 
1.7.9.5

