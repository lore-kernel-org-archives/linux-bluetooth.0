Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <johan.hedberg@gmail.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v5 03/10] emulator: Add handling inquiry number of responses
Date: Thu, 20 Mar 2014 12:25:06 +0100
Message-ID: <1395314713-13104-4-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1395314713-13104-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1395314713-13104-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 emulator/btdev.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 5b8cc2f..ea08da6 100644
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
 
@@ -776,16 +779,21 @@ static bool inquiry_callback(void *user_data)
 
 	data->iter = i;
 
-	if (i == MAX_BTDEV_ENTRIES) {
-		struct bt_hci_evt_inquiry_complete ic;
-
-		ic.status = BT_HCI_ERR_SUCCESS;
-		send_event(btdev, BT_HCI_EVT_INQUIRY_COMPLETE, &ic, sizeof(ic));
+	/* Check if we sent already required amount of responses*/
+	if (data->num_resp && data->sent_count == data->num_resp)
+		goto finish;
 
-		return false;
-	}
+	if (i == MAX_BTDEV_ENTRIES)
+		goto finish;
 
 	return true;
+
+finish:
+	/* Note that destroy will be called */
+	ic.status = BT_HCI_ERR_SUCCESS;
+	send_event(btdev, BT_HCI_EVT_INQUIRY_COMPLETE, &ic, sizeof(ic));
+
+	return false;
 }
 
 static void inquiry_destroy(void *user_data)
@@ -804,6 +812,7 @@ finish:
 
 static void inquiry_cmd(struct btdev *btdev, const void *cmd)
 {
+	const struct bt_hci_cmd_inquiry *inq_cmd = cmd;
 	struct inquiry_data *data;
 	struct bt_hci_evt_inquiry_complete ic;
 	int status = BT_HCI_ERR_HARDWARE_FAILURE;
@@ -819,6 +828,7 @@ static void inquiry_cmd(struct btdev *btdev, const void *cmd)
 
 	memset(data, 0, sizeof(*data));
 	data->btdev = btdev;
+	data->num_resp = inq_cmd->num_resp;
 
 	btdev->inquiry_id = timeout_add(DEFAULT_INQUIRY_INTERVAL,
 							inquiry_callback, data,
-- 
1.8.4

