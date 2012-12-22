Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH BlueZ 2/4] hog: Add debug info when initializing the suspend plugin
Date: Sat, 22 Dec 2012 12:12:40 -0300
Message-Id: <1356189162-11584-2-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1356189162-11584-1-git-send-email-jprvita@openbossa.org>
References: <1356189162-11584-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/input/suspend-dummy.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/profiles/input/suspend-dummy.c b/profiles/input/suspend-dummy.c
index b43946d..14aabd0 100644
--- a/profiles/input/suspend-dummy.c
+++ b/profiles/input/suspend-dummy.c
@@ -124,6 +124,8 @@ int suspend_init(suspend_event suspend, resume_event resume)
 		return err;
 	}
 
+	DBG("Created suspend-dummy FIFO on %s", HOG_SUSPEND_FIFO);
+
 	ret = fifo_open();
 	if (ret < 0)
 		remove(HOG_SUSPEND_FIFO);
-- 
1.7.11.7

