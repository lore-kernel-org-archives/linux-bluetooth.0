Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <johan.hedberg@gmail.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v3 03/10] emulator: Add handling inquiry number of responses
Date: Mon, 17 Mar 2014 10:37:36 +0100
Message-ID: <1395049064-9751-4-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1395049064-9751-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1395049064-9751-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 emulator/btdev.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 22ce7c5..0b82e2c 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -136,6 +136,8 @@ struct btdev {
 
 struct inquiry_data {
 	struct btdev *btdev;
+	int num_resp;
+
 	int sent_count;
 	int iter;
 };
@@ -710,6 +712,7 @@ static bool inquiry_callback(void *user_data)
 {
 	struct inquiry_data *data = user_data;
 	struct btdev *btdev = data->btdev;
+	struct bt_hci_evt_inquiry_complete ic;
 	int sent = data->sent_count;
 	int i;
 
@@ -776,17 +779,21 @@ static bool inquiry_callback(void *user_data)
 
 	data->iter = i;
 
+	/* Check if we sent already required amount of responses*/
+	if (data->num_resp && data->sent_count == data->num_resp)
+		goto finish;
 
-	if (i == MAX_BTDEV_ENTRIES) {
-		struct bt_hci_evt_inquiry_complete ic;
+	if (i == MAX_BTDEV_ENTRIES)
+		goto finish;
 
-		ic.status = BT_HCI_ERR_SUCCESS;
-		send_event(btdev, BT_HCI_EVT_INQUIRY_COMPLETE, &ic, sizeof(ic));
+	return true;
 
-		return false;
-	}
+finish:
+	/* Note that destroy will be called */
+	ic.status = BT_HCI_ERR_SUCCESS;
+	send_event(btdev, BT_HCI_EVT_INQUIRY_COMPLETE, &ic, sizeof(ic));
 
-	return true;
+	return false;
 }
 
 static void inquiry_destroy(void *user_data)
@@ -805,6 +812,7 @@ finish:
 
 static void inquiry_cmd(struct btdev *btdev, const void *cmd)
 {
+	const struct bt_hci_cmd_inquiry *inq_cmd = cmd;
 	struct inquiry_data *data;
 	struct bt_hci_evt_inquiry_complete ic;
 	int status = BT_HCI_ERR_HARDWARE_FAILURE;
@@ -820,6 +828,7 @@ static void inquiry_cmd(struct btdev *btdev, const void *cmd)
 
 	memset(data, 0, sizeof(*data));
 	data->btdev = btdev;
+	data->num_resp = inq_cmd->num_resp;
 
 	btdev->inquiry_id = timeout_add(DEFAULT_INQUIRY_INTERVAL,
 							inquiry_callback, data,
-- 
1.8.4

