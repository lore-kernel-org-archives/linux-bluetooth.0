Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 06/17] serial: Fix errno handling convention
Date: Wed, 16 Nov 2011 09:19:53 -0400
Message-Id: <1321449604-4188-7-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1321449604-4188-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1321449604-4188-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Variables which are assigned to the errno variable (usually called
"err") should be negative, and "-err" should be used where a positive
value is needed.
---
 serial/port.c  |    6 +++---
 serial/proxy.c |   39 ++++++++++++++++++---------------------
 2 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/serial/port.c b/serial/port.c
index fa302be..3b36d44 100644
--- a/serial/port.c
+++ b/serial/port.c
@@ -183,16 +183,16 @@ static int port_release(struct serial_port *port)
 	req.flags = (1 << RFCOMM_HANGUP_NOW);
 
 	if (ioctl(rfcomm_ctl, RFCOMMRELEASEDEV, &req) < 0) {
-		err = errno;
+		err = -errno;
 		error("Can't release device %s: %s (%d)",
-				port->dev, strerror(err), err);
+				port->dev, strerror(-err), -err);
 	}
 
 	g_free(port->dev);
 	port->dev = NULL;
 	port->id = -1;
 	close(rfcomm_ctl);
-	return -err;
+	return err;
 }
 
 static void serial_port_free(void *data)
diff --git a/serial/proxy.c b/serial/proxy.c
index 371ad5f..736f690 100644
--- a/serial/proxy.c
+++ b/serial/proxy.c
@@ -289,19 +289,18 @@ static inline int unix_socket_connect(const char *address)
 	/* Unix socket */
 	sk = socket(AF_UNIX, SOCK_STREAM, 0);
 	if (sk < 0) {
-		err = errno;
+		err = -errno;
 		error("Unix socket(%s) create failed: %s(%d)",
-				address, strerror(err), err);
-		return -err;
+				address, strerror(-err), -err);
+		return err;
 	}
 
 	if (connect(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
-		err = errno;
+		err = -errno;
 		error("Unix socket(%s) connect failed: %s(%d)",
-				address, strerror(err), err);
+				address, strerror(-err), -err);
 		close(sk);
-		errno = err;
-		return -err;
+		return err;
 	}
 
 	return sk;
@@ -329,18 +328,17 @@ static int tcp_socket_connect(const char *address)
 
 	sk = socket(PF_INET, SOCK_STREAM, 0);
 	if (sk < 0) {
-		err = errno;
+		err = -errno;
 		error("TCP socket(%s) create failed %s(%d)", address,
-							strerror(err), err);
-		return -err;
+							strerror(-err), -err);
+		return err;
 	}
 	if (connect(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
-		err = errno;
+		err = -errno;
 		error("TCP socket(%s) connect failed: %s(%d)",
-						address, strerror(err), err);
+						address, strerror(-err), -err);
 		close(sk);
-		errno = err;
-		return -err;
+		return err;
 	}
 	return sk;
 }
@@ -351,18 +349,17 @@ static inline int tty_open(const char *tty, struct termios *ti)
 
 	sk = open(tty, O_RDWR | O_NOCTTY);
 	if (sk < 0) {
-		err = errno;
-		error("Can't open TTY %s: %s(%d)", tty, strerror(err), err);
-		return -err;
+		err = -errno;
+		error("Can't open TTY %s: %s(%d)", tty, strerror(-err), -err);
+		return err;
 	}
 
 	if (ti && tcsetattr(sk, TCSANOW, ti) < 0) {
-		err = errno;
+		err = -errno;
 		error("Can't change serial settings: %s(%d)",
-				strerror(err), err);
+				strerror(-err), -err);
 		close(sk);
-		errno = err;
-		return -err;
+		return err;
 	}
 
 	return sk;
-- 
1.7.0.4

