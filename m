Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] Bluetooth: Remove unneeded mgmt_discoverable function
Date: Thu, 10 Jul 2014 12:09:08 +0300
Message-Id: <1404983349-6105-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1404983349-6105-1-git-send-email-johan.hedberg@gmail.com>
References: <1404983349-6105-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Since the HCISETSCAN ioctl is the only non-mgmt user we care about for
setting the right discoverable state we can simply do the necessary
updates in the ioctl handler function instead. This then allows the
removal of the mgmt_discoverable function and should simplify that state
handling considerably.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  2 +-
 net/bluetooth/hci_core.c         | 24 +++++++++++---
 net/bluetooth/hci_event.c        | 19 +++---------
 net/bluetooth/mgmt.c             | 67 ++++++++++++++--------------------------
 4 files changed, 50 insertions(+), 62 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 76675c55be15..b65efb22be54 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1286,8 +1286,8 @@ void mgmt_index_added(struct hci_dev *hdev);
 void mgmt_index_removed(struct hci_dev *hdev);
 void mgmt_set_powered_failed(struct hci_dev *hdev, int err);
 int mgmt_powered(struct hci_dev *hdev, u8 powered);
+int mgmt_update_adv_data(struct hci_dev *hdev);
 void mgmt_discoverable_timeout(struct hci_dev *hdev);
-void mgmt_discoverable(struct hci_dev *hdev, u8 discoverable);
 void mgmt_write_scan_failed(struct hci_dev *hdev, u8 scan, u8 status);
 void mgmt_new_link_key(struct hci_dev *hdev, struct link_key *key,
 		       bool persistent);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 27c40e4901a3..3321c65c73ac 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2657,7 +2657,7 @@ done:
 
 static void hci_update_scan_state(struct hci_dev *hdev, u8 scan)
 {
-	bool conn_changed;
+	bool conn_changed, discov_changed;
 
 	BT_DBG("%s scan 0x%02x", hdev->name, scan);
 
@@ -2668,11 +2668,27 @@ static void hci_update_scan_state(struct hci_dev *hdev, u8 scan)
 		conn_changed = test_and_clear_bit(HCI_CONNECTABLE,
 						  &hdev->dev_flags);
 
+	if ((scan & SCAN_INQUIRY)) {
+		discov_changed = !test_and_set_bit(HCI_DISCOVERABLE,
+						   &hdev->dev_flags);
+	} else {
+		clear_bit(HCI_LIMITED_DISCOVERABLE, &hdev->dev_flags);
+		discov_changed = test_and_clear_bit(HCI_DISCOVERABLE,
+						    &hdev->dev_flags);
+	}
+
 	if (!test_bit(HCI_MGMT, &hdev->dev_flags))
 		return;
 
-	if (conn_changed)
+	if (conn_changed || discov_changed) {
+		/* In case this was disabled through mgmt */
+		set_bit(HCI_BREDR_ENABLED, &hdev->dev_flags);
+
+		if (test_bit(HCI_LE_ENABLED, &hdev->dev_flags))
+			mgmt_update_adv_data(hdev);
+
 		mgmt_new_settings(hdev);
+	}
 }
 
 int hci_dev_cmd(unsigned int cmd, void __user *arg)
@@ -2736,8 +2752,8 @@ int hci_dev_cmd(unsigned int cmd, void __user *arg)
 		err = hci_req_sync(hdev, hci_scan_req, dr.dev_opt,
 				   HCI_INIT_TIMEOUT);
 
-		/* Ensure that the connectable state gets correctly
-		 * modified as this was a non-mgmt change.
+		/* Ensure that the connectable and discoverable states
+		 * get correctly modified as this was a non-mgmt change.
 		 */
 		if (!err)
 			hci_update_scan_state(hdev, dr.dev_opt);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 38a0e457eaf9..760bbd88f3c5 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -296,7 +296,6 @@ static void hci_cc_write_scan_enable(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	__u8 status = *((__u8 *) skb->data);
 	__u8 param;
-	int old_pscan, old_iscan;
 	void *sent;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, status);
@@ -315,23 +314,15 @@ static void hci_cc_write_scan_enable(struct hci_dev *hdev, struct sk_buff *skb)
 		goto done;
 	}
 
