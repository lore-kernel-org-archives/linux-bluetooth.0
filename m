Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] android/gatt: Add helper to create listen data
Date: Wed,  3 Sep 2014 11:26:57 +0200
Message-Id: <1409736417-17615-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1409736417-17615-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1409736417-17615-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 6970636..3383e7a 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1900,6 +1900,20 @@ struct listen_data {
 	bool start;
 };
 
+static struct listen_data *create_listen_data(int32_t client_id, bool start)
+{
+	struct listen_data *d;
+
+	d = new0(struct listen_data, 1);
+	if (!d)
+		return NULL;
+
+	d->client_id = client_id;
+	d->start = start;
+
+	return d;
+}
+
 static void set_advertising_cb(uint8_t status, void *user_data)
 {
 	struct listen_data *l = user_data;
@@ -1942,16 +1956,13 @@ static void handle_client_unregister(const void *buf, uint16_t len)
 	}
 
 	if (!advertising_cnt) {
-		data = new0(struct listen_data, 1);
+		data = create_listen_data(cmd->client_if, false);
 		if (!data) {
-			error("gatt: Could not allocate memory for listen data");
+			error("gatt: Could not allocate listen data");
 			status = HAL_STATUS_NOMEM;
 			goto reply;
 		}
 
-		data->client_id = cmd->client_if;
-		data->start = false;
-
 		if (!bt_le_set_advertising(data->start, set_advertising_cb,
 								data)) {
 			error("gatt: Could not set advertising");
@@ -2102,16 +2113,13 @@ static void handle_client_listen(const void *buf, uint16_t len)
 		}
 	}
 
-	data = new0(struct listen_data, 1);
+	data = create_listen_data(cmd->client_if, cmd->start);
 	if (!data) {
-		error("gatt: Could not allocate memory for listen data");
+		error("gatt: Could not allocate listen data");
 		status = HAL_STATUS_NOMEM;
 		goto reply;
 	}
 
-	data->client_id = cmd->client_if;
-	data->start = cmd->start;
-
 	if (!bt_le_set_advertising(cmd->start, set_advertising_cb, data)) {
 		error("gatt: Could not set advertising");
 		status = HAL_STATUS_FAILED;
-- 
1.9.3

