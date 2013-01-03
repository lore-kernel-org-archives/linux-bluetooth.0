Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH v2 BlueZ 4/6] input: Remove unnecessary encrypt_completed() function
Date: Thu,  3 Jan 2013 10:15:01 -0400
Message-Id: <1357222503-31554-4-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1357222503-31554-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1357222503-31554-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Its code is used only once, and can be made much simpler if moved to
encrypt_notify().
---
 profiles/input/device.c |   28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index fc7f8f7..e69d647 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -271,33 +271,25 @@ static int ioctl_connadd(struct hidp_connadd_req *req)
 	return err;
 }
 
-static void encrypt_completed(uint8_t status, gpointer user_data)
-{
-	struct hidp_connadd_req *req = user_data;
-	int err;
-
-	err = ioctl_connadd(req);
-	if (err < 0) {
-		error("ioctl_connadd(): %s(%d)", strerror(-err), -err);
-		close(req->intr_sock);
-		close(req->ctrl_sock);
-	}
-
-	g_free(req->rd_data);
-	g_free(req);
-}
-
 static gboolean encrypt_notify(GIOChannel *io, GIOCondition condition,
 								gpointer data)
 {
 	struct input_device *idev = data;
-	struct hidp_connadd_req *req = idev->req;
+	int err;
 
 	DBG(" ");
 
-	encrypt_completed(0, req);
+	err = ioctl_connadd(idev->req);
+	if (err < 0) {
+		error("ioctl_connadd(): %s(%d)", strerror(-err), -err);
+		close(idev->req->intr_sock);
+		close(idev->req->ctrl_sock);
+	}
 
 	idev->sec_watch = 0;
+
+	g_free(idev->req->rd_data);
+	g_free(idev->req);
 	idev->req = NULL;
 
 	return FALSE;
-- 
1.7.9.5

