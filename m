Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <johan.hedberg@gmail.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v3 04/10] emulator: Add handling inquiry_lenght from inquiry command
Date: Mon, 17 Mar 2014 10:37:37 +0100
Message-ID: <1395049064-9751-5-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1395049064-9751-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1395049064-9751-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With this patch, btdev is taking into accoung inquiry_lenght from hci
inquiry command.
Inquiry session will last that long unless number of devices parameter
has been provided different then 0
---
 emulator/btdev.c | 45 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 0b82e2c..b2102a6 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -70,6 +70,7 @@ struct btdev {
 	void *send_data;
 
 	int inquiry_id;
+	int inquiry_timeout_id;
 
 	struct hook *hook_list[MAX_HOOK_ENTRIES];
 
@@ -140,6 +141,8 @@ struct inquiry_data {
 
 	int sent_count;
 	int iter;
+
+	bool timeout;
 };
 
 #define DEFAULT_INQUIRY_INTERVAL 100 /* 100 miliseconds */
@@ -549,7 +552,7 @@ void btdev_destroy(struct btdev *btdev)
 	if (!btdev)
 		return;
 
-	if (btdev->inquiry_id)
+	if (btdev->inquiry_id > 0)
 		timeout_remove(btdev->inquiry_id);
 
 	del_btdev(btdev);
@@ -716,6 +719,10 @@ static bool inquiry_callback(void *user_data)
 	int sent = data->sent_count;
 	int i;
 
+	/*Report devices only once and wait for inquiry timeout*/
+	if (data->iter == MAX_BTDEV_ENTRIES)
+		return true;
+
 	for (i = data->iter; i < MAX_BTDEV_ENTRIES; i++) {
 		/*Lets sent 10 inquiry results at once */
 		if (sent + 10 == data->sent_count)
@@ -776,16 +783,12 @@ static bool inquiry_callback(void *user_data)
 			data->sent_count++;
 		}
 	}
-
 	data->iter = i;
 
 	/* Check if we sent already required amount of responses*/
 	if (data->num_resp && data->sent_count == data->num_resp)
 		goto finish;
 
-	if (i == MAX_BTDEV_ENTRIES)
-		goto finish;
-
 	return true;
 
 finish:
@@ -806,16 +809,38 @@ static void inquiry_destroy(void *user_data)
 
 	btdev->inquiry_id = 0;
 
+	if (btdev->inquiry_timeout_id)
+		timeout_remove(btdev->inquiry_timeout_id);
+
+	btdev->inquiry_timeout_id = 0;
+
 finish:
 	free(data);
 }
 
+static bool inquiry_timeout(void *user_data)
+{
+	struct inquiry_data *data = user_data;
+	struct btdev *btdev = data->btdev;
+	struct bt_hci_evt_inquiry_complete ic;
+
+	timeout_remove(btdev->inquiry_id);
+	btdev->inquiry_timeout_id = 0;
+
+	/* Inquiry is stopped, send Inquiry complete event. */
+	ic.status = BT_HCI_ERR_SUCCESS;
+	send_event(btdev, BT_HCI_EVT_INQUIRY_COMPLETE, &ic, sizeof(ic));
+
+	return false;
+}
+
 static void inquiry_cmd(struct btdev *btdev, const void *cmd)
 {
 	const struct bt_hci_cmd_inquiry *inq_cmd = cmd;
 	struct inquiry_data *data;
 	struct bt_hci_evt_inquiry_complete ic;
 	int status = BT_HCI_ERR_HARDWARE_FAILURE;
+	unsigned int inquiry_len_ms;
 
 	if (btdev->inquiry_id > 0) {
 		status = BT_HCI_ERR_COMMAND_DISALLOWED;
@@ -830,6 +855,13 @@ static void inquiry_cmd(struct btdev *btdev, const void *cmd)
 	data->btdev = btdev;
 	data->num_resp = inq_cmd->num_resp;
 
+	/* Add timeout to cancel inquiry */
+	inquiry_len_ms = 1280 * inq_cmd->length;
+	if (inquiry_len_ms)
+		btdev->inquiry_timeout_id = timeout_add(inquiry_len_ms,
+							inquiry_timeout,
+								data, NULL);
+
 	btdev->inquiry_id = timeout_add(DEFAULT_INQUIRY_INTERVAL,
 							inquiry_callback, data,
 							inquiry_destroy);
@@ -852,6 +884,8 @@ static void inquiry_cancel(struct btdev *btdev)
 		return;
 	}
 
+	timeout_remove(btdev->inquiry_timeout_id);
+	btdev->inquiry_timeout_id = 0;
 
 	timeout_remove(btdev->inquiry_id);
 	btdev->inquiry_id = 0;
@@ -860,6 +894,7 @@ static void inquiry_cancel(struct btdev *btdev)
 	cmd_complete(btdev, BT_HCI_CMD_INQUIRY_CANCEL, &status,
 							sizeof(status));
 }
+
 static void conn_complete(struct btdev *btdev,
 					const uint8_t *bdaddr, uint8_t status)
 {
-- 
1.8.4

