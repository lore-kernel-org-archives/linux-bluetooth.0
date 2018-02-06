Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Tedd Ho-Jeong An <tedd.an@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Tedd Ho Jeong An <tedd.an@intel.com>
Subject: [PATCH BlueZ 1/2] tester: Set event mask for LE Read Local P-256 PK Complete event
Date: Tue,  6 Feb 2018 13:03:56 -0800
Message-Id: <1517951037-2970-1-git-send-email-tedd.an@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho Jeong An <tedd.an@intel.com>

LE Read Local P-256 PK command fails because LE Read Local P-256 PK
Complete event and LE Meta event are disabled by default.
This patch sets event masks for LE Read Local P-256 PK Complete and
LE Meta Event to receive the events for 'LE Read Local PK' test and
'LE Generate DHKey' test.
---
 tools/hci-tester.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/hci-tester.c b/tools/hci-tester.c
index e900789..1e9ce4e 100644
--- a/tools/hci-tester.c
+++ b/tools/hci-tester.c
@@ -460,11 +460,27 @@ static void test_le_read_local_pk_status(const void *data, uint8_t size,
 static void test_le_read_local_pk(const void *test_data)
 {
 	struct user_data *user = tester_get_data();
+	struct bt_hci_cmd_set_event_mask sem;
+	struct bt_hci_cmd_le_set_event_mask lsem;
 
 	bt_hci_register(user->hci_ut, BT_HCI_EVT_LE_META_EVENT,
 				test_le_read_local_pk_complete,
 				(void *)test_data, NULL);
 
+	memset(sem.mask, 0, 8);
+	sem.mask[1] |= 0x20;	/* Command Complete */
+	sem.mask[1] |= 0x40;	/* Command Status */
+	sem.mask[7] |= 0x20;	/* LE Meta */
+
+	bt_hci_send(user->hci_ut, BT_HCI_CMD_SET_EVENT_MASK,
+					&sem, sizeof(sem), NULL, NULL, NULL);
+
+	memset(lsem.mask, 0, 8);
+	lsem.mask[0] |= 0x80;	/* LE Read Local P-256 Public Key Complete */
+
+	bt_hci_send(user->hci_ut, BT_HCI_CMD_LE_SET_EVENT_MASK,
+					&lsem, sizeof(lsem), NULL, NULL, NULL);
+
 	if (!bt_hci_send(user->hci_ut, BT_HCI_CMD_LE_READ_LOCAL_PK256, NULL,
 				0, test_le_read_local_pk_status,
 				NULL, NULL)) {
@@ -517,11 +533,27 @@ static void setup_le_read_local_pk_status(const void *data, uint8_t size,
 static void setup_le_generate_dhkey(const void *test_data)
 {
 	struct user_data *user = tester_get_data();
+	struct bt_hci_cmd_set_event_mask sem;
+	struct bt_hci_cmd_le_set_event_mask lsem;
 
 	bt_hci_register(user->hci_ut, BT_HCI_EVT_LE_META_EVENT,
 				setup_le_read_local_pk_complete,
 				(void *)test_data, NULL);
 
+	memset(sem.mask, 0, 8);
+	sem.mask[1] |= 0x20;	/* Command Complete */
+	sem.mask[1] |= 0x40;	/* Command Status */
+	sem.mask[7] |= 0x20;	/* LE Meta */
+
+	bt_hci_send(user->hci_ut, BT_HCI_CMD_SET_EVENT_MASK,
+					&sem, sizeof(sem), NULL, NULL, NULL);
+
+	memset(lsem.mask, 0, 8);
+	lsem.mask[0] |= 0x80;	/* LE Read Local P-256 Public Key Complete */
+
+	bt_hci_send(user->hci_ut, BT_HCI_CMD_LE_SET_EVENT_MASK,
+					&lsem, sizeof(lsem), NULL, NULL, NULL);
+
 	if (!bt_hci_send(user->hci_ut, BT_HCI_CMD_LE_READ_LOCAL_PK256, NULL,
 				0, setup_le_read_local_pk_status,
 				NULL, NULL)) {
-- 
2.7.4

