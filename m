Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 09/11] Bluetooth: Use async requests internally in hci_req_sync
Date: Tue,  5 Mar 2013 20:37:49 +0200
Message-Id: <1362508671-6460-10-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1362508671-6460-1-git-send-email-johan.hedberg@gmail.com>
References: <1362508671-6460-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch converts the hci_req_sync() procedure to internaly use the
asynchronous HCI requests.

The hci_req_sync mechanism relies on hci_req_complete() calls from
hci_event.c into hci_core.c whenever a HCI command completes. This is
very similar to what asynchronous requests do and makes the conversion
fairly straight forward by converting hci_req_complete into a request
complete callback. By this change hci_req_complete (renamed to
hci_req_sync_complete) becomes private to hci_core.c and all calls to it
can be removed from hci_event.c.

The commands in each hci_req_sync procedure are collected into their own
request by passing the hci_request pointer to the request callback
(instead of the hci_dev pointer). The one slight exception is the HCI
init request which has the special handling of HCI driver specific
initialization commands. These commands are run in their own request
prior to the "main" init request.

One other extra change that this patch must contain is the handling of
spontaneous HCI reset complete events that some controllers exhibit.
These were previously handled in the hci_req_complete function but the
right place for them now becomes the hci_req_cmd_complete function.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |    2 -
 net/bluetooth/hci_core.c         |  271 +++++++++++++++++++++-----------------
 net/bluetooth/hci_event.c        |   78 +----------
 3 files changed, 156 insertions(+), 195 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index d732d68..3f124f4 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1164,8 +1164,6 @@ struct hci_sec_filter {
 #define hci_req_lock(d)		mutex_lock(&d->req_lock)
 #define hci_req_unlock(d)	mutex_unlock(&d->req_lock)
 
-void hci_req_complete(struct hci_dev *hdev, __u16 cmd, int result);
-
 void hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max,
 					u16 latency, u16 to_multiplier);
 void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __u8 rand[8],
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 2493d3b..9116dad 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -57,36 +57,9 @@ static void hci_notify(struct hci_dev *hdev, int event)
 
 /* ---- HCI requests ---- */
 
