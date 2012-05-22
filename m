Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 1/3] Bluetooth: Fix coding style in mgmt and hci code
Date: Tue, 22 May 2012 19:00:18 -0300
Message-Id: <1337724020-3171-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

This is some leftover from the last patches that fixed style. It is mostly
line over 80 characters fixes reported by checkpatch.pl.
checkpatch.pl is clean for these files now.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 net/bluetooth/hci_conn.c  |    3 ++-
 net/bluetooth/hci_core.c  |   13 +++++++++----
 net/bluetooth/hci_event.c |   25 ++++++++++++++++---------
 net/bluetooth/hci_sock.c  |   36 ++++++++++++++++++++++++------------
 net/bluetooth/hci_sysfs.c |    4 ++--
 net/bluetooth/mgmt.c      |   12 ++++++++----
 6 files changed, 61 insertions(+), 32 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 971601e..1ff09bf 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -454,7 +454,8 @@ struct hci_dev *hci_get_route(bdaddr_t *dst, bdaddr_t *src)
 	read_lock(&hci_dev_list_lock);
 
 	list_for_each_entry(d, &hci_dev_list, list) {
-		if (!test_bit(HCI_UP, &d->flags) || test_bit(HCI_RAW, &d->flags))
+		if (!test_bit(HCI_UP, &d->flags) ||
+		    test_bit(HCI_RAW, &d->flags))
 			continue;
 
 		/* Simple routing:
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index d0a960d..0d05f3e 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -167,8 +167,10 @@ static int __hci_request(struct hci_dev *hdev,
 	return err;
 }
 
-static inline int hci_request(struct hci_dev *hdev, void (*req)(struct hci_dev *hdev, unsigned long opt),
-					unsigned long opt, __u32 timeout)
+static inline int hci_request(struct hci_dev *hdev,
+			      void (*req)(struct hci_dev *hdev,
+					  unsigned long opt),
+			      unsigned long opt, __u32 timeout)
 {
 	int ret;
 
@@ -621,7 +623,9 @@ int hci_inquiry(void __user *arg)
 			goto done;
 	}
 
-	/* for unlimited number of responses we will use buffer with 255 entries */
+	/* for unlimited number of responses we will use buffer with
+	 * 255 entries
+	 */
 	max_rsp = (ir.num_rsp == 0) ? 255 : ir.num_rsp;
 
 	/* cache_dump can't sleep. Therefore we allocate temp buffer and then
@@ -2609,7 +2613,8 @@ static inline void hci_sched_esco(struct hci_dev *hdev)
 	if (!hci_conn_num(hdev, ESCO_LINK))
 		return;
 
-	while (hdev->sco_cnt && (conn = hci_low_sent(hdev, ESCO_LINK, &quote))) {
+	while (hdev->sco_cnt && (conn = hci_low_sent(hdev, ESCO_LINK,
+						     &quote))) {
 		while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
 			BT_DBG("skb %p len %d", skb, skb->len);
 			hci_send_frame(skb);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 6c2d7cc..0c62546 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -409,7 +409,8 @@ static void hci_cc_read_voice_setting(struct hci_dev *hdev, struct sk_buff *skb)
 		hdev->notify(hdev, HCI_NOTIFY_VOICE_SETTING);
 }
 
-static void hci_cc_write_voice_setting(struct hci_dev *hdev, struct sk_buff *skb)
+static void hci_cc_write_voice_setting(struct hci_dev *hdev,
+				       struct sk_buff *skb)
 {
 	__u8 status = *((__u8 *) skb->data);
 	__u16 setting;
@@ -648,7 +649,8 @@ static void hci_setup_link_policy(struct hci_dev *hdev)
 	hci_send_cmd(hdev, HCI_OP_WRITE_DEF_LINK_POLICY, sizeof(cp), &cp);
 }
 
-static void hci_cc_read_local_commands(struct hci_dev *hdev, struct sk_buff *skb)
+static void hci_cc_read_local_commands(struct hci_dev *hdev,
+				       struct sk_buff *skb)
 {
 	struct hci_rp_read_local_commands *rp = (void *) skb->data;
 
@@ -666,7 +668,8 @@ done:
 	hci_req_complete(hdev, HCI_OP_READ_LOCAL_COMMANDS, rp->status);
 }
 
-static void hci_cc_read_local_features(struct hci_dev *hdev, struct sk_buff *skb)
+static void hci_cc_read_local_features(struct hci_dev *hdev,
+				       struct sk_buff *skb)
 {
 	struct hci_rp_read_local_features *rp = (void *) skb->data;
 
@@ -1849,7 +1852,8 @@ static inline void hci_conn_request_evt(struct hci_dev *hdev,
 		if (ie)
 			memcpy(ie->data.dev_class, ev->dev_class, 3);
 
-		conn = hci_conn_hash_lookup_ba(hdev, ev->link_type, &ev->bdaddr);
+		conn = hci_conn_hash_lookup_ba(hdev, ev->link_type,
+					       &ev->bdaddr);
 		if (!conn) {
 			conn = hci_conn_add(hdev, ev->link_type, &ev->bdaddr);
 			if (!conn) {
@@ -2006,7 +2010,8 @@ unlock:
 	hci_dev_unlock(hdev);
 }
 
-static inline void hci_remote_name_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static inline void hci_remote_name_evt(struct hci_dev *hdev,
+				       struct sk_buff *skb)
 {
 	struct hci_ev_remote_name *ev = (void *) skb->data;
 	struct hci_conn *conn;
@@ -2636,7 +2641,8 @@ static inline void hci_mode_change_evt(struct hci_dev *hdev,
 		conn->mode = ev->mode;
 		conn->interval = __le16_to_cpu(ev->interval);
 
-		if (!test_and_clear_bit(HCI_CONN_MODE_CHANGE_PEND, &conn->flags)) {
+		if (!test_and_clear_bit(HCI_CONN_MODE_CHANGE_PEND,
+					&conn->flags)) {
 			if (conn->mode == HCI_CM_ACTIVE)
 				set_bit(HCI_CONN_POWER_SAVE, &conn->flags);
 			else
@@ -2729,8 +2735,8 @@ static inline void hci_link_key_request_evt(struct hci_dev *hdev,
 
 		if (key->type == HCI_LK_COMBINATION && key->pin_len < 16 &&
 		    conn->pending_sec_level == BT_SECURITY_HIGH) {
-			BT_DBG("%s ignoring key unauthenticated for high \
-			       security", hdev->name);
+			BT_DBG("%s ignoring key unauthenticated for high security",
+			       hdev->name);
 			goto not_found;
 		}
 
@@ -3119,7 +3125,8 @@ static inline void hci_io_capa_request_evt(struct hci_dev *hdev,
 		conn->auth_type = hci_get_auth_req(conn);
 		cp.authentication = conn->auth_type;
 
-		if ((conn->out || test_bit(HCI_CONN_REMOTE_OOB, &conn->flags)) &&
+		if ((conn->out ||
+		     test_bit(HCI_CONN_REMOTE_OOB, &conn->flags)) &&
 		    hci_find_remote_oob_data(hdev, &conn->dst))
 			cp.oob_data = 0x01;
 		else
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index bdf51d1..df2fd25 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -118,7 +118,8 @@ void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb)
 			continue;
 
 		if (bt_cb(skb)->pkt_type == HCI_EVENT_PKT) {
-			register int evt = (*(__u8 *)skb->data & HCI_FLT_EVENT_BITS);
+			register int evt = (*(__u8 *)skb->data &
+					    HCI_FLT_EVENT_BITS);
 
 			if (!hci_test_bit(evt, &flt->event_mask))
 				continue;
@@ -241,7 +242,8 @@ void hci_send_to_monitor(struct hci_dev *hdev, struct sk_buff *skb)
 			struct hci_mon_hdr *hdr;
 
 			/* Create a private copy with headroom */
-			skb_copy = __pskb_copy(skb, HCI_MON_HDR_SIZE, GFP_ATOMIC);
+			skb_copy = __pskb_copy(skb, HCI_MON_HDR_SIZE,
+					       GFP_ATOMIC);
 			if (!skb_copy)
 				continue;
 
@@ -496,7 +498,8 @@ static int hci_sock_blacklist_del(struct hci_dev *hdev, void __user *arg)
 }
 
 /* Ioctls that require bound socket */
