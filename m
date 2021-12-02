Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF38C433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Dec 2021 22:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347891AbhLBW3w (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Dec 2021 17:29:52 -0500
Received: from mga04.intel.com ([192.55.52.120]:49807 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347710AbhLBW3v (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Dec 2021 17:29:51 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10186"; a="235591266"
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="235591266"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 14:26:28 -0800
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="513398900"
Received: from srami-mobl.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.212.228.98])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 14:26:28 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, brian.gix@intel.com, luiz.dentz@gmail.com
Subject: [PATCH 2/2] Bluetooth: Implement support for Mesh
Date:   Thu,  2 Dec 2021 14:26:19 -0800
Message-Id: <20211202222619.626678-3-brian.gix@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211202222619.626678-1-brian.gix@intel.com>
References: <20211202222619.626678-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The patch adds state bits, storage and HCI command chains for sending
and recieving Bluetooth Mesh advertising packets, and delivery to
requesting user space processes.

Signed-off-by: Brian Gix <brian.gix@intel.com>
---
 include/net/bluetooth/hci.h      |   5 +
 include/net/bluetooth/hci_core.h |  16 ++-
 include/net/bluetooth/hci_sync.h |   2 +
 net/bluetooth/hci_conn.c         |   4 +-
 net/bluetooth/hci_event.c        |  61 +++++----
 net/bluetooth/hci_request.c      | 119 ++++++++++++++----
 net/bluetooth/hci_sync.c         |  94 +++++++++++---
 net/bluetooth/mgmt.c             | 208 +++++++++++++++++++++++++++++--
 8 files changed, 430 insertions(+), 79 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 0d2a9216869b..74bc9d24be1e 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -333,6 +333,11 @@ enum {
 	HCI_QUALITY_REPORT,
 	HCI_OFFLOAD_CODECS_ENABLED,
 
+	HCI_MESH,
+	HCI_MESH_SENDING,
+	HCI_MESH_ACTIVE,
+	HCI_MESH_JIFFIES,
+
 	__HCI_NUM_FLAGS,
 };
 
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 7bae8376fd6f..f3c0608eecda 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -345,6 +345,7 @@ struct hci_dev {
 	__u8		le_resolv_list_size;
 	__u8		le_num_of_adv_sets;
 	__u8		le_states[8];
+	__u8		mesh_ad_types[16];
 	__u8		commands[64];
 	__u8		hci_ver;
 	__u16		hci_rev;
@@ -581,6 +582,8 @@ struct hci_dev {
 	struct delayed_work	rpa_expired;
 	bdaddr_t		rpa;
 
+	struct delayed_work	mesh_send_done;
+
 	enum {
 		INTERLEAVE_SCAN_NONE,
 		INTERLEAVE_SCAN_NO_FILTER,
@@ -1471,13 +1474,19 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 
 /* Use ext scanning if set ext scan param and ext scan enable is supported */
 #define use_ext_scan(dev) (((dev)->commands[37] & 0x20) && \
-			   ((dev)->commands[37] & 0x40))
+			   ((dev)->commands[37] & 0x40) && \
+			   !hci_dev_test_flag(dev, HCI_MESH))
+
 /* Use ext create connection if command is supported */
 #define use_ext_conn(dev) ((dev)->commands[37] & 0x80)
 
 /* Extended advertising support */
 #define ext_adv_capable(dev) (((dev)->le_features[1] & HCI_LE_EXT_ADV))
 
+/* Use ext advertising if supported and not running Mesh */
+#define use_ext_adv(dev) (ext_adv_capable(dev) && \
+			  !hci_dev_test_flag(dev, HCI_MESH))
+
 /* ----- HCI protocols ----- */
 #define HCI_PROTO_DEFER             0x01
 
@@ -1759,6 +1768,8 @@ void hci_mgmt_chan_unregister(struct hci_mgmt_chan *c);
 #define DISCOV_LE_RESTART_DELAY		msecs_to_jiffies(200)	/* msec */
 #define DISCOV_LE_FAST_ADV_INT_MIN	0x00A0	/* 100 msec */
 #define DISCOV_LE_FAST_ADV_INT_MAX	0x00F0	/* 150 msec */
+#define DISCOV_LE_ADV_MESH_MIN		0x00A0  /* 100 msec */
+#define DISCOV_LE_ADV_MESH_MAX		0x00A0  /* 100 msec */
 
 #define NAME_RESOLVE_DURATION		msecs_to_jiffies(10240)	/* 10.24 sec */
 
@@ -1810,7 +1821,8 @@ void mgmt_start_discovery_complete(struct hci_dev *hdev, u8 status);
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
index 0336c1bc5d25..0339e6881750 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -83,6 +83,8 @@ int hci_remove_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance,
 struct sk_buff *hci_read_local_oob_data_sync(struct hci_dev *hdev, bool ext,
 					     struct sock *sk);
 
+int hci_mesh_send_sync(struct hci_dev *hdev, u8 *data, u8 len);
+
 int hci_reset_sync(struct hci_dev *hdev);
 int hci_dev_open_sync(struct hci_dev *hdev);
 int hci_dev_close_sync(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index cd6e1cf7e396..e3d2b59c5ae5 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -638,7 +638,7 @@ static void hci_conn_auto_accept(struct work_struct *work)
 
 static void le_disable_advertising(struct hci_dev *hdev)
 {
-	if (ext_adv_capable(hdev)) {
+	if (use_ext_adv(hdev)) {
 		struct hci_cp_le_set_ext_adv_enable cp;
 
 		cp.enable = 0x00;
@@ -1063,7 +1063,7 @@ static void hci_req_directed_advertising(struct hci_request *req,
 	u8 own_addr_type;
 	u8 enable;
 
-	if (ext_adv_capable(hdev)) {
+	if (use_ext_adv(hdev)) {
 		struct hci_cp_le_set_ext_adv_params cp;
 		bdaddr_t random_addr;
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 9d8d2d9e5d1f..1316cd8561bb 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1486,6 +1486,8 @@ static void le_set_scan_enable_complete(struct hci_dev *hdev, u8 enable)
 		hci_dev_set_flag(hdev, HCI_LE_SCAN);
 		if (hdev->le_scan_type == LE_SCAN_ACTIVE)
 			clear_pending_adv_report(hdev);
+		if (hci_dev_test_flag(hdev, HCI_MESH))
+			hci_discovery_set_state(hdev, DISCOVERY_FINDING);
 		break;
 
 	case LE_SCAN_DISABLE:
@@ -1500,7 +1502,7 @@ static void le_set_scan_enable_complete(struct hci_dev *hdev, u8 enable)
 					  d->last_adv_addr_type, NULL,
 					  d->last_adv_rssi, d->last_adv_flags,
 					  d->last_adv_data,
-					  d->last_adv_data_len, NULL, 0);
+					  d->last_adv_data_len, NULL, 0, 0);
 		}
 
 		/* Cancel this timer so that we don't try to disable scanning
@@ -1516,6 +1518,9 @@ static void le_set_scan_enable_complete(struct hci_dev *hdev, u8 enable)
 		 */
 		if (hci_dev_test_and_clear_flag(hdev, HCI_LE_SCAN_INTERRUPTED))
 			hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
+		else if (!hci_dev_test_flag(hdev, HCI_LE_ADV) &&
+			 hdev->discovery.state == DISCOVERY_FINDING)
+			hci_req_reenable_advertising(hdev);
 
 		break;
 
@@ -2772,7 +2777,7 @@ static void hci_inquiry_result_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 		mgmt_device_found(hdev, &info->bdaddr, ACL_LINK, 0x00,
 				  info->dev_class, HCI_RSSI_INVALID,
-				  flags, NULL, 0, NULL, 0);
+				  flags, NULL, 0, NULL, 0, 0);
 	}
 
 	hci_dev_unlock(hdev);
@@ -4433,7 +4438,7 @@ static void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev,
 
 			mgmt_device_found(hdev, &info->bdaddr, ACL_LINK, 0x00,
 					  info->dev_class, info->rssi,
-					  flags, NULL, 0, NULL, 0);
+					  flags, NULL, 0, NULL, 0, 0);
 		}
 	} else {
 		struct inquiry_info_with_rssi *info = (void *) (skb->data + 1);
@@ -4457,7 +4462,7 @@ static void hci_inquiry_result_with_rssi_evt(struct hci_dev *hdev,
 
 			mgmt_device_found(hdev, &info->bdaddr, ACL_LINK, 0x00,
 					  info->dev_class, info->rssi,
-					  flags, NULL, 0, NULL, 0);
+					  flags, NULL, 0, NULL, 0, 0);
 		}
 	}
 
