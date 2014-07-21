Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 2/3] shared/tester: Increase space for test case title
Date: Mon, 21 Jul 2014 15:23:39 +0200
Message-Id: <1405949020-27462-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1405949020-27462-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1405949020-27462-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This makes more space for case's title in the summary, and still
retains 80 chars boundary. This fixes column alignment when using
long case titles i.e. in new android-tester.
---
 src/shared/tester.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/tester.c b/src/shared/tester.c
index 88dfaeb..95b4682 100644
--- a/src/shared/tester.c
+++ b/src/shared/tester.c
@@ -53,7 +53,7 @@
 		printf(color fmt COLOR_OFF "\n", ## args)
 
 #define print_summary(label, color, value, fmt, args...) \
-			printf("%-45s " color "%-10s" COLOR_OFF fmt "\n", \
+			printf("%-52s " color "%-10s" COLOR_OFF fmt "\n", \
 							label, value, ## args)
 
 #define print_progress(name, color, fmt, args...) \
-- 
1.9.1

