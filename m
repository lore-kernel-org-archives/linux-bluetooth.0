Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v9 5/9] Bluetooth: Use voice setting in defered SCO connection request
Date: Fri, 12 Jul 2013 18:05:39 +0200
Message-Id: <1373645143-7494-6-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1373645143-7494-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1373645143-7494-1-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When an incoming eSCO connection is requested, check the selected voice setting
and reply appropriately. Voice setting should have been negotiated previously.
For example, in case of HFP, the codec is negotiated using AT commands on the
RFCOMM channel. This patch only changes replies for socket with defered setup
enabled.

Signed-off-by: Frédéric Dalleau <frederic.dalleau@linux.intel.com>
---
 net/bluetooth/sco.c |   22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index ce8690f..934002c 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -653,7 +653,7 @@ static int sco_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
 	return err;
 }
 
-static void sco_conn_defer_accept(struct hci_conn *conn)
+static void sco_conn_defer_accept(struct hci_conn *conn, int setting)
 {
 	struct hci_dev *hdev = conn->hdev;
 
@@ -676,9 +676,21 @@ static void sco_conn_defer_accept(struct hci_conn *conn)
 
 		cp.tx_bandwidth   = __constant_cpu_to_le32(0x00001f40);
 		cp.rx_bandwidth   = __constant_cpu_to_le32(0x00001f40);
-		cp.max_latency    = __constant_cpu_to_le16(0xffff);
-		cp.content_format = cpu_to_le16(hdev->voice_setting);
-		cp.retrans_effort = 0xff;
+		cp.content_format = cpu_to_le16(setting);
+
+		switch (setting & SCO_AIRMODE_MASK) {
+		case SCO_AIRMODE_TRANSP:
+			if (conn->pkt_type & ESCO_2EV3)
+				cp.max_latency = __constant_cpu_to_le16(0x0008);
+			else
+				cp.max_latency = __constant_cpu_to_le16(0x000D);
+			cp.retrans_effort = 0x02;
+			break;
+		case SCO_AIRMODE_CVSD:
+			cp.max_latency    = __constant_cpu_to_le16(0xffff);
+			cp.retrans_effort = 0xff;
+			break;
+		}
 
 		hci_send_cmd(hdev, HCI_OP_ACCEPT_SYNC_CONN_REQ,
 			     sizeof(cp), &cp);
@@ -695,7 +707,7 @@ static int sco_sock_recvmsg(struct kiocb *iocb, struct socket *sock,
 
 	if (sk->sk_state == BT_CONNECT2 &&
 	    test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags)) {
-		sco_conn_defer_accept(pi->conn->hcon);
+		sco_conn_defer_accept(pi->conn->hcon, pi->setting);
 		sk->sk_state = BT_CONFIG;
 		msg->msg_namelen = 0;
 
-- 
1.7.9.5

