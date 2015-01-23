Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Check for valid bdaddr in add_remote_oob_data
Date: Fri, 23 Jan 2015 10:10:38 +0200
Message-Id: <1422000639-4918-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Before doing any other verifications, the add_remote_oob_data function
should first check that the given address is valid. This patch adds such
a missing check to the beginning of the function.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 41e30055bae8..2c0de3e4e79a 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3633,10 +3633,16 @@ unlock:
 static int add_remote_oob_data(struct sock *sk, struct hci_dev *hdev,
 			       void *data, u16 len)
 {
+	struct mgmt_addr_info *addr = data;
 	int err;
 
 	BT_DBG("%s ", hdev->name);
 
+	if (!bdaddr_type_is_valid(addr->type))
+		return cmd_complete(sk, hdev->id, MGMT_OP_ADD_REMOTE_OOB_DATA,
+				    MGMT_STATUS_INVALID_PARAMS, addr,
+				    sizeof(*addr));
+
 	hci_dev_lock(hdev);
 
 	if (len == MGMT_ADD_REMOTE_OOB_DATA_SIZE) {
-- 
2.1.0

