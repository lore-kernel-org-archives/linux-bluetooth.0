Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Fix mgmt_pair_device imediate error responses
Date: Fri, 11 Nov 2011 00:07:35 +0200
Message-Id: <1320962855-19036-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1320962855-19036-1-git-send-email-johan.hedberg@gmail.com>
References: <1320962855-19036-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When possible cmd_complete should be returned instead of cmd_status
since it contains the remote address (this helps user-space track what
exactly failed).

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 555e31f..3d33168 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1366,6 +1366,7 @@ static int pair_device(struct sock *sk, u16 index, unsigned char *data, u16 len)
 {
 	struct hci_dev *hdev;
 	struct mgmt_cp_pair_device *cp;
+	struct mgmt_rp_pair_device rp;
 	struct pending_cmd *cmd;
 	u8 sec_level, auth_type;
 	struct hci_conn *conn;
@@ -1397,14 +1398,22 @@ static int pair_device(struct sock *sk, u16 index, unsigned char *data, u16 len)
 		conn = hci_connect(hdev, LE_LINK, &cp->addr.bdaddr, sec_level,
 								auth_type);
 
+	memset(&rp, 0, sizeof(rp));
+	bacpy(&rp.addr.bdaddr, &cp->addr.bdaddr);
+	rp.addr.type = cp->addr.type;
+
 	if (IS_ERR(conn)) {
-		err = PTR_ERR(conn);
+		rp.status = -PTR_ERR(conn);
+		err = cmd_complete(sk, index, MGMT_OP_PAIR_DEVICE,
+							&rp, sizeof(rp));
 		goto unlock;
 	}
 
 	if (conn->connect_cfm_cb) {
 		hci_conn_put(conn);
-		err = cmd_status(sk, index, MGMT_OP_PAIR_DEVICE, EBUSY);
+		rp.status = EBUSY;
+		err = cmd_complete(sk, index, MGMT_OP_PAIR_DEVICE,
+							&rp, sizeof(rp));
 		goto unlock;
 	}
 
-- 
1.7.7.1

