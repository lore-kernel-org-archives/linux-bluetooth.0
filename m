Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9D5C433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 31 Mar 2022 18:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbiCaSJ4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 31 Mar 2022 14:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233578AbiCaSJv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 31 Mar 2022 14:09:51 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF172325E6
        for <linux-bluetooth@vger.kernel.org>; Thu, 31 Mar 2022 11:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648750082; x=1680286082;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6VHbV9yWzD4qHhk/eFnBbFkdN6x47DWLRS8NaSGPp3M=;
  b=Ax3xiWa9ksuwK3AP5P5PIByP/Fd2QK8KssxbcdtdPF1nJscXWjZkbbMz
   3wc4Hrkii2N4Q3y1/MdEgF8Pk4cidFU7PjQ7aq4ZvBNF28E9dsDyByrND
   jN8q4Z2JoZYDURN5DY5BTmPCBYqkZ8ZriABtVRstsNsSi5QLy0Ie2gcSD
   Bn0u1IFqV+ckXyzvCB00uotS9ETB5elwEVOSKf2rhFS9G0tt+GoXg0bk8
   8EA5TSJb9J/vjExg8cKK6PZNVB1uKFdwfsgbkNF1+0DH+mGsJC07CO0iY
   oU8RwkKmzoQkYUaPcZdDBW2PspCECE39Ru/azximtamj3k0Mr14KxH7ml
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="257495899"
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="257495899"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 11:08:01 -0700
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="840896187"
Received: from coletonb-mobl.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.209.6.25])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 11:08:01 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH 2/3] Bluetooth: Implement support for Mesh
Date:   Thu, 31 Mar 2022 11:07:48 -0700
Message-Id: <20220331180749.456913-3-brian.gix@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220331180749.456913-1-brian.gix@intel.com>
References: <20220331180749.456913-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The patch adds state bits, storage and HCI command chains for sending
and recieving Bluetooth Mesh advertising packets, and delivery to
requesting user space processes. It specifically creates 4 new MGMT
commands and 2 new MGMT events:

MGMT_OP_SET_MESH_RECEIVER - Sets passive scan parameters and a list of
AD Types which will trigger Mesh Packet Received events

MGMT_OP_MESH_READ_FEATURES - Returns information on how many outbound
Mesh packets can be simultaneously queued, and what the currently queued
handles are.

MGMT_OP_MESH_SEND - Command to queue a specific outbound Mesh packet,
with the number of times it should be sent, and the BD Addr to use.

MGMT_OP_MESH_SEND_CANCEL - Command to cancel a prior outbound message
request.

MGMT_EV_MESH_DEVICE_FOUND - Event to deliver entire received Mesh
Advertisement packet, along with timing information.

MGMT_EV_MESH_PACKET_CMPLT - Event to indicate that an outbound packet is
no longer queued for delivery.

Signed-off-by: Brian Gix <brian.gix@intel.com>
---
 include/net/bluetooth/hci.h      |   3 +
 include/net/bluetooth/hci_core.h |  18 +-
 include/net/bluetooth/hci_sync.h |   3 +
 include/net/bluetooth/mgmt.h     |  51 ++++
 net/bluetooth/hci_conn.c         |   2 +-
 net/bluetooth/hci_core.c         |   1 +
 net/bluetooth/hci_event.c        |  61 +++--
 net/bluetooth/hci_request.c      | 115 ++++++--
 net/bluetooth/hci_sync.c         | 104 ++++++--
 net/bluetooth/mgmt.c             | 432 ++++++++++++++++++++++++++++++-
 net/bluetooth/mgmt_util.c        |  58 +++++
 net/bluetooth/mgmt_util.h        |  17 ++
 12 files changed, 786 insertions(+), 79 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 5cb095b09a94..71ffc8d20e50 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -353,6 +353,9 @@ enum {
 	HCI_OFFLOAD_CODECS_ENABLED,
 	HCI_LE_SIMULTANEOUS_ROLES,
 
+	HCI_MESH,
+	HCI_MESH_SENDING,
+
 	__HCI_NUM_FLAGS,
 };
 
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index d5377740e99c..5a32c91f27c7 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -357,6 +357,8 @@ struct hci_dev {
 	__u8		le_resolv_list_size;
 	__u8		le_num_of_adv_sets;
 	__u8		le_states[8];
+	__u8		mesh_ad_types[16];
+	__u8		mesh_send_ref;
 	__u8		commands[64];
 	__u8		hci_ver;
 	__u16		hci_rev;
@@ -544,6 +546,7 @@ struct hci_dev {
 
 	struct hci_conn_hash	conn_hash;
 
+	struct list_head	mesh_pending;
 	struct list_head	mgmt_pending;
 	struct list_head	reject_list;
 	struct list_head	accept_list;
@@ -595,6 +598,8 @@ struct hci_dev {
 	struct delayed_work	rpa_expired;
 	bdaddr_t		rpa;
 
+	struct delayed_work	mesh_send_done;
+
 	enum {
 		INTERLEAVE_SCAN_NONE,
 		INTERLEAVE_SCAN_NO_FILTER,
@@ -1497,7 +1502,9 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 
 /* Use ext scanning if set ext scan param and ext scan enable is supported */
 #define use_ext_scan(dev) (((dev)->commands[37] & 0x20) && \
-			   ((dev)->commands[37] & 0x40))
+			   ((dev)->commands[37] & 0x40) && \
+			   !hci_dev_test_flag(dev, HCI_MESH))
+
 /* Use ext create connection if command is supported */
 #define use_ext_conn(dev) ((dev)->commands[37] & 0x80)
 
@@ -1512,6 +1519,10 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 #define use_enhanced_conn_complete(dev) (ll_privacy_capable(dev) || \
 					 ext_adv_capable(dev))
 
+/* Use ext advertising if supported and not running Mesh */
+#define use_ext_adv(dev) (ext_adv_capable(dev) && \
+			  !hci_dev_test_flag(dev, HCI_MESH))
+
 /* ----- HCI protocols ----- */
 #define HCI_PROTO_DEFER             0x01
 
@@ -1793,6 +1804,8 @@ void hci_mgmt_chan_unregister(struct hci_mgmt_chan *c);
 #define DISCOV_LE_RESTART_DELAY		msecs_to_jiffies(200)	/* msec */
 #define DISCOV_LE_FAST_ADV_INT_MIN	0x00A0	/* 100 msec */
 #define DISCOV_LE_FAST_ADV_INT_MAX	0x00F0	/* 150 msec */
+#define DISCOV_LE_ADV_MESH_MIN		0x00A0  /* 100 msec */
+#define DISCOV_LE_ADV_MESH_MAX		0x00A0  /* 100 msec */
 
 #define NAME_RESOLVE_DURATION		msecs_to_jiffies(10240)	/* 10.24 sec */
 
@@ -1844,7 +1857,8 @@ void mgmt_start_discovery_complete(struct hci_dev *hdev, u8 status);
 void mgmt_stop_discovery_complete(struct hci_dev *hdev, u8 status);
 void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		       u8 addr_type, u8 *dev_class, s8 rssi, u32 flags,