-void hci_req_complete(struct hci_dev *hdev, __u16 cmd, int result)
+static void hci_req_sync_complete(struct hci_dev *hdev, u8 result)
 {
-	BT_DBG("%s command 0x%4.4x result 0x%2.2x", hdev->name, cmd, result);
-
-	/* If this is the init phase check if the completed command matches
-	 * the last init command, and if not just return.
-	 */
-	if (test_bit(HCI_INIT, &hdev->flags) && hdev->init_last_cmd != cmd) {
-		struct hci_command_hdr *sent = (void *) hdev->sent_cmd->data;
-		u16 opcode = __le16_to_cpu(sent->opcode);
-		struct sk_buff *skb;
-
-		/* Some CSR based controllers generate a spontaneous
-		 * reset complete event during init and any pending
-		 * command will never be completed. In such a case we
-		 * need to resend whatever was the last sent
-		 * command.
-		 */
-
-		if (cmd != HCI_OP_RESET || opcode == HCI_OP_RESET)
-			return;
-
-		skb = skb_clone(hdev->sent_cmd, GFP_ATOMIC);
-		if (skb) {
-			skb_queue_head(&hdev->cmd_q, skb);
-			queue_work(hdev->workqueue, &hdev->cmd_work);
-		}
-
-		return;
-	}
+	BT_DBG("%s result 0x%2.2x", hdev->name, result);
 
 	if (hdev->req_status == HCI_REQ_PEND) {
 		hdev->req_result = result;
@@ -108,26 +81,36 @@ static void hci_req_cancel(struct hci_dev *hdev, int err)
 
 /* Execute request and wait for completion. */
 static int __hci_req_sync(struct hci_dev *hdev,
-			  void (*req)(struct hci_dev *hdev, unsigned long opt),
+			  void (*func)(struct hci_request *req,
+				      unsigned long opt),
 			  unsigned long opt, __u32 timeout)
 {
+	struct hci_request req;
 	DECLARE_WAITQUEUE(wait, current);
 	int err = 0;
 
 	BT_DBG("%s start", hdev->name);
 
+	hci_req_init(&req, hdev);
+
 	hdev->req_status = HCI_REQ_PEND;
 
 	add_wait_queue(&hdev->req_wait_q, &wait);
 	set_current_state(TASK_INTERRUPTIBLE);
 
-	req(hdev, opt);
+	func(&req, opt);
 
-	/* If the request didn't send any commands return immediately */
-	if (skb_queue_empty(&hdev->cmd_q) && atomic_read(&hdev->cmd_cnt)) {
+	err = hci_req_run(&req, hci_req_sync_complete);
+	if (err < 0) {
 		hdev->req_status = 0;
 		remove_wait_queue(&hdev->req_wait_q, &wait);
-		return err;
+		/* req_run will fail if the request did not add any
+		 * commands to the queue, something that can happen when
+		 * a request with conditionals doesn't trigger any
+		 * commands to be sent. This is normal behavior and
+		 * should not trigger an error return.
+		 */
+		return 0;
 	}
 
 	schedule_timeout(timeout);
@@ -159,7 +142,8 @@ static int __hci_req_sync(struct hci_dev *hdev,
 }
 
 static int hci_req_sync(struct hci_dev *hdev,
-			void (*req)(struct hci_dev *hdev, unsigned long opt),
+			void (*req)(struct hci_request *req,
+				    unsigned long opt),
 			unsigned long opt, __u32 timeout)
 {
 	int ret;
@@ -175,72 +159,80 @@ static int hci_req_sync(struct hci_dev *hdev,
 	return ret;
 }
 
-static void hci_reset_req(struct hci_dev *hdev, unsigned long opt)
+static void hci_reset_req(struct hci_request *req, unsigned long opt)
 {
-	BT_DBG("%s %ld", hdev->name, opt);
+	BT_DBG("%s %ld", req->hdev->name, opt);
 
 	/* Reset device */
-	set_bit(HCI_RESET, &hdev->flags);
-	hci_send_cmd(hdev, HCI_OP_RESET, 0, NULL);
+	set_bit(HCI_RESET, &req->hdev->flags);
+	hci_req_add(req, HCI_OP_RESET, 0, NULL);
 }
 
-static void bredr_init(struct hci_dev *hdev)
+static void bredr_init(struct hci_request *req)
 {
-	hdev->flow_ctl_mode = HCI_FLOW_CTL_MODE_PACKET_BASED;
+	req->hdev->flow_ctl_mode = HCI_FLOW_CTL_MODE_PACKET_BASED;
 
 	/* Read Local Supported Features */
-	hci_send_cmd(hdev, HCI_OP_READ_LOCAL_FEATURES, 0, NULL);
+	hci_req_add(req, HCI_OP_READ_LOCAL_FEATURES, 0, NULL);
 
 	/* Read Local Version */
-	hci_send_cmd(hdev, HCI_OP_READ_LOCAL_VERSION, 0, NULL);
+	hci_req_add(req, HCI_OP_READ_LOCAL_VERSION, 0, NULL);
 
 	/* Read BD Address */
-	hci_send_cmd(hdev, HCI_OP_READ_BD_ADDR, 0, NULL);
+	hci_req_add(req, HCI_OP_READ_BD_ADDR, 0, NULL);
 }
 
-static void amp_init(struct hci_dev *hdev)
+static void amp_init(struct hci_request *req)
 {
-	hdev->flow_ctl_mode = HCI_FLOW_CTL_MODE_BLOCK_BASED;
+	req->hdev->flow_ctl_mode = HCI_FLOW_CTL_MODE_BLOCK_BASED;
 
 	/* Read Local Version */
-	hci_send_cmd(hdev, HCI_OP_READ_LOCAL_VERSION, 0, NULL);
+	hci_req_add(req, HCI_OP_READ_LOCAL_VERSION, 0, NULL);
 
 	/* Read Local AMP Info */
-	hci_send_cmd(hdev, HCI_OP_READ_LOCAL_AMP_INFO, 0, NULL);
+	hci_req_add(req, HCI_OP_READ_LOCAL_AMP_INFO, 0, NULL);
 
 	/* Read Data Blk size */
-	hci_send_cmd(hdev, HCI_OP_READ_DATA_BLOCK_SIZE, 0, NULL);
+	hci_req_add(req, HCI_OP_READ_DATA_BLOCK_SIZE, 0, NULL);
 }
 
-static void hci_init1_req(struct hci_dev *hdev, unsigned long opt)
+static void hci_init1_req(struct hci_request *req, unsigned long opt)
 {
+	struct hci_dev *hdev = req->hdev;
+	struct hci_request init_req;
 	struct sk_buff *skb;
 
 	BT_DBG("%s %ld", hdev->name, opt);
 
 	/* Driver initialization */
 
+	hci_req_init(&init_req, hdev);
+
 	/* Special commands */
 	while ((skb = skb_dequeue(&hdev->driver_init))) {
 		bt_cb(skb)->pkt_type = HCI_COMMAND_PKT;
 		skb->dev = (void *) hdev;
 
-		skb_queue_tail(&hdev->cmd_q, skb);
-		queue_work(hdev->workqueue, &hdev->cmd_work);
+		if (skb_queue_empty(&init_req.cmd_q))
+			bt_cb(skb)->req.start = true;
+
+		skb_queue_tail(&init_req.cmd_q, skb);
 	}
 	skb_queue_purge(&hdev->driver_init);
 
+	hci_req_run(&init_req, NULL);
+
 	/* Reset */
 	if (!test_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks))
-		hci_reset_req(hdev, 0);
+		hci_reset_req(req, 0);
 
 	switch (hdev->dev_type) {
 	case HCI_BREDR:
-		bredr_init(hdev);
+		bredr_init(req);
 		break;
 
 	case HCI_AMP:
-		amp_init(hdev);
+		amp_init(req);
 		break;
 
 	default:
@@ -249,53 +241,53 @@ static void hci_init1_req(struct hci_dev *hdev, unsigned long opt)
 	}
 }
 
-static void bredr_setup(struct hci_dev *hdev)
+static void bredr_setup(struct hci_request *req)
 {
 	struct hci_cp_delete_stored_link_key cp;
 	__le16 param;
 	__u8 flt_type;
 
 	/* Read Buffer Size (ACL mtu, max pkt, etc.) */
-	hci_send_cmd(hdev, HCI_OP_READ_BUFFER_SIZE, 0, NULL);
+	hci_req_add(req, HCI_OP_READ_BUFFER_SIZE, 0, NULL);
 
 	/* Read Class of Device */
-	hci_send_cmd(hdev, HCI_OP_READ_CLASS_OF_DEV, 0, NULL);
+	hci_req_add(req, HCI_OP_READ_CLASS_OF_DEV, 0, NULL);
 
 	/* Read Local Name */
-	hci_send_cmd(hdev, HCI_OP_READ_LOCAL_NAME, 0, NULL);
+	hci_req_add(req, HCI_OP_READ_LOCAL_NAME, 0, NULL);
 
 	/* Read Voice Setting */
-	hci_send_cmd(hdev, HCI_OP_READ_VOICE_SETTING, 0, NULL);
+	hci_req_add(req, HCI_OP_READ_VOICE_SETTING, 0, NULL);
 
 	/* Clear Event Filters */
 	flt_type = HCI_FLT_CLEAR_ALL;
-	hci_send_cmd(hdev, HCI_OP_SET_EVENT_FLT, 1, &flt_type);
+	hci_req_add(req, HCI_OP_SET_EVENT_FLT, 1, &flt_type);
 
 	/* Connection accept timeout ~20 secs */
 	param = __constant_cpu_to_le16(0x7d00);
-	hci_send_cmd(hdev, HCI_OP_WRITE_CA_TIMEOUT, 2, &param);
+	hci_req_add(req, HCI_OP_WRITE_CA_TIMEOUT, 2, &param);
 
 	bacpy(&cp.bdaddr, BDADDR_ANY);
 	cp.delete_all = 0x01;
-	hci_send_cmd(hdev, HCI_OP_DELETE_STORED_LINK_KEY, sizeof(cp), &cp);
+	hci_req_add(req, HCI_OP_DELETE_STORED_LINK_KEY, sizeof(cp), &cp);
 }
 
-static void le_setup(struct hci_dev *hdev)
+static void le_setup(struct hci_request *req)
 {
 	/* Read LE Buffer Size */
-	hci_send_cmd(hdev, HCI_OP_LE_READ_BUFFER_SIZE, 0, NULL);
+	hci_req_add(req, HCI_OP_LE_READ_BUFFER_SIZE, 0, NULL);
 
 	/* Read LE Local Supported Features */
-	hci_send_cmd(hdev, HCI_OP_LE_READ_LOCAL_FEATURES, 0, NULL);
+	hci_req_add(req, HCI_OP_LE_READ_LOCAL_FEATURES, 0, NULL);
 
 	/* Read LE Advertising Channel TX Power */
-	hci_send_cmd(hdev, HCI_OP_LE_READ_ADV_TX_POWER, 0, NULL);
+	hci_req_add(req, HCI_OP_LE_READ_ADV_TX_POWER, 0, NULL);
 
 	/* Read LE White List Size */
-	hci_send_cmd(hdev, HCI_OP_LE_READ_WHITE_LIST_SIZE, 0, NULL);
+	hci_req_add(req, HCI_OP_LE_READ_WHITE_LIST_SIZE, 0, NULL);
 
 	/* Read LE Supported States */
-	hci_send_cmd(hdev, HCI_OP_LE_READ_SUPPORTED_STATES, 0, NULL);
+	hci_req_add(req, HCI_OP_LE_READ_SUPPORTED_STATES, 0, NULL);
 }
 
 static u8 hci_get_inquiry_mode(struct hci_dev *hdev)
@@ -326,17 +318,19 @@ static u8 hci_get_inquiry_mode(struct hci_dev *hdev)
 	return 0x00;
 }
 
-static void hci_setup_inquiry_mode(struct hci_dev *hdev)
+static void hci_setup_inquiry_mode(struct hci_request *req)
 {
 	u8 mode;
 
-	mode = hci_get_inquiry_mode(hdev);
+	mode = hci_get_inquiry_mode(req->hdev);
 
-	hci_send_cmd(hdev, HCI_OP_WRITE_INQUIRY_MODE, 1, &mode);
+	hci_req_add(req, HCI_OP_WRITE_INQUIRY_MODE, 1, &mode);
 }
 
-static void hci_setup_event_mask(struct hci_dev *hdev)
+static void hci_setup_event_mask(struct hci_request *req)
 {
+	struct hci_dev *hdev = req->hdev;
+
 	/* The second byte is 0xff instead of 0x9f (two reserved bits
 	 * disabled) since a Broadcom 1.2 dongle doesn't respond to the
 	 * command otherwise.
@@ -392,67 +386,70 @@ static void hci_setup_event_mask(struct hci_dev *hdev)
 	if (lmp_le_capable(hdev))
 		events[7] |= 0x20;	/* LE Meta-Event */
 
-	hci_send_cmd(hdev, HCI_OP_SET_EVENT_MASK, sizeof(events), events);
+	hci_req_add(req, HCI_OP_SET_EVENT_MASK, sizeof(events), events);
 
 	if (lmp_le_capable(hdev)) {
 		memset(events, 0, sizeof(events));
 		events[0] = 0x1f;
-		hci_send_cmd(hdev, HCI_OP_LE_SET_EVENT_MASK,
-			     sizeof(events), events);
+		hci_req_add(req, HCI_OP_LE_SET_EVENT_MASK,
+			    sizeof(events), events);
 	}
 }
 
-static void hci_init2_req(struct hci_dev *hdev, unsigned long opt)
+static void hci_init2_req(struct hci_request *req, unsigned long opt)
 {
+	struct hci_dev *hdev = req->hdev;
+
 	if (lmp_bredr_capable(hdev))
-		bredr_setup(hdev);
+		bredr_setup(req);
 
 	if (lmp_le_capable(hdev))
-		le_setup(hdev);
+		le_setup(req);
 
-	hci_setup_event_mask(hdev);
+	hci_setup_event_mask(req);
 
 	if (hdev->hci_ver > BLUETOOTH_VER_1_1)
-		hci_send_cmd(hdev, HCI_OP_READ_LOCAL_COMMANDS, 0, NULL);
+		hci_req_add(req, HCI_OP_READ_LOCAL_COMMANDS, 0, NULL);
 
 	if (lmp_ssp_capable(hdev)) {
 		if (test_bit(HCI_SSP_ENABLED, &hdev->dev_flags)) {
 			u8 mode = 0x01;
-			hci_send_cmd(hdev, HCI_OP_WRITE_SSP_MODE,
-				     sizeof(mode), &mode);
+			hci_req_add(req, HCI_OP_WRITE_SSP_MODE,
+				    sizeof(mode), &mode);
 		} else {
 			struct hci_cp_write_eir cp;
 
 			memset(hdev->eir, 0, sizeof(hdev->eir));
 			memset(&cp, 0, sizeof(cp));
 
-			hci_send_cmd(hdev, HCI_OP_WRITE_EIR, sizeof(cp), &cp);
+			hci_req_add(req, HCI_OP_WRITE_EIR, sizeof(cp), &cp);
 		}
 	}
 
 	if (lmp_inq_rssi_capable(hdev))
-		hci_setup_inquiry_mode(hdev);
+		hci_setup_inquiry_mode(req);
 
 	if (lmp_inq_tx_pwr_capable(hdev))
-		hci_send_cmd(hdev, HCI_OP_READ_INQ_RSP_TX_POWER, 0, NULL);
+		hci_req_add(req, HCI_OP_READ_INQ_RSP_TX_POWER, 0, NULL);
 
 	if (lmp_ext_feat_capable(hdev)) {
 		struct hci_cp_read_local_ext_features cp;
 
 		cp.page = 0x01;
-		hci_send_cmd(hdev, HCI_OP_READ_LOCAL_EXT_FEATURES, sizeof(cp),
-			     &cp);
+		hci_req_add(req, HCI_OP_READ_LOCAL_EXT_FEATURES,
+			    sizeof(cp), &cp);
 	}
 
 	if (test_bit(HCI_LINK_SECURITY, &hdev->dev_flags)) {
 		u8 enable = 1;
-		hci_send_cmd(hdev, HCI_OP_WRITE_AUTH_ENABLE, sizeof(enable),
-			     &enable);
+		hci_req_add(req, HCI_OP_WRITE_AUTH_ENABLE, sizeof(enable),
+			    &enable);
 	}
 }
 
-static void hci_setup_link_policy(struct hci_dev *hdev)
+static void hci_setup_link_policy(struct hci_request *req)
 {
+	struct hci_dev *hdev = req->hdev;
 	struct hci_cp_write_def_link_policy cp;
 	u16 link_policy = 0;
 
@@ -466,11 +463,12 @@ static void hci_setup_link_policy(struct hci_dev *hdev)
 		link_policy |= HCI_LP_PARK;
 
 	cp.policy = cpu_to_le16(link_policy);
-	hci_send_cmd(hdev, HCI_OP_WRITE_DEF_LINK_POLICY, sizeof(cp), &cp);
+	hci_req_add(req, HCI_OP_WRITE_DEF_LINK_POLICY, sizeof(cp), &cp);
 }
 
-static void hci_set_le_support(struct hci_dev *hdev)
+static void hci_set_le_support(struct hci_request *req)
 {
+	struct hci_dev *hdev = req->hdev;
 	struct hci_cp_write_le_host_supported cp;
 
 	memset(&cp, 0, sizeof(cp));
@@ -481,17 +479,19 @@ static void hci_set_le_support(struct hci_dev *hdev)
 	}
 
 	if (cp.le != lmp_host_le_capable(hdev))
-		hci_send_cmd(hdev, HCI_OP_WRITE_LE_HOST_SUPPORTED, sizeof(cp),
-			     &cp);
+		hci_req_add(req, HCI_OP_WRITE_LE_HOST_SUPPORTED, sizeof(cp),
+			    &cp);
 }
 
-static void hci_init3_req(struct hci_dev *hdev, unsigned long opt)
+static void hci_init3_req(struct hci_request *req, unsigned long opt)
 {
+	struct hci_dev *hdev = req->hdev;
+
 	if (hdev->commands[5] & 0x10)
-		hci_setup_link_policy(hdev);
+		hci_setup_link_policy(req);
 
 	if (lmp_le_capable(hdev))
-		hci_set_le_support(hdev);
+		hci_set_le_support(req);
 }
 
 static int __hci_init(struct hci_dev *hdev)
@@ -516,44 +516,44 @@ static int __hci_init(struct hci_dev *hdev)
 	return __hci_req_sync(hdev, hci_init3_req, 0, HCI_INIT_TIMEOUT);
 }
 
-static void hci_scan_req(struct hci_dev *hdev, unsigned long opt)
+static void hci_scan_req(struct hci_request *req, unsigned long opt)
 {
 	__u8 scan = opt;
 
-	BT_DBG("%s %x", hdev->name, scan);
+	BT_DBG("%s %x", req->hdev->name, scan);
 
 	/* Inquiry and Page scans */
-	hci_send_cmd(hdev, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
+	hci_req_add(req, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
 }
 
-static void hci_auth_req(struct hci_dev *hdev, unsigned long opt)
+static void hci_auth_req(struct hci_request *req, unsigned long opt)
 {
 	__u8 auth = opt;
 
-	BT_DBG("%s %x", hdev->name, auth);
+	BT_DBG("%s %x", req->hdev->name, auth);
 
 	/* Authentication */
-	hci_send_cmd(hdev, HCI_OP_WRITE_AUTH_ENABLE, 1, &auth);
+	hci_req_add(req, HCI_OP_WRITE_AUTH_ENABLE, 1, &auth);
 }
 
-static void hci_encrypt_req(struct hci_dev *hdev, unsigned long opt)
+static void hci_encrypt_req(struct hci_request *req, unsigned long opt)
 {
 	__u8 encrypt = opt;
 
-	BT_DBG("%s %x", hdev->name, encrypt);
+	BT_DBG("%s %x", req->hdev->name, encrypt);
 
 	/* Encryption */
-	hci_send_cmd(hdev, HCI_OP_WRITE_ENCRYPT_MODE, 1, &encrypt);
+	hci_req_add(req, HCI_OP_WRITE_ENCRYPT_MODE, 1, &encrypt);
 }
 
-static void hci_linkpol_req(struct hci_dev *hdev, unsigned long opt)
+static void hci_linkpol_req(struct hci_request *req, unsigned long opt)
 {
 	__le16 policy = cpu_to_le16(opt);
 
-	BT_DBG("%s %x", hdev->name, policy);
+	BT_DBG("%s %x", req->hdev->name, policy);
 
 	/* Default link policy */
-	hci_send_cmd(hdev, HCI_OP_WRITE_DEF_LINK_POLICY, 2, &policy);
+	hci_req_add(req, HCI_OP_WRITE_DEF_LINK_POLICY, 2, &policy);
 }
 
 /* Get HCI device by index.
@@ -790,9 +790,10 @@ static int inquiry_cache_dump(struct hci_dev *hdev, int num, __u8 *buf)
 	return copied;
 }
 
-static void hci_inq_req(struct hci_dev *hdev, unsigned long opt)
+static void hci_inq_req(struct hci_request *req, unsigned long opt)
 {
 	struct hci_inquiry_req *ir = (struct hci_inquiry_req *) opt;
+	struct hci_dev *hdev = req->hdev;
 	struct hci_cp_inquiry cp;
 
 	BT_DBG("%s", hdev->name);
@@ -804,7 +805,7 @@ static void hci_inq_req(struct hci_dev *hdev, unsigned long opt)
 	memcpy(&cp.lap, &ir->lap, 3);
 	cp.length  = ir->length;
 	cp.num_rsp = ir->num_rsp;
-	hci_send_cmd(hdev, HCI_OP_INQUIRY, sizeof(cp), &cp);
+	hci_req_add(req, HCI_OP_INQUIRY, sizeof(cp), &cp);
 }
 
 int hci_inquiry(void __user *arg)
@@ -1845,7 +1846,7 @@ int hci_blacklist_del(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type)
 	return mgmt_device_unblocked(hdev, bdaddr, type);
 }
 
-static void le_scan_param_req(struct hci_dev *hdev, unsigned long opt)
+static void le_scan_param_req(struct hci_request *req, unsigned long opt)
 {
 	struct le_scan_params *param =  (struct le_scan_params *) opt;
 	struct hci_cp_le_set_scan_param cp;
@@ -1855,10 +1856,10 @@ static void le_scan_param_req(struct hci_dev *hdev, unsigned long opt)
 	cp.interval = cpu_to_le16(param->interval);
 	cp.window = cpu_to_le16(param->window);
 
-	hci_send_cmd(hdev, HCI_OP_LE_SET_SCAN_PARAM, sizeof(cp), &cp);
+	hci_req_add(req, HCI_OP_LE_SET_SCAN_PARAM, sizeof(cp), &cp);
 }
 
-static void le_scan_enable_req(struct hci_dev *hdev, unsigned long opt)
+static void le_scan_enable_req(struct hci_request *req, unsigned long opt)
 {
 	struct hci_cp_le_set_scan_enable cp;
 
@@ -1866,7 +1867,7 @@ static void le_scan_enable_req(struct hci_dev *hdev, unsigned long opt)
 	cp.enable = 1;
 	cp.filter_dup = 1;
 
-	hci_send_cmd(hdev, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
+	hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
 }
 
 static int hci_do_le_scan(struct hci_dev *hdev, u8 type, u16 interval,
@@ -3219,6 +3220,28 @@ static bool hci_req_is_complete(struct hci_dev *hdev)
 	return bt_cb(skb)->req.start;
 }
 
+static void hci_resend_last(struct hci_dev *hdev)
+{
+	struct hci_command_hdr *sent;
+	struct sk_buff *skb;
+	u16 opcode;
+
+	if (!hdev->sent_cmd)
+		return;
+
+	sent = (void *) hdev->sent_cmd->data;
+	opcode = __le16_to_cpu(sent->opcode);
+	if (opcode == HCI_OP_RESET)
+		return;
+
+	skb = skb_clone(hdev->sent_cmd, GFP_KERNEL);
+	if (!skb)
+		return;
+
+	skb_queue_head(&hdev->cmd_q, skb);
+	queue_work(hdev->workqueue, &hdev->cmd_work);
+}
+
 void hci_req_cmd_complete(struct hci_dev *hdev, u16 opcode, u8 status)
 {
 	hci_req_complete_t req_complete = NULL;
@@ -3227,11 +3250,21 @@ void hci_req_cmd_complete(struct hci_dev *hdev, u16 opcode, u8 status)
 
 	BT_DBG("opcode 0x%04x status 0x%02x", opcode, status);
 
-	/* Check that the completed command really matches the last one
-	 * that was sent.
+	/* If the completed command doesn't match the last one that was
+	 * sent we need to do special handling of it.
 	 */
-	if (!hci_sent_cmd_data(hdev, opcode))
+	if (!hci_sent_cmd_data(hdev, opcode)) {
+		/* Some CSR based controllers generate a spontaneous
+		 * reset complete event during init and any pending
+		 * command will never be completed. In such a case we
+		 * need to resend whatever was the last sent
+		 * command.
+		 */
+		if (test_bit(HCI_INIT, &hdev->flags) && opcode == HCI_OP_RESET)
+			hci_resend_last(hdev);
+
 		return;
+	}
 
 	/* If the command succeeded and there's still more commands in
 	 * this request the request is not yet complete.
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 8b878a3..0dd85a0 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -54,7 +54,6 @@ static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_dev_unlock(hdev);
 
 	hci_req_cmd_complete(hdev, HCI_OP_INQUIRY, status);
-	hci_req_complete(hdev, HCI_OP_INQUIRY_CANCEL, status);
 
 	hci_conn_check_pending(hdev);
 }
@@ -184,8 +183,6 @@ static void hci_cc_write_def_link_policy(struct hci_dev *hdev,
 
 	if (!status)
 		hdev->link_policy = get_unaligned_le16(sent);
-
-	hci_req_complete(hdev, HCI_OP_WRITE_DEF_LINK_POLICY, status);
 }
 
 static void hci_cc_reset(struct hci_dev *hdev, struct sk_buff *skb)
@@ -196,8 +193,6 @@ static void hci_cc_reset(struct hci_dev *hdev, struct sk_buff *skb)
 
 	clear_bit(HCI_RESET, &hdev->flags);
 
-	hci_req_complete(hdev, HCI_OP_RESET, status);
-
 	/* Reset all non-persistent flags */
 	hdev->dev_flags &= ~(BIT(HCI_LE_SCAN) | BIT(HCI_PENDING_CLASS) |
 			     BIT(HCI_PERIODIC_INQ));
@@ -232,8 +227,6 @@ static void hci_cc_write_local_name(struct hci_dev *hdev, struct sk_buff *skb)
 
 	if (!status && !test_bit(HCI_INIT, &hdev->flags))
 		hci_update_ad(hdev);
-
-	hci_req_complete(hdev, HCI_OP_WRITE_LOCAL_NAME, status);
 }
 
 static void hci_cc_read_local_name(struct hci_dev *hdev, struct sk_buff *skb)
@@ -271,8 +264,6 @@ static void hci_cc_write_auth_enable(struct hci_dev *hdev, struct sk_buff *skb)
 
 	if (test_bit(HCI_MGMT, &hdev->dev_flags))
 		mgmt_auth_enable_complete(hdev, status);
-
-	hci_req_complete(hdev, HCI_OP_WRITE_AUTH_ENABLE, status);
 }
 
 static void hci_cc_write_encrypt_mode(struct hci_dev *hdev, struct sk_buff *skb)
@@ -294,8 +285,6 @@ static void hci_cc_write_encrypt_mode(struct hci_dev *hdev, struct sk_buff *skb)
 		else
 			clear_bit(HCI_ENCRYPT, &hdev->flags);
 	}
