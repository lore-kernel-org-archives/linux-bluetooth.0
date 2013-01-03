Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH v2 BlueZ 5/6] input: Minor whitespace fixes
Date: Thu,  3 Jan 2013 10:15:02 -0400
Message-Id: <1357222503-31554-5-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1357222503-31554-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1357222503-31554-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/input/device.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index e69d647..3d5ee20 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -277,11 +277,11 @@ static gboolean encrypt_notify(GIOChannel *io, GIOCondition condition,
 	struct input_device *idev = data;
 	int err;
 
-	DBG(" ");
+	DBG("");
 
 	err = ioctl_connadd(idev->req);
 	if (err < 0) {
-		error("ioctl_connadd(): %s(%d)", strerror(-err), -err);
+		error("ioctl_connadd(): %s (%d)", strerror(-err), -err);
 		close(idev->req->intr_sock);
 		close(idev->req->ctrl_sock);
 	}
-- 
1.7.9.5

