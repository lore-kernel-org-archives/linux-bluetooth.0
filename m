Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix generation of non-resolvable private addresses
Date: Sun,  7 Dec 2014 20:13:17 +0100
Message-Id: <1417979597-27993-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the host decides to use a non-resolvable private address, it
must ensure that this generated address does not match the public
address of the controller. Add an extra check to ensure this required
behavior.

In addition rename the variable from urpa to nrpa and fix all of the
comments in the code that use the term unresolvable instead of the
term non-resolvable as used in the Bluetooth specification.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_conn.c |  2 +-
 net/bluetooth/hci_core.c | 24 ++++++++++++++++++------
 net/bluetooth/mgmt.c     |  2 +-
 3 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 79d84b88b8f0..fe18825cc8a4 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -661,7 +661,7 @@ static void hci_req_add_le_create_conn(struct hci_request *req,
 	memset(&cp, 0, sizeof(cp));
 
 	/* Update random address, but set require_privacy to false so
-	 * that we never connect with an unresolvable address.
+	 * that we never connect with an non-resolvable address.
 	 */
 	if (hci_update_random_address(req, false, &own_addr_type))
 		return;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 93f92a085506..96e7321c57a4 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3959,17 +3959,29 @@ int hci_update_random_address(struct hci_request *req, bool require_privacy,
 	}
 
 	/* In case of required privacy without resolvable private address,
-	 * use an unresolvable private address. This is useful for active
+	 * use an non-resolvable private address. This is useful for active
 	 * scanning and non-connectable advertising.
 	 */
 	if (require_privacy) {
-		bdaddr_t urpa;
+		bdaddr_t nrpa;
 
-		get_random_bytes(&urpa, 6);
-		urpa.b[5] &= 0x3f;	/* Clear two most significant bits */
+		while (true) {
+			/* The non-resolvable private address is generated
+			 * from random six bytes with the two most significant
+			 * bits cleared.
+			 */
+			get_random_bytes(&nrpa, 6);
+			nrpa.b[5] &= 0x3f;
+
+			/* The non-resolvable private address shall not be
+			 * equal to the public address.
+			 */
+			if (bacmp(&hdev->bdaddr, &nrpa))
+				break;
+		}
 
 		*own_addr_type = ADDR_LE_DEV_RANDOM;
-		set_random_addr(req, &urpa);
+		set_random_addr(req, &nrpa);
 		return 0;
 	}
 
@@ -5625,7 +5637,7 @@ void hci_req_add_le_passive_scan(struct hci_request *req)
 	u8 filter_policy;
 
 	/* Set require_privacy to false since no SCAN_REQ are send
-	 * during passive scanning. Not using an unresolvable address
+	 * during passive scanning. Not using an non-resolvable address
 	 * here is important so that peer devices using direct
 	 * advertising with our address will be correctly reported
 	 * by the controller.
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index a91e484886fe..44b20deb6038 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3791,7 +3791,7 @@ static bool trigger_discovery(struct hci_request *req, u8 *status)
 
 		/* All active scans will be done with either a resolvable
 		 * private address (when privacy feature has been enabled)
-		 * or unresolvable private address.
+		 * or non-resolvable private address.
 		 */
 		err = hci_update_random_address(req, true, &own_addr_type);
 		if (err < 0) {
-- 
1.9.3

