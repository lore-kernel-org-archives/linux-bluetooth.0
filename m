Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 6/7] tools/hcidump: Fix resource leaks
Date: Wed, 12 Aug 2015 18:07:12 +0300
Message-Id: <1439392033-11822-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1439392033-11822-1-git-send-email-luiz.dentz@gmail.com>
References: <1439392033-11822-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 tools/hcidump.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/tools/hcidump.c b/tools/hcidump.c
index 8839eb0..af8f592 100644
--- a/tools/hcidump.c
+++ b/tools/hcidump.c
@@ -145,7 +145,8 @@ static int process_frames(int dev, int sock, int fd, unsigned long flags)
 	struct frame frm;
 	struct pollfd fds[2];
 	int nfds = 0;
-	char *buf, *ctrl;
+	char *buf;
+	char ctrl[100];
 	int len, hdr_size = HCIDUMP_HDR_SIZE;
 
 	if (sock < 0)
@@ -167,13 +168,6 @@ static int process_frames(int dev, int sock, int fd, unsigned long flags)
 	dp = (void *) buf;
 	frm.data = buf + hdr_size;
 
-	ctrl = malloc(100);
-	if (!ctrl) {
-		free(buf);
-		perror("Can't allocate control buffer");
-		return -1;
-	}
-
 	if (dev == HCI_DEV_NONE)
 		printf("system: ");
 	else
@@ -538,13 +532,13 @@ static int open_socket(int dev, unsigned long flags)
 	opt = 1;
 	if (setsockopt(sk, SOL_HCI, HCI_DATA_DIR, &opt, sizeof(opt)) < 0) {
 		perror("Can't enable data direction info");
-		return -1;
+		goto fail;
 	}
 
 	opt = 1;
 	if (setsockopt(sk, SOL_HCI, HCI_TIME_STAMP, &opt, sizeof(opt)) < 0) {
 		perror("Can't enable time stamp");
-		return -1;
+		goto fail;
 	}
 
 	/* Setup filter */
@@ -553,7 +547,7 @@ static int open_socket(int dev, unsigned long flags)
 	hci_filter_all_events(&flt);
 	if (setsockopt(sk, SOL_HCI, HCI_FILTER, &flt, sizeof(flt)) < 0) {
 		perror("Can't set filter");
-		return -1;
+		goto fail;
 	}
 
 	/* Bind socket to the HCI device */
@@ -563,10 +557,14 @@ static int open_socket(int dev, unsigned long flags)
 	if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
 		printf("Can't attach to device hci%d. %s(%d)\n",
 					dev, strerror(errno), errno);
-		return -1;
+		goto fail;
 	}
 
 	return sk;
+
+fail:
+	close(sk);
+	return -1;
 }
 
 static struct {
-- 
2.4.3

