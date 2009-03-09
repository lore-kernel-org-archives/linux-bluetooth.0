Return-Path: <cyrus@holtmann.org>
From: =?utf-8?q?Erik=20Andr=C3=A9n?= <erik.andren@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?utf-8?q?Erik=20Andr=C3=A9n?= <erik.andren@gmail.com>
Subject: [PATCH 2/3] Checkpatch.pl: Fixup hci_core.c
Date: Mon,  9 Mar 2009 20:55:28 +0100
Message-Id: <1236628529-23819-3-git-send-email-erik.andren@gmail.com>
In-Reply-To: <1236628529-23819-2-git-send-email-erik.andren@gmail.com>
References: <1>
 <1236628529-23819-1-git-send-email-erik.andren@gmail.com>
 <1236628529-23819-2-git-send-email-erik.andren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Erik Andrén <erik.andren@gmail.com>
---
 net/bluetooth/hci_core.c |  102 ++++++++++++++++++++++++++++++---------------
 1 files changed, 68 insertions(+), 34 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index c21753f..b1a93c4 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -39,10 +39,10 @@
 #include <linux/skbuff.h>
 #include <linux/interrupt.h>
 #include <linux/notifier.h>
+#include <linux/uaccess.h>
 #include <net/sock.h>
 
 #include <asm/system.h>
-#include <asm/uaccess.h>
 #include <asm/unaligned.h>
 
 #include <net/bluetooth/bluetooth.h>
@@ -112,8 +112,11 @@ static void hci_req_cancel(struct hci_dev *hdev, int err)
 }
 
 /* Execute request and wait for completion. */
