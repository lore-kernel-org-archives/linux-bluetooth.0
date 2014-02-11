Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 5/7] android/test-ipc: Fix crash due to invalid ipc_register() parameter
Date: Tue, 11 Feb 2014 14:32:30 -0400
Message-Id: <1392143552-11395-5-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1392143552-11395-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1392143552-11395-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This test checks for proper handling of invalid Service ID on a IPC
message, but it was attempting to register handlers for this invalid ID,
which on current ipc_register() implementation was causing a buffer
overrun.

The fix was to use a valid ID during registration, but still attempt to
use an invalid one when sending the message.
---
 android/test-ipc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/test-ipc.c b/android/test-ipc.c
index 3a0729e..7318251 100644
--- a/android/test-ipc.c
+++ b/android/test-ipc.c
@@ -526,7 +526,7 @@ static const struct hal_hdr test_cmd_service_offrange_hdr = {
 static const struct test_data test_cmd_service_offrange = {
 	.cmd = &test_cmd_service_offrange_hdr,
 	.cmd_size = sizeof(struct hal_hdr),
-	.service = HAL_SERVICE_ID_MAX + 1,
+	.service = 0,
 	.handlers = cmd_handlers,
 	.handlers_size = 1,
 	.expected_signal = SIGTERM
-- 
1.7.9.5

