Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2] Bluetooth: new sockopt to enter active state when sending data
Date: Tue, 10 Aug 2010 16:48:32 +0300
Message-Id: <1281448112-2944-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
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
 include/net/bluetooth/l2cap.h    |    2 ++
 net/bluetooth/hci_conn.c         |    7 ++++++-
 net/bluetooth/l2cap.c            |   15 +++++++++++++++
 4 files changed, 24 insertions(+), 1 deletions(-)

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
index 7c695bf..540cca7 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -74,6 +74,8 @@ struct l2cap_conninfo {
 #define L2CAP_LM_RELIABLE	0x0010
 #define L2CAP_LM_SECURE		0x0020
 
+#define L2CAP_FORCE_ACTIVE_MODE	0x04
+
 /* L2CAP command codes */
 #define L2CAP_COMMAND_REJ	0x01
 #define L2CAP_CONN_REQ		0x02
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 800b6b9..11fc44a 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -214,6 +214,8 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
 	conn->auth_type = HCI_AT_GENERAL_BONDING;
 
 	conn->power_save = 1;
+	/* Do not enter active state by default */ 
+	conn->force_active = 0;
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
index cf3c407..5328e82 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -1909,6 +1909,15 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname, char __us
 		l2cap_pi(sk)->force_reliable = (opt & L2CAP_LM_RELIABLE);
 		break;
 
+	case L2CAP_FORCE_ACTIVE_MODE:
+		if (get_user(opt, (u32 __user *) optval)) {
+			err = -EFAULT;
+			break;
+		}
+		
+		l2cap_pi(sk)->conn->hcon->force_active = opt;
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
@@ -2058,6 +2067,12 @@ static int l2cap_sock_getsockopt_old(struct socket *sock, int optname, char __us
 
 		break;
 
+	case L2CAP_FORCE_ACTIVE_MODE:
+		if (put_user(l2cap_pi(sk)->conn->hcon->force_active,
+					(u32 __user *) optval))
+			err = -EFAULT;
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
-- 
1.7.0.4

