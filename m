Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 09/15] Bluetooth: Fix hdev->own_addr_type value when privacy is set
Date: Sat, 22 Feb 2014 19:06:39 +0200
Message-Id: <1393088805-28658-10-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1393088805-28658-1-git-send-email-johan.hedberg@gmail.com>
References: <1393088805-28658-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When powering on the controller and deciding what value to set to
hdev->own_address_time take also into account the HCI_PRIVACY flag (in
which case random own address should be used).

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 964aa8deb009..753a73ba6764 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1477,14 +1477,16 @@ static void hci_init3_req(struct hci_request *req, unsigned long opt)
 
 	if (lmp_le_capable(hdev)) {
 		/* If the controller has a public BD_ADDR, then by default
-		 * use that one. If this is a LE only controller without
-		 * a public address, default to the random address.
+		 * use that one, unless Privacy is enabled. If this is a LE
+		 * only controller without a public address, default to
+		 * the random address.
 		 *
 		 * For debugging purposes it is possible to force
 		 * controllers with a public address to use the
 		 * random address instead.
 		 */
-		if (test_bit(HCI_FORCE_STATIC_ADDR, &hdev->dev_flags) ||
+		if (test_bit(HCI_PRIVACY, &hdev->dev_flags) ||
+		    test_bit(HCI_FORCE_STATIC_ADDR, &hdev->dev_flags) ||
 		    !bacmp(&hdev->bdaddr, BDADDR_ANY))
 			hdev->own_addr_type = ADDR_LE_DEV_RANDOM;
 		else
-- 
1.8.5.3

