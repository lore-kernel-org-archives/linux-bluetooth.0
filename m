Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 15/15] Bluetooth: Add support for remote OOB input of P-256 data
Date: Fri, 10 Jan 2014 02:07:30 -0800
Message-Id: <1389348450-23303-15-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The current management interface only allows to provide the remote
OOB input of P-192 data. This extends the command to also accept
P-256 data as well. To make this backwards compatible, the userspace
can decide to only provide P-192 data or the combined P-192 and P-256
data. It is also allowed to leave the P-192 data empty if userspace
only has the remote P-256 data.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/mgmt.h |  8 ++++++++
 net/bluetooth/mgmt.c         | 45 +++++++++++++++++++++++++++++++++-----------
 2 files changed, 42 insertions(+), 11 deletions(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 036ddc7dc7ed..e19049fb6c46 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -309,6 +309,14 @@ struct mgmt_cp_add_remote_oob_data {
 	__u8	randomizer[16];
 } __packed;
 #define MGMT_ADD_REMOTE_OOB_DATA_SIZE	(MGMT_ADDR_INFO_SIZE + 32)
+struct mgmt_cp_add_remote_oob_ext_data {
+	struct mgmt_addr_info addr;
+	__u8	hash192[16];
+	__u8	randomizer192[16];
+	__u8	hash256[16];
+	__u8	randomizer256[16];
+} __packed;
+#define MGMT_ADD_REMOTE_OOB_EXT_DATA_SIZE (MGMT_ADDR_INFO_SIZE + 64)
 
 #define MGMT_OP_REMOVE_REMOTE_OOB_DATA	0x0022
 struct mgmt_cp_remove_remote_oob_data {
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index bbe30c983492..4b6034fcc902 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3096,23 +3096,46 @@ unlock:
 static int add_remote_oob_data(struct sock *sk, struct hci_dev *hdev,
 			       void *data, u16 len)
 {
-	struct mgmt_cp_add_remote_oob_data *cp = data;
-	u8 status;
 	int err;
 
 	BT_DBG("%s ", hdev->name);
 
 	hci_dev_lock(hdev);
 
-	err = hci_add_remote_oob_data(hdev, &cp->addr.bdaddr, cp->hash,
-				      cp->randomizer);
-	if (err < 0)
-		status = MGMT_STATUS_FAILED;
-	else
-		status = MGMT_STATUS_SUCCESS;
+	if (len == MGMT_ADD_REMOTE_OOB_DATA_SIZE) {
+		struct mgmt_cp_add_remote_oob_data *cp = data;
+		u8 status;
 
-	err = cmd_complete(sk, hdev->id, MGMT_OP_ADD_REMOTE_OOB_DATA, status,
-			   &cp->addr, sizeof(cp->addr));
+		err = hci_add_remote_oob_data(hdev, &cp->addr.bdaddr,
+					      cp->hash, cp->randomizer);
+		if (err < 0)
+			status = MGMT_STATUS_FAILED;
+		else
+			status = MGMT_STATUS_SUCCESS;
+
+		err = cmd_complete(sk, hdev->id, MGMT_OP_ADD_REMOTE_OOB_DATA,
+				   status, &cp->addr, sizeof(cp->addr));
+	} else if (len == MGMT_ADD_REMOTE_OOB_EXT_DATA_SIZE) {
+		struct mgmt_cp_add_remote_oob_ext_data *cp = data;
+		u8 status;
+
+		err = hci_add_remote_oob_ext_data(hdev, &cp->addr.bdaddr,
+						  cp->hash192,
+						  cp->randomizer192,
+						  cp->hash256,
+						  cp->randomizer256);
+		if (err < 0)
+			status = MGMT_STATUS_FAILED;
+		else
+			status = MGMT_STATUS_SUCCESS;
+
+		err = cmd_complete(sk, hdev->id, MGMT_OP_ADD_REMOTE_OOB_DATA,
+				   status, &cp->addr, sizeof(cp->addr));
+	} else {
+		BT_ERR("add_remote_oob_data: invalid length of %u bytes", len);
+		err = cmd_status(sk, hdev->id, MGMT_OP_ADD_REMOTE_OOB_DATA,
+				 MGMT_STATUS_INVALID_PARAMS);
+	}
 
 	hci_dev_unlock(hdev);
 	return err;
@@ -4202,7 +4225,7 @@ static const struct mgmt_handler {
 	{ user_passkey_reply,     false, MGMT_USER_PASSKEY_REPLY_SIZE },
 	{ user_passkey_neg_reply, false, MGMT_USER_PASSKEY_NEG_REPLY_SIZE },
 	{ read_local_oob_data,    false, MGMT_READ_LOCAL_OOB_DATA_SIZE },
-	{ add_remote_oob_data,    false, MGMT_ADD_REMOTE_OOB_DATA_SIZE },
+	{ add_remote_oob_data,    true,  MGMT_ADD_REMOTE_OOB_DATA_SIZE },
 	{ remove_remote_oob_data, false, MGMT_REMOVE_REMOTE_OOB_DATA_SIZE },
 	{ start_discovery,        false, MGMT_START_DISCOVERY_SIZE },
 	{ stop_discovery,         false, MGMT_STOP_DISCOVERY_SIZE },
-- 
1.8.4.2