-		       u8 *eir, u16 eir_len, u8 *scan_rsp, u8 scan_rsp_len);
+		       u8 *eir, u16 eir_len, u8 *scan_rsp, u8 scan_rsp_len,
+		       u32 instant);
 void mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		      u8 addr_type, s8 rssi, u8 *name, u8 name_len);
 void mgmt_discovering(struct hci_dev *hdev, u8 discovering);
diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index 2492e3b46a8f..b86a3bcf0814 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -85,6 +85,9 @@ int hci_remove_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance,
 struct sk_buff *hci_read_local_oob_data_sync(struct hci_dev *hdev, bool ext,
 					     struct sock *sk);
 
+int hci_mesh_send_sync(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 bdaddr_type,
+							u8 *data, u8 len);
+
 int hci_reset_sync(struct hci_dev *hdev);
 int hci_dev_open_sync(struct hci_dev *hdev);
 int hci_dev_close_sync(struct hci_dev *hdev);
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 7c1ad0f6fcec..4ddeee94b1e2 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -837,6 +837,41 @@ struct mgmt_cp_add_adv_patterns_monitor_rssi {
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
+#define MESH_HANDLES_MAX	4
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
+	__u8   data[];
+} __packed;
+#define MGMT_MESH_SEND_SIZE		18
+
+#define MGMT_OP_MESH_SEND_CANCEL	0x005A
+struct mgmt_cp_mesh_send_cancel {
+	__u8  handle;
+} __packed;
+#define MGMT_MESH_SEND_CANCEL_SIZE	1
 
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
@@ -1120,3 +1155,19 @@ struct mgmt_ev_adv_monitor_device_lost {
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
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 84312c836549..db4a0c98e231 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -638,7 +638,7 @@ static void hci_conn_auto_accept(struct work_struct *work)
 
 static void le_disable_advertising(struct hci_dev *hdev)
 {
-	if (ext_adv_capable(hdev)) {
+	if (use_ext_adv(hdev)) {
 		struct hci_cp_le_set_ext_adv_enable cp;
 
 		cp.enable = 0x00;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index b4782a6c1025..66ca5321ef34 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2487,6 +2487,7 @@ struct hci_dev *hci_alloc_dev_priv(int sizeof_priv)
 	mutex_init(&hdev->lock);
 	mutex_init(&hdev->req_lock);
 
+	INIT_LIST_HEAD(&hdev->mesh_pending);
 	INIT_LIST_HEAD(&hdev->mgmt_pending);
 	INIT_LIST_HEAD(&hdev->reject_list);
 	INIT_LIST_HEAD(&hdev->accept_list);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index abaabfae19cc..bf51fda1733b 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1712,6 +1712,8 @@ static void le_set_scan_enable_complete(struct hci_dev *hdev, u8 enable)
 		hci_dev_set_flag(hdev, HCI_LE_SCAN);
 		if (hdev->le_scan_type == LE_SCAN_ACTIVE)
 			clear_pending_adv_report(hdev);
+		if (hci_dev_test_flag(hdev, HCI_MESH))
+			hci_discovery_set_state(hdev, DISCOVERY_FINDING);
 		break;
 
 	case LE_SCAN_DISABLE:
@@ -1726,7 +1728,7 @@ static void le_set_scan_enable_complete(struct hci_dev *hdev, u8 enable)
 					  d->last_adv_addr_type, NULL,
 					  d->last_adv_rssi, d->last_adv_flags,
 					  d->last_adv_data,
-					  d->last_adv_data_len, NULL, 0);
+					  d->last_adv_data_len, NULL, 0, 0);
 		}
 
 		/* Cancel this timer so that we don't try to disable scanning
@@ -1742,6 +1744,9 @@ static void le_set_scan_enable_complete(struct hci_dev *hdev, u8 enable)
 		 */
 		if (hci_dev_test_and_clear_flag(hdev, HCI_LE_SCAN_INTERRUPTED))
 			hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
+		else if (!hci_dev_test_flag(hdev, HCI_LE_ADV) &&
+			 hdev->discovery.state == DISCOVERY_FINDING)
+			hci_req_reenable_advertising(hdev);
 
 		break;
 
@@ -3056,7 +3061,7 @@ static void hci_inquiry_result_evt(struct hci_dev *hdev, void *edata,
 
 		mgmt_device_found(hdev, &info->bdaddr, ACL_LINK, 0x00,
 				  info->dev_class, HCI_RSSI_INVALID,
-				  flags, NULL, 0, NULL, 0);
+				  flags, NULL, 0, NULL, 0, 0);
 	}
 
 	hci_dev_unlock(hdev);
@@ -4566,7 +4571,7 @@ static void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev, void *edata,
 
 			mgmt_device_found(hdev, &info->bdaddr, ACL_LINK, 0x00,
 					  info->dev_class, info->rssi,
-					  flags, NULL, 0, NULL, 0);
+					  flags, NULL, 0, NULL, 0, 0);
 		}
 	} else if (skb->len == array_size(ev->num,
 					  sizeof(struct inquiry_info_rssi))) {
@@ -4597,7 +4602,7 @@ static void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev, void *edata,
 
 			mgmt_device_found(hdev, &info->bdaddr, ACL_LINK, 0x00,
 					  info->dev_class, info->rssi,
-					  flags, NULL, 0, NULL, 0);
+					  flags, NULL, 0, NULL, 0, 0);
 		}
 	} else {
 		bt_dev_err(hdev, "Malformed HCI Event: 0x%2.2x",
@@ -4849,7 +4854,7 @@ static void hci_extended_inquiry_result_evt(struct hci_dev *hdev, void *edata,
 
 		mgmt_device_found(hdev, &info->bdaddr, ACL_LINK, 0x00,
 				  info->dev_class, info->rssi,
-				  flags, info->data, eir_len, NULL, 0);
+				  flags, info->data, eir_len, NULL, 0, 0);
 	}
 
 	hci_dev_unlock(hdev);
@@ -5896,7 +5901,7 @@ static struct hci_conn *check_pending_le_conn(struct hci_dev *hdev,
 static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 			       u8 bdaddr_type, bdaddr_t *direct_addr,
 			       u8 direct_addr_type, s8 rssi, u8 *data, u8 len,
-			       bool ext_adv)
+			       bool ext_adv, bool ctl_time, u32 instant)
 {
 	struct discovery_state *d = &hdev->discovery;
 	struct smp_irk *irk;
@@ -5944,7 +5949,7 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 	 * important to see if the address is matching the local
 	 * controller address.
 	 */
-	if (direct_addr) {
+	if (!hci_dev_test_flag(hdev, HCI_MESH) && direct_addr) {
 		direct_addr_type = ev_bdaddr_type(hdev, direct_addr_type,
 						  &bdaddr_resolved);
 
@@ -5992,6 +5997,18 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
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
@@ -6005,12 +6022,8 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
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
 
@@ -6029,11 +6042,8 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
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
@@ -6050,7 +6060,7 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 		}
 
 		mgmt_device_found(hdev, bdaddr, LE_LINK, bdaddr_type, NULL,
-				  rssi, flags, data, len, NULL, 0);
+				  rssi, flags, data, len, NULL, 0, 0);
 		return;
 	}
 
