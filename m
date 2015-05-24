Return-Path: <cyrus@holtmann.org>
From: Florian Grandel <fgrandel@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 13/16] Bluetooth: mgmt: multi adv for add_advertising()
Date: Mon, 25 May 2015 00:39:11 +0200
Message-Id: <1432507154-22925-14-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1432507154-22925-1-git-send-email-fgrandel@gmail.com>
References: <1432507154-22925-1-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1430408000-17785-1-git-send-email-fgrandel@gmail.com>
References: <1430408000-17785-1-git-send-email-fgrandel@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The add_advertising() function had a hard coded instance identifier.
This is being fixed by adding an arbitrary advertising instance to the
dynamic advertising instance list and updating the current instance
identifier accordingly.

The code is made more readable by factoring advertising instance
management and initialization into a low-level hci_add_adv_instance()
function.

We also make sure that event notifications are correctly dealt with in
the case of multiple advertising instances.

This change still relies on the fact that we only allow for a single
advertising instance as it does not yet provide a means to advertise
several instances in a round-robin fashion. This must be added as soon
as more than one instance will be allowed. A corresponding TODO has been
inserted into the code.

Signed-off-by: Florian Grandel <fgrandel@gmail.com>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         |  1 +
 net/bluetooth/mgmt.c             | 72 +++++++++++++++++++++++-----------------
 3 files changed, 43 insertions(+), 31 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index d92d324..36cc941 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -158,6 +158,7 @@ struct oob_data {
 struct adv_info {
 	struct list_head list;
 	struct hci_dev *hdev;
+	bool pending;
 	struct delayed_work timeout_exp;
 	__u8	instance;
 	__u32	flags;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 1ec557f..01fc98e 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2687,6 +2687,7 @@ int hci_add_adv_instance(struct hci_dev *hdev, u8 instance, u32 flags,
 
 		memset(adv_instance, 0, sizeof(*adv_instance));
 		adv_instance->hdev = hdev;
+		adv_instance->pending = true;
 		INIT_DELAYED_WORK(&adv_instance->timeout_exp, timeout_work);
 		adv_instance->instance = instance;
 		list_add(&adv_instance->list, &hdev->adv_instances);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 1bdf005..6eba4d8 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6902,7 +6902,9 @@ static void add_advertising_complete(struct hci_dev *hdev, u8 status,
 				     u16 opcode)
 {
 	struct mgmt_pending_cmd *cmd;
+	struct mgmt_cp_add_advertising *cp;
 	struct mgmt_rp_add_advertising rp;
+	struct adv_info *adv_instance, *n;
 
 	BT_DBG("status %d", status);
 
@@ -6911,15 +6913,27 @@ static void add_advertising_complete(struct hci_dev *hdev, u8 status,
 	cmd = pending_find(MGMT_OP_ADD_ADVERTISING, hdev);
 
 	if (status) {
+		/* TODO: Start advertising another adv instance if any. */
 		hci_dev_clear_flag(hdev, HCI_ADVERTISING_INSTANCE);
-		memset(&hdev->adv_instance, 0, sizeof(hdev->adv_instance));
-		advertising_removed(cmd ? cmd->sk : NULL, hdev, 1);
+	}
+
+	list_for_each_entry_safe(adv_instance, n, &hdev->adv_instances, list) {
+		if (!adv_instance->pending)
+			continue;
+
+		if (status) {
+			hci_remove_adv_instance(hdev, adv_instance->instance);
+			advertising_removed(cmd ? cmd->sk : NULL, hdev, adv_instance->instance);
+		} else {
+			adv_instance->pending = false;
+		}
 	}
 
 	if (!cmd)
 		goto unlock;
 
-	rp.instance = 0x01;
+	cp = cmd->param;
+	rp.instance = cp->instance;
 
 	if (status)
 		mgmt_cmd_status(cmd->sk, cmd->index, cmd->opcode,
@@ -6955,6 +6969,7 @@ static int add_advertising(struct sock *sk, struct hci_dev *hdev,
 	u32 supported_flags;
 	u8 status;
 	u16 timeout;
+	unsigned int prev_instance_cnt = hdev->adv_instance_cnt;
 	int err;
 	struct mgmt_pending_cmd *cmd;
 	struct hci_request req;
@@ -6969,11 +6984,11 @@ static int add_advertising(struct sock *sk, struct hci_dev *hdev,
 	flags = __le32_to_cpu(cp->flags);
 	timeout = __le16_to_cpu(cp->timeout);
 
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
 
@@ -7001,38 +7016,33 @@ static int add_advertising(struct sock *sk, struct hci_dev *hdev,
 		goto unlock;
 	}
 
-	INIT_DELAYED_WORK(&hdev->adv_instance.timeout_exp, adv_timeout_expired);
-
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
-	if (hdev->adv_instance.timeout)
-		cancel_delayed_work(&hdev->adv_instance.timeout_exp);
+	err = hci_add_adv_instance(hdev, cp->instance, flags,
+				   cp->adv_data_len, cp->data,
+				   cp->scan_rsp_len,
+				   cp->data + cp->adv_data_len,
+				   adv_timeout_expired, timeout);
+	if (err < 0) {
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_ADD_ADVERTISING,
+				      MGMT_STATUS_FAILED);
+		goto unlock;
+	}
 
-	hdev->adv_instance.timeout = timeout;
+	hdev->cur_adv_instance = cp->instance;
 
-	if (timeout)
-		queue_delayed_work(hdev->workqueue,
-				   &hdev->adv_instance.timeout_exp,
-				   msecs_to_jiffies(timeout * 1000));
+	hci_dev_set_flag(hdev, HCI_ADVERTISING_INSTANCE);
 
-	if (!hci_dev_test_and_set_flag(hdev, HCI_ADVERTISING_INSTANCE))
-		advertising_added(sk, hdev, 1);
+	/* Only trigger an advertising added event if a new instance was
+	 * actually added.
+	 */
+	if (hdev->adv_instance_cnt > prev_instance_cnt)
+		advertising_added(sk, hdev, cp->instance);
 
-	/* If the HCI_ADVERTISING flag is set or the device isn't powered then
+	/* If we are already advertising or the device isn't powered then
 	 * we have no HCI communication to make. Simply return.
 	 */
 	if (!hdev_is_powered(hdev) ||
-	    hci_dev_test_flag(hdev, HCI_ADVERTISING)) {
-		rp.instance = 0x01;
+	    hci_dev_test_flag(hdev, HCI_LE_ADV)) {
+		rp.instance = cp->instance;
 		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_ADD_ADVERTISING,
 					MGMT_STATUS_SUCCESS, &rp, sizeof(rp));
 		goto unlock;
-- 
1.9.1