-
-	hci_req_complete(hdev, HCI_OP_WRITE_ENCRYPT_MODE, status);
 }
 
 static void hci_cc_write_scan_enable(struct hci_dev *hdev, struct sk_buff *skb)
@@ -344,7 +333,6 @@ static void hci_cc_write_scan_enable(struct hci_dev *hdev, struct sk_buff *skb)
 
 done:
 	hci_dev_unlock(hdev);
-	hci_req_complete(hdev, HCI_OP_WRITE_SCAN_ENABLE, status);
 }
 
 static void hci_cc_read_class_of_dev(struct hci_dev *hdev, struct sk_buff *skb)
@@ -441,8 +429,6 @@ static void hci_cc_host_buffer_size(struct hci_dev *hdev, struct sk_buff *skb)
 	__u8 status = *((__u8 *) skb->data);
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, status);
-
-	hci_req_complete(hdev, HCI_OP_HOST_BUFFER_SIZE, status);
 }
 
 static void hci_cc_write_ssp_mode(struct hci_dev *hdev, struct sk_buff *skb)
@@ -480,7 +466,7 @@ static void hci_cc_read_local_version(struct hci_dev *hdev, struct sk_buff *skb)
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
 	if (rp->status)
-		goto done;
+		return;
 
 	hdev->hci_ver = rp->hci_ver;
 	hdev->hci_rev = __le16_to_cpu(rp->hci_rev);
