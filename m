Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v6 6/6] Bluetooth: Enable new connection establishment procedure.
Date: Wed, 29 Jul 2015 17:17:42 +0200
Message-Id: <1438183062-3265-6-git-send-email-jpawlowski@google.com>
In-Reply-To: <1438183062-3265-1-git-send-email-jpawlowski@google.com>
References: <1438183062-3265-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Currently, when trying to connect to already paired device that just
rotated its RPA MAC address, old address would be used and connection
would fail. In order to fix that, kernel must scan and receive
advertisement with fresh RPA before connecting.

This patch enables new connection establishment procedure. Instead of just
sending HCI_OP_LE_CREATE_CONN to controller, "connect" will add device to
kernel whitelist and start scan. If advertisement is received, it'll be
compared against whitelist and then trigger connection if it matches.
That fixes mentioned reconnect issue for  already paired devices. It also
make whole connection procedure more robust. We can try to connect to
multiple devices at same time now, even though controller allow only one.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 net/bluetooth/l2cap_core.c | 6 ++++--
 net/bluetooth/mgmt.c       | 7 ++++---
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 45fffa4..7c65ee2 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7113,8 +7113,10 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 		else
 			role = HCI_ROLE_MASTER;
 
-		hcon = hci_connect_le(hdev, dst, dst_type, chan->sec_level,
-				      HCI_LE_CONN_TIMEOUT, role);
+		hcon = hci_connect_le_scan(hdev, dst, dst_type,
+					   chan->sec_level,
+					   HCI_LE_CONN_TIMEOUT,
+					   role);
 	} else {
 		u8 auth_type = l2cap_get_auth_type(chan);
 		hcon = hci_connect_acl(hdev, dst, chan->sec_level, auth_type);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index fac6582..fcd57c8 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3564,9 +3564,10 @@ static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 		 */
 		hci_conn_params_add(hdev, &cp->addr.bdaddr, addr_type);
 
-		conn = hci_connect_le(hdev, &cp->addr.bdaddr, addr_type,
-				      sec_level, HCI_LE_CONN_TIMEOUT,
-				      HCI_ROLE_MASTER);
+		conn = hci_connect_le_scan(hdev, &cp->addr.bdaddr,
+					   addr_type, sec_level,
+					   HCI_LE_CONN_TIMEOUT,
+					   HCI_ROLE_MASTER);
 	}
 
 	if (IS_ERR(conn)) {
-- 
2.1.4

