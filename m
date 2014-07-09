Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] android/gatt: Fix sending incorrect frames
Date: Wed,  9 Jul 2014 10:53:52 +0200
Message-Id: <1404896033-17337-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Don't send pdu if encoding failed. It cause errors when trying
send notification larger than MTU - encoding pdu failed, and
length passed to g_attrib_send was 0. I caused errors.
---
 android/gatt.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 2ee2d05..cccf23e 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -4884,9 +4884,14 @@ static void handle_server_send_indication(const void *buf, uint16_t len)
 						(uint8_t *)cmd->value, cmd->len,
 						pdu, mtu);
 
-	g_attrib_send(conn->device->attrib, 0, pdu, length, NULL, NULL, NULL);
-
-	status = HAL_STATUS_SUCCESS;
+	if (length == 0) {
+		error("gatt: Failed to encode indication");
+		status = HAL_STATUS_FAILED;
+	} else {
+		g_attrib_send(conn->device->attrib, 0, pdu, length, NULL, NULL,
+									NULL);
+		status = HAL_STATUS_SUCCESS;
+	}
 
 reply:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
-- 
1.9.3

