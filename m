Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3B03E92BA
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 13:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778506359; cv=none; b=Ys5q/9WaND95Uc9p3Som3uzCW66Eler1oD2KqNExWGJ3vobB+W9xJodU3erbulFMOo/u8YArqD5I6aIayuLH4/ozCaIMMX7aY2dyNrkPHCBbnytFaSTxgzLiBhiATvCGEhWdXzEpC83WBHMCp3DitqPwLavFAg+aAI9DvYRJcWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778506359; c=relaxed/simple;
	bh=wYO7DlAJoLJwTvtdWLiBaB8Gpygv1cHdiFaKYTzbYtQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JisMKG42chDuDt4WKZNZi7uh0rObWFZeWLBsNz4aCXsCqeKm9W8eihmLGitMAeu8YYo2hIGQq2P85yqfL2vg1GE1rQ38puoA/C4Mn+PDzg/3rXEGsOoZcx/J/F1tBiy3is2WM0Ml+QU+OAB36ZYarNdXJ63VqYg1/kKm6/s3GLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 2FDB2581334
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 13:21:48 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8E7333E97A
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 13:21:41 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v3 6/6] btattach: Use _cleanup_fd_ to simplify error paths
Date: Mon, 11 May 2026 15:18:09 +0200
Message-ID: <20260511132131.1283892-7-hadess@hadess.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511132131.1283892-1-hadess@hadess.net>
References: <20260511132131.1283892-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: dmFkZTFyg4dcWaG5eSKnyQUHRkNw/X4O2fwqTBchSxLtNlc8UZkgYcvmT3qFT99KlQyk19auPdMEZcmgm/Vyr6QiQMZqh5NFE17Zc0wXOtGPQQZRz5XwT9JV83lfqcvUtVp2HNtl2hZC1BgZ9TR7tsTgsJSySwYWZzV5EPUMt6P2DJ1BVLKAGzqYnxDlPqKBHFh4XfMCnpWb3pFBFavNJlLQjO+blTA/peaWNxPspJqGVDx6v0cAbK74vnvh38G7adG+f8OSDFt6Fhdnqo3vTy+0xSBEumrusRanrze1CrRoMShKBmPygTEsg0qM+HlxUOxeeaxDbZ4d+AS9eqXKhVcDycEXQOzSGTLGOuYj6ZxroiyzBMnLfua6hM3/avx1RHVa2J+L0tD1HBPeb8Ssh2DqiukGwW4w/FaSEqfwHuUYc/iIQ+Hk+TZhqA/cBSDifF2puJCWzsYaWsMGhrbjK8du4KTIEAKxM94jZBJ9vSQQr67opGKsc/XmPdmCDSpFclsZe8IFXE0fLldKKcNsJZMsB+jwk8WVzfC+qA3CWsVB8YEPvshIeLSS5HMHEP9+6plNnM6Ox7YOkGSUpmlPjIDlDyRxwkEyVhehlxAwy/SEFtesOaSXqDNsAVhzdLDP47uiC4+eHNQoJvu0SEXm0hCT4j0LljWtcSCFc8EgQ045a5V6EQ
X-GND-State: clean
X-GND-Score: 0

Use _cleanup_fd_ and _steal_fd() to simplify error paths, and only
"steal" the file descriptor on success.
---
 tools/btattach.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/tools/btattach.c b/tools/btattach.c
index 5f7d19093698..8868871b0128 100644
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
+	return _steal_fd_(&fd);
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
+	return _steal_fd_(&fd);
 }
 
 static void uart_callback(int fd, uint32_t events, void *user_data)
-- 
2.54.0

