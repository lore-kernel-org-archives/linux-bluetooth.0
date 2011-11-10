Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Add address type to mgmt_pair_device
Date: Fri, 11 Nov 2011 00:07:34 +0200
Message-Id: <1320962855-19036-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The kernel needs to know whether it should connect to a device over
BR/EDR or over LE. This is particularly important in the future when
dual-mode device may be connectable also over LE. It is also important
if/when we decide to move the LE advertisement cache from the kernel
into user-space. Adding the type to the mgmt command also ensures
conformance with the latest mgmt API spec.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/mgmt.h |    4 ++--
 net/bluetooth/mgmt.c         |   13 ++++++-------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 8b07a83..bfdb04b 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -172,11 +172,11 @@ struct mgmt_cp_set_io_capability {
 
 #define MGMT_OP_PAIR_DEVICE		0x0014
 struct mgmt_cp_pair_device {
-	bdaddr_t bdaddr;
+	struct mgmt_addr_info addr;
 	__u8 io_cap;
 } __packed;
 struct mgmt_rp_pair_device {
-	bdaddr_t bdaddr;
+	struct mgmt_addr_info addr;
 	__u8 status;
 } __packed;
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 5562c21..555e31f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1333,7 +1333,8 @@ static void pairing_complete(struct pending_cmd *cmd, u8 status)
 	struct mgmt_rp_pair_device rp;
 	struct hci_conn *conn = cmd->user_data;
 
-	bacpy(&rp.bdaddr, &conn->dst);
+	bacpy(&rp.addr.bdaddr, &conn->dst);
+	rp.addr.type = link_to_mgmt(conn->type, conn->dst_type);
 	rp.status = status;
 
 	cmd_complete(cmd->sk, cmd->index, MGMT_OP_PAIR_DEVICE, &rp, sizeof(rp));
@@ -1366,7 +1367,6 @@ static int pair_device(struct sock *sk, u16 index, unsigned char *data, u16 len)
 	struct hci_dev *hdev;
 	struct mgmt_cp_pair_device *cp;
 	struct pending_cmd *cmd;
-	struct adv_entry *entry;
 	u8 sec_level, auth_type;
 	struct hci_conn *conn;
 	int err;
@@ -1390,12 +1390,11 @@ static int pair_device(struct sock *sk, u16 index, unsigned char *data, u16 len)
 	else
 		auth_type = HCI_AT_DEDICATED_BONDING_MITM;
 
-	entry = hci_find_adv_entry(hdev, &cp->bdaddr);
-	if (entry)
-		conn = hci_connect(hdev, LE_LINK, &cp->bdaddr, sec_level,
+	if (cp->addr.type == MGMT_ADDR_BREDR)
+		conn = hci_connect(hdev, ACL_LINK, &cp->addr.bdaddr, sec_level,
 								auth_type);
 	else
-		conn = hci_connect(hdev, ACL_LINK, &cp->bdaddr, sec_level,
+		conn = hci_connect(hdev, LE_LINK, &cp->addr.bdaddr, sec_level,
 								auth_type);
 
 	if (IS_ERR(conn)) {
@@ -1417,7 +1416,7 @@ static int pair_device(struct sock *sk, u16 index, unsigned char *data, u16 len)
 	}
 
 	/* For LE, just connecting isn't a proof that the pairing finished */
-	if (!entry)
+	if (cp->addr.type == MGMT_ADDR_BREDR)
 		conn->connect_cfm_cb = pairing_complete_cb;
 
 	conn->security_cfm_cb = pairing_complete_cb;
-- 
1.7.7.1

