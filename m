Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/9] Bluetooth: Add initial mgmt_confirm_name support
Date: Thu,  5 Jan 2012 17:16:17 +0200
Message-Id: <1325776582-10314-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1325776582-10314-1-git-send-email-johan.hedberg@gmail.com>
References: <1325776582-10314-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds initial support for mgmt_confirm_name. It adds the
necessary tracking of the name state by extending the inquiry cache. The
actual name resolving operation (to be done once inquiry is finished) is
not yet part of this patch.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |   29 ++++++++++++++----
 net/bluetooth/hci_core.c         |   58 ++++++++++++++++++++++++++++++-------
 net/bluetooth/hci_event.c        |   51 ++++++++++++++++++++++++++++-----
 net/bluetooth/hci_sysfs.c        |    2 +-
 net/bluetooth/mgmt.c             |   51 ++++++++++++++++++++++++++++++++-
 5 files changed, 163 insertions(+), 28 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 91d1baf..2999b6e 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -44,14 +44,23 @@ struct inquiry_data {
 };
 
 struct inquiry_entry {
-	struct list_head	list;
+	struct list_head	all;		/* inq_cache.all */
+	struct list_head	list;		/* unknown or resolve */
+	enum {
+		NAME_NOT_KNOWN,
+		NAME_NEEDED,
+		NAME_PENDING,
+		NAME_KNOWN,
+	} name_state;
 	__u32			timestamp;
 	struct inquiry_data	data;
 };
 
 struct inquiry_cache {
-	struct list_head	list;
-	__u32			timestamp;
+	struct list_head all;		/* All devices found during inquiry */
+	struct list_head unknown;	/* Name state not known */
+	struct list_head resolve;	/* Name needs to be resolved */
+	__u32		timestamp;
 };
 
 struct hci_conn_hash {
@@ -350,12 +359,14 @@ extern int sco_recv_scodata(struct hci_conn *hcon, struct sk_buff *skb);
 
 static inline void inquiry_cache_init(struct hci_dev *hdev)
 {
-	INIT_LIST_HEAD(&hdev->inq_cache.list);
+	INIT_LIST_HEAD(&hdev->inq_cache.all);
+	INIT_LIST_HEAD(&hdev->inq_cache.unknown);
+	INIT_LIST_HEAD(&hdev->inq_cache.resolve);
 }
 
 static inline int inquiry_cache_empty(struct hci_dev *hdev)
 {
-	return list_empty(&hdev->inq_cache.list);
+	return list_empty(&hdev->inq_cache.all);
 }
 
 static inline long inquiry_cache_age(struct hci_dev *hdev)
@@ -371,7 +382,10 @@ static inline long inquiry_entry_age(struct inquiry_entry *e)
 
 struct inquiry_entry *hci_inquiry_cache_lookup(struct hci_dev *hdev,
 							bdaddr_t *bdaddr);
-void hci_inquiry_cache_update(struct hci_dev *hdev, struct inquiry_data *data);
+struct inquiry_entry *hci_inquiry_cache_lookup_unknown(struct hci_dev *hdev,
+							bdaddr_t *bdaddr);
+void hci_inquiry_cache_update(struct hci_dev *hdev, struct inquiry_data *data,
+							bool name_known);
 
 /* ----- HCI Connections ----- */
 enum {
@@ -913,7 +927,8 @@ int mgmt_set_local_name_complete(struct hci_dev *hdev, u8 *name, u8 status);
 int mgmt_read_local_oob_data_reply_complete(struct hci_dev *hdev, u8 *hash,
 						u8 *randomizer, u8 status);
 int mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
-				u8 addr_type, u8 *dev_class, s8 rssi, u8 *eir);
+					u8 addr_type, u8 *dev_class, s8 rssi,
+					u8 cfm_name, u8 *eir);
 int mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 *name);
 int mgmt_start_discovery_failed(struct hci_dev *hdev, u8 status);
 int mgmt_stop_discovery_failed(struct hci_dev *hdev, u8 status);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 39214e1..9e36fb1 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -357,12 +357,16 @@ struct hci_dev *hci_dev_get(int index)
 /* ---- Inquiry support ---- */
 static void inquiry_cache_flush(struct hci_dev *hdev)
 {
+	struct inquiry_cache *cache = &hdev->inq_cache;
 	struct inquiry_entry *p, *n;
 
-	list_for_each_entry_safe(p, n, &hdev->inq_cache.list, list) {
-		list_del(&p->list);
+	list_for_each_entry_safe(p, n, &cache->all, all) {
+		list_del(&p->all);
 		kfree(p);
 	}
+
+	INIT_LIST_HEAD(&cache->unknown);
+	INIT_LIST_HEAD(&cache->resolve);
 }
 
 struct inquiry_entry *hci_inquiry_cache_lookup(struct hci_dev *hdev, bdaddr_t *bdaddr)
@@ -372,7 +376,7 @@ struct inquiry_entry *hci_inquiry_cache_lookup(struct hci_dev *hdev, bdaddr_t *b
 
 	BT_DBG("cache %p, %s", cache, batostr(bdaddr));
 
-	list_for_each_entry(e, &cache->list, list) {
+	list_for_each_entry(e, &cache->all, all) {
 		if (!bacmp(&e->data.bdaddr, bdaddr))
 			return e;
 	}
@@ -380,7 +384,24 @@ struct inquiry_entry *hci_inquiry_cache_lookup(struct hci_dev *hdev, bdaddr_t *b
 	return NULL;
 }
 
-void hci_inquiry_cache_update(struct hci_dev *hdev, struct inquiry_data *data)
+struct inquiry_entry *hci_inquiry_cache_lookup_unknown(struct hci_dev *hdev,
+							bdaddr_t *bdaddr)
+{
+	struct inquiry_cache *cache = &hdev->inq_cache;
+	struct inquiry_entry *e;
+
+	BT_DBG("cache %p, %s", cache, batostr(bdaddr));
+
+	list_for_each_entry(e, &cache->unknown, list) {
+		if (!bacmp(&e->data.bdaddr, bdaddr))
+			return e;
+	}
+
+	return NULL;
+}
+
+void hci_inquiry_cache_update(struct hci_dev *hdev, struct inquiry_data *data,
+							bool name_known)
 {
 	struct inquiry_cache *cache = &hdev->inq_cache;
 	struct inquiry_entry *ie;
@@ -388,13 +409,28 @@ void hci_inquiry_cache_update(struct hci_dev *hdev, struct inquiry_data *data)
 	BT_DBG("cache %p, %s", cache, batostr(&data->bdaddr));
 
 	ie = hci_inquiry_cache_lookup(hdev, &data->bdaddr);
-	if (!ie) {
-		/* Entry not in the cache. Add new one. */
-		ie = kzalloc(sizeof(struct inquiry_entry), GFP_ATOMIC);
-		if (!ie)
-			return;
+	if (ie)
+		goto update;
+
+	/* Entry not in the cache. Add new one. */
+	ie = kzalloc(sizeof(struct inquiry_entry), GFP_ATOMIC);
+	if (!ie)
+		return;
+
+	list_add(&ie->all, &cache->all);
+
+	if (name_known) {
+		ie->name_state = NAME_KNOWN;
+	} else {
+		ie->name_state = NAME_NOT_KNOWN;
+		list_add(&ie->list, &cache->unknown);
+	}
 
-		list_add(&ie->list, &cache->list);
+update:
+	if (name_known && ie->name_state != NAME_KNOWN &&
+					ie->name_state != NAME_PENDING) {
+		ie->name_state = NAME_KNOWN;
+		list_del(&ie->list);
 	}
 
 	memcpy(&ie->data, data, sizeof(*data));
@@ -409,7 +445,7 @@ static int inquiry_cache_dump(struct hci_dev *hdev, int num, __u8 *buf)
 	struct inquiry_entry *e;
 	int copied = 0;
 
-	list_for_each_entry(e, &cache->list, list) {
+	list_for_each_entry(e, &cache->all, all) {
 		struct inquiry_data *data = &e->data;
 
 		if (copied >= num)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index d37f5b2..abcdadf 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1533,9 +1533,9 @@ static inline void hci_inquiry_result_evt(struct hci_dev *hdev, struct sk_buff *
 		data.clock_offset	= info->clock_offset;
 		data.rssi		= 0x00;
 		data.ssp_mode		= 0x00;
-		hci_inquiry_cache_update(hdev, &data);
+		hci_inquiry_cache_update(hdev, &data, false);
 		mgmt_device_found(hdev, &info->bdaddr, ACL_LINK, 0x00,
-						info->dev_class, 0, NULL);
+						info->dev_class, 0, 1, NULL);
 	}
 
 	hci_dev_unlock(hdev);
@@ -2572,10 +2572,10 @@ static inline void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev, struct
 			data.clock_offset	= info->clock_offset;
 			data.rssi		= info->rssi;
 			data.ssp_mode		= 0x00;
-			hci_inquiry_cache_update(hdev, &data);
+			hci_inquiry_cache_update(hdev, &data, false);
 			mgmt_device_found(hdev, &info->bdaddr, ACL_LINK, 0x00,
 						info->dev_class, info->rssi,
-						NULL);
+						1, NULL);
 		}
 	} else {
 		struct inquiry_info_with_rssi *info = (void *) (skb->data + 1);
@@ -2589,10 +2589,10 @@ static inline void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev, struct
 			data.clock_offset	= info->clock_offset;
 			data.rssi		= info->rssi;
 			data.ssp_mode		= 0x00;
-			hci_inquiry_cache_update(hdev, &data);
+			hci_inquiry_cache_update(hdev, &data, false);
 			mgmt_device_found(hdev, &info->bdaddr, ACL_LINK, 0x00,
 						info->dev_class, info->rssi,
-						NULL);
+						1, NULL);
 		}
 	}
 
@@ -2710,6 +2710,31 @@ static inline void hci_sniff_subrate_evt(struct hci_dev *hdev, struct sk_buff *s
 	BT_DBG("%s status %d", hdev->name, ev->status);
 }
 
+static inline bool eir_has_complete_name(u8 *data, size_t data_len)
+{
+	u8 field_len;
+	size_t parsed;
+
+	for (parsed = 0; parsed < data_len - 1; parsed += field_len) {
+		field_len = data[0];
+
+		if (field_len == 0)
+			break;
+
+		parsed += field_len + 1;
+
+		if (parsed > data_len)
+			break;
+
+		if (data[1] == EIR_NAME_COMPLETE)
+			return true;
+
+		data += field_len + 1;
+	}
+
+	return false;
+}
+
 static inline void hci_extended_inquiry_result_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct inquiry_data data;
@@ -2724,6 +2749,8 @@ static inline void hci_extended_inquiry_result_evt(struct hci_dev *hdev, struct
 	hci_dev_lock(hdev);
 
 	for (; num_rsp; num_rsp--, info++) {
+		bool name_known;
+
 		bacpy(&data.bdaddr, &info->bdaddr);
 		data.pscan_rep_mode	= info->pscan_rep_mode;
 		data.pscan_period_mode	= info->pscan_period_mode;
@@ -2732,9 +2759,17 @@ static inline void hci_extended_inquiry_result_evt(struct hci_dev *hdev, struct
 		data.clock_offset	= info->clock_offset;
 		data.rssi		= info->rssi;
 		data.ssp_mode		= 0x01;
-		hci_inquiry_cache_update(hdev, &data);
+
+		if (test_bit(HCI_MGMT, &hdev->flags))
+			name_known = eir_has_complete_name(info->data,
+							sizeof(info->data));
+		else
+			name_known = true;
+
+		hci_inquiry_cache_update(hdev, &data, name_known);
 		mgmt_device_found(hdev, &info->bdaddr, ACL_LINK, 0x00,
-				info->dev_class, info->rssi, info->data);
+						info->dev_class, info->rssi,
+						!name_known, info->data);
 	}
 
 	hci_dev_unlock(hdev);
diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index ed9ccee..3600d78 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -388,7 +388,7 @@ static int inquiry_cache_show(struct seq_file *f, void *p)
 
 	hci_dev_lock(hdev);
 
-	list_for_each_entry(e, &cache->list, list) {
+	list_for_each_entry(e, &cache->all, all) {
 		struct inquiry_data *data = &e->data;
 		seq_printf(f, "%s %d %d %d 0x%.2x%.2x%.2x 0x%.4x %d %d %u\n",
 			   batostr(&data->bdaddr),
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 851cb19..3977511 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1967,6 +1967,50 @@ failed:
 	return err;
 }
 
+static int confirm_name(struct sock *sk, u16 index, unsigned char *data,
+								u16 len)
+{
+	struct mgmt_cp_confirm_name *cp = (void *) data;
+	struct inquiry_entry *e;
+	struct hci_dev *hdev;
+	int err;
+
+	BT_DBG("hci%u", index);
+
+	if (len != sizeof(*cp))
+		return cmd_status(sk, index, MGMT_OP_CONFIRM_NAME,
+				MGMT_STATUS_INVALID_PARAMS);
+
+	hdev = hci_dev_get(index);
+	if (!hdev)
+		return cmd_status(sk, index, MGMT_OP_CONFIRM_NAME,
+				MGMT_STATUS_INVALID_PARAMS);
+
+	hci_dev_lock(hdev);
+
+	e = hci_inquiry_cache_lookup_unknown(hdev, &cp->bdaddr);
+	if (!e) {
+		err = cmd_status (sk, index, MGMT_OP_CONFIRM_NAME,
+				MGMT_STATUS_INVALID_PARAMS);
+		goto failed;
+	}
+
+	if (cp->name_known) {
+		e->name_state = NAME_KNOWN;
+		list_del(&e->list);
+	} else {
+		e->name_state = NAME_NEEDED;
+		list_move(&e->list, &hdev->inq_cache.resolve);
+	}
+
+	err = 0;
+
+failed:
+	hci_dev_unlock(hdev);
+
+	return err;
+}
+
 static int block_device(struct sock *sk, u16 index, unsigned char *data,
 								u16 len)
 {
@@ -2215,6 +2259,9 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 	case MGMT_OP_STOP_DISCOVERY:
 		err = stop_discovery(sk, index);
 		break;
+	case MGMT_OP_CONFIRM_NAME:
+		err = confirm_name(sk, index, buf + sizeof(*hdr), len);
+		break;
 	case MGMT_OP_BLOCK_DEVICE:
 		err = block_device(sk, index, buf + sizeof(*hdr), len);
 		break;
@@ -2689,7 +2736,8 @@ int mgmt_read_local_oob_data_reply_complete(struct hci_dev *hdev, u8 *hash,
 }
 
 int mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
-				u8 addr_type, u8 *dev_class, s8 rssi, u8 *eir)
+				u8 addr_type, u8 *dev_class, s8 rssi,
+				u8 cfm_name, u8 *eir)
 {
 	struct mgmt_ev_device_found ev;
 
@@ -2698,6 +2746,7 @@ int mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 	bacpy(&ev.addr.bdaddr, bdaddr);
 	ev.addr.type = link_to_mgmt(link_type, addr_type);
 	ev.rssi = rssi;
+	ev.confirm_name = cfm_name;
 
 	if (eir)
 		memcpy(ev.eir, eir, sizeof(ev.eir));
-- 
1.7.7.3

