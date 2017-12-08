Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?=C5=81ukasz=20Rymanowski?=
        <lukasz.rymanowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?=C5=81ukasz=20Rymanowski?=
        <lukasz.rymanowski@codecoup.pl>
Subject: [PATCH] Bluetooth: Add support to advertise when connected
Date: Fri,  8 Dec 2017 13:40:57 +0100
Message-Id: <20171208124057.32162-1-lukasz.rymanowski@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

So far, kernel did not allow to advertise when there was a connection
established. With this patch kernel does allow it if controller
supports it.

If controller supports non-connectable advertising when connected, then
only non-connectable advertising instances will be advertised.

Signed-off-by: Łukasz Rymanowski <lukasz.rymanowski@codecoup.pl>
---
 net/bluetooth/hci_request.c | 55 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 46 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index abc0f3224dd1..f0ab3a772949 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -919,6 +919,43 @@ static bool adv_use_rpa(struct hci_dev *hdev, uint32_t flags)
 	return true;
 }
 
+static bool is_advertising_allowed(struct hci_dev *hdev, bool connectable)
+{
+	/* If there is no connection we are OK to advertise. */
+	if (hci_conn_num(hdev, LE_LINK) == 0)
+		return true;
+
+	/* Check le_states if there is any connection in slave role. */
+	if (hdev->conn_hash.le_num_slave > 0) {
+		/* Slave connection state and non connectable mode bit 20. */
+		if (!connectable && !(hdev->le_states[2] & 0x10))
+			return false;
+
+		/* Slave connection state and connectable mode bit 38
+		 * and scannable bit 21.
+		 */
+		if (connectable && (!(hdev->le_states[4] & 0x01) ||
+				    !(hdev->le_states[2] & 0x40)))
+			return false;
+	}
+
+	/* Check le_states if there is any connection in master role. */
+	if (hci_conn_num(hdev, LE_LINK) != hdev->conn_hash.le_num_slave) {
+		/* Master connection state and non connectable mode bit 18. */
+		if (!connectable && !(hdev->le_states[2] & 0x02))
+			return false;
+
+		/* Master connection state and connectable mode bit 35 and
+		 * scannable 19.
+		 */
+		if (connectable && (!(hdev->le_states[4] & 0x10) ||
+				    !(hdev->le_states[2] & 0x08)))
+			return false;
+	}
+
+	return true;
+}
+
 void __hci_req_enable_advertising(struct hci_request *req)
 {
 	struct hci_dev *hdev = req->hdev;
@@ -927,7 +964,15 @@ void __hci_req_enable_advertising(struct hci_request *req)
 	bool connectable;
 	u32 flags;
 
-	if (hci_conn_num(hdev, LE_LINK) > 0)
+	flags = get_adv_instance_flags(hdev, hdev->cur_adv_instance);
+
+	/* If the "connectable" instance flag was not set, then choose between
+	 * ADV_IND and ADV_NONCONN_IND based on the global connectable setting.
+	 */
+	connectable = (flags & MGMT_ADV_FLAG_CONNECTABLE) ||
+		      mgmt_get_connectable(hdev);
+
+	if (!is_advertising_allowed(hdev, connectable))
 		return;
 
 	if (hci_dev_test_flag(hdev, HCI_LE_ADV))
@@ -940,14 +985,6 @@ void __hci_req_enable_advertising(struct hci_request *req)
 	 */
 	hci_dev_clear_flag(hdev, HCI_LE_ADV);
 
-	flags = get_adv_instance_flags(hdev, hdev->cur_adv_instance);
-
-	/* If the "connectable" instance flag was not set, then choose between
-	 * ADV_IND and ADV_NONCONN_IND based on the global connectable setting.
-	 */
-	connectable = (flags & MGMT_ADV_FLAG_CONNECTABLE) ||
-		      mgmt_get_connectable(hdev);
-
 	/* Set require_privacy to true only when non-connectable
 	 * advertising is used. In that case it is fine to use a
 	 * non-resolvable private address.
-- 
2.14.1

