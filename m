Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 09/10] Bluetooth: Make is_identity_address a global function
Date: Wed,  2 Jul 2014 17:37:33 +0300
Message-Id: <1404311854-12233-10-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1404311854-12233-1-git-send-email-johan.hedberg@gmail.com>
References: <1404311854-12233-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

There are more places that can take advantage of is_identity_address()
besides hci_core.c. This patch moves the function to hci_core.h and
gives it the appropriate hci_ prefix.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h | 12 ++++++++++++
 net/bluetooth/hci_core.c         | 14 +-------------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index d0bca13843ce..92f1bad6e22d 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1179,6 +1179,18 @@ static inline bool hci_bdaddr_is_rpa(bdaddr_t *bdaddr, u8 addr_type)
 	return false;
 }
 
+static inline bool hci_is_identity_address(bdaddr_t *addr, u8 addr_type)
+{
+	if (addr_type == ADDR_LE_DEV_PUBLIC)
+		return true;
+
+	/* Check for Random Static address type */
+	if ((addr->b[5] & 0xc0) == 0xc0)
+		return true;
+
+	return false;
+}
+
 static inline struct smp_irk *hci_get_irk(struct hci_dev *hdev,
 					  bdaddr_t *bdaddr, u8 addr_type)
 {
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index a3cd0bbd3518..1fff3d890f41 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3412,18 +3412,6 @@ static bool is_connected(struct hci_dev *hdev, bdaddr_t *addr, u8 type)
 	return true;
 }
 
-static bool is_identity_address(bdaddr_t *addr, u8 addr_type)
-{
-	if (addr_type == ADDR_LE_DEV_PUBLIC)
-		return true;
-
-	/* Check for Random Static address type */
-	if ((addr->b[5] & 0xc0) == 0xc0)
-		return true;
-
-	return false;
-}
-
 /* This function requires the caller holds hdev->lock */
 struct bdaddr_list *hci_pend_le_conn_lookup(struct hci_dev *hdev,
 					    bdaddr_t *addr, u8 addr_type)
@@ -3504,7 +3492,7 @@ struct hci_conn_params *hci_conn_params_add(struct hci_dev *hdev,
 {
 	struct hci_conn_params *params;
 
-	if (!is_identity_address(addr, addr_type))
+	if (!hci_is_identity_address(addr, addr_type))
 		return NULL;
 
 	params = hci_conn_params_lookup(hdev, addr, addr_type);
-- 
1.9.3

