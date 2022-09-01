Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DFAECAAD1
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Sep 2022 19:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbiIATTh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Sep 2022 15:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233750AbiIATTc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Sep 2022 15:19:32 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90097C1E4
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Sep 2022 12:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662059969; x=1693595969;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tArTgXlWYF2g+L46BzaGrd5ZCTilQ/QQ0Ts7tniSlZ4=;
  b=VZG93i6hLdnf2cUvbO2x0CYgLisH5BqkrAbZr2skJxg8Mb4UR9Vb2Gaz
   jPiL/HdK6t1M7IVfUoWqDmcjfFfMOMdfWBCE7jhESx4BEuvD4v3PUfPZz
   qIS7rzpllvazvk8HA2zj8yUkNT2M5OaN4nKG4IKMwXpWxr8/TlKfB3gQU
   w65uDkaDkJzEL+QH9/8lsyZNY2cLFCIT9TTPQjClOmYh2qq5Mq+5vzx9M
   Nprtn6a7p7A3vAPa42RZR42wSLK23H/BoGjDt7cdNjklx1+ybTxsX5MlQ
   ZuMChH6eL2Xf7fwMdHi7x0OKQF9ji08kv2rWc/fgRIt0xQlu8qgqGqh14
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="296590698"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="296590698"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 12:19:28 -0700
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="674007693"
Received: from ghonawax-mobl.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.212.58.197])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 12:19:28 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH v7 1/2] Bluetooth: Implement support for Mesh
Date:   Thu,  1 Sep 2022 12:19:13 -0700
Message-Id: <20220901191914.22706-2-brian.gix@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220901191914.22706-1-brian.gix@intel.com>
References: <20220901191914.22706-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The patch adds state bits, storage and HCI command chains for sending
and receiving Bluetooth Mesh advertising packets, and delivery to
requesting user space processes. It specifically creates 4 new MGMT
commands and 2 new MGMT events:

MGMT_OP_SET_MESH_RECEIVER - Sets passive scan parameters and a list of
AD Types which will trigger Mesh Packet Received events

MGMT_OP_MESH_READ_FEATURES - Returns information on how many outbound
Mesh packets can be simultaneously queued, and what the currently queued
handles are.

MGMT_OP_MESH_SEND - Command to queue a specific outbound Mesh packet,
with the number of times it should be sent, and the BD Addr to use.
Discrete advertisments are added to the ADV Instance list.

MGMT_OP_MESH_SEND_CANCEL - Command to cancel a prior outbound message
request.

MGMT_EV_MESH_DEVICE_FOUND - Event to deliver entire received Mesh
Advertisement packet, along with timing information.

MGMT_EV_MESH_PACKET_CMPLT - Event to indicate that an outbound packet is
no longer queued for delivery.

Signed-off-by: Brian Gix <brian.gix@intel.com>
---
 include/net/bluetooth/bluetooth.h |   1 +
 include/net/bluetooth/hci.h       |   3 +
 include/net/bluetooth/hci_core.h  |  16 +-
 include/net/bluetooth/mgmt.h      |  52 ++++
 net/bluetooth/hci_core.c          |  13 +-
 net/bluetooth/hci_event.c         |  61 ++--
 net/bluetooth/hci_sock.c          |   1 +
 net/bluetooth/hci_sync.c          |  87 +++++-
 net/bluetooth/mgmt.c              | 480 +++++++++++++++++++++++++++++-
 net/bluetooth/mgmt_util.c         |  74 +++++
 net/bluetooth/mgmt_util.h         |  18 ++
 11 files changed, 760 insertions(+), 46 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index e72f3b247b5e..bcc5a4cd2c17 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -627,6 +627,7 @@ static inline bool iso_enabled(void)
 
 int mgmt_init(void);
 void mgmt_exit(void);
