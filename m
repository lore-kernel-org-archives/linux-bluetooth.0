Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH BlueZ 01/12] monitor: Fix memory leak
Date: Wed, 23 May 2012 21:27:21 +0530
Message-id: <1337788652-23697-2-git-send-email-s.syam@samsung.com>
In-reply-to: <1337788652-23697-1-git-send-email-s.syam@samsung.com>
References: <1337788652-23697-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 monitor/hcidump.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/monitor/hcidump.c b/monitor/hcidump.c
index 043c75e..373d2f5 100644
--- a/monitor/hcidump.c
+++ b/monitor/hcidump.c
@@ -233,7 +233,7 @@ static void device_list(int fd, int max_dev)
 
 	if (ioctl(fd, HCIGETDEVLIST, (void *) dl) < 0) {
 		perror("Failed to get device list");
-		return;
+		goto done;
 	}
 
 	for (i = 0; i < dl->dev_num; i++, dr++) {
@@ -253,6 +253,7 @@ static void device_list(int fd, int max_dev)
 		open_device(dr->dev_id);
 	}
 
+done:
 	free(dl);
 }
 
-- 
1.7.4.1

