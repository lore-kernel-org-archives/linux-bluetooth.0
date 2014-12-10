Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v3 4/4] android/bluetooth: Enable LE privacy mode on BfA startup
Date: Wed, 10 Dec 2014 20:15:48 +0100
Message-Id: <1418238948-30800-5-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1418238948-30800-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1418238948-30800-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Lets follow Android Lollipop behaviour and enable privacy on
startup.
---
 android/bluetooth.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 4c359d0..54e3d97 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -3423,6 +3423,32 @@ static void clear_auto_connect_list(void)
 	error("Could not clear auto connect list");
 }
 
+static void set_privacy_complete(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	if (status != MGMT_STATUS_SUCCESS)
+		error("Failed to set privacy mode: %s (0x%02x)",
+						mgmt_errstr(status), status);
+}
+
+static void set_privacy(void)
+{
+	struct mgmt_cp_set_privacy cp;
+
+	if (!local_irk_is_valid())
+		goto failed;
+
+	cp.privacy = 0x01;
+	memcpy(cp.irk, adapter.irk, sizeof(adapter.irk));
+
+	if (mgmt_send(mgmt_if, MGMT_OP_SET_PRIVACY, adapter.index, sizeof(cp),
+				&cp, set_privacy_complete, NULL, NULL) > 0)
+		return;
+
+failed:
+	error("Could not set privacy mode");
+}
+
 static void read_info_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -3497,6 +3523,9 @@ static void read_info_complete(uint8_t status, uint16_t length,
 	if (missing_settings & MGMT_SETTING_BONDABLE)
 		set_mode(MGMT_OP_SET_BONDABLE, 0x01);
 
+	if (missing_settings & MGMT_SETTING_PRIVACY)
+		set_privacy();
+
 	load_devices_info(cb);
 	load_devices_cache();
 
-- 
1.8.4