+void mgmt_cleanup(struct sock *sk);
 
 void bt_sock_reclassify_lock(struct sock *sk, int proto);
 
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index cf29511b25a8..b3ade687531f 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -354,6 +354,9 @@ enum {
 	HCI_LE_SIMULTANEOUS_ROLES,
 	HCI_CMD_DRAIN_WORKQUEUE,
 
+	HCI_MESH,
+	HCI_MESH_SENDING,
+
 	__HCI_NUM_FLAGS,
 };
 
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index e7862903187d..258f8d15e7bc 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -238,6 +238,7 @@ struct adv_info {
 	bool	enabled;
 	bool	pending;
 	bool	periodic;
+	__u8	mesh;
 	__u8	instance;
 	__u32	flags;
 	__u16	timeout;
@@ -372,6 +373,8 @@ struct hci_dev {
 	__u8		le_resolv_list_size;
 	__u8		le_num_of_adv_sets;
 	__u8		le_states[8];
+	__u8		mesh_ad_types[16];
+	__u8		mesh_send_ref;
 	__u8		commands[64];
 	__u8		hci_ver;
 	__u16		hci_rev;
@@ -511,6 +514,7 @@ struct hci_dev {
 	struct list_head	cmd_sync_work_list;
 	struct mutex		cmd_sync_work_lock;
 	struct work_struct	cmd_sync_cancel_work;
+	struct work_struct	reenable_adv_work;
 
 	__u16			discov_timeout;
 	struct delayed_work	discov_off;
@@ -561,6 +565,7 @@ struct hci_dev {
 
 	struct hci_conn_hash	conn_hash;
 
+	struct list_head	mesh_pending;
 	struct list_head	mgmt_pending;
 	struct list_head	reject_list;
 	struct list_head	accept_list;
@@ -614,6 +619,8 @@ struct hci_dev {
 	struct delayed_work	rpa_expired;
 	bdaddr_t		rpa;
 
+	struct delayed_work	mesh_send_done;
+
 	enum {
 		INTERLEAVE_SCAN_NONE,
 		INTERLEAVE_SCAN_NO_FILTER,
@@ -1576,7 +1583,8 @@ struct adv_info *hci_add_adv_instance(struct hci_dev *hdev, u8 instance,
 				      u32 flags, u16 adv_data_len, u8 *adv_data,
 				      u16 scan_rsp_len, u8 *scan_rsp_data,
 				      u16 timeout, u16 duration, s8 tx_power,
-				      u32 min_interval, u32 max_interval);
+				      u32 min_interval, u32 max_interval,
+				      u8 mesh_handle);
 struct adv_info *hci_add_per_instance(struct hci_dev *hdev, u8 instance,
 				      u32 flags, u8 data_len, u8 *data,
 				      u32 min_interval, u32 max_interval);
@@ -1997,6 +2005,9 @@ void hci_mgmt_chan_unregister(struct hci_mgmt_chan *c);
 #define DISCOV_LE_FAST_ADV_INT_MAX	0x00F0	/* 150 msec */
 #define DISCOV_LE_PER_ADV_INT_MIN	0x00A0	/* 200 msec */
 #define DISCOV_LE_PER_ADV_INT_MAX	0x00A0	/* 200 msec */
+#define DISCOV_LE_ADV_MESH_MIN		0x00A0  /* 100 msec */
+#define DISCOV_LE_ADV_MESH_MAX		0x00A0  /* 100 msec */
+#define INTERVAL_TO_MS(x)		(((x) * 10) / 0x10)
 
 #define NAME_RESOLVE_DURATION		msecs_to_jiffies(10240)	/* 10.24 sec */
 
@@ -2048,7 +2059,8 @@ void mgmt_start_discovery_complete(struct hci_dev *hdev, u8 status);
 void mgmt_stop_discovery_complete(struct hci_dev *hdev, u8 status);
 void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		       u8 addr_type, u8 *dev_class, s8 rssi, u32 flags,
-		       u8 *eir, u16 eir_len, u8 *scan_rsp, u8 scan_rsp_len);
+		       u8 *eir, u16 eir_len, u8 *scan_rsp, u8 scan_rsp_len,
+		       u64 instant);
 void mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		      u8 addr_type, s8 rssi, u8 *name, u8 name_len);
 void mgmt_discovering(struct hci_dev *hdev, u8 discovering);
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 7c1ad0f6fcec..743f6f59dff8 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -837,6 +837,42 @@ struct mgmt_cp_add_adv_patterns_monitor_rssi {
 	struct mgmt_adv_pattern patterns[];
 } __packed;
 #define MGMT_ADD_ADV_PATTERNS_MONITOR_RSSI_SIZE	8
+#define MGMT_OP_SET_MESH_RECEIVER		0x0057
+struct mgmt_cp_set_mesh {
+	__u8   enable;
+	__le16 window;
+	__le16 period;
+	__u8   num_ad_types;
+	__u8   ad_types[];
+} __packed;
+#define MGMT_SET_MESH_RECEIVER_SIZE	6
+
+#define MGMT_OP_MESH_READ_FEATURES	0x0058
+#define MGMT_MESH_READ_FEATURES_SIZE	0
+#define MESH_HANDLES_MAX	3
+struct mgmt_rp_mesh_read_features {
+	__le16	index;
+	__u8   max_handles;
+	__u8   used_handles;
+	__u8   handles[MESH_HANDLES_MAX];
+} __packed;
+
+#define MGMT_OP_MESH_SEND		0x0059
+struct mgmt_cp_mesh_send {
+	struct mgmt_addr_info addr;
+	__le64  instant;
+	__le16  delay;
+	__u8   cnt;
+	__u8   adv_data_len;
+	__u8   adv_data[];
+} __packed;
+#define MGMT_MESH_SEND_SIZE		19
+
+#define MGMT_OP_MESH_SEND_CANCEL	0x005A
+struct mgmt_cp_mesh_send_cancel {
+	__u8  handle;
+} __packed;
+#define MGMT_MESH_SEND_CANCEL_SIZE	1
 
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
@@ -1120,3 +1156,19 @@ struct mgmt_ev_adv_monitor_device_lost {
 	__le16 monitor_handle;
 	struct mgmt_addr_info addr;
 } __packed;
+
+#define MGMT_EV_MESH_DEVICE_FOUND	0x0031
+struct mgmt_ev_mesh_device_found {
+	struct mgmt_addr_info addr;
+	__s8	rssi;
+	__le64	instant;
+	__le32	flags;
+	__le16	eir_len;
+	__u8	eir[];
+} __packed;
+
+
+#define MGMT_EV_MESH_PACKET_CMPLT		0x0032
+struct mgmt_ev_mesh_pkt_cmplt {
+	__u8	handle;
+} __packed;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 9d2c33f6b065..3803e54f23c0 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1706,7 +1706,8 @@ struct adv_info *hci_add_adv_instance(struct hci_dev *hdev, u8 instance,
 				      u32 flags, u16 adv_data_len, u8 *adv_data,
 				      u16 scan_rsp_len, u8 *scan_rsp_data,
 				      u16 timeout, u16 duration, s8 tx_power,
-				      u32 min_interval, u32 max_interval)
+				      u32 min_interval, u32 max_interval,
+				      u8 mesh_handle)
 {
 	struct adv_info *adv;
 
@@ -1717,7 +1718,7 @@ struct adv_info *hci_add_adv_instance(struct hci_dev *hdev, u8 instance,
 		memset(adv->per_adv_data, 0, sizeof(adv->per_adv_data));
 	} else {
 		if (hdev->adv_instance_cnt >= hdev->le_num_of_adv_sets ||
-		    instance < 1 || instance > hdev->le_num_of_adv_sets)
+		    instance < 1 || instance > hdev->le_num_of_adv_sets + 1)
 			return ERR_PTR(-EOVERFLOW);
 
 		adv = kzalloc(sizeof(*adv), GFP_KERNEL);
@@ -1734,6 +1735,11 @@ struct adv_info *hci_add_adv_instance(struct hci_dev *hdev, u8 instance,
 	adv->min_interval = min_interval;
 	adv->max_interval = max_interval;
 	adv->tx_power = tx_power;
+	/* Defining a mesh_handle changes the timing units to ms,
+	 * rather than seconds, and ties the instance to the requested
+	 * mesh_tx queue.
+	 */
+	adv->mesh = mesh_handle;
 
 	hci_set_adv_instance_data(hdev, instance, adv_data_len, adv_data,
 				  scan_rsp_len, scan_rsp_data);
@@ -1762,7 +1768,7 @@ struct adv_info *hci_add_per_instance(struct hci_dev *hdev, u8 instance,
 
 	adv = hci_add_adv_instance(hdev, instance, flags, 0, NULL, 0, NULL,
 				   0, 0, HCI_ADV_TX_POWER_NO_PREFERENCE,
-				   min_interval, max_interval);
+				   min_interval, max_interval, 0);
 	if (IS_ERR(adv))
 		return adv;
 
@@ -2486,6 +2492,7 @@ struct hci_dev *hci_alloc_dev_priv(int sizeof_priv)
 	mutex_init(&hdev->lock);
 	mutex_init(&hdev->req_lock);
 
+	INIT_LIST_HEAD(&hdev->mesh_pending);
 	INIT_LIST_HEAD(&hdev->mgmt_pending);
 	INIT_LIST_HEAD(&hdev->reject_list);
 	INIT_LIST_HEAD(&hdev->accept_list);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 1906822a061b..de79b66ee6db 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1715,6 +1715,8 @@ static void le_set_scan_enable_complete(struct hci_dev *hdev, u8 enable)
 		hci_dev_set_flag(hdev, HCI_LE_SCAN);
 		if (hdev->le_scan_type == LE_SCAN_ACTIVE)
 			clear_pending_adv_report(hdev);
+		if (hci_dev_test_flag(hdev, HCI_MESH))
+			hci_discovery_set_state(hdev, DISCOVERY_FINDING);
 		break;
 
 	case LE_SCAN_DISABLE:
@@ -1729,7 +1731,7 @@ static void le_set_scan_enable_complete(struct hci_dev *hdev, u8 enable)
 					  d->last_adv_addr_type, NULL,
 					  d->last_adv_rssi, d->last_adv_flags,
 					  d->last_adv_data,
-					  d->last_adv_data_len, NULL, 0);
+					  d->last_adv_data_len, NULL, 0, 0);
 		}
 
 		/* Cancel this timer so that we don't try to disable scanning
@@ -1745,6 +1747,9 @@ static void le_set_scan_enable_complete(struct hci_dev *hdev, u8 enable)
 		 */
 		if (hci_dev_test_and_clear_flag(hdev, HCI_LE_SCAN_INTERRUPTED))
 			hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
+		else if (!hci_dev_test_flag(hdev, HCI_LE_ADV) &&
+			 hdev->discovery.state == DISCOVERY_FINDING)
+			queue_work(hdev->workqueue, &hdev->reenable_adv_work);
 
 		break;
 