-static inline int hci_sock_bound_ioctl(struct sock *sk, unsigned int cmd, unsigned long arg)
+static inline int hci_sock_bound_ioctl(struct sock *sk, unsigned int cmd,
+				       unsigned long arg)
 {
 	struct hci_dev *hdev = hci_pi(sk)->hdev;
 
@@ -541,7 +544,8 @@ static inline int hci_sock_bound_ioctl(struct sock *sk, unsigned int cmd, unsign
 	}
 }
 
-static int hci_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
+static int hci_sock_ioctl(struct socket *sock, unsigned int cmd,
+			  unsigned long arg)
 {
 	struct sock *sk = sock->sk;
 	void __user *argp = (void __user *) arg;
@@ -602,7 +606,8 @@ static int hci_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long a
 	}
 }
 
-static int hci_sock_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
+static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
+			 int addr_len)
 {
 	struct sockaddr_hci haddr;
 	struct sock *sk = sock->sk;
@@ -691,7 +696,8 @@ done:
 	return err;
 }
 
-static int hci_sock_getname(struct socket *sock, struct sockaddr *addr, int *addr_len, int peer)
+static int hci_sock_getname(struct socket *sock, struct sockaddr *addr,
+			    int *addr_len, int peer)
 {
 	struct sockaddr_hci *haddr = (struct sockaddr_hci *) addr;
 	struct sock *sk = sock->sk;
@@ -712,13 +718,15 @@ static int hci_sock_getname(struct socket *sock, struct sockaddr *addr, int *add
 	return 0;
 }
 
-static inline void hci_sock_cmsg(struct sock *sk, struct msghdr *msg, struct sk_buff *skb)
+static inline void hci_sock_cmsg(struct sock *sk, struct msghdr *msg,
+				 struct sk_buff *skb)
 {
 	__u32 mask = hci_pi(sk)->cmsg_mask;
 
 	if (mask & HCI_CMSG_DIR) {
 		int incoming = bt_cb(skb)->incoming;
-		put_cmsg(msg, SOL_HCI, HCI_CMSG_DIR, sizeof(incoming), &incoming);
+		put_cmsg(msg, SOL_HCI, HCI_CMSG_DIR, sizeof(incoming),
+			 &incoming);
 	}
 
 	if (mask & HCI_CMSG_TSTAMP) {
@@ -893,7 +901,8 @@ drop:
 	goto done;
 }
 
-static int hci_sock_setsockopt(struct socket *sock, int level, int optname, char __user *optval, unsigned int len)
+static int hci_sock_setsockopt(struct socket *sock, int level, int optname,
+			       char __user *optval, unsigned int len)
 {
 	struct hci_ufilter uf = { .opcode = 0 };
 	struct sock *sk = sock->sk;
@@ -951,8 +960,10 @@ static int hci_sock_setsockopt(struct socket *sock, int level, int optname, char
 
 		if (!capable(CAP_NET_RAW)) {
 			uf.type_mask &= hci_sec_filter.type_mask;
-			uf.event_mask[0] &= *((u32 *) hci_sec_filter.event_mask + 0);
-			uf.event_mask[1] &= *((u32 *) hci_sec_filter.event_mask + 1);
+			uf.event_mask[0] &=
+				*((u32 *) hci_sec_filter.event_mask + 0);
+			uf.event_mask[1] &=
+				*((u32 *) hci_sec_filter.event_mask + 1);
 		}
 
 		{
@@ -975,7 +986,8 @@ done:
 	return err;
 }
 
-static int hci_sock_getsockopt(struct socket *sock, int level, int optname, char __user *optval, int __user *optlen)
+static int hci_sock_getsockopt(struct socket *sock, int level, int optname,
+			       char __user *optval, int __user *optlen)
 {
 	struct hci_ufilter uf;
 	struct sock *sk = sock->sk;
diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 847a844..ee8d9ea 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -220,8 +220,8 @@ static ssize_t show_class(struct device *dev,
 			  struct device_attribute *attr, char *buf)
 {
 	struct hci_dev *hdev = to_hci_dev(dev);
-	return sprintf(buf, "0x%.2x%.2x%.2x\n",
-		       hdev->dev_class[2], hdev->dev_class[1], hdev->dev_class[0]);
+	return sprintf(buf, "0x%.2x%.2x%.2x\n", hdev->dev_class[2],
+		       hdev->dev_class[1], hdev->dev_class[0]);
 }
 
 static ssize_t show_address(struct device *dev,
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 6a7e926..f3170e5 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -714,7 +714,8 @@ static struct pending_cmd *mgmt_pending_add(struct sock *sk, u16 opcode,
 }
 
 static void mgmt_pending_foreach(u16 opcode, struct hci_dev *hdev,
-				 void (*cb)(struct pending_cmd *cmd, void *data),
+				 void (*cb)(struct pending_cmd *cmd,
+					    void *data),
 				 void *data)
 {
 	struct list_head *p, *n;
@@ -1594,7 +1595,8 @@ static int disconnect(struct sock *sk, struct hci_dev *hdev, void *data,
 	}
 
 	if (cp->addr.type == BDADDR_BREDR)
-		conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &cp->addr.bdaddr);
+		conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK,
+					       &cp->addr.bdaddr);
 	else
 		conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, &cp->addr.bdaddr);
 
@@ -3226,7 +3228,8 @@ int mgmt_user_confirm_neg_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 					 u8 link_type, u8 addr_type, u8 status)
 {
 	return user_pairing_resp_complete(hdev, bdaddr, link_type, addr_type,
-					  status, MGMT_OP_USER_CONFIRM_NEG_REPLY);
+					  status,
+					  MGMT_OP_USER_CONFIRM_NEG_REPLY);
 }
 
 int mgmt_user_passkey_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
@@ -3240,7 +3243,8 @@ int mgmt_user_passkey_neg_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 					 u8 link_type, u8 addr_type, u8 status)
 {
 	return user_pairing_resp_complete(hdev, bdaddr, link_type, addr_type,
-					  status, MGMT_OP_USER_PASSKEY_NEG_REPLY);
+					  status,
+					  MGMT_OP_USER_PASSKEY_NEG_REPLY);
 }
 
 int mgmt_auth_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
-- 
1.7.10.1

