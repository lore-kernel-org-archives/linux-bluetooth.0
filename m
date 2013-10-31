Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 1/2] android: Always enable SSP if supported by controller
Date: Thu, 31 Oct 2013 14:15:08 +0100
Message-ID: <1383225309-7260-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is no HAL function to enable/disable SSP so always enable it if
supported by controller.
---

v2:
  use missing_settings mask for checking if setting is enabled

 android/adapter.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/android/adapter.c b/android/adapter.c
index a3f9aa6..c6fcf96 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -490,6 +490,7 @@ static void read_info_complete(uint8_t status, uint16_t length, const void *para
 							void *user_data)
 {
 	const struct mgmt_rp_read_info *rp = param;
+	uint32_t missing_settings;
 	int err;
 
 	DBG("");
@@ -528,6 +529,13 @@ static void read_info_complete(uint8_t status, uint16_t length, const void *para
 	load_link_keys(NULL);
 
 	set_io_capability();
+
+	missing_settings = adapter->current_settings ^
+						adapter->supported_settings;
+
+	if (missing_settings & MGMT_SETTING_SSP)
+		set_mode(MGMT_OP_SET_SSP, 0x01);
+
 	set_mode(MGMT_OP_SET_PAIRABLE, 0x01);
 
 	return;
-- 
1.8.4.1

