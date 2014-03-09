Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 03/10] emulator: Add inquiry cancel
Date: Mon, 10 Mar 2014 00:05:56 +0100
Message-ID: <1394406363-6751-4-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1394406363-6751-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1394406363-6751-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With this patch, scheduled inquiry session in btdev can be canceled

Conflicts:
	emulator/btdev.c
---
 emulator/btdev.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 8b3a2d8..3c0b0ad 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -70,6 +70,7 @@ struct btdev {
 	void *send_data;
 
 	int inquiry_id;
+	bool inquiry_cancel;
 
 	struct hook *hook_list[MAX_HOOK_ENTRIES];
 
@@ -784,10 +785,20 @@ static bool inquiry_callback(void *user_data)
 static void inquiry_destroy(void *user_data)
 {
 	struct inquiry_data *data = user_data;
+	struct btdev *btdev = data->btdev;
+	uint8_t status = BT_HCI_ERR_SUCCESS;
+
+	if (!btdev)
+		goto finish;
 
-	if (data->btdev)
-		data->btdev->inquiry_id = 0;
+	if (btdev->inquiry_cancel)
+		cmd_complete(btdev, BT_HCI_CMD_INQUIRY_CANCEL, &status,
+							sizeof(status));
 
+	btdev->inquiry_cancel = false;
+	btdev->inquiry_id = 0;
+
+finish:
 	free(data);
 }
 
@@ -820,6 +831,20 @@ error:
 	send_event(btdev, BT_HCI_EVT_INQUIRY_COMPLETE, &ic, sizeof(ic));
 }
 
+static void inquiry_cancel(struct btdev *btdev)
+{
+	uint8_t status = BT_HCI_ERR_COMMAND_DISALLOWED;
+
+	if (!btdev->inquiry_id) {
+		cmd_complete(btdev, BT_HCI_CMD_INQUIRY_CANCEL, &status,
+							sizeof(status));
+		return;
+	}
+
+	btdev->inquiry_cancel = true;
+	timeout_remove(btdev->inquiry_id);
+	btdev->inquiry_id = 0;
+}
 static void conn_complete(struct btdev *btdev,
 					const uint8_t *bdaddr, uint8_t status)
 {
@@ -1637,8 +1662,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 	case BT_HCI_CMD_INQUIRY_CANCEL:
 		if (btdev->type == BTDEV_TYPE_LE)
 			goto unsupported;
-		status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &status, sizeof(status));
+		inquiry_cancel(btdev);
 		break;
 
 	case BT_HCI_CMD_CREATE_CONN:
-- 
1.8.4

