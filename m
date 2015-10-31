Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH 2/2] Bluetooth: fix connect race condition
Date: Fri, 30 Oct 2015 20:47:41 -0700
Message-Id: <1446263261-1549-2-git-send-email-jpawlowski@google.com>
In-Reply-To: <1446263261-1549-1-git-send-email-jpawlowski@google.com>
References: <1446263261-1549-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Right now, when calling Device1.Connect() on two LE devices using RPA
at same time, second call to Connect() will fail every few times. It is
due to race condition inside kernel, that happens when adding devices to
whitelist. This patch fixes that.

Each time device is added to whitelist, __hci_update_background_scan will
be called. Scan state will be checked, and two commands will be scheduled,
but not executed yet: LE_SET_SCAN_PARAM and LE_SET_SCAN_ENABLE. Then
during execution time, if those commands were scheduled twice, first two
commands will succeed, but later two will fail, because LE_SET_SCAN_PARAM
must be executed when scan is disabled, and fist two commands left it
enabled.

In order to solve that, HCI_OP_VIRT_LE_SCAN_DISABLE must be used. It'll
check the scan state at the runtime, instead of schedule time, and will
stop the scan if necessary.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 net/bluetooth/hci_request.c | 22 ++++++++++++++++------
 net/bluetooth/mgmt.c        |  1 -
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 981f8a2..9a5c41c 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -150,6 +150,19 @@ void hci_req_add_le_scan_disable(struct hci_request *req)
 	hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
 }
 
+void hci_req_add_virt_le_scan_disable(struct hci_request *req)
+{
+	struct hci_cp_le_set_scan_enable cp;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.enable = LE_SCAN_DISABLE;
+
+	/* Instead of sending real scan disable packet, send virtual one,
+	 * that will check and stop scan at time of running command.
+	 */
+	hci_req_add(req, HCI_OP_VIRT_LE_SCAN_DISABLE, sizeof(cp), &cp);
+}
+
 static void add_to_white_list(struct hci_request *req,
 			      struct hci_conn_params *params)
 {
@@ -258,6 +271,9 @@ void hci_req_add_le_passive_scan(struct hci_request *req)
 	u8 own_addr_type;
 	u8 filter_policy;
 
+	/* HCI_OP_LE_SET_SCAN_PARAM must be run when scan is disabled. */
+	hci_req_add_virt_le_scan_disable(req);
+
 	/* Set require_privacy to false since no SCAN_REQ are send
 	 * during passive scanning. Not using an non-resolvable address
 	 * here is important so that peer devices using direct
@@ -531,12 +547,6 @@ void __hci_update_background_scan(struct hci_request *req)
 		if (hci_lookup_le_connect(hdev))
 			return;
 
-		/* If controller is currently scanning, we stop it to ensure we
-		 * don't miss any advertising (due to duplicates filter).
-		 */
-		if (hci_dev_test_flag(hdev, HCI_LE_SCAN))
-			hci_req_add_le_scan_disable(req);
-
 		hci_req_add_le_passive_scan(req);
 
 		BT_DBG("%s starting background scanning", hdev->name);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 7f22119..89efb31 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5045,7 +5045,6 @@ static int set_scan_params(struct sock *sk, struct hci_dev *hdev,
 
 		hci_req_init(&req, hdev);
 
-		hci_req_add_le_scan_disable(&req);
 		hci_req_add_le_passive_scan(&req);
 
 		hci_req_run(&req, NULL);
-- 
2.5.0

