Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 6/6] Bluetooth: Add support for Start Service Discovery command
Date: Thu,  4 Dec 2014 10:14:01 +0100
Message-Id: <1417684441-103825-6-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jakub Pawlowski <jpawlowski@google.com>

This patch adds support for the Start Service Discovery command. It
does all the check for command parameters and configured the discovery
filter settings correctly. However the actual support for filtering
will be added with another patch.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 110 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 108 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index c0e718b1c357..9f844096c414 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -93,6 +93,7 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_READ_CONFIG_INFO,
 	MGMT_OP_SET_EXTERNAL_CONFIG,
 	MGMT_OP_SET_PUBLIC_ADDRESS,
+	MGMT_OP_START_SERVICE_DISCOVERY,
 };
 
 static const u16 mgmt_events[] = {
@@ -3792,8 +3793,11 @@ static int mgmt_start_discovery_failed(struct hci_dev *hdev, u8 status)
 	hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
 
 	cmd = mgmt_pending_find(MGMT_OP_START_DISCOVERY, hdev);
-	if (!cmd)
-		return -ENOENT;
+	if (!cmd) {
+		cmd = mgmt_pending_find(MGMT_OP_START_SERVICE_DISCOVERY, hdev);
+		if (!cmd)
+			return -ENOENT;
+	}
 
 	type = hdev->discovery.type;
 
@@ -3903,6 +3907,107 @@ failed:
 	return err;
 }
 
+static int start_service_discovery(struct sock *sk, struct hci_dev *hdev,
+				   void *data, u16 len)
+{
+	struct mgmt_cp_start_service_discovery *cp = data;
+	struct pending_cmd *cmd;
+	struct hci_request req;
+	const u16 max_uuid_count = ((U16_MAX - sizeof(*cp)) / 16);
+	u16 uuid_count, expected_len;
+	u8 status;
+	int err;
+
+	BT_DBG("%s", hdev->name);
+
+	hci_dev_lock(hdev);
+
+	if (!hdev_is_powered(hdev)) {
+		err = cmd_complete(sk, hdev->id,
+				   MGMT_OP_START_SERVICE_DISCOVERY,
+				   MGMT_STATUS_NOT_POWERED,
+				   &cp->type, sizeof(cp->type));
+		goto failed;
+	}
+
+	if (hdev->discovery.state != DISCOVERY_STOPPED ||
+	    test_bit(HCI_PERIODIC_INQ, &hdev->dev_flags)) {
+		err = cmd_complete(sk, hdev->id,
+				   MGMT_OP_START_SERVICE_DISCOVERY,
+				   MGMT_STATUS_BUSY, &cp->type,
+				   sizeof(cp->type));
+		goto failed;
+	}
+
+	uuid_count = __le16_to_cpu(cp->uuid_count);
+	if (uuid_count > max_uuid_count) {
+		BT_ERR("service_discovery: too big uuid_count value %u",
+		       uuid_count);
+		err = cmd_complete(sk, hdev->id,
+				   MGMT_OP_START_SERVICE_DISCOVERY,
+				   MGMT_STATUS_INVALID_PARAMS, &cp->type,
+				   sizeof(cp->type));
+		goto failed;
+	}
+
+	expected_len = sizeof(*cp) + uuid_count * 16;
+	if (expected_len != len) {
+		BT_ERR("service_discovery: expected %u bytes, got %u bytes",
+		       expected_len, len);
+		err = cmd_complete(sk, hdev->id,
+				   MGMT_OP_START_SERVICE_DISCOVERY,
+				   MGMT_STATUS_INVALID_PARAMS, &cp->type,
+				   sizeof(cp->type));
+		goto failed;
+	}
+
+	cmd = mgmt_pending_add(sk, MGMT_OP_START_SERVICE_DISCOVERY,
+			       hdev, NULL, 0);
+	if (!cmd) {
+		err = -ENOMEM;
+		goto failed;
+	}
+
+	hdev->discovery.type = cp->type;
+	hdev->discovery.rssi = cp->rssi;
+	hdev->discovery.uuid_count = uuid_count;
+
+	if (uuid_count > 0) {
+		hdev->discovery.uuids = kmemdup(cp->uuids, uuid_count * 16,
+						GFP_KERNEL);
+		if (!hdev->discovery.uuids) {
+			err = cmd_complete(sk, hdev->id,
+					   MGMT_OP_START_SERVICE_DISCOVERY,
+					   MGMT_STATUS_FAILED,
+					   &cp->type, sizeof(cp->type));
+			mgmt_pending_remove(cmd);
+			goto failed;
+		}
+	}
+
+	hci_req_init(&req, hdev);
+
+	if (!trigger_discovery(&req, &status)) {
+		err = cmd_complete(sk, hdev->id,
+				   MGMT_OP_START_SERVICE_DISCOVERY,
+				   status, &cp->type, sizeof(cp->type));
+		mgmt_pending_remove(cmd);
+		goto failed;
+	}
+
+	err = hci_req_run(&req, start_discovery_complete);
+	if (err < 0) {
+		mgmt_pending_remove(cmd);
+		goto failed;
+	}
+
+	hci_discovery_set_state(hdev, DISCOVERY_STARTING);
+
+failed:
+	hci_dev_unlock(hdev);
+	return err;
+}
+
 static int mgmt_stop_discovery_failed(struct hci_dev *hdev, u8 status)
 {
 	struct pending_cmd *cmd;
@@ -5747,6 +5852,7 @@ static const struct mgmt_handler {
 	{ read_config_info,       false, MGMT_READ_CONFIG_INFO_SIZE },
 	{ set_external_config,    false, MGMT_SET_EXTERNAL_CONFIG_SIZE },
 	{ set_public_address,     false, MGMT_SET_PUBLIC_ADDRESS_SIZE },
+	{ start_service_discovery,true,  MGMT_START_SERVICE_DISCOVERY_SIZE },
 };
 
 int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
-- 
1.9.3