@@ -4688,7 +4693,7 @@ static void hci_extended_inquiry_result_evt(struct hci_dev *hdev,
 
 		mgmt_device_found(hdev, &info->bdaddr, ACL_LINK, 0x00,
 				  info->dev_class, info->rssi,
-				  flags, info->data, eir_len, NULL, 0);
+				  flags, info->data, eir_len, NULL, 0, 0);
 	}
 
 	hci_dev_unlock(hdev);
@@ -5709,7 +5714,7 @@ static struct hci_conn *check_pending_le_conn(struct hci_dev *hdev,
 static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 			       u8 bdaddr_type, bdaddr_t *direct_addr,
 			       u8 direct_addr_type, s8 rssi, u8 *data, u8 len,
-			       bool ext_adv)
+			       bool ext_adv, bool ctl_time, u32 instant)
 {
 	struct discovery_state *d = &hdev->discovery;
 	struct smp_irk *irk;
@@ -5757,7 +5762,7 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 	 * important to see if the address is matching the local
 	 * controller address.
 	 */
-	if (direct_addr) {
+	if (!hci_dev_test_flag(hdev, HCI_MESH) && direct_addr) {
 		direct_addr_type = ev_bdaddr_type(hdev, direct_addr_type,
 						  &bdaddr_resolved);
 
@@ -5805,6 +5810,18 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
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
@@ -5818,12 +5835,8 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
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
 
@@ -5842,11 +5855,8 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
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
@@ -5863,7 +5873,7 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 		}
 
 		mgmt_device_found(hdev, bdaddr, LE_LINK, bdaddr_type, NULL,
-				  rssi, flags, data, len, NULL, 0);
+				  rssi, flags, data, len, NULL, 0, 0);
 		return;
 	}
 
