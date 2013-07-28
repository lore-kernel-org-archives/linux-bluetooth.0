Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <syamsidhardh@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH 1/1] Bluetooth: Fix ACL alive for long in case of non pariable devices
Date: Mon, 29 Jul 2013 00:26:41 +0900
Message-Id: <1375025201-18139-1-git-send-email-syamsidhardh@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Syam Sidhardhan <s.syam@samsung.com>

For certain devices (ex: HID mouse), support for authentication,
pairing and bonding is optional. For such devices, the ACL alive
for too long after the L2CAP disconnection.

To avoid the ACL alive for too long after L2CAP disconnection, reset the ACL
disconnect timeout back to HCI_DISCONN_TIMEOUT during L2CAP connect.

While merging the commit id:a9ea3ed9b71cc3271dd59e76f65748adcaa76422
this issue might have introduced.

Signed-off-by: Sang-Ki Park <sangki79.park@samsung.com>
Signed-off-by: Chan-yeol Park <chanyeol.park@samsung.com>
Signed-off-by: Jaganath Kanakkassery <jaganath.k@samsung.com>
Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
---
v1 -> Modified the code as per the latest code.
v2 -> Add descriptive comment as per Marcel request.
v3 -> Moved from l2cap_conn_ready() to l2cap_connect() inorder to fix remote
      non ssp pairing timeout. Generated the patch based on bluetooth.git tree.

 net/bluetooth/l2cap_core.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 68843a2..8179fc3 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3753,6 +3753,13 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
 
 	hci_conn_hold(conn->hcon);
 
+	/* For certain devices (ex: HID mouse), support for authentication,
+	 * pairing and bonding is optional. For such devices, inorder to avoid
+	 * the ACL alive for too long after L2CAP disconnection, reset the ACL
+	 * disc_timeout back to HCI_DISCONN_TIMEOUT during L2CAP connect.
+	 */
+	conn->hcon->disc_timeout = HCI_DISCONN_TIMEOUT;
+
 	bacpy(&bt_sk(sk)->src, conn->src);
 	bacpy(&bt_sk(sk)->dst, conn->dst);
 	chan->psm  = psm;
-- 
1.7.9.5

