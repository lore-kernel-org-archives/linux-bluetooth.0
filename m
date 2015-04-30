Return-Path: <cyrus@holtmann.org>
From: Florian Grandel <fgrandel@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 14/17] Bluetooth: mgmt: multi adv for add_advertising()
Date: Thu, 30 Apr 2015 17:33:17 +0200
Message-Id: <1430408000-17785-15-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1430408000-17785-1-git-send-email-fgrandel@gmail.com>
References: <1430408000-17785-1-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1428633041-18415-1-git-send-email-fgrandel@gmail.com>
References: <1428633041-18415-1-git-send-email-fgrandel@gmail.com>
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
 net/bluetooth/mgmt.c | 72 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 41 insertions(+), 31 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 92560ae..52f3e62 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6897,7 +6897,9 @@ static void add_advertising_complete(struct hci_dev *hdev, u8 status,
 				     u16 opcode)
 {
 	struct mgmt_pending_cmd *cmd;
+	struct mgmt_cp_add_advertising *cp;
 	struct mgmt_rp_add_advertising rp;
+	struct adv_info *adv_instance, *n;
 
 	BT_DBG("status %d", status);
 
@@ -6906,15 +6908,27 @@ static void add_advertising_complete(struct hci_dev *hdev, u8 status,
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
@@ -6950,6 +6964,7 @@ static int add_advertising(struct sock *sk, struct hci_dev *hdev,
 	u32 supported_flags;
 	u8 status;
 	u16 timeout;
+	unsigned int prev_instance_cnt = hdev->adv_instance_cnt;
 	int err;
 	struct mgmt_pending_cmd *cmd;
 	struct hci_request req;
@@ -6964,11 +6979,11 @@ static int add_advertising(struct sock *sk, struct hci_dev *hdev,
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
 
@@ -6996,38 +7011,33 @@ static int add_advertising(struct sock *sk, struct hci_dev *hdev,
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

