Return-Path: <cyrus@holtmann.org>
From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <padovan@profusion.mobi>,
	Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Subject: [PATCH v2] Bluetooth: Clean up some code style issues
Date: Tue, 7 Jun 2011 11:18:06 +0200
Message-ID: <1307438286-30597-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fix lines longer than 80 chars in length.

Signed-off-by: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
---
 include/net/bluetooth/bluetooth.h |    7 +++--
 include/net/bluetooth/hci_core.h  |   38 ++++++++++++++++++++++++------------
 include/net/bluetooth/rfcomm.h    |    9 +++++--
 3 files changed, 35 insertions(+), 19 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index af930a3..7bccaf9 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -137,7 +137,8 @@ int  bt_sock_register(int proto, const struct net_proto_family *ops);
 int  bt_sock_unregister(int proto);
 void bt_sock_link(struct bt_sock_list *l, struct sock *s);
 void bt_sock_unlink(struct bt_sock_list *l, struct sock *s);
-int  bt_sock_recvmsg(struct kiocb *iocb, struct socket *sock, struct msghdr *msg, size_t len, int flags);
+int  bt_sock_recvmsg(struct kiocb *iocb, struct socket *sock,
+				struct msghdr *msg, size_t len, int flags);
 int  bt_sock_stream_recvmsg(struct kiocb *iocb, struct socket *sock,
 			struct msghdr *msg, size_t len, int flags);
 uint bt_sock_poll(struct file * file, struct socket *sock, poll_table *wait);
@@ -172,8 +173,8 @@ static inline struct sk_buff *bt_skb_alloc(unsigned int len, gfp_t how)
 	return skb;
 }
 
-static inline struct sk_buff *bt_skb_send_alloc(struct sock *sk, unsigned long len, 
-							int nb, int *err)
+static inline struct sk_buff *bt_skb_send_alloc(struct sock *sk,
+					unsigned long len, int nb, int *err)
 {
 	struct sk_buff *skb;
 
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 818eadb..836d3e8 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -224,7 +224,7 @@ struct hci_conn {
 	spinlock_t	lock;
 
 	bdaddr_t	dst;
-	__u8            dst_type;
+	__u8		dst_type;
 	__u16		handle;
 	__u16		state;
 	__u8		mode;
@@ -317,7 +317,8 @@ static inline long inquiry_entry_age(struct inquiry_entry *e)
 	return jiffies - e->timestamp;
 }
 
-struct inquiry_entry *hci_inquiry_cache_lookup(struct hci_dev *hdev, bdaddr_t *bdaddr);
+struct inquiry_entry *hci_inquiry_cache_lookup(struct hci_dev *hdev,
+							bdaddr_t *bdaddr);
 void hci_inquiry_cache_update(struct hci_dev *hdev, struct inquiry_data *data);
 
 /* ----- HCI Connections ----- */
@@ -431,7 +432,8 @@ int hci_conn_del(struct hci_conn *conn);
 void hci_conn_hash_flush(struct hci_dev *hdev);
 void hci_conn_check_pending(struct hci_dev *hdev);
 
-struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8 sec_level, __u8 auth_type);
+struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
+						__u8 sec_level, __u8 auth_type);
 int hci_conn_check_link_mode(struct hci_conn *conn);
 int hci_conn_check_secure(struct hci_conn *conn, __u8 sec_level);
 int hci_conn_security(struct hci_conn *conn, __u8 sec_level, __u8 auth_type);
@@ -460,10 +462,12 @@ static inline void hci_conn_put(struct hci_conn *conn)
 				timeo = msecs_to_jiffies(conn->disc_timeout);
 				if (!conn->out)
 					timeo *= 2;
-			} else
+			} else {
 				timeo = msecs_to_jiffies(10);
-		} else
+			}
+		} else {
 			timeo = msecs_to_jiffies(10);
+		}
 		mod_timer(&conn->disc_timer, jiffies + timeo);
 	}
 }
@@ -578,16 +582,20 @@ struct hci_proto {
 
 	void		*priv;
 
-	int (*connect_ind)	(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 type);
+	int (*connect_ind)	(struct hci_dev *hdev, bdaddr_t *bdaddr,
+								__u8 type);
 	int (*connect_cfm)	(struct hci_conn *conn, __u8 status);
 	int (*disconn_ind)	(struct hci_conn *conn);
 	int (*disconn_cfm)	(struct hci_conn *conn, __u8 reason);
-	int (*recv_acldata)	(struct hci_conn *conn, struct sk_buff *skb, __u16 flags);
+	int (*recv_acldata)	(struct hci_conn *conn, struct sk_buff *skb,
+								__u16 flags);
 	int (*recv_scodata)	(struct hci_conn *conn, struct sk_buff *skb);
-	int (*security_cfm)	(struct hci_conn *conn, __u8 status, __u8 encrypt);
+	int (*security_cfm)	(struct hci_conn *conn, __u8 status,
+								__u8 encrypt);
 };
 
