Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [BlueZ PATCH 2/3] android: Get max advertising instances from kernel
To: linux-bluetooth@vger.kernel.org
From: Martin Fuzzey <mfuzzey@parkeon.com>
Date: Tue, 10 Oct 2017 11:27:53 +0200
Message-ID: <20171010092753.30705.21331.stgit@localhost>
In-Reply-To: <20171010092748.30705.23283.stgit@localhost>
References: <20171010092748.30705.23283.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use the mgmnt "advinfo" operation to obtain the number of advertising
instances supported by the kernel.

Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
---
 android/bluetooth.c |   43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 8ea521e..ba8f405 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -3345,6 +3345,37 @@ static void clear_auto_connect_list(void)
 	error("Could not clear auto connect list");
 }
 
+static void read_adv_features_complete(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	const struct mgmt_rp_read_adv_features *rp = param;
+	bt_bluetooth_ready cb = user_data;
+	int err;
+
+	if (status) {
+		error("Failed to read advertising features for index %u: %s (0x%02x)",
+				adapter.index, mgmt_errstr(status), status);
+		err = -EIO;
+		goto failed;
+	}
+
+	if (length < sizeof(*rp)) {
+		error("Too small read advertising features response");
+		err = -EIO;
+		goto failed;
+	}
+
+	adapter.max_advert_instance = rp->max_instances;
+	info("Max LE advertising instances: %d", adapter.max_advert_instance);
+
+	load_devices_info(cb);
+
+	return;
+
+failed:
+	cb(err, NULL);
+}
+
 static void read_info_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -3416,7 +3447,17 @@ static void read_info_complete(uint8_t status, uint16_t length,
 	if (missing_settings & MGMT_SETTING_BONDABLE)
 		set_mode(MGMT_OP_SET_BONDABLE, 0x01);
 
-	load_devices_info(cb);
+	if (adapter.supported_settings & MGMT_SETTING_LE) {
+		if (mgmt_send(mgmt_if, MGMT_OP_READ_ADV_FEATURES, adapter.index, 0, NULL,
+				read_adv_features_complete, cb, NULL) == 0) {
+			error("Cannot get LE adv features");
+			err = -EIO;
+			goto failed;
+		}
+	} else {
+		load_devices_info(cb);
+	}
+
 	load_devices_cache();
 
 	return;

