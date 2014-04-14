Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 2/3] android/bluetooth: Expose gap api to set advertising
Date: Mon, 14 Apr 2014 10:58:38 +0200
Message-Id: <1397465919-12677-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1397465919-12677-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1397465919-12677-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With this patch it is possible to start/stop advertising by gap clients
---
 android/bluetooth.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 android/bluetooth.h |  4 ++++
 2 files changed, 47 insertions(+)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index b3fad59..6624492 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -2882,6 +2882,49 @@ static bool stop_discovery(uint8_t type)
 	return false;
 }
 
+struct adv_user_data {
+	bt_le_set_advertising_done cb;
+	void *user_data;
+};
+
+static void set_advertising_cb(uint8_t status, uint16_t length,
+			const void *param, void *user_data)
+{
+	struct adv_user_data *data = user_data;
+
+	DBG("");
+
+	if (status)
+		error("Failed to set adverising for index %u: %s (0x%02x))",
+				adapter.index, mgmt_errstr(status), status);
+
+	data->cb(status, data->user_data);
+	free(data);
+	return;
+}
+
+bool bt_le_set_advertising(bool advertising, bt_le_set_advertising_done cb,
+							 void *user_data)
+{
+	struct adv_user_data *data;
+	uint8_t adv = advertising ? 0x01 : 0x00;
+
+	data = new0(struct adv_user_data, 1);
+	if (!data)
+		return false;
+
+	data->cb = cb;
+	data->user_data = user_data;
+
+	if (mgmt_send(mgmt_if, MGMT_OP_SET_ADVERTISING, adapter.index,
+			sizeof(adv), &adv, set_advertising_cb, data, NULL) > 0)
+		return true;
+
+	error("Failed to set advertising");
+	free(data);
+	return false;
+}
+
 bool bt_le_discovery_stop(bt_le_discovery_stopped cb)
 {
 	if (!adapter.cur_discovery_type) {
diff --git a/android/bluetooth.h b/android/bluetooth.h
index 807ebe7..3eddf16 100644
--- a/android/bluetooth.h
+++ b/android/bluetooth.h
@@ -42,3 +42,7 @@ bool bt_le_discovery_start(bt_le_device_found cb);
 
 typedef void (*bt_le_discovery_stopped)(void);
 bool bt_le_discovery_stop(bt_le_discovery_stopped cb);
+
+typedef void (*bt_le_set_advertising_done)(uint8_t status, void *user_data);
+bool bt_le_set_advertising(bool advertising, bt_le_set_advertising_done cb,
+							void *user_data);
-- 
1.8.4

