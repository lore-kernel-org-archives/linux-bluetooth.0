Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH BlueZ 3/4] hog: Fix error message formating
Date: Sat, 22 Dec 2012 12:12:41 -0300
Message-Id: <1356189162-11584-3-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1356189162-11584-1-git-send-email-jprvita@openbossa.org>
References: <1356189162-11584-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/input/suspend-dummy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/input/suspend-dummy.c b/profiles/input/suspend-dummy.c
index 14aabd0..33b790a 100644
--- a/profiles/input/suspend-dummy.c
+++ b/profiles/input/suspend-dummy.c
@@ -119,7 +119,7 @@ int suspend_init(suspend_event suspend, resume_event resume)
 
 	if (mkfifo(HOG_SUSPEND_FIFO, S_IRWXU) < 0) {
 		int err = -errno;
-		error("Can't create FIFO (%s) : %s(%d)", HOG_SUSPEND_FIFO,
+		error("Can't create FIFO (%s): %s (%d)", HOG_SUSPEND_FIFO,
 							strerror(-err), -err);
 		return err;
 	}
-- 
1.7.11.7

