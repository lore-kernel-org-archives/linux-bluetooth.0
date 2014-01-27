Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2] avctp: Fix unchecked return value
Date: Mon, 27 Jan 2014 17:59:35 +0200
Message-Id: <1390838375-25264-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <CAJdJm_P5JwjNhRuqz0gFYJ7QZMPmcHNVSvSa+SAQ11ftM8z0WQ@mail.gmail.com>
References: <CAJdJm_P5JwjNhRuqz0gFYJ7QZMPmcHNVSvSa+SAQ11ftM8z0WQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Refactor code so that ioctl() return value is checked.
---
 profiles/audio/avctp.c | 47 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 10 deletions(-)

diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index 6fd1454..bf44f9c 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -1027,27 +1027,54 @@ static int uinput_create(char *name)
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
 	}
 
-	ioctl(fd, UI_SET_EVBIT, EV_KEY);
-	ioctl(fd, UI_SET_EVBIT, EV_REL);
-	ioctl(fd, UI_SET_EVBIT, EV_REP);
-	ioctl(fd, UI_SET_EVBIT, EV_SYN);
+	if (ioctl(fd, UI_SET_EVBIT, EV_REL) < 0) {
+		err = -errno;
+		error("ioctl UI_SET_EVBIT: %s (%d)", strerror(-err), -err);
+		goto fail;
+	}
 
-	for (i = 0; key_map[i].name != NULL; i++)
-		ioctl(fd, UI_SET_KEYBIT, key_map[i].uinput);
+	if (ioctl(fd, UI_SET_EVBIT, EV_REP) < 0) {
+		err = -errno;
+		error("ioctl UI_SET_EVBIT: %s (%d)", strerror(-err), -err);
+		goto fail;
+	}
+
+	if (ioctl(fd, UI_SET_EVBIT, EV_SYN) < 0) {
+		err = -errno;
+		error("ioctl UI_SET_EVBIT: %s (%d)", strerror(-err), -err);
+		goto fail;
+	}
+
+	for (i = 0; key_map[i].name != NULL; i++) {
+		if (ioctl(fd, UI_SET_KEYBIT, key_map[i].uinput) < 0) {
+			err = -errno;
+			error("ioctl UI_SET_KEYBIT: %s (%d)", strerror(-err),
+									-err);
+			goto fail;
+		}
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

