Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Select the own address type during initial setup phase
Date: Fri, 18 Oct 2013 16:38:09 -0700
Message-Id: <1382139490-306-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The own address type is based on the fact if the controller has
a public address or not. This means that this detail can be just
configured once during setup phase.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_conn.c         |  7 +------
 net/bluetooth/hci_core.c         | 13 ++++++++++++-
 net/bluetooth/mgmt.c             | 10 ++--------
 4 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 9b5db01..0daac39 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -142,6 +142,7 @@ struct hci_dev {
 	__u8		dev_type;
 	bdaddr_t	bdaddr;
 	bdaddr_t	static_addr;
+	__u8		own_addr_type;
 	__u8		dev_name[HCI_MAX_NAME_LENGTH];
 	__u8		short_name[HCI_MAX_SHORT_NAME_LENGTH];
 	__u8		eir[HCI_MAX_EIR_LENGTH];
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 4e72650..974d7bc 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -615,12 +615,7 @@ static struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 	else
 		conn->dst_type = ADDR_LE_DEV_RANDOM;
 
-	if (bacmp(&conn->src, BDADDR_ANY)) {
-		conn->src_type = ADDR_LE_DEV_PUBLIC;
-	} else {
-		bacpy(&conn->src, &hdev->static_addr);
-		conn->src_type = ADDR_LE_DEV_RANDOM;
-	}
+	conn->src_type = hdev->own_addr_type;
 
 	conn->state = BT_CONNECT;
 	conn->out = true;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 6b1844f..c130a23 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1053,8 +1053,19 @@ static void hci_init3_req(struct hci_request *req, unsigned long opt)
 	if (hdev->commands[5] & 0x10)
 		hci_setup_link_policy(req);
 
-	if (lmp_le_capable(hdev))
+	if (lmp_le_capable(hdev)) {
+		/* If the controller has a public BD_ADDR, then by
+		 * default use that one. If this is a LE only
+		 * controller without one, default to the random
+		 * address.
+		 */
+		if (bacmp(&hdev->bdaddr, BDADDR_ANY))
+			hdev->own_addr_type = ADDR_LE_DEV_PUBLIC;
+		else
+			hdev->own_addr_type = ADDR_LE_DEV_RANDOM;
+
 		hci_set_le_support(req);
+	}
 
 	/* Read features beyond page 1 if available */
 	for (p = 2; p < HCI_MAX_PAGES && p <= hdev->max_page; p++) {
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index a727b47..fb7fc9f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1325,10 +1325,7 @@ static void enable_advertising(struct hci_request *req)
 	cp.min_interval = __constant_cpu_to_le16(0x0800);
 	cp.max_interval = __constant_cpu_to_le16(0x0800);
 	cp.type = get_adv_type(hdev);
-	if (bacmp(&hdev->bdaddr, BDADDR_ANY))
-		cp.own_address_type = ADDR_LE_DEV_PUBLIC;
-	else
-		cp.own_address_type = ADDR_LE_DEV_RANDOM;
+	cp.own_address_type = hdev->own_addr_type;
 	cp.channel_map = 0x07;
 
 	hci_req_add(req, HCI_OP_LE_SET_ADV_PARAM, sizeof(cp), &cp);
@@ -3237,10 +3234,7 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 		param_cp.type = LE_SCAN_ACTIVE;
 		param_cp.interval = cpu_to_le16(DISCOV_LE_SCAN_INT);
 		param_cp.window = cpu_to_le16(DISCOV_LE_SCAN_WIN);
-		if (bacmp(&hdev->bdaddr, BDADDR_ANY))
-			param_cp.own_address_type = ADDR_LE_DEV_PUBLIC;
-		else
-			param_cp.own_address_type = ADDR_LE_DEV_RANDOM;
+		param_cp.own_address_type = hdev->own_addr_type;
 		hci_req_add(&req, HCI_OP_LE_SET_SCAN_PARAM, sizeof(param_cp),
 			    &param_cp);
 
-- 
1.8.3.1

