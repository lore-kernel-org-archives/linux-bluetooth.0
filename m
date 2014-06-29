Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Don't use non-resolvable private address for passive scanning
Date: Sun, 29 Jun 2014 12:20:15 +0200
Message-Id: <1404037215-42235-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The usage of non-resovlable private addresses for passive scanning is
a bad idea. Passive scanning will not send any SCAN_REQ and thus using
your identity address for passive scanning is not a privacy issue.

It is important to use the identity address during passive scanning
since that is the only way devices using direct advertising will be
reported correctly by the controller. This is overlooked detail in
the Bluetooth specification that current controllers are not able
to report direct advertising events for other than their current
address.

When remote peers are using direct advertising and scanning is done
with non-resolvable private address these devices will not be found.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 50db0201213c..3ee2885dd9bc 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -5250,12 +5250,13 @@ void hci_req_add_le_passive_scan(struct hci_request *req)
 	struct hci_dev *hdev = req->hdev;
 	u8 own_addr_type;
 
-	/* Set require_privacy to true to avoid identification from
-	 * unknown peer devices. Since this is passive scanning, no
-	 * SCAN_REQ using the local identity should be sent. Mandating
-	 * privacy is just an extra precaution.
+	/* Set require_privacy to false since no SCAN_REQ are send
+	 * during passive scanning. Not using an unresolvable address
+	 * here is important so that peer devices using direct
+	 * advertising with our address will be correctly reported
+	 * by the controller.
 	 */
-	if (hci_update_random_address(req, true, &own_addr_type))
+	if (hci_update_random_address(req, false, &own_addr_type))
 		return;
 
 	memset(&param_cp, 0, sizeof(param_cp));
-- 
1.9.3

