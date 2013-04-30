Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 01/13] Bluetooth: Fix start_discovery for LE-only controllers
Date: Tue, 30 Apr 2013 02:44:52 -0300
Message-Id: <1367300704-703-2-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1367300704-703-1-git-send-email-andre.guedes@openbossa.org>
References: <1367300704-703-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

LE-only controllers don't have local extended features (see commit
c73eee9172bf061202c75ad4d16506a7efd04d1c). Thus, lmp_host_le_capable
helper is not applicable and we should use test_bit(HCI_LE_ENABLED)
to check if the host supports LE. Otherwise, start_discovery will
always fail for LE-only controllers.

This misbehavior can be easily checked by running mgmt-tester tool
(test "Start Discovery - Success 2" will fail).

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/mgmt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 35fef22..9ea3783 100644
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
@@ -2712,7 +2712,8 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 		break;
 
 	case DISCOV_TYPE_INTERLEAVED:
-		if (!lmp_host_le_capable(hdev) || !lmp_bredr_capable(hdev)) {
+		if (!test_bit(HCI_LE_ENABLED, &hdev->dev_flags) ||
+		    !lmp_bredr_capable(hdev)) {
 			err = cmd_status(sk, hdev->id, MGMT_OP_START_DISCOVERY,
 					 MGMT_STATUS_NOT_SUPPORTED);
 			mgmt_pending_remove(cmd);
-- 
1.8.2.1

