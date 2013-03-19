Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v4 4/6] Bluetooth: Use voice_setting in incoming SCO connection
Date: Tue, 19 Mar 2013 19:04:13 +0100
Message-Id: <1363716255-21332-5-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1363716255-21332-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1363716255-21332-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When an incoming SCO connection is requested, check the selected voice_setting,
and reply appropriately. Mode should have been negotiated previously. For
example, in case of HFP, the codec is negotiated using AT commands on the RFCOMM
channel. This patch only changes replies for socket with defered setup enabled.
---
 net/bluetooth/sco.c |   21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 7593a8e..50be879 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -654,7 +654,8 @@ static int sco_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
 	return err;
 }
 
-static void sco_conn_defer_accept(struct hci_conn *conn, int mask)
+static void sco_conn_defer_accept(struct hci_conn *conn, int mask,
+				  int voice_setting)
 {
 	struct hci_dev *hdev = conn->hdev;
 
@@ -681,9 +682,19 @@ static void sco_conn_defer_accept(struct hci_conn *conn, int mask)
 
 		cp.tx_bandwidth   = __constant_cpu_to_le32(0x00001f40);
 		cp.rx_bandwidth   = __constant_cpu_to_le32(0x00001f40);
-		cp.max_latency    = __constant_cpu_to_le16(0xffff);
-		cp.content_format = cpu_to_le16(hdev->voice_setting);
-		cp.retrans_effort = 0xff;
+
+		if (voice_setting == 0x0003) {
+			if (conn->pkt_type & ESCO_2EV3)
+				cp.max_latency = __constant_cpu_to_le16(0x0008);
+			else
+				cp.max_latency = __constant_cpu_to_le16(0x000D);
+			cp.content_format = __constant_cpu_to_le16(0x0003);
+			cp.retrans_effort = 0x02;
+		} else if (voice_setting == 0x0000) {
+			cp.max_latency    = __constant_cpu_to_le16(0xffff);
+			cp.content_format = cpu_to_le16(hdev->voice_setting);
+			cp.retrans_effort = 0xff;
+		}
 
 		hci_send_cmd(hdev, HCI_OP_ACCEPT_SYNC_CONN_REQ,
 			     sizeof(cp), &cp);
@@ -700,7 +711,7 @@ static int sco_sock_recvmsg(struct kiocb *iocb, struct socket *sock,
 
 	if (sk->sk_state == BT_CONNECT2 &&
 	    test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags)) {
-		sco_conn_defer_accept(pi->conn->hcon, 0);
+		sco_conn_defer_accept(pi->conn->hcon, 0, pi->voice_setting);
 		sk->sk_state = BT_CONFIG;
 
 		release_sock(sk);
-- 
1.7.9.5

