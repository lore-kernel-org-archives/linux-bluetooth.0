Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: hyuk0512.lee@samsung.com
To: linux-bluetooth@vger.kernel.org
Cc: Lee Hyuk <hyuk0512.lee@samsung.com>
Subject: [PATCH BlueZ] tools: Fix the sock handle leak
Date: Tue, 28 Mar 2017 10:12:14 +0900
Message-id: <1490663534-30177-1-git-send-email-hyuk0512.lee@samsung.com>
References: <CGME20170328011217epcas5p22d24014478494faeb29c66c21cd21fb2@epcas5p2.samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lee Hyuk <hyuk0512.lee@samsung.com>

This patch adds function "close" for fixing the socket handle leak.
---
 tools/rfcomm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/rfcomm.c b/tools/rfcomm.c
index 809c240..03359be 100644
--- a/tools/rfcomm.c
+++ b/tools/rfcomm.c
@@ -310,6 +310,7 @@ static void cmd_connect(int ctl, int dev, bdaddr_t *bdaddr, int argc, char **arg
 
 		if (setsockopt(sk, SOL_SOCKET, SO_LINGER, &l, sizeof(l)) < 0) {
 			perror("Can't set linger option");
+			close(sk);
 			return;
 		}
 	}
-- 
1.9.1

