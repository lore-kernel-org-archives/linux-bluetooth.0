Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 7/7] Bluetooth: Fix coding style in hci_core.c
Date: Thu, 17 May 2012 00:36:26 -0300
Message-Id: <1337225786-11064-7-git-send-email-gustavo@padovan.org>
In-Reply-To: <1337225786-11064-6-git-send-email-gustavo@padovan.org>
References: <1337225786-11064-1-git-send-email-gustavo@padovan.org>
 <1337225786-11064-2-git-send-email-gustavo@padovan.org>
 <1337225786-11064-3-git-send-email-gustavo@padovan.org>
 <1337225786-11064-4-git-send-email-gustavo@padovan.org>
 <1337225786-11064-5-git-send-email-gustavo@padovan.org>
 <1337225786-11064-6-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

Follow net subsystem rules.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 net/bluetooth/hci_core.c |  103 ++++++++++++++++++++++++----------------------
 1 file changed, 53 insertions(+), 50 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 411ace8..d0a960d 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -124,8 +124,9 @@ static void hci_req_cancel(struct hci_dev *hdev, int err)
 }
 
 /* Execute request and wait for completion. */
-static int __hci_request(struct hci_dev *hdev, void (*req)(struct hci_dev *hdev, unsigned long opt),
-					unsigned long opt, __u32 timeout)
+static int __hci_request(struct hci_dev *hdev,
+			 void (*req)(struct hci_dev *hdev, unsigned long opt),
+			 unsigned long opt, __u32 timeout)
 {
 	DECLARE_WAITQUEUE(wait, current);
 	int err = 0;
@@ -417,7 +418,8 @@ static void inquiry_cache_flush(struct hci_dev *hdev)
 	INIT_LIST_HEAD(&cache->resolve);
 }
 
-struct inquiry_entry *hci_inquiry_cache_lookup(struct hci_dev *hdev, bdaddr_t *bdaddr)
+struct inquiry_entry *hci_inquiry_cache_lookup(struct hci_dev *hdev,
+					       bdaddr_t *bdaddr)
 {
 	struct discovery_state *cache = &hdev->discovery;
 	struct inquiry_entry *e;
@@ -478,7 +480,7 @@ void hci_inquiry_cache_update_resolve(struct hci_dev *hdev,
 
 	list_for_each_entry(p, &cache->resolve, list) {
 		if (p->name_state != NAME_PENDING &&
-				abs(p->data.rssi) >= abs(ie->data.rssi))
+		    abs(p->data.rssi) >= abs(ie->data.rssi))
 			break;
 		pos = &p->list;
 	}
@@ -503,7 +505,7 @@ bool hci_inquiry_cache_update(struct hci_dev *hdev, struct inquiry_data *data,
 			*ssp = true;
 
 		if (ie->name_state == NAME_NEEDED &&
-						data->rssi != ie->data.rssi) {
+		    data->rssi != ie->data.rssi) {
 			ie->data.rssi = data->rssi;
 			hci_inquiry_cache_update_resolve(hdev, ie);
 		}
@@ -527,7 +529,7 @@ bool hci_inquiry_cache_update(struct hci_dev *hdev, struct inquiry_data *data,
 
 update:
 	if (name_known && ie->name_state != NAME_KNOWN &&
-					ie->name_state != NAME_PENDING) {
+	    ie->name_state != NAME_PENDING) {
 		ie->name_state = NAME_KNOWN;
 		list_del(&ie->list);
 	}
@@ -605,8 +607,7 @@ int hci_inquiry(void __user *arg)
 
 	hci_dev_lock(hdev);
 	if (inquiry_cache_age(hdev) > INQUIRY_CACHE_AGE_MAX ||
-				inquiry_cache_empty(hdev) ||
-				ir.flags & IREQ_CACHE_FLUSH) {
+	    inquiry_cache_empty(hdev) || ir.flags & IREQ_CACHE_FLUSH) {
 		inquiry_cache_flush(hdev);
 		do_inquiry = 1;
 	}
@@ -641,7 +642,7 @@ int hci_inquiry(void __user *arg)
 	if (!copy_to_user(ptr, &ir, sizeof(ir))) {
 		ptr += sizeof(ir);
 		if (copy_to_user(ptr, buf, sizeof(struct inquiry_info) *
-					ir.num_rsp))
+				 ir.num_rsp))
 			err = -EFAULT;
 	} else
 		err = -EFAULT;
@@ -702,11 +703,11 @@ int hci_dev_open(__u16 dev)
 		hdev->init_last_cmd = 0;
 
 		ret = __hci_request(hdev, hci_init_req, 0,
-					msecs_to_jiffies(HCI_INIT_TIMEOUT));
+				    msecs_to_jiffies(HCI_INIT_TIMEOUT));
 
 		if (lmp_host_le_capable(hdev))
 			ret = __hci_request(hdev, hci_le_init_req, 0,
-					msecs_to_jiffies(HCI_INIT_TIMEOUT));
+					    msecs_to_jiffies(HCI_INIT_TIMEOUT));
 
 		clear_bit(HCI_INIT, &hdev->flags);
 	}
