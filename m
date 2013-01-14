Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] Bluetooth: Fix write_scan_enable when HCI_AUTO_OFF is set
Date: Mon, 14 Jan 2013 22:33:53 +0200
Message-Id: <1358195633-29303-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1358195633-29303-1-git-send-email-johan.hedberg@gmail.com>
References: <1358195633-29303-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When the HCI_AUTO_OFF flag is set the HCI device has been powered on
automatically by the kernel but through the mgmt interface it looks like
its powered off (and requires an explicit mgmt_set_powered to be
considered powered on). However, since the mgmt interface accepts
commands such as set_discoverable and set_connectable when powered off
there's no reason to avoid sending HCI commands in this state.

The hdev_is_powered() macro checks for both HCI_UP and HCI_AUTO_OFF and
is usable for mgmt commands that should fail (return NOT_POWERED) when
powered off, however for commands that should succeed testing only for
HCI_UP makes more sense.

Since the power_off delayed work is active when HCI_AUTO_OFF is set, and
can be triggered at any moment, it's also important to modify the expiry
time with mod_delayed_work() to ensure that the HCI commands are safely
completed.

The added benefit of doing these commands before an explicit
mgmt_set_powered call is that HCI commands sent in the mgmt_powered
function do not have the same kind of tracking as those triggered by a
directly related mgmt command and can therefore cause race conditions
(when e.g. set_discoverable is called quickly after calling
set_powered).

Since mgmt_powered() no longer takes care of the write_scan_enable we
also need to ensure that it's part of the hci_setup procedure and hence
the set_bredr_scan() function needs to be moved into hci_core.c from
mgmt.c.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c |   17 +++++++++++++++++
 net/bluetooth/mgmt.c      |   28 ++++++++++------------------
 2 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 705078a..aaa18bd 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -573,6 +573,21 @@ static void hci_setup_event_mask(struct hci_dev *hdev)
 	}
 }
 
+static int set_bredr_scan(struct hci_dev *hdev)
+{
+	u8 scan = 0;
+
+	if (test_bit(HCI_CONNECTABLE, &hdev->dev_flags))
+		scan |= SCAN_PAGE;
+	if (test_bit(HCI_DISCOVERABLE, &hdev->dev_flags))
+		scan |= SCAN_INQUIRY;
+
+	if (!scan)
+		return 0;
+
+	return hci_send_cmd(hdev, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
+}
+
 static void bredr_setup(struct hci_dev *hdev)
 {
 	struct hci_cp_delete_stored_link_key cp;
@@ -602,6 +617,8 @@ static void bredr_setup(struct hci_dev *hdev)
 	bacpy(&cp.bdaddr, BDADDR_ANY);
 	cp.delete_all = 1;
 	hci_send_cmd(hdev, HCI_OP_DELETE_STORED_LINK_KEY, sizeof(cp), &cp);
+
+	set_bredr_scan(hdev);
 }
 
 static void le_setup(struct hci_dev *hdev)
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index fc171f2..7cc2379 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -907,7 +907,7 @@ static int set_discoverable(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto failed;
 	}
 
-	if (!hdev_is_powered(hdev)) {
+	if (!test_bit(HCI_UP, &hdev->flags)) {
 		bool changed = false;
 
 		if (!!cp->val != test_bit(HCI_DISCOVERABLE, &hdev->dev_flags)) {
@@ -954,6 +954,10 @@ static int set_discoverable(struct sock *sk, struct hci_dev *hdev, void *data,
 	else
 		cancel_delayed_work(&hdev->discov_off);
 
+	if (test_bit(HCI_AUTO_OFF, &hdev->dev_flags))
+		mod_delayed_work(hdev->req_workqueue, &hdev->power_off,
+				 HCI_AUTO_OFF_TIMEOUT);
+
 	err = hci_send_cmd(hdev, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
 	if (err < 0)
 		mgmt_pending_remove(cmd);
@@ -986,7 +990,7 @@ static int set_connectable(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	hci_dev_lock(hdev);
 
-	if (!hdev_is_powered(hdev)) {
+	if (!test_bit(HCI_UP, &hdev->flags)) {
 		bool changed = false;
 
 		if (!!cp->val != test_bit(HCI_CONNECTABLE, &hdev->dev_flags))
@@ -1027,6 +1031,10 @@ static int set_connectable(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto failed;
 	}
 
+	if (test_bit(HCI_AUTO_OFF, &hdev->dev_flags))
+		mod_delayed_work(hdev->req_workqueue, &hdev->power_off,
+				 HCI_AUTO_OFF_TIMEOUT);
+
 	if (cp->val) {
 		scan = SCAN_PAGE;
 	} else {
@@ -2930,21 +2938,6 @@ static void settings_rsp(struct pending_cmd *cmd, void *data)
 	mgmt_pending_free(cmd);
 }
 
-static int set_bredr_scan(struct hci_dev *hdev)
-{
-	u8 scan = 0;
-
-	if (test_bit(HCI_CONNECTABLE, &hdev->dev_flags))
-		scan |= SCAN_PAGE;
-	if (test_bit(HCI_DISCOVERABLE, &hdev->dev_flags))
-		scan |= SCAN_INQUIRY;
-
-	if (!scan)
-		return 0;
-
-	return hci_send_cmd(hdev, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
-}
-
 int mgmt_powered(struct hci_dev *hdev, u8 powered)
 {
 	struct cmd_lookup match = { NULL, hdev };
@@ -2980,7 +2973,6 @@ int mgmt_powered(struct hci_dev *hdev, u8 powered)
 		}
 
 		if (lmp_bredr_capable(hdev)) {
-			set_bredr_scan(hdev);
 			update_class(hdev);
 			update_name(hdev, hdev->dev_name);
 			update_eir(hdev);
-- 
1.7.10.4

