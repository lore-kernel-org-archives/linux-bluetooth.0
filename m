Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH v2 BlueZ 1/6] input: Remove dead code from encrypt_completed()
Date: Thu,  3 Jan 2013 10:14:58 -0400
Message-Id: <1357222503-31554-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

"status" is always zero, so this code will never be reached.
---
 profiles/input/device.c |    7 -------
 1 file changed, 7 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 9cea028..7655534 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -276,18 +276,11 @@ static void encrypt_completed(uint8_t status, gpointer user_data)
 	struct hidp_connadd_req *req = user_data;
 	int err;
 
-	if (status) {
-		error("Encryption failed: %s(0x%x)",
-				strerror(bt_error(status)), status);
-		goto failed;
-	}
-
 	err = ioctl_connadd(req);
 	if (err == 0)
 		goto cleanup;
 
 	error("ioctl_connadd(): %s(%d)", strerror(-err), -err);
-failed:
 	close(req->intr_sock);
 	close(req->ctrl_sock);
 
-- 
1.7.9.5