@@ -6069,7 +6079,7 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 					  d->last_adv_addr_type, NULL,
 					  d->last_adv_rssi, d->last_adv_flags,
 					  d->last_adv_data,
-					  d->last_adv_data_len, NULL, 0);
+					  d->last_adv_data_len, NULL, 0, 0);
 
 		/* If the new report will trigger a SCAN_REQ store it for
 		 * later merging.
@@ -6086,7 +6096,7 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 		 */
 		clear_pending_adv_report(hdev);
 		mgmt_device_found(hdev, bdaddr, LE_LINK, bdaddr_type, NULL,
-				  rssi, flags, data, len, NULL, 0);
+				  rssi, flags, data, len, NULL, 0, 0);
 		return;
 	}
 
@@ -6096,7 +6106,7 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 	 */
 	mgmt_device_found(hdev, &d->last_adv_addr, LE_LINK,
 			  d->last_adv_addr_type, NULL, rssi, d->last_adv_flags,
-			  d->last_adv_data, d->last_adv_data_len, data, len);
+			  d->last_adv_data, d->last_adv_data_len, data, len, 0);
 	clear_pending_adv_report(hdev);
 }
 
@@ -6104,6 +6114,7 @@ static void hci_le_adv_report_evt(struct hci_dev *hdev, void *data,
 				  struct sk_buff *skb)
 {
 	struct hci_ev_le_advertising_report *ev = data;
+	u32 instant = jiffies;
 
 	if (!ev->num)
 		return;
@@ -6128,7 +6139,8 @@ static void hci_le_adv_report_evt(struct hci_dev *hdev, void *data,
 			rssi = info->data[info->length];
 			process_adv_report(hdev, info->type, &info->bdaddr,
 					   info->bdaddr_type, NULL, 0, rssi,
-					   info->data, info->length, false);
+					   info->data, info->length, false,
+					   false, instant);
 		} else {
 			bt_dev_err(hdev, "Dropping invalid advertising data");
 		}
@@ -6185,6 +6197,7 @@ static void hci_le_ext_adv_report_evt(struct hci_dev *hdev, void *data,
 				      struct sk_buff *skb)
 {
 	struct hci_ev_le_ext_adv_report *ev = data;
+	u32 instant = jiffies;
 
 	if (!ev->num)
 		return;
@@ -6211,7 +6224,8 @@ static void hci_le_ext_adv_report_evt(struct hci_dev *hdev, void *data,
 			process_adv_report(hdev, legacy_evt_type, &info->bdaddr,
 					   info->bdaddr_type, NULL, 0,
 					   info->rssi, info->data, info->length,
-					   !(evt_type & LE_EXT_ADV_LEGACY_PDU));
+					   !(evt_type & LE_EXT_ADV_LEGACY_PDU),
+					   false, instant);
 		}
 	}
 
