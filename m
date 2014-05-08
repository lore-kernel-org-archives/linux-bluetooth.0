Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 4/8] Bluetooth: Add support for user data in hci_request
Date: Thu, 8 May 2014 15:32:11 +0200
Message-ID: <1399555935-702-5-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1399555935-702-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1399555935-702-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch makes possible to store some user data in hci_request struct
which will be available in completion callback. Data can be added when
initializing new request using hci_req_init(). With this it's now easy
to run request which can be associated with e.g. specific hci_conn.

Signed-off-by: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
---
 include/net/bluetooth/bluetooth.h |  3 +-
 include/net/bluetooth/hci_core.h  |  3 +-
 net/bluetooth/hci_conn.c          |  4 +-
 net/bluetooth/hci_core.c          | 29 +++++++++-----
 net/bluetooth/mgmt.c              | 84 +++++++++++++++++++++------------------
 5 files changed, 69 insertions(+), 54 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 904777c1..28378ad 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -273,12 +273,13 @@ struct l2cap_ctrl {
 
 struct hci_dev;
 
-typedef void (*hci_req_complete_t)(struct hci_dev *hdev, u8 status);
+typedef void (*hci_req_complete_t)(struct hci_dev *hdev, u8 status, void *data);
 
 struct hci_req_ctrl {
 	bool			start;
 	u8			event;
 	hci_req_complete_t	complete;
+	void			*data;
 };
 
 struct bt_skb_cb {
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 211bad6..30d245f 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1162,6 +1162,7 @@ int hci_unregister_cb(struct hci_cb *hcb);
 struct hci_request {
 	struct hci_dev		*hdev;
 	struct sk_buff_head	cmd_q;
+	void			*data;
 
 	/* If something goes wrong when building the HCI request, the error
 	 * value is stored in this field.
@@ -1169,7 +1170,7 @@ struct hci_request {
 	int			err;
 };
 
-void hci_req_init(struct hci_request *req, struct hci_dev *hdev);
+void hci_req_init(struct hci_request *req, struct hci_dev *hdev, void *data);
 int hci_req_run(struct hci_request *req, hci_req_complete_t complete);
 void hci_req_add(struct hci_request *req, u16 opcode, u32 plen,
 		 const void *param);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 74b368b..78cfe3b 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -571,7 +571,7 @@ void hci_le_conn_failed(struct hci_conn *conn, u8 status)
 	mgmt_reenable_advertising(hdev);
 }
 
-static void create_le_conn_complete(struct hci_dev *hdev, u8 status)
+static void create_le_conn_complete(struct hci_dev *hdev, u8 status, void *data)
 {
 	struct hci_conn *conn;
 
@@ -728,7 +728,7 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 	conn->pending_sec_level = sec_level;
 	conn->auth_type = auth_type;
 
-	hci_req_init(&req, hdev);
+	hci_req_init(&req, hdev, NULL);
 
 	if (test_bit(HCI_ADVERTISING, &hdev->dev_flags)) {
 		hci_req_directed_advertising(&req, conn);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index d31f144..f5dcbb1 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1020,7 +1020,7 @@ static const struct file_operations le_auto_conn_fops = {
 
 /* ---- HCI requests ---- */
 
-static void hci_req_sync_complete(struct hci_dev *hdev, u8 result)
+static void hci_req_sync_complete(struct hci_dev *hdev, u8 result, void *data)
 {
 	BT_DBG("%s result 0x%2.2x", hdev->name, result);
 
@@ -1106,7 +1106,7 @@ struct sk_buff *__hci_cmd_sync_ev(struct hci_dev *hdev, u16 opcode, u32 plen,
 
 	BT_DBG("%s", hdev->name);
 
-	hci_req_init(&req, hdev);
+	hci_req_init(&req, hdev, NULL);
 
 	hci_req_add_ev(&req, opcode, plen, param, event);
 
@@ -1170,7 +1170,7 @@ static int __hci_req_sync(struct hci_dev *hdev,
 
 	BT_DBG("%s start", hdev->name);
 
-	hci_req_init(&req, hdev);
+	hci_req_init(&req, hdev, NULL);
 
 	hdev->req_status = HCI_REQ_PEND;
 
@@ -3573,7 +3573,7 @@ void hci_pend_le_conns_clear(struct hci_dev *hdev)
 	BT_DBG("All LE pending connections cleared");
 }
 
-static void inquiry_complete(struct hci_dev *hdev, u8 status)
+static void inquiry_complete(struct hci_dev *hdev, u8 status, void *data)
 {
 	if (status) {
 		BT_ERR("Failed to start inquiry: status %d", status);
@@ -3585,7 +3585,8 @@ static void inquiry_complete(struct hci_dev *hdev, u8 status)
 	}
 }
 
-static void le_scan_disable_work_complete(struct hci_dev *hdev, u8 status)
+static void le_scan_disable_work_complete(struct hci_dev *hdev, u8 status,
+					  void *data)
 {
 	/* General inquiry access code (GIAC) */
 	u8 lap[3] = { 0x33, 0x8b, 0x9e };
@@ -3606,7 +3607,7 @@ static void le_scan_disable_work_complete(struct hci_dev *hdev, u8 status)
 		break;
 
 	case DISCOV_TYPE_INTERLEAVED:
-		hci_req_init(&req, hdev);
+		hci_req_init(&req, hdev, NULL);
 
 		memset(&cp, 0, sizeof(cp));
 		memcpy(&cp.lap, lap, sizeof(cp.lap));
@@ -3637,7 +3638,7 @@ static void le_scan_disable_work(struct work_struct *work)
 
 	BT_DBG("%s", hdev->name);
 
-	hci_req_init(&req, hdev);
+	hci_req_init(&req, hdev, NULL);
 
 	hci_req_add_le_scan_disable(&req);
 
@@ -4263,10 +4264,11 @@ static void hci_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 		BT_ERR("%s sending frame failed", hdev->name);
 }
 
-void hci_req_init(struct hci_request *req, struct hci_dev *hdev)
+void hci_req_init(struct hci_request *req, struct hci_dev *hdev, void *data)
 {
 	skb_queue_head_init(&req->cmd_q);
 	req->hdev = hdev;
+	req->data = data;
 	req->err = 0;
 }
 
@@ -4292,6 +4294,7 @@ int hci_req_run(struct hci_request *req, hci_req_complete_t complete)
 
 	skb = skb_peek_tail(&req->cmd_q);
 	bt_cb(skb)->req.complete = complete;
+	bt_cb(skb)->req.data = req->data;
 
 	spin_lock_irqsave(&hdev->cmd_q.lock, flags);
 	skb_queue_splice_tail(&req->cmd_q, &hdev->cmd_q);
@@ -5083,6 +5086,7 @@ static void hci_resend_last(struct hci_dev *hdev)
 void hci_req_cmd_complete(struct hci_dev *hdev, u16 opcode, u8 status)
 {
 	hci_req_complete_t req_complete = NULL;
+	void *req_data = NULL;
 	struct sk_buff *skb;
 	unsigned long flags;
 
@@ -5116,6 +5120,7 @@ void hci_req_cmd_complete(struct hci_dev *hdev, u16 opcode, u8 status)
 	 */
 	if (hdev->sent_cmd) {
 		req_complete = bt_cb(hdev->sent_cmd)->req.complete;
+		req_data = bt_cb(hdev->sent_cmd)->req.data;
 
 		if (req_complete) {
 			/* We must set the complete callback to NULL to
@@ -5137,13 +5142,14 @@ void hci_req_cmd_complete(struct hci_dev *hdev, u16 opcode, u8 status)
 		}
 
 		req_complete = bt_cb(skb)->req.complete;
+		req_data = bt_cb(skb)->req.data;
 		kfree_skb(skb);
 	}
 	spin_unlock_irqrestore(&hdev->cmd_q.lock, flags);
 
 call_complete:
 	if (req_complete)
-		req_complete(hdev, status);
+		req_complete(hdev, status, req_data);
 }
 
 static void hci_rx_work(struct work_struct *work)
@@ -5273,7 +5279,8 @@ void hci_req_add_le_passive_scan(struct hci_request *req)
 		    &enable_cp);
 }
 
-static void update_background_scan_complete(struct hci_dev *hdev, u8 status)
+static void update_background_scan_complete(struct hci_dev *hdev, u8 status,
+					    void *data)
 {
 	if (status)
 		BT_DBG("HCI request failed to update background scanning: "
@@ -5292,7 +5299,7 @@ void hci_update_background_scan(struct hci_dev *hdev)
 	struct hci_conn *conn;
 	int err;
 
-	hci_req_init(&req, hdev);
+	hci_req_init(&req, hdev, NULL);
 
 	if (list_empty(&hdev->pend_le_conns)) {
 		/* If there is no pending LE connections, we should stop
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 840b273..bb3188f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -896,7 +896,7 @@ static void service_cache_off(struct work_struct *work)
 	if (!test_and_clear_bit(HCI_SERVICE_CACHE, &hdev->dev_flags))
 		return;
 
-	hci_req_init(&req, hdev);
+	hci_req_init(&req, hdev, NULL);
 
 	hci_dev_lock(hdev);
 
@@ -926,7 +926,7 @@ static void rpa_expired(struct work_struct *work)
 	 * controller happens in the enable_advertising() function.
 	 */
 
-	hci_req_init(&req, hdev);
+	hci_req_init(&req, hdev, NULL);
 
 	disable_advertising(&req);
 	enable_advertising(&req);
@@ -1046,7 +1046,7 @@ static int send_settings_rsp(struct sock *sk, u16 opcode, struct hci_dev *hdev)
 			    sizeof(settings));
 }
 
-static void clean_up_hci_complete(struct hci_dev *hdev, u8 status)
+static void clean_up_hci_complete(struct hci_dev *hdev, u8 status, void *data)
 {
 	BT_DBG("%s status 0x%02x", hdev->name, status);
 
@@ -1061,7 +1061,7 @@ static int clean_up_hci_state(struct hci_dev *hdev)
 	struct hci_request req;
 	struct hci_conn *conn;
 
-	hci_req_init(&req, hdev);
+	hci_req_init(&req, hdev, NULL);
 
 	if (test_bit(HCI_ISCAN, &hdev->flags) ||
 	    test_bit(HCI_PSCAN, &hdev->flags)) {
@@ -1266,7 +1266,8 @@ static u8 mgmt_le_support(struct hci_dev *hdev)
 		return MGMT_STATUS_SUCCESS;
 }
 
-static void set_discoverable_complete(struct hci_dev *hdev, u8 status)
+static void set_discoverable_complete(struct hci_dev *hdev, u8 status,
+				      void *data)
 {
 	struct pending_cmd *cmd;
 	struct mgmt_mode *cp;
@@ -1312,7 +1313,7 @@ static void set_discoverable_complete(struct hci_dev *hdev, u8 status)
 	 * that class of device has the limited discoverable
 	 * bit correctly set.
 	 */
-	hci_req_init(&req, hdev);
+	hci_req_init(&req, hdev, NULL);
 	update_class(&req);
 	hci_req_run(&req, NULL);
 
@@ -1436,7 +1437,7 @@ static int set_discoverable(struct sock *sk, struct hci_dev *hdev, void *data,
 	else
 		clear_bit(HCI_LIMITED_DISCOVERABLE, &hdev->dev_flags);
 
-	hci_req_init(&req, hdev);
+	hci_req_init(&req, hdev, NULL);
 
 	/* The procedure for LE-only controllers is much simpler - just
 	 * update the advertising data.
@@ -1523,7 +1524,8 @@ static void write_fast_connectable(struct hci_request *req, bool enable)
 		hci_req_add(req, HCI_OP_WRITE_PAGE_SCAN_TYPE, 1, &type);
 }
 
-static void set_connectable_complete(struct hci_dev *hdev, u8 status)
+static void set_connectable_complete(struct hci_dev *hdev, u8 status,
+				     void *data)
 {
 	struct pending_cmd *cmd;
 	struct mgmt_mode *cp;
@@ -1627,7 +1629,7 @@ static int set_connectable(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto failed;
 	}
 
-	hci_req_init(&req, hdev);
+	hci_req_init(&req, hdev, NULL);
 
 	/* If BR/EDR is not enabled and we disable advertising as a
 	 * by-product of disabling connectable, we need to update the
@@ -1913,7 +1915,7 @@ unlock:
 	return err;
 }
 
-static void le_enable_complete(struct hci_dev *hdev, u8 status)
+static void le_enable_complete(struct hci_dev *hdev, u8 status, void *data)
 {
 	struct cmd_lookup match = { NULL, hdev };
 
@@ -1942,7 +1944,7 @@ static void le_enable_complete(struct hci_dev *hdev, u8 status)
 
 		hci_dev_lock(hdev);
 
-		hci_req_init(&req, hdev);
+		hci_req_init(&req, hdev, NULL);
 		update_adv_data(&req);
 		update_scan_rsp_data(&req);
 		hci_req_run(&req, NULL);
@@ -2016,7 +2018,7 @@ static int set_le(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 		goto unlock;
 	}
 
-	hci_req_init(&req, hdev);
+	hci_req_init(&req, hdev, NULL);
 
 	memset(&hci_cp, 0, sizeof(hci_cp));
 
@@ -2101,7 +2103,7 @@ unlock:
 	hci_dev_unlock(hdev);
 }
 
-static void add_uuid_complete(struct hci_dev *hdev, u8 status)
+static void add_uuid_complete(struct hci_dev *hdev, u8 status, void *data)
 {
 	BT_DBG("status 0x%02x", status);
 
@@ -2138,7 +2140,7 @@ static int add_uuid(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 
 	list_add_tail(&uuid->list, &hdev->uuids);
 
-	hci_req_init(&req, hdev);
+	hci_req_init(&req, hdev, NULL);
 
 	update_class(&req);
 	update_eir(&req);
@@ -2180,7 +2182,7 @@ static bool enable_service_cache(struct hci_dev *hdev)
 	return false;
 }
 
-static void remove_uuid_complete(struct hci_dev *hdev, u8 status)
+static void remove_uuid_complete(struct hci_dev *hdev, u8 status, void *data)
 {
 	BT_DBG("status 0x%02x", status);
 
@@ -2237,7 +2239,7 @@ static int remove_uuid(struct sock *sk, struct hci_dev *hdev, void *data,
 	}
 
 update_class:
-	hci_req_init(&req, hdev);
+	hci_req_init(&req, hdev, NULL);
 
 	update_class(&req);
 	update_eir(&req);
@@ -2265,7 +2267,7 @@ unlock:
 	return err;
 }
 
-static void set_class_complete(struct hci_dev *hdev, u8 status)
+static void set_class_complete(struct hci_dev *hdev, u8 status, void *data)
 {
 	BT_DBG("status 0x%02x", status);
 
@@ -2309,7 +2311,7 @@ static int set_dev_class(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto unlock;
 	}
 
-	hci_req_init(&req, hdev);
+	hci_req_init(&req, hdev, NULL);
 
 	if (test_and_clear_bit(HCI_SERVICE_CACHE, &hdev->dev_flags)) {
 		hci_dev_unlock(hdev);
@@ -3119,7 +3121,7 @@ static void update_name(struct hci_request *req)
 	hci_req_add(req, HCI_OP_WRITE_LOCAL_NAME, sizeof(cp), &cp);
 }
 
-static void set_name_complete(struct hci_dev *hdev, u8 status)
+static void set_name_complete(struct hci_dev *hdev, u8 status, void *data)
 {
 	struct mgmt_cp_set_local_name *cp;
 	struct pending_cmd *cmd;
@@ -3194,7 +3196,7 @@ static int set_local_name(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	memcpy(hdev->dev_name, cp->name, sizeof(hdev->dev_name));
 
-	hci_req_init(&req, hdev);
+	hci_req_init(&req, hdev, NULL);
 
 	if (lmp_bredr_capable(hdev)) {
 		update_name(&req);
@@ -3357,7 +3359,8 @@ static int mgmt_start_discovery_failed(struct hci_dev *hdev, u8 status)
 	return err;
 }
 
-static void start_discovery_complete(struct hci_dev *hdev, u8 status)
+static void start_discovery_complete(struct hci_dev *hdev, u8 status,
+				     void *data)
 {
 	unsigned long timeout = 0;
 
@@ -3440,7 +3443,7 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 
 	hdev->discovery.type = cp->type;
 
-	hci_req_init(&req, hdev);
+	hci_req_init(&req, hdev, NULL);
 
 	switch (hdev->discovery.type) {
 	case DISCOV_TYPE_BREDR:
@@ -3561,7 +3564,8 @@ static int mgmt_stop_discovery_failed(struct hci_dev *hdev, u8 status)
 	return err;
 }
 
-static void stop_discovery_complete(struct hci_dev *hdev, u8 status)
+static void stop_discovery_complete(struct hci_dev *hdev, u8 status,
+				    void *data)
 {
 	BT_DBG("status %d", status);
 
@@ -3612,7 +3616,7 @@ static int stop_discovery(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto unlock;
 	}
 
-	hci_req_init(&req, hdev);
+	hci_req_init(&req, hdev, NULL);
 
 	switch (hdev->discovery.state) {
 	case DISCOVERY_FINDING:
@@ -3793,7 +3797,7 @@ static int set_device_id(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	err = cmd_complete(sk, hdev->id, MGMT_OP_SET_DEVICE_ID, 0, NULL, 0);
 
-	hci_req_init(&req, hdev);
+	hci_req_init(&req, hdev, NULL);
 	update_eir(&req);
 	hci_req_run(&req, NULL);
 
@@ -3802,7 +3806,8 @@ static int set_device_id(struct sock *sk, struct hci_dev *hdev, void *data,
 	return err;
 }
 
-static void set_advertising_complete(struct hci_dev *hdev, u8 status)
+static void set_advertising_complete(struct hci_dev *hdev, u8 status,
+				     void *data)
 {
 	struct cmd_lookup match = { NULL, hdev };
 
@@ -3885,7 +3890,7 @@ static int set_advertising(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto unlock;
 	}
 
-	hci_req_init(&req, hdev);
+	hci_req_init(&req, hdev, NULL);
 
 	if (val)
 		enable_advertising(&req);
@@ -3984,7 +3989,7 @@ static int set_scan_params(struct sock *sk, struct hci_dev *hdev,
 	    hdev->discovery.state == DISCOVERY_STOPPED) {
 		struct hci_request req;
 
-		hci_req_init(&req, hdev);
+		hci_req_init(&req, hdev, NULL);
 
 		hci_req_add_le_scan_disable(&req);
 		hci_req_add_le_passive_scan(&req);
@@ -3997,7 +4002,8 @@ static int set_scan_params(struct sock *sk, struct hci_dev *hdev,
 	return err;
 }
 
-static void fast_connectable_complete(struct hci_dev *hdev, u8 status)
+static void fast_connectable_complete(struct hci_dev *hdev, u8 status,
+				      void *data)
 {
 	struct pending_cmd *cmd;
 
@@ -4078,7 +4084,7 @@ static int set_fast_connectable(struct sock *sk, struct hci_dev *hdev,
 		goto unlock;
 	}
 
-	hci_req_init(&req, hdev);
+	hci_req_init(&req, hdev, NULL);
 
 	write_fast_connectable(&req, cp->val);
 
@@ -4115,7 +4121,7 @@ static void set_bredr_scan(struct hci_request *req)
 		hci_req_add(req, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
 }
 
-static void set_bredr_complete(struct hci_dev *hdev, u8 status)
+static void set_bredr_complete(struct hci_dev *hdev, u8 status, void *data)
 {
 	struct pending_cmd *cmd;
 
@@ -4218,7 +4224,7 @@ static int set_bredr(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 	 */
 	set_bit(HCI_BREDR_ENABLED, &hdev->dev_flags);
 
-	hci_req_init(&req, hdev);
+	hci_req_init(&req, hdev, NULL);
 
 	if (test_bit(HCI_CONNECTABLE, &hdev->dev_flags))
 		set_bredr_scan(&req);
@@ -4750,7 +4756,7 @@ static void restart_le_auto_conns(struct hci_dev *hdev)
 	}
 }
 
-static void powered_complete(struct hci_dev *hdev, u8 status)
+static void powered_complete(struct hci_dev *hdev, u8 status, void *data)
 {
 	struct cmd_lookup match = { NULL, hdev };
 
@@ -4775,7 +4781,7 @@ static int powered_update_hci(struct hci_dev *hdev)
 	struct hci_request req;
 	u8 link_sec;
 
-	hci_req_init(&req, hdev);
+	hci_req_init(&req, hdev, NULL);
 
 	if (test_bit(HCI_SSP_ENABLED, &hdev->dev_flags) &&
 	    !lmp_host_ssp_capable(hdev)) {
@@ -4898,7 +4904,7 @@ void mgmt_discoverable_timeout(struct hci_dev *hdev)
 	clear_bit(HCI_LIMITED_DISCOVERABLE, &hdev->dev_flags);
 	clear_bit(HCI_DISCOVERABLE, &hdev->dev_flags);
 
-	hci_req_init(&req, hdev);
+	hci_req_init(&req, hdev, NULL);
 	if (test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags)) {
 		u8 scan = SCAN_PAGE;
 		hci_req_add(&req, HCI_OP_WRITE_SCAN_ENABLE,
@@ -4944,7 +4950,7 @@ void mgmt_discoverable(struct hci_dev *hdev, u8 discoverable)
 		 * a disabling of connectable there could be a need to
 		 * update the advertising flags.
 		 */
-		hci_req_init(&req, hdev);
+		hci_req_init(&req, hdev, NULL);
 		update_adv_data(&req);
 		hci_req_run(&req, NULL);
 
@@ -5521,7 +5527,7 @@ void mgmt_ssp_enable_complete(struct hci_dev *hdev, u8 enable, u8 status)
 	if (match.sk)
 		sock_put(match.sk);
 
-	hci_req_init(&req, hdev);
+	hci_req_init(&req, hdev, NULL);
 
 	if (test_bit(HCI_SSP_ENABLED, &hdev->dev_flags))
 		update_eir(&req);
@@ -5799,7 +5805,7 @@ int mgmt_device_unblocked(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type)
 			  cmd ? cmd->sk : NULL);
 }
 
-static void adv_enable_complete(struct hci_dev *hdev, u8 status)
+static void adv_enable_complete(struct hci_dev *hdev, u8 status, void *data)
 {
 	BT_DBG("%s status %u", hdev->name, status);
 
@@ -5820,7 +5826,7 @@ void mgmt_reenable_advertising(struct hci_dev *hdev)
 	if (!test_bit(HCI_ADVERTISING, &hdev->dev_flags))
 		return;
 
-	hci_req_init(&req, hdev);
+	hci_req_init(&req, hdev, NULL);
 	enable_advertising(&req);
 
 	/* If this fails we have no option but to let user space know
-- 
1.9.2

