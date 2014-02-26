Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 13/17] Bluetooth: Connection parameters and resolvable address
Date: Wed, 26 Feb 2014 20:21:52 -0300
Message-Id: <1393456916-22701-13-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1393456916-22701-1-git-send-email-andre.guedes@openbossa.org>
References: <1393456916-22701-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We should only accept connection parameters from identity addresses
(public or random static). Thus, we should check the address type
in hci_conn_params_add().

Additionally, since the IRK is removed during unpair, we should also
remove the connection parameters from that device.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |  6 +++---
 net/bluetooth/hci_core.c         | 25 +++++++++++++++++++++----
 net/bluetooth/mgmt.c             |  2 ++
 3 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b159810..4b192d0 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -801,9 +801,9 @@ int hci_blacklist_del(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
 
 struct hci_conn_params *hci_conn_params_lookup(struct hci_dev *hdev,
 					       bdaddr_t *addr, u8 addr_type);
-void hci_conn_params_add(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type,
-			 u8 auto_connect, u16 conn_min_interval,
-			 u16 conn_max_interval);
+int hci_conn_params_add(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type,
+			u8 auto_connect, u16 conn_min_interval,
+			u16 conn_max_interval);
 void hci_conn_params_del(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type);
 void hci_conn_params_clear(struct hci_dev *hdev);
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 9470a9c..6d83ca0 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3220,13 +3220,28 @@ static bool is_connected(struct hci_dev *hdev, bdaddr_t *addr, u8 type)
 	return true;
 }
 
+static bool is_identity_address(bdaddr_t *addr, u8 addr_type)
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
 /* This function requires the caller holds hdev->lock */
-void hci_conn_params_add(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type,
-			 u8 auto_connect, u16 conn_min_interval,
-			 u16 conn_max_interval)
+int hci_conn_params_add(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type,
+			u8 auto_connect, u16 conn_min_interval,
+			u16 conn_max_interval)
 {
 	struct hci_conn_params *params;
 
+	if (!is_identity_address(addr, addr_type))
+		return -EINVAL;
+
 	params = hci_conn_params_lookup(hdev, addr, addr_type);
 	if (params)
 		goto update;
@@ -3234,7 +3249,7 @@ void hci_conn_params_add(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type,
 	params = kzalloc(sizeof(*params), GFP_KERNEL);
 	if (!params) {
 		BT_ERR("Out of memory");
-		return;
+		return -ENOMEM;
 	}
 
 	bacpy(&params->addr, addr);
@@ -3261,6 +3276,8 @@ update:
 	BT_DBG("addr %pMR (type %u) auto_connect %u conn_min_interval 0x%.4x "
 	       "conn_max_interval 0x%.4x", addr, addr_type, auto_connect,
 	       conn_min_interval, conn_max_interval);
+
+	return 0;
 }
 
 /* This function requires the caller holds hdev->lock */
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index f878267..2e6564e 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2416,6 +2416,8 @@ static int unpair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 
 		hci_remove_irk(hdev, &cp->addr.bdaddr, addr_type);
 
+		hci_conn_params_del(hdev, &cp->addr.bdaddr, addr_type);
+
 		err = hci_remove_ltk(hdev, &cp->addr.bdaddr, addr_type);
 	}
 
-- 
1.8.5.4

