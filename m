Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 11/12] Bluetooth: Make hci_pend_le_conn_lookup more general purposed
Date: Fri,  4 Jul 2014 12:37:26 +0300
Message-Id: <1404466647-16352-12-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1404466647-16352-1-git-send-email-johan.hedberg@gmail.com>
References: <1404466647-16352-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

In some circumstances we need to look up entries in pend_le_conns and in
other in pend_le_reports. This patch converts the existing lookup
function for pend_le_conns to something that can be used for both lists.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h | 5 +++--
 net/bluetooth/hci_core.c         | 6 +++---
 net/bluetooth/hci_event.c        | 2 +-
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index c2bc9180cb79..1cae4d3a629d 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -868,8 +868,9 @@ void hci_conn_params_clear_all(struct hci_dev *hdev);
 void hci_conn_params_clear_disabled(struct hci_dev *hdev);
 void hci_conn_params_clear_enabled(struct hci_dev *hdev);
 
-struct hci_conn_params *hci_pend_le_conn_lookup(struct hci_dev *hdev,
-						bdaddr_t *addr, u8 addr_type);
+struct hci_conn_params *hci_pend_le_action_lookup(struct list_head *list,
+						  bdaddr_t *addr,
+						  u8 addr_type);
 
 void hci_update_background_scan(struct hci_dev *hdev);
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 38a0c5cd0ee4..038b4748375b 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3442,8 +3442,8 @@ static bool is_connected(struct hci_dev *hdev, bdaddr_t *addr, u8 type)
 }
 
 /* This function requires the caller holds hdev->lock */
-struct hci_conn_params *hci_pend_le_conn_lookup(struct hci_dev *hdev,
-						bdaddr_t *addr, u8 addr_type)
+struct hci_conn_params *hci_pend_le_action_lookup(struct list_head *list,
+						  bdaddr_t *addr, u8 addr_type)
 {
 	struct hci_conn_params *param;
 
@@ -3451,7 +3451,7 @@ struct hci_conn_params *hci_pend_le_conn_lookup(struct hci_dev *hdev,
 	if (!hci_is_identity_address(addr, addr_type))
 		return NULL;
 
-	list_for_each_entry(param, &hdev->pend_le_conns, action) {
+	list_for_each_entry(param, list, action) {
 		if (bacmp(&param->addr, addr) == 0 &&
 		    param->addr_type == addr_type)
 			return param;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 9e0b2e888bba..9274cd228995 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4194,7 +4194,7 @@ static bool check_pending_le_conn(struct hci_dev *hdev, bdaddr_t *addr,
 {
 	struct hci_conn *conn;
 
-	if (!hci_pend_le_conn_lookup(hdev, addr, addr_type))
+	if (!hci_pend_le_action_lookup(&hdev->pend_le_conns, addr, addr_type))
 		return false;
 
 	conn = hci_connect_le(hdev, addr, addr_type, BT_SECURITY_LOW,
-- 
1.9.3

