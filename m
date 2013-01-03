Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH v2 BlueZ 2/6] input: Use g_free() where appropriate
Date: Thu,  3 Jan 2013 10:14:59 -0400
Message-Id: <1357222503-31554-2-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1357222503-31554-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1357222503-31554-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

req->rd_data was allocated with g_try_malloc0(), therefore it should be
freed with g_free().
---
 profiles/input/device.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 7655534..ca1ce8b 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -285,7 +285,7 @@ static void encrypt_completed(uint8_t status, gpointer user_data)
 	close(req->ctrl_sock);
 
 cleanup:
-	free(req->rd_data);
+	g_free(req->rd_data);
 
 	g_free(req);
 }
@@ -376,7 +376,7 @@ static int hidp_add_connection(struct input_device *idev)
 	err = ioctl_connadd(req);
 
 cleanup:
-	free(req->rd_data);
+	g_free(req->rd_data);
 	g_free(req);
 
 	return err;
-- 
1.7.9.5

