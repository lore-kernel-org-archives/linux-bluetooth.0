Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>,
	<par-gunnar.p.hjalmdahl@stericsson.com>,
	<ulrik.lauren@stericsson.com>
Subject: [PATCH 3/4] Bluetooth: Add BT_NO_AUTORETRY SCO socket option.
Date: Tue, 14 Jun 2011 15:57:06 +0200
Message-ID: <1308059827-15095-4-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1308059827-15095-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1308059827-15095-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add BT_NO_AUTORETRY socket option used to disable automatic connection retry
in case of failure.

This is now implemented for SCO sockets to disable retrying connection using
SCO packets only when it failed using eSCO packets. Such fallback is unwanted
i.e. for HFP wideband speech it is mandatory to use eSCO transport.

Signed-off-by: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
---
 include/net/bluetooth/bluetooth.h |    2 ++
 include/net/bluetooth/hci_core.h  |    1 +
 include/net/bluetooth/sco.h       |    1 +
 net/bluetooth/hci_event.c         |    2 +-
 net/bluetooth/sco.c               |   20 ++++++++++++++++++++
 5 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 795174b..bf7f1a5 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -86,6 +86,8 @@ struct bt_sco_parameters {
 	__u16 pkt_type;
 } __packed;
 
+#define BT_NO_AUTORETRY	11
+
 #define BT_INFO(fmt, arg...) printk(KERN_INFO "Bluetooth: " fmt "\n" , ## arg)
 #define BT_ERR(fmt, arg...)  printk(KERN_ERR "%s: " fmt "\n" , __func__ , ## arg)
 #define BT_DBG(fmt, arg...)  pr_debug("%s: " fmt "\n" , __func__ , ## arg)
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 5048472..c1ba98f 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -233,6 +233,7 @@ struct hci_conn {
 	__u8		type;
 	__u8		out;
 	__u8		attempt;
+	__u8		no_autoretry;
 	__u8		dev_class[3];
 	__u8		features[8];
 	__u8		ssp_mode;
diff --git a/include/net/bluetooth/sco.h b/include/net/bluetooth/sco.h
index 4fa57bf..c92a8b5 100644
--- a/include/net/bluetooth/sco.h
+++ b/include/net/bluetooth/sco.h
@@ -74,6 +74,7 @@ struct sco_pinfo {
 	struct bt_sock	bt;
 	__u32		flags;
 	struct bt_sco_parameters	param;
+	__u8	no_autoretry;
 	struct sco_conn	*conn;
 };
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 2f0d3ab..d30719e 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2419,7 +2419,7 @@ static inline void hci_sync_conn_complete_evt(struct hci_dev *hdev, struct sk_bu
 	case 0x1c:	/* SCO interval rejected */
 	case 0x1a:	/* Unsupported Remote Feature */
 	case 0x1f:	/* Unspecified error */
-		if (conn->out && conn->attempt < 2) {
+		if (conn->out && !conn->no_autoretry && conn->attempt < 2) {
 			conn->pkt_type = hdev->esco_type & SCO_ESCO_MASK;
 			hci_setup_sync(conn, conn->link->handle);
 			goto unlock;
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index c432428..d34228d 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -203,6 +203,11 @@ static int sco_connect(struct sock *sk)
 		goto done;
 	}
 
+	/* Make sure we won't retry connection automatically if user does
+	 * not want this. */
+	if (sco_pi(sk)->no_autoretry)
+		hcon->no_autoretry = 1;
+
 	conn = sco_conn_add(hcon, 0);
 	if (!conn) {
 		hci_conn_put(hcon);
@@ -677,6 +682,7 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname, char
 	int len;
 	int err = 0;
 	struct bt_sco_parameters *param;
+	u32 opt;
 
 	BT_DBG("sk %p", sk);
 
@@ -705,6 +711,15 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname, char
 
 		break;
 
+	case BT_NO_AUTORETRY:
+		if (get_user(opt, (u32 __user *) optval)) {
+			err = -EFAULT;
+			break;
+		}
+
+		sco_pi(sk)->no_autoretry = opt;
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
@@ -799,6 +814,11 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname, char
 
 		break;
 
+	case BT_NO_AUTORETRY:
+		if (put_user(sco_pi(sk)->no_autoretry, (u32 __user *) optval))
+			err = -EFAULT;
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
-- 
1.7.5.4