@@ -791,10 +792,10 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 	skb_queue_purge(&hdev->cmd_q);
 	atomic_set(&hdev->cmd_cnt, 1);
 	if (!test_bit(HCI_RAW, &hdev->flags) &&
-				test_bit(HCI_QUIRK_NO_RESET, &hdev->quirks)) {
+	    test_bit(HCI_QUIRK_NO_RESET, &hdev->quirks)) {
 		set_bit(HCI_INIT, &hdev->flags);
 		__hci_request(hdev, hci_reset_req, 0,
-					msecs_to_jiffies(250));
+			      msecs_to_jiffies(250));
 		clear_bit(HCI_INIT, &hdev->flags);
 	}
 
@@ -884,7 +885,7 @@ int hci_dev_reset(__u16 dev)
 
 	if (!test_bit(HCI_RAW, &hdev->flags))
 		ret = __hci_request(hdev, hci_reset_req, 0,
-					msecs_to_jiffies(HCI_INIT_TIMEOUT));
+				    msecs_to_jiffies(HCI_INIT_TIMEOUT));
 
 done:
 	hci_req_unlock(hdev);
@@ -924,7 +925,7 @@ int hci_dev_cmd(unsigned int cmd, void __user *arg)
 	switch (cmd) {
 	case HCISETAUTH:
 		err = hci_request(hdev, hci_auth_req, dr.dev_opt,
-					msecs_to_jiffies(HCI_INIT_TIMEOUT));
+				  msecs_to_jiffies(HCI_INIT_TIMEOUT));
 		break;
 
 	case HCISETENCRYPT:
@@ -936,23 +937,23 @@ int hci_dev_cmd(unsigned int cmd, void __user *arg)
 		if (!test_bit(HCI_AUTH, &hdev->flags)) {
 			/* Auth must be enabled first */
 			err = hci_request(hdev, hci_auth_req, dr.dev_opt,
-					msecs_to_jiffies(HCI_INIT_TIMEOUT));
+					  msecs_to_jiffies(HCI_INIT_TIMEOUT));
 			if (err)
 				break;
 		}
 
 		err = hci_request(hdev, hci_encrypt_req, dr.dev_opt,
-					msecs_to_jiffies(HCI_INIT_TIMEOUT));
+				  msecs_to_jiffies(HCI_INIT_TIMEOUT));
 		break;
 
 	case HCISETSCAN:
 		err = hci_request(hdev, hci_scan_req, dr.dev_opt,
-					msecs_to_jiffies(HCI_INIT_TIMEOUT));
+				  msecs_to_jiffies(HCI_INIT_TIMEOUT));
 		break;
 
 	case HCISETLINKPOL:
 		err = hci_request(hdev, hci_linkpol_req, dr.dev_opt,
-					msecs_to_jiffies(HCI_INIT_TIMEOUT));
+				  msecs_to_jiffies(HCI_INIT_TIMEOUT));
 		break;
 
 	case HCISETLINKMODE:
@@ -1103,7 +1104,7 @@ static void hci_power_on(struct work_struct *work)
 
 	if (test_bit(HCI_AUTO_OFF, &hdev->dev_flags))
 		schedule_delayed_work(&hdev->power_off,
-					msecs_to_jiffies(AUTO_OFF_TIMEOUT));
+				      msecs_to_jiffies(AUTO_OFF_TIMEOUT));
 
 	if (test_and_clear_bit(HCI_SETUP, &hdev->dev_flags))
 		mgmt_index_added(hdev);
