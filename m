Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] avctp: Fix unchecked return value
Date: Fri, 24 Jan 2014 16:56:43 +0200
Message-Id: <1390575403-30860-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1390575403-30860-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1390575403-30860-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Refactor code so that ioctl() return value is checked.
---
 profiles/audio/avctp.c | 43 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index 6669ddc..4d0f906 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -1026,27 +1026,52 @@ static int uinput_create(char *name)
 		err = -errno;
 		error("Can't write device information: %s (%d)",
 						strerror(-err), -err);
-		close(fd);
-		return err;
+		goto fail;
+	}
+
+	if (ioctl(fd, UI_SET_EVBIT, EV_KEY) < 0) {
+		err = -errno;
+		error("ioctl UI_SET_EVBIT: %s (%d)", strerror(-err), -err);
+		goto fail;
+	}
+
+	if (ioctl(fd, UI_SET_EVBIT, EV_REL) < 0) {
+		err = -errno;
+		error("ioctl UI_SET_EVBIT: %s (%d)", strerror(-err), -err);
+		goto fail;
+	}
+
+	if (ioctl(fd, UI_SET_EVBIT, EV_REP) < 0) {
+		err = -errno;
+		error("ioctl UI_SET_EVBIT: %s (%d)", strerror(-err), -err);
+		goto fail;
 	}
 
-	ioctl(fd, UI_SET_EVBIT, EV_KEY);
-	ioctl(fd, UI_SET_EVBIT, EV_REL);
-	ioctl(fd, UI_SET_EVBIT, EV_REP);
-	ioctl(fd, UI_SET_EVBIT, EV_SYN);
+	if (ioctl(fd, UI_SET_EVBIT, EV_SYN) < 0) {
+		err = -errno;
+		error("ioctl UI_SET_EVBIT: %s (%d)", strerror(-err), -err);
+		goto fail;
+	}
 
-	for (i = 0; key_map[i].name != NULL; i++)
+	for (i = 0; key_map[i].name != NULL; i++) {
 		ioctl(fd, UI_SET_KEYBIT, key_map[i].uinput);
+		err = -errno;
+		error("ioctl UI_SET_KEYBIT: %s (%d)", strerror(-err), -err);
+		goto fail;
+	}
 
 	if (ioctl(fd, UI_DEV_CREATE, NULL) < 0) {
 		err = -errno;
 		error("Can't create uinput device: %s (%d)",
 						strerror(-err), -err);
-		close(fd);
-		return err;
+		goto fail;
 	}
 
 	return fd;
+
+fail:
+	close(fd);
+	return err;
 }
 
 static void init_uinput(struct avctp *session)
-- 
1.8.3.2

