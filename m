Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH  2/2] emulator/le: Add LE test commands
Date: Thu, 04 Jun 2015 15:56:08 +0530
Message-id: <1433413568-26382-2-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1433413568-26382-1-git-send-email-gowtham.ab@samsung.com>
References: <1433413568-26382-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 emulator/le.c | 45 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 42 insertions(+), 3 deletions(-)

diff --git a/emulator/le.c b/emulator/le.c
index dc51469..7f852a9 100644
--- a/emulator/le.c
+++ b/emulator/le.c
@@ -258,9 +258,9 @@ static void reset_defaults(struct bt_le *hci)
 	//hci->commands[28] |= 0x02;	/* LE Long Term Key Request Reply */
 	//hci->commands[28] |= 0x04;	/* LE Long Term Key Request Negative Reply */
 	hci->commands[28] |= 0x08;	/* LE Read Supported States */
-	//hci->commands[28] |= 0x10;	/* LE Receiver Test */
-	//hci->commands[28] |= 0x20;	/* LE Transmitter Test */
-	//hci->commands[28] |= 0x40;	/* LE Test End */
+	hci->commands[28] |= 0x10;	/* LE Receiver Test */
+	hci->commands[28] |= 0x20;	/* LE Transmitter Test */
+	hci->commands[28] |= 0x40;	/* LE Test End */
 	//hci->commands[33] |= 0x10;	/* LE Remote Connection Parameter Request Reply */
 	//hci->commands[33] |= 0x20;	/* LE Remote Connection Parameter Request Negative Reply */
 	hci->commands[33] |= 0x40;	/* LE Set Data Length */
@@ -1218,6 +1218,36 @@ static void cmd_le_read_supported_states(struct bt_le *hci,
 							&rsp, sizeof(rsp));
 }
 
+static void cmd_le_receiver_test(struct bt_le *hci,
+						const void *data, uint8_t size)
+{
+	uint8_t status;
+
+	status = BT_HCI_ERR_SUCCESS;
+	cmd_complete(hci, BT_HCI_CMD_LE_RECEIVER_TEST,
+					&status, sizeof(status));
+}
+
+static void cmd_le_transmitter_test(struct bt_le *hci,
+						const void *data, uint8_t size)
+{
+	uint8_t status;
+
+	status = BT_HCI_ERR_SUCCESS;
+	cmd_complete(hci, BT_HCI_CMD_LE_TRANSMITTER_TEST,
+					&status, sizeof(status));
+}
+
+static void cmd_le_end_test(struct bt_le *hci, const void *data, uint8_t size)
+{
+	struct bt_hci_rsp_le_test_end lte;
+
+	lte.status = BT_HCI_ERR_SUCCESS;
+	lte.num_packets = 0;
+
+	cmd_complete(hci, BT_HCI_CMD_LE_TEST_END, &lte, sizeof(lte));
+}
+
 static void cmd_le_set_data_length(struct bt_le *hci,
 						const void *data, uint8_t size)
 {
@@ -1611,6 +1641,15 @@ static const struct {
 	{ BT_HCI_CMD_LE_READ_SUPPORTED_STATES,
 				cmd_le_read_supported_states, 0, true },
 
+	{ BT_HCI_CMD_LE_RECEIVER_TEST,
+				cmd_le_receiver_test, 1, true },
+
+	{ BT_HCI_CMD_LE_TRANSMITTER_TEST,
+				cmd_le_transmitter_test, 3, true },
+
+	{ BT_HCI_CMD_LE_TEST_END,
+				cmd_le_end_test, 0, true },
+
 	{ BT_HCI_CMD_LE_SET_DATA_LENGTH,
 				cmd_le_set_data_length, 6, true },
 	{ BT_HCI_CMD_LE_READ_DEFAULT_DATA_LENGTH,
-- 
1.9.1