@@ -1112,7 +1113,7 @@ static void hci_power_on(struct work_struct *work)
 static void hci_power_off(struct work_struct *work)
 {
 	struct hci_dev *hdev = container_of(work, struct hci_dev,
-							power_off.work);
+					    power_off.work);
 
 	BT_DBG("%s", hdev->name);
 
@@ -1193,7 +1194,7 @@ struct link_key *hci_find_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr)
 }
 
 static bool hci_persistent_key(struct hci_dev *hdev, struct hci_conn *conn,
-						u8 key_type, u8 old_key_type)
+			       u8 key_type, u8 old_key_type)
 {
 	/* Legacy key */
 	if (key_type < 0x03)
@@ -1234,7 +1235,7 @@ struct smp_ltk *hci_find_ltk(struct hci_dev *hdev, __le16 ediv, u8 rand[8])
 
 	list_for_each_entry(k, &hdev->long_term_keys, list) {
 		if (k->ediv != ediv ||
-				memcmp(rand, k->rand, sizeof(k->rand)))
+		    memcmp(rand, k->rand, sizeof(k->rand)))
 			continue;
 
 		return k;
@@ -1251,7 +1252,7 @@ struct smp_ltk *hci_find_ltk_by_addr(struct hci_dev *hdev, bdaddr_t *bdaddr,
 
 	list_for_each_entry(k, &hdev->long_term_keys, list)
 		if (addr_type == k->bdaddr_type &&
-					bacmp(bdaddr, &k->bdaddr) == 0)
+		    bacmp(bdaddr, &k->bdaddr) == 0)
 			return k;
 
 	return NULL;
@@ -1283,8 +1284,7 @@ int hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn, int new_key,
 	 * combination key for legacy pairing even when there's no
 	 * previous key */
 	if (type == HCI_LK_CHANGED_COMBINATION &&
-					(!conn || conn->remote_auth == 0xff) &&
-					old_key_type == 0xff) {
+	    (!conn || conn->remote_auth == 0xff) && old_key_type == 0xff) {
 		type = HCI_LK_COMBINATION;
 		if (conn)
 			conn->key_type = type;
@@ -1741,7 +1741,7 @@ int hci_register_dev(struct hci_dev *hdev)
 	write_unlock(&hci_dev_list_lock);
 
 	hdev->workqueue = alloc_workqueue(hdev->name, WQ_HIGHPRI | WQ_UNBOUND |
-							WQ_MEM_RECLAIM, 1);
+					  WQ_MEM_RECLAIM, 1);
 	if (!hdev->workqueue) {
 		error = -ENOMEM;
 		goto err;
@@ -1752,7 +1752,8 @@ int hci_register_dev(struct hci_dev *hdev)
 		goto err_wqueue;
 
 	hdev->rfkill = rfkill_alloc(hdev->name, &hdev->dev,
-				RFKILL_TYPE_BLUETOOTH, &hci_rfkill_ops, hdev);
+				    RFKILL_TYPE_BLUETOOTH, &hci_rfkill_ops,
+				    hdev);
 	if (hdev->rfkill) {
 		if (rfkill_register(hdev->rfkill) < 0) {
 			rfkill_destroy(hdev->rfkill);
@@ -1799,7 +1800,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
 		kfree_skb(hdev->reassembly[i]);
 
 	if (!test_bit(HCI_INIT, &hdev->flags) &&
-				!test_bit(HCI_SETUP, &hdev->dev_flags)) {
+	    !test_bit(HCI_SETUP, &hdev->dev_flags)) {
 		hci_dev_lock(hdev);
 		mgmt_index_removed(hdev);
 		hci_dev_unlock(hdev);
@@ -1853,7 +1854,7 @@ int hci_recv_frame(struct sk_buff *skb)
 {
 	struct hci_dev *hdev = (struct hci_dev *) skb->dev;
 	if (!hdev || (!test_bit(HCI_UP, &hdev->flags)
-				&& !test_bit(HCI_INIT, &hdev->flags))) {
+		      && !test_bit(HCI_INIT, &hdev->flags))) {
 		kfree_skb(skb);
 		return -ENXIO;
 	}
@@ -1872,7 +1873,7 @@ int hci_recv_frame(struct sk_buff *skb)
 EXPORT_SYMBOL(hci_recv_frame);
 
 static int hci_reassembly(struct hci_dev *hdev, int type, void *data,
-						  int count, __u8 index)
+			  int count, __u8 index)
 {
 	int len = 0;
 	int hlen = 0;
@@ -1881,7 +1882,7 @@ static int hci_reassembly(struct hci_dev *hdev, int type, void *data,
 	struct bt_skb_cb *scb;
 
 	if ((type < HCI_ACLDATA_PKT || type > HCI_EVENT_PKT) ||
-				index >= NUM_REASSEMBLY)
+	    index >= NUM_REASSEMBLY)
 		return -EILSEQ;
 
 	skb = hdev->reassembly[index];
@@ -2023,7 +2024,7 @@ int hci_recv_stream_fragment(struct hci_dev *hdev, void *data, int count)
 			type = bt_cb(skb)->pkt_type;
 
 		rem = hci_reassembly(hdev, type, data, count,
-							STREAM_REASSEMBLY);
+				     STREAM_REASSEMBLY);
 		if (rem < 0)
 			return rem;
 
@@ -2157,7 +2158,7 @@ static void hci_add_acl_hdr(struct sk_buff *skb, __u16 handle, __u16 flags)
 }
 
 static void hci_queue_acl(struct hci_conn *conn, struct sk_buff_head *queue,
-				struct sk_buff *skb, __u16 flags)
+			  struct sk_buff *skb, __u16 flags)
 {
 	struct hci_dev *hdev = conn->hdev;
 	struct sk_buff *list;
@@ -2244,7 +2245,8 @@ EXPORT_SYMBOL(hci_send_sco);
 /* ---- HCI TX task (outgoing data) ---- */
 
 /* HCI Connection scheduler */
-static inline struct hci_conn *hci_low_sent(struct hci_dev *hdev, __u8 type, int *quote)
+static inline struct hci_conn *hci_low_sent(struct hci_dev *hdev, __u8 type,
+					    int *quote)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn *conn = NULL, *c;
@@ -2316,7 +2318,7 @@ static inline void hci_link_tx_to(struct hci_dev *hdev, __u8 type)
 	list_for_each_entry_rcu(c, &h->list, list) {
 		if (c->type == type && c->sent) {
 			BT_ERR("%s killing stalled connection %s",
-				hdev->name, batostr(&c->dst));
+			       hdev->name, batostr(&c->dst));
 			hci_acl_disconn(c, 0x13);
 		}
 	}
@@ -2325,7 +2327,7 @@ static inline void hci_link_tx_to(struct hci_dev *hdev, __u8 type)
 }
 
 static inline struct hci_chan *hci_chan_sent(struct hci_dev *hdev, __u8 type,
-						int *quote)
+					     int *quote)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_chan *chan = NULL;
@@ -2442,7 +2444,7 @@ static void hci_prio_recalculate(struct hci_dev *hdev, __u8 type)
 			skb->priority = HCI_PRIO_MAX - 1;
 
 			BT_DBG("chan %p skb %p promoted to %d", chan, skb,
-								skb->priority);
+			       skb->priority);
 		}
 
 		if (hci_conn_num(hdev, type) == num)
