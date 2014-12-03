Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 07/49] Bluetooth: Use custom macro for testing BR/EDR SC enabled
Date: Wed,  3 Dec 2014 17:02:01 +0200
Message-Id: <1417618963-18010-8-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
References: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Since the HCI_SC_ENABLED flag will also be used for controllers without
BR/EDR Secure Connections support whenever we need to check specifically
for SC for BR/EDR we also need to check that the controller actually
supports it. This patch adds a convenience macro for check all the
necessary conditions and converts the places in the code that need it to
use it.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h | 3 +++
 net/bluetooth/hci_core.c         | 4 +---
 net/bluetooth/hci_event.c        | 2 +-
 net/bluetooth/mgmt.c             | 5 ++---
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 396c09840fdf..7f08ea36d246 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -999,6 +999,9 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 
 #define hdev_is_powered(hdev) (test_bit(HCI_UP, &hdev->flags) && \
 				!test_bit(HCI_AUTO_OFF, &hdev->dev_flags))
+#define bredr_sc_enabled(dev) ((lmp_sc_capable(dev) || \
+				test_bit(HCI_FORCE_SC, &(dev)->dbg_flags)) && \
+			       test_bit(HCI_SC_ENABLED, &(dev)->dev_flags))
 
 /* ----- HCI protocols ----- */
 #define HCI_PROTO_DEFER             0x01
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 5c319a49a5a4..2586e405adb3 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1734,9 +1734,7 @@ static void hci_init4_req(struct hci_request *req, unsigned long opt)
 		hci_req_add(req, HCI_OP_READ_SYNC_TRAIN_PARAMS, 0, NULL);
 
 	/* Enable Secure Connections if supported and configured */
-	if ((lmp_sc_capable(hdev) ||
-	     test_bit(HCI_FORCE_SC, &hdev->dbg_flags)) &&
-	    test_bit(HCI_SC_ENABLED, &hdev->dev_flags)) {
+	if (bredr_sc_enabled(hdev)) {
 		u8 support = 0x01;
 		hci_req_add(req, HCI_OP_WRITE_SC_SUPPORT,
 			    sizeof(support), &support);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index d76d4f821189..f980fc46ea5e 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4027,7 +4027,7 @@ static void hci_remote_oob_data_request_evt(struct hci_dev *hdev,
 
 	data = hci_find_remote_oob_data(hdev, &ev->bdaddr);
 	if (data) {
-		if (test_bit(HCI_SC_ENABLED, &hdev->dev_flags)) {
+		if (bredr_sc_enabled(hdev)) {
 			struct hci_cp_remote_oob_ext_data_reply cp;
 
 			bacpy(&cp.bdaddr, &ev->bdaddr);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 7974a39a42d9..868769543d83 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3562,7 +3562,7 @@ static int read_local_oob_data(struct sock *sk, struct hci_dev *hdev,
 		goto unlock;
 	}
 
-	if (test_bit(HCI_SC_ENABLED, &hdev->dev_flags))
+	if (bredr_sc_enabled(hdev))
 		err = hci_send_cmd(hdev, HCI_OP_READ_LOCAL_OOB_EXT_DATA,
 				   0, NULL);
 	else
@@ -6803,8 +6803,7 @@ void mgmt_read_local_oob_data_complete(struct hci_dev *hdev, u8 *hash192,
 		cmd_status(cmd->sk, hdev->id, MGMT_OP_READ_LOCAL_OOB_DATA,
 			   mgmt_status(status));
 	} else {
-		if (test_bit(HCI_SC_ENABLED, &hdev->dev_flags) &&
-		    hash256 && rand256) {
+		if (bredr_sc_enabled(hdev) && hash256 && rand256) {
 			struct mgmt_rp_read_local_oob_ext_data rp;
 
 			memcpy(rp.hash192, hash192, sizeof(rp.hash192));
-- 
2.1.0