@@ -6401,6 +6415,7 @@ static void hci_le_direct_adv_report_evt(struct hci_dev *hdev, void *data,
 					 struct sk_buff *skb)
 {
 	struct hci_ev_le_direct_adv_report *ev = data;
+	u32 instant = jiffies;
 	int i;
 
 	if (!hci_le_ev_skb_pull(hdev, skb, HCI_EV_LE_DIRECT_ADV_REPORT,
@@ -6418,7 +6433,7 @@ static void hci_le_direct_adv_report_evt(struct hci_dev *hdev, void *data,
 		process_adv_report(hdev, info->type, &info->bdaddr,
 				   info->bdaddr_type, &info->direct_addr,
 				   info->direct_addr_type, info->rssi, NULL, 0,
-				   false);
+				   false, false, instant);
 	}
 
 	hci_dev_unlock(hdev);
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 42c8047a9897..a9dbbf0e9a58 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -675,7 +675,12 @@ static void hci_req_start_scan(struct hci_request *req, u8 type, u16 interval,
 
 		memset(&ext_enable_cp, 0, sizeof(ext_enable_cp));
 		ext_enable_cp.enable = LE_SCAN_ENABLE;
-		ext_enable_cp.filter_dup = filter_dup;
+
+		/* Mesh protocols requires duplicate filtering to be disabled */
+		if (hci_dev_test_flag(hdev, HCI_MESH))
+			ext_enable_cp.filter_dup = LE_SCAN_FILTER_DUP_DISABLE;
+		else
+			ext_enable_cp.filter_dup = filter_dup;
 
 		hci_req_add(req, HCI_OP_LE_SET_EXT_SCAN_ENABLE,
 			    sizeof(ext_enable_cp), &ext_enable_cp);
@@ -683,18 +688,31 @@ static void hci_req_start_scan(struct hci_request *req, u8 type, u16 interval,
 		struct hci_cp_le_set_scan_param param_cp;
 		struct hci_cp_le_set_scan_enable enable_cp;
 
+		memset(&enable_cp, 0, sizeof(enable_cp));
+		hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(enable_cp),
+			    &enable_cp);
+
 		memset(&param_cp, 0, sizeof(param_cp));
 		param_cp.type = type;
 		param_cp.interval = cpu_to_le16(interval);
 		param_cp.window = cpu_to_le16(window);
 		param_cp.own_address_type = own_addr_type;
-		param_cp.filter_policy = filter_policy;
+		if (hci_dev_test_flag(hdev, HCI_MESH))
+			param_cp.filter_policy = 0;
+		else
+			param_cp.filter_policy = filter_policy;
 		hci_req_add(req, HCI_OP_LE_SET_SCAN_PARAM, sizeof(param_cp),
 			    &param_cp);
 
 		memset(&enable_cp, 0, sizeof(enable_cp));
 		enable_cp.enable = LE_SCAN_ENABLE;
-		enable_cp.filter_dup = filter_dup;
+
+		/* Mesh protocols requires duplicate filtering to be disabled */
+		if (hci_dev_test_flag(hdev, HCI_MESH))
+			enable_cp.filter_dup = LE_SCAN_FILTER_DUP_DISABLE;
+		else
+			enable_cp.filter_dup = filter_dup;
+
 		hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(enable_cp),
 			    &enable_cp);
 	}
@@ -825,7 +843,7 @@ static bool adv_cur_instance_is_scannable(struct hci_dev *hdev)
 
 void __hci_req_disable_advertising(struct hci_request *req)
 {
-	if (ext_adv_capable(req->hdev)) {
+	if (use_ext_adv(req->hdev)) {
 		__hci_req_disable_ext_adv_instance(req, 0x00);
 
 	} else {
@@ -911,8 +929,13 @@ void __hci_req_enable_advertising(struct hci_request *req)
 
 	/* If the "connectable" instance flag was not set, then choose between
 	 * ADV_IND and ADV_NONCONN_IND based on the global connectable setting.
+	 * If the controller has been enabled for mesh, all advertisements should
+	 * non-connectable, and non-resolvable private. TODO: bgix
 	 */
-	connectable = (flags & MGMT_ADV_FLAG_CONNECTABLE) ||
+	if (hci_dev_test_flag(hdev, HCI_MESH))
+		connectable = false;
+	else
+		connectable = (flags & MGMT_ADV_FLAG_CONNECTABLE) ||
 		      mgmt_get_connectable(hdev);
 
 	if (!is_advertising_allowed(hdev, connectable))
@@ -955,8 +978,12 @@ void __hci_req_enable_advertising(struct hci_request *req)
 		else
 			cp.type = LE_ADV_NONCONN_IND;
 
-		if (!hci_dev_test_flag(hdev, HCI_DISCOVERABLE) ||
-		    hci_dev_test_flag(hdev, HCI_LIMITED_DISCOVERABLE)) {
+		if (hci_dev_test_flag(hdev, HCI_MESH)) {
+			adv_min_interval = DISCOV_LE_ADV_MESH_MIN;
+			adv_max_interval = DISCOV_LE_ADV_MESH_MAX;
+			cp.filter_policy = 3;
+		} else if (!hci_dev_test_flag(hdev, HCI_DISCOVERABLE) ||
+			hci_dev_test_flag(hdev, HCI_LIMITED_DISCOVERABLE)) {
 			adv_min_interval = DISCOV_LE_FAST_ADV_INT_MIN;
 			adv_max_interval = DISCOV_LE_FAST_ADV_INT_MAX;
 		}
@@ -967,7 +994,8 @@ void __hci_req_enable_advertising(struct hci_request *req)
 	cp.own_address_type = own_addr_type;
 	cp.channel_map = hdev->le_adv_channel_map;
 
-	hci_req_add(req, HCI_OP_LE_SET_ADV_PARAM, sizeof(cp), &cp);
+	if (hdev->manufacturer != 0x000f || hdev->hci_rev != 0x16e4)
+		hci_req_add(req, HCI_OP_LE_SET_ADV_PARAM, sizeof(cp), &cp);
 
 	hci_req_add(req, HCI_OP_LE_SET_ADV_ENABLE, sizeof(enable), &enable);
 }
@@ -980,7 +1008,7 @@ void __hci_req_update_scan_rsp_data(struct hci_request *req, u8 instance)
 	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED))
 		return;
 
-	if (ext_adv_capable(hdev)) {
+	if (use_ext_adv(hdev)) {
 		struct {
 			struct hci_cp_le_set_ext_scan_rsp_data cp;
 			u8 data[HCI_MAX_EXT_AD_LENGTH];
@@ -1032,7 +1060,7 @@ void __hci_req_update_adv_data(struct hci_request *req, u8 instance)
 	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED))
 		return;
 
-	if (ext_adv_capable(hdev)) {
+	if (use_ext_adv(hdev)) {
 		struct {
 			struct hci_cp_le_set_ext_adv_data cp;
 			u8 data[HCI_MAX_EXT_AD_LENGTH];
@@ -1128,7 +1156,7 @@ void hci_req_reenable_advertising(struct hci_dev *hdev)
 		__hci_req_schedule_adv_instance(&req, hdev->cur_adv_instance,
 						true);
 	} else {
-		if (ext_adv_capable(hdev)) {
+		if (use_ext_adv(hdev)) {
 			__hci_req_start_ext_adv(&req, 0x00);
 		} else {
 			__hci_req_update_adv_data(&req, 0x00);
@@ -1603,7 +1631,7 @@ int __hci_req_schedule_adv_instance(struct hci_request *req, u8 instance,
 				adv_instance->remaining_time - timeout;
 
 	/* Only use work for scheduling instances with legacy advertising */
-	if (!ext_adv_capable(hdev)) {
+	if (!use_ext_adv(hdev)) {
 		hdev->adv_instance_timeout = timeout;
 		queue_delayed_work(hdev->req_workqueue,
 			   &hdev->adv_instance_expire,
@@ -1619,7 +1647,7 @@ int __hci_req_schedule_adv_instance(struct hci_request *req, u8 instance,
 		return 0;
 
 	hdev->cur_adv_instance = instance;
-	if (ext_adv_capable(hdev)) {
+	if (use_ext_adv(hdev)) {
 		__hci_req_start_ext_adv(req, instance);
 	} else {
 		__hci_req_update_adv_data(req, instance);
@@ -1691,7 +1719,7 @@ void hci_req_clear_adv_instance(struct hci_dev *hdev, struct sock *sk,
 	    hci_dev_test_flag(hdev, HCI_ADVERTISING))
 		return;
 
-	if (next_instance && !ext_adv_capable(hdev))
+	if (next_instance && !use_ext_adv(hdev))
 		__hci_req_schedule_adv_instance(req, next_instance->instance,
 						false);
 }
@@ -1941,7 +1969,7 @@ static int discoverable_update(struct hci_request *req, unsigned long opt)
 		 * address in limited privacy mode.
 		 */
 		if (hci_dev_test_flag(hdev, HCI_LIMITED_PRIVACY)) {
-			if (ext_adv_capable(hdev))
+			if (use_ext_adv(hdev))
 				__hci_req_start_ext_adv(req, 0x00);
 			else
 				__hci_req_enable_advertising(req);
@@ -2090,7 +2118,8 @@ static void le_scan_disable_work(struct work_struct *work)
 
 	bt_dev_dbg(hdev, "");
 
-	if (!hci_dev_test_flag(hdev, HCI_LE_SCAN))
+	if (!hci_dev_test_flag(hdev, HCI_LE_SCAN) ||
+				hci_dev_test_flag(hdev, HCI_MESH))
 		return;
 
 	cancel_delayed_work(&hdev->le_scan_restart);
@@ -2136,9 +2165,11 @@ static void le_scan_disable_work(struct work_struct *work)
 	return;
 
 discov_stopped:
-	hci_dev_lock(hdev);
-	hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
-	hci_dev_unlock(hdev);
+	if (!hci_dev_test_flag(hdev, HCI_MESH)) {
+		hci_dev_lock(hdev);
+		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
+		hci_dev_unlock(hdev);
+	}
 }
 
 static int le_scan_restart(struct hci_request *req, unsigned long opt)
@@ -2161,7 +2192,12 @@ static int le_scan_restart(struct hci_request *req, unsigned long opt)
 
 		memset(&ext_enable_cp, 0, sizeof(ext_enable_cp));
 		ext_enable_cp.enable = LE_SCAN_ENABLE;
-		ext_enable_cp.filter_dup = LE_SCAN_FILTER_DUP_ENABLE;
+
+		/* Mesh protocols requires duplicate filtering to be disabled */
+		if (hci_dev_test_flag(hdev, HCI_MESH))
+			ext_enable_cp.filter_dup = LE_SCAN_FILTER_DUP_DISABLE;
+		else
+			ext_enable_cp.filter_dup = LE_SCAN_FILTER_DUP_ENABLE;
 
 		hci_req_add(req, HCI_OP_LE_SET_EXT_SCAN_ENABLE,
 			    sizeof(ext_enable_cp), &ext_enable_cp);
@@ -2170,7 +2206,13 @@ static int le_scan_restart(struct hci_request *req, unsigned long opt)
 
 		memset(&cp, 0, sizeof(cp));
 		cp.enable = LE_SCAN_ENABLE;
-		cp.filter_dup = LE_SCAN_FILTER_DUP_ENABLE;
+
+		/* Mesh protocols requires duplicate filtering to be disabled */
+		if (hci_dev_test_flag(hdev, HCI_MESH))
+			cp.filter_dup = LE_SCAN_FILTER_DUP_DISABLE;
+		else
+			cp.filter_dup = LE_SCAN_FILTER_DUP_ENABLE;
+
 		hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
 	}
 
@@ -2283,6 +2325,21 @@ static int active_scan(struct hci_request *req, unsigned long opt)
 	return 0;
 }
 
+static int mesh_scan(struct hci_request *req, unsigned long opt)
+{
+	struct hci_dev *hdev = req->hdev;
+	u16 window = hdev->le_scan_window;
+
+	BT_INFO("MESH-SCAN %s", hdev->name);
+
+	/* In Mesh mode we are always at least passive scanning,
+	 * with no filtering */
+
+	hci_req_start_scan(req, LE_SCAN_PASSIVE, window, window,
+			   0x00, 0x00, false, false);
+	return 0;
+}
+
 static int interleaved_discov(struct hci_request *req, unsigned long opt)
 {
 	int err;
@@ -2337,8 +2394,16 @@ static void start_discovery(struct hci_dev *hdev, u8 *status)
 		break;
 	case DISCOV_TYPE_LE:
 		timeout = msecs_to_jiffies(DISCOV_LE_TIMEOUT);
-		hci_req_sync(hdev, active_scan, hdev->le_scan_int_discovery,
-			     HCI_CMD_TIMEOUT, status);
+		if (hci_dev_test_flag(hdev, HCI_MESH)) {
+			BT_INFO("LE Discovery - (passive)");
+			hci_req_sync(hdev, mesh_scan, DISCOV_LE_SCAN_INT,
+					HCI_CMD_TIMEOUT, status);
+		} else {
+			BT_INFO("LE Discovery - (active)");
+			hci_req_sync(hdev, active_scan,
+					hdev->le_scan_int_discovery,
+					HCI_CMD_TIMEOUT, status);
+		}
 		break;
 	default:
 		*status = HCI_ERROR_UNSPECIFIED;
@@ -2566,7 +2631,7 @@ static int powered_update_hci(struct hci_request *req, unsigned long opt)
 		    list_empty(&hdev->adv_instances)) {
 			int err;
 
-			if (ext_adv_capable(hdev)) {
+			if (use_ext_adv(hdev)) {
 				err = __hci_req_setup_ext_adv_instance(req,
 								       0x00);
 				if (!err)
@@ -2579,7 +2644,7 @@ static int powered_update_hci(struct hci_request *req, unsigned long opt)
 			}
 
 			if (hci_dev_test_flag(hdev, HCI_ADVERTISING)) {
-				if (!ext_adv_capable(hdev))
+				if (!use_ext_adv(hdev))
 					__hci_req_enable_advertising(req);
 				else if (!err)
 					__hci_req_enable_ext_advertising(req,
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 8f4c5698913d..bce36f83021e 100644
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
 
@@ -898,7 +898,7 @@ int hci_update_scan_rsp_data_sync(struct hci_dev *hdev, u8 instance)
 	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED))
 		return 0;
 
-	if (ext_adv_capable(hdev))
+	if (use_ext_adv(hdev))
 		return hci_set_ext_scan_rsp_data_sync(hdev, instance);
 
 	return __hci_set_scan_rsp_data_sync(hdev, instance);
@@ -969,7 +969,7 @@ static int hci_start_adv_sync(struct hci_dev *hdev, u8 instance)
 {
 	int err;
 
-	if (ext_adv_capable(hdev))
+	if (use_ext_adv(hdev))
 		return hci_start_ext_adv_sync(hdev, instance);
 
 	err = hci_update_adv_data_sync(hdev, instance);
@@ -993,7 +993,7 @@ int hci_enable_advertising_sync(struct hci_dev *hdev)
 	u32 flags;
 	u8 status;
 
-	if (ext_adv_capable(hdev))
+	if (use_ext_adv(hdev))
 		return hci_enable_ext_advertising_sync(hdev,
 						       hdev->cur_adv_instance);
 
@@ -1142,6 +1142,47 @@ static int hci_set_ext_adv_data_sync(struct hci_dev *hdev, u8 instance)
 				     HCI_CMD_TIMEOUT);
 }
 
+int hci_mesh_send_sync(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 bdaddr_type,
+							u8 *data, u8 len)
+{
+	struct hci_cp_le_set_adv_data cp_data;
+	struct hci_cp_le_set_adv_param cp_param;
+	u8 own_addr_type, enable;
+	int err;
+
+	memset(&cp_data, 0, sizeof(cp_data));
+	cp_data.length = len + 1;
+	cp_data.data[0] = len;
+	memcpy(cp_data.data + 1, data, len);
+
+	hci_update_random_address_sync(hdev, true, false, &own_addr_type);
+
+	memset(&cp_param, 0, sizeof(cp_param));
+	cp_param.type = LE_ADV_NONCONN_IND;
+	cp_param.min_interval = cpu_to_le16(DISCOV_LE_ADV_MESH_MIN);
+	cp_param.max_interval = cpu_to_le16(DISCOV_LE_ADV_MESH_MAX);
+	cp_param.own_address_type = 1;
+	cp_param.channel_map = 7;
+	cp_param.filter_policy = 3;
+
+	__hci_cmd_sync_status(hdev, HCI_OP_LE_SET_ADV_PARAM,
+				       sizeof(cp_param), &cp_param,
+				       HCI_CMD_TIMEOUT);
+
+	err = __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_ADV_DATA,
+			     sizeof(cp_data), &cp_data, HCI_CMD_TIMEOUT);
+
+	if (err)
+		return err;
+
+	memcpy(hdev->adv_data, cp_data.data, sizeof(cp_data.data));
+	hdev->adv_data_len = len;
+
+	enable = 0x01;
+	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_ADV_ENABLE,
+				     sizeof(enable), &enable, HCI_CMD_TIMEOUT);
+}
+
 static int hci_set_adv_data_sync(struct hci_dev *hdev, u8 instance)
 {
 	struct hci_cp_le_set_adv_data cp;
@@ -1170,7 +1211,7 @@ int hci_update_adv_data_sync(struct hci_dev *hdev, u8 instance)
 	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED))
 		return 0;
 
-	if (ext_adv_capable(hdev))
+	if (use_ext_adv(hdev))
 		return hci_set_ext_adv_data_sync(hdev, instance);
 
 	return hci_set_adv_data_sync(hdev, instance);
@@ -1182,7 +1223,7 @@ int hci_schedule_adv_instance_sync(struct hci_dev *hdev, u8 instance,
 	struct adv_info *adv = NULL;
 	u16 timeout;
 
-	if (hci_dev_test_flag(hdev, HCI_ADVERTISING) && !ext_adv_capable(hdev))
+	if (hci_dev_test_flag(hdev, HCI_ADVERTISING) && !use_ext_adv(hdev))
 		return -EPERM;
 
 	if (hdev->adv_instance_timeout)
@@ -1212,7 +1253,7 @@ int hci_schedule_adv_instance_sync(struct hci_dev *hdev, u8 instance,
 		adv->remaining_time = adv->remaining_time - timeout;
 
 	/* Only use work for scheduling instances with legacy advertising */
-	if (!ext_adv_capable(hdev)) {
+	if (!use_ext_adv(hdev)) {
 		hdev->adv_instance_timeout = timeout;
 		queue_delayed_work(hdev->req_workqueue,
 				   &hdev->adv_instance_expire,
@@ -1251,10 +1292,13 @@ static int hci_clear_adv_sets_sync(struct hci_dev *hdev, struct sock *sk)
 static int hci_clear_adv_sync(struct hci_dev *hdev, struct sock *sk, bool force)
 {
 	struct adv_info *adv, *n;
+	int err = 0;
 
 	if (ext_adv_capable(hdev))
 		/* Remove all existing sets */
-		return hci_clear_adv_sets_sync(hdev, sk);
+		err = hci_clear_adv_sets_sync(hdev, sk);
+	if (use_ext_adv(hdev))
+		return err;
 
 	/* This is safe as long as there is no command send while the lock is
 	 * held.
@@ -1282,11 +1326,13 @@ static int hci_clear_adv_sync(struct hci_dev *hdev, struct sock *sk, bool force)
 static int hci_remove_adv_sync(struct hci_dev *hdev, u8 instance,
 			       struct sock *sk)
 {
-	int err;
+	int err = 0;
 
 	/* If we use extended advertising, instance has to be removed first. */
 	if (ext_adv_capable(hdev))
-		return hci_remove_ext_adv_instance_sync(hdev, instance, sk);
+		err = hci_remove_ext_adv_instance_sync(hdev, instance, sk);
+	if (use_ext_adv(hdev))
+		return err;
 
 	/* This is safe as long as there is no command send while the lock is
 	 * held.
@@ -1351,7 +1397,7 @@ int hci_remove_advertising_sync(struct hci_dev *hdev, struct sock *sk,
 	if (!hdev_is_powered(hdev) || hci_dev_test_flag(hdev, HCI_ADVERTISING))
 		return 0;
 
-	if (next && !ext_adv_capable(hdev))
+	if (next && !use_ext_adv(hdev))
 		hci_schedule_adv_instance_sync(hdev, next->instance, false);
 
 	return 0;
@@ -1385,13 +1431,16 @@ int hci_read_tx_power_sync(struct hci_dev *hdev, __le16 handle, u8 type)
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
+	if (use_ext_adv(hdev))
+		return err;
 
 	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_ADV_ENABLE,
 				     sizeof(enable), &enable, HCI_CMD_TIMEOUT);
@@ -1404,7 +1453,11 @@ static int hci_le_set_ext_scan_enable_sync(struct hci_dev *hdev, u8 val,
 
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
@@ -1420,7 +1473,11 @@ static int hci_le_set_scan_enable_sync(struct hci_dev *hdev, u8 val,
 
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
@@ -1755,7 +1812,7 @@ static int hci_pause_advertising_sync(struct hci_dev *hdev)
 		return err;
 
 	/* If we are using software rotation, pause the loop */
-	if (!ext_adv_capable(hdev))
+	if (!use_ext_adv(hdev))
 		cancel_adv_timeout(hdev);
 
 	hdev->advertising_paused = true;
@@ -1783,7 +1840,7 @@ static int hci_resume_advertising_sync(struct hci_dev *hdev)
 
 	bt_dev_dbg(hdev, "Resuming advertising instances");
 
-	if (ext_adv_capable(hdev)) {
+	if (use_ext_adv(hdev)) {
 		/* Call for each tracked instance to be re-enabled */
 		list_for_each_entry_safe(adv, tmp, &hdev->adv_instances, list) {
 			err = hci_enable_ext_advertising_sync(hdev,
@@ -2054,6 +2111,7 @@ static int hci_passive_scan_sync(struct hci_dev *hdev)
 	u8 own_addr_type;
 	u8 filter_policy;
 	u16 window, interval;
+	u8 filter_dups = LE_SCAN_FILTER_DUP_ENABLE;
 	int err;
 
 	if (hdev->scanning_paused) {
@@ -2116,11 +2174,16 @@ static int hci_passive_scan_sync(struct hci_dev *hdev)
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
@@ -2170,7 +2233,8 @@ int hci_update_passive_scan_sync(struct hci_dev *hdev)
 	bt_dev_dbg(hdev, "ADV monitoring is %s",
 		   hci_is_adv_monitoring(hdev) ? "on" : "off");
 
-	if (list_empty(&hdev->pend_le_conns) &&
+	if (!hci_dev_test_flag(hdev, HCI_MESH) &&
+	    list_empty(&hdev->pend_le_conns) &&
 	    list_empty(&hdev->pend_le_reports) &&
 	    !hci_is_adv_monitoring(hdev)) {
 		/* If there is no pending LE connections or devices
@@ -2318,7 +2382,7 @@ static int hci_powered_update_adv_sync(struct hci_dev *hdev)
 	 */
 	if (hci_dev_test_flag(hdev, HCI_ADVERTISING) ||
 	    list_empty(&hdev->adv_instances)) {
-		if (ext_adv_capable(hdev)) {
+		if (use_ext_adv(hdev)) {
 			err = hci_setup_ext_adv_instance_sync(hdev, 0x00);
 			if (!err)
 				hci_update_scan_rsp_data_sync(hdev, 0x00);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index d2d390534e54..642e6086274d 100644
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
@@ -1002,7 +1006,7 @@ static int rpa_expired_sync(struct hci_dev *hdev, void *data)
 	 * controller happens in the hci_req_enable_advertising()
 	 * function.
 	 */
-	if (ext_adv_capable(hdev))
+	if (use_ext_adv(hdev))
 		return hci_start_ext_adv_sync(hdev, hdev->cur_adv_instance);
 	else
 		return hci_enable_advertising_sync(hdev);
@@ -1023,13 +1027,72 @@ static void rpa_expired(struct work_struct *work)
 	hci_cmd_sync_queue(hdev, rpa_expired_sync, NULL, NULL);
 }
 
+static int send_settings_rsp(struct sock *sk, u16 opcode, struct hci_dev *hdev);
+
+static void mesh_send_complete(struct hci_dev *hdev,
+						struct mgmt_mesh_tx *mesh_tx)
+{
+	u8 handle = mesh_tx->handle;
+
+	mgmt_event(MGMT_EV_MESH_PACKET_CMPLT, hdev, &handle, sizeof(handle),
+								NULL);
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
+	mesh_tx = mgmt_mesh_next(hdev);
+
+	if (mesh_tx)
+		mesh_send_complete(hdev, mesh_tx);
+
+	return 0;
+}
+
+static int mesh_send_sync(struct hci_dev *hdev, void *data);
+static void mesh_send_start_complete(struct hci_dev *hdev, void *data, int err);
+static void mesh_next(struct hci_dev *hdev, void *data, int err)
+{
+	struct mgmt_mesh_tx *mesh_tx = mgmt_mesh_next(hdev);
+
+	if (!mesh_tx)
+		return;
+
+	err = hci_cmd_sync_queue(hdev, mesh_send_sync, mesh_tx,
+			mesh_send_start_complete);
+
+	if (err < 0)
+		mesh_send_complete(hdev, mesh_tx);
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
 		return;
 
+	BT_INFO("MGMT ver %d.%d", MGMT_VERSION, MGMT_REVISION);
+
 	INIT_DELAYED_WORK(&hdev->service_cache, service_cache_off);
 	INIT_DELAYED_WORK(&hdev->rpa_expired, rpa_expired);
+	INIT_DELAYED_WORK(&hdev->mesh_send_done, mesh_send_done);
 
 	/* Non-mgmt controlled devices get this bit set
 	 * implicitly so that pairing works for them, however
@@ -2029,6 +2092,7 @@ static int set_le_sync(struct hci_dev *hdev, void *data)
 	u8 val = !!cp->val;
 	int err;
 
+
 	if (!val) {
 		if (hci_dev_test_flag(hdev, HCI_LE_ADV))
 			hci_disable_advertising_sync(hdev);
@@ -2047,7 +2111,7 @@ static int set_le_sync(struct hci_dev *hdev, void *data)
 	 * update in powered_update_hci will take care of it.
 	 */
 	if (!err && hci_dev_test_flag(hdev, HCI_LE_ENABLED)) {
-		if (ext_adv_capable(hdev)) {
+		if (use_ext_adv(hdev)) {
 			int status;
 
 			status = hci_setup_ext_adv_instance_sync(hdev, 0x00);
@@ -2064,6 +2128,282 @@ static int set_le_sync(struct hci_dev *hdev, void *data)
 	return err;
 }
 
+static void set_mesh_complete(struct hci_dev *hdev, void *data, int err)
+{
+	struct mgmt_pending_cmd *cmd = data;
+	u8 status = mgmt_status(err);
+	struct sock *sk = cmd->sk;
+	u8 slots;
+
+	if (status) {
+		mgmt_pending_foreach(MGMT_OP_SET_MESH_RECEIVER, hdev,
+						cmd_status_rsp, &status);
+		return;
+	}
+
+	if (hci_dev_test_flag(hdev, HCI_MESH))
+		slots = 1;
+	else
+		slots = 0;
+
+	mgmt_pending_remove(cmd);
+	mgmt_cmd_complete(sk, hdev->id, MGMT_OP_SET_MESH_RECEIVER, 0,
+								&slots, 1);
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
+						set_mesh_complete);
+
+
+	if (err < 0) {
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_MESH_RECEIVER,
+						MGMT_STATUS_FAILED);
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
+	struct mgmt_cp_mesh_send *send = (void *) mesh_tx->param;
+	unsigned long mesh_send_interval;
+	u8 mgmt_err = mgmt_status(err);
+
+	/* Report any errors here, but don't report completion */
+
+	if (mgmt_err) {
+		hci_dev_clear_flag(hdev, HCI_MESH_SENDING);
+		/* Send Complete Error Code for handle */
+		mesh_send_complete(hdev, mesh_tx);
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
+	struct mgmt_cp_mesh_send *send = (void *) mesh_tx->param;
+	u8 len = mesh_tx->param_len - sizeof(*send);
+
+	if (hci_dev_test_flag(hdev, HCI_LE_ADV))
+		return MGMT_STATUS_BUSY;
+
+	return hci_mesh_send_sync(hdev, &send->addr.bdaddr, send->addr.type,
+							send->data, len);
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
+						void *data, u16 len)
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
+		mgmt_mesh_foreach(hdev, send_count, &rp);
+
+	mgmt_cmd_complete(sk, hdev->id, MGMT_OP_MESH_READ_FEATURES, 0, &rp,
+			rp.used_handles + sizeof(rp) - MESH_HANDLES_MAX);
+
+	hci_dev_unlock(hdev);
+	return 0;
+}
+
+static int send_cancel(struct hci_dev *hdev, void *data)
+{
+	struct mgmt_pending_cmd *cmd = data;
+	struct mgmt_cp_mesh_send_cancel *cancel = (void *) cmd->param;
+	struct mgmt_mesh_tx *mesh_tx;
+
+	if (!cancel->handle) {
+		do {
+			mesh_tx = mgmt_mesh_next(hdev);
+
+			if (mesh_tx)
+				mesh_send_complete(hdev, mesh_tx);
+		} while (mesh_tx);
+	} else {
+		mesh_tx = mgmt_mesh_find(hdev, cancel->handle);
+
+		if (mesh_tx)
+			mesh_send_complete(hdev, mesh_tx);
+	}
+
+	mgmt_cmd_complete(cmd->sk, hdev->id, MGMT_OP_MESH_SEND_CANCEL,
+								0, NULL, 0);
+	mgmt_pending_free(cmd);
+
+	return 0;
+}
+
+static int mesh_send_cancel(struct sock *sk, struct hci_dev *hdev,
+						void *data, u16 len)
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
+					len <= MGMT_MESH_SEND_SIZE ||
+					len > (MGMT_MESH_SEND_SIZE + 29))
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_MESH_SEND,
+				       MGMT_STATUS_REJECTED);
+
+	hci_dev_lock(hdev);
+
+	memset(&rp, 0, sizeof(rp));
+	rp.max_handles = MESH_HANDLES_MAX;
+
+	mgmt_mesh_foreach(hdev, send_count, &rp);
+
+	if (rp.max_handles <= rp.used_handles) {
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_MESH_SEND,
+							MGMT_STATUS_BUSY);
+		goto done;
+	}
+
+
+	sending = hci_dev_test_flag(hdev, HCI_MESH_SENDING);
+	mesh_tx = mgmt_mesh_add(sk, hdev, send, len);
+
+	if (!mesh_tx)
+		err = -ENOMEM;
+	else if (!sending)
+		err = hci_cmd_sync_queue(hdev, mesh_send_sync, mesh_tx,
+						mesh_send_start_complete);
+
+	if (err < 0) {
+		bt_dev_err(hdev, "Send Mesh Failed %d", err);
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_MESH_SEND,
+						MGMT_STATUS_FAILED);
+
+		if (mesh_tx) {
+			if (sending)
+				mgmt_mesh_remove(mesh_tx);
+		}
+	} else {
+		u8 handle;
+
+		hci_dev_set_flag(hdev, HCI_MESH_SENDING);
+
+		/* Switch to result with handle */
+		hdev->mesh_send_ref++;
+		if (!hdev->mesh_send_ref)
+			hdev->mesh_send_ref++;
+
+		handle = hdev->mesh_send_ref;
+		mesh_tx->handle = handle;
+		mgmt_cmd_complete(sk, hdev->id, MGMT_OP_MESH_SEND, 0, &handle, 1);
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
@@ -5816,7 +6156,7 @@ static int set_adv_sync(struct hci_dev *hdev, void *data)
 		 */
 		hdev->cur_adv_instance = 0x00;
 
-		if (ext_adv_capable(hdev)) {
+		if (use_ext_adv(hdev)) {
 			hci_start_ext_adv_sync(hdev, 0x00);
 		} else {
 			hci_update_adv_data_sync(hdev, 0x00);
@@ -5865,6 +6205,7 @@ static int set_advertising(struct sock *sk, struct hci_dev *hdev, void *data,
 	if (!hdev_is_powered(hdev) ||
 	    (val == hci_dev_test_flag(hdev, HCI_ADVERTISING) &&
 	     (cp->val == 0x02) == hci_dev_test_flag(hdev, HCI_ADVERTISING_CONNECTABLE)) ||
+	    hci_dev_test_flag(hdev, HCI_MESH) ||
 	    hci_conn_num(hdev, LE_LINK) > 0 ||
 	    (hci_dev_test_flag(hdev, HCI_LE_SCAN) &&
 	     hdev->le_scan_type == LE_SCAN_ACTIVE)) {
@@ -7822,11 +8163,10 @@ static u32 get_supported_adv_flags(struct hci_dev *hdev)
 	/* In extended adv TX_POWER returned from Set Adv Param
 	 * will be always valid.
 	 */
-	if ((hdev->adv_tx_power != HCI_TX_POWER_INVALID) ||
-	    ext_adv_capable(hdev))
+	if ((hdev->adv_tx_power != HCI_TX_POWER_INVALID) || use_ext_adv(hdev))
 		flags |= MGMT_ADV_FLAG_TX_POWER;
 
-	if (ext_adv_capable(hdev)) {
+	if (use_ext_adv(hdev)) {
 		flags |= MGMT_ADV_FLAG_SEC_1M;
 		flags |= MGMT_ADV_FLAG_HW_OFFLOAD;
 		flags |= MGMT_ADV_FLAG_CAN_SET_TX_POWER;
@@ -8788,8 +9128,13 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
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
@@ -9722,14 +10067,85 @@ static void mgmt_adv_monitor_device_found(struct hci_dev *hdev,
 		kfree_skb(skb);
 }
 
+static void mesh_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr,
+		       u8 addr_type, s8 rssi, u32 flags, u8 *eir, u16 eir_len,
+		       u8 *scan_rsp, u8 scan_rsp_len, u32 instant)
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
+	ev->instant = instant;
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
+		       u32 instant)
 {
 	struct sk_buff *skb;
 	struct mgmt_ev_device_found *ev;
 	bool report_device = hci_discovery_active(hdev);
 
+	if (hci_dev_test_flag(hdev, HCI_MESH) && link_type == LE_LINK)
+		mesh_device_found(hdev, bdaddr, addr_type, rssi, flags,
+				eir, eir_len, scan_rsp, scan_rsp_len, instant);
+
 	/* Don't send events for a non-kernel initiated discovery. With
 	 * LE one exception is if we have pend_le_reports > 0 in which
 	 * case we're doing passive scanning and want these events.
diff --git a/net/bluetooth/mgmt_util.c b/net/bluetooth/mgmt_util.c
index b69cfed62088..0498efdc876c 100644
--- a/net/bluetooth/mgmt_util.c
+++ b/net/bluetooth/mgmt_util.c
@@ -314,3 +314,61 @@ void mgmt_pending_remove(struct mgmt_pending_cmd *cmd)
 	list_del(&cmd->list);
 	mgmt_pending_free(cmd);
 }
+
+void mgmt_mesh_foreach(struct hci_dev *hdev,
+			  void (*cb)(struct mgmt_mesh_tx *mesh_tx, void *data),
+			  void *data)
+{
+	struct mgmt_mesh_tx *mesh_tx, *tmp;
+
+	list_for_each_entry_safe(mesh_tx, tmp, &hdev->mgmt_pending, list) {
+		cb(mesh_tx, data);
+	}
+}
+
+struct mgmt_mesh_tx *mgmt_mesh_next(struct hci_dev *hdev)
+{
+	if (list_empty(&hdev->mesh_pending))
+		return NULL;
+
+	return list_first_entry(&hdev->mesh_pending, struct mgmt_mesh_tx, list);
+}
+
+struct mgmt_mesh_tx *mgmt_mesh_find(struct hci_dev *hdev, u8 handle)
+{
+	struct mgmt_mesh_tx *mesh_tx;
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
index 98e40395a383..54930b18038e 100644
--- a/net/bluetooth/mgmt_util.h
+++ b/net/bluetooth/mgmt_util.h
@@ -20,6 +20,15 @@
    SOFTWARE IS DISCLAIMED.
 */
 
+struct mgmt_mesh_tx {
+	struct list_head list;
+	int index;
+	size_t param_len;
+	struct sock *sk;
+	u8 handle;
+	u8 param[sizeof(struct mgmt_cp_mesh_send) + 29];
+};
+
 struct mgmt_pending_cmd {
 	struct list_head list;
 	u16 opcode;
@@ -59,3 +68,11 @@ struct mgmt_pending_cmd *mgmt_pending_new(struct sock *sk, u16 opcode,
 					  void *data, u16 len);
 void mgmt_pending_free(struct mgmt_pending_cmd *cmd);
 void mgmt_pending_remove(struct mgmt_pending_cmd *cmd);
+void mgmt_mesh_foreach(struct hci_dev *hdev,
+			  void (*cb)(struct mgmt_mesh_tx *mesh_tx, void *data),
+			  void *data);
+struct mgmt_mesh_tx *mgmt_mesh_find(struct hci_dev *hdev, u8 handle);
+struct mgmt_mesh_tx *mgmt_mesh_next(struct hci_dev *hdev);
+struct mgmt_mesh_tx *mgmt_mesh_add(struct sock *sk, struct hci_dev *hdev,
+				   void *data, u16 len);
+void mgmt_mesh_remove(struct mgmt_mesh_tx *mesh_tx);
-- 
2.35.1

