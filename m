Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Add support for changing the public device address
Date: Sun,  6 Jul 2014 12:11:15 +0200
Message-Id: <1404641476-24971-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds support for changing the public device address. This feature
is required by controllers that do not provide a public address and
have HCI_QUIRK_INVALID_BDADDR set.

Even if a controller has a public device address, this is useful when
an embedded system wants to use its own value. As long as the driver
provides the set_bdaddr callback, this allows changing the device
address before powering on the controller.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/mgmt.h |  6 +++++
 net/bluetooth/hci_core.c     | 14 ++++++-----
 net/bluetooth/mgmt.c         | 57 +++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 70 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 80606d2fe086..623d5203c592 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -489,6 +489,12 @@ struct mgmt_cp_set_external_config {
 } __packed;
 #define MGMT_SET_EXTERNAL_CONFIG_SIZE	1
 
+#define MGMT_OP_SET_PUBLIC_ADDRESS	0x0039
+struct mgmt_cp_set_public_address {
+	bdaddr_t bdaddr;
+} __packed;
+#define MGMT_SET_PUBLIC_ADDRESS_SIZE	6
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 538716587a29..eae00836b739 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2302,12 +2302,14 @@ static int hci_dev_do_open(struct hci_dev *hdev)
 			ret = __hci_unconf_init(hdev);
 	}
 
-	/* If public address change is configured, ensure that the
-	 * address gets programmed. If the driver does not support
-	 * changing the public address, fail the power on procedure.
-	 */
-	if (!ret && bacmp(&hdev->public_addr, BDADDR_ANY)) {
-		if (hdev->set_bdaddr)
+	if (test_bit(HCI_CONFIG, &hdev->dev_flags)) {
+		/* If public address change is configured, ensure that
+		 * the address gets programmed. If the driver does not
+		 * support changing the public address, fail the power
+		 * on procedure.
+		 */
+		if (bacmp(&hdev->public_addr, BDADDR_ANY) &&
+		    hdev->set_bdaddr)
 			ret = hdev->set_bdaddr(hdev, &hdev->public_addr);
 		else
 			ret = -EADDRNOTAVAIL;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 9721f428640e..9ef6f90021ad 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -92,6 +92,7 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_READ_UNCONF_INDEX_LIST,
 	MGMT_OP_READ_CONFIG_INFO,
 	MGMT_OP_SET_EXTERNAL_CONFIG,
+	MGMT_OP_SET_PUBLIC_ADDRESS,
 };
 
 static const u16 mgmt_events[] = {
@@ -5446,6 +5447,58 @@ unlock:
 	return err;
 }
 
+static int set_public_address(struct sock *sk, struct hci_dev *hdev,
+			      void *data, u16 len)
+{
+	struct mgmt_cp_set_public_address *cp = data;
+	bool changed;
+	int err;
+
+	BT_DBG("%s", hdev->name);
+
+	if (hdev_is_powered(hdev))
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_PUBLIC_ADDRESS,
+				  MGMT_STATUS_REJECTED);
+
+	if (!bacmp(&cp->bdaddr, BDADDR_ANY))
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_PUBLIC_ADDRESS,
+				    MGMT_STATUS_INVALID_PARAMS);
+
+	if (!hdev->set_bdaddr)
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_PUBLIC_ADDRESS,
+				  MGMT_STATUS_NOT_SUPPORTED);
+
+	hci_dev_lock(hdev);
+
+	changed = !!bacmp(&hdev->public_addr, &cp->bdaddr);
+	bacpy(&hdev->public_addr, &cp->bdaddr);
+
+	err = send_options_rsp(sk, MGMT_OP_SET_PUBLIC_ADDRESS, hdev);
+	if (err < 0)
+		goto unlock;
+
+	if (!changed)
+		goto unlock;
+
+	if (test_bit(HCI_UNCONFIGURED, &hdev->dev_flags))
+		err = new_options(hdev, sk);
+
+	if (is_configured(hdev)) {
+		mgmt_index_removed(hdev);
+
+		clear_bit(HCI_UNCONFIGURED, &hdev->dev_flags);
+
+		set_bit(HCI_CONFIG, &hdev->dev_flags);
+		set_bit(HCI_AUTO_OFF, &hdev->dev_flags);
+
+		queue_work(hdev->req_workqueue, &hdev->power_on);
+	}
+
+unlock:
+	hci_dev_unlock(hdev);
+	return err;
+}
+
 static const struct mgmt_handler {
 	int (*func) (struct sock *sk, struct hci_dev *hdev, void *data,
 		     u16 data_len);
@@ -5509,6 +5562,7 @@ static const struct mgmt_handler {
 	{ read_unconf_index_list, false, MGMT_READ_UNCONF_INDEX_LIST_SIZE },
 	{ read_config_info,       false, MGMT_READ_CONFIG_INFO_SIZE },
 	{ set_external_config,    false, MGMT_SET_EXTERNAL_CONFIG_SIZE },
+	{ set_public_address,     false, MGMT_SET_PUBLIC_ADDRESS_SIZE },
 };
 
 int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
@@ -5563,7 +5617,8 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 
 		if (test_bit(HCI_UNCONFIGURED, &hdev->dev_flags) &&
 		    opcode != MGMT_OP_READ_CONFIG_INFO &&
-		    opcode != MGMT_OP_SET_EXTERNAL_CONFIG) {
+		    opcode != MGMT_OP_SET_EXTERNAL_CONFIG &&
+		    opcode != MGMT_OP_SET_PUBLIC_ADDRESS) {
 			err = cmd_status(sk, index, opcode,
 					 MGMT_STATUS_INVALID_INDEX);
 			goto done;
-- 
1.9.3

