Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH v2 BlueZ 3/6] input: Remove unnecessary goto label
Date: Thu,  3 Jan 2013 10:15:00 -0400
Message-Id: <1357222503-31554-3-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1357222503-31554-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1357222503-31554-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Instead, use "if (err < 0)" for error handling.
---
 profiles/input/device.c |   13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index ca1ce8b..fc7f8f7 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -277,16 +277,13 @@ static void encrypt_completed(uint8_t status, gpointer user_data)
 	int err;
 
 	err = ioctl_connadd(req);
-	if (err == 0)
-		goto cleanup;
-
-	error("ioctl_connadd(): %s(%d)", strerror(-err), -err);
-	close(req->intr_sock);
-	close(req->ctrl_sock);
+	if (err < 0) {
+		error("ioctl_connadd(): %s(%d)", strerror(-err), -err);
+		close(req->intr_sock);
+		close(req->ctrl_sock);
+	}
 
-cleanup:
 	g_free(req->rd_data);
-
 	g_free(req);
 }
 
-- 
1.7.9.5

