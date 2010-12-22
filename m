Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH] Change LE scan interval and window to recommended values
Date: Wed, 22 Dec 2010 15:11:48 -0400
Message-Id: <1293045108-14011-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Replace default scan interval and scan window values with recommended
ones for general discovery procedure, according to the Core
specification.
---
 plugins/hciops.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 43e3d93..be143e9 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -2583,8 +2583,10 @@ static int hciops_start_scanning(int index)
 
 	memset(&cp, 0, sizeof(cp));
 	cp.type = 0x01;			/* Active scanning */
-	cp.interval = htobs(0x0010);
-	cp.window = htobs(0x0010);
+	/* The recommended value for scan interval and window is 11.25 msec.
+	 * It is calculated by: time = n * 0.625 msec */
+	cp.interval = htobs(0x0012);
+	cp.window = htobs(0x0012);
 	cp.own_bdaddr_type = 0;		/* Public address */
 	cp.filter = 0;			/* Accept all adv packets */
 
-- 
1.7.0.4