@@ -490,9 +476,6 @@ static void hci_cc_read_local_version(struct hci_dev *hdev, struct sk_buff *skb)
 
 	BT_DBG("%s manufacturer 0x%4.4x hci ver %d:%d", hdev->name,
 	       hdev->manufacturer, hdev->hci_ver, hdev->hci_rev);
-
-done:
-	hci_req_complete(hdev, HCI_OP_READ_LOCAL_VERSION, rp->status);
 }
 
 static void hci_cc_read_local_commands(struct hci_dev *hdev,
@@ -504,8 +487,6 @@ static void hci_cc_read_local_commands(struct hci_dev *hdev,
 
 	if (!rp->status)
 		memcpy(hdev->commands, rp->commands, sizeof(hdev->commands));
-
-	hci_req_complete(hdev, HCI_OP_READ_LOCAL_COMMANDS, rp->status);
 }
 
 static void hci_cc_read_local_features(struct hci_dev *hdev,
@@ -572,7 +553,7 @@ static void hci_cc_read_local_ext_features(struct hci_dev *hdev,
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
 	if (rp->status)
-		goto done;
+		return;
 
 	switch (rp->page) {
 	case 0:
@@ -582,9 +563,6 @@ static void hci_cc_read_local_ext_features(struct hci_dev *hdev,
 		memcpy(hdev->host_features, rp->features, 8);
 		break;
 	}
-
-done:
-	hci_req_complete(hdev, HCI_OP_READ_LOCAL_EXT_FEATURES, rp->status);
 }
 
 static void hci_cc_read_flow_control_mode(struct hci_dev *hdev,
@@ -594,12 +572,8 @@ static void hci_cc_read_flow_control_mode(struct hci_dev *hdev,
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
-	if (rp->status)
-		return;
-
-	hdev->flow_ctl_mode = rp->mode;
-
-	hci_req_complete(hdev, HCI_OP_READ_FLOW_CONTROL_MODE, rp->status);
+	if (!rp->status)
+		hdev->flow_ctl_mode = rp->mode;
 }
 
 static void hci_cc_read_buffer_size(struct hci_dev *hdev, struct sk_buff *skb)
@@ -636,8 +610,6 @@ static void hci_cc_read_bd_addr(struct hci_dev *hdev, struct sk_buff *skb)
 
 	if (!rp->status)
 		bacpy(&hdev->bdaddr, &rp->bdaddr);
-
-	hci_req_complete(hdev, HCI_OP_READ_BD_ADDR, rp->status);
 }
 
 static void hci_cc_read_data_block_size(struct hci_dev *hdev,
@@ -658,8 +630,6 @@ static void hci_cc_read_data_block_size(struct hci_dev *hdev,
 
 	BT_DBG("%s blk mtu %d cnt %d len %d", hdev->name, hdev->block_mtu,
 	       hdev->block_cnt, hdev->block_len);
-
-	hci_req_complete(hdev, HCI_OP_READ_DATA_BLOCK_SIZE, rp->status);
 }
 
 static void hci_cc_write_ca_timeout(struct hci_dev *hdev, struct sk_buff *skb)
@@ -667,8 +637,6 @@ static void hci_cc_write_ca_timeout(struct hci_dev *hdev, struct sk_buff *skb)
 	__u8 status = *((__u8 *) skb->data);
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, status);
-
-	hci_req_complete(hdev, HCI_OP_WRITE_CA_TIMEOUT, status);
 }
 
 static void hci_cc_read_local_amp_info(struct hci_dev *hdev,
@@ -692,8 +660,6 @@ static void hci_cc_read_local_amp_info(struct hci_dev *hdev,
 	hdev->amp_be_flush_to = __le32_to_cpu(rp->be_flush_to);
 	hdev->amp_max_flush_to = __le32_to_cpu(rp->max_flush_to);
 
-	hci_req_complete(hdev, HCI_OP_READ_LOCAL_AMP_INFO, rp->status);
-
 a2mp_rsp:
 	a2mp_send_getinfo_rsp(hdev);
 }
@@ -741,8 +707,6 @@ static void hci_cc_delete_stored_link_key(struct hci_dev *hdev,
 	__u8 status = *((__u8 *) skb->data);
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, status);
-
-	hci_req_complete(hdev, HCI_OP_DELETE_STORED_LINK_KEY, status);
 }
 
 static void hci_cc_set_event_mask(struct hci_dev *hdev, struct sk_buff *skb)
@@ -750,8 +714,6 @@ static void hci_cc_set_event_mask(struct hci_dev *hdev, struct sk_buff *skb)
 	__u8 status = *((__u8 *) skb->data);
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, status);
-
-	hci_req_complete(hdev, HCI_OP_SET_EVENT_MASK, status);
 }
 
 static void hci_cc_write_inquiry_mode(struct hci_dev *hdev,
@@ -760,8 +722,6 @@ static void hci_cc_write_inquiry_mode(struct hci_dev *hdev,
 	__u8 status = *((__u8 *) skb->data);
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, status);
-
-	hci_req_complete(hdev, HCI_OP_WRITE_INQUIRY_MODE, status);
 }
 
 static void hci_cc_read_inq_rsp_tx_power(struct hci_dev *hdev,
@@ -773,8 +733,6 @@ static void hci_cc_read_inq_rsp_tx_power(struct hci_dev *hdev,
 
 	if (!rp->status)
 		hdev->inq_tx_power = rp->tx_power;
-
-	hci_req_complete(hdev, HCI_OP_READ_INQ_RSP_TX_POWER, rp->status);
 }
 
 static void hci_cc_set_event_flt(struct hci_dev *hdev, struct sk_buff *skb)
@@ -782,8 +740,6 @@ static void hci_cc_set_event_flt(struct hci_dev *hdev, struct sk_buff *skb)
 	__u8 status = *((__u8 *) skb->data);
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, status);
-
-	hci_req_complete(hdev, HCI_OP_SET_EVENT_FLT, status);
 }
 
 static void hci_cc_pin_code_reply(struct hci_dev *hdev, struct sk_buff *skb)
