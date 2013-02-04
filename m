Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v3 3/5] Bluetooth: Use mode to create SCO connection
Date: Mon,  4 Feb 2013 14:56:26 +0100
Message-Id: <1359986188-24432-3-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1359986188-24432-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1359986188-24432-1-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When an incoming SCO connection is requested, check the selected mode, and
reply appropriately. Mode should have been negotiated previously. For example,
in case of HFP, the codec is negotiated using AT commands on the RFCOMM
channel. This patch only changes replies for socket with defered setup enabled.

Signed-off-by: Frédéric Dalleau <frederic.dalleau@linux.intel.com>
---
 net/bluetooth/sco.c |   23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 7d57af5..7fbb4c4 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -656,7 +656,7 @@ static int sco_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
 	return err;
 }
 
-static void sco_conn_defer_accept(struct hci_conn *conn, int mask)
+static void sco_conn_defer_accept(struct hci_conn *conn, int mask, int mode)
 {
 	struct hci_dev *hdev = conn->hdev;
 
@@ -683,9 +683,22 @@ static void sco_conn_defer_accept(struct hci_conn *conn, int mask)
 
 		cp.tx_bandwidth   = __constant_cpu_to_le32(0x00001f40);
 		cp.rx_bandwidth   = __constant_cpu_to_le32(0x00001f40);
-		cp.max_latency    = __constant_cpu_to_le16(0xffff);
-		cp.content_format = cpu_to_le16(hdev->voice_setting);
-		cp.retrans_effort = 0xff;
+
+		switch (mode) {
+		case SCO_MODE_CVSD:
+			cp.max_latency    = __constant_cpu_to_le16(0xffff);
+			cp.content_format = cpu_to_le16(hdev->voice_setting);
+			cp.retrans_effort = 0xff;
+			break;
+		case SCO_MODE_TRANSPARENT:
+			if (conn->pkt_type & ESCO_2EV3)
+				cp.max_latency = __constant_cpu_to_le16(0x0008);
+			else
+				cp.max_latency = __constant_cpu_to_le16(0x000D);
+			cp.content_format = __constant_cpu_to_le16(0x0003);
+			cp.retrans_effort = 0x02;
+			break;
+		}
 
 		hci_send_cmd(hdev, HCI_OP_ACCEPT_SYNC_CONN_REQ,
 			     sizeof(cp), &cp);
@@ -702,7 +715,7 @@ static int sco_sock_recvmsg(struct kiocb *iocb, struct socket *sock,
 
 	if (sk->sk_state == BT_CONNECT2 &&
 	    test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags)) {
-		sco_conn_defer_accept(pi->conn->hcon, 0);
+		sco_conn_defer_accept(pi->conn->hcon, 0, pi->mode);
 		sk->sk_state = BT_CONFIG;
 
 		release_sock(sk);
-- 
1.7.9.5

