Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: new sockopt to enter active state when sending data
Date: Tue, 10 Aug 2010 15:29:53 +0300
Message-Id: <1281443393-31160-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>

Patch adds new socket option to enter active state when sending
data. Modified version of Fabien Chevalier patch (Sep/2008).
Discussions:
http://www.spinics.net/lists/bluez-devel/msg00567.html
http://www.spinics.net/lists/linux-bluetooth/msg03765.html

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
---
 include/net/bluetooth/hci_core.h |    1 +
 include/net/bluetooth/l2cap.h    |    1 +
 net/bluetooth/hci_conn.c         |    7 ++++++-
 net/bluetooth/l2cap.c            |    3 +++
 4 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index e42f6ed..477a492 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -178,6 +178,7 @@ struct hci_conn {
 	__u8             auth_type;
 	__u8             sec_level;
 	__u8             power_save;
+	__u8             force_active;
 	__u16            disc_timeout;
 	unsigned long	 pend;
 
diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 7c695bf..0a8ac4c 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -57,6 +57,7 @@ struct l2cap_options {
 	__u8  mode;
 	__u8  fcs;
 	__u8  max_tx;
+	__u8  force_active;
 	__u16 txwin_size;
 };
 
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 800b6b9..b8ea611 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -214,6 +214,8 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
 	conn->auth_type = HCI_AT_GENERAL_BONDING;
 
 	conn->power_save = 1;
+	/* Enter active state by default */ 
+	conn->force_active = 1;
 	conn->disc_timeout = HCI_DISCONN_TIMEOUT;
 
 	switch (type) {
@@ -505,7 +507,10 @@ void hci_conn_enter_active_mode(struct hci_conn *conn)
 	if (test_bit(HCI_RAW, &hdev->flags))
 		return;
 
-	if (conn->mode != HCI_CM_SNIFF || !conn->power_save)
+	if (conn->mode != HCI_CM_SNIFF)
+		goto timer;
+
+	if (!conn->power_save && !conn->force_active)
 		goto timer;
 
 	if (!test_and_set_bit(HCI_CONN_MODE_CHANGE_PEND, &conn->pend)) {
diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index cf3c407..a631cf1 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -1863,6 +1863,7 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname, char __us
 		opts.mode     = l2cap_pi(sk)->mode;
 		opts.fcs      = l2cap_pi(sk)->fcs;
 		opts.max_tx   = l2cap_pi(sk)->max_tx;
+		opts.force_active = l2cap_pi(sk)->conn->hcon->force_active;
 		opts.txwin_size = (__u16)l2cap_pi(sk)->tx_win;
 
 		len = min_t(unsigned int, sizeof(opts), optlen);
@@ -1889,6 +1890,7 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname, char __us
 		l2cap_pi(sk)->omtu = opts.omtu;
 		l2cap_pi(sk)->fcs  = opts.fcs;
 		l2cap_pi(sk)->max_tx = opts.max_tx;
+		l2cap_pi(sk)->conn->hcon->force_active = opts.force_active;
 		l2cap_pi(sk)->tx_win = (__u8)opts.txwin_size;
 		break;
 
@@ -2006,6 +2008,7 @@ static int l2cap_sock_getsockopt_old(struct socket *sock, int optname, char __us
 		opts.mode     = l2cap_pi(sk)->mode;
 		opts.fcs      = l2cap_pi(sk)->fcs;
 		opts.max_tx   = l2cap_pi(sk)->max_tx;
+		opts.force_active = l2cap_pi(sk)->conn->hcon->force_active;
 		opts.txwin_size = (__u16)l2cap_pi(sk)->tx_win;
 
 		len = min_t(unsigned int, len, sizeof(opts));
-- 
1.7.0.4