@@ -845,8 +801,6 @@ static void hci_cc_le_read_buffer_size(struct hci_dev *hdev,
 	hdev->le_cnt = hdev->le_pkts;
 
 	BT_DBG("%s le mtu %d:%d", hdev->name, hdev->le_mtu, hdev->le_pkts);
-
-	hci_req_complete(hdev, HCI_OP_LE_READ_BUFFER_SIZE, rp->status);
 }
 
 static void hci_cc_le_read_local_features(struct hci_dev *hdev,
@@ -858,8 +812,6 @@ static void hci_cc_le_read_local_features(struct hci_dev *hdev,
 
 	if (!rp->status)
 		memcpy(hdev->le_features, rp->features, 8);
-
-	hci_req_complete(hdev, HCI_OP_LE_READ_LOCAL_FEATURES, rp->status);
 }
 
 static void hci_cc_le_read_adv_tx_power(struct hci_dev *hdev,
@@ -874,8 +826,6 @@ static void hci_cc_le_read_adv_tx_power(struct hci_dev *hdev,
 		if (!test_bit(HCI_INIT, &hdev->flags))
 			hci_update_ad(hdev);
 	}
-
-	hci_req_complete(hdev, HCI_OP_LE_READ_ADV_TX_POWER, rp->status);
 }
 
 static void hci_cc_le_set_event_mask(struct hci_dev *hdev, struct sk_buff *skb)
@@ -883,8 +833,6 @@ static void hci_cc_le_set_event_mask(struct hci_dev *hdev, struct sk_buff *skb)
 	__u8 status = *((__u8 *) skb->data);
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, status);
-
-	hci_req_complete(hdev, HCI_OP_LE_SET_EVENT_MASK, status);
 }
 
 static void hci_cc_user_confirm_reply(struct hci_dev *hdev, struct sk_buff *skb)
