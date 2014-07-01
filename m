Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Use hci_conn_params_add within hci_conn_params_set
Date: Tue,  1 Jul 2014 12:11:05 +0200
Message-Id: <1404209466-64712-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The hci_conn_params_add function provides the default allocation of
connection parameters. To avoid code duplication, use that code from
hci_conn_params_set to allocate or lookup parameter struct.

As a benefit the connection latency and supervision timeout parameters
are no longer reset to default when calling hci_conn_params_set.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 883ddd52344d..9ae945d8ad7e 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3513,29 +3513,12 @@ int hci_conn_params_set(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type,
 {
 	struct hci_conn_params *params;
 
-	if (!is_identity_address(addr, addr_type))
-		return -EINVAL;
-
-	params = hci_conn_params_lookup(hdev, addr, addr_type);
-	if (params)
-		goto update;
-
-	params = kzalloc(sizeof(*params), GFP_KERNEL);
-	if (!params) {
-		BT_ERR("Out of memory");
-		return -ENOMEM;
-	}
-
-	bacpy(&params->addr, addr);
-	params->addr_type = addr_type;
-
-	list_add(&params->list, &hdev->le_conn_params);
+	params = hci_conn_params_add(hdev, addr, addr_type);
+	if (!params)
+		return -EIO;
 
-update:
 	params->conn_min_interval = conn_min_interval;
 	params->conn_max_interval = conn_max_interval;
-	params->conn_latency = hdev->le_conn_latency;
-	params->supervision_timeout = hdev->le_supv_timeout;
 	params->auto_connect = auto_connect;
 
 	switch (auto_connect) {
-- 
1.9.3