@@ -5882,7 +5892,7 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 					  d->last_adv_addr_type, NULL,
 					  d->last_adv_rssi, d->last_adv_flags,
 					  d->last_adv_data,
-					  d->last_adv_data_len, NULL, 0);
+					  d->last_adv_data_len, NULL, 0, 0);
 
 		/* If the new report will trigger a SCAN_REQ store it for
 		 * later merging.
@@ -5899,7 +5909,7 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 		 */
 		clear_pending_adv_report(hdev);
 		mgmt_device_found(hdev, bdaddr, LE_LINK, bdaddr_type, NULL,
-				  rssi, flags, data, len, NULL, 0);
+				  rssi, flags, data, len, NULL, 0, 0);
 		return;
 	}
 
@@ -5909,7 +5919,7 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 	 */
 	mgmt_device_found(hdev, &d->last_adv_addr, LE_LINK,
 			  d->last_adv_addr_type, NULL, rssi, d->last_adv_flags,
-			  d->last_adv_data, d->last_adv_data_len, data, len);
+			  d->last_adv_data, d->last_adv_data_len, data, len, 0);
 	clear_pending_adv_report(hdev);
 }
 
@@ -5917,6 +5927,7 @@ static void hci_le_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	u8 num_reports = skb->data[0];
 	void *ptr = &skb->data[1];
+	u32 instant = jiffies;
 
 	hci_dev_lock(hdev);
 
@@ -5934,7 +5945,8 @@ static void hci_le_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
 			rssi = ev->data[ev->length];
 			process_adv_report(hdev, ev->evt_type, &ev->bdaddr,
 					   ev->bdaddr_type, NULL, 0, rssi,
-					   ev->data, ev->length, false);
+					   ev->data, ev->length, false,
+					   false, instant);
 		} else {
 			bt_dev_err(hdev, "Dropping invalid advertising data");
 		}
@@ -5993,6 +6005,7 @@ static void hci_le_ext_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	u8 num_reports = skb->data[0];
 	void *ptr = &skb->data[1];
+	u32 instant = jiffies;
 
 	hci_dev_lock(hdev);
 
@@ -6007,7 +6020,8 @@ static void hci_le_ext_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
 			process_adv_report(hdev, legacy_evt_type, &ev->bdaddr,
 					   ev->bdaddr_type, NULL, 0, ev->rssi,
 					   ev->data, ev->length,
-					   !(evt_type & LE_EXT_ADV_LEGACY_PDU));
+					   !(evt_type & LE_EXT_ADV_LEGACY_PDU),
+					   false, instant);
 		}
 
 		ptr += sizeof(*ev) + ev->length;