@@ -985,8 +933,6 @@ static void hci_cc_le_set_adv_enable(struct hci_dev *hdev, struct sk_buff *skb)
 
 	if (!test_bit(HCI_INIT, &hdev->flags))
 		hci_update_ad(hdev);
-
-	hci_req_complete(hdev, HCI_OP_LE_SET_ADV_ENABLE, status);
 }
 
 static void hci_cc_le_set_scan_param(struct hci_dev *hdev, struct sk_buff *skb)
@@ -995,8 +941,6 @@ static void hci_cc_le_set_scan_param(struct hci_dev *hdev, struct sk_buff *skb)
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, status);
 
-	hci_req_complete(hdev, HCI_OP_LE_SET_SCAN_PARAM, status);
-
 	if (status) {
 		hci_dev_lock(hdev);
 		mgmt_start_discovery_failed(hdev, status);
@@ -1019,8 +963,6 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 
 	switch (cp->enable) {
 	case LE_SCANNING_ENABLED:
-		hci_req_complete(hdev, HCI_OP_LE_SET_SCAN_ENABLE, status);
-
 		if (status) {
 			hci_dev_lock(hdev);
 			mgmt_start_discovery_failed(hdev, status);
@@ -1071,8 +1013,6 @@ static void hci_cc_le_read_white_list_size(struct hci_dev *hdev,
 
 	if (!rp->status)
 		hdev->le_white_list_size = rp->size;
-
-	hci_req_complete(hdev, HCI_OP_LE_READ_WHITE_LIST_SIZE, rp->status);
 }
 
 static void hci_cc_le_ltk_reply(struct hci_dev *hdev, struct sk_buff *skb)
@@ -1083,8 +1023,6 @@ static void hci_cc_le_ltk_reply(struct hci_dev *hdev, struct sk_buff *skb)
 
 	if (rp->status)
 		return;
-
-	hci_req_complete(hdev, HCI_OP_LE_LTK_REPLY, rp->status);
 }
 
 static void hci_cc_le_ltk_neg_reply(struct hci_dev *hdev, struct sk_buff *skb)
@@ -1095,8 +1033,6 @@ static void hci_cc_le_ltk_neg_reply(struct hci_dev *hdev, struct sk_buff *skb)
 
 	if (rp->status)
 		return;
-
-	hci_req_complete(hdev, HCI_OP_LE_LTK_NEG_REPLY, rp->status);
 }
 
 static void hci_cc_le_read_supported_states(struct hci_dev *hdev,
@@ -1108,8 +1044,6 @@ static void hci_cc_le_read_supported_states(struct hci_dev *hdev,
 
 	if (!rp->status)
 		memcpy(hdev->le_states, rp->le_states, 8);
-
-	hci_req_complete(hdev, HCI_OP_LE_READ_SUPPORTED_STATES, rp->status);
 }
 
 static void hci_cc_write_le_host_supported(struct hci_dev *hdev,
@@ -1139,8 +1073,6 @@ static void hci_cc_write_le_host_supported(struct hci_dev *hdev,
 	if (test_bit(HCI_MGMT, &hdev->dev_flags) &&
 	    !test_bit(HCI_INIT, &hdev->flags))
 		mgmt_le_enable_complete(hdev, sent->le, status);
-
-	hci_req_complete(hdev, HCI_OP_WRITE_LE_HOST_SUPPORTED, status);
 }
 
 static void hci_cc_write_remote_amp_assoc(struct hci_dev *hdev,
@@ -1162,7 +1094,6 @@ static void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
 	BT_DBG("%s status 0x%2.2x", hdev->name, status);
 
 	if (status) {
-		hci_req_complete(hdev, HCI_OP_INQUIRY, status);
 		hci_conn_check_pending(hdev);
 		hci_dev_lock(hdev);
 		if (test_bit(HCI_MGMT, &hdev->dev_flags))
@@ -1694,7 +1625,6 @@ static void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	BT_DBG("%s status 0x%2.2x", hdev->name, status);
 
 	hci_req_cmd_complete(hdev, HCI_OP_INQUIRY, status);
-	hci_req_complete(hdev, HCI_OP_INQUIRY, status);
 
 	hci_conn_check_pending(hdev);
 
-- 
1.7.10.4

