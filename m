Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <szymon.janc@tieto.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 13/15] android/gatt: Change label name from failed to reply
Date: Tue, 8 Apr 2014 11:22:30 +0200
Message-ID: <1396948952-2035-14-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1396948952-2035-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1396948952-2035-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Next patch will use this label in success case therefore let's change
this label
---
 android/gatt.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 1b48730..58b228d 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1351,12 +1351,12 @@ static void handle_client_get_included_service(const void *buf, uint16_t len)
 	device = find_device_by_conn_id(cmd->conn_id);
 	if (!device) {
 		status = HAL_STATUS_FAILED;
-		goto failed;
+		goto reply;
 	}
 
 	if (queue_isempty(device->services)) {
 		status = HAL_STATUS_FAILED;
-		goto failed;
+		goto reply;
 	}
 
 	if (!cmd->number) {
@@ -1370,14 +1370,14 @@ static void handle_client_get_included_service(const void *buf, uint16_t len)
 
 	if (!service) {
 		status = HAL_STATUS_FAILED;
-		goto failed;
+		goto reply;
 	}
 
 	data = new0(struct get_included_data, 1);
 	if (!data) {
 		error("gatt: failed to allocate memory for included_data");
 		status = HAL_STATUS_FAILED;
-		goto failed;
+		goto reply;
 	}
 
 	data->prim = service;
@@ -1389,7 +1389,7 @@ static void handle_client_get_included_service(const void *buf, uint16_t len)
 
 	status = HAL_STATUS_SUCCESS;
 
-failed:
+reply:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
 					HAL_OP_GATT_CLIENT_GET_INCLUDED_SERVICE,
 					status);
-- 
1.8.4

