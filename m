Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 19/26] Bluetooth: Refactor fast connectable HCI commands
Date: Wed, 13 Mar 2013 11:12:10 -0700
Message-Id: <1363198337-3896-20-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1363198337-3896-1-git-send-email-johan.hedberg@gmail.com>
References: <1363198337-3896-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch refactors the fast connectable HCI commands into their own
HCI function. This is necessary so that the same function can be reused
fo the fast connectable change required by disabling the connectable
setting.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |   43 ++++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index b6a33c5..f03b10c 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1000,6 +1000,29 @@ failed:
 	return err;
 }
 
+static void write_fast_connectable(struct hci_request *req, bool enable)
+{
+	struct hci_cp_write_page_scan_activity acp;
+	u8 type;
+
+	if (enable) {
+		type = PAGE_SCAN_TYPE_INTERLACED;
+
+		/* 160 msec page scan interval */
+		acp.interval = __constant_cpu_to_le16(0x0100);
+	} else {
+		type = PAGE_SCAN_TYPE_STANDARD;	/* default */
+
+		/* default 1.28 sec page scan */
+		acp.interval = __constant_cpu_to_le16(0x0800);
+	}
+
+	acp.window = __constant_cpu_to_le16(0x0012);
+
+	hci_req_add(req, HCI_OP_WRITE_PAGE_SCAN_ACTIVITY, sizeof(acp), &acp);
+	hci_req_add(req, HCI_OP_WRITE_PAGE_SCAN_TYPE, 1, &type);
+}
+
 static void set_connectable_complete(struct hci_dev *hdev, u8 status)
 {
 	struct pending_cmd *cmd;
@@ -2937,10 +2960,8 @@ static int set_fast_connectable(struct sock *sk, struct hci_dev *hdev,
 				void *data, u16 len)
 {
 	struct mgmt_mode *cp = data;
-	struct hci_cp_write_page_scan_activity acp;
 	struct pending_cmd *cmd;
 	struct hci_request req;
-	u8 type;
 	int err;
 
 	BT_DBG("%s", hdev->name);
@@ -2975,21 +2996,6 @@ static int set_fast_connectable(struct sock *sk, struct hci_dev *hdev,
 		goto unlock;
 	}
 
-	if (cp->val) {
-		type = PAGE_SCAN_TYPE_INTERLACED;
-
-		/* 160 msec page scan interval */
-		acp.interval = __constant_cpu_to_le16(0x0100);
-	} else {
-		type = PAGE_SCAN_TYPE_STANDARD;	/* default */
-
-		/* default 1.28 sec page scan */
-		acp.interval = __constant_cpu_to_le16(0x0800);
-	}
-
-	/* default 11.25 msec page scan window */
-	acp.window = __constant_cpu_to_le16(0x0012);
-
 	cmd = mgmt_pending_add(sk, MGMT_OP_SET_FAST_CONNECTABLE, hdev,
 			       data, len);
 	if (!cmd) {
@@ -2999,8 +3005,7 @@ static int set_fast_connectable(struct sock *sk, struct hci_dev *hdev,
 
 	hci_req_init(&req, hdev);
 
-	hci_req_add(&req, HCI_OP_WRITE_PAGE_SCAN_ACTIVITY, sizeof(acp), &acp);
-	hci_req_add(&req, HCI_OP_WRITE_PAGE_SCAN_TYPE, 1, &type);
+	write_fast_connectable(&req, cp->val);
 
 	err = hci_req_run(&req, fast_connectable_complete);
 	if (err < 0) {
-- 
1.7.10.4

