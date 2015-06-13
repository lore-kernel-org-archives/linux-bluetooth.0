Return-Path: <cyrus@holtmann.org>
From: Florian Grandel <fgrandel@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v7 14/20] Bluetooth: mgmt/hci_core: multi-adv for add_advertising*()
Date: Sat, 13 Jun 2015 05:41:07 +0200
Message-Id: <1434166873-21595-15-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1434166873-21595-1-git-send-email-fgrandel@gmail.com>
References: <1434166873-21595-1-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1432600463-7758-1-git-send-email-fgrandel@gmail.com>
References: <1432600463-7758-1-git-send-email-fgrandel@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The add_advertising() and add_advertising_complete() functions reference
the now obsolete hdev->adv_instance struct. Both methods are being
refactored to access the dynamic advertising instance list instead.

This patch also introduces all logic necessary to actually deal with
multiple instance advertising. Notably the mgmt_adv_inst_expired() and
schedule_adv_inst() method are being referenced to schedule instances in
a round robin fashion.

This patch also introduces a "pending" flag into the adv_info struct.
This is necessary to identify and remove recently added advertising
instances when the HCI commands return with an error status code.
Otherwise new advertising instances could be leaked without properly
informing userspace about their existence.

Signed-off-by: Florian Grandel <fgrandel@gmail.com>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         |  1 +
 net/bluetooth/mgmt.c             | 96 +++++++++++++++++++++++++---------------
 3 files changed, 62 insertions(+), 36 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b53e1b1..4f58a0e 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -157,6 +157,7 @@ struct oob_data {
 
 struct adv_info {
 	struct list_head list;
+	bool pending;
 	__u8	instance;
 	__u32	flags;
 	__u16	timeout;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index d1110db..e50f7c3 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2721,6 +2721,7 @@ int hci_add_adv_instance(struct hci_dev *hdev, u8 instance, u32 flags,
 			return -ENOMEM;
 
 		memset(adv_instance, 0, sizeof(*adv_instance));
+		adv_instance->pending = true;
 		adv_instance->instance = instance;
 		list_add(&adv_instance->list, &hdev->adv_instances);
 		hdev->adv_instance_cnt++;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index cbcc8d9..686d933 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -7016,7 +7016,10 @@ static void add_advertising_complete(struct hci_dev *hdev, u8 status,
 				     u16 opcode)
 {
 	struct mgmt_pending_cmd *cmd;
+	struct mgmt_cp_add_advertising *cp;
 	struct mgmt_rp_add_advertising rp;
+	struct adv_info *adv_instance, *n;
+	u8 instance;
 
 	BT_DBG("status %d", status);
 
@@ -7024,16 +7027,32 @@ static void add_advertising_complete(struct hci_dev *hdev, u8 status,
 
 	cmd = pending_find(MGMT_OP_ADD_ADVERTISING, hdev);
 
-	if (status) {
+	if (status)
 		hci_dev_clear_flag(hdev, HCI_ADVERTISING_INSTANCE);
-		memset(&hdev->adv_instance, 0, sizeof(hdev->adv_instance));
-		advertising_removed(cmd ? cmd->sk : NULL, hdev, 1);
+
+	list_for_each_entry_safe(adv_instance, n, &hdev->adv_instances, list) {
+		if (!adv_instance->pending)
+			continue;
+
+		if (!status) {
+			adv_instance->pending = false;
+			continue;
+		}
+
+		instance = adv_instance->instance;
+
+		if (hdev->cur_adv_instance == instance)
+			cancel_adv_timeout(hdev);
+
+		hci_remove_adv_instance(hdev, instance);
+		advertising_removed(cmd ? cmd->sk : NULL, hdev, instance);
 	}
 
 	if (!cmd)
 		goto unlock;
 
-	rp.instance = 0x01;
+	cp = cmd->param;
+	rp.instance = cp->instance;
 
 	if (status)
 		mgmt_cmd_status(cmd->sk, cmd->index, cmd->opcode,
@@ -7081,7 +7100,8 @@ static int add_advertising(struct sock *sk, struct hci_dev *hdev,
 	u32 flags;
 	u32 supported_flags;
 	u8 status;
-	u16 timeout;
+	u16 timeout, duration;
+	unsigned int prev_instance_cnt = hdev->adv_instance_cnt;
 	int err;
 	struct mgmt_pending_cmd *cmd;
 	struct hci_request req;
@@ -7095,12 +7115,13 @@ static int add_advertising(struct sock *sk, struct hci_dev *hdev,
 
 	flags = __le32_to_cpu(cp->flags);
 	timeout = __le16_to_cpu(cp->timeout);
+	duration = __le16_to_cpu(cp->duration);
 
-	/* The current implementation only supports adding one instance and only
-	 * a subset of the specified flags.
+	/* The current implementation only supports a subset of the specified
+	 * flags.
 	 */
 	supported_flags = get_supported_adv_flags(hdev);
-	if (cp->instance != 0x01 || (flags & ~supported_flags))
+	if (flags & ~supported_flags)
 		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_ADD_ADVERTISING,
 				       MGMT_STATUS_INVALID_PARAMS);
 
@@ -7128,36 +7149,39 @@ static int add_advertising(struct sock *sk, struct hci_dev *hdev,
 		goto unlock;
 	}
 
-	hdev->adv_instance.flags = flags;
-	hdev->adv_instance.adv_data_len = cp->adv_data_len;
-	hdev->adv_instance.scan_rsp_len = cp->scan_rsp_len;
-
-	if (cp->adv_data_len)
-		memcpy(hdev->adv_instance.adv_data, cp->data, cp->adv_data_len);
-
-	if (cp->scan_rsp_len)
-		memcpy(hdev->adv_instance.scan_rsp_data,
-		       cp->data + cp->adv_data_len, cp->scan_rsp_len);
-
-	if (hdev->adv_instance_timeout)
-		cancel_delayed_work(&hdev->adv_instance_expire);
+	err = hci_add_adv_instance(hdev, cp->instance, flags,
+				   cp->adv_data_len, cp->data,
+				   cp->scan_rsp_len,
+				   cp->data + cp->adv_data_len,
+				   timeout, duration);
+	if (err < 0) {
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_ADD_ADVERTISING,
+				      MGMT_STATUS_FAILED);
+		goto unlock;
+	}
 
-	hdev->adv_instance_timeout = timeout;
+	/* Only trigger an advertising added event if a new instance was
+	 * actually added.
+	 */
+	if (hdev->adv_instance_cnt > prev_instance_cnt)
+		advertising_added(sk, hdev, cp->instance);
 
-	if (timeout)
-		queue_delayed_work(hdev->workqueue,
-				   &hdev->adv_instance_expire,
-				   msecs_to_jiffies(timeout * 1000));
+	hci_dev_set_flag(hdev, HCI_ADVERTISING_INSTANCE);
 
-	if (!hci_dev_test_and_set_flag(hdev, HCI_ADVERTISING_INSTANCE))
-		advertising_added(sk, hdev, 1);
+	/* If the currently advertised instance is being changed then
+	 * cancel the current advertising and override it.
+	 */
+	if (hdev->cur_adv_instance == cp->instance)
+		cancel_adv_timeout(hdev);
 
-	/* If the HCI_ADVERTISING flag is set or the device isn't powered then
-	 * we have no HCI communication to make. Simply return.
+	/* If the HCI_ADVERTISING flag is set or the device isn't powered or
+	 * another instance is already being advertised then we have no HCI
+	 * communication to make. Simply return.
 	 */
 	if (!hdev_is_powered(hdev) ||
-	    hci_dev_test_flag(hdev, HCI_ADVERTISING)) {
-		rp.instance = 0x01;
+	    hci_dev_test_flag(hdev, HCI_ADVERTISING) ||
+	    hdev->adv_instance_timeout) {
+		rp.instance = cp->instance;
 		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_ADD_ADVERTISING,
 					MGMT_STATUS_SUCCESS, &rp, sizeof(rp));
 		goto unlock;
@@ -7175,11 +7199,11 @@ static int add_advertising(struct sock *sk, struct hci_dev *hdev,
 
 	hci_req_init(&req, hdev);
 
-	update_adv_data(&req);
-	update_scan_rsp_data(&req);
-	enable_advertising(&req);
+	err = schedule_adv_instance(&req, cp->instance, true);
+
+	if (!err)
+		err = hci_req_run(&req, add_advertising_complete);
 
-	err = hci_req_run(&req, add_advertising_complete);
 	if (err < 0)
 		mgmt_pending_remove(cmd);
 
-- 
1.9.1

