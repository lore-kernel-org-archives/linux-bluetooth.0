Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] Bluetooth: Introduce a new HCI_BREDR_ENABLED flag
Date: Wed,  2 Oct 2013 13:43:13 +0300
Message-Id: <1380710594-24555-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1380710594-24555-1-git-send-email-johan.hedberg@gmail.com>
References: <1380710594-24555-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

To allow treating dual-mode (BR/EDR/LE) controllers as single-mode ones
(LE-only) we want to introduce a new HCI_BREDR_ENABLED flag to track
whether BR/EDR is enabled or not (previously we simply looked at the
feature bit with lmp_bredr_enabled).

This patch add the new flag and updates the relevant places to test
against it instead of using lmp_bredr_enabled. The flag is by default
enabled when registering an adapter and only cleared if necessary once
the local features have been read during the HCI init procedure.

We cannot completely block BR/EDR usage in case user space uses raw HCI
sockets but the patch tries to block this in places where possible, such
as the various BR/EDR specific ioctls.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h |  1 +
 net/bluetooth/hci_conn.c    |  3 +++
 net/bluetooth/hci_core.c    | 21 +++++++++++++++++++--
 net/bluetooth/mgmt.c        | 24 +++++++++++++-----------
 4 files changed, 36 insertions(+), 13 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 7ede266..4fa08d7 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -122,6 +122,7 @@ enum {
 	HCI_LINK_SECURITY,
 	HCI_PERIODIC_INQ,
 	HCI_FAST_CONNECTABLE,
+	HCI_BREDR_ENABLED,
 };
 
 /* A mask for the flags that are supposed to remain when a reset happens
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index d2380e0..514148b 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -581,6 +581,9 @@ static struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
 {
 	struct hci_conn *acl;
 
+	if (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags))
+		return ERR_PTR(-ENOTSUPP);
+
 	acl = hci_conn_hash_lookup_ba(hdev, ACL_LINK, dst);
 	if (!acl) {
 		acl = hci_conn_add(hdev, ACL_LINK, dst);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 7cbdd33..14df032 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -519,6 +519,8 @@ static void hci_init2_req(struct hci_request *req, unsigned long opt)
 
 	if (lmp_bredr_capable(hdev))
 		bredr_setup(req);
+	else
+		clear_bit(HCI_BREDR_ENABLED, &hdev->dev_flags);
 
 	if (lmp_le_capable(hdev))
 		le_setup(req);
@@ -1034,6 +1036,11 @@ int hci_inquiry(void __user *arg)
 		goto done;
 	}
 
+	if (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags)) {
+		err = -EOPNOTSUPP;
+		goto done;
+	}
+
 	hci_dev_lock(hdev);
 	if (inquiry_cache_age(hdev) > INQUIRY_CACHE_AGE_MAX ||
 	    inquiry_cache_empty(hdev) || ir.flags & IREQ_CACHE_FLUSH) {
@@ -1101,7 +1108,7 @@ static u8 create_ad(struct hci_dev *hdev, u8 *ptr)
 	if (test_bit(HCI_LE_PERIPHERAL, &hdev->dev_flags))
 		flags |= LE_AD_GENERAL;
 
-	if (!lmp_bredr_capable(hdev))
+	if (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags))
 		flags |= LE_AD_NO_BREDR;
 
 	if (lmp_le_br_capable(hdev))
@@ -1493,6 +1500,11 @@ int hci_dev_cmd(unsigned int cmd, void __user *arg)
 		goto done;
 	}
 
+	if (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags)) {
+		err = -EOPNOTSUPP;
+		goto done;
+	}
+
 	switch (cmd) {
 	case HCISETAUTH:
 		err = hci_req_sync(hdev, hci_auth_req, dr.dev_opt,
@@ -2318,8 +2330,13 @@ int hci_register_dev(struct hci_dev *hdev)
 
 	set_bit(HCI_SETUP, &hdev->dev_flags);
 
-	if (hdev->dev_type != HCI_AMP)
+	if (hdev->dev_type != HCI_AMP) {
 		set_bit(HCI_AUTO_OFF, &hdev->dev_flags);
+		/* Assume BR/EDR support until proven otherwise (such as
+		 * through reading supported features during init.
+		 */
+		set_bit(HCI_BREDR_ENABLED, &hdev->dev_flags);
+	}
 
 	write_lock(&hci_dev_list_lock);
 	list_add(&hdev->list, &hci_dev_list);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 35d3c12..04d0f5a 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -408,7 +408,7 @@ static u32 get_current_settings(struct hci_dev *hdev)
 	if (test_bit(HCI_PAIRABLE, &hdev->dev_flags))
 		settings |= MGMT_SETTING_PAIRABLE;
 
