Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [RFC 2/2] Bluetooth: Fix SCO cancelation before ACL is established
Date: Wed, 14 Aug 2013 19:29:02 +0200
Message-Id: <1376501342-30347-2-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1376501342-30347-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1376501342-30347-1-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If SCO socket is closed before ACL connection is established, it is
possible to cancel the ongoing ACL connection setup. This happen
automatically when the last reference to the ACL connection is dropped.
Thus this patch simply drop the ACL connection.

Signed-off-by: Frédéric Dalleau <frederic.dalleau@linux.intel.com>
---
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/hci_conn.c         |   10 ++++++++++
 net/bluetooth/sco.c              |    4 +++-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 1000553..a09556a 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -587,6 +587,7 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
 			     __u8 dst_type, __u8 sec_level, __u8 auth_type);
 struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
 				 __u16 setting);
+void hci_cancel_sco(struct hci_conn *hconn);
 int hci_conn_check_link_mode(struct hci_conn *conn);
 int hci_conn_check_secure(struct hci_conn *conn, __u8 sec_level);
 int hci_conn_security(struct hci_conn *conn, __u8 sec_level, __u8 auth_type);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index d3befac..c3ef7a5 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -639,6 +639,16 @@ struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
 	return sco;
 }
 
+void hci_cancel_sco(struct hci_conn *hcon)
+{
+	struct hci_conn *acl = hcon->link;
+
+	if (acl && acl->handle == 0)
+		hci_conn_drop(acl);
+	else
+		BT_DBG("ACL is already established");
+}
+
 /* Create SCO, ACL or LE connection. */
 struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
 			     __u8 dst_type, __u8 sec_level, __u8 auth_type)
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index e94e654..89491a2 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -364,8 +364,10 @@ static void __sco_sock_close(struct sock *sk)
 			sco_chan_del(sk, ECONNRESET);
 		break;
 
-	case BT_CONNECT2:
 	case BT_CONNECT:
+		if (sco_pi(sk)->conn->hcon)
+			hci_cancel_sco(sco_pi(sk)->conn->hcon);
+	case BT_CONNECT2:
 	case BT_DISCONN:
 		sco_chan_del(sk, ECONNRESET);
 		break;
-- 
1.7.9.5

