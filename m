Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECC631F992
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 14:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015028; cv=none; b=ERFCwOA5abVPhc/H1/hg5cgeewZJzpIhY1mIEPfuR6Q1q+1zZiN2++4XxgcEwFqFnvTX0TUP6ndIp5ReKBXlOPD7KsKwMct0Qn1s3pkmHygi0yfMf9YyBp1YkBQASd18pjDalEEjeWzUNTewjOXfp+HWBe66TUnH2sFA1BRMavs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015028; c=relaxed/simple;
	bh=ZQSgk/UJCKPnsx7nkLQQR2l6Ona5fhkC4kXQWyISoLw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FP5T4UjxtQYdV0IBkWyRt21CsIvBJnhNpT01zQMrT0N+mFgSQTthCFq4KPPm3fwRVusdhpkUwBPc8rXrPErjONayPWvaj1HK3oZVChJyrUcQILJG1ZpAmammUCIzPVU39Rih8EF5IJKbGdJ/zRGHoX0bByE/OkMJtXWLWpL/YlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 5D96B5829C8
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 13:58:54 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C2C933EDD8
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 13:58:46 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ 6/6] btattach: Use _cleanup_fd_ to simplify error paths
Date: Tue,  9 Jun 2026 15:50:58 +0200
Message-ID: <20260609135837.476561-7-hadess@hadess.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609135837.476561-1-hadess@hadess.net>
References: <20260609135837.476561-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: dmFkZTEVlSdXhFUvSV8QQx6yOrxge8LgLVsxPuUsLns/yksmkNx+qdDvLvza5bKGN8WNxSHwt+f8VbZ4lJPoURNdRMWp8SMuewEQUfgBMkY/jbgr+LyXuM7iW1giNJiHgNHw6TWCI3u/pWopj0uku4KXuEzF2U7Jkv7EHtBXrrJV7gBwCRlXQDiK2LO8ylQk6uzIFcjqpCrorpKwg3w0D6ojMjAneIde2+9Xgn2LOidAqfgBRNsXEa58H2+xUe5E0Ri8LlvlWBN+ajBkbQKIGVS8FIytq/3m1RxPUluCTzu51875p3iUUbERbtkhDOOaRjgxLdx7vcvY3Bj/fS1GlcpyS/+RCS88NNC2zLfCQdHG6XPnV+C6HIaWfQ3jJfqI+wyZRAtWgMLpVUnWwXKxekwPkWzFsUTNastfpWl7xTFKtJ/YKIPu5iBZPh9cbZ/5H0I64WJEObBfF3uowwQ+ZIOZO/3NtmMnw+wbVwJYyH6ULGyL+KOmrx0TZhHcmD+nACxQdAT4LNekQe/Yu+nOZBjBibZ1YCMOfCV/q9EacoG8AQi6MSoYEaFRmjLW6MNujx+kLJ3f7BX7T255+8JRb6z6EJHyOHpsEwwMgwVr/GBugtbUm5+CixNgTZ2XFd/7fifuRqyVCrpQRux6I1upP0xDHzlk3lh2iIX0v4e2QPezFarzFg

Use _cleanup_fd_ and _steal_fd() to simplify error paths, and only
"steal" the file descriptor on success.
---
 tools/btattach.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/tools/btattach.c b/tools/btattach.c
index 5f7d19093698..4918c79f65c7 100644
--- a/tools/btattach.c
+++ b/tools/btattach.c
@@ -40,7 +40,8 @@
 static int open_serial(const char *path, unsigned int speed, bool flowctl)
 {
 	struct termios ti;
-	int fd, saved_ldisc, ldisc = N_HCI;
+	_cleanup_fd_ int fd = -1;
+	int saved_ldisc, ldisc = N_HCI;
 
 	fd = open(path, O_RDWR | O_NOCTTY);
 	if (fd < 0) {
@@ -50,13 +51,11 @@ static int open_serial(const char *path, unsigned int speed, bool flowctl)
 
 	if (tcflush(fd, TCIOFLUSH) < 0) {
 		perror("Failed to flush serial port");
-		close(fd);
 		return -1;
 	}
 
 	if (ioctl(fd, TIOCGETD, &saved_ldisc) < 0) {
 		perror("Failed get serial line discipline");
-		close(fd);
 		return -1;
 	}
 
@@ -73,19 +72,17 @@ static int open_serial(const char *path, unsigned int speed, bool flowctl)
 
 	if (tcsetattr(fd, TCSANOW, &ti) < 0) {
 		perror("Failed to set serial port settings");
-		close(fd);
 		return -1;
 	}
 
 	if (ioctl(fd, TIOCSETD, &ldisc) < 0) {
 		perror("Failed set serial line discipline");
-		close(fd);
 		return -1;
 	}
 
 	printf("Switched line discipline from %d to %d\n", saved_ldisc, ldisc);
 
-	return fd;
+	return _steal_fd_(fd);
 }
 
 static void local_version_callback(const void *data, uint8_t size,
@@ -99,7 +96,8 @@ static void local_version_callback(const void *data, uint8_t size,
 static int attach_proto(const char *path, unsigned int proto,
 			unsigned int speed, bool flowctl, unsigned int flags)
 {
-	int fd, dev_id;
+	_cleanup_fd_ int fd = -1;
+	int dev_id;
 
 	fd = open_serial(path, speed, flowctl);
 	if (fd < 0)
@@ -107,20 +105,17 @@ static int attach_proto(const char *path, unsigned int proto,
 
 	if (ioctl(fd, HCIUARTSETFLAGS, flags) < 0) {
 		perror("Failed to set flags");
-		close(fd);
 		return -1;
 	}
 
 	if (ioctl(fd, HCIUARTSETPROTO, proto) < 0) {
 		perror("Failed to set protocol");
-		close(fd);
 		return -1;
 	}
 
 	dev_id = ioctl(fd, HCIUARTGETDEVICE);
 	if (dev_id < 0) {
 		perror("Failed to get device id");
-		close(fd);
 		return -1;
 	}
 
@@ -140,7 +135,6 @@ static int attach_proto(const char *path, unsigned int proto,
 
 		if (!hci) {
 			fprintf(stderr, "Failed to open HCI user channel\n");
-			close(fd);
 			return -1;
 		}
 
@@ -149,7 +143,7 @@ static int attach_proto(const char *path, unsigned int proto,
 					(bt_hci_destroy_func_t) bt_hci_unref);
 	}
 
-	return fd;
+	return _steal_fd_(fd);
 }
 
 static void uart_callback(int fd, uint32_t events, void *user_data)
-- 
2.54.0

