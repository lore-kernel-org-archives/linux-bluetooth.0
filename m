Return-Path: <cyrus@holtmann.org>
From: Anchit Narang <anchit.n@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: sachin.dev@samsung.com
Subject: [PATCH v2] tools/hciconfig:Fixed Memory Leak
Date: Mon, 27 Jul 2015 16:26:26 +0530
Message-id: <1437994586-19180-1-git-send-email-anchit.n@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Freed memory allocated to structure hci_dev_list_req to avoid memory leak
---
 tools/hciconfig.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/hciconfig.c b/tools/hciconfig.c
index 6397e71..0e0b790 100644
--- a/tools/hciconfig.c
+++ b/tools/hciconfig.c
@@ -69,6 +69,7 @@ static void print_dev_list(int ctl, int flags)
 
 	if (ioctl(ctl, HCIGETDEVLIST, (void *) dl) < 0) {
 		perror("Can't get device list");
+		free(dl);
 		exit(1);
 	}
 
@@ -78,6 +79,8 @@ static void print_dev_list(int ctl, int flags)
 			continue;
 		print_dev_info(ctl, &di);
 	}
+
+	free(dl);
 }
 
 static void print_pkt_type(struct hci_dev_info *di)
-- 
1.7.9.5

