Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 4/4] Bluetooth: convert role_switch variable to flag in l2cap chan
Date: Tue, 11 Oct 2011 14:04:34 +0300
Message-Id: <1318331074-32054-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1318331074-32054-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1318331074-32054-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

role_switch variable inside l2cap_chan is a logical one and can
be easily converted to flag

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/l2cap.h |    2 +-
 net/bluetooth/l2cap_core.c    |    4 ++--
 net/bluetooth/l2cap_sock.c    |    9 +++++----
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 440e7b8..aea083c 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -324,7 +324,6 @@ struct l2cap_chan {
 	__le16		sport;
 
 	__u8		sec_level;
-	__u8		role_switch;
 
 	__u8		ident;
 
@@ -463,6 +462,7 @@ enum {
 
 /* Definitions for flags in l2cap_chan */
 enum {
+	FLAG_ROLE_SWITCH,
 	FLAG_FORCE_ACTIVE,
 	FLAG_FORCE_RELIABLE,
 	FLAG_FLUSHABLE,
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index aeeacf8..18a08c5 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3938,12 +3938,12 @@ static int l2cap_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type)
 
 		if (!bacmp(&bt_sk(sk)->src, &hdev->bdaddr)) {
 			lm1 |= HCI_LM_ACCEPT;
-			if (c->role_switch)
+			if (test_bit(FLAG_ROLE_SWITCH, &c->flags))
 				lm1 |= HCI_LM_MASTER;
 			exact++;
 		} else if (!bacmp(&bt_sk(sk)->src, BDADDR_ANY)) {
 			lm2 |= HCI_LM_ACCEPT;
-			if (c->role_switch)
+			if (test_bit(FLAG_ROLE_SWITCH, &c->flags))
 				lm2 |= HCI_LM_MASTER;
 		}
 	}
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index bf196c6..48ad8ba 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -356,7 +356,7 @@ static int l2cap_sock_getsockopt_old(struct socket *sock, int optname, char __us
 			break;
 		}
 
-		if (chan->role_switch)
+		if (test_bit(FLAG_ROLE_SWITCH, &chan->flags))
 			opt |= L2CAP_LM_MASTER;
 
 		if (test_bit(FLAG_FORCE_RELIABLE, &chan->flags))
@@ -549,7 +549,10 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname, char __us
 		if (opt & L2CAP_LM_SECURE)
 			chan->sec_level = BT_SECURITY_HIGH;
 
-		chan->role_switch    = (opt & L2CAP_LM_MASTER);
+		if (opt & L2CAP_LM_MASTER)
+			set_bit(FLAG_ROLE_SWITCH, &chan->flags);
+		else
+			clear_bit(FLAG_ROLE_SWITCH, &chan->flags);
 
 		if (opt & L2CAP_LM_RELIABLE)
 			set_bit(FLAG_FORCE_RELIABLE, &chan->flags);
@@ -941,7 +944,6 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent)
 		chan->max_tx = pchan->max_tx;
 		chan->tx_win = pchan->tx_win;
 		chan->sec_level = pchan->sec_level;
-		chan->role_switch = pchan->role_switch;
 		chan->flags = pchan->flags;
 	} else {
 
@@ -970,7 +972,6 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent)
 		chan->fcs  = L2CAP_FCS_CRC16;
 		chan->tx_win = L2CAP_DEFAULT_TX_WINDOW;
 		chan->sec_level = BT_SECURITY_LOW;
-		chan->role_switch = 0;
 		chan->flags = 0;
 		set_bit(FLAG_FORCE_ACTIVE, &chan->flags);
 	}
-- 
1.7.4.1

