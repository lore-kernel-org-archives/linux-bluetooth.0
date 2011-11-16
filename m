Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 01/17] AVCTP: Fix errno handling convention
Date: Wed, 16 Nov 2011 09:19:48 -0400
Message-Id: <1321449604-4188-2-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1321449604-4188-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1321449604-4188-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Variables which are assigned to the errno variable (usually called
"err") should be negative, and "-err" should be used where a positive
value is needed.

This patch also fixes a bug related to not using an "err" variable to
store the errno value before calling external library code.
---
 audio/avctp.c |   31 +++++++++++++------------------
 1 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/audio/avctp.c b/audio/avctp.c
index df3b2b8..5bd5db1 100644
--- a/audio/avctp.c
+++ b/audio/avctp.c
@@ -502,10 +502,10 @@ static int uinput_create(char *name)
 		if (fd < 0) {
 			fd = open("/dev/misc/uinput", O_RDWR);
 			if (fd < 0) {
-				err = errno;
+				err = -errno;
 				error("Can't open input device: %s (%d)",
-							strerror(err), err);
-				return -err;
+							strerror(-err), -err);
+				return err;
 			}
 		}
 	}
@@ -520,12 +520,11 @@ static int uinput_create(char *name)
 	dev.id.version = 0x0000;
 
 	if (write(fd, &dev, sizeof(dev)) < 0) {
-		err = errno;
+		err = -errno;
 		error("Can't write device information: %s (%d)",
-						strerror(err), err);
+						strerror(-err), -err);
 		close(fd);
-		errno = err;
-		return -err;
+		return err;
 	}
 
 	ioctl(fd, UI_SET_EVBIT, EV_KEY);
@@ -537,12 +536,11 @@ static int uinput_create(char *name)
 		ioctl(fd, UI_SET_KEYBIT, key_map[i].uinput);
 
 	if (ioctl(fd, UI_DEV_CREATE, NULL) < 0) {
-		err = errno;
+		err = -errno;
 		error("Can't create uinput device: %s (%d)",
-						strerror(err), err);
+						strerror(-err), -err);
 		close(fd);
-		errno = err;
-		return -err;
+		return err;
 	}
 
 	return fd;
@@ -895,7 +893,7 @@ int avctp_send_vendordep(struct avctp *session, uint8_t transaction,
 	struct avctp_header *avctp;
 	struct avc_header *avc;
 	uint8_t *pdu;
-	int sk, err;
+	int sk, err = 0;
 	uint16_t size;
 
 	if (session->state != AVCTP_STATE_CONNECTED)
@@ -920,14 +918,11 @@ int avctp_send_vendordep(struct avctp *session, uint8_t transaction,
 
 	memcpy(pdu, operands, operand_count);
 
-	err = write(sk, buf, size);
-	if (err < 0) {
-		g_free(buf);
-		return -errno;
-	}
+	if (write(sk, buf, size) < 0)
+		err = -errno;
 
 	g_free(buf);
-	return 0;
+	return err;
 }
 
 unsigned int avctp_add_state_cb(avctp_state_cb cb, void *user_data)
-- 
1.7.0.4

