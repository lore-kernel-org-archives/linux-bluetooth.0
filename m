Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] android/gatt: Add helper to create listen data
Date: Wed, 13 Aug 2014 16:50:16 +0200
Message-Id: <1407941416-28453-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1407941416-28453-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1407941416-28453-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 7b3db06..5d78101 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1851,6 +1851,20 @@ struct listen_data {
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
@@ -1885,16 +1899,13 @@ static void handle_client_unregister(const void *buf, uint16_t len)
 						INT_TO_PTR(cmd->client_if));
 
 	if (listening_client) {
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
@@ -2072,16 +2083,14 @@ static void handle_client_listen(const void *buf, uint16_t len)
 		}
 	}
 
-	data = new0(struct listen_data, 1);
+	data = create_listen_data(cmd->client_if, cmd->start);
 	if (!data) {
-		error("gatt: Could not allocate memory for listen data");
+		error("gatt: Could not allocate listen data");
+
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

