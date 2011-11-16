Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 05/17] audio: Fix errno handling convention
Date: Wed, 16 Nov 2011 09:19:52 -0400
Message-Id: <1321449604-4188-6-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1321449604-4188-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1321449604-4188-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Variables which are assigned to the errno variable (usually called
"err") should be negative, and "-err" should be used where a positive
value is needed.
---
 audio/ctl_bluetooth.c |   13 +++++++------
 audio/unix.c          |   21 ++++++++++++---------
 2 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/audio/ctl_bluetooth.c b/audio/ctl_bluetooth.c
index d941421..a16f476 100644
--- a/audio/ctl_bluetooth.c
+++ b/audio/ctl_bluetooth.c
@@ -257,18 +257,19 @@ static int bluetooth_read_event(snd_ctl_ext_t *ext, snd_ctl_elem_id_t *id,
 	struct bluetooth_data *data = ext->private_data;
 	char buf[BT_SUGGESTED_BUFFER_SIZE];
 	struct bt_control_ind *ind = (void *) buf;
-	int ret;
+	int err;
 	const char *type, *name;
 
 	DBG("ext %p id %p", ext, id);
 
 	memset(buf, 0, sizeof(buf));
 
-	ret = recv(data->sock, ind, BT_SUGGESTED_BUFFER_SIZE, MSG_DONTWAIT);
-	if (ret < 0) {
-		SNDERR("Failed while receiving data: %s (%d)",
-				strerror(errno), errno);
-		return -errno;
+	err = recv(data->sock, ind, BT_SUGGESTED_BUFFER_SIZE, MSG_DONTWAIT);
+	if (err < 0) {
+		err = -errno;
+		SNDERR("Failed while receiving data: %s (%d)", strerror(-err),
+									-err);
+		return err;
 	}
 
 	type = bt_audio_strtype(ind->h.type);
diff --git a/audio/unix.c b/audio/unix.c
index 4e0a6f9..5199831 100644
--- a/audio/unix.c
+++ b/audio/unix.c
@@ -1864,25 +1864,28 @@ int unix_init(void)
 
 	sk = socket(PF_LOCAL, SOCK_STREAM, 0);
 	if (sk < 0) {
-		err = errno;
-		error("Can't create unix socket: %s (%d)", strerror(err), err);
-		return -err;
+		err = -errno;
+		error("Can't create unix socket: %s (%d)", strerror(-err),
+									-err);
+		return err;
 	}
 
 	if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
-		error("Can't bind unix socket: %s (%d)", strerror(errno),
-				errno);
+		err = -errno;
+		error("Can't bind unix socket: %s (%d)", strerror(-err),
+									-err);
 		close(sk);
-		return -1;
+		return err;
 	}
 
 	set_nonblocking(sk);
 
 	if (listen(sk, 1) < 0) {
-		error("Can't listen on unix socket: %s (%d)",
-						strerror(errno), errno);
+		err = -errno;
+		error("Can't listen on unix socket: %s (%d)", strerror(-err),
+									-err);
 		close(sk);
-		return -1;
+		return err;
 	}
 
 	unix_sock = sk;
-- 
1.7.0.4

