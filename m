Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 4/4] Bluetooth: clean up hci code
Date: Fri, 26 Nov 2010 17:22:45 +0200
Message-Id: <1290784965-4508-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1290784965-4508-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1290784965-4508-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>

Remove extra spaces

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
---
 include/net/bluetooth/hci.h      |   16 +++++-----
 include/net/bluetooth/hci_core.h |   14 ++++----
 net/bluetooth/hci_conn.c         |   23 ++++++++++-----
 net/bluetooth/hci_core.c         |   57 ++++++++++++++++++++++++--------------
 net/bluetooth/hci_event.c        |    8 +++--
 net/bluetooth/hci_sock.c         |   17 +++++++----
 6 files changed, 82 insertions(+), 53 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index e30e008..f3c5ed6 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1,4 +1,4 @@
-/* 
+/*
    BlueZ - Bluetooth protocol stack for Linux
    Copyright (C) 2000-2001 Qualcomm Incorporated
 
@@ -12,13 +12,13 @@
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
    IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR ANY
-   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAGES 
-   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN 
-   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF 
+   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAGES
+   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
    OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 
-   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS, 
-   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS 
+   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
+   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
    SOFTWARE IS DISCLAIMED.
 */
 
@@ -489,7 +489,7 @@ struct hci_rp_read_local_name {
 
 #define HCI_OP_WRITE_PG_TIMEOUT		0x0c18
 
-#define HCI_OP_WRITE_SCAN_ENABLE 	0x0c1a
+#define HCI_OP_WRITE_SCAN_ENABLE	0x0c1a
 	#define SCAN_DISABLED		0x00
 	#define SCAN_INQUIRY		0x01
 	#define SCAN_PAGE		0x02
@@ -874,7 +874,7 @@ struct hci_ev_si_security {
 
 struct hci_command_hdr {
 	__le16	opcode;		/* OCF & OGF */
-	__u8 	plen;
+	__u8	plen;
 } __packed;
 
 struct hci_event_hdr {
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index ebec8c9..9c08625 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -44,15 +44,15 @@ struct inquiry_data {
 };
 
 struct inquiry_entry {
-	struct inquiry_entry 	*next;
+	struct inquiry_entry	*next;
 	__u32			timestamp;
 	struct inquiry_data	data;
 };
 
 struct inquiry_cache {
-	spinlock_t 		lock;
+	spinlock_t		lock;
 	__u32			timestamp;
-	struct inquiry_entry 	*list;
+	struct inquiry_entry	*list;
 };
 
 struct hci_conn_hash {
@@ -141,7 +141,7 @@ struct hci_dev {
 	void			*driver_data;
 	void			*core_data;
 
-	atomic_t 		promisc;
+	atomic_t		promisc;
 
 	struct dentry		*debugfs;
 
@@ -150,7 +150,7 @@ struct hci_dev {
 
 	struct rfkill		*rfkill;
 
-	struct module 		*owner;
+	struct module		*owner;
 
 	int (*open)(struct hci_dev *hdev);
 	int (*close)(struct hci_dev *hdev);
@@ -215,8 +215,8 @@ extern rwlock_t hci_dev_list_lock;
 extern rwlock_t hci_cb_list_lock;
 
 /* ----- Inquiry cache ----- */
-#define INQUIRY_CACHE_AGE_MAX   (HZ*30)   // 30 seconds
-#define INQUIRY_ENTRY_AGE_MAX   (HZ*60)   // 60 seconds
+#define INQUIRY_CACHE_AGE_MAX   (HZ*30)   /* 30 seconds */
+#define INQUIRY_ENTRY_AGE_MAX   (HZ*60)   /* 60 seconds */
 
 #define inquiry_cache_lock(c)		spin_lock(&c->lock)
 #define inquiry_cache_unlock(c)		spin_unlock(&c->lock)
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 0b1e460..6b90a41 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -39,7 +39,7 @@
 #include <net/sock.h>
 
 #include <asm/system.h>
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 #include <asm/unaligned.h>
 
 #include <net/bluetooth/bluetooth.h>
@@ -66,7 +66,8 @@ void hci_acl_connect(struct hci_conn *conn)
 	bacpy(&cp.bdaddr, &conn->dst);
 	cp.pscan_rep_mode = 0x02;
 
-	if ((ie = hci_inquiry_cache_lookup(hdev, &conn->dst))) {
+	ie = hci_inquiry_cache_lookup(hdev, &conn->dst);
+	if (ie) {
 		if (inquiry_entry_age(ie) <= INQUIRY_ENTRY_AGE_MAX) {
 			cp.pscan_rep_mode = ie->data.pscan_rep_mode;
 			cp.pscan_mode     = ie->data.pscan_mode;
@@ -368,8 +369,10 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8
 
 	BT_DBG("%s dst %s", hdev->name, batostr(dst));
 
-	if (!(acl = hci_conn_hash_lookup_ba(hdev, ACL_LINK, dst))) {
-		if (!(acl = hci_conn_add(hdev, ACL_LINK, dst)))
+	acl = hci_conn_hash_lookup_ba(hdev, ACL_LINK, dst);
+	if (!acl) {
+		acl = hci_conn_add(hdev, ACL_LINK, dst);
+		if (!acl)
 			return NULL;
 	}
 
@@ -389,8 +392,10 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8
 	if (type == ACL_LINK)
 		return acl;
 
-	if (!(sco = hci_conn_hash_lookup_ba(hdev, type, dst))) {
-		if (!(sco = hci_conn_add(hdev, type, dst))) {
+	sco = hci_conn_hash_lookup_ba(hdev, type, dst);
+	if (!sco) {
+		sco = hci_conn_add(hdev, type, dst);
+		if (!sco) {
 			hci_conn_put(acl);
 			return NULL;
 		}
@@ -647,10 +652,12 @@ int hci_get_conn_list(void __user *arg)
 
 	size = sizeof(req) + req.conn_num * sizeof(*ci);
 
-	if (!(cl = kmalloc(size, GFP_KERNEL)))
+	cl = kmalloc(size, GFP_KERNEL);
+	if (!cl)
 		return -ENOMEM;
 
-	if (!(hdev = hci_dev_get(req.dev_id))) {
+	hdev = hci_dev_get(req.dev_id);
+	if (!hdev) {
 		kfree(cl);
 		return -ENODEV;
 	}
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index bc2a052..7305d84 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -44,7 +44,7 @@
 #include <net/sock.h>
 
 #include <asm/system.h>
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 #include <asm/unaligned.h>
 
 #include <net/bluetooth/bluetooth.h>
@@ -349,20 +349,23 @@ struct inquiry_entry *hci_inquiry_cache_lookup(struct hci_dev *hdev, bdaddr_t *b
 void hci_inquiry_cache_update(struct hci_dev *hdev, struct inquiry_data *data)
 {
 	struct inquiry_cache *cache = &hdev->inq_cache;
-	struct inquiry_entry *e;
+	struct inquiry_entry *ie;
 
 	BT_DBG("cache %p, %s", cache, batostr(&data->bdaddr));
 
-	if (!(e = hci_inquiry_cache_lookup(hdev, &data->bdaddr))) {
+	ie = hci_inquiry_cache_lookup(hdev, &data->bdaddr);
+	if (!ie) {
 		/* Entry not in the cache. Add new one. */
-		if (!(e = kzalloc(sizeof(struct inquiry_entry), GFP_ATOMIC)))
+		ie = kzalloc(sizeof(struct inquiry_entry), GFP_ATOMIC);
+		if (!ie)
 			return;
-		e->next     = cache->list;
-		cache->list = e;
+
+		ie->next = cache->list;
+		cache->list = ie;
 	}
 
-	memcpy(&e->data, data, sizeof(*data));
-	e->timestamp = jiffies;
+	memcpy(&ie->data, data, sizeof(*data));
+	ie->timestamp = jiffies;
 	cache->timestamp = jiffies;
 }
 
@@ -430,7 +433,8 @@ int hci_inquiry(void __user *arg)
 	hci_dev_unlock_bh(hdev);
 
 	timeo = ir.length * msecs_to_jiffies(2000);
-	if (do_inquiry && (err = hci_request(hdev, hci_inq_req, (unsigned long)&ir, timeo)) < 0)
+	err = hci_request(hdev, hci_inq_req, (unsigned long)&ir, timeo);
+	if (do_inquiry && err < 0)
 		goto done;
 
 	/* for unlimited number of responses we will use buffer with 255 entries */
@@ -439,7 +443,8 @@ int hci_inquiry(void __user *arg)
 	/* cache_dump can't sleep. Therefore we allocate temp buffer and then
 	 * copy it to the user space.
 	 */
-	if (!(buf = kmalloc(sizeof(struct inquiry_info) * max_rsp, GFP_KERNEL))) {
+	buf = kmalloc(sizeof(struct inquiry_info) *max_rsp, GFP_KERNEL);
+	if (!buf) {
 		err = -ENOMEM;
 		goto done;
 	}
@@ -611,7 +616,8 @@ int hci_dev_close(__u16 dev)
 	struct hci_dev *hdev;
 	int err;
 
-	if (!(hdev = hci_dev_get(dev)))
+	hdev = hci_dev_get(dev);
+	if (!hdev)
 		return -ENODEV;
 	err = hci_dev_do_close(hdev);
 	hci_dev_put(hdev);
@@ -623,7 +629,8 @@ int hci_dev_reset(__u16 dev)
 	struct hci_dev *hdev;
 	int ret = 0;
 
-	if (!(hdev = hci_dev_get(dev)))
+	hdev = hci_dev_get(dev);
+	if (!hdev)
 		return -ENODEV;
 
 	hci_req_lock(hdev);
@@ -663,7 +670,8 @@ int hci_dev_reset_stat(__u16 dev)
 	struct hci_dev *hdev;
 	int ret = 0;
 
-	if (!(hdev = hci_dev_get(dev)))
+	hdev = hci_dev_get(dev);
+	if (!hdev)
 		return -ENODEV;
 
 	memset(&hdev->stat, 0, sizeof(struct hci_dev_stats));
@@ -682,7 +690,8 @@ int hci_dev_cmd(unsigned int cmd, void __user *arg)
 	if (copy_from_user(&dr, arg, sizeof(dr)))
 		return -EFAULT;
 
-	if (!(hdev = hci_dev_get(dr.dev_id)))
+	hdev = hci_dev_get(dr.dev_id);
+	if (!hdev)
 		return -ENODEV;
 
 	switch (cmd) {
@@ -763,7 +772,8 @@ int hci_get_dev_list(void __user *arg)
 
 	size = sizeof(*dl) + dev_num * sizeof(*dr);
 
-	if (!(dl = kzalloc(size, GFP_KERNEL)))
+	dl = kzalloc(size, GFP_KERNEL);
+	if (!dl)
 		return -ENOMEM;
 
 	dr = dl->dev_req;
@@ -797,7 +807,8 @@ int hci_get_dev_info(void __user *arg)
 	if (copy_from_user(&di, arg, sizeof(di)))
 		return -EFAULT;
 
-	if (!(hdev = hci_dev_get(di.dev_id)))
+	hdev = hci_dev_get(di.dev_id);
+	if (!hdev)
 		return -ENODEV;
 
 	strcpy(di.name, hdev->name);
@@ -905,7 +916,7 @@ int hci_register_dev(struct hci_dev *hdev)
 	hdev->sniff_max_interval = 800;
 	hdev->sniff_min_interval = 80;
 
-	tasklet_init(&hdev->cmd_task, hci_cmd_task,(unsigned long) hdev);
+	tasklet_init(&hdev->cmd_task, hci_cmd_task, (unsigned long) hdev);
 	tasklet_init(&hdev->rx_task, hci_rx_task, (unsigned long) hdev);
 	tasklet_init(&hdev->tx_task, hci_tx_task, (unsigned long) hdev);
 
@@ -1368,7 +1379,8 @@ void hci_send_acl(struct hci_conn *conn, struct sk_buff *skb, __u16 flags)
 	bt_cb(skb)->pkt_type = HCI_ACLDATA_PKT;
 	hci_add_acl_hdr(skb, conn->handle, flags | ACL_START);
 
-	if (!(list = skb_shinfo(skb)->frag_list)) {
+	list = skb_shinfo(skb)->frag_list;
+	if (!list) {
 		/* Non fragmented */
 		BT_DBG("%s nonfrag skb %p len %d", hdev->name, skb, skb->len);
 
@@ -1609,7 +1621,8 @@ static inline void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_conn_enter_active_mode(conn);
 
 		/* Send to upper protocol */
-		if ((hp = hci_proto[HCI_PROTO_L2CAP]) && hp->recv_acldata) {
+		hp = hci_proto[HCI_PROTO_L2CAP];
+		if (hp && hp->recv_acldata) {
 			hp->recv_acldata(conn, skb, flags);
 			return;
 		}
@@ -1644,7 +1657,8 @@ static inline void hci_scodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 		register struct hci_proto *hp;
 
 		/* Send to upper protocol */
-		if ((hp = hci_proto[HCI_PROTO_SCO]) && hp->recv_scodata) {
+		hp = hci_proto[HCI_PROTO_SCO];
+		if (hp && hp->recv_scodata) {
 			hp->recv_scodata(conn, skb);
 			return;
 		}
@@ -1727,7 +1741,8 @@ static void hci_cmd_task(unsigned long arg)
 	if (atomic_read(&hdev->cmd_cnt) && (skb = skb_dequeue(&hdev->cmd_q))) {
 		kfree_skb(hdev->sent_cmd);
 
-		if ((hdev->sent_cmd = skb_clone(skb, GFP_ATOMIC))) {
+		hdev->sent_cmd = skb_clone(skb, GFP_ATOMIC);
+		if (hdev->sent_cmd) {
 			atomic_dec(&hdev->cmd_cnt);
 			hci_send_frame(skb);
 			hdev->cmd_last_tx = jiffies;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 3c1957c..8923b36 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -39,7 +39,7 @@
 #include <net/sock.h>
 
 #include <asm/system.h>
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 #include <asm/unaligned.h>
 
 #include <net/bluetooth/bluetooth.h>
@@ -1512,10 +1512,12 @@ static inline void hci_num_comp_pkts_evt(struct hci_dev *hdev, struct sk_buff *s
 			conn->sent -= count;
 
 			if (conn->type == ACL_LINK) {
-				if ((hdev->acl_cnt += count) > hdev->acl_pkts)
+				hdev->acl_cnt += count;
+				if (hdev->acl_cnt > hdev->acl_pkts)
 					hdev->acl_cnt = hdev->acl_pkts;
 			} else {
-				if ((hdev->sco_cnt += count) > hdev->sco_pkts)
+				hdev->sco_cnt += count;
+				if (hdev->sco_cnt > hdev->sco_pkts)
 					hdev->sco_cnt = hdev->sco_pkts;
 			}
 		}
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 83acd16..b3753ba 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -43,7 +43,7 @@
 #include <net/sock.h>
 
 #include <asm/system.h>
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 #include <asm/unaligned.h>
 
 #include <net/bluetooth/bluetooth.h>
@@ -125,7 +125,8 @@ void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb)
 				continue;
 		}
 
-		if (!(nskb = skb_clone(skb, GFP_ATOMIC)))
+		nskb = skb_clone(skb, GFP_ATOMIC);
+		if (!nskb)
 			continue;
 
 		/* Put type byte before the data */
@@ -370,7 +371,8 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr, int addr_le
 	}
 
 	if (haddr->hci_dev != HCI_DEV_NONE) {
-		if (!(hdev = hci_dev_get(haddr->hci_dev))) {
+		hdev = hci_dev_get(haddr->hci_dev);
+		if (!hdev) {
 			err = -ENODEV;
 			goto done;
 		}
@@ -457,7 +459,8 @@ static int hci_sock_recvmsg(struct kiocb *iocb, struct socket *sock,
 	if (sk->sk_state == BT_CLOSED)
 		return 0;
 
-	if (!(skb = skb_recv_datagram(sk, flags, noblock, &err)))
+	skb = skb_recv_datagram(sk, flags, noblock, &err);
+	if (!skb)
 		return err;
 
 	msg->msg_namelen = 0;
@@ -499,7 +502,8 @@ static int hci_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
 
 	lock_sock(sk);
 
-	if (!(hdev = hci_pi(sk)->hdev)) {
+	hdev = hci_pi(sk)->hdev;
+	if (!hdev) {
 		err = -EBADFD;
 		goto done;
 	}
@@ -509,7 +513,8 @@ static int hci_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
 		goto done;
 	}
 
-	if (!(skb = bt_skb_send_alloc(sk, len, msg->msg_flags & MSG_DONTWAIT, &err)))
+	skb = bt_skb_send_alloc(sk, len, msg->msg_flags & MSG_DONTWAIT, &err);
+	if (!skb)
 		goto done;
 
 	if (memcpy_fromiovec(skb_put(skb, len), msg->msg_iov, len)) {
-- 
1.7.1