-static int __hci_request(struct hci_dev *hdev, void (*req)(struct hci_dev *hdev, unsigned long opt),
-				unsigned long opt, __u32 timeout)
+static int __hci_request(struct hci_dev *hdev,
+			 void (*req)(struct hci_dev *hdev,
+			 unsigned long opt),
+			 unsigned long opt,
+			 __u32 timeout)
 {
 	DECLARE_WAITQUEUE(wait, current);
 	int err = 0;
@@ -154,8 +157,11 @@ static int __hci_request(struct hci_dev *hdev, void (*req)(struct hci_dev *hdev,
 	return err;
 }
 
-static inline int hci_request(struct hci_dev *hdev, void (*req)(struct hci_dev *hdev, unsigned long opt),
-				unsigned long opt, __u32 timeout)
+static inline int hci_request(struct hci_dev *hdev,
+			      void (*req)(struct hci_dev *hdev,
+			      unsigned long opt),
+			      unsigned long opt,
+			      __u32 timeout)
 {
 	int ret;
 
@@ -330,7 +336,8 @@ static void inquiry_cache_flush(struct hci_dev *hdev)
 	}
 }
 
-struct inquiry_entry *hci_inquiry_cache_lookup(struct hci_dev *hdev, bdaddr_t *bdaddr)
+struct inquiry_entry *hci_inquiry_cache_lookup(struct hci_dev *hdev,
+					       bdaddr_t *bdaddr)
 {
 	struct inquiry_cache *cache = &hdev->inq_cache;
 	struct inquiry_entry *e;
@@ -350,11 +357,13 @@ void hci_inquiry_cache_update(struct hci_dev *hdev, struct inquiry_data *data)
 
 	BT_DBG("cache %p, %s", cache, batostr(&data->bdaddr));
 
-	if (!(e = hci_inquiry_cache_lookup(hdev, &data->bdaddr))) {
+	e = hci_inquiry_cache_lookup(hdev, &data->bdaddr);
+	if (!e) {
 		/* Entry not in the cache. Add new one. */
-		if (!(e = kzalloc(sizeof(struct inquiry_entry), GFP_ATOMIC)))
+		e = kzalloc(sizeof(struct inquiry_entry), GFP_ATOMIC);
+		if (!e)
 			return;
-		e->next     = cache->list;
+		e->next = cache->list;
 		cache->list = e;
 	}
 
@@ -414,7 +423,8 @@ int hci_inquiry(void __user *arg)
 	if (copy_from_user(&ir, ptr, sizeof(ir)))
 		return -EFAULT;
 
-	if (!(hdev = hci_dev_get(ir.dev_id)))
+	hdev = hci_dev_get(ir.dev_id);
+	if (!hdev)
 		return -ENODEV;
 
 	hci_dev_lock_bh(hdev);
@@ -427,16 +437,22 @@ int hci_inquiry(void __user *arg)
 	hci_dev_unlock_bh(hdev);
 
 	timeo = ir.length * msecs_to_jiffies(2000);
-	if (do_inquiry && (err = hci_request(hdev, hci_inq_req, (unsigned long)&ir, timeo)) < 0)
-		goto done;
 
-	/* for unlimited number of responses we will use buffer with 255 entries */
+	if (do_inquiry) {
+		err = hci_request(hdev, hci_inq_req, (unsigned long)&ir, timeo);
+		if (err < 0)
+			goto done;
+	}
+
+	/* for unlimited number of responses
+	   we will use buffer with 255 entries */
 	max_rsp = (ir.num_rsp == 0) ? 255 : ir.num_rsp;
 
 	/* cache_dump can't sleep. Therefore we allocate temp buffer and then
 	 * copy it to the user space.
 	 */
-	if (!(buf = kmalloc(sizeof(struct inquiry_info) * max_rsp, GFP_KERNEL))) {
+	buf = kmalloc(sizeof(struct inquiry_info) * max_rsp, GFP_KERNEL);
+	if (!buf) {
 		err = -ENOMEM;
 		goto done;
 	}
@@ -469,7 +485,8 @@ int hci_dev_open(__u16 dev)
 	struct hci_dev *hdev;
 	int ret = 0;
 
-	if (!(hdev = hci_dev_get(dev)))
+	hdev = hci_dev_get(dev)
+	if (!hdev)
 		return -ENODEV;
 
 	BT_DBG("%s %p", hdev->name, hdev);
@@ -493,7 +510,7 @@ int hci_dev_open(__u16 dev)
 		atomic_set(&hdev->cmd_cnt, 1);
 		set_bit(HCI_INIT, &hdev->flags);
 
-		//__hci_request(hdev, hci_reset_req, 0, HZ);
+		/* __hci_request(hdev, hci_reset_req, 0, HZ); */
 		ret = __hci_request(hdev, hci_init_req, 0,
 					msecs_to_jiffies(HCI_INIT_TIMEOUT));
 
@@ -599,7 +616,8 @@ int hci_dev_close(__u16 dev)
 	struct hci_dev *hdev;
 	int err;
 
-	if (!(hdev = hci_dev_get(dev)))
+	hdev = hci_dev_get(dev);
+	if (!hdev)
 		return -ENODEV;
 	err = hci_dev_do_close(hdev);
 	hci_dev_put(hdev);
@@ -611,7 +629,8 @@ int hci_dev_reset(__u16 dev)
 	struct hci_dev *hdev;
 	int ret = 0;
 
-	if (!(hdev = hci_dev_get(dev)))
+	hdev = hci_dev_get(dev);
+	if (!hdev)
 		return -ENODEV;
 
 	hci_req_lock(hdev);
@@ -651,7 +670,8 @@ int hci_dev_reset_stat(__u16 dev)
 	struct hci_dev *hdev;
 	int ret = 0;
 
-	if (!(hdev = hci_dev_get(dev)))
+	hdev = hci_dev_get(dev);
+	if (!hdev)
 		return -ENODEV;
 
 	memset(&hdev->stat, 0, sizeof(struct hci_dev_stats));
@@ -670,7 +690,8 @@ int hci_dev_cmd(unsigned int cmd, void __user *arg)
 	if (copy_from_user(&dr, arg, sizeof(dr)))
 		return -EFAULT;
 
-	if (!(hdev = hci_dev_get(dr.dev_id)))
+	hdev = hci_dev_get(dr.dev_id);
+	if (!hdev)
 		return -ENODEV;
 
 	switch (cmd) {
@@ -751,7 +772,8 @@ int hci_get_dev_list(void __user *arg)
 
 	size = sizeof(*dl) + dev_num * sizeof(*dr);
 
-	if (!(dl = kzalloc(size, GFP_KERNEL)))
+	dl = kzalloc(size, GFP_KERNEL);
+	if (!dl)
 		return -ENOMEM;
 
 	dr = dl->dev_req;
@@ -785,7 +807,8 @@ int hci_get_dev_info(void __user *arg)
 	if (copy_from_user(&di, arg, sizeof(di)))
 		return -EFAULT;
 
-	if (!(hdev = hci_dev_get(di.dev_id)))
+	hdev = hci_dev_get(di.dev_id);
+	if (!hdev)
 		return -ENODEV;
 
 	strcpy(di.name, hdev->name);
@@ -845,7 +868,8 @@ int hci_register_dev(struct hci_dev *hdev)
 	int i, err, id = 0;
 	bool empty;
 
-	BT_DBG("%p name %s type %d owner %p", hdev, hdev->name, hdev->type, hdev->owner);
+	BT_DBG("%p name %s type %d owner %p", hdev, hdev->name,
+	       hdev->type, hdev->owner);
 
 	if (!hdev->open || !hdev->close || !hdev->destruct)
 		return -EINVAL;
@@ -878,7 +902,7 @@ int hci_register_dev(struct hci_dev *hdev)
 	hdev->sniff_max_interval = 800;
 	hdev->sniff_min_interval = 80;
 
-	tasklet_init(&hdev->cmd_task, hci_cmd_task,(unsigned long) hdev);
+	tasklet_init(&hdev->cmd_task, hci_cmd_task, (unsigned long) hdev);
 	tasklet_init(&hdev->rx_task, hci_rx_task, (unsigned long) hdev);
 	tasklet_init(&hdev->tx_task, hci_tx_task, (unsigned long) hdev);
 
@@ -982,7 +1006,8 @@ int hci_recv_fragment(struct hci_dev *hdev, int type, void *data, int count)
 			case HCI_ACLDATA_PKT:
 				if (count >= HCI_ACL_HDR_SIZE) {
 					struct hci_acl_hdr *h = data;
-					len = HCI_ACL_HDR_SIZE + __le16_to_cpu(h->dlen);
+					len = HCI_ACL_HDR_SIZE +
+							__le16_to_cpu(h->dlen);
 				} else
 					return -EILSEQ;
 				break;
@@ -1208,7 +1233,8 @@ int hci_send_acl(struct hci_conn *conn, struct sk_buff *skb, __u16 flags)
 	bt_cb(skb)->pkt_type = HCI_ACLDATA_PKT;
 	hci_add_acl_hdr(skb, conn->handle, flags | ACL_START);
 
-	if (!(list = skb_shinfo(skb)->frag_list)) {
+	list = skb_shinfo(skb)->frag_list);
+	if (!list) {
 		/* Non fragmented */
 		BT_DBG("%s nonfrag skb %p len %d", hdev->name, skb, skb->len);
 
@@ -1274,7 +1300,8 @@ EXPORT_SYMBOL(hci_send_sco);
 /* ---- HCI TX task (outgoing data) ---- */
 
 /* HCI Connection scheduler */
-static inline struct hci_conn *hci_low_sent(struct hci_dev *hdev, __u8 type, int *quote)
+static inline struct hci_conn *hci_low_sent(struct hci_dev *hdev,
+					    __u8 type, int *quote)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn *conn = NULL;
@@ -1342,7 +1369,8 @@ static inline void hci_sched_acl(struct hci_dev *hdev)
 	if (!test_bit(HCI_RAW, &hdev->flags)) {
 		/* ACL tx timeout must be longer than maximum
 		 * link supervision timeout (40.9 seconds) */
-		if (!hdev->acl_cnt && time_after(jiffies, hdev->acl_last_tx + HZ * 45))
+		if (!hdev->acl_cnt &&
+			time_after(jiffies, hdev->acl_last_tx + HZ * 45))
 			hci_acl_tx_to(hdev);
 	}
 
@@ -1390,7 +1418,8 @@ static inline void hci_sched_esco(struct hci_dev *hdev)
 
 	BT_DBG("%s", hdev->name);
 
-	while (hdev->sco_cnt && (conn = hci_low_sent(hdev, ESCO_LINK, &quote))) {
+	while (hdev->sco_cnt &&
+		      (conn = hci_low_sent(hdev, ESCO_LINK, &quote))) {
 		while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
 			BT_DBG("skb %p len %d", skb, skb->len);
 			hci_send_frame(skb);
@@ -1441,7 +1470,8 @@ static inline void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 	flags  = hci_flags(handle);
 	handle = hci_handle(handle);
 
-	BT_DBG("%s len %d handle 0x%x flags 0x%x", hdev->name, skb->len, handle, flags);
+	BT_DBG("%s len %d handle 0x%x flags 0x%x",
+	       hdev->name, skb->len, handle, flags);
 
 	hdev->stat.acl_rx++;
 
@@ -1454,8 +1484,9 @@ static inline void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 
 		hci_conn_enter_active_mode(conn);
 
+		hp = hci_proto[HCI_PROTO_L2CAP];
 		/* Send to upper protocol */
-		if ((hp = hci_proto[HCI_PROTO_L2CAP]) && hp->recv_acldata) {
+		if (hp && hp->recv_acldata) {
 			hp->recv_acldata(conn, skb, flags);
 			return;
 		}
@@ -1490,7 +1521,8 @@ static inline void hci_scodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 		register struct hci_proto *hp;
 
 		/* Send to upper protocol */
-		if ((hp = hci_proto[HCI_PROTO_SCO]) && hp->recv_scodata) {
+		hp = hci_proto[HCI_PROTO_SCO];
+		if (hp && hp->recv_scodata) {
 			hp->recv_scodata(conn, skb);
 			return;
 		}
@@ -1564,7 +1596,8 @@ static void hci_cmd_task(unsigned long arg)
 
 	BT_DBG("%s cmd %d", hdev->name, atomic_read(&hdev->cmd_cnt));
 
-	if (!atomic_read(&hdev->cmd_cnt) && time_after(jiffies, hdev->cmd_last_tx + HZ)) {
+	if (!atomic_read(&hdev->cmd_cnt) &&
+		    time_after(jiffies, hdev->cmd_last_tx + HZ)) {
 		BT_ERR("%s command tx timeout", hdev->name);
 		atomic_set(&hdev->cmd_cnt, 1);
 	}
@@ -1573,7 +1606,8 @@ static void hci_cmd_task(unsigned long arg)
 	if (atomic_read(&hdev->cmd_cnt) && (skb = skb_dequeue(&hdev->cmd_q))) {
 		kfree_skb(hdev->sent_cmd);
 
-		if ((hdev->sent_cmd = skb_clone(skb, GFP_ATOMIC))) {
+		hdev->sent_cmd = skb_clone(skb, GFP_ATOMIC);
+		if (hdev->sent_cmd) {
 			atomic_dec(&hdev->cmd_cnt);
 			hci_send_frame(skb);
 			hdev->cmd_last_tx = jiffies;
-- 
1.5.6.3

