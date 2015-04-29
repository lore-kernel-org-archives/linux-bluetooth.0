Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] android/gatt: Remove redundant comment line
Date: Wed, 29 Apr 2015 11:15:51 +0200
Message-Id: <1430298953-31018-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1430298953-31018-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1430298953-31018-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes redundant line from multiple line comment.
---
 android/gatt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index 4da959f..656abfc 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1642,7 +1642,6 @@ reply:
 			/*
 			 * There is no ongoing bonding, lets search for primary
 			 * services
-			 *
 			 */
 			search_dev_for_srvc(conn, NULL);
 	}
-- 
2.1.0

