Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <59db4697.d505630a.16da5.e54a@mx.google.com>
Date: Mon, 9 Oct 2017 15:22:52 +0530
From: Shermin Joy <shermin.joy@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v2 3/3] Use whitelist along with resolving list to enable
 device filtering
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

A peer device using an RPA can be added to the whitelist, if it is
present in the resolving list.

Signed-off-by: Shermin Joy <shermin.joy@gmail.com>
---
 net/bluetooth/hci_request.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 347054d..5be918a 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -708,8 +708,14 @@ static u8 update_white_list(struct hci_request *req)
 		}
 
 		if (hci_find_irk_by_addr(hdev, &b->bdaddr, b->bdaddr_type)) {
-			/* White list can not be used with RPAs */
-			return 0x00;
+			/* White list can not be used with RPAs if address
+			 * resolution is disabled in the controller or the
+			 * peer device is not present in the resolving list.
+			 */
+			if (!hdev->le_ll_addr_resolve_enabled ||
+			    (!hci_resolving_list_lookup(hdev, &b->bdaddr,
+						       b->bdaddr_type)))
+				return 0x00;
 		}
 
 		white_list_entries++;
@@ -737,8 +743,14 @@ static u8 update_white_list(struct hci_request *req)
 
 		if (hci_find_irk_by_addr(hdev, &params->addr,
 					 params->addr_type)) {
-			/* White list can not be used with RPAs */
-			return 0x00;
+			/* White list can not be used with RPAs if address
+			 * resolution is disabled in the controller or the
+			 * peer device is not present in the resolving list.
+			 */
+			if (!hdev->le_ll_addr_resolve_enabled ||
+			    (!hci_resolving_list_lookup(hdev, &params->addr,
+						       params->addr_type)))
+				return 0x00;
 		}
 
 		white_list_entries++;
@@ -761,8 +773,14 @@ static u8 update_white_list(struct hci_request *req)
 
 		if (hci_find_irk_by_addr(hdev, &params->addr,
 					 params->addr_type)) {
-			/* White list can not be used with RPAs */
-			return 0x00;
+			/* White list can not be used with RPAs if address
+			 * resolution is disabled in the controller or the
+			 * peer device is not present in the resolving list.
+			 */
+			if (!hdev->le_ll_addr_resolve_enabled ||
+			    (!hci_resolving_list_lookup(hdev, &params->addr,
+						       params->addr_type)))
+				return 0x00;
 		}
 
 		white_list_entries++;
-- 
1.9.1

