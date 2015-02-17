Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH] android/bluetooth: Fix enabling secure connection
Date: Tue, 17 Feb 2015 23:56:34 +0100
Message-Id: <1424213794-3646-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Current code works fine for controllers supporting BR/EDR secure
connections.

We want to have LE Secure connection enabled also for controllers which
does not support BR/EDR secure connections. For this we need to set
secure connection in the kernel just after LE is enabled (if requested
on register)
---
 android/bluetooth.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index f39f1e6..c2fb3f9 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -3481,9 +3481,6 @@ static void read_info_complete(uint8_t status, uint16_t length,
 	if (missing_settings & MGMT_SETTING_SSP)
 		set_mode(MGMT_OP_SET_SSP, 0x01);
 
-	if (missing_settings & MGMT_SETTING_SECURE_CONN)
-		set_mode(MGMT_OP_SET_SECURE_CONN, 0x01);
-
 	if (missing_settings & MGMT_SETTING_BONDABLE)
 		set_mode(MGMT_OP_SET_BONDABLE, 0x01);
 
@@ -5386,6 +5383,10 @@ bool bt_bluetooth_register(struct ipc *ipc, uint8_t mode)
 		goto failed;
 	}
 
+	/* Requested mode is set now, let's enable secure connection */
+	if (missing_settings & MGMT_SETTING_SECURE_CONN)
+		set_mode(MGMT_OP_SET_SECURE_CONN, 0x01);
+
 	/* Set initial default name */
 	if (!adapter.name) {
 		adapter.name = g_strdup(bt_config_get_model());
-- 
1.8.4