@@ -6197,6 +6211,7 @@ static void hci_le_direct_adv_report_evt(struct hci_dev *hdev,
 {
 	u8 num_reports = skb->data[0];
 	struct hci_ev_le_direct_adv_info *ev = (void *)&skb->data[1];
+	u32 instant = jiffies;
 
 	if (!num_reports || skb->len < num_reports * sizeof(*ev) + 1)
 		return;
@@ -6207,7 +6222,7 @@ static void hci_le_direct_adv_report_evt(struct hci_dev *hdev,
 		process_adv_report(hdev, ev->evt_type, &ev->bdaddr,
 				   ev->bdaddr_type, &ev->direct_addr,
 				   ev->direct_addr_type, ev->rssi, NULL, 0,
-				   false);
+				   false, false, instant);
 
 	hci_dev_unlock(hdev);
 }
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 8b3205e4b23e..4cba7c3e2ba2 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -686,7 +686,12 @@ static void hci_req_start_scan(struct hci_request *req, u8 type, u16 interval,
 
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
@@ -694,18 +699,31 @@ static void hci_req_start_scan(struct hci_request *req, u8 type, u16 interval,
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
@@ -840,7 +858,7 @@ void __hci_req_pause_adv_instances(struct hci_request *req)
 	__hci_req_disable_advertising(req);
 
 	/* If we are using software rotation, pause the loop */
-	if (!ext_adv_capable(req->hdev))
+	if (!use_ext_adv(req->hdev))
 		cancel_adv_timeout(req->hdev);
 }
 
@@ -851,7 +869,7 @@ static void __hci_req_resume_adv_instances(struct hci_request *req)
 
 	bt_dev_dbg(req->hdev, "Resuming advertising instances");
 
-	if (ext_adv_capable(req->hdev)) {
+	if (use_ext_adv(req->hdev)) {
 		/* Call for each tracked instance to be re-enabled */
 		list_for_each_entry(adv, &req->hdev->adv_instances, list) {
 			__hci_req_enable_ext_advertising(req,
@@ -886,7 +904,7 @@ static bool adv_cur_instance_is_scannable(struct hci_dev *hdev)
 
 void __hci_req_disable_advertising(struct hci_request *req)
 {
-	if (ext_adv_capable(req->hdev)) {
+	if (use_ext_adv(req->hdev)) {
 		__hci_req_disable_ext_adv_instance(req, 0x00);
 
 	} else {
@@ -972,8 +990,13 @@ void __hci_req_enable_advertising(struct hci_request *req)
 
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
@@ -1016,8 +1039,12 @@ void __hci_req_enable_advertising(struct hci_request *req)
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
@@ -1028,7 +1055,8 @@ void __hci_req_enable_advertising(struct hci_request *req)
 	cp.own_address_type = own_addr_type;
 	cp.channel_map = hdev->le_adv_channel_map;
 
-	hci_req_add(req, HCI_OP_LE_SET_ADV_PARAM, sizeof(cp), &cp);
+	if (hdev->manufacturer != 0x000f || hdev->hci_rev != 0x16e4)
+		hci_req_add(req, HCI_OP_LE_SET_ADV_PARAM, sizeof(cp), &cp);
 
 	hci_req_add(req, HCI_OP_LE_SET_ADV_ENABLE, sizeof(enable), &enable);
 }
@@ -1041,7 +1069,7 @@ void __hci_req_update_scan_rsp_data(struct hci_request *req, u8 instance)
 	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED))
 		return;
 
-	if (ext_adv_capable(hdev)) {
+	if (use_ext_adv(hdev)) {
 		struct {
 			struct hci_cp_le_set_ext_scan_rsp_data cp;
 			u8 data[HCI_MAX_EXT_AD_LENGTH];
@@ -1093,7 +1121,7 @@ void __hci_req_update_adv_data(struct hci_request *req, u8 instance)
 	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED))
 		return;
 
-	if (ext_adv_capable(hdev)) {
+	if (use_ext_adv(hdev)) {
 		struct {
 			struct hci_cp_le_set_ext_adv_data cp;
 			u8 data[HCI_MAX_EXT_AD_LENGTH];
@@ -1189,7 +1217,7 @@ void hci_req_reenable_advertising(struct hci_dev *hdev)
 		__hci_req_schedule_adv_instance(&req, hdev->cur_adv_instance,
 						true);
 	} else {
-		if (ext_adv_capable(hdev)) {
+		if (use_ext_adv(hdev)) {
 			__hci_req_start_ext_adv(&req, 0x00);
 		} else {
 			__hci_req_update_adv_data(&req, 0x00);
@@ -1664,7 +1692,7 @@ int __hci_req_schedule_adv_instance(struct hci_request *req, u8 instance,
 				adv_instance->remaining_time - timeout;
 
 	/* Only use work for scheduling instances with legacy advertising */
-	if (!ext_adv_capable(hdev)) {
+	if (!use_ext_adv(hdev)) {
 		hdev->adv_instance_timeout = timeout;
 		queue_delayed_work(hdev->req_workqueue,
 			   &hdev->adv_instance_expire,
@@ -1680,7 +1708,7 @@ int __hci_req_schedule_adv_instance(struct hci_request *req, u8 instance,
 		return 0;
 
 	hdev->cur_adv_instance = instance;
-	if (ext_adv_capable(hdev)) {
+	if (use_ext_adv(hdev)) {
 		__hci_req_start_ext_adv(req, instance);
 	} else {
 		__hci_req_update_adv_data(req, instance);
@@ -1752,7 +1780,7 @@ void hci_req_clear_adv_instance(struct hci_dev *hdev, struct sock *sk,
 	    hci_dev_test_flag(hdev, HCI_ADVERTISING))
 		return;
 
-	if (next_instance && !ext_adv_capable(hdev))
+	if (next_instance && !use_ext_adv(hdev))
 		__hci_req_schedule_adv_instance(req, next_instance->instance,
 						false);
 }
@@ -2002,7 +2030,7 @@ static int discoverable_update(struct hci_request *req, unsigned long opt)
 		 * address in limited privacy mode.
 		 */
 		if (hci_dev_test_flag(hdev, HCI_LIMITED_PRIVACY)) {
-			if (ext_adv_capable(hdev))
+			if (use_ext_adv(hdev))
 				__hci_req_start_ext_adv(req, 0x00);
 			else
 				__hci_req_enable_advertising(req);
@@ -2151,7 +2179,8 @@ static void le_scan_disable_work(struct work_struct *work)
 
 	bt_dev_dbg(hdev, "");
 
-	if (!hci_dev_test_flag(hdev, HCI_LE_SCAN))
+	if (!hci_dev_test_flag(hdev, HCI_LE_SCAN) ||
+				hci_dev_test_flag(hdev, HCI_MESH))
 		return;
 
 	cancel_delayed_work(&hdev->le_scan_restart);
@@ -2197,9 +2226,11 @@ static void le_scan_disable_work(struct work_struct *work)
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
@@ -2222,7 +2253,12 @@ static int le_scan_restart(struct hci_request *req, unsigned long opt)
 
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
@@ -2231,7 +2267,13 @@ static int le_scan_restart(struct hci_request *req, unsigned long opt)
 
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
 
@@ -2344,6 +2386,21 @@ static int active_scan(struct hci_request *req, unsigned long opt)
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
@@ -2398,8 +2455,16 @@ static void start_discovery(struct hci_dev *hdev, u8 *status)
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
@@ -2627,7 +2692,7 @@ static int powered_update_hci(struct hci_request *req, unsigned long opt)
 		    list_empty(&hdev->adv_instances)) {
 			int err;
 
-			if (ext_adv_capable(hdev)) {
+			if (use_ext_adv(hdev)) {
 				err = __hci_req_setup_ext_adv_instance(req,
 								       0x00);
 				if (!err)
@@ -2640,7 +2705,7 @@ static int powered_update_hci(struct hci_request *req, unsigned long opt)
 			}
 
 			if (hci_dev_test_flag(hdev, HCI_ADVERTISING)) {
-				if (!ext_adv_capable(hdev))
+				if (!use_ext_adv(hdev))
 					__hci_req_enable_advertising(req);
 				else if (!err)
 					__hci_req_enable_ext_advertising(req,
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index ad86caf41f91..b63bd01e254d 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -856,7 +856,7 @@ int hci_update_scan_rsp_data_sync(struct hci_dev *hdev, u8 instance)
 	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED))
 		return 0;
 
-	if (ext_adv_capable(hdev))
+	if (use_ext_adv(hdev))
 		return hci_set_ext_scan_rsp_data_sync(hdev, instance);
 
 	return __hci_set_scan_rsp_data_sync(hdev, instance);
@@ -927,7 +927,7 @@ static int hci_start_adv_sync(struct hci_dev *hdev, u8 instance)
 {
 	int err;
 
-	if (ext_adv_capable(hdev))
+	if (use_ext_adv(hdev))
 		return hci_start_ext_adv_sync(hdev, instance);
 
 	err = hci_update_adv_data_sync(hdev, instance);
@@ -951,7 +951,7 @@ int hci_enable_advertising_sync(struct hci_dev *hdev)
 	u32 flags;
 	u8 status;
 
-	if (ext_adv_capable(hdev))
+	if (use_ext_adv(hdev))
 		return hci_enable_ext_advertising_sync(hdev,
 						       hdev->cur_adv_instance);
 
@@ -1100,6 +1100,49 @@ static int hci_set_ext_adv_data_sync(struct hci_dev *hdev, u8 instance)
 				     HCI_CMD_TIMEOUT);
 }
 
+int hci_mesh_send_sync(struct hci_dev *hdev, u8 *data, u8 len)
+{
+	struct hci_cp_le_set_adv_data cp_data;
+	struct hci_cp_le_set_adv_param cp_param;
+	u8 own_addr_type, enable = 0x00;
+	int err;
+
+	memset(&cp_data, 0, sizeof(cp_data));
+	cp_data.length = len + 1;
+	cp_data.data[0] = len;
+	memcpy(cp_data.data + 1, data, len);
+
+	__hci_cmd_sync_status(hdev, HCI_OP_LE_SET_ADV_ENABLE,
+				     sizeof(enable), &enable, HCI_CMD_TIMEOUT);
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
@@ -1128,7 +1171,7 @@ int hci_update_adv_data_sync(struct hci_dev *hdev, u8 instance)
 	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED))
 		return 0;
 
-	if (ext_adv_capable(hdev))
+	if (use_ext_adv(hdev))
 		return hci_set_ext_adv_data_sync(hdev, instance);
 
 	return hci_set_adv_data_sync(hdev, instance);
@@ -1140,7 +1183,7 @@ int hci_schedule_adv_instance_sync(struct hci_dev *hdev, u8 instance,
 	struct adv_info *adv = NULL;
 	u16 timeout;
 
-	if (hci_dev_test_flag(hdev, HCI_ADVERTISING) && !ext_adv_capable(hdev))
+	if (hci_dev_test_flag(hdev, HCI_ADVERTISING) && !use_ext_adv(hdev))
 		return -EPERM;
 
 	if (hdev->adv_instance_timeout)
@@ -1170,7 +1213,7 @@ int hci_schedule_adv_instance_sync(struct hci_dev *hdev, u8 instance,
 		adv->remaining_time = adv->remaining_time - timeout;
 
 	/* Only use work for scheduling instances with legacy advertising */
-	if (!ext_adv_capable(hdev)) {
+	if (!use_ext_adv(hdev)) {
 		hdev->adv_instance_timeout = timeout;
 		queue_delayed_work(hdev->req_workqueue,
 				   &hdev->adv_instance_expire,
@@ -1209,10 +1252,13 @@ static int hci_clear_adv_sets_sync(struct hci_dev *hdev, struct sock *sk)
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
@@ -1240,11 +1286,13 @@ static int hci_clear_adv_sync(struct hci_dev *hdev, struct sock *sk, bool force)
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
@@ -1309,7 +1357,7 @@ int hci_remove_advertising_sync(struct hci_dev *hdev, struct sock *sk,
 	if (!hdev_is_powered(hdev) || hci_dev_test_flag(hdev, HCI_ADVERTISING))
 		return 0;
 
-	if (next && !ext_adv_capable(hdev))
+	if (next && !use_ext_adv(hdev))
 		hci_schedule_adv_instance_sync(hdev, next->instance, false);
 
 	return 0;
@@ -1343,13 +1391,16 @@ int hci_read_tx_power_sync(struct hci_dev *hdev, __le16 handle, u8 type)
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
@@ -1362,7 +1413,11 @@ static int hci_le_set_ext_scan_enable_sync(struct hci_dev *hdev, u8 val,
 
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
@@ -1378,7 +1433,11 @@ static int hci_le_set_scan_enable_sync(struct hci_dev *hdev, u8 val,
 
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
@@ -1676,7 +1735,7 @@ static int hci_pause_advertising_sync(struct hci_dev *hdev)
 		return err;
 
 	/* If we are using software rotation, pause the loop */
-	if (!ext_adv_capable(hdev))
+	if (!use_ext_adv(hdev))
 		cancel_adv_timeout(hdev);
 
 	hdev->advertising_paused = true;
@@ -1704,7 +1763,7 @@ static int hci_resume_advertising_sync(struct hci_dev *hdev)
 
 	bt_dev_dbg(hdev, "Resuming advertising instances");
 
-	if (ext_adv_capable(hdev)) {
+	if (use_ext_adv(hdev)) {
 		/* Call for each tracked instance to be re-enabled */
 		list_for_each_entry_safe(adv, tmp, &hdev->adv_instances, list) {
 			err = hci_enable_ext_advertising_sync(hdev,
@@ -2088,7 +2147,8 @@ int hci_update_passive_scan_sync(struct hci_dev *hdev)
 	bt_dev_dbg(hdev, "ADV monitoring is %s",
 		   hci_is_adv_monitoring(hdev) ? "on" : "off");
 
-	if (list_empty(&hdev->pend_le_conns) &&
+	if (!hci_dev_test_flag(hdev, HCI_MESH) &&
+	    list_empty(&hdev->pend_le_conns) &&
 	    list_empty(&hdev->pend_le_reports) &&
 	    !hci_is_adv_monitoring(hdev)) {
 		/* If there is no pending LE connections or devices
@@ -2236,7 +2296,7 @@ static int hci_powered_update_adv_sync(struct hci_dev *hdev)
 	 */
 	if (hci_dev_test_flag(hdev, HCI_ADVERTISING) ||
 	    list_empty(&hdev->adv_instances)) {
-		if (ext_adv_capable(hdev)) {
+		if (use_ext_adv(hdev)) {
 			err = hci_setup_ext_adv_instance_sync(hdev, 0x00);
 			if (!err)
 				hci_update_scan_rsp_data_sync(hdev, 0x00);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index bf989ae03f9f..120798f039fe 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -129,6 +129,8 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_ADD_EXT_ADV_PARAMS,
 	MGMT_OP_ADD_EXT_ADV_DATA,
 	MGMT_OP_ADD_ADV_PATTERNS_MONITOR_RSSI,
+	MGMT_OP_SET_MESH,
+	MGMT_OP_MESH_SEND,
 };
 
 static const u16 mgmt_events[] = {
@@ -994,7 +996,7 @@ static int rpa_expired_sync(struct hci_dev *hdev, void *data)
 	 * controller happens in the hci_req_enable_advertising()
 	 * function.
 	 */
-	if (ext_adv_capable(hdev))
+	if (use_ext_adv(hdev))
 		return hci_start_ext_adv_sync(hdev, hdev->cur_adv_instance);
 	else
 		return hci_enable_advertising_sync(hdev);
@@ -1015,13 +1017,43 @@ static void rpa_expired(struct work_struct *work)
 	hci_cmd_sync_queue(hdev, rpa_expired_sync, NULL, NULL);
 }
 
+static int send_settings_rsp(struct sock *sk, u16 opcode, struct hci_dev *hdev);
+static int mesh_send_done_sync(struct hci_dev *hdev, void *data)
+{
+	struct mgmt_pending_cmd *cmd = data;
+
+	bt_dev_dbg(hdev, "Send Mesh Packet Done");
+	hci_disable_advertising_sync(hdev);
+	hci_dev_clear_flag(hdev, HCI_MESH_SENDING);
+	send_settings_rsp(cmd->sk, MGMT_OP_SET_MESH, hdev);
+	mgmt_pending_remove(cmd);
+
+	return 0;
+}
+
+static void mesh_send_done(struct work_struct *work)
+{
+	struct mgmt_pending_cmd *cmd;
+	struct hci_dev *hdev = container_of(work, struct hci_dev,
+					    mesh_send_done.work);
+
+	if (!hci_dev_test_flag(hdev, HCI_MESH_SENDING))
+		return;
+
+	cmd = pending_find(MGMT_OP_MESH_SEND, hdev);
+	hci_cmd_sync_queue(hdev, mesh_send_done_sync, cmd, NULL);
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
@@ -1992,6 +2024,9 @@ static int set_le_sync(struct hci_dev *hdev, void *data)
 	u8 val = !!cp->val;
 	int err;
 
+	hci_dev_clear_flag(hdev, HCI_MESH);
+	hci_dev_clear_flag(hdev, HCI_MESH_ACTIVE);
+
 	if (!val) {
 		if (hci_dev_test_flag(hdev, HCI_LE_ADV))
 			hci_disable_advertising_sync(hdev);
@@ -2010,7 +2045,7 @@ static int set_le_sync(struct hci_dev *hdev, void *data)
 	 * update in powered_update_hci will take care of it.
 	 */
 	if (!err && hci_dev_test_flag(hdev, HCI_LE_ENABLED)) {
-		if (ext_adv_capable(hdev)) {
+		if (use_ext_adv(hdev)) {
 			int status;
 
 			status = hci_setup_ext_adv_instance_sync(hdev, 0x00);
@@ -2027,6 +2062,159 @@ static int set_le_sync(struct hci_dev *hdev, void *data)
 	return err;
 }
 
+static void set_mesh_complete(struct hci_dev *hdev, void *data, int err)
+{
+	struct mgmt_pending_cmd *cmd = data;
+	u8 status = mgmt_status(err);
+	struct sock *sk = cmd->sk;
+
+	if (status) {
+		mgmt_pending_foreach(MGMT_OP_SET_MESH, hdev, cmd_status_rsp,
+							&status);
+		return;
+	}
+
+	send_settings_rsp(sk, MGMT_OP_SET_MESH, hdev);
+}
+
+static int set_mesh_sync(struct hci_dev *hdev, void *data)
+{
+	struct mgmt_pending_cmd *cmd = data;
+	struct mgmt_cp_set_mesh *cp = cmd->param;
+	size_t len = cmd->param_len;
+
+	memset(hdev->mesh_ad_types, 0, sizeof(hdev->mesh_ad_types));
+	hci_dev_clear_flag(hdev, HCI_MESH_ACTIVE);
+
+	if (cp->enable) {
+		hci_dev_set_flag(hdev, HCI_MESH);
+
+		if (cp->active)
+			hci_dev_set_flag(hdev, HCI_MESH_ACTIVE);
+
+	} else
+		hci_dev_clear_flag(hdev, HCI_MESH);
+
+	/* Truncate the passed ad_type list if too long */
+	if (len - sizeof(*cp) <= sizeof(hdev->mesh_ad_types))
+		memcpy(hdev->mesh_ad_types, cp->ad_types, len - sizeof(*cp));
+	else
+		memcpy(hdev->mesh_ad_types, cp->ad_types,
+						sizeof(hdev->mesh_ad_types));
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
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_MESH,
+				       MGMT_STATUS_NOT_SUPPORTED);
+
+	if ((cp->enable != 0x00 && cp->enable != 0x01) ||
+				(cp->active != 0x00 && cp->active != 0x01))
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_MESH,
+				       MGMT_STATUS_INVALID_PARAMS);
+
+	hci_dev_lock(hdev);
+
+	cmd = mgmt_pending_add(sk, MGMT_OP_SET_MESH, hdev, data, len);
+	if (!cmd)
+		err = -ENOMEM;
+	else
+		err = hci_cmd_sync_queue(hdev, set_mesh_sync, cmd,
+						set_mesh_complete);
+
+
+	send_settings_rsp(sk, MGMT_OP_SET_MESH, hdev);
+	hci_dev_unlock(hdev);
+	return err;
+}
+
+static void mesh_send_complete(struct hci_dev *hdev, void *data, int err)
+{
+	struct mgmt_pending_cmd *cmd = data;
+	struct mgmt_cp_mesh_send *cp = cmd->param;
+	unsigned long mesh_send_interval;
+	u8 mgmt_err = mgmt_status(err);
+
+	/* Report any errors here, but don't report completion */
+
+	if (mgmt_err) {
+		hci_dev_clear_flag(hdev, HCI_MESH_SENDING);
+		mgmt_cmd_status(cmd->sk, hdev->id, MGMT_OP_MESH_SEND, mgmt_err);
+		mgmt_pending_remove(cmd);
+		return;
+	}
+
+	mesh_send_interval = msecs_to_jiffies((cp->cnt) * 25);
+	queue_delayed_work(hdev->req_workqueue, &hdev->mesh_send_done,
+			   mesh_send_interval);
+}
+
+static int mesh_send_sync(struct hci_dev *hdev, void *data)
+{
+	struct mgmt_pending_cmd *cmd = data;
+
+	if (hci_dev_test_flag(hdev, HCI_LE_ADV))
+		return MGMT_STATUS_BUSY;
+
+	return hci_mesh_send_sync(hdev, cmd->param, cmd->param_len);
+}
+
+static int mesh_send(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
+{
+	struct mgmt_pending_cmd *cmd;
+	struct mgmt_cp_mesh_send *send = data;
+	int err = 0;
+
+	bt_dev_dbg(hdev, "Send Mesh Packet Start...");
+
+	if (!hci_dev_test_flag(hdev, HCI_MESH) || len <= MGMT_MESH_SEND_SIZE ||
+					len > (MGMT_MESH_SEND_SIZE + 29))
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_MESH_SEND,
+				       MGMT_STATUS_REJECTED);
+
+	hci_dev_lock(hdev);
+	if (hci_dev_test_flag(hdev, HCI_MESH_SENDING) ||
+				hci_dev_test_flag(hdev, HCI_LE_ADV)) {
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_MESH_SEND,
+							MGMT_STATUS_BUSY);
+		goto done;
+	}
+
+
+	hci_dev_set_flag(hdev, HCI_MESH_SENDING);
+
+	cmd = mgmt_pending_add(sk, MGMT_OP_MESH_SEND, hdev, send->data,
+				len - sizeof(struct mgmt_cp_mesh_send));
+
+	if (!cmd)
+		err = -ENOMEM;
+	else
+		err = hci_cmd_sync_queue(hdev, mesh_send_sync, cmd,
+						mesh_send_complete);
+
+	if (err < 0) {
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_MESH_SEND,
+						MGMT_STATUS_FAILED);
+
+		if (cmd)
+			mgmt_pending_remove(cmd);
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
@@ -5731,7 +5919,7 @@ static int set_adv_sync(struct hci_dev *hdev, void *data)
 		 */
 		hdev->cur_adv_instance = 0x00;
 
-		if (ext_adv_capable(hdev)) {
+		if (use_ext_adv(hdev)) {
 			hci_start_ext_adv_sync(hdev, 0x00);
 		} else {
 			hci_update_adv_data_sync(hdev, 0x00);
@@ -5780,6 +5968,7 @@ static int set_advertising(struct sock *sk, struct hci_dev *hdev, void *data,
 	if (!hdev_is_powered(hdev) ||
 	    (val == hci_dev_test_flag(hdev, HCI_ADVERTISING) &&
 	     (cp->val == 0x02) == hci_dev_test_flag(hdev, HCI_ADVERTISING_CONNECTABLE)) ||
+	    hci_dev_test_flag(hdev, HCI_MESH) ||
 	    hci_conn_num(hdev, LE_LINK) > 0 ||
 	    (hci_dev_test_flag(hdev, HCI_LE_SCAN) &&
 	     hdev->le_scan_type == LE_SCAN_ACTIVE)) {
@@ -7730,11 +7919,10 @@ static u32 get_supported_adv_flags(struct hci_dev *hdev)
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
@@ -8703,7 +8891,10 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
 	{ add_ext_adv_data,        MGMT_ADD_EXT_ADV_DATA_SIZE,
 						HCI_MGMT_VAR_LEN },
 	{ add_adv_patterns_monitor_rssi,
-				   MGMT_ADD_ADV_PATTERNS_MONITOR_RSSI_SIZE,
+				   MGMT_ADD_ADV_PATTERNS_MONITOR_RSSI_SIZE },
+	{ set_mesh,                MGMT_SET_MESH_SIZE,
+						HCI_MGMT_VAR_LEN },
+	{ mesh_send,               MGMT_MESH_SEND_SIZE,
 						HCI_MGMT_VAR_LEN },
 };
 
@@ -9526,7 +9717,8 @@ static bool is_filter_match(struct hci_dev *hdev, s8 rssi, u8 *eir,
 
 void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		       u8 addr_type, u8 *dev_class, s8 rssi, u32 flags,
-		       u8 *eir, u16 eir_len, u8 *scan_rsp, u8 scan_rsp_len)
+		       u8 *eir, u16 eir_len, u8 *scan_rsp, u8 scan_rsp_len,
+		       u32 instant)
 {
 	char buf[512];
 	struct mgmt_ev_device_found *ev = (void *)buf;
-- 
2.31.1

