Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Limit BR/EDR switching for LE only with secure connections
Date: Thu, 22 Jan 2015 11:15:21 -0800
Message-Id: <1421954122-15727-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When a powered on dual-mode controller has been configured to operate
as LE only with secure connections, then the BR/EDR side of things can
not be switched back on. Do reconfigure the controller it first needs
to be powered down.

The secure connections feature is implemented in the BR/EDR controller
while for LE it is implemented in the host. So explicitly forbid such
a transaction to avoid inconsistent states.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 3049a4815665..e86b8d9105e9 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4691,9 +4691,16 @@ static int set_bredr(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 		 * Dual-mode controllers shall operate with the public
 		 * address as its identity address for BR/EDR and LE. So
 		 * reject the attempt to create an invalid configuration.
+		 *
+		 * The same restrictions applies when secure connections
+		 * has been enabled. For BR/EDR this is a controller feature
+		 * while for LE it is a host stack feature. This means that
+		 * switching BR/EDR back on when secure connections has been
+		 * enabled is not a supported transaction.
 		 */
 		if (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags) &&
-		    bacmp(&hdev->static_addr, BDADDR_ANY)) {
+		    (bacmp(&hdev->static_addr, BDADDR_ANY) ||
+		     test_bit(HCI_SC_ENABLED, &hdev->dev_flags))) {
 			err = cmd_status(sk, hdev->id, MGMT_OP_SET_BREDR,
 					 MGMT_STATUS_REJECTED);
 			goto unlock;
-- 
2.1.0

