Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH BlueZ 4/4] hog: Remove pre-existing suspend FIFO
Date: Sat, 22 Dec 2012 12:12:42 -0300
Message-Id: <1356189162-11584-4-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1356189162-11584-1-git-send-email-jprvita@openbossa.org>
References: <1356189162-11584-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If bluetoothd crashes the exit routine of the suspend plugin will not be
executed, leaving the suspend FIFO behind and preventing the plugin load
on subsequent executions. This commit checks for pre-existence of the
suspend FIFO and tries to remove and re-create it.
---
 profiles/input/suspend-dummy.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/profiles/input/suspend-dummy.c b/profiles/input/suspend-dummy.c
index 33b790a..43384c0 100644
--- a/profiles/input/suspend-dummy.c
+++ b/profiles/input/suspend-dummy.c
@@ -119,6 +119,22 @@ int suspend_init(suspend_event suspend, resume_event resume)
 
 	if (mkfifo(HOG_SUSPEND_FIFO, S_IRWXU) < 0) {
 		int err = -errno;
+
+		if (err == -EEXIST) {
+			DBG("FIFO (%s) already exists, trying to remove",
+							HOG_SUSPEND_FIFO);
+
+			/* remove pre-existing FIFO and retry */
+			if (remove(HOG_SUSPEND_FIFO) < 0) {
+				err = -errno;
+				error("Failed to remove FIFO (%s): %s (%d)",
+					HOG_SUSPEND_FIFO, strerror(-err), -err);
+				return err;
+			}
+
+			return suspend_init(suspend, resume);
+		}
+
 		error("Can't create FIFO (%s): %s (%d)", HOG_SUSPEND_FIFO,
 							strerror(-err), -err);
 		return err;
-- 
1.7.11.7

