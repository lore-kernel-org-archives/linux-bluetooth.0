Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 05/10] emulator: Add handling inquiry_lenght from inquiry command
Date: Mon, 10 Mar 2014 00:05:58 +0100
Message-ID: <1394406363-6751-6-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1394406363-6751-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1394406363-6751-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With this patch, btdev is taking into accoung inquiry_lenght from hci
inquiry command.
Inquiry session will last that long unless number of devices parameter
has been provided different then 0
---
 emulator/btdev.c | 46 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 42 insertions(+), 4 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index c932a18..27bbb08 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -70,6 +70,7 @@ struct btdev {
 	void *send_data;
 
 	int inquiry_id;
+	int inquiry_timeout_id;
 	bool inquiry_cancel;
 
 	struct hook *hook_list[MAX_HOOK_ENTRIES];
@@ -133,6 +134,8 @@ struct inquiry_data {
 
 	int sent_count;
 	int iter;
+
+	bool timeout;
 };
 
 #define DEFAULT_INQUIRY_INTERVAL 100 /* 100 miliseconds */
@@ -711,6 +714,14 @@ static bool inquiry_callback(void *user_data)
 	int sent = data->sent_count;
 	int i;
 
+	/* Check if inquiry timeout fired. */
+	if (data->timeout)
+		goto finish;
+
+	/*Report devices only once and wait for inquiry timeout*/
+	if (data->iter == MAX_BTDEV_ENTRIES)
+		return true;
+
 	for (i = data->iter; i < MAX_BTDEV_ENTRIES; i++, data->iter++) {
 		/*Lets sent 10 inquiry results at once */
 		if (sent + 10 == data->sent_count)
@@ -771,14 +782,10 @@ static bool inquiry_callback(void *user_data)
 			data->sent_count++;
 		}
 	}
-
 	/* Check if we sent already required amount of responses*/
 	if (data->num_resp && data->sent_count == data->num_resp)
 		goto finish;
 
-	if (i == MAX_BTDEV_ENTRIES)
-		goto finish;
-
 	return true;
 
 finish:
@@ -806,16 +813,33 @@ static void inquiry_destroy(void *user_data)
 	btdev->inquiry_cancel = false;
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
+
+	data->timeout = true;
+	btdev->inquiry_timeout_id = 0;
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
 
 	if (btdev->inquiry_id) {
 		status = BT_HCI_ERR_COMMAND_DISALLOWED;
@@ -830,6 +854,13 @@ static void inquiry_cmd(struct btdev *btdev, const void *cmd)
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
 				inquiry_callback, data, inquiry_destroy);
 	/* Return if success */
@@ -852,9 +883,16 @@ static void inquiry_cancel(struct btdev *btdev)
 	}
 
 	btdev->inquiry_cancel = true;
+
+	if (btdev->inquiry_timeout_id)
+		timeout_remove(btdev->inquiry_timeout_id);
+
+	btdev->inquiry_timeout_id = 0;
+
 	timeout_remove(btdev->inquiry_id);
 	btdev->inquiry_id = 0;
 }
+
 static void conn_complete(struct btdev *btdev,
 					const uint8_t *bdaddr, uint8_t status)
 {
-- 
1.8.4

