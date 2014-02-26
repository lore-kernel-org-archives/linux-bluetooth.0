Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 09/17] emulator: Add handling inquiry number of responses
Date: Wed, 26 Feb 2014 02:57:20 +0100
Message-ID: <1393379848-4031-10-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1393379848-4031-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1393379848-4031-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Conflicts:
	emulator/btdev.c

Conflicts:
	emulator/btdev.c
---
 emulator/btdev.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 722c312..c74258b 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -128,6 +128,8 @@ struct btdev {
 
 struct inquiry_data {
 	struct btdev *btdev;
+	int num_resp;
+
 	int sent_count;
 };
 
@@ -703,6 +705,7 @@ static bool inquiry_callback(void *user_data)
 {
 	struct inquiry_data *data = user_data;
 	struct btdev *btdev = data->btdev;
+	struct bt_hci_evt_inquiry_complete ic;
 	static int j;
 	int sent = data->sent_count;
 	int i;
@@ -771,20 +774,31 @@ static bool inquiry_callback(void *user_data)
 		}
 	}
 
-	if (i == MAX_BTDEV_ENTRIES) {
-		struct bt_hci_evt_inquiry_complete ic;
+	/* Check if we sent already required amount of responses*/
+	if (data->num_resp && data->sent_count == data->num_resp)
+		goto finish;
 
-		ic.status = BT_HCI_ERR_SUCCESS;
-		send_event(btdev, BT_HCI_EVT_INQUIRY_COMPLETE, &ic, sizeof(ic));
+	if (i == MAX_BTDEV_ENTRIES) {
+		if (!data->num_resp)
+			goto finish;
 
-		/* reset */
-		btdev->inquiry_id = 0;
+		/* Reset main iterator so we can start iterate btdev_list
+		 * from the beggining */
 		j = 0;
-
-		return false;
 	}
 
 	return true;
+
+finish:
+	/* Note that destroy will be called */
+	ic.status = BT_HCI_ERR_SUCCESS;
+	send_event(btdev, BT_HCI_EVT_INQUIRY_COMPLETE, &ic, sizeof(ic));
+
+	/* reset */
+	btdev->inquiry_id = 0;
+	j = 0;
+
+	return false;
 }
 
 static void inquiry_destroy(void *user_data)
@@ -809,6 +823,7 @@ finish:
 
 static void inquiry_cmd(struct btdev *btdev, const void *cmd)
 {
+	const struct bt_hci_cmd_inquiry *inq_cmd = cmd;
 	struct inquiry_data *data;
 	struct bt_hci_evt_inquiry_complete ic;
 
@@ -821,6 +836,7 @@ static void inquiry_cmd(struct btdev *btdev, const void *cmd)
 
 	memset(data, 0, sizeof(*data));
 	data->btdev = btdev;
+	data->num_resp = inq_cmd->num_resp;
 
 	btdev->inquiry_id = timeout_add(DEFAULT_INQUIRY_INTERVAL,
 				inquiry_callback, data, inquiry_destroy);
-- 
1.8.4

