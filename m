Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 1/3] android/bluetooth: Add supported lmp settings to adapter struct
Date: Wed, 23 Apr 2014 18:53:25 +0200
Message-Id: <1398272007-15338-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1398272007-15338-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1398272007-15338-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/bluetooth.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 93c7935..5782e4d 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -129,6 +129,7 @@ static struct {
 	char *name;
 
 	uint32_t current_settings;
+	uint32_t supported_settings;
 
 	uint8_t cur_discovery_type;
 	uint8_t exp_discovery_type;
@@ -140,6 +141,7 @@ static struct {
 	.dev_class = 0,
 	.name = NULL,
 	.current_settings = 0,
+	.supported_settings = 0,
 	.cur_discovery_type = SCAN_TYPE_NONE,
 	.exp_discovery_type = SCAN_TYPE_NONE,
 	.discoverable_timeout = DEFAULT_DISCOVERABLE_TIMEOUT,
@@ -2324,7 +2326,7 @@ static void read_info_complete(uint8_t status, uint16_t length,
 {
 	const struct mgmt_rp_read_info *rp = param;
 	bt_bluetooth_ready cb = user_data;
-	uint32_t missing_settings, supported_settings;
+	uint32_t missing_settings;
 	int err;
 
 	DBG("");
@@ -2369,7 +2371,7 @@ static void read_info_complete(uint8_t status, uint16_t length,
 	adapter.dev_class = rp->dev_class[0] | (rp->dev_class[1] << 8) |
 						(rp->dev_class[2] << 16);
 
-	supported_settings = btohs(rp->supported_settings);
+	adapter.supported_settings = btohs(rp->supported_settings);
 	adapter.current_settings = btohs(rp->current_settings);
 
 	/* TODO: Register all event notification handlers */
@@ -2380,7 +2382,8 @@ static void read_info_complete(uint8_t status, uint16_t length,
 	set_io_capability();
 	set_device_id();
 
-	missing_settings = adapter.current_settings ^ supported_settings;
+	missing_settings = adapter.current_settings ^
+						adapter.supported_settings;
 
 	if (missing_settings & MGMT_SETTING_SSP)
 		set_mode(MGMT_OP_SET_SSP, 0x01);
-- 
1.8.4

