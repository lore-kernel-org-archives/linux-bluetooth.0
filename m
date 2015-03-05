Return-Path: <cyrus@holtmann.org>
From: Bharat Panda <bharat.panda@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: cpgs@samsung.com, Bharat Panda <bharat.panda@samsung.com>
Subject: [PATCH ] hciattach: Fix memory leak
Date: Thu, 05 Mar 2015 17:11:36 +0530
Message-id: <1425555696-8308-1-git-send-email-bharat.panda@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/hciattach.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/tools/hciattach.c b/tools/hciattach.c
index da154df..4dc5be5 100644
--- a/tools/hciattach.c
+++ b/tools/hciattach.c
@@ -1209,7 +1209,7 @@ static int init_uart(char *dev, struct uart_t *u, int send_break, int raw)
 
 	if (tcgetattr(fd, &ti) < 0) {
 		perror("Can't get port settings");
-		return -1;
+		goto fail;
 	}
 
 	cfmakeraw(&ti);
@@ -1222,13 +1222,13 @@ static int init_uart(char *dev, struct uart_t *u, int send_break, int raw)
 
 	if (tcsetattr(fd, TCSANOW, &ti) < 0) {
 		perror("Can't set port settings");
-		return -1;
+		goto fail;
 	}
 
 	/* Set initial baudrate */
 	if (set_speed(fd, &ti, u->init_speed) < 0) {
 		perror("Can't set initial baud rate");
-		return -1;
+		goto fail;
 	}
 
 	tcflush(fd, TCIOFLUSH);
@@ -1239,37 +1239,41 @@ static int init_uart(char *dev, struct uart_t *u, int send_break, int raw)
 	}
 
 	if (u->init && u->init(fd, u, &ti) < 0)
-		return -1;
+		goto fail;
 
 	tcflush(fd, TCIOFLUSH);
 
 	/* Set actual baudrate */
 	if (set_speed(fd, &ti, u->speed) < 0) {
 		perror("Can't set baud rate");
-		return -1;
+		goto fail;
 	}
 
 	/* Set TTY to N_HCI line discipline */
 	i = N_HCI;
 	if (ioctl(fd, TIOCSETD, &i) < 0) {
 		perror("Can't set line discipline");
-		return -1;
+		goto fail;
 	}
 
 	if (flags && ioctl(fd, HCIUARTSETFLAGS, flags) < 0) {
 		perror("Can't set UART flags");
-		return -1;
+		goto fail;
 	}
 
 	if (ioctl(fd, HCIUARTSETPROTO, u->proto) < 0) {
 		perror("Can't set device");
-		return -1;
+		goto fail;
 	}
 
 	if (u->post && u->post(fd, u, &ti) < 0)
-		return -1;
+		goto fail;
 
 	return fd;
+
+fail:
+	close(fd);
+	return -1;
 }
 
 static void usage(void)
-- 
1.9.1

