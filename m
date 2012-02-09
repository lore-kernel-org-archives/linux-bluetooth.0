Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 8/8] Bluetooth: Add Device Unpaired mgmt event
Date: Thu,  9 Feb 2012 17:23:50 +0200
Message-Id: <1328801030-24274-9-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1328801030-24274-1-git-send-email-johan.hedberg@gmail.com>
References: <1328801030-24274-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch add a new Device Unpaired mgmt event. This will be sent to
all mgmt sockets except the one that requested unpairing (that socket
will get a command complete instead). The event is also reserved for
future SMP updates where a remote device will be able to request pairing
revocation from us.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/mgmt.h |    5 +++++
 net/bluetooth/mgmt.c         |   27 +++++++++++++++++++++------
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 17bbf8b..5b5edee 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -412,3 +412,8 @@ struct mgmt_ev_device_blocked {
 struct mgmt_ev_device_unblocked {
 	struct mgmt_addr_info addr;
 } __packed;
+
+#define MGMT_EV_DEVICE_UNPAIRED		0x0016
+struct mgmt_ev_device_unpaired {
+	struct mgmt_addr_info addr;
+} __packed;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 0cf0f4d..a2c2e12 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1073,6 +1073,18 @@ static int load_link_keys(struct sock *sk, u16 index, void *data, u16 len)
 	return 0;
 }
 
+static int device_unpaired(struct hci_dev *hdev, bdaddr_t *bdaddr,
+					u8 addr_type, struct sock *skip_sk)
+{
+	struct mgmt_ev_device_unpaired ev;
+
+	bacpy(&ev.addr.bdaddr, bdaddr);
+	ev.addr.type = addr_type;
+
+	return mgmt_event(MGMT_EV_DEVICE_UNPAIRED, hdev, &ev, sizeof(ev),
+								skip_sk);
+}
+
 static int unpair_device(struct sock *sk, u16 index, void *data, u16 len)
 {
 	struct hci_dev *hdev;
@@ -1111,6 +1123,7 @@ static int unpair_device(struct sock *sk, u16 index, void *data, u16 len)
 	if (!test_bit(HCI_UP, &hdev->flags) || !cp->disconnect) {
 		err = cmd_complete(sk, index, MGMT_OP_UNPAIR_DEVICE, &rp,
 								sizeof(rp));
+		device_unpaired(hdev, &cp->addr.bdaddr, cp->addr.type, sk);
 		goto unlock;
 	}
 
@@ -1124,6 +1137,7 @@ static int unpair_device(struct sock *sk, u16 index, void *data, u16 len)
 	if (!conn) {
 		err = cmd_complete(sk, index, MGMT_OP_UNPAIR_DEVICE, &rp,
 								sizeof(rp));
+		device_unpaired(hdev, &cp->addr.bdaddr, cp->addr.type, sk);
 		goto unlock;
 	}
 
@@ -2629,18 +2643,17 @@ static void disconnect_rsp(struct pending_cmd *cmd, void *data)
 
 static void unpair_device_rsp(struct pending_cmd *cmd, void *data)
 {
-	u8 *status = data;
+	struct hci_dev *hdev = data;
 	struct mgmt_cp_unpair_device *cp = cmd->param;
 	struct mgmt_rp_unpair_device rp;
 
 	memset(&rp, 0, sizeof(rp));
 	bacpy(&rp.addr.bdaddr, &cp->addr.bdaddr);
 	rp.addr.type = cp->addr.type;
-	if (status != NULL)
-		rp.status = *status;
 
-	cmd_complete(cmd->sk, cmd->index, MGMT_OP_UNPAIR_DEVICE, &rp,
-								sizeof(rp));
+	device_unpaired(hdev, &cp->addr.bdaddr, cp->addr.type, cmd->sk);
+
+	cmd_complete(cmd->sk, cmd->index, cmd->opcode, &rp, sizeof(rp));
 
 	mgmt_pending_remove(cmd);
 }
@@ -2664,7 +2677,7 @@ int mgmt_device_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr,
 		sock_put(sk);
 
 	mgmt_pending_foreach(MGMT_OP_UNPAIR_DEVICE, hdev, unpair_device_rsp,
-									NULL);
+									hdev);
 
 	return err;
 }
@@ -2689,6 +2702,8 @@ int mgmt_disconnect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr,
 
 	mgmt_pending_remove(cmd);
 
+	mgmt_pending_foreach(MGMT_OP_UNPAIR_DEVICE, hdev, unpair_device_rsp,
+									hdev);
 	return err;
 }
 
-- 
1.7.9

