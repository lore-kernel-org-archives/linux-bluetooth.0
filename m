Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [RFC 3/4] Bluetooth: Use codec to create SCO connection
Date: Wed, 28 Nov 2012 19:28:35 +0100
Message-Id: <1354127316-17431-4-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1354127316-17431-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1354127316-17431-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When an incoming SCO connection is requested, check the selected codec, and
reply appropriately. Codec should have been negotiated previously.
Note that this patch only changes the reply for defered setup.
---
 include/net/bluetooth/hci_core.h |    2 +-
 net/bluetooth/hci_event.c        |   23 +++++++++++++++++++----
 net/bluetooth/sco.c              |    2 +-
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 2f2b743..cb41552 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -577,7 +577,7 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst);
 int hci_conn_del(struct hci_conn *conn);
 void hci_conn_hash_flush(struct hci_dev *hdev);
 void hci_conn_check_pending(struct hci_dev *hdev);
-void hci_conn_accept(struct hci_conn *conn, int mask);
+void hci_conn_accept(struct hci_conn *conn, int mask, int codec);
 
 struct hci_chan *hci_chan_create(struct hci_conn *conn);
 void hci_chan_del(struct hci_chan *chan);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 705078a..57ed7d3 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2047,7 +2047,7 @@ unlock:
 	hci_conn_check_pending(hdev);
 }
 
-void hci_conn_accept(struct hci_conn *conn, int mask)
+void hci_conn_accept(struct hci_conn *conn, int mask, int codec)
 {
 	struct hci_dev *hdev = conn->hdev;
 
@@ -2070,13 +2070,28 @@ void hci_conn_accept(struct hci_conn *conn, int mask)
 		struct hci_cp_accept_sync_conn_req cp;
 
 		bacpy(&cp.bdaddr, &conn->dst);
-		cp.pkt_type = cpu_to_le16(conn->pkt_type);
 
+		cp.pkt_type       = cpu_to_le16(conn->pkt_type);
 		cp.tx_bandwidth   = __constant_cpu_to_le32(0x00001f40);
 		cp.rx_bandwidth   = __constant_cpu_to_le32(0x00001f40);
-		cp.max_latency    = __constant_cpu_to_le16(0xffff);
 		cp.content_format = cpu_to_le16(hdev->voice_setting);
-		cp.retrans_effort = 0xff;
+
+		switch (codec) {
+		case 0:
+			cp.max_latency    = __constant_cpu_to_le16(0xffff);
+			cp.retrans_effort = 0xff;
+			break;
+		case 1 /* mSBC */:
+			/* Transparent */
+			cp.content_format |= cpu_to_le16(3);
+			 /* 2EV3 unsupported */
+			if (conn->pkt_type & ESCO_2EV3)
+				cp.max_latency = __constant_cpu_to_le16(0x0008);
+			else
+				cp.max_latency = __constant_cpu_to_le16(0x000D);
+			cp.retrans_effort = 0x02;
+			break;
+		}
 
 		hci_send_cmd(hdev, HCI_OP_ACCEPT_SYNC_CONN_REQ,
 			     sizeof(cp), &cp);
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index b363712..be3e0b2 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -675,7 +675,7 @@ static int sco_sock_recvmsg(struct kiocb *iocb, struct socket *sock,
 
 	if (sk->sk_state == BT_CONNECT2 &&
 	    test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags)) {
-		hci_conn_accept(pi->conn->hcon, 0);
+		hci_conn_accept(pi->conn->hcon, 0, pi->codec);
 		sk->sk_state = BT_CONFIG;
 
 		release_sock(sk);
-- 
1.7.9.5

