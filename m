Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 07/10] Bluetooth: Fix code style issues and make checkpatch silent about hci_core.h
Date: Thu, 17 Feb 2011 14:16:38 +0100
Message-ID: <1297948601-12723-8-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1297948601-12723-1-git-send-email-szymon.janc@tieto.com>
References: <1297948601-12723-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 include/net/bluetooth/hci_core.h |   91 +++++++++++++++++++++-----------------
 1 files changed, 51 insertions(+), 40 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index e4f370f..a8a5ecb 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -208,37 +208,37 @@ struct hci_dev {
 struct hci_conn {
 	struct list_head list;
 
-	atomic_t	 refcnt;
-	spinlock_t	 lock;
-
-	bdaddr_t	 dst;
-	__u16		 handle;
-	__u16		 state;
-	__u8             mode;
-	__u8		 type;
-	__u8		 out;
-	__u8		 attempt;
-	__u8		 dev_class[3];
-	__u8             features[8];
-	__u8             ssp_mode;
-	__u16            interval;
-	__u16            pkt_type;
-	__u16            link_policy;
-	__u32		 link_mode;
-	__u8             auth_type;
-	__u8             sec_level;
-	__u8		 pending_sec_level;
-	__u8		 pin_length;
-	__u8		 io_capability;
-	__u8             power_save;
-	__u16            disc_timeout;
-	unsigned long	 pend;
+	atomic_t	refcnt;
+	spinlock_t	lock;
+
+	bdaddr_t	dst;
+	__u16		handle;
+	__u16		state;
+	__u8		mode;
+	__u8		type;
+	__u8		out;
+	__u8		attempt;
+	__u8		dev_class[3];
+	__u8		features[8];
+	__u8		ssp_mode;
+	__u16		interval;
+	__u16		pkt_type;
+	__u16		link_policy;
+	__u32		link_mode;
+	__u8		auth_type;
+	__u8		sec_level;
+	__u8		pending_sec_level;
+	__u8		pin_length;
+	__u8		io_capability;
+	__u8		power_save;
+	__u16		disc_timeout;
+	unsigned long	pend;
 
 	__u8		remote_cap;
 	__u8		remote_oob;
 	__u8		remote_auth;
 
-	unsigned int	 sent;
+	unsigned int	sent;
 
 	struct sk_buff_head data_q;
 
@@ -298,7 +298,8 @@ static inline long inquiry_entry_age(struct inquiry_entry *e)
 	return jiffies - e->timestamp;
 }
 
-struct inquiry_entry *hci_inquiry_cache_lookup(struct hci_dev *hdev, bdaddr_t *bdaddr);
+struct inquiry_entry *hci_inquiry_cache_lookup(struct hci_dev *hdev,
+							bdaddr_t *bdaddr);
 void hci_inquiry_cache_update(struct hci_dev *hdev, struct inquiry_data *data);
 
 /* ----- HCI Connections ----- */
@@ -356,7 +357,7 @@ static inline void hci_conn_hash_del(struct hci_dev *hdev, struct hci_conn *c)
 }
 
 static inline struct hci_conn *hci_conn_hash_lookup_handle(struct hci_dev *hdev,
-					__u16 handle)
+								__u16 handle)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct list_head *p;
@@ -371,7 +372,7 @@ static inline struct hci_conn *hci_conn_hash_lookup_handle(struct hci_dev *hdev,
 }
 
 static inline struct hci_conn *hci_conn_hash_lookup_ba(struct hci_dev *hdev,
-					__u8 type, bdaddr_t *ba)
+							__u8 type, bdaddr_t *ba)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct list_head *p;
@@ -386,7 +387,7 @@ static inline struct hci_conn *hci_conn_hash_lookup_ba(struct hci_dev *hdev,
 }
 
 static inline struct hci_conn *hci_conn_hash_lookup_state(struct hci_dev *hdev,
-					__u8 type, __u16 state)
+							__u8 type, __u16 state)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct list_head *p;
@@ -411,7 +412,8 @@ int hci_conn_del(struct hci_conn *conn);
 void hci_conn_hash_flush(struct hci_dev *hdev);
 void hci_conn_check_pending(struct hci_dev *hdev);
 
-struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8 sec_level, __u8 auth_type);
+struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
+						__u8 sec_level, __u8 auth_type);
 int hci_conn_check_link_mode(struct hci_conn *conn);
 int hci_conn_security(struct hci_conn *conn, __u8 sec_level, __u8 auth_type);
 int hci_conn_change_link_key(struct hci_conn *conn);
@@ -499,7 +501,8 @@ int hci_get_conn_info(struct hci_dev *hdev, void __user *arg);
 int hci_get_auth_info(struct hci_dev *hdev, void __user *arg);
 int hci_inquiry(void __user *arg);
 
-struct bdaddr_list *hci_blacklist_lookup(struct hci_dev *hdev, bdaddr_t *bdaddr);
+struct bdaddr_list *hci_blacklist_lookup(struct hci_dev *hdev,
+							bdaddr_t *bdaddr);
 int hci_blacklist_clear(struct hci_dev *hdev);
 
 int hci_uuids_clear(struct hci_dev *hdev);
@@ -551,16 +554,20 @@ struct hci_proto {
 
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
@@ -637,7 +644,8 @@ static inline void hci_proto_auth_cfm(struct hci_conn *conn, __u8 status)
 		hp->security_cfm(conn, status, encrypt);
 }
 
-static inline void hci_proto_encrypt_cfm(struct hci_conn *conn, __u8 status, __u8 encrypt)
+static inline void hci_proto_encrypt_cfm(struct hci_conn *conn, __u8 status,
+								__u8 encrypt)
 {
 	register struct hci_proto *hp;
 
@@ -659,7 +667,8 @@ struct hci_cb {
 
 	char *name;
 
-	void (*security_cfm)	(struct hci_conn *conn, __u8 status, __u8 encrypt);
+	void (*security_cfm)	(struct hci_conn *conn, __u8 status,
+								__u8 encrypt);
 	void (*key_change_cfm)	(struct hci_conn *conn, __u8 status);
 	void (*role_switch_cfm)	(struct hci_conn *conn, __u8 status, __u8 role);
 };
@@ -685,7 +694,8 @@ static inline void hci_auth_cfm(struct hci_conn *conn, __u8 status)
 	read_unlock_bh(&hci_cb_list_lock);
 }
 
-static inline void hci_encrypt_cfm(struct hci_conn *conn, __u8 status, __u8 encrypt)
+static inline void hci_encrypt_cfm(struct hci_conn *conn, __u8 status,
+								__u8 encrypt)
 {
 	struct list_head *p;
 
@@ -716,7 +726,8 @@ static inline void hci_key_change_cfm(struct hci_conn *conn, __u8 status)
 	read_unlock_bh(&hci_cb_list_lock);
 }
 
-static inline void hci_role_switch_cfm(struct hci_conn *conn, __u8 status, __u8 role)
+static inline void hci_role_switch_cfm(struct hci_conn *conn, __u8 status,
+								__u8 role)
 {
 	struct list_head *p;
 
-- 
1.7.0.4