@@ -2465,7 +2467,7 @@ static inline void __check_timeout(struct hci_dev *hdev, unsigned int cnt)
 		/* ACL tx timeout must be longer than maximum
 		 * link supervision timeout (40.9 seconds) */
 		if (!cnt && time_after(jiffies, hdev->acl_last_tx +
-					msecs_to_jiffies(HCI_ACL_TX_TIMEOUT)))
+				       msecs_to_jiffies(HCI_ACL_TX_TIMEOUT)))
 			hci_link_tx_to(hdev, ACL_LINK);
 	}
 }
@@ -2480,11 +2482,11 @@ static inline void hci_sched_acl_pkt(struct hci_dev *hdev)
 	__check_timeout(hdev, cnt);
 
 	while (hdev->acl_cnt &&
-			(chan = hci_chan_sent(hdev, ACL_LINK, &quote))) {
+	       (chan = hci_chan_sent(hdev, ACL_LINK, &quote))) {
 		u32 priority = (skb_peek(&chan->data_q))->priority;
 		while (quote-- && (skb = skb_peek(&chan->data_q))) {
 			BT_DBG("chan %p skb %p len %d priority %u", chan, skb,
-					skb->len, skb->priority);
+			       skb->len, skb->priority);
 
 			/* Stop if priority has changed */
 			if (skb->priority < priority)
@@ -2518,13 +2520,13 @@ static inline void hci_sched_acl_blk(struct hci_dev *hdev)
 	__check_timeout(hdev, cnt);
 
 	while (hdev->block_cnt > 0 &&
-			(chan = hci_chan_sent(hdev, ACL_LINK, &quote))) {
+	       (chan = hci_chan_sent(hdev, ACL_LINK, &quote))) {
 		u32 priority = (skb_peek(&chan->data_q))->priority;
 		while (quote > 0 && (skb = skb_peek(&chan->data_q))) {
 			int blocks;
 
 			BT_DBG("chan %p skb %p len %d priority %u", chan, skb,
-						skb->len, skb->priority);
+			       skb->len, skb->priority);
 
 			/* Stop if priority has changed */
 			if (skb->priority < priority)
@@ -2537,7 +2539,7 @@ static inline void hci_sched_acl_blk(struct hci_dev *hdev)
 				return;
 
 			hci_conn_enter_active_mode(chan->conn,
-						bt_cb(skb)->force_active);
+						   bt_cb(skb)->force_active);
 
 			hci_send_frame(skb);
 			hdev->acl_last_tx = jiffies;
@@ -2634,7 +2636,7 @@ static inline void hci_sched_le(struct hci_dev *hdev)
 		/* LE tx timeout must be longer than maximum
 		 * link supervision timeout (40.9 seconds) */
 		if (!hdev->le_cnt && hdev->le_pkts &&
-				time_after(jiffies, hdev->le_last_tx + HZ * 45))
+		    time_after(jiffies, hdev->le_last_tx + HZ * 45))
 			hci_link_tx_to(hdev, LE_LINK);
 	}
 
