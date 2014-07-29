Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix SMP authentication requirement when initiator
Date: Tue, 29 Jul 2014 12:07:39 +0300
Message-Id: <1406624859-17294-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Even if we're not pairable (the HCI_PAIRABLE flag is unset) we should
still allow initiating pairing with bonding. This patch adds a missing
check for SMP_FLAG_INITIATOR to build_pairing_cmd() and ensures this
flag is properly set before calling the function.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index a7c344b4acbc..7e914477721a 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -307,7 +307,8 @@ static void build_pairing_cmd(struct l2cap_conn *conn,
 	struct hci_dev *hdev = hcon->hdev;
 	u8 local_dist = 0, remote_dist = 0;
 
-	if (test_bit(HCI_PAIRABLE, &conn->hcon->hdev->dev_flags)) {
+	if (test_bit(HCI_PAIRABLE, &conn->hcon->hdev->dev_flags) ||
+	    test_bit(SMP_FLAG_INITIATOR, &smp->flags)) {
 		local_dist = SMP_DIST_ENC_KEY | SMP_DIST_SIGN;
 		remote_dist = SMP_DIST_ENC_KEY | SMP_DIST_SIGN;
 		authreq |= SMP_AUTH_BONDING;
@@ -985,6 +986,8 @@ int smp_conn_security(struct hci_conn *hcon, __u8 sec_level)
 	    hcon->pending_sec_level > BT_SECURITY_MEDIUM)
 		authreq |= SMP_AUTH_MITM;
 
+	set_bit(SMP_FLAG_INITIATOR, &smp->flags);
+
 	if (hcon->role == HCI_ROLE_MASTER) {
 		struct smp_cmd_pairing cp;
 
@@ -999,8 +1002,6 @@ int smp_conn_security(struct hci_conn *hcon, __u8 sec_level)
 		smp_send_cmd(conn, SMP_CMD_SECURITY_REQ, sizeof(cp), &cp);
 	}
 
-	set_bit(SMP_FLAG_INITIATOR, &smp->flags);
-
 	return 0;
 }
 
-- 
1.9.3

