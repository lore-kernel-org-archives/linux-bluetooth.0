Return-Path: <cyrus@holtmann.org>
From: Antonio Ospite <ospite@studenti.unina.it>
To: linux-bluetooth@vger.kernel.org
Cc: Antonio Ospite <ospite@studenti.unina.it>
Subject: [PATCH BlueZ] Fix batostr(): return the bdaddr in the right order
Date: Wed, 14 Sep 2011 17:46:19 +0200
Message-Id: <1316015179-6474-1-git-send-email-ospite@studenti.unina.it>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

lib/bluetooth.c::batostr() is returning the bdaddr reversed, fix this
and put more arguments on the same line to look more like ba2str().
---
 lib/bluetooth.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/lib/bluetooth.c b/lib/bluetooth.c
index db7bbe1..8509620 100644
--- a/lib/bluetooth.c
+++ b/lib/bluetooth.c
@@ -55,8 +55,7 @@ char *batostr(const bdaddr_t *ba)
 		return NULL;
 
 	sprintf(str, "%2.2X:%2.2X:%2.2X:%2.2X:%2.2X:%2.2X",
-		ba->b[0], ba->b[1], ba->b[2],
-		ba->b[3], ba->b[4], ba->b[5]);
+		ba->b[5], ba->b[4], ba->b[3], ba->b[2], ba->b[1], ba->b[0]);
 
 	return str;
 }
-- 
1.7.5.4

