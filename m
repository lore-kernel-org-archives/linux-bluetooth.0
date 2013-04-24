Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix checks for LE support on LE-only controllers
Date: Wed, 24 Apr 2013 13:05:32 +0300
Message-Id: <1366797932-11507-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

LE-only controllers do not support extended features so any kind of host
feature bit checks do not make sense for them. This patch fixes code
used for both single-mode (LE-only) and dual-mode (BR/EDR/LE) to use the
HCI_LE_ENABLED flag instead of the "Host LE supported" feature bit for
LE support tests.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
This one slipped by with my earlier single-mode fixes. I've added a
mgmt-tester case for it to prevent it from returning in the future.
Since this is probably too late for a bluetooth-next pull for 3.10 I
suppose it'll need to wait for the first bluetooth.git pull request
instead.

 net/bluetooth/mgmt.c |    2 +-
 net/bluetooth/smp.c  |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 35fef22..5e93b24 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2700,7 +2700,7 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 		break;
 
 	case DISCOV_TYPE_LE:
-		if (!lmp_host_le_capable(hdev)) {
+		if (!test_bit(HCI_LE_ENABLED, &hdev->dev_flags)) {
 			err = cmd_status(sk, hdev->id, MGMT_OP_START_DISCOVERY,
 					 MGMT_STATUS_NOT_SUPPORTED);
 			mgmt_pending_remove(cmd);
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index b2296d3..b5562ab 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -770,7 +770,7 @@ int smp_conn_security(struct hci_conn *hcon, __u8 sec_level)
 
 	BT_DBG("conn %p hcon %p level 0x%2.2x", conn, hcon, sec_level);
 
-	if (!lmp_host_le_capable(hcon->hdev))
+	if (!test_bit(HCI_LE_ENABLED, &hcon->hdev->dev_flags))
 		return 1;
 
 	if (sec_level == BT_SECURITY_LOW)
@@ -851,7 +851,7 @@ int smp_sig_channel(struct l2cap_conn *conn, struct sk_buff *skb)
 	__u8 reason;
 	int err = 0;
 
-	if (!lmp_host_le_capable(conn->hcon->hdev)) {
+	if (!test_bit(HCI_LE_ENABLED, &conn->hcon->hdev->dev_flags)) {
 		err = -ENOTSUPP;
 		reason = SMP_PAIRING_NOTSUPP;
 		goto done;
-- 
1.7.10.4

