Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <johan.hedberg@gmail.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v4 02/10] emulator: Add inquiry cancel
Date: Thu, 20 Mar 2014 10:49:24 +0100
Message-ID: <1395308972-4320-3-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1395308972-4320-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1395308972-4320-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With this patch, scheduled inquiry session in btdev can be canceled
---
 emulator/btdev.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index d0292a6..125ed35 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -791,10 +791,14 @@ static bool inquiry_callback(void *user_data)
 static void inquiry_destroy(void *user_data)
 {
 	struct inquiry_data *data = user_data;
+	struct btdev *btdev = data->btdev;
+
+	if (!btdev)
+		goto finish;
 
-	if (data->btdev)
-		data->btdev->inquiry_id = 0;
+	btdev->inquiry_id = 0;
 
+finish:
 	free(data);
 }
 
@@ -828,6 +832,24 @@ failed:
 	send_event(btdev, BT_HCI_EVT_INQUIRY_COMPLETE, &ic, sizeof(ic));
 }
 
+static void inquiry_cancel(struct btdev *btdev)
+{
+	uint8_t status = BT_HCI_ERR_COMMAND_DISALLOWED;
+
+	if (btdev->inquiry_id <= 0) {
+		cmd_complete(btdev, BT_HCI_CMD_INQUIRY_CANCEL, &status,
+							sizeof(status));
+		return;
+	}
+
+	timeout_remove(btdev->inquiry_id);
+	btdev->inquiry_id = 0;
+
+	status = BT_HCI_ERR_SUCCESS;
+	cmd_complete(btdev, BT_HCI_CMD_INQUIRY_CANCEL, &status,
+							sizeof(status));
+}
+
 static void conn_complete(struct btdev *btdev,
 					const uint8_t *bdaddr, uint8_t status)
 {
@@ -1760,8 +1782,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
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

