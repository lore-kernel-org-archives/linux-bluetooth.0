Return-Path: <cyrus@holtmann.org>
From: Suraj Sumangala <suraj@atheros.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <Jothikumar.Mothilal@Atheros.com>,
	Suraj Sumangala <suraj@atheros.com>
Subject: [PATCH] hciattach: makes set_speed return error if any one operation fail
Date: Tue, 23 Nov 2010 16:09:43 +0530
Message-ID: <1290508783-31183-1-git-send-email-suraj@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch lets set_speed function changing UART baud rate
to return an error code if any one operation fails
instead of returning only the last operation's status.

---
 tools/hciattach.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/hciattach.c b/tools/hciattach.c
index fd53710..7cb8e9e 100644
--- a/tools/hciattach.c
+++ b/tools/hciattach.c
@@ -144,9 +144,16 @@ static int uart_speed(int s)
 
 int set_speed(int fd, struct termios *ti, int speed)
 {
-	cfsetospeed(ti, uart_speed(speed));
-	cfsetispeed(ti, uart_speed(speed));
-	return tcsetattr(fd, TCSANOW, ti);
+	if (cfsetospeed(ti, uart_speed(speed)) < 0)
+		return -errno;
+
+	if (cfsetispeed(ti, uart_speed(speed)) < 0)
+		return -errno;
+
+	if (tcsetattr(fd, TCSANOW, ti) < 0)
+		return -errno;
+
+	return 0;
 }
 
 /*
-- 
1.7.0.4

