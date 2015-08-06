Return-Path: <cyrus@holtmann.org>
From: Anupam Roy <anupam.r@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: sachin.dev@samsung.com
Subject: [PATCH] tools/hcidump: Add missing socket close()
Date: Thu, 06 Aug 2015 10:56:30 -0400
Message-id: <1438872990-14301-1-git-send-email-anupam.r@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add socket close() calls, in case socket operations fail.
---
 tools/hcidump.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/hcidump.c b/tools/hcidump.c
index 20749f3..5fc45e9 100644
--- a/tools/hcidump.c
+++ b/tools/hcidump.c
@@ -548,12 +548,14 @@ static int open_socket(int dev, unsigned long flags)
 	opt = 1;
 	if (setsockopt(sk, SOL_HCI, HCI_DATA_DIR, &opt, sizeof(opt)) < 0) {
 		perror("Can't enable data direction info");
+		close(sk);
 		return -1;
 	}
 
 	opt = 1;
 	if (setsockopt(sk, SOL_HCI, HCI_TIME_STAMP, &opt, sizeof(opt)) < 0) {
 		perror("Can't enable time stamp");
+		close(sk);
 		return -1;
 	}
 
@@ -563,6 +565,7 @@ static int open_socket(int dev, unsigned long flags)
 	hci_filter_all_events(&flt);
 	if (setsockopt(sk, SOL_HCI, HCI_FILTER, &flt, sizeof(flt)) < 0) {
 		perror("Can't set filter");
+		close(sk);
 		return -1;
 	}
 
@@ -573,6 +576,7 @@ static int open_socket(int dev, unsigned long flags)
 	if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
 		printf("Can't attach to device hci%d. %s(%d)\n",
 					dev, strerror(errno), errno);
+		close(sk);
 		return -1;
 	}
 
-- 
1.9.1

