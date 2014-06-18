Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 1/4] android/gatt: Rename set_security function
Date: Thu, 19 Jun 2014 00:41:23 +0200
Message-Id: <1403131286-15028-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1403131286-15028-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1403131286-15028-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

New helper set_security_level will be introduced in next patch, so lets
give this function better name
---
 android/gatt.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 32853fa..004dead 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -2735,7 +2735,7 @@ static int get_sec_level(struct gatt_device *dev)
 	return sec_level;
 }
 
-static bool set_security(struct gatt_device *device, int auth_type)
+static bool set_security_by_auth(struct gatt_device *device, int auth_type)
 {
 	int req_sec_level, sec_level;
 	GError *gerr = NULL;
@@ -2818,7 +2818,7 @@ static void handle_client_read_characteristic(const void *buf, uint16_t len)
 		goto failed;
 	}
 
-	if (!set_security(conn->device, cmd->auth_req)) {
+	if (!set_security_by_auth(conn->device, cmd->auth_req)) {
 		error("gatt: Failed to set security %d", cmd->auth_req);
 		status = HAL_STATUS_FAILED;
 		free(cb_data);
@@ -2952,7 +2952,7 @@ static void handle_client_write_characteristic(const void *buf, uint16_t len)
 		}
 	}
 
-	if (!set_security(conn->device, cmd->auth_req)) {
+	if (!set_security_by_auth(conn->device, cmd->auth_req)) {
 		error("gatt: Failed to set security %d", cmd->auth_req);
 		status = HAL_STATUS_FAILED;
 		goto failed;
@@ -3159,7 +3159,7 @@ static void handle_client_read_descriptor(const void *buf, uint16_t len)
 		goto failed;
 	}
 
-	if (!set_security(conn->device, cmd->auth_req)) {
+	if (!set_security_by_auth(conn->device, cmd->auth_req)) {
 		error("gatt: Failed to set security %d", cmd->auth_req);
 		status = HAL_STATUS_FAILED;
 		free(cb_data);
@@ -3291,7 +3291,7 @@ static void handle_client_write_descriptor(const void *buf, uint16_t len)
 		}
 	}
 
-	if (!set_security(conn->device, cmd->auth_req)) {
+	if (!set_security_by_auth(conn->device, cmd->auth_req)) {
 		error("gatt: Failed to set security %d", cmd->auth_req);
 		status = HAL_STATUS_FAILED;
 		goto failed;
@@ -3774,7 +3774,7 @@ static uint8_t test_increase_security(bdaddr_t *bdaddr, uint16_t u1)
 	if (!device)
 		return HAL_STATUS_FAILED;
 
-	if (!set_security(device, u1))
+	if (!set_security_by_auth(device, u1))
 		return HAL_STATUS_FAILED;
 
 	return HAL_STATUS_SUCCESS;
-- 
1.8.4

