Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 08/17] emulator: Add inquiry cancel
Date: Wed, 26 Feb 2014 02:57:19 +0100
Message-ID: <1393379848-4031-9-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1393379848-4031-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1393379848-4031-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 emulator/btdev.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 18f7410..722c312 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -70,6 +70,7 @@ struct btdev {
 	void *send_data;
 
 	int inquiry_id;
+	bool inquiry_cancel;
 
 	struct hook *hook_list[MAX_HOOK_ENTRIES];
 
@@ -789,10 +790,20 @@ static bool inquiry_callback(void *user_data)
 static void inquiry_destroy(void *user_data)
 {
 	struct inquiry_data *data = user_data;
+	struct btdev *btdev = data->btdev;
+	uint8_t status = BT_HCI_ERR_SUCCESS;
+
+	if (!btdev)
+		goto finish;
+
+	if (btdev->inquiry_cancel)
+		cmd_complete(btdev, BT_HCI_CMD_INQUIRY_CANCEL, &status,
+							sizeof(status));
 
-	if (data->btdev)
-		data->btdev->inquiry_id = 0;
+	btdev->inquiry_cancel = false;
+	btdev->inquiry_id = 0;
 
+finish:
 	free(data);
 }
 
@@ -822,6 +833,19 @@ error:
 	send_event(btdev, BT_HCI_EVT_INQUIRY_COMPLETE, &ic, sizeof(ic));
 }
 
+static void inquiry_cancel(struct btdev *btdev)
+{
+	uint8_t status = BT_HCI_ERR_COMMAND_DISALLOWED;
+
+	if (btdev->inquiry_id) {
+		btdev->inquiry_cancel = true;
+		timeout_remove(btdev->inquiry_id);
+		btdev->inquiry_id = 0;
+		return;
+	}
+
+	cmd_complete(btdev, BT_HCI_CMD_INQUIRY_CANCEL, &status, sizeof(status));
+}
 static void conn_complete(struct btdev *btdev,
 					const uint8_t *bdaddr, uint8_t status)
 {
@@ -1638,8 +1662,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
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

