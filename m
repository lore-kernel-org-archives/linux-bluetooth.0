Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <linus.walleij@stericsson.com>, <par-gunnar.p.hjalmdahl@stericsson.com>,
	<padovan@profusion.mobi>, <marcel@holtmann.org>, Lukasz Rymanowski
	<lukasz.rymanowski@tieto.com>
Subject: [PATCH] bluetooth: Fix for security block issue.
Date: Tue, 25 Jan 2011 15:27:19 +0100
Message-ID: <1295965639-16683-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

It can happen that controller will schedule ACL data
containing L2CAP connect request to host just before
encryption change event, even though link is encrypted on
LMP level before L2CAP connect request come.
With this fix, L2CAP layer will handle such scenario.

Signed-off-by: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
---
 include/net/bluetooth/l2cap.h |    8 +++++++
 net/bluetooth/l2cap.c         |   46 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 7f88a87..f1a5bd8 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -262,6 +262,11 @@ struct l2cap_chan_list {
 	long		num;
 };
 
+struct l2cap_pend_conn_req {
+	struct l2cap_cmd_hdr cmd;
+	struct l2cap_conn_req conn_req;
+};
+
 struct l2cap_conn {
 	struct hci_conn	*hcon;
 
@@ -276,6 +281,9 @@ struct l2cap_conn {
 	__u8		info_ident;
 
 	struct timer_list info_timer;
+	struct timer_list encrypt_timer;
+
+	struct l2cap_pend_conn_req *p_req;
 
 	spinlock_t	lock;
 
diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index d99b6b7..09181c7 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -57,6 +57,7 @@
 
 #define VERSION "2.15"
 
+#define ENCRYPT_TIMEOUT (20) /* 20 ms */
 static int disable_ertm;
 
 static u32 l2cap_feat_mask = L2CAP_FEAT_FIXED_CHAN;
@@ -75,6 +76,7 @@ static void l2cap_busy_work(struct work_struct *work);
 static void __l2cap_sock_close(struct sock *sk, int reason);
 static void l2cap_sock_close(struct sock *sk);
 static void l2cap_sock_kill(struct sock *sk);
+static void l2cap_encrypt_timeout(unsigned long arg);
 
 static int l2cap_build_conf_req(struct sock *sk, void *data);
 static struct sk_buff *l2cap_build_cmd(struct l2cap_conn *conn,
@@ -707,6 +709,8 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon, u8 status)
 	setup_timer(&conn->info_timer, l2cap_info_timeout,
 						(unsigned long) conn);
 
+	setup_timer(&conn->encrypt_timer, l2cap_encrypt_timeout,
+						(unsigned long) conn);
 	conn->disc_reason = 0x13;
 
 	return conn;
@@ -735,6 +739,11 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 	if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_SENT)
 		del_timer_sync(&conn->info_timer);
 
+	if (conn->p_req)
+		del_timer_sync(&conn->encrypt_timer);
+
+	kfree(conn->p_req);
+
 	hcon->l2cap_data = NULL;
 	kfree(conn);
 }
@@ -2982,6 +2991,28 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 	/* Check if the ACL is secure enough (if not SDP) */
 	if (psm != cpu_to_le16(0x0001) &&
 				!hci_conn_check_link_mode(conn->hcon)) {
+		/* Let's give a chance to Encryption Change Evt.*/
+		if (!conn->p_req) {
+			conn->p_req = kzalloc(sizeof(*conn->p_req), GFP_KERNEL);
+			if (conn->p_req) {
+				BT_DBG("Create pending connection req %p.",
+								conn->p_req);
+
+				memcpy(&conn->p_req->cmd, cmd, sizeof(*cmd));
+				memcpy(&conn->p_req->conn_req, req,
+								sizeof(*req));
+
+				mod_timer(&conn->encrypt_timer, jiffies +
+					msecs_to_jiffies(ENCRYPT_TIMEOUT));
+
+				/*
+				 * We will restart l2cap_conn_req in
+				 *  l2cap_encrypt_timeout.
+				 */
+				bh_unlock_sock(parent);
+				return 0;
+			}
+		}
 		conn->disc_reason = 0x05;
 		result = L2CAP_CR_SEC_BLOCK;
 		goto response;
@@ -3147,6 +3178,21 @@ static inline int l2cap_connect_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hd
 	return 0;
 }
 
+static void l2cap_encrypt_timeout(unsigned long arg)
+{
+	struct l2cap_conn *conn = (void *) arg;
+
+	BUG_ON(conn->p_req == NULL);
+
+	BT_DBG("conn %p, p_req %p", conn, conn->p_req);
+
+	(void)l2cap_connect_req(conn, &conn->p_req->cmd,
+					(u8 *)&conn->p_req->conn_req);
+
+	kfree(conn->p_req);
+	conn->p_req = NULL;
+}
+
 static inline void set_default_fcs(struct l2cap_pinfo *pi)
 {
 	/* FCS is enabled only in ERTM or streaming mode, if one or both
-- 
1.7.0.4

/Lukasz
on behalf of STEricsson
