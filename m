Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v11 11/15] Bluetooth: Connection parameters and resolvable address
Date: Mon, 24 Feb 2014 19:30:57 -0300
Message-Id: <1393281061-14320-12-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1393281061-14320-1-git-send-email-andre.guedes@openbossa.org>
References: <1393281061-14320-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We should only add connection parameters for public, random static and
random private resolvable with IRK. If we allow non-resolvable or
resolvable without IRK, the background scan may run indefinitely. So, to
avoid this undesired behavior, we should check the address type in
hci_conn_params_add().

Additionally, since the IRK is removed during unpair, we should also
remove the connection parameters from that device.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h | 18 +++++++++++++++---
 net/bluetooth/hci_core.c         | 24 ++++++++++++++++++++----
 net/bluetooth/mgmt.c             |  2 ++
 3 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 5539dea..c81847e 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -799,9 +799,9 @@ int hci_blacklist_del(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
 
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
 
@@ -1117,6 +1117,18 @@ static inline bool hci_bdaddr_is_rpa(bdaddr_t *bdaddr, u8 addr_type)
 	return false;
 }
 
+/* Check if address is "random private non-resolvable" type */
+static inline bool hci_bdaddr_is_non_rpa(bdaddr_t *bdaddr, u8 addr_type)
+{
+	if (addr_type != 0x01)
+		return false;
+
+	if ((bdaddr->b[5] & 0xc0) == 0x00)
+		return true;
+
+	return false;
+}
+
 static inline struct smp_irk *hci_get_irk(struct hci_dev *hdev,
 					  bdaddr_t *bdaddr, u8 addr_type)
 {
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index e78e48e..a8baf9a 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3221,12 +3221,26 @@ static bool is_connected(struct hci_dev *hdev, bdaddr_t *addr, u8 type)
 }
 
 /* This function requires the caller holds hdev->lock */
-void hci_conn_params_add(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type,
-			 u8 auto_connect, u16 conn_min_interval,
-			 u16 conn_max_interval)
+int hci_conn_params_add(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type,
+			u8 auto_connect, u16 conn_min_interval,
+			u16 conn_max_interval)
 {
 	struct hci_conn_params *params;
 
+	if (hci_bdaddr_is_non_rpa(addr, addr_type))
+		return -EINVAL;
+
+	if (hci_bdaddr_is_rpa(addr, addr_type)) {
+		struct smp_irk *irk;
+
+		irk = hci_get_irk(hdev, addr, addr_type);
+		if (!irk)
+			return -EINVAL;
+
+		addr = &irk->bdaddr;
+		addr_type = irk->addr_type;
+	}
+
 	params = hci_conn_params_lookup(hdev, addr, addr_type);
 	if (params)
 		goto update;
@@ -3234,7 +3248,7 @@ void hci_conn_params_add(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type,
 	params = kzalloc(sizeof(*params), GFP_KERNEL);
 	if (!params) {
 		BT_ERR("Out of memory");
-		return;
+		return -ENOMEM;
 	}
 
 	bacpy(&params->addr, addr);
@@ -3261,6 +3275,8 @@ update:
 	BT_DBG("addr %pMR (type %u) auto_connect %u conn_min_interval 0x%.4x "
 	       "conn_max_interval 0x%.4x", addr, addr_type, auto_connect,
 	       conn_min_interval, conn_max_interval);
+
+	return 0;
 }
 
 /* This function requires the caller holds hdev->lock */
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index a08c2bf..4745fb5 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2419,6 +2419,8 @@ static int unpair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 
 		hci_remove_irk(hdev, &cp->addr.bdaddr, addr_type);
 
+		hci_conn_params_del(hdev, &cp->addr.bdaddr, addr_type);
+
 		err = hci_remove_ltk(hdev, &cp->addr.bdaddr, addr_type);
 	}
 
-- 
1.8.5.4

