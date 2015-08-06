Return-Path: <cyrus@holtmann.org>
From: Anupam Roy <anupam.r@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: sachin.dev@samsung.com
Subject: [PATCH] tools/hcidump: Fix memory leak in process_frames method
Date: Thu, 06 Aug 2015 10:38:23 -0400
Message-id: <1438871903-13906-1-git-send-email-anupam.r@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Prevent memory leaks by freeing the dynamically allocated
buf and ctrl pointers.

Above is done by creating failed and done labels for handling
clean exit from process_frames method.
---
 tools/hcidump.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/tools/hcidump.c b/tools/hcidump.c
index 8839eb0..20749f3 100644
--- a/tools/hcidump.c
+++ b/tools/hcidump.c
@@ -145,11 +145,12 @@ static int process_frames(int dev, int sock, int fd, unsigned long flags)
 	struct frame frm;
 	struct pollfd fds[2];
 	int nfds = 0;
-	char *buf, *ctrl;
+	char *buf = NULL;
+	char *ctrl = NULL;
 	int len, hdr_size = HCIDUMP_HDR_SIZE;
 
 	if (sock < 0)
-		return -1;
+		goto failed;
 
 	if (snap_len < SNAP_LEN)
 		snap_len = SNAP_LEN;
@@ -160,7 +161,7 @@ static int process_frames(int dev, int sock, int fd, unsigned long flags)
 	buf = malloc(snap_len + hdr_size);
 	if (!buf) {
 		perror("Can't allocate data buffer");
-		return -1;
+		goto failed;
 	}
 
 	dh = (void *) buf;
@@ -169,9 +170,8 @@ static int process_frames(int dev, int sock, int fd, unsigned long flags)
 
 	ctrl = malloc(100);
 	if (!ctrl) {
-		free(buf);
 		perror("Can't allocate control buffer");
-		return -1;
+		goto failed;
 	}
 
 	if (dev == HCI_DEV_NONE)
@@ -197,9 +197,10 @@ static int process_frames(int dev, int sock, int fd, unsigned long flags)
 			if (fds[i].revents & (POLLHUP | POLLERR | POLLNVAL)) {
 				if (fds[i].fd == sock)
 					printf("device: disconnected\n");
-				else
+				else {
 					printf("client: disconnect\n");
-				return 0;
+					goto done;
+				}
 			}
 		}
 
@@ -216,7 +217,7 @@ static int process_frames(int dev, int sock, int fd, unsigned long flags)
 			if (errno == EAGAIN || errno == EINTR)
 				continue;
 			perror("Receive failed");
-			return -1;
+			goto failed;
 		}
 
 		/* Process control message */
@@ -269,7 +270,7 @@ static int process_frames(int dev, int sock, int fd, unsigned long flags)
 
 			if (write_n(fd, buf, frm.data_len + hdr_size) < 0) {
 				perror("Write error");
-				return -1;
+				goto failed;
 			}
 			break;
 
@@ -280,7 +281,16 @@ static int process_frames(int dev, int sock, int fd, unsigned long flags)
 		}
 	}
 
+done:
+	free(ctrl);
+	free(buf);
 	return 0;
+
+failed:
+	free(ctrl);
+	free(buf);
+	return -1;
+
 }
 
 static void read_dump(int fd)
-- 
1.9.1

