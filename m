Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 08/10] Bluetooth: Fix code style issues and make checkpatch silent about hci_core.c
Date: Thu, 17 Feb 2011 14:16:39 +0100
Message-ID: <1297948601-12723-9-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1297948601-12723-1-git-send-email-szymon.janc@tieto.com>
References: <1297948601-12723-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 net/bluetooth/hci_core.c |   30 +++++++++++++++++-------------
 1 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 0f5bbb0..60581b7 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -123,8 +123,9 @@ static void hci_req_cancel(struct hci_dev *hdev, int err)
 }
 
 /* Execute request and wait for completion. */
-static int __hci_request(struct hci_dev *hdev, void (*req)(struct hci_dev *hdev, unsigned long opt),
-				unsigned long opt, __u32 timeout)
+static int __hci_request(struct hci_dev *hdev,
+			void (*req)(struct hci_dev *hdev, unsigned long opt),
+					unsigned long opt, __u32 timeout)
 {
 	DECLARE_WAITQUEUE(wait, current);
 	int err = 0;
@@ -165,8 +166,9 @@ static int __hci_request(struct hci_dev *hdev, void (*req)(struct hci_dev *hdev,
 	return err;
 }
 
-static inline int hci_request(struct hci_dev *hdev, void (*req)(struct hci_dev *hdev, unsigned long opt),
-				unsigned long opt, __u32 timeout)
+static inline int hci_request(struct hci_dev *hdev,
+			void (*req)(struct hci_dev *hdev, unsigned long opt),
+					unsigned long opt, __u32 timeout)
 {
 	int ret;
 
@@ -351,7 +353,8 @@ static void inquiry_cache_flush(struct hci_dev *hdev)
 	}
 }
 
-struct inquiry_entry *hci_inquiry_cache_lookup(struct hci_dev *hdev, bdaddr_t *bdaddr)
+struct inquiry_entry *hci_inquiry_cache_lookup(struct hci_dev *hdev,
+							bdaddr_t *bdaddr)
 {
 	struct inquiry_cache *cache = &hdev->inq_cache;
 	struct inquiry_entry *e;
@@ -459,13 +462,13 @@ int hci_inquiry(void __user *arg)
 			goto done;
 	}
 
-	/* for unlimited number of responses we will use buffer with 255 entries */
+	/* for unlimited number of responses use buffer with 255 entries */
 	max_rsp = (ir.num_rsp == 0) ? 255 : ir.num_rsp;
 
 	/* cache_dump can't sleep. Therefore we allocate temp buffer and then
 	 * copy it to the user space.
 	 */
-	buf = kmalloc(sizeof(struct inquiry_info) *max_rsp, GFP_KERNEL);
+	buf = kmalloc(sizeof(struct inquiry_info) * max_rsp, GFP_KERNEL);
 	if (!buf) {
 		err = -ENOMEM;
 		goto done;
@@ -534,7 +537,6 @@ int hci_dev_open(__u16 dev)
 		set_bit(HCI_INIT, &hdev->flags);
 		hdev->init_last_cmd = 0;
 
-		//__hci_request(hdev, hci_reset_req, 0, HZ);
 		ret = __hci_request(hdev, hci_init_req, 0,
 					msecs_to_jiffies(HCI_INIT_TIMEOUT));
 
@@ -1748,7 +1750,8 @@ EXPORT_SYMBOL(hci_send_sco);
 /* ---- HCI TX task (outgoing data) ---- */
 
 /* HCI Connection scheduler */
-static inline struct hci_conn *hci_low_sent(struct hci_dev *hdev, __u8 type, int *quote)
+static inline struct hci_conn *hci_low_sent(struct hci_dev *hdev, __u8 type,
+								int *quote)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn *conn = NULL;
@@ -1833,7 +1836,8 @@ static inline void hci_sched_acl(struct hci_dev *hdev)
 	if (!test_bit(HCI_RAW, &hdev->flags)) {
 		/* ACL tx timeout must be longer than maximum
 		 * link supervision timeout (40.9 seconds) */
-		if (!hdev->acl_cnt && time_after(jiffies, hdev->acl_last_tx + HZ * 45))
+		if (!hdev->acl_cnt &&
+			time_after(jiffies, hdev->acl_last_tx + HZ * 45))
 			hci_link_tx_to(hdev, ACL_LINK);
 	}
 
@@ -1881,7 +1885,7 @@ static inline void hci_sched_esco(struct hci_dev *hdev)
 
 	BT_DBG("%s", hdev->name);
 
-	while (hdev->sco_cnt && (conn = hci_low_sent(hdev, ESCO_LINK, &quote))) {
+	while (hdev->sco_cnt && (conn = hci_low_sent(hdev, ESCO_LINK, &quote)))
 		while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
 			BT_DBG("skb %p len %d", skb, skb->len);
 			hci_send_frame(skb);
@@ -1890,7 +1894,6 @@ static inline void hci_sched_esco(struct hci_dev *hdev)
 			if (conn->sent == ~0)
 				conn->sent = 0;
 		}
-	}
 }
 
 static inline void hci_sched_le(struct hci_dev *hdev)
@@ -1969,7 +1972,8 @@ static inline void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 	flags  = hci_flags(handle);
 	handle = hci_handle(handle);
 
-	BT_DBG("%s len %d handle 0x%x flags 0x%x", hdev->name, skb->len, handle, flags);
+	BT_DBG("%s len %d handle 0x%x flags 0x%x", hdev->name, skb->len, handle,
+									flags);
 
 	hdev->stat.acl_rx++;
 
-- 
1.7.0.4