@@ -3071,7 +3076,7 @@ static void hci_inquiry_result_evt(struct hci_dev *hdev, void *edata,
 
 		mgmt_device_found(hdev, &info->bdaddr, ACL_LINK, 0x00,
 				  info->dev_class, HCI_RSSI_INVALID,
-				  flags, NULL, 0, NULL, 0);
+				  flags, NULL, 0, NULL, 0, 0);
 	}
 
 	hci_dev_unlock(hdev);
@@ -4829,7 +4834,7 @@ static void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev, void *edata,
 
 			mgmt_device_found(hdev, &info->bdaddr, ACL_LINK, 0x00,
 					  info->dev_class, info->rssi,
-					  flags, NULL, 0, NULL, 0);
+					  flags, NULL, 0, NULL, 0, 0);
 		}
 	} else if (skb->len == array_size(ev->num,
 					  sizeof(struct inquiry_info_rssi))) {
@@ -4860,7 +4865,7 @@ static void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev, void *edata,
 
 			mgmt_device_found(hdev, &info->bdaddr, ACL_LINK, 0x00,
 					  info->dev_class, info->rssi,
-					  flags, NULL, 0, NULL, 0);
+					  flags, NULL, 0, NULL, 0, 0);
 		}
 	} else {
 		bt_dev_err(hdev, "Malformed HCI Event: 0x%2.2x",
@@ -5116,7 +5121,7 @@ static void hci_extended_inquiry_result_evt(struct hci_dev *hdev, void *edata,
 
 		mgmt_device_found(hdev, &info->bdaddr, ACL_LINK, 0x00,
 				  info->dev_class, info->rssi,
-				  flags, info->data, eir_len, NULL, 0);
+				  flags, info->data, eir_len, NULL, 0, 0);
 	}
 
 	hci_dev_unlock(hdev);
@@ -6172,7 +6177,7 @@ static struct hci_conn *check_pending_le_conn(struct hci_dev *hdev,
 static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 			       u8 bdaddr_type, bdaddr_t *direct_addr,
 			       u8 direct_addr_type, s8 rssi, u8 *data, u8 len,
-			       bool ext_adv)
+			       bool ext_adv, bool ctl_time, u64 instant)
 {
 	struct discovery_state *d = &hdev->discovery;
 	struct smp_irk *irk;
@@ -6220,7 +6225,7 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 	 * important to see if the address is matching the local
 	 * controller address.
 	 */
-	if (direct_addr) {
+	if (!hci_dev_test_flag(hdev, HCI_MESH) && direct_addr) {
 		direct_addr_type = ev_bdaddr_type(hdev, direct_addr_type,
 						  &bdaddr_resolved);
 
@@ -6268,6 +6273,18 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 		conn->le_adv_data_len = len;
 	}
 
+	if (type == LE_ADV_NONCONN_IND || type == LE_ADV_SCAN_IND)
+		flags = MGMT_DEV_FOUND_NOT_CONNECTABLE;
+	else
+		flags = 0;
+
+	/* All scan results should be sent up for Mesh systems */
+	if (hci_dev_test_flag(hdev, HCI_MESH)) {
+		mgmt_device_found(hdev, bdaddr, LE_LINK, bdaddr_type, NULL,
+				  rssi, flags, data, len, NULL, 0, instant);
+		return;
+	}
+
 	/* Passive scanning shouldn't trigger any device found events,
 	 * except for devices marked as CONN_REPORT for which we do send
 	 * device found events, or advertisement monitoring requested.
@@ -6281,12 +6298,8 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 		    idr_is_empty(&hdev->adv_monitors_idr))
 			return;
 
-		if (type == LE_ADV_NONCONN_IND || type == LE_ADV_SCAN_IND)
-			flags = MGMT_DEV_FOUND_NOT_CONNECTABLE;
-		else
-			flags = 0;
 		mgmt_device_found(hdev, bdaddr, LE_LINK, bdaddr_type, NULL,
-				  rssi, flags, data, len, NULL, 0);
+				  rssi, flags, data, len, NULL, 0, 0);
 		return;
 	}
 
@@ -6305,11 +6318,8 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 	 * and just sends a scan response event, then it is marked as
 	 * not connectable as well.
 	 */
-	if (type == LE_ADV_NONCONN_IND || type == LE_ADV_SCAN_IND ||
-	    type == LE_ADV_SCAN_RSP)
+	if (type == LE_ADV_SCAN_RSP)
 		flags = MGMT_DEV_FOUND_NOT_CONNECTABLE;
-	else
-		flags = 0;
 
 	/* If there's nothing pending either store the data from this
 	 * event or send an immediate device found event if the data
@@ -6326,7 +6336,7 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 		}
 
 		mgmt_device_found(hdev, bdaddr, LE_LINK, bdaddr_type, NULL,
-				  rssi, flags, data, len, NULL, 0);
+				  rssi, flags, data, len, NULL, 0, 0);
 		return;
 	}
 
@@ -6345,7 +6355,7 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 					  d->last_adv_addr_type, NULL,
 					  d->last_adv_rssi, d->last_adv_flags,
 					  d->last_adv_data,
-					  d->last_adv_data_len, NULL, 0);
+					  d->last_adv_data_len, NULL, 0, 0);
 
 		/* If the new report will trigger a SCAN_REQ store it for
 		 * later merging.
@@ -6362,7 +6372,7 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 		 */
 		clear_pending_adv_report(hdev);
 		mgmt_device_found(hdev, bdaddr, LE_LINK, bdaddr_type, NULL,
-				  rssi, flags, data, len, NULL, 0);
+				  rssi, flags, data, len, NULL, 0, 0);
 		return;
 	}
 
@@ -6372,7 +6382,7 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 	 */
 	mgmt_device_found(hdev, &d->last_adv_addr, LE_LINK,
 			  d->last_adv_addr_type, NULL, rssi, d->last_adv_flags,
-			  d->last_adv_data, d->last_adv_data_len, data, len);
+			  d->last_adv_data, d->last_adv_data_len, data, len, 0);
 	clear_pending_adv_report(hdev);
 }
 
@@ -6380,6 +6390,7 @@ static void hci_le_adv_report_evt(struct hci_dev *hdev, void *data,
 				  struct sk_buff *skb)
 {
 	struct hci_ev_le_advertising_report *ev = data;
+	u64 instant = jiffies;
 
 	if (!ev->num)
 		return;
@@ -6404,7 +6415,8 @@ static void hci_le_adv_report_evt(struct hci_dev *hdev, void *data,
 			rssi = info->data[info->length];
 			process_adv_report(hdev, info->type, &info->bdaddr,
 					   info->bdaddr_type, NULL, 0, rssi,
-					   info->data, info->length, false);
+					   info->data, info->length, false,
+					   false, instant);
 		} else {
 			bt_dev_err(hdev, "Dropping invalid advertising data");
 		}
@@ -6461,6 +6473,7 @@ static void hci_le_ext_adv_report_evt(struct hci_dev *hdev, void *data,
 				      struct sk_buff *skb)
 {
 	struct hci_ev_le_ext_adv_report *ev = data;
+	u64 instant = jiffies;
 
 	if (!ev->num)
 		return;
@@ -6487,7 +6500,8 @@ static void hci_le_ext_adv_report_evt(struct hci_dev *hdev, void *data,
 			process_adv_report(hdev, legacy_evt_type, &info->bdaddr,
 					   info->bdaddr_type, NULL, 0,
 					   info->rssi, info->data, info->length,
-					   !(evt_type & LE_EXT_ADV_LEGACY_PDU));
+					   !(evt_type & LE_EXT_ADV_LEGACY_PDU),
+					   false, instant);
 		}
 	}
 