@@ -2644,7 +2646,7 @@ static inline void hci_sched_le(struct hci_dev *hdev)
 		u32 priority = (skb_peek(&chan->data_q))->priority;
 		while (quote-- && (skb = skb_peek(&chan->data_q))) {
 			BT_DBG("chan %p skb %p len %d priority %u", chan, skb,
-					skb->len, skb->priority);
+			       skb->len, skb->priority);
 
 			/* Stop if priority has changed */
 			if (skb->priority < priority)
@@ -2676,7 +2678,7 @@ static void hci_tx_work(struct work_struct *work)
 	struct sk_buff *skb;
 
 	BT_DBG("%s acl %d sco %d le %d", hdev->name, hdev->acl_cnt,
-		hdev->sco_cnt, hdev->le_cnt);
+	       hdev->sco_cnt, hdev->le_cnt);
 
 	/* Schedule queues and send stuff to HCI driver */
 
@@ -2708,7 +2710,8 @@ static inline void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 	flags  = hci_flags(handle);
 	handle = hci_handle(handle);
 
-	BT_DBG("%s len %d handle 0x%x flags 0x%x", hdev->name, skb->len, handle, flags);
+	BT_DBG("%s len %d handle 0x%x flags 0x%x", hdev->name, skb->len,
+	       handle, flags);
 
 	hdev->stat.acl_rx++;
 
@@ -2732,7 +2735,7 @@ static inline void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 		return;
 	} else {
 		BT_ERR("%s ACL packet for unknown connection handle %d",
-			hdev->name, handle);
+		       hdev->name, handle);
 	}
 
 	kfree_skb(skb);
@@ -2763,7 +2766,7 @@ static inline void hci_scodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 		return;
 	} else {
 		BT_ERR("%s SCO packet for unknown connection handle %d",
-			hdev->name, handle);
+		       hdev->name, handle);
 	}
 
 	kfree_skb(skb);
-- 
1.7.10.1