-	if (lmp_bredr_capable(hdev))
+	if (test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags))
 		settings |= MGMT_SETTING_BREDR;
 
 	if (test_bit(HCI_LE_ENABLED, &hdev->dev_flags))
@@ -929,7 +929,7 @@ static int set_discoverable(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	BT_DBG("request for %s", hdev->name);
 
-	if (!lmp_bredr_capable(hdev))
+	if (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags))
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_DISCOVERABLE,
 				 MGMT_STATUS_NOT_SUPPORTED);
 
@@ -1085,7 +1085,7 @@ static int set_connectable(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	BT_DBG("request for %s", hdev->name);
 
-	if (!lmp_bredr_capable(hdev))
+	if (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags))
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_CONNECTABLE,
 				  MGMT_STATUS_NOT_SUPPORTED);
 
@@ -1208,7 +1208,7 @@ static int set_link_security(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	BT_DBG("request for %s", hdev->name);
 
-	if (!lmp_bredr_capable(hdev))
+	if (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags))
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_LINK_SECURITY,
 				  MGMT_STATUS_NOT_SUPPORTED);
 
@@ -1342,7 +1342,7 @@ static int set_hs(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 
 	BT_DBG("request for %s", hdev->name);
 
-	if (!lmp_bredr_capable(hdev))
+	if (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags))
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_HS,
 				  MGMT_STATUS_NOT_SUPPORTED);
 
@@ -1416,7 +1416,7 @@ static int set_le(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 				  MGMT_STATUS_INVALID_PARAMS);
 
 	/* LE-only devices do not allow toggling LE on/off */
-	if (!lmp_bredr_capable(hdev))
+	if (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags))
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_LE,
 				  MGMT_STATUS_REJECTED);
 
@@ -1727,7 +1727,7 @@ static int set_dev_class(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	BT_DBG("request for %s", hdev->name);
 
-	if (!lmp_bredr_capable(hdev))
+	if (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags))
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_DEV_CLASS,
 				  MGMT_STATUS_NOT_SUPPORTED);
 
@@ -2810,7 +2810,7 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 
 	switch (hdev->discovery.type) {
 	case DISCOV_TYPE_BREDR:
-		if (!lmp_bredr_capable(hdev)) {
+		if (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags)) {
 			err = cmd_status(sk, hdev->id, MGMT_OP_START_DISCOVERY,
 					 MGMT_STATUS_NOT_SUPPORTED);
 			mgmt_pending_remove(cmd);
@@ -2842,7 +2842,7 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 		}
 
 		if (hdev->discovery.type == DISCOV_TYPE_INTERLEAVED &&
-		    !lmp_bredr_capable(hdev)) {
+		    !test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags)) {
 			err = cmd_status(sk, hdev->id, MGMT_OP_START_DISCOVERY,
 					 MGMT_STATUS_NOT_SUPPORTED);
 			mgmt_pending_remove(cmd);
@@ -3289,7 +3289,8 @@ static int set_fast_connectable(struct sock *sk, struct hci_dev *hdev,
 
 	BT_DBG("%s", hdev->name);
 
-	if (!lmp_bredr_capable(hdev) || hdev->hci_ver < BLUETOOTH_VER_1_2)
+	if (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags) ||
+	    hdev->hci_ver < BLUETOOTH_VER_1_2)
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_FAST_CONNECTABLE,
 				  MGMT_STATUS_NOT_SUPPORTED);
 
@@ -3653,7 +3654,8 @@ static int powered_update_hci(struct hci_dev *hdev)
 			    sizeof(link_sec), &link_sec);
 
 	if (lmp_bredr_capable(hdev)) {
-		set_bredr_scan(&req);
+		if (test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags))
+			set_bredr_scan(&req);
 		update_class(&req);
 		update_name(&req);
 		update_eir(&req);
-- 
1.8.3.1