-static inline int hci_proto_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 type)
+static inline int hci_proto_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr,
+								__u8 type)
 {
 	register struct hci_proto *hp;
 	int mask = 0;
@@ -673,7 +681,8 @@ static inline void hci_proto_auth_cfm(struct hci_conn *conn, __u8 status)
 		conn->security_cfm_cb(conn, status);
 }
 
-static inline void hci_proto_encrypt_cfm(struct hci_conn *conn, __u8 status, __u8 encrypt)
+static inline void hci_proto_encrypt_cfm(struct hci_conn *conn, __u8 status,
+								__u8 encrypt)
 {
 	register struct hci_proto *hp;
 
@@ -698,7 +707,8 @@ struct hci_cb {
 
 	char *name;
 
-	void (*security_cfm)	(struct hci_conn *conn, __u8 status, __u8 encrypt);
+	void (*security_cfm)	(struct hci_conn *conn, __u8 status,
+								__u8 encrypt);
 	void (*key_change_cfm)	(struct hci_conn *conn, __u8 status);
 	void (*role_switch_cfm)	(struct hci_conn *conn, __u8 status, __u8 role);
 };
@@ -724,7 +734,8 @@ static inline void hci_auth_cfm(struct hci_conn *conn, __u8 status)
 	read_unlock_bh(&hci_cb_list_lock);
 }
 
-static inline void hci_encrypt_cfm(struct hci_conn *conn, __u8 status, __u8 encrypt)
+static inline void hci_encrypt_cfm(struct hci_conn *conn, __u8 status,
+								__u8 encrypt)
 {
 	struct list_head *p;
 
@@ -755,7 +766,8 @@ static inline void hci_key_change_cfm(struct hci_conn *conn, __u8 status)
 	read_unlock_bh(&hci_cb_list_lock);
 }
 
-static inline void hci_role_switch_cfm(struct hci_conn *conn, __u8 status, __u8 role)
+static inline void hci_role_switch_cfm(struct hci_conn *conn, __u8 status,
+								__u8 role)
 {
 	struct list_head *p;
 
diff --git a/include/net/bluetooth/rfcomm.h b/include/net/bluetooth/rfcomm.h
index 6eac4a7..d5eee20 100644
--- a/include/net/bluetooth/rfcomm.h
+++ b/include/net/bluetooth/rfcomm.h
@@ -234,7 +234,8 @@ int rfcomm_send_rpn(struct rfcomm_session *s, int cr, u8 dlci,
 /* ---- RFCOMM DLCs (channels) ---- */
 struct rfcomm_dlc *rfcomm_dlc_alloc(gfp_t prio);
 void rfcomm_dlc_free(struct rfcomm_dlc *d);
-int  rfcomm_dlc_open(struct rfcomm_dlc *d, bdaddr_t *src, bdaddr_t *dst, u8 channel);
+int  rfcomm_dlc_open(struct rfcomm_dlc *d, bdaddr_t *src, bdaddr_t *dst,
+								u8 channel);
 int  rfcomm_dlc_close(struct rfcomm_dlc *d, int reason);
 int  rfcomm_dlc_send(struct rfcomm_dlc *d, struct sk_buff *skb);
 int  rfcomm_dlc_set_modem_status(struct rfcomm_dlc *d, u8 v24_sig);
@@ -271,7 +272,8 @@ static inline void rfcomm_dlc_unthrottle(struct rfcomm_dlc *d)
 }
 
 /* ---- RFCOMM sessions ---- */
-void   rfcomm_session_getaddr(struct rfcomm_session *s, bdaddr_t *src, bdaddr_t *dst);
+void   rfcomm_session_getaddr(struct rfcomm_session *s, bdaddr_t *src,
+								bdaddr_t *dst);
 
 static inline void rfcomm_session_hold(struct rfcomm_session *s)
 {
@@ -312,7 +314,8 @@ struct rfcomm_pinfo {
 int  rfcomm_init_sockets(void);
 void rfcomm_cleanup_sockets(void);
 
-int  rfcomm_connect_ind(struct rfcomm_session *s, u8 channel, struct rfcomm_dlc **d);
+int  rfcomm_connect_ind(struct rfcomm_session *s, u8 channel,
+							struct rfcomm_dlc **d);
 
 /* ---- RFCOMM TTY ---- */
 #define RFCOMM_MAX_DEV  256
-- 
1.7.4.1

