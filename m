Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>,
	Sang-Ki Park <sangki79.park@samsung.com>
Subject: [PATCH 1/1 v1] Bluetooth: Fix ACL alive for long in case of non
 pariable devices
Date: Fri, 28 Jun 2013 15:44:32 +0530
Message-id: <1372414472-15854-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For certain devices (ex: HID mouse), support for authentication,
pairing and bonding is optional. For such devices, the ACL alive
for too long after the l2cap disconnection.

To avoid keep ACL alive for too long, set the ACL timeout back to
HCI_DISCONN_TIMEOUT when l2cap is connected.

While merging the commit id:a9ea3ed9b71cc3271dd59e76f65748adcaa76422
this issue might have introduce.

Signed-off-by: Sang-Ki Park <sangki79.park@samsung.com>
Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
---
 net/bluetooth/l2cap_core.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 9af3a76..80df756 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1383,6 +1383,10 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
 
 	BT_DBG("conn %p", conn);
 
+	hci_conn_hold(conn->hcon);
+	conn->hcon->disc_timeout = HCI_DISCONN_TIMEOUT;
+	hci_conn_drop(conn->hcon);
+
 	/* For outgoing pairing which doesn't necessarily have an
 	 * associated socket (e.g. mgmt_pair_device).
 	 */
-- 
1.7.9.5

