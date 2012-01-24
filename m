Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH BlueZ] Change page scan interval in fast connectable mode
Date: Tue, 24 Jan 2012 14:43:17 +0200
Message-Id: <1327408997-6528-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Page scan interval in fast connectable mode is changed from 22.5 msec to
160 msec to perform less aggressive page scanning. This is done
accordingly to controller vendor recommendation.

Primary concern is that current parameters 22.5 interval, 11.25 window, and
interleaved scanning occupy whole radio bandwidth. Changing interval to 160
msec should be sufficient for both speeding up connection establishment and
leaving space for other activities, like inquiry scan, e.g.
---
 plugins/hciops.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index d42e7de..bc38c9b 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -3141,7 +3141,7 @@ static int hciops_fast_connectable(int index, gboolean enable)
 
 	if (enable) {
 		type = PAGE_SCAN_TYPE_INTERLACED;
-		cp.interval = 0x0024;	/* 22.5 msec page scan interval */
+		cp.interval = 0x0100;	/* 160 msec page scan interval */
 	} else {
 		type = PAGE_SCAN_TYPE_STANDARD;	/* default */
 		cp.interval = 0x0800;	/* default 1.28 sec page scan */
-- 
1.7.5.4