@@ -6710,6 +6724,7 @@ static void hci_le_direct_adv_report_evt(struct hci_dev *hdev, void *data,
 					 struct sk_buff *skb)
 {
 	struct hci_ev_le_direct_adv_report *ev = data;
+	u64 instant = jiffies;
 	int i;
 
 	if (!hci_le_ev_skb_pull(hdev, skb, HCI_EV_LE_DIRECT_ADV_REPORT,
@@ -6727,7 +6742,7 @@ static void hci_le_direct_adv_report_evt(struct hci_dev *hdev, void *data,
 		process_adv_report(hdev, info->type, &info->bdaddr,
 				   info->bdaddr_type, &info->direct_addr,
 				   info->direct_addr_type, info->rssi, NULL, 0,
-				   false);
+				   false, false, instant);
 	}
 
 	hci_dev_unlock(hdev);
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 0d015d4a8e41..b2a33a05c93e 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -2065,6 +2065,7 @@ static int hci_sock_getsockopt(struct socket *sock, int level, int optname,
 
 static void hci_sock_destruct(struct sock *sk)
 {
+	mgmt_cleanup(sk);
 	skb_queue_purge(&sk->sk_receive_queue);
 	skb_queue_purge(&sk->sk_write_queue);
 }
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index e08c0503027d..fa433896ddc7 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -246,7 +246,7 @@ int __hci_cmd_sync_status_sk(struct hci_dev *hdev, u16 opcode, u32 plen,
 	skb = __hci_cmd_sync_sk(hdev, opcode, plen, param, event, timeout, sk);
 	if (IS_ERR(skb)) {
 		bt_dev_err(hdev, "Opcode 0x%4x failed: %ld", opcode,
-			   PTR_ERR(skb));
+				PTR_ERR(skb));
 		return PTR_ERR(skb);
 	}
 
@@ -465,6 +465,48 @@ static void le_scan_restart(struct work_struct *work)
 	hci_dev_unlock(hdev);
 }
 
+static int reenable_adv_sync(struct hci_dev *hdev, void *data)
+{
+	bt_dev_dbg(hdev, "");
+
+	if (!hci_dev_test_flag(hdev, HCI_ADVERTISING) &&
+	    list_empty(&hdev->adv_instances))
+		return 0;
+
+	if (hdev->cur_adv_instance) {
+		return hci_schedule_adv_instance_sync(hdev,
+						      hdev->cur_adv_instance,
+						      true);
+	} else {
+		if (ext_adv_capable(hdev)) {
+			hci_start_ext_adv_sync(hdev, 0x00);
+		} else {
+			hci_update_adv_data_sync(hdev, 0x00);
+			hci_update_scan_rsp_data_sync(hdev, 0x00);
+			hci_enable_advertising_sync(hdev);
+		}
+	}
+
+	return 0;
+}
+
+static void reenable_adv(struct work_struct *work)
+{
+	struct hci_dev *hdev = container_of(work, struct hci_dev,
+					    reenable_adv_work);
+	int status;
+
+	bt_dev_dbg(hdev, "");
+
+	hci_dev_lock(hdev);
+
+	status = hci_cmd_sync_queue(hdev, reenable_adv_sync, NULL, NULL);
+	if (status)
+		bt_dev_err(hdev, "failed to reenable ADV: %d", status);
+
+	hci_dev_unlock(hdev);
+}
+
 static void cancel_adv_timeout(struct hci_dev *hdev)
 {
 	if (hdev->adv_instance_timeout) {
@@ -587,6 +629,7 @@ void hci_cmd_sync_init(struct hci_dev *hdev)
 	mutex_init(&hdev->cmd_sync_work_lock);
 
 	INIT_WORK(&hdev->cmd_sync_cancel_work, hci_cmd_sync_cancel_work);
+	INIT_WORK(&hdev->reenable_adv_work, reenable_adv);
 	INIT_DELAYED_WORK(&hdev->le_scan_disable, le_scan_disable);
 	INIT_DELAYED_WORK(&hdev->le_scan_restart, le_scan_restart);
 	INIT_DELAYED_WORK(&hdev->adv_instance_expire, adv_timeout_expire);
@@ -597,6 +640,7 @@ void hci_cmd_sync_clear(struct hci_dev *hdev)
 	struct hci_cmd_sync_work_entry *entry, *tmp;
 
 	cancel_work_sync(&hdev->cmd_sync_work);
+	cancel_work_sync(&hdev->reenable_adv_work);
 
 	list_for_each_entry_safe(entry, tmp, &hdev->cmd_sync_work_list, list) {
 		if (entry->destroy)
@@ -1746,10 +1790,13 @@ static int hci_clear_adv_sets_sync(struct hci_dev *hdev, struct sock *sk)
 static int hci_clear_adv_sync(struct hci_dev *hdev, struct sock *sk, bool force)
 {
 	struct adv_info *adv, *n;
+	int err = 0;
 
 	if (ext_adv_capable(hdev))
 		/* Remove all existing sets */
-		return hci_clear_adv_sets_sync(hdev, sk);
+		err = hci_clear_adv_sets_sync(hdev, sk);
+	if (ext_adv_capable(hdev))
+		return err;
 
 	/* This is safe as long as there is no command send while the lock is
 	 * held.
@@ -1777,11 +1824,13 @@ static int hci_clear_adv_sync(struct hci_dev *hdev, struct sock *sk, bool force)
 static int hci_remove_adv_sync(struct hci_dev *hdev, u8 instance,
 			       struct sock *sk)
 {
-	int err;
+	int err = 0;
 
 	/* If we use extended advertising, instance has to be removed first. */
 	if (ext_adv_capable(hdev))
-		return hci_remove_ext_adv_instance_sync(hdev, instance, sk);
+		err = hci_remove_ext_adv_instance_sync(hdev, instance, sk);
+	if (ext_adv_capable(hdev))
+		return err;
 
 	/* This is safe as long as there is no command send while the lock is
 	 * held.
@@ -1880,13 +1929,16 @@ int hci_read_tx_power_sync(struct hci_dev *hdev, __le16 handle, u8 type)
 int hci_disable_advertising_sync(struct hci_dev *hdev)
 {
 	u8 enable = 0x00;
+	int err = 0;
 
 	/* If controller is not advertising we are done. */
 	if (!hci_dev_test_flag(hdev, HCI_LE_ADV))
 		return 0;
 
 	if (ext_adv_capable(hdev))
-		return hci_disable_ext_adv_instance_sync(hdev, 0x00);
+		err = hci_disable_ext_adv_instance_sync(hdev, 0x00);
+	if (ext_adv_capable(hdev))
+		return err;
 
 	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_ADV_ENABLE,
 				     sizeof(enable), &enable, HCI_CMD_TIMEOUT);
@@ -1899,7 +1951,11 @@ static int hci_le_set_ext_scan_enable_sync(struct hci_dev *hdev, u8 val,
 
 	memset(&cp, 0, sizeof(cp));
 	cp.enable = val;
-	cp.filter_dup = filter_dup;
+
+	if (hci_dev_test_flag(hdev, HCI_MESH))
+		cp.filter_dup = LE_SCAN_FILTER_DUP_DISABLE;
+	else
+		cp.filter_dup = filter_dup;
 
 	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_SCAN_ENABLE,
 				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
@@ -1915,7 +1971,11 @@ static int hci_le_set_scan_enable_sync(struct hci_dev *hdev, u8 val,
 
 	memset(&cp, 0, sizeof(cp));
 	cp.enable = val;
-	cp.filter_dup = filter_dup;
+
+	if (val && hci_dev_test_flag(hdev, HCI_MESH))
+		cp.filter_dup = LE_SCAN_FILTER_DUP_DISABLE;
+	else
+		cp.filter_dup = filter_dup;
 
 	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_SCAN_ENABLE,
 				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
@@ -2554,6 +2614,7 @@ static int hci_passive_scan_sync(struct hci_dev *hdev)
 	u8 own_addr_type;
 	u8 filter_policy;
 	u16 window, interval;
+	u8 filter_dups = LE_SCAN_FILTER_DUP_ENABLE;
 	int err;
 
 	if (hdev->scanning_paused) {
@@ -2616,11 +2677,16 @@ static int hci_passive_scan_sync(struct hci_dev *hdev)
 		interval = hdev->le_scan_interval;
 	}
 
+	/* Disable all filtering for Mesh */
+	if (hci_dev_test_flag(hdev, HCI_MESH)) {
+		filter_policy = 0;
+		filter_dups = LE_SCAN_FILTER_DUP_DISABLE;
+	}
+
 	bt_dev_dbg(hdev, "LE passive scan with acceptlist = %d", filter_policy);
 
 	return hci_start_scan_sync(hdev, LE_SCAN_PASSIVE, interval, window,
-				   own_addr_type, filter_policy,
-				   LE_SCAN_FILTER_DUP_ENABLE);
+				   own_addr_type, filter_policy, filter_dups);
 }
 
 /* This function controls the passive scanning based on hdev->pend_le_conns
@@ -2670,7 +2736,8 @@ int hci_update_passive_scan_sync(struct hci_dev *hdev)
 	bt_dev_dbg(hdev, "ADV monitoring is %s",
 		   hci_is_adv_monitoring(hdev) ? "on" : "off");
 
-	if (list_empty(&hdev->pend_le_conns) &&
+	if (!hci_dev_test_flag(hdev, HCI_MESH) &&
+	    list_empty(&hdev->pend_le_conns) &&
 	    list_empty(&hdev->pend_le_reports) &&
 	    !hci_is_adv_monitoring(hdev) &&
 	    !hci_dev_test_flag(hdev, HCI_PA_SYNC)) {
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 77e7aa63c0c0..b7ca59e1e10c 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -129,6 +129,10 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_ADD_EXT_ADV_PARAMS,
 	MGMT_OP_ADD_EXT_ADV_DATA,
 	MGMT_OP_ADD_ADV_PATTERNS_MONITOR_RSSI,
+	MGMT_OP_SET_MESH_RECEIVER,
+	MGMT_OP_MESH_READ_FEATURES,
+	MGMT_OP_MESH_SEND,
+	MGMT_OP_MESH_SEND_CANCEL,
 };
 
 static const u16 mgmt_events[] = {
@@ -1048,6 +1052,63 @@ static void discov_off(struct work_struct *work)
 	hci_dev_unlock(hdev);
 }
 
+static int send_settings_rsp(struct sock *sk, u16 opcode, struct hci_dev *hdev);
+
+static void mesh_send_complete(struct hci_dev *hdev,
+			       struct mgmt_mesh_tx *mesh_tx, bool silent)
+{
+	u8 handle = mesh_tx->handle;
+
+	if (!silent)
+		mgmt_event(MGMT_EV_MESH_PACKET_CMPLT, hdev, &handle,
+			   sizeof(handle), NULL);
+
+	mgmt_mesh_remove(mesh_tx);
+}
+
+static int mesh_send_done_sync(struct hci_dev *hdev, void *data)
+{
+	struct mgmt_mesh_tx *mesh_tx;
+
+	hci_dev_clear_flag(hdev, HCI_MESH_SENDING);
+	hci_disable_advertising_sync(hdev);
+	mesh_tx = mgmt_mesh_next(hdev, NULL);
+
+	if (mesh_tx)
+		mesh_send_complete(hdev, mesh_tx, false);
+
+	return 0;
+}
+
+static int mesh_send_sync(struct hci_dev *hdev, void *data);
+static void mesh_send_start_complete(struct hci_dev *hdev, void *data, int err);
+static void mesh_next(struct hci_dev *hdev, void *data, int err)
+{
+	struct mgmt_mesh_tx *mesh_tx = mgmt_mesh_next(hdev, NULL);
+
+	if (!mesh_tx)
+		return;
+
+	err = hci_cmd_sync_queue(hdev, mesh_send_sync, mesh_tx,
+				 mesh_send_start_complete);
+
+	if (err < 0)
+		mesh_send_complete(hdev, mesh_tx, false);
+	else
+		hci_dev_set_flag(hdev, HCI_MESH_SENDING);
+}
+
+static void mesh_send_done(struct work_struct *work)
+{
+	struct hci_dev *hdev = container_of(work, struct hci_dev,
+					    mesh_send_done.work);
+
+	if (!hci_dev_test_flag(hdev, HCI_MESH_SENDING))
+		return;
+
+	hci_cmd_sync_queue(hdev, mesh_send_done_sync, NULL, mesh_next);
+}
+
 static void mgmt_init_hdev(struct sock *sk, struct hci_dev *hdev)
 {
 	if (hci_dev_test_and_set_flag(hdev, HCI_MGMT))
@@ -1058,6 +1119,7 @@ static void mgmt_init_hdev(struct sock *sk, struct hci_dev *hdev)
 	INIT_DELAYED_WORK(&hdev->discov_off, discov_off);
 	INIT_DELAYED_WORK(&hdev->service_cache, service_cache_off);
 	INIT_DELAYED_WORK(&hdev->rpa_expired, rpa_expired);
+	INIT_DELAYED_WORK(&hdev->mesh_send_done, mesh_send_done);
 
 	/* Non-mgmt controlled devices get this bit set
 	 * implicitly so that pairing works for them, however
@@ -2094,6 +2156,306 @@ static int set_le_sync(struct hci_dev *hdev, void *data)
 	return err;
 }
 
+static void set_mesh_complete(struct hci_dev *hdev, void *data, int err)
+{
+	struct mgmt_pending_cmd *cmd = data;
+	u8 status = mgmt_status(err);
+	struct sock *sk = cmd->sk;
+
+	if (status) {
+		mgmt_pending_foreach(MGMT_OP_SET_MESH_RECEIVER, hdev,
+				     cmd_status_rsp, &status);
+		return;
+	}
+
+	mgmt_pending_remove(cmd);
+	mgmt_cmd_complete(sk, hdev->id, MGMT_OP_SET_MESH_RECEIVER, 0, NULL, 0);
+}
+
+static int set_mesh_sync(struct hci_dev *hdev, void *data)
+{
+	struct mgmt_pending_cmd *cmd = data;
+	struct mgmt_cp_set_mesh *cp = cmd->param;
+	size_t len = cmd->param_len;
+
+	memset(hdev->mesh_ad_types, 0, sizeof(hdev->mesh_ad_types));
+
+	if (cp->enable)
+		hci_dev_set_flag(hdev, HCI_MESH);
+	else
+		hci_dev_clear_flag(hdev, HCI_MESH);
+
+	len -= sizeof(*cp);
+
+	/* If filters don't fit, forward all adv pkts */
+	if (len <= sizeof(hdev->mesh_ad_types))
+		memcpy(hdev->mesh_ad_types, cp->ad_types, len);
+
+	hci_update_passive_scan_sync(hdev);
+	return 0;
+}
+
+static int set_mesh(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
+{
+	struct mgmt_cp_set_mesh *cp = data;
+	struct mgmt_pending_cmd *cmd;
+	int err = 0;
+
+	bt_dev_dbg(hdev, "sock %p", sk);
+
+	if (!lmp_le_capable(hdev))
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_MESH_RECEIVER,
+				       MGMT_STATUS_NOT_SUPPORTED);
+
+	if (cp->enable != 0x00 && cp->enable != 0x01)
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_MESH_RECEIVER,
+				       MGMT_STATUS_INVALID_PARAMS);
+
+	hci_dev_lock(hdev);
+
+	cmd = mgmt_pending_add(sk, MGMT_OP_SET_MESH_RECEIVER, hdev, data, len);
+	if (!cmd)
+		err = -ENOMEM;
+	else
+		err = hci_cmd_sync_queue(hdev, set_mesh_sync, cmd,
+					 set_mesh_complete);
+
+	if (err < 0) {
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_MESH_RECEIVER,
+				      MGMT_STATUS_FAILED);
+
+		if (cmd)
+			mgmt_pending_remove(cmd);
+	}
+
+	hci_dev_unlock(hdev);
+	return err;
+}
+
+static void mesh_send_start_complete(struct hci_dev *hdev, void *data, int err)
+{
+	struct mgmt_mesh_tx *mesh_tx = data;
+	struct mgmt_cp_mesh_send *send = (void *)mesh_tx->param;
+	unsigned long mesh_send_interval;
+	u8 mgmt_err = mgmt_status(err);
+
+	/* Report any errors here, but don't report completion */
+
+	if (mgmt_err) {
+		hci_dev_clear_flag(hdev, HCI_MESH_SENDING);
+		/* Send Complete Error Code for handle */
+		mesh_send_complete(hdev, mesh_tx, false);
+		return;
+	}
+
+	mesh_send_interval = msecs_to_jiffies((send->cnt) * 25);
+	queue_delayed_work(hdev->req_workqueue, &hdev->mesh_send_done,
+			   mesh_send_interval);
+}
+
+static int mesh_send_sync(struct hci_dev *hdev, void *data)
+{
+	struct mgmt_mesh_tx *mesh_tx = data;
+	struct mgmt_cp_mesh_send *send = (void *)mesh_tx->param;
+	struct adv_info *adv, *next_instance;
+	u8 instance = hdev->le_num_of_adv_sets + 1;
+	u16 timeout, duration;
+	int err = 0;
+
+	if (hdev->le_num_of_adv_sets <= hdev->adv_instance_cnt)
+		return MGMT_STATUS_BUSY;
+
+	timeout = 1000;
+	duration = send->cnt * INTERVAL_TO_MS(hdev->le_adv_max_interval);
+	adv = hci_add_adv_instance(hdev, instance, 0,
+				   send->adv_data_len, send->adv_data,
+				   0, NULL,
+				   timeout, duration,
+				   HCI_ADV_TX_POWER_NO_PREFERENCE,
+				   hdev->le_adv_min_interval,
+				   hdev->le_adv_max_interval,
+				   mesh_tx->handle);
+
+	if (!IS_ERR(adv))
+		mesh_tx->instance = instance;
+	else
+		err = PTR_ERR(adv);
+
+	if (hdev->cur_adv_instance == instance) {
+		/* If the currently advertised instance is being changed then
+		 * cancel the current advertising and schedule the next
+		 * instance. If there is only one instance then the overridden
+		 * advertising data will be visible right away.
+		 */
+		cancel_adv_timeout(hdev);
+
+		next_instance = hci_get_next_instance(hdev, instance);
+		if (next_instance)
+			instance = next_instance->instance;
+		else
+			instance = 0;
+	} else if (hdev->adv_instance_timeout) {
+		/* Immediately advertise the new instance if no other, or
+		 * let it go naturally from queue if ADV is already happening
+		 */
+		instance = 0;
+	}
+
+	if (instance)
+		return hci_schedule_adv_instance_sync(hdev, instance, true);
+
+	return err;
+}
+
+static void send_count(struct mgmt_mesh_tx *mesh_tx, void *data)
+{
+	struct mgmt_rp_mesh_read_features *rp = data;
+
+	if (rp->used_handles >= rp->max_handles)
+		return;
+
+	rp->handles[rp->used_handles++] = mesh_tx->handle;
+}
+
+static int mesh_features(struct sock *sk, struct hci_dev *hdev,
+			 void *data, u16 len)
+{
+	struct mgmt_rp_mesh_read_features rp;
+
+	if (!lmp_le_capable(hdev))
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_MESH_READ_FEATURES,
+				       MGMT_STATUS_NOT_SUPPORTED);
+
+	memset(&rp, 0, sizeof(rp));
+	rp.index = cpu_to_le16(hdev->id);
+	if (hci_dev_test_flag(hdev, HCI_LE_ENABLED))
+		rp.max_handles = MESH_HANDLES_MAX;
+
+	hci_dev_lock(hdev);
+
+	if (rp.max_handles)
+		mgmt_mesh_foreach(hdev, send_count, &rp, sk);
+
+	mgmt_cmd_complete(sk, hdev->id, MGMT_OP_MESH_READ_FEATURES, 0, &rp,
+			  rp.used_handles + sizeof(rp) - MESH_HANDLES_MAX);
+
+	hci_dev_unlock(hdev);
+	return 0;
+}
+
+static int send_cancel(struct hci_dev *hdev, void *data)
+{
+	struct mgmt_pending_cmd *cmd = data;
+	struct mgmt_cp_mesh_send_cancel *cancel = (void *)cmd->param;
+	struct mgmt_mesh_tx *mesh_tx;
+
+	if (!cancel->handle) {
+		do {
+			mesh_tx = mgmt_mesh_next(hdev, cmd->sk);
+
+			if (mesh_tx)
+				mesh_send_complete(hdev, mesh_tx, false);
+		} while (mesh_tx);
+	} else {
+		mesh_tx = mgmt_mesh_find(hdev, cancel->handle);
+
+		if (mesh_tx && mesh_tx->sk == cmd->sk)
+			mesh_send_complete(hdev, mesh_tx, false);
+	}
+
+	mgmt_cmd_complete(cmd->sk, hdev->id, MGMT_OP_MESH_SEND_CANCEL,
+			  0, NULL, 0);
+	mgmt_pending_free(cmd);
+
+	return 0;
+}
+
+static int mesh_send_cancel(struct sock *sk, struct hci_dev *hdev,
+			    void *data, u16 len)
+{
+	struct mgmt_pending_cmd *cmd;
+	int err;
+
+	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED))
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_MESH_SEND_CANCEL,
+				       MGMT_STATUS_REJECTED);
+
+	hci_dev_lock(hdev);
+	cmd = mgmt_pending_new(sk, MGMT_OP_MESH_SEND_CANCEL, hdev, data, len);
+	if (!cmd)
+		err = -ENOMEM;
+	else
+		err = hci_cmd_sync_queue(hdev, send_cancel, cmd, NULL);
+
+	if (err < 0) {
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_MESH_SEND_CANCEL,
+				      MGMT_STATUS_FAILED);
+
+		if (cmd)
+			mgmt_pending_free(cmd);
+	}
+
+	hci_dev_unlock(hdev);
+	return err;
+}
+
+static int mesh_send(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
+{
+	struct mgmt_mesh_tx *mesh_tx;
+	struct mgmt_cp_mesh_send *send = data;
+	struct mgmt_rp_mesh_read_features rp;
+	bool sending;
+	int err = 0;
+
+	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED) ||
+	    len <= MGMT_MESH_SEND_SIZE ||
+	    len > (MGMT_MESH_SEND_SIZE + 31))
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_MESH_SEND,
+				       MGMT_STATUS_REJECTED);
+
+	hci_dev_lock(hdev);
+
+	memset(&rp, 0, sizeof(rp));
+	rp.max_handles = MESH_HANDLES_MAX;
+
+	mgmt_mesh_foreach(hdev, send_count, &rp, sk);
+
+	if (rp.max_handles <= rp.used_handles) {
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_MESH_SEND,
+				      MGMT_STATUS_BUSY);
+		goto done;
+	}
+
+	sending = hci_dev_test_flag(hdev, HCI_MESH_SENDING);
+	mesh_tx = mgmt_mesh_add(sk, hdev, send, len);
+
+	if (!mesh_tx)
+		err = -ENOMEM;
+	else if (!sending)
+		err = hci_cmd_sync_queue(hdev, mesh_send_sync, mesh_tx,
+					 mesh_send_start_complete);
+
+	if (err < 0) {
+		bt_dev_err(hdev, "Send Mesh Failed %d", err);
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_MESH_SEND,
+				      MGMT_STATUS_FAILED);
+
+		if (mesh_tx) {
+			if (sending)
+				mgmt_mesh_remove(mesh_tx);
+		}
+	} else {
+		hci_dev_set_flag(hdev, HCI_MESH_SENDING);
+
+		mgmt_cmd_complete(sk, hdev->id, MGMT_OP_MESH_SEND, 0,
+				  &mesh_tx->handle, 1);
+	}
+
+done:
+	hci_dev_unlock(hdev);
+	return err;
+}
+
 static int set_le(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 {
 	struct mgmt_mode *cp = data;
@@ -5980,6 +6342,7 @@ static int set_advertising(struct sock *sk, struct hci_dev *hdev, void *data,
 	if (!hdev_is_powered(hdev) ||
 	    (val == hci_dev_test_flag(hdev, HCI_ADVERTISING) &&
 	     (cp->val == 0x02) == hci_dev_test_flag(hdev, HCI_ADVERTISING_CONNECTABLE)) ||
+	    hci_dev_test_flag(hdev, HCI_MESH) ||
 	    hci_conn_num(hdev, LE_LINK) > 0 ||
 	    (hci_dev_test_flag(hdev, HCI_LE_SCAN) &&
 	     hdev->le_scan_type == LE_SCAN_ACTIVE)) {
@@ -7908,8 +8271,7 @@ static u32 get_supported_adv_flags(struct hci_dev *hdev)
 	/* In extended adv TX_POWER returned from Set Adv Param
 	 * will be always valid.
 	 */
-	if ((hdev->adv_tx_power != HCI_TX_POWER_INVALID) ||
-	    ext_adv_capable(hdev))
+	if (hdev->adv_tx_power != HCI_TX_POWER_INVALID || ext_adv_capable(hdev))
 		flags |= MGMT_ADV_FLAG_TX_POWER;
 
 	if (ext_adv_capable(hdev)) {
@@ -7962,8 +8324,14 @@ static int read_adv_features(struct sock *sk, struct hci_dev *hdev,
 
 	instance = rp->instance;
 	list_for_each_entry(adv_instance, &hdev->adv_instances, list) {
-		*instance = adv_instance->instance;
-		instance++;
+		/* Only instances 1-le_num_of_adv_sets are externally visible */
+		if (adv_instance->instance <= hdev->adv_instance_cnt) {
+			*instance = adv_instance->instance;
+			instance++;
+		} else {
+			rp->num_instances--;
+			rp_len--;
+		}
 	}
 
 	hci_dev_unlock(hdev);
@@ -8225,7 +8593,7 @@ static int add_advertising(struct sock *sk, struct hci_dev *hdev,
 				   timeout, duration,
 				   HCI_ADV_TX_POWER_NO_PREFERENCE,
 				   hdev->le_adv_min_interval,
-				   hdev->le_adv_max_interval);
+				   hdev->le_adv_max_interval, 0);
 	if (IS_ERR(adv)) {
 		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_ADD_ADVERTISING,
 				      MGMT_STATUS_FAILED);
@@ -8429,7 +8797,7 @@ static int add_ext_adv_params(struct sock *sk, struct hci_dev *hdev,
 	/* Create advertising instance with no advertising or response data */
 	adv = hci_add_adv_instance(hdev, cp->instance, flags, 0, NULL, 0, NULL,
 				   timeout, duration, tx_power, min_interval,
-				   max_interval);
+				   max_interval, 0);
 
 	if (IS_ERR(adv)) {
 		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_ADD_EXT_ADV_PARAMS,
@@ -8875,8 +9243,13 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
 	{ add_ext_adv_data,        MGMT_ADD_EXT_ADV_DATA_SIZE,
 						HCI_MGMT_VAR_LEN },
 	{ add_adv_patterns_monitor_rssi,
-				   MGMT_ADD_ADV_PATTERNS_MONITOR_RSSI_SIZE,
+				   MGMT_ADD_ADV_PATTERNS_MONITOR_RSSI_SIZE },
+	{ set_mesh,                MGMT_SET_MESH_RECEIVER_SIZE,
 						HCI_MGMT_VAR_LEN },
+	{ mesh_features,           MGMT_MESH_READ_FEATURES_SIZE },
+	{ mesh_send,               MGMT_MESH_SEND_SIZE,
+						HCI_MGMT_VAR_LEN },
+	{ mesh_send_cancel,        MGMT_MESH_SEND_CANCEL_SIZE },
 };
 
 void mgmt_index_added(struct hci_dev *hdev)
@@ -9816,14 +10189,86 @@ static void mgmt_adv_monitor_device_found(struct hci_dev *hdev,
 		kfree_skb(skb);
 }
 
+static void mesh_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr,
+			      u8 addr_type, s8 rssi, u32 flags, u8 *eir,
+			      u16 eir_len, u8 *scan_rsp, u8 scan_rsp_len,
+			      u64 instant)
+{
+	struct sk_buff *skb;
+	struct mgmt_ev_mesh_device_found *ev;
+	int i, j;
+
+	if (!hdev->mesh_ad_types[0])
+		goto accepted;
+
+	/* Scan for requested AD types */
+	if (eir_len > 0) {
+		for (i = 0; i + 1 < eir_len; i += eir[i] + 1) {
+			for (j = 0; j < sizeof(hdev->mesh_ad_types); j++) {
+				if (!hdev->mesh_ad_types[j])
+					break;
+
+				if (hdev->mesh_ad_types[j] == eir[i + 1])
+					goto accepted;
+			}
+		}
+	}
+
+	if (scan_rsp_len > 0) {
+		for (i = 0; i + 1 < scan_rsp_len; i += scan_rsp[i] + 1) {
+			for (j = 0; j < sizeof(hdev->mesh_ad_types); j++) {
+				if (!hdev->mesh_ad_types[j])
+					break;
+
+				if (hdev->mesh_ad_types[j] == scan_rsp[i + 1])
+					goto accepted;
+			}
+		}
+	}
+
+	return;
+
+accepted:
+	skb = mgmt_alloc_skb(hdev, MGMT_EV_MESH_DEVICE_FOUND,
+			     sizeof(*ev) + eir_len + scan_rsp_len);
+	if (!skb)
+		return;
+
+	ev = skb_put(skb, sizeof(*ev));
+
+	bacpy(&ev->addr.bdaddr, bdaddr);
+	ev->addr.type = link_to_bdaddr(LE_LINK, addr_type);
+	ev->rssi = rssi;
+	ev->flags = cpu_to_le32(flags);
+	ev->instant = cpu_to_le64(instant);
+
+	if (eir_len > 0)
+		/* Copy EIR or advertising data into event */
+		skb_put_data(skb, eir, eir_len);
+
+	if (scan_rsp_len > 0)
+		/* Append scan response data to event */
+		skb_put_data(skb, scan_rsp, scan_rsp_len);
+
+	ev->eir_len = cpu_to_le16(eir_len + scan_rsp_len);
+
+	mgmt_event_skb(skb, NULL);
+}
+
 void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		       u8 addr_type, u8 *dev_class, s8 rssi, u32 flags,
-		       u8 *eir, u16 eir_len, u8 *scan_rsp, u8 scan_rsp_len)
+		       u8 *eir, u16 eir_len, u8 *scan_rsp, u8 scan_rsp_len,
+		       u64 instant)
 {
 	struct sk_buff *skb;
 	struct mgmt_ev_device_found *ev;
 	bool report_device = hci_discovery_active(hdev);
 
+	if (hci_dev_test_flag(hdev, HCI_MESH) && link_type == LE_LINK)
+		mesh_device_found(hdev, bdaddr, addr_type, rssi, flags,
+				  eir, eir_len, scan_rsp, scan_rsp_len,
+				  instant);
+
 	/* Don't send events for a non-kernel initiated discovery. With
 	 * LE one exception is if we have pend_le_reports > 0 in which
 	 * case we're doing passive scanning and want these events.
@@ -9982,3 +10427,22 @@ void mgmt_exit(void)
 {
 	hci_mgmt_chan_unregister(&chan);
 }
+
+void mgmt_cleanup(struct sock *sk)
+{
+	struct mgmt_mesh_tx *mesh_tx;
+	struct hci_dev *hdev;
+
+	read_lock(&hci_dev_list_lock);
+
+	list_for_each_entry(hdev, &hci_dev_list, list) {
+		do {
+			mesh_tx = mgmt_mesh_next(hdev, sk);
+
+			if (mesh_tx)
+				mesh_send_complete(hdev, mesh_tx, true);
+		} while (mesh_tx);
+	}
+
+	read_unlock(&hci_dev_list_lock);
+}
diff --git a/net/bluetooth/mgmt_util.c b/net/bluetooth/mgmt_util.c
index b69cfed62088..0115f783bde8 100644
--- a/net/bluetooth/mgmt_util.c
+++ b/net/bluetooth/mgmt_util.c
@@ -314,3 +314,77 @@ void mgmt_pending_remove(struct mgmt_pending_cmd *cmd)
 	list_del(&cmd->list);
 	mgmt_pending_free(cmd);
 }
+
+void mgmt_mesh_foreach(struct hci_dev *hdev,
+		       void (*cb)(struct mgmt_mesh_tx *mesh_tx, void *data),
+		       void *data, struct sock *sk)
+{
+	struct mgmt_mesh_tx *mesh_tx, *tmp;
+
+	list_for_each_entry_safe(mesh_tx, tmp, &hdev->mgmt_pending, list) {
+		if (!sk || mesh_tx->sk == sk)
+			cb(mesh_tx, data);
+	}
+}
+
+struct mgmt_mesh_tx *mgmt_mesh_next(struct hci_dev *hdev, struct sock *sk)
+{
+	struct mgmt_mesh_tx *mesh_tx;
+
+	if (list_empty(&hdev->mesh_pending))
+		return NULL;
+
+	list_for_each_entry(mesh_tx, &hdev->mesh_pending, list) {
+		if (!sk || mesh_tx->sk == sk)
+			return mesh_tx;
+	}
+
+	return NULL;
+}
+
+struct mgmt_mesh_tx *mgmt_mesh_find(struct hci_dev *hdev, u8 handle)
+{
+	struct mgmt_mesh_tx *mesh_tx;
+
+	if (list_empty(&hdev->mesh_pending))
+		return NULL;
+
+	list_for_each_entry(mesh_tx, &hdev->mesh_pending, list) {
+		if (mesh_tx->handle == handle)
+			return mesh_tx;
+	}
+
+	return NULL;
+}
+
+struct mgmt_mesh_tx *mgmt_mesh_add(struct sock *sk, struct hci_dev *hdev,
+				   void *data, u16 len)
+{
+	struct mgmt_mesh_tx *mesh_tx;
+
+	mesh_tx = kzalloc(sizeof(*mesh_tx), GFP_KERNEL);
+	if (!mesh_tx)
+		return NULL;
+
+	hdev->mesh_send_ref++;
+	if (!hdev->mesh_send_ref)
+		hdev->mesh_send_ref++;
+
+	mesh_tx->handle = hdev->mesh_send_ref;
+	mesh_tx->index = hdev->id;
+	memcpy(mesh_tx->param, data, len);
+	mesh_tx->param_len = len;
+	mesh_tx->sk = sk;
+	sock_hold(sk);
+
+	list_add_tail(&mesh_tx->list, &hdev->mesh_pending);
+
+	return mesh_tx;
+}
+
+void mgmt_mesh_remove(struct mgmt_mesh_tx *mesh_tx)
+{
+	list_del(&mesh_tx->list);
+	sock_put(mesh_tx->sk);
+	kfree(mesh_tx);
+}
diff --git a/net/bluetooth/mgmt_util.h b/net/bluetooth/mgmt_util.h
index 98e40395a383..6a8b7e84293d 100644
--- a/net/bluetooth/mgmt_util.h
+++ b/net/bluetooth/mgmt_util.h
@@ -20,6 +20,16 @@
    SOFTWARE IS DISCLAIMED.
 */
 
+struct mgmt_mesh_tx {
+	struct list_head list;
+	int index;
+	size_t param_len;
+	struct sock *sk;
+	u8 handle;
+	u8 instance;
+	u8 param[sizeof(struct mgmt_cp_mesh_send) + 29];
+};
+
 struct mgmt_pending_cmd {
 	struct list_head list;
 	u16 opcode;
@@ -59,3 +69,11 @@ struct mgmt_pending_cmd *mgmt_pending_new(struct sock *sk, u16 opcode,
 					  void *data, u16 len);
 void mgmt_pending_free(struct mgmt_pending_cmd *cmd);
 void mgmt_pending_remove(struct mgmt_pending_cmd *cmd);
+void mgmt_mesh_foreach(struct hci_dev *hdev,
+		       void (*cb)(struct mgmt_mesh_tx *mesh_tx, void *data),
+		       void *data, struct sock *sk);
+struct mgmt_mesh_tx *mgmt_mesh_find(struct hci_dev *hdev, u8 handle);
+struct mgmt_mesh_tx *mgmt_mesh_next(struct hci_dev *hdev, struct sock *sk);
+struct mgmt_mesh_tx *mgmt_mesh_add(struct sock *sk, struct hci_dev *hdev,
+				   void *data, u16 len);
+void mgmt_mesh_remove(struct mgmt_mesh_tx *mesh_tx);
-- 
2.37.2