-	/* We need to ensure that we set this back on if someone changed
-	 * the scan mode through a raw HCI socket.
-	 */
-	set_bit(HCI_BREDR_ENABLED, &hdev->dev_flags);
-
-	old_pscan = test_and_clear_bit(HCI_PSCAN, &hdev->flags);
-	old_iscan = test_and_clear_bit(HCI_ISCAN, &hdev->flags);
-
-	if (param & SCAN_INQUIRY) {
+	if (param & SCAN_INQUIRY)
 		set_bit(HCI_ISCAN, &hdev->flags);
-		if (!old_iscan)
-			mgmt_discoverable(hdev, 1);
-	} else if (old_iscan)
-		mgmt_discoverable(hdev, 0);
+	else
+		clear_bit(HCI_ISCAN, &hdev->flags);
 
 	if (param & SCAN_PAGE)
 		set_bit(HCI_PSCAN, &hdev->flags);
+	else
+		clear_bit(HCI_ISCAN, &hdev->flags);
 
 done:
 	hci_dev_unlock(hdev);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 9f9f11c8488b..1dad7bffc6af 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -906,6 +906,16 @@ static void update_adv_data(struct hci_request *req)
 	hci_req_add(req, HCI_OP_LE_SET_ADV_DATA, sizeof(cp), &cp);
 }
 
+int mgmt_update_adv_data(struct hci_dev *hdev)
+{
+	struct hci_request req;
+
+	hci_req_init(&req, hdev);
+	update_adv_data(&req);
+
+	return hci_req_run(&req, NULL);
+}
+
 static void create_eir(struct hci_dev *hdev, u8 *data)
 {
 	u8 *ptr = data;
@@ -1743,7 +1753,7 @@ static void set_connectable_complete(struct hci_dev *hdev, u8 status)
 {
 	struct pending_cmd *cmd;
 	struct mgmt_mode *cp;
-	bool changed;
+	bool conn_changed, discov_changed;
 
 	BT_DBG("status 0x%02x", status);
 
@@ -1760,15 +1770,23 @@ static void set_connectable_complete(struct hci_dev *hdev, u8 status)
 	}
 
 	cp = cmd->param;
-	if (cp->val)
-		changed = !test_and_set_bit(HCI_CONNECTABLE, &hdev->dev_flags);
-	else
-		changed = test_and_clear_bit(HCI_CONNECTABLE, &hdev->dev_flags);
+	if (cp->val) {
+		conn_changed = !test_and_set_bit(HCI_CONNECTABLE,
+						 &hdev->dev_flags);
+		discov_changed = false;
+	} else {
+		conn_changed = test_and_clear_bit(HCI_CONNECTABLE,
+						  &hdev->dev_flags);
+		discov_changed = test_and_clear_bit(HCI_DISCOVERABLE,
+						    &hdev->dev_flags);
+	}
 
 	send_settings_rsp(cmd->sk, MGMT_OP_SET_CONNECTABLE, hdev);
 
-	if (changed) {
+	if (conn_changed || discov_changed) {
 		new_settings(hdev, cmd->sk);
+		if (discov_changed)
+			mgmt_update_adv_data(hdev);
 		hci_update_background_scan(hdev);
 	}
 
@@ -6031,43 +6049,6 @@ void mgmt_discoverable_timeout(struct hci_dev *hdev)
 	hci_dev_unlock(hdev);
 }
 
-void mgmt_discoverable(struct hci_dev *hdev, u8 discoverable)
-{
-	bool changed;
-
-	/* Nothing needed here if there's a pending command since that
-	 * commands request completion callback takes care of everything
-	 * necessary.
-	 */
-	if (mgmt_pending_find(MGMT_OP_SET_DISCOVERABLE, hdev))
-		return;
-
-	/* Powering off may clear the scan mode - don't let that interfere */
-	if (!discoverable && mgmt_pending_find(MGMT_OP_SET_POWERED, hdev))
-		return;
-
-	if (discoverable) {
-		changed = !test_and_set_bit(HCI_DISCOVERABLE, &hdev->dev_flags);
-	} else {
-		clear_bit(HCI_LIMITED_DISCOVERABLE, &hdev->dev_flags);
-		changed = test_and_clear_bit(HCI_DISCOVERABLE, &hdev->dev_flags);
-	}
-
-	if (changed) {
-		struct hci_request req;
-
-		/* In case this change in discoverable was triggered by
-		 * a disabling of connectable there could be a need to
-		 * update the advertising flags.
-		 */
-		hci_req_init(&req, hdev);
-		update_adv_data(&req);
-		hci_req_run(&req, NULL);
-
-		new_settings(hdev, NULL);
-	}
-}
-
 void mgmt_write_scan_failed(struct hci_dev *hdev, u8 scan, u8 status)
 {
 	u8 mgmt_err = mgmt_status(status);
-- 
1.9.3

